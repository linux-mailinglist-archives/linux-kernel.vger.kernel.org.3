Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A455580515
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiGYULy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGYULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C9020F73;
        Mon, 25 Jul 2022 13:11:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 713B76114C;
        Mon, 25 Jul 2022 20:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158A0C341C8;
        Mon, 25 Jul 2022 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779909;
        bh=3DgoIQ2ka7gg3ZlNLS7U8anre4conVYByApEe4IZRtM=;
        h=From:To:Cc:Subject:Date:From;
        b=foIATQWvaDCnonVRM3Fhou78CGaTiOcsySD/3/DCKO/fhMIU4EAADeGTevCat3EKO
         9KYSFtFoDkuZMOGkWwcXgOwgFGI/4UPwogy3BJZvDpxsMmPWQYIDqkStqhES3SKJJE
         eLI88+rQYr+waRyVN8y0eAns+AGaYI57SvMFuLrH7Ksr4dzxGLMEqSFqezi1BzKhuz
         YGLya0a/8q7jRn7q9Zl8NSlCLAGRdZ9gWCW3VNmh7fdsBYL4+TbG4j4ivsA4v0y5ov
         S1QZm9duHKX9UsyNfBWOxPRVseTSRNVMpyB3uAEqdRLbYILeDF5ukPIRGczPet86eI
         XpPwxopHyQACA==
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V7 00/16] The Runtime Verification (RV) interface
Date:   Mon, 25 Jul 2022 22:11:12 +0200
Message-Id: <cover.1658778484.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

  De Oliveira, Daniel Bristot; Cucinotta, Tommaso; De Oliveira, Romulo Silva.
  *Efficient formal verification for the Linux kernel.* In: International
  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
  p. 315-332.

And how efficient is this approach here:

  De Oliveira, Daniel B.; De Oliveira, Romulo S.; Cucinotta, Tommaso. *A thread
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

Given that RV is a tracing consumer, the code is being placed inside the
tracing subsystem (Steven and I have been talking about it for a while).

Features to be added after this patchset:
	- safe_wtd monitor (requires further discussion with watchdog maintainers)
	- Export symbols for external modules
	- dot2bpf
	- Add a reactor that enables the visualization of the visited
	  states via KCOV (Marco Elver & Dmitry Vyukov)
	- Add a CRC method to check from user-space if the values
	  exported by the monitor were not corrupted by any other
	  kernel task (Gabriele Paoloni)

Changes from v6:
	- Remove lock protection when reading static data (Steven)
	- Add lock protection in disable_all_monitors() (Steven)
	- Re-arrange enable_monitor (Steven/Tao)
	- Fix monitor_desc_read_data() Description (Tao)
	- Actually use reactor's count to avoid control usage
	  (Tao)
	- Wait for tracepoint_synchronize_unregister() anytime a monitor
	  is Disabled (daniel)
	- Add memory barriers around monitoring_on and reacting_on (Steven)
	- Make rv reactor name and description const char * (Tao)
	- Append missing _##name for some da_automata functions/variables (Steven)
	- rv_unregister_monitor() will disable the monitor if necessary, and
	  take care of synchronization (Daniel)
	- Fixed da_monitor_instrumentation.rst (Tao)
	- Fix !CONFIG_RV_REACTORS (kbuild test)
	- Moved struct rv/rv.h to linux/rv.h (Daniel)
	- Add rv_ prefix on get/put task slot (Daniel)
Changes from v5:
	- Add task monitor slot checks (Daniel/Tao)
	- Reset the monitors only after initializing the data (Daniel)
	- Add static for static data (Daniel/0-day)
	- Change start/stop *functions to enable/disable (like the user-
	  interface (Daniel)
	- s/init/start/ for the functions starting the monitoring (Daniel)
	- Access monitoring_on and reacting_on via functions (Daniel)
	- Improved vector access checks (Tao)
	- cleanups (Daniel/Tao)
Changes from v4:
	- The watchdog monitor will be discussed on another thread (Daniel)
	- s/safe/final/ in the tracepoint definition (Daniel)
	- Improved error handling at __init functions (Daniel)
	- Remove the hostname from example of commands in a shell (Bagas Sanjaya)
	- Added documentation about automata representation in C/DOT/Formal
	  and this documentation is cited in a comment on all model.h
	  (Steven)
	- Make wwnr a single patch (Daniel/Steven)
	- Add the .dot file for each monitor (Daniel)
	- Add a document for each monitor (Daniel)
	- Add an order for documentation in the index.rst (Daniel)
	- Add wip/wwnr/... long description (Steven/Randy)
	- Add comments for helper functions (Steven)
	- Improve checks in da_monitor.h (Tao Zhou)
	- Change final states set to bool (Tao/Daniel)
	- Adjust indentation on enabling monitor/reactor (Steven)
	- Use strim on buffers from user-space (Steven)
	- Remove ifdefs inside functions (Steven)
	- Adjust depends on RV in Kconfig (Steven)
	- Check empty enabled monitor list (Tao Zhou)
	- Fixed Copyright (Steven)
	- Adjusted structures' indentation (Steven)
	- Fix rv/monitors/$monitor/enabled return value (Song Liu)
	- Typos (Punit Agrawal/Randy)
	- Improved python scripts w.r.t. consistency (Steve)
	- Blamed myself for so many problems :-) (Daniel's mind)
Changes from v3:
	- Rebased on 5.19
	(rostedt's request were made on 1x1 meetings)
	- Moved monitors to monitors/$name/ (Rostedt)
	- Consolidate the tracepoints into a single include file in the default
	  directory (trace/events/rv.h) (Rostedt)
	- The tracepoints now record the entire string to the buffer.
	- Change the enable_monitors to disable monitors with ! (instead of -).
	  (Rostedt)
	- Add a suffix to the state/events enums, to avoid conflict in the
	  vmlinux.h used by eBPF.
	- The models are now placed in the $name.h (it used to store the
	  tracepoints, but they are now consolidated in a single file)
	- dot2c and dot2k updated to the changes
	- models re-generated with these new standards.
	- user-space tools moved to an directory outside of tools/tracing as
	  other methods of verification/log sources are planned.
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




Daniel Bristot de Oliveira (16):
  rv: Add Runtime Verification (RV) interface
  rv: Add runtime reactors interface
  rv/include: Add helper functions for deterministic automata
  rv/include: Add deterministic automata monitor definition via C macros
  rv/include: Add instrumentation helper functions
  Documentation/rv: Add a basic documentation
  tools/rv: Add dot2c
  Documentation/rv: Add deterministic automaton documentation
  tools/rv: Add dot2k
  Documentation/rv: Add deterministic automata monitor synthesis
    documentation
  Documentation/rv: Add deterministic automata instrumentation
    documentation
  rv/monitor: Add the wip monitor skeleton created by dot2k
  rv/monitor: Add the wip monitor
  rv/monitor: Add the wwnr monitor
  rv/reactor: Add the printk reactor
  rv/reactor: Add the panic reactor

 Documentation/trace/index.rst                 |   1 +
 .../trace/rv/da_monitor_instrumentation.rst   | 171 ++++
 .../trace/rv/da_monitor_synthesis.rst         | 147 ++++
 .../trace/rv/deterministic_automata.rst       | 184 ++++
 Documentation/trace/rv/index.rst              |  14 +
 Documentation/trace/rv/monitor_wip.rst        |  55 ++
 Documentation/trace/rv/monitor_wwnr.rst       |  45 +
 .../trace/rv/runtime-verification.rst         | 231 ++++++
 include/linux/rv.h                            |  70 ++
 include/linux/sched.h                         |  11 +
 include/rv/automata.h                         |  75 ++
 include/rv/da_monitor.h                       | 539 ++++++++++++
 include/rv/instrumentation.h                  |  29 +
 include/trace/events/rv.h                     | 142 ++++
 kernel/fork.c                                 |  14 +
 kernel/trace/Kconfig                          |   2 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/rv/Kconfig                       |  78 ++
 kernel/trace/rv/Makefile                      |   8 +
 kernel/trace/rv/monitors/wip/wip.c            |  88 ++
 kernel/trace/rv/monitors/wip/wip.h            |  46 +
 kernel/trace/rv/monitors/wwnr/wwnr.c          |  87 ++
 kernel/trace/rv/monitors/wwnr/wwnr.h          |  46 +
 kernel/trace/rv/reactor_panic.c               |  43 +
 kernel/trace/rv/reactor_printk.c              |  42 +
 kernel/trace/rv/rv.c                          | 784 ++++++++++++++++++
 kernel/trace/rv/rv.h                          |  69 ++
 kernel/trace/rv/rv_reactors.c                 | 506 +++++++++++
 kernel/trace/trace.c                          |   2 +
 kernel/trace/trace.h                          |   9 +
 tools/verification/dot2/Makefile              |  26 +
 tools/verification/dot2/automata.py           | 174 ++++
 tools/verification/dot2/dot2c                 |  26 +
 tools/verification/dot2/dot2c.py              | 254 ++++++
 tools/verification/dot2/dot2k                 |  47 ++
 tools/verification/dot2/dot2k.py              | 177 ++++
 .../dot2/dot2k_templates/main_global.c        |  91 ++
 .../dot2/dot2k_templates/main_per_cpu.c       |  91 ++
 .../dot2/dot2k_templates/main_per_task.c      |  91 ++
 tools/verification/models/wip.dot             |  16 +
 tools/verification/models/wwnr.dot            |  16 +
 41 files changed, 4548 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
 create mode 100644 Documentation/trace/rv/deterministic_automata.rst
 create mode 100644 Documentation/trace/rv/index.rst
 create mode 100644 Documentation/trace/rv/monitor_wip.rst
 create mode 100644 Documentation/trace/rv/monitor_wwnr.rst
 create mode 100644 Documentation/trace/rv/runtime-verification.rst
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/automata.h
 create mode 100644 include/rv/da_monitor.h
 create mode 100644 include/rv/instrumentation.h
 create mode 100644 include/trace/events/rv.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/monitors/wip/wip.c
 create mode 100644 kernel/trace/rv/monitors/wip/wip.h
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.c
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.h
 create mode 100644 kernel/trace/rv/reactor_panic.c
 create mode 100644 kernel/trace/rv/reactor_printk.c
 create mode 100644 kernel/trace/rv/rv.c
 create mode 100644 kernel/trace/rv/rv.h
 create mode 100644 kernel/trace/rv/rv_reactors.c
 create mode 100644 tools/verification/dot2/Makefile
 create mode 100644 tools/verification/dot2/automata.py
 create mode 100644 tools/verification/dot2/dot2c
 create mode 100644 tools/verification/dot2/dot2c.py
 create mode 100644 tools/verification/dot2/dot2k
 create mode 100644 tools/verification/dot2/dot2k.py
 create mode 100644 tools/verification/dot2/dot2k_templates/main_global.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
 create mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c
 create mode 100644 tools/verification/models/wip.dot
 create mode 100644 tools/verification/models/wwnr.dot

-- 
2.35.1

