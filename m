Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC94B4E31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351064AbiBNLYJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:24:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350936AbiBNLXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:23:51 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4376613FA6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:59:10 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-UNO-Taq1O52MDZbamgUMuA-1; Mon, 14 Feb 2022 05:48:25 -0500
X-MC-Unique: UNO-Taq1O52MDZbamgUMuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 346211091DA0;
        Mon, 14 Feb 2022 10:48:23 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2F4527BDF;
        Mon, 14 Feb 2022 10:48:18 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
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
        linux-trace-devel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC V2 21/21] Documentation/rv: Add watchdog-monitor documentation
Date:   Mon, 14 Feb 2022 11:45:12 +0100
Message-Id: <347942775f8c2b6badd9796d1fd75f574dd0ce95.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 Documentation/trace/rv/watchdog-monitor.rst | 307 ++++++++++++++++++++
 1 file changed, 307 insertions(+)
 create mode 100644 Documentation/trace/rv/watchdog-monitor.rst

diff --git a/Documentation/trace/rv/watchdog-monitor.rst b/Documentation/trace/rv/watchdog-monitor.rst
new file mode 100644
index 000000000000..98d5bdd0ed85
--- /dev/null
+++ b/Documentation/trace/rv/watchdog-monitor.rst
@@ -0,0 +1,307 @@
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
+The user-space safety_app sample code in ``tools/tracing/rv/safety_app/``
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
+  - 6: The The RV monitor does not react if the watchdog is closed without stopping.
+       But the hardware watchdog is expected to react.
+
+Deterministic automata monitors
+-------------------------------
+
+Following the specifications, two deterministic automata monitors
+were developed. The are the safe_wtd and the safe_wtd_nwo monitors.
+The monitors are modeled as Deterministic Automata models.
+
+The difference between the safe_wtd and the safe_wtd_nwo is that
+the latter enforces the usage of the watchdog's nowayout option
+to reach the safe state.
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
+The deterministic automata model for safe_wtd_nwo is::
+
+                             |
+                             |
+                             v
+                    #===================#
+                    H       init        H
+                    #===================#
+                             |
+                             | nowayout
+                             v
+    nowayout        +-------------------+
+    other_threads   |                   |
+  +---------------- |        nwo        |
+  |                 |                   |
+  +---------------> |                   | <---+
+                    +-------------------+     |
+                             |                |
+                             | open           | close
+                             v                |
+                    +-------------------+     |
+                    |      opened       | ----+
+                    +-------------------+
+                             |
+                             | start
+                             v
+                    +-------------------+
+  +---------------> |      started      | ---+
+  |                 +-------------------+    |
+  |                   |                      |
+  | open              | set_safe_timeout     |
+  |                   v                      |
+  |                 +-------------------+    |
+  |                 |        set        |    |
+  |                 +-------------------+    |
+  |                          |               |
+  |       +------------+     | ping          |
+  |       |            v     v               |
+  |       | ping    +-------------------+    |
+  |       +---------|       safe        |    |
+  |                 +-------------------+    |
+  |                          |               |
+  |                          | close         | close
+  |                          v               |
+  |                 +-------------------+    |
+  +---------------- |  closed_running   | <--+
+                    +-------------------+
+                      ^               |
+                      | nowayout      |
+                      | other_threads |
+                      +---------------+
+
+It is important to note that the events sched_keep_alive and keep_alive
+are not allowed on any of the present monitors (they are said to be blocked
+events). The execution of any blocked events leads the RV monitor to react.
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
2.33.1

