Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B4F51C4B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381671AbiEEQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiEEQLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C425C363;
        Thu,  5 May 2022 09:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8DCBB82DF2;
        Thu,  5 May 2022 16:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC19C385A4;
        Thu,  5 May 2022 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766840;
        bh=ZoySQFMuCXYihBFhKAzzBX3l7fodRNeWMI02GDfbZQw=;
        h=From:To:Cc:Subject:Date:From;
        b=K3riGR+bMXMgjRKxY4Oo55cEBqmqh8DssLcnM44PbokWHE4FEUC6cYNR51UunBe35
         tZaTcPmZ1QkzG1bl7bkW/5MGuUlKpJZTgFvps2WHWV8/mNhPPnek4QXYDn0VuxYYzZ
         gpLTnqSCXn3FDj3ptspoWSMc2ukDcOFG8Df1n98TCKqzq1wIp7WvvXAW1xQKjR8354
         KrD7MUOMMOIfQAjfODPzLmcRoqCuv9i0Z3kbqtvVBMGFIS+B8o3s9P6s+YbR3skyLC
         SSWKtiu8QEnN2i+8Gzjnw2oucom/ogJ4SgsvRtm6Mf2TF7BPQB5a2JRy3d73+paqK+
         +9vI90EgIysXA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
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
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 00/20] The Runtime Verification (RV) interface
Date:   Thu,  5 May 2022 18:06:40 +0200
Message-Id: <cover.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Changes from v2:
	- Tons of checkpatch and kernel test robot
	- Moved files to better places
	- Adjusted watchdog tracepoints patch (Guenter Roeck)
	- Added pretimeout watchdog events (Peter Enderborg) 
	- Used task struct to store per-task monitors (Peter Zijlstra)
	- Changed the instrumentation to use internal definition of tracepoint
	  and check the callback signature (Steven Rostedt)
	- Used printk_deferred() and removed the comment about deadlocks
	  (Shuah Khan/John Ogness)
	- Some simplifications:
		- Removed the safe watchdog nowayout for now (myself)
		- Removed export symbols for now (myself)
Changes from V1:
	- rebased to the latest kernel;
	- code cleanup;
	- the watchdog dev monitor;
	- safety app;

Things kept for a second moment (after this patchset):
	- Add a reactor tha enables the visualization of the visited
	  states via KCOV (Marco Elver & Dmitry Vyukov)
	- Add a CRC method to check from user-space if the values
	  exported by the monitor were not corrupted by any other
	  kernel task (Gabriele Paoloni)
	- Export symbols for external modules
Daniel Bristot de Oliveira (20):
  rv: Add Runtime Verification (RV) interface
  rv: Add runtime reactors interface
  rv/include: Add helper functions for deterministic automata
  rv/include: Add deterministic automata monitor definition via C macros
  rv/include: Add instrumentation helper functions
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
  rv/safety_app: Add an safety_app sample
  Documentation/rv: Add watchdog-monitor documentation

 Documentation/trace/index.rst                 |   1 +
 .../trace/rv/da_monitor_instrumentation.rst   | 223 ++++++
 .../trace/rv/da_monitor_synthesis.rst         | 286 +++++++
 Documentation/trace/rv/index.rst              |   9 +
 .../trace/rv/runtime-verification.rst         | 233 ++++++
 Documentation/trace/rv/watchdog-monitor.rst   | 250 ++++++
 drivers/watchdog/watchdog_dev.c               |  43 +-
 drivers/watchdog/watchdog_pretimeout.c        |   2 +
 include/linux/rv.h                            |  36 +
 include/linux/sched.h                         |  11 +
 include/linux/watchdog.h                      |   7 +-
 include/rv/automata.h                         |  49 ++
 include/rv/da_monitor.h                       | 421 ++++++++++
 include/rv/instrumentation.h                  |  23 +
 include/rv/rv.h                               |  32 +
 include/trace/events/watchdog.h               | 101 +++
 kernel/fork.c                                 |  14 +
 kernel/trace/Kconfig                          |   2 +
 kernel/trace/Makefile                         |   2 +
 kernel/trace/rv/Kconfig                       |  68 ++
 kernel/trace/rv/Makefile                      |   9 +
 kernel/trace/rv/monitor_safe_wtd/model.h      |  84 ++
 kernel/trace/rv/monitor_safe_wtd/safe_wtd.c   | 302 +++++++
 kernel/trace/rv/monitor_safe_wtd/safe_wtd.h   |  64 ++
 kernel/trace/rv/monitor_wip/model.h           |  38 +
 kernel/trace/rv/monitor_wip/wip.c             | 112 +++
 kernel/trace/rv/monitor_wip/wip.h             |  64 ++
 kernel/trace/rv/monitor_wwnr/model.h          |  38 +
 kernel/trace/rv/monitor_wwnr/wwnr.c           | 110 +++
 kernel/trace/rv/monitor_wwnr/wwnr.h           |  70 ++
 kernel/trace/rv/reactor_panic.c               |  44 +
 kernel/trace/rv/reactor_printk.c              |  43 +
 kernel/trace/rv/rv.c                          | 752 ++++++++++++++++++
 kernel/trace/rv/rv.h                          |  54 ++
 kernel/trace/trace.c                          |   4 +
 kernel/trace/trace.h                          |   2 +
 tools/tracing/rv/dot2/Makefile                |  26 +
 tools/tracing/rv/dot2/automata.py             | 179 +++++
 tools/tracing/rv/dot2/dot2c                   |  30 +
 tools/tracing/rv/dot2/dot2c.py                | 240 ++++++
 tools/tracing/rv/dot2/dot2k                   |  46 ++
 tools/tracing/rv/dot2/dot2k.py                | 188 +++++
 .../rv/dot2/dot2k_templates/main_global.c     |  97 +++
 .../rv/dot2/dot2k_templates/main_global.h     |  64 ++
 .../rv/dot2/dot2k_templates/main_per_cpu.c    |  97 +++
 .../rv/dot2/dot2k_templates/main_per_cpu.h    |  64 ++
 .../rv/dot2/dot2k_templates/main_per_task.c   |  97 +++
 .../rv/dot2/dot2k_templates/main_per_task.h   |  70 ++
 tools/tracing/rv/safety_app/Makefile          |  51 ++
 tools/tracing/rv/safety_app/safety_app.c      | 645 +++++++++++++++
 50 files changed, 5487 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/index.rst
 create mode 100644 Documentation/trace/rv/runtime-verification.rst
 create mode 100644 Documentation/trace/rv/watchdog-monitor.rst
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/automata.h
 create mode 100644 include/rv/da_monitor.h
 create mode 100644 include/rv/instrumentation.h
 create mode 100644 include/rv/rv.h
 create mode 100644 include/trace/events/watchdog.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/monitor_safe_wtd/model.h
 create mode 100644 kernel/trace/rv/monitor_safe_wtd/safe_wtd.c
 create mode 100644 kernel/trace/rv/monitor_safe_wtd/safe_wtd.h
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
2.35.1

