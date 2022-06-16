Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B654DD51
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376327AbiFPIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359805AbiFPIrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:47:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472C15E75A;
        Thu, 16 Jun 2022 01:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C56B0B822B0;
        Thu, 16 Jun 2022 08:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2BAC341CB;
        Thu, 16 Jun 2022 08:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369209;
        bh=bdDAcR0HjZJFIwntvamKxxbeGIgFlMkgAgwD/aNZMUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhE2Z1kxHHmMoI0ytsNbGs77YMejHNJmaQtWeg8xugywbbBIzbfHqyFiQNPBhtObH
         abEEZl3AQ2thYv6cQkW0TnUD9D8Jr/uTalMn2P8Gl8ceipda9naJk48Ed9028lDNqU
         iWjp77uNu8NI6zIsKMsE7/8FfcbGv1LKF0pLv7m4ZFWsrXaaO09pLt3bt3y8zOPPqK
         9mzngcI00N/QEJwYaK/4EdcOANSGxrb+NW4AI/8m2xHnpv7uF8Ocw7ZiarCe+44AsC
         ceu24HWEe6HuDE+298zLQCqd6rrZKqHzOoKFm91cxf9it/pTCjG/Bwtx7U+2cJ+grt
         iGQwmqDrdDokA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 20/20] Documentation/rv: Add watchdog-monitor documentation
Date:   Thu, 16 Jun 2022 10:45:02 +0200
Message-Id: <129a431c1a12610fa7b44f76ce73aa8058f55bc6.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation about the safe_wtd and safe_wtd_nwo RV monitors,
and their usage via a safety application.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/trace/rv/watchdog-monitor.rst | 250 ++++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 Documentation/trace/rv/watchdog-monitor.rst

diff --git a/Documentation/trace/rv/watchdog-monitor.rst b/Documentation/trace/rv/watchdog-monitor.rst
new file mode 100644
index 000000000000..2b142fb31572
--- /dev/null
+++ b/Documentation/trace/rv/watchdog-monitor.rst
@@ -0,0 +1,250 @@
+Watchdog monitor
+----------------
+
+The watchdog is an essential building block for the usage of Linux in
+safety-critical systems because it allows the system to be monitored from
+an external element - the watchdog hardware, acting as a safety-monitor.
+
+A user-space application controls the watchdog device via the watchdog
+interface. This application, hereafter safety_app, enables the watchdog
+and periodically pets the watchdog upon correct completion of the safety
+related processing.
+
+If the safety_app, for any reason, stops pinging the watchdog,
+the watchdog hardware can set the system in a fail-safe state. For
+example, shutting the system down.
+
+Given the importance of the safety_app / watchdog hardware couple,
+the interaction between these software pieces also needs some
+sort of monitoring. In other words, "who monitors the monitor?"
+
+The safe watchdog (safe_wtd) RV monitor monitors the interaction between
+the safety_app and the watchdog device, enforcing the correct sequence of
+events that leads the system to a safe state.
+
+Furthermore, the safety_app can monitor the RV monitor by collecting the
+events generated by the RV monitor itself via tracing interface. In this way,
+closing the monitoring loop with the safety_app.
+
+A diagram of the components and their interactions is::
+
+  user-space:
+                  +--------------------------------+
+                  | safety_app                     |-----------+
+                  +--------------------------------+           |
+                     |                    ^                    |
+                     | Configure          | Enable and         |
+                     |                    | check data         |
+  ===================+====================+===============     |
+  kernel-space:      |                    |                    |
+                     v                    v                    |
+                +----------+  instr.     +-------------+       |
+                | watchdog | ----------->| RV Monitor  |----+  |
+                | device   |             +-------------+    |  |
+                +----------+                                |  |
+                  |                                         |  |
+                  |                                         |  |
+  ================+======================================   |  |
+  hardware:       |                                         |  |
+                  v                                         |  +-> Bring the system
+                +--------------------+                      +----> to a safe state,
+                | watchdog hardware  |---------------------------> e.g., halt.
+                +--------------------+
+
+Sample safety_app
+-----------------
+
+The user-space safety_app sample code in ``tools/verification/safety_app/``
+serves to illustrate the usage of the RV monitors for this use-case, as
+well as the starting point to the development of a user-specific safety_app.
+
+Watchdog events
+---------------
+
+The RV monitor observes the watchdog by using instrumentation to
+process the events generated by the interaction between the
+safety_app and the watchdog device layer in kernel.
+
+The monitored events are:
+
+  - watchdog:watchdog_open: open the watchdog device;
+  - watchdog:watchdog_close: close the watchdog device;
+  - watchdog:watchdog_start: start the watchdog;
+  - watchdog:watchdog_stop: stop the watchdog;
+  - watchdog:watchdog_set_timeout: set the watchdog timeout;
+  - watchdog:watchdog_ping: reprogram the watchdog with the previously set
+    timeout;
+  - watchdog:watchdog_nowayout: prevents the watchdog from stopping;
+  - watchdog:watchdog_set_keep_alive: set an intermediary ping to overcome
+    the limitation of a hardware watchdog maximum timeout being shorter than
+    the timeout set by the user-space tool;
+  - watchdog:watchdog_keep_alive: the execution of the function that runs the
+    intermediary keep alive ping;
+
+RV monitor events
+-----------------
+
+The RV monitor monitors the relevant events as an outside observer,
+interpreting all the components (the hardware; the watchdog device
+interface; and the safety monitor) as an integrated component.
+
+The events selected for the monitor are:
+
+  - other_threads: an event generated by any thread other than the
+    one that set nowayout or open the watchdog the last time.
+  - open: a thread opens the watchdog to manipulate it;
+  - close: a thread closes the watchdog;
+  - start: starts the watchdog countdown;
+  - stop: stops the watchdog;
+  - set_safe_timeout: configures the watchdog with a given timeout;
+  - ping: resets the watchdog countdown with the previously configured timeout;
+  - nowayout: prevents the watchdog to be stopped until the system's shutdown;
+  - sched_keep_alive: schedules a kernel worker to ping the watchdog if the
+    timeout is longer than the watchdog hardware can handle.
+  - keep_alive: executes the previously scheduled watchdog ping;
+
+Noting that the events that does not appear in the automata models are
+considered blocked events, and their execution will always cause the
+RV monitor to react to an unexpected event.
+
+RV monitor specification
+------------------------
+
+The monitor's goal is to assess a set of specifications that conducts the
+system to a safe state.
+
+These specifications are:
+
+  - 1: Once open, only one process manipulates the watchdog;
+  - 2: Following 1, the keep-alive mechanisms will not be used;
+  - 3: If required, nowayout will be set before opening the watchdog;
+  - 4: A safe timeout must be set;
+  - 5: At least one ping must be made before entering the safe/safe_nwo states
+  - 6: The RV monitor does not react if the watchdog is closed without stopping.
+       But the hardware watchdog is expected to react.
+
+Deterministic automata monitors
+-------------------------------
+
+Following the specifications, a deterministic automata monitor
+was developed. The monitor is modeled as Deterministic Automata model.
+
+The deterministic automata model for safe_wtd is::
+
+              #==================================#   other_threads
+              H                                  H ----------------+
+ -----------> H               init               H                 |
+              H                                  H <---------------+
+              #==================================#
+                      |     |     ^
+                      |     |     |               close
+                      |     |     +----------------------------------------------------+
+                      |     |                                                          |
+                      |     |                     open                                 |
+                      |     +------------------------------------------------------+   |
+                      |                                                            |   |
+                      |  nowayout                                                  |   |
+                      v                                                            |   |
+    nowayout        +-------------------+                                          |   |
+    other_threads   |                   |          nowayout                        |   |
+  +---------------- |        nwo        |<-------------------------------------+   |   |
+  |                 |                   |                                      |   |   |
+  +---------------> |                   | <+                                   |   |   |
+                    +-------------------+  |                                   |   |   |
+                      |                    |                                   |   |   |
+                      | open               | close                             |   |   |
+                      v                    |                                   |   |   |
+                    +-------------------+  |                                   |   |   |
+                    |    opened_nwo     | -+                                   |   |   |
+                    +-------------------+                                      |   |   |
+                      |                                                        |   |   |
+                      | start                                                  |   |   |
+                      v                                                        |   |   |
+                    +-------------------+                                      |   |   |
+  +---------------> |    started_nwo    | -+                                   |   |   |
+  |                 +-------------------+  |                                   |   |   |
+  |                   |                    |                                   |   |   |
+  | open              | set_safe_timeout   |                                   |   |   |
+  |                   v                    |                                   |   |   |
+  |                 +-------------------+  |                                   |   |   |
+  |                 |      set_nwo      |  |                                   |   |   |
+  |                 +-------------------+  |                                   |   |   |
+  |                           |            |                                   |   |   |
+  |     +-------------+       | ping       |                                   |   |   |
+  |     |             |       |            |                                   |   |   |
+  |     | ping        v       v            |                                   |   |   |
+  |     |           +-------------------+  |                                   |   |   |
+  |     +-----------|     safe_nwo      |  |                                   |   |   |
+  |                 +-------------------+  |                                   |   |   |
+  |                   |                    |                                   |   |   |
+  |                   | close              | close                             |   |   |
+  |                   v                    v                                   |   |   |
+  |                 +----------------------------------+   nowayout            |   |   |
+  |                 |                                  |   other_threads       |   |   |
+  |                 |        closed_running_nwo        | ----------------+     |   |   |
+  |                 |                                  |                 |     |   |   |
+  +---------------- |                                  | <---------------+     |   |   |
+                    +----------------------------------+                       |   |   |
+                        |        nowayout             ^                        |   |   |
+                        +-----------------------------+                        |   |   |
+                                                                               |   |   |
+                                                                               |   |   |
+                               +-------------------+           +--------+      |   |   |
+                               |                   |           |        |------+---+   |
+                               |      started      |  start    | opened |      |       |
+             +---------------- |                   | <-------- |        |>-----+-------+
+             |                 +-------------------+           +--------+      |       ^
+             |                   |                                             |       |
+             |                   | set_safe_timeout              +-------------+-------+
+             |                   v                               |             |
+             |                 +-------------------+             |             |
+             |                 |                   |             |             |
+             |                 |        set        |             |             |
+  +----------+---------------> |                   |             |             |
+  |          |                 +-------------------+             |             |
+  |          |                   |                               |             |
+  |          |                   | ping                          |             |
+  |          |                   v                               |             |
+  |          |                 +-------------------+   ping      |             |
+  |          |                 |                   | -------+    |             |
+  |          |           +---- |       safe        |        |    |             |
+  |          |           |     |                   | <------+    |             |
+  |          |           |     +-------------------+             |             |
+  |          |           |       |                               |             |
+  |          | stop      |       | stop                          |             |
+  |          |           |       v                               |             |
+  |          |           |     +-------------------+   close     |             |
+  |          +-----------+---> |      stopped      |-------------+             |
+  |                      |     +-------------------+                           |
+  |                      +---+                                                 |
+  |                          | close                                           |
+  |                          v                                                 |
+  |     other_threads  +----------------------------------------+              |
+  |   +--------------> |                                        |              |
+  |   |                |             closed_running             |              |
+  |   +--------------- |                                        |--------------+
+  |                    +----------------------------------------+
+  |                               |          ^
+  |                         open  |          | close
+  |                               v          |
+  |    set_safe_timeout       +-------------------+
+  +-------------------------> |     reopened      |
+                                +-------------------+
+
+It is important to note that the events sched_keep_alive and keep_alive
+are not allowed in the monitor (they are said to be blocked events).
+The execution of any blocked events leads the RV monitor to react.
+
+Additional options
+------------------
+
+The RV monitor also has a set of options enabled via kernel command
+line/module options. They are:
+
+ - watchdog_id: the device id to monitor (default 0);
+ - dont_stop: once enabled, do not allow the RV monitor to be stopped (default off);
+ - safe_timeout: define a maximum safe value that a user-space application can
+   set as the watchdog timeout (default unlimited);
+ - check_timeout: After every ping, check if the time left in the watchdog is less
+   than or equal to the last timeout set for the watchdog. It only works for watchdog
+   devices that provide the get_timeleft() function (default off);
-- 
2.35.1

