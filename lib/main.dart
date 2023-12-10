import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Sample',
      home: MyHomePage(title: 'Flutter Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<int, dynamic> items = new Map();


  Future<void> getData(int index) async {
    var response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/$index',
      ));

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      items[index-1] = jsonResponse;
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i=1; i<10; i++) {
      getData(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Sample'),
      ),
      body: SizedBox(
        child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(children: [
              Text(items[index]["name"].toString().toUpperCase()),
              Image.network(items[index]["sprites"]["front_default"]),
              Text(items[index]["types"][0]["type"]["name"])
              ]),
          );
        },
      ),
      )
    );
  }
}
