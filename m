Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3C568EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiGFQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiGFQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:17:55 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69027B09;
        Wed,  6 Jul 2022 09:17:53 -0700 (PDT)
Date:   Thu, 7 Jul 2022 00:18:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657124271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Raaiqvgf/oXa3C5u6t6C+vDHjw8nRdLb6gNkGnKU7k4=;
        b=hYMsEmZD3EwQ8ffLy6H8lZxfQhiJQg33nRXz3KcOfnakjrlhA4tQ1+4YeDcj6OuZP8Jrgz
        Pt8mCDmeP3b0//nxN9ceatyG2fpJgdZpi9BRCDRIXdngyK7+JLCv1B7xNJm/7zp8MWXGVK
        22TodQVeII6PrI6sVyXkaezzByaPBKg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V4 00/20] The Runtime Verification (RV) interface
Message-ID: <YsW18EqSJb/XMLMW@geo.homenetwork>
References: <cover.1655368610.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

After reading things in paper and the previous versions these days slowly
from me, I choose to join the thread this time not because I understand
them clearly. Sorry for not saving your email bandwidth..

On Thu, Jun 16, 2022 at 10:44:42AM +0200, Daniel Bristot de Oliveira wrote:
> Over the last years, I've been exploring the possibility of
> verifying the Linux kernel behavior using Runtime Verification.
> 
> Runtime Verification (RV) is a lightweight (yet rigorous) method that
> complements classical exhaustive verification techniques (such as model
> checking and theorem proving) with a more practical approach for complex
> systems.
> 
> Instead of relying on a fine-grained model of a system (e.g., a
> re-implementation a instruction level), RV works by analyzing the trace of the
> system's actual execution, comparing it against a formal specification of
> the system behavior.
> 
> The usage of deterministic automaton for RV is a well-established
> approach. In the specific case of the Linux kernel, you can check how
> to model complex behavior of the Linux kernel with this paper:
> 
>   DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo Silva.
>   *Efficient formal verification for the Linux kernel.* In: International
>   Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
>   p. 315-332.
> 
> And how efficient is this approach here:
> 
>   DE OLIVEIRA, Daniel B.; DE OLIVEIRA, Romulo S.; CUCINOTTA, Tommaso. *A thread
>   synchronization model for the PREEMPT_RT Linux kernel.* Journal of Systems
>   Architecture, 2020, 107: 101729.
> 
> tlrd: it is possible to model complex behaviors in a modular way, with
> an acceptable overhead (even for production systems). See this
> presentation at 2019's ELCE: https://www.youtube.com/watch?v=BfTuEHafNgg
> 
> Here I am proposing a more practical approach for the usage of deterministic
> automata for runtime verification, and it includes:
> 
> 	- An interface for controlling the verification;
> 	- A tool and set of headers that enables the automatic code
> 	  generation of the RV monitor (Monitor Synthesis);
> 	- Sample monitors to evaluate the interface;
> 	- A sample monitor developed in the context of the Elisa Project
> 	  demonstrating how to use RV in the context of safety-critical
> 	  systems.
> 
> Given that RV is a tracing consumer, the code is being placed inside the
> tracing subsystem (Steven and I have been talking about it for a while).
> 
> Changes from v3:
> 	- Rebased on 5.19
> 	(rostedt's request were made on 1x1 meetings)
> 	- Moved monitors to monitors/$name/ (Rostedt)
> 	- Consolidate the tracepoints into a single include file in the default
> 	  directory (trave/events/rv.h) (Rostedt)

s/trave\(\/events\/rv.h\)/trace\1/

> 	- The tracepoints now record the entire string to the buffer.
> 	- Change the enable_monitors to disable monitors with ! (instead of -).
> 	  (Rostedt)
> 	- Add a suffix to the state/events enums, to avoid conflict in the
> 	  vmlinux.h used by eBPF.
> 	- The models are now placed in the $name.h (it used to store the
> 	  tracepoints, but they are now consolidated in a single file)
> 	- dot2c and dot2k updated to the changes
> 	- models re-generated with these new standards.
> 	- user-space tools moved to an directory outside of tools/tracing as
> 	  other methods of verification/log sources are planned.
> Changes from v2:
> 	- Tons of checkpatch and kernel test robot
> 	- Moved files to better places
> 	- Adjusted watchdog tracepoints patch (Guenter Roeck)
> 	- Added pretimeout watchdog events (Peter Enderborg) 
> 	- Used task struct to store per-task monitors (Peter Zijlstra)
> 	- Changed the instrumentation to use internal definition of tracepoint
> 	  and check the callback signature (Steven Rostedt)
> 	- Used printk_deferred() and removed the comment about deadlocks
> 	  (Shuah Khan/John Ogness)
> 	- Some simplifications:
> 		- Removed the safe watchdog nowayout for now (myself)
> 		- Removed export symbols for now (myself)
> Changes from V1:
> 	- rebased to the latest kernel;
> 	- code cleanup;
> 	- the watchdog dev monitor;
> 	- safety app;
> 
> Things kept for a second moment (after this patchset):
> 	- Add a reactor tha enables the visualization of the visited
> 	  states via KCOV (Marco Elver & Dmitry Vyukov)
> 	- Add a CRC method to check from user-space if the values
> 	  exported by the monitor were not corrupted by any other
> 	  kernel task (Gabriele Paoloni)
> 	- Export symbols for external modules
> 	- dot2bpf
> 
> Daniel Bristot de Oliveira (20):
>   rv: Add Runtime Verification (RV) interface
>   rv: Add runtime reactors interface
>   rv/include: Add helper functions for deterministic automata
>   rv/include: Add deterministic automata monitor definition via C macros
>   rv/include: Add instrumentation helper functions
>   tools/rv: Add dot2c
>   tools/rv: Add dot2k
>   rv/monitor: Add the wip monitor skeleton created by dot2k
>   rv/monitor: wip instrumentation and Makefile/Kconfig entries
>   rv/monitor: Add the wwnr monitor skeleton created by dot2k
>   rv/monitor: wwnr instrumentation and Makefile/Kconfig entries
>   rv/reactor: Add the printk reactor
>   rv/reactor: Add the panic reactor
>   Documentation/rv: Add a basic documentation
>   Documentation/rv: Add deterministic automata monitor synthesis
>     documentation
>   Documentation/rv: Add deterministic automata instrumentation
>     documentation
>   watchdog/dev: Add tracepoints
>   rv/monitor: Add safe watchdog monitor
>   rv/safety_app: Add a safety_app sample
>   Documentation/rv: Add watchdog-monitor documentation
> 
>  Documentation/trace/index.rst                 |   1 +
>  .../trace/rv/da_monitor_instrumentation.rst   | 223 ++++++
>  .../trace/rv/da_monitor_synthesis.rst         | 284 +++++++
>  Documentation/trace/rv/index.rst              |   9 +
>  .../trace/rv/runtime-verification.rst         | 233 ++++++
>  Documentation/trace/rv/watchdog-monitor.rst   | 250 ++++++
>  drivers/watchdog/watchdog_dev.c               |  43 +-
>  drivers/watchdog/watchdog_pretimeout.c        |   2 +
>  include/linux/rv.h                            |  38 +
>  include/linux/sched.h                         |  11 +
>  include/linux/watchdog.h                      |   7 +-
>  include/rv/automata.h                         |  49 ++
>  include/rv/da_monitor.h                       | 419 ++++++++++
>  include/rv/instrumentation.h                  |  23 +
>  include/rv/rv.h                               |  32 +
>  include/trace/events/rv.h                     | 153 ++++
>  include/trace/events/watchdog.h               | 101 +++
>  kernel/fork.c                                 |  14 +
>  kernel/trace/Kconfig                          |   2 +
>  kernel/trace/Makefile                         |   2 +
>  kernel/trace/rv/Kconfig                       |  84 ++
>  kernel/trace/rv/Makefile                      |   9 +
>  kernel/trace/rv/monitors/safe_wtd/safe_wtd.c  | 300 +++++++
>  kernel/trace/rv/monitors/safe_wtd/safe_wtd.h  |  84 ++
>  kernel/trace/rv/monitors/wip/wip.c            | 110 +++
>  kernel/trace/rv/monitors/wip/wip.h            |  38 +
>  kernel/trace/rv/monitors/wwnr/wwnr.c          | 109 +++
>  kernel/trace/rv/monitors/wwnr/wwnr.h          |  38 +
>  kernel/trace/rv/reactor_panic.c               |  44 +
>  kernel/trace/rv/reactor_printk.c              |  43 +
>  kernel/trace/rv/rv.c                          | 757 ++++++++++++++++++
>  kernel/trace/rv/rv.h                          |  54 ++
>  kernel/trace/rv/rv_reactors.c                 | 476 +++++++++++
>  kernel/trace/trace.c                          |   4 +
>  kernel/trace/trace.h                          |   2 +
>  tools/verification/dot2/Makefile              |  26 +
>  tools/verification/dot2/automata.py           | 179 +++++
>  tools/verification/dot2/dot2c                 |  30 +
>  tools/verification/dot2/dot2c.py              | 244 ++++++
>  tools/verification/dot2/dot2k                 |  50 ++
>  tools/verification/dot2/dot2k.py              | 177 ++++
>  .../dot2/dot2k_templates/main_global.c        |  94 +++
>  .../dot2/dot2k_templates/main_per_cpu.c       |  94 +++
>  .../dot2/dot2k_templates/main_per_task.c      |  94 +++
>  tools/verification/safety_app/Makefile        |  51 ++
>  tools/verification/safety_app/safety_app.c    | 614 ++++++++++++++
>  46 files changed, 5691 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst
>  create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst
>  create mode 100644 Documentation/trace/rv/index.rst
>  create mode 100644 Documentation/trace/rv/runtime-verification.rst
>  create mode 100644 Documentation/trace/rv/watchdog-monitor.rst
>  create mode 100644 include/linux/rv.h
>  create mode 100644 include/rv/automata.h
>  create mode 100644 include/rv/da_monitor.h
>  create mode 100644 include/rv/instrumentation.h
>  create mode 100644 include/rv/rv.h
>  create mode 100644 include/trace/events/rv.h
>  create mode 100644 include/trace/events/watchdog.h
>  create mode 100644 kernel/trace/rv/Kconfig
>  create mode 100644 kernel/trace/rv/Makefile
>  create mode 100644 kernel/trace/rv/monitors/safe_wtd/safe_wtd.c
>  create mode 100644 kernel/trace/rv/monitors/safe_wtd/safe_wtd.h
>  create mode 100644 kernel/trace/rv/monitors/wip/wip.c
>  create mode 100644 kernel/trace/rv/monitors/wip/wip.h
>  create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.c
>  create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.h
>  create mode 100644 kernel/trace/rv/reactor_panic.c
>  create mode 100644 kernel/trace/rv/reactor_printk.c
>  create mode 100644 kernel/trace/rv/rv.c
>  create mode 100644 kernel/trace/rv/rv.h
>  create mode 100644 kernel/trace/rv/rv_reactors.c
>  create mode 100644 tools/verification/dot2/Makefile
>  create mode 100644 tools/verification/dot2/automata.py
>  create mode 100644 tools/verification/dot2/dot2c
>  create mode 100644 tools/verification/dot2/dot2c.py
>  create mode 100644 tools/verification/dot2/dot2k
>  create mode 100644 tools/verification/dot2/dot2k.py
>  create mode 100644 tools/verification/dot2/dot2k_templates/main_global.c
>  create mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
>  create mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c
>  create mode 100644 tools/verification/safety_app/Makefile
>  create mode 100644 tools/verification/safety_app/safety_app.c
> 
> -- 
> 2.35.1
> 
