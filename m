Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA954B4E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiBNL3D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351412AbiBNL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:28:20 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA56C2DCA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:06:02 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-_7XVMO5INWiMjIMJzHYuqg-1; Mon, 14 Feb 2022 05:45:57 -0500
X-MC-Unique: _7XVMO5INWiMjIMJzHYuqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2E7E1091DA1;
        Mon, 14 Feb 2022 10:45:54 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B42427BDF;
        Mon, 14 Feb 2022 10:45:27 +0000 (UTC)
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
        linux-trace-devel@vger.kernel.org
Subject: [RFC V2 00/21] The Runtime Verification (RV) interface
Date:   Mon, 14 Feb 2022 11:44:51 +0100
Message-Id: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over the last years, I've been exploring the possibility of
verifying the Linux kernel behavior using Runtime Verification.

Runtime Verification (RV) is a lightweight (yet rigorous) method that
complements classical exhaustive verification techniques (such as model
checking and theorem proving) with a more practical approach for complex
systems.

Instead of relying on a fine-grained model of a system (e.g., a
re-implementation a instruction level), RV works by analyzing the trace of the
system's actual execution, comparing it against a formal specification of
the system behavior.

The usage of deterministic automaton for RV is a well-established
approach. In the specific case of the Linux kernel, you can check how
to model complex behavior of the Linux kernel with this paper:

  DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo Silva.
  *Efficient formal verification for the Linux kernel.* In: International
  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
  p. 315-332.

And how efficient is this approach here:

  DE OLIVEIRA, Daniel B.; DE OLIVEIRA, Romulo S.; CUCINOTTA, Tommaso. *A thread
  synchronization model for the PREEMPT_RT Linux kernel.* Journal of Systems
  Architecture, 2020, 107: 101729.

tlrd: it is possible to model complex behaviors in a modular way, with
an acceptable overhead (even for production systems). See this
presentation at 2019's ELCE: https://www.youtube.com/watch?v=BfTuEHafNgg

Here I am proposing a more practical approach for the usage of deterministic
automata for runtime verification, and it includes:

	- An interface for controlling the verification;
	- A tool and set of headers that enables the automatic code
	  generation of the RV monitor (Monitor Synthesis);
	- Sample monitors to evaluate the interface;
	- A sample monitor developed in the context of the Elisa Project
	  demonstrating how to use RV in the context of safety-critical
	  systems.

Given that RV is a tracing consumer, the code is being placed inside the
tracing subsystem (Steven and I have been talking about it for a while).

The changes since V1 includes:
	- rebased to the latest kernel;
	- code cleanup;
	- the watchdog dev monitor;
	- safety app;

The TODO list still includes:
	- Make per-task monitor use the task struct to store the
	  per monitor state (Suggested by peterz)
	- Add a reactor tha enables the visualization of the visited
	  states via KCOV (Marco Elver & Dmitry Vyukov)
	- Add a CRC method to check from user-space if the values
	  exported by the monitor were not corrupted by any other
	  kernel task (Gabriele Paoloni)

I am sending the V2 with some TODOs because I need
some feedback on the interface/files placement inside the kernel,
so I can adjust all the patches accordingly. Also, to make it possible
for people in the Elisa Project to evaluate the safety_app approach.

Daniel Bristot de Oliveira (21):
  rv: Add Runtime Verification (RV) interface
  rv: Add runtime reactors interface
  rv/include: Add helper functions for deterministic automata
  rv/include: Add deterministic automata monitor definition via C macros
  rv/include: Add tracing helper functions
  tools/rv: Add dot2c
  tools/rv: Add dot2k
  rv/monitor: Add the wip monitor skeleton created by dot2k
  rv/monitor: wip instrumentation and Makefile/Kconfig entries
  rv/monitor: Add the wwnr monitor skeleton created by dot2k
  rv/monitor: wwnr instrumentation and Makefile/Kconfig entries
  rv/reactor: Add the printk reactor
  rv/reactor: Add the panic reactor
  Documentation/rv: Add a basic documentation
  Documentation/rv: Add deterministic automata monitor synthesis
    documentation
  Documentation/rv: Add deterministic automata instrumentation
    documentation
  watchdog/dev: Add tracepoints
  rv/monitor: Add safe watchdog monitor
  rv/monitor: Add safe watchdog nowayout monitor
  rv/safety_app: Add an safety_app sample
  Documentation/rv: Add watchdog-monitor documentation

 Documentation/trace/index.rst                 |   1 +
 .../trace/rv/da_monitor_instrumentation.rst   | 230 ++++++
 .../trace/rv/da_monitor_synthesis.rst         | 286 +++++++
 Documentation/trace/rv/index.rst              |   9 +
 .../trace/rv/runtime-verification.rst         | 233 ++++++
 Documentation/trace/rv/watchdog-monitor.rst   | 307 ++++++++
 drivers/watchdog/watchdog_dev.c               |  41 +-
 include/linux/rv.h                            |  31 +
 include/linux/watchdog.h                      |   7 +-
 include/rv/automata.h                         |  52 ++
 include/rv/da_monitor.h                       | 398 ++++++++++
 include/rv/trace_helpers.h                    |  69 ++
 include/trace/events/watchdog.h               | 103 +++
 kernel/trace/Kconfig                          |   2 +
 kernel/trace/Makefile                         |   2 +
 kernel/trace/rv/Kconfig                       |  78 ++
 kernel/trace/rv/Makefile                      |  10 +
 kernel/trace/rv/monitor_safe_wtd/model.h      |  84 +++
 kernel/trace/rv/monitor_safe_wtd/safe_wtd.c   | 322 ++++++++
 kernel/trace/rv/monitor_safe_wtd/safe_wtd.h   |  64 ++
 kernel/trace/rv/monitor_safe_wtd_nwo/model.h  |  61 ++
 .../rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c    | 309 ++++++++
 .../rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h    |  64 ++
 kernel/trace/rv/monitor_wip/model.h           |  38 +
 kernel/trace/rv/monitor_wip/wip.c             | 124 +++
 kernel/trace/rv/monitor_wip/wip.h             |  64 ++
 kernel/trace/rv/monitor_wwnr/model.h          |  38 +
 kernel/trace/rv/monitor_wwnr/wwnr.c           | 122 +++
 kernel/trace/rv/monitor_wwnr/wwnr.h           |  70 ++
 kernel/trace/rv/reactor_panic.c               |  44 ++
 kernel/trace/rv/reactor_printk.c              |  43 ++
 kernel/trace/rv/rv.c                          | 700 +++++++++++++++++
 kernel/trace/rv/rv.h                          |  50 ++
 kernel/trace/rv/rv_reactors.c                 | 478 ++++++++++++
 kernel/trace/trace.c                          |   4 +
 kernel/trace/trace.h                          |   2 +
 tools/tracing/rv/dot2/Makefile                |  26 +
 tools/tracing/rv/dot2/automata.py             | 179 +++++
 tools/tracing/rv/dot2/dot2c                   |  30 +
 tools/tracing/rv/dot2/dot2c.py                | 240 ++++++
 tools/tracing/rv/dot2/dot2k                   |  46 ++
 tools/tracing/rv/dot2/dot2k.py                | 184 +++++
 .../rv/dot2/dot2k_templates/main_global.c     |  96 +++
 .../rv/dot2/dot2k_templates/main_global.h     |  64 ++
 .../rv/dot2/dot2k_templates/main_per_cpu.c    |  96 +++
 .../rv/dot2/dot2k_templates/main_per_cpu.h    |  64 ++
 .../rv/dot2/dot2k_templates/main_per_task.c   |  96 +++
 .../rv/dot2/dot2k_templates/main_per_task.h   |  70 ++
 tools/tracing/rv/safety_app/Makefile          |  51 ++
 tools/tracing/rv/safety_app/safety_app.c      | 713 ++++++++++++++++++
 50 files changed, 6486 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/index.rst
 create mode 100644 Documentation/trace/rv/runtime-verification.rst
 create mode 100644 Documentation/trace/rv/watchdog-monitor.rst
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/automata.h
 create mode 100644 include/rv/da_monitor.h
 create mode 100644 include/rv/trace_helpers.h
 create mode 100644 include/trace/events/watchdog.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/monitor_safe_wtd/model.h
 create mode 100644 kernel/trace/rv/monitor_safe_wtd/safe_wtd.c
 create mode 100644 kernel/trace/rv/monitor_safe_wtd/safe_wtd.h
 create mode 100644 kernel/trace/rv/monitor_safe_wtd_nwo/model.h
 create mode 100644 kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c
 create mode 100644 kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h
 create mode 100644 kernel/trace/rv/monitor_wip/model.h
 create mode 100644 kernel/trace/rv/monitor_wip/wip.c
 create mode 100644 kernel/trace/rv/monitor_wip/wip.h
 create mode 100644 kernel/trace/rv/monitor_wwnr/model.h
 create mode 100644 kernel/trace/rv/monitor_wwnr/wwnr.c
 create mode 100644 kernel/trace/rv/monitor_wwnr/wwnr.h
 create mode 100644 kernel/trace/rv/reactor_panic.c
 create mode 100644 kernel/trace/rv/reactor_printk.c
 create mode 100644 kernel/trace/rv/rv.c
 create mode 100644 kernel/trace/rv/rv.h
 create mode 100644 kernel/trace/rv/rv_reactors.c
 create mode 100644 tools/tracing/rv/dot2/Makefile
 create mode 100644 tools/tracing/rv/dot2/automata.py
 create mode 100644 tools/tracing/rv/dot2/dot2c
 create mode 100644 tools/tracing/rv/dot2/dot2c.py
 create mode 100644 tools/tracing/rv/dot2/dot2k
 create mode 100644 tools/tracing/rv/dot2/dot2k.py
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_global.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_cpu.h
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/tracing/rv/dot2/dot2k_templates/main_per_task.h
 create mode 100644 tools/tracing/rv/safety_app/Makefile
 create mode 100644 tools/tracing/rv/safety_app/safety_app.c

-- 
2.33.1

