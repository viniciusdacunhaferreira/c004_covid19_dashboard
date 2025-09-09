import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A type representing the various available data points
enum DataPoint {
  casesTotal('Total Cases', 'assets/count.png', Color(0xFFFFF492)),
  casesActive('Active Cases', 'assets/fever.png', Color(0xFFE99600)),
  deaths('Deaths', 'assets/death.png', Color(0xFFE40000)),
  recovered('Recovered', 'assets/patient.png', Color(0xFF70A901));

  const DataPoint(this.name, this.assetPath, this.color);
  final String name;
  final String assetPath;
  final Color color;
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('COVID-19 Tracker'),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          // Use Center as layout has unconstrained width (loose constraints),
          // together with SizedBox to specify the max width (tight constraints)
          // See this thread for more info:
          // https://twitter.com/biz84/status/1445400059894542337
          child: Center(
            child: SizedBox(
              width: 500, // max allowed width
              child: Dashboard(),
            ),
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Some random values
    final values = [
      9231249,
      123214,
      51245,
      7452340,
    ];
    return ListView(
      children: [
        for (final dataPoint in DataPoint.values)
          DataPointCard(
            endpoint: dataPoint,
            value: values[dataPoint.index],
          ),
      ],
    );
  }
}

class DataPointCard extends StatelessWidget {
  const DataPointCard({super.key, required this.endpoint, required this.value});
  final DataPoint endpoint;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                endpoint.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: endpoint.color),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    endpoint.assetPath,
                    color: endpoint.color,
                    height: 48,
                  ),
                  Text(
                    NumberFormat('#,###,###,###').format(value),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: endpoint.color,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
