import 'dart:async';

import 'package:flutter/material.dart';

import '../components/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stopwatch _stopwatch = Stopwatch();
  final List<String> labTimes = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  String formatDuration(Duration d) {
    return '${d.inMinutes.toString().padLeft(2, '0')}:'
        '${(d.inSeconds % 60).toString().padLeft(2, '0')}:'
        '${((d.inMilliseconds % 1000) ~/ 10).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    formatDuration(_stopwatch.elapsed),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 70,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    text: _stopwatch.isRunning ? "Stop" : "Start",
                    onPressed: () {
                      setState(() {
                        if (_stopwatch.isRunning) {
                          _stopwatch.stop();
                        } else {
                          _stopwatch.start();
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Button(
                    text: "Lap Time",
                    onPressed: () {
                      if (_stopwatch.isRunning) {
                        setState(() {
                          labTimes.insert(
                              0,
                              "Lab ${labTimes.length + 1}: " +
                                  formatDuration(_stopwatch.elapsed));
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Button(
                    text: "Reset",
                    onPressed: () {
                      setState(() {
                        _stopwatch.reset();
                        labTimes.clear();
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children:
                      labTimes.map((time) => Labtime(text: time)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class Labtime extends StatelessWidget {
  final String text;

  Labtime({required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
