Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6F4E3D43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiCVLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiCVLLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:11:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D96E2BF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:10:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so21184755edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Lz2UHE6ZvsmlY/56Db1biFIn2sQL3St8e0WLobJ+ys=;
        b=CRZI7bOcLsQ6M4awpT+KCR/3KIe9OtvArHjfqnNyf3oR8VgC0sA+6N6300js1odzKx
         +zR1omXpxLD/Pp6yK9xb9SjVx0vmyDGtxDbjEcSPMqNM0BzPUzpDqKb7esVaCHfmKxVH
         XD0/qucYARGmt0/0q6WPjv8TTAzXG2L8mPYSYnPfQ6VvvnfyxWEYuszlafV2f48DDjUj
         VA0cfQ+wQlwDu6ZfKlHFtrR+yTVt+aN8yzCahLokPHlkXyzKpXIrcLmlLpT3RRsR/9ON
         zK7qpQq//kTQI+qxWE4YftsElsmFHzdJ8GGdzIK7rYgP0ymqS92zs1sE8jfbSJtbvdgE
         NX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0Lz2UHE6ZvsmlY/56Db1biFIn2sQL3St8e0WLobJ+ys=;
        b=kr4q2hgkicAOsGgkohq2F2qJQJFxgQNETNJ1ZF3/xfk5W0wfOJg9/uZzNtGfiWSngI
         QagbU5PFyvGo+ctEYEBhX3ui4c6uX96bfe5goJS+dSR94tNom/LD6t2WfEoZEnAOqmUU
         ejaMKn+PYlptN5/yknXzRSe5h/KorsIWv81s2ttTTdSKrpoqUkXBgfGWqjULq/se5+xN
         XORW4VSB1POYtKsttL3h/vp+yrIaFVYQ6SLiNGgVHNpmhGoKeqNJC5rlfEyOa2g9AU4d
         wdpEizc8/a6fL25iTQCH/5DK8nm6FFSZuviFsjVg7QUlUoHyNOU0OTf+Hv5eXyRRMMhG
         mRYw==
X-Gm-Message-State: AOAM5308/gJa6qT2bYXVGmK7wPI8AP6KyXJIB2muiXy7B7Wtk/LG7zt/
        6yItwrnfP30F1cYyrm3dCiw=
X-Google-Smtp-Source: ABdhPJzauo7jCugyxxy5XRsCnf+vjUrAkcW1Ua/dKSA/DBcvBoHyJvKOomFZE1RijV6pTrOT3LpvNw==
X-Received: by 2002:a05:6402:1909:b0:418:d876:3119 with SMTP id e9-20020a056402190900b00418d8763119mr28451604edz.266.1647947415810;
        Tue, 22 Mar 2022 04:10:15 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id o12-20020a50c90c000000b0041907e62024sm6565020edh.85.2022.03.22.04.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 04:10:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 22 Mar 2022 12:10:13 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL -v2] scheduler updates for v5.18
Message-ID: <YjmulZMqswiXsuki@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjhZUezhnamHAl0H@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-03-22

   # HEAD: ffea9fb319360b9ead8befac6bb2db2b54fd53e6 sched/headers: ARM needs asm/paravirt_api_clock.h too

This second pull request also fixes two regressions that were reported.

Changes in this cycle were:

 - Cleanups for SCHED_DEADLINE
 - Tracing updates/fixes
 - CPU Accounting fixes
 - First wave of changes to optimize the overhead of the scheduler build,
   from the fast-headers tree - including placeholder *_api.h headers for
   later header split-ups.
 - Preempt-dynamic using static_branch() for ARM64
 - Isolation housekeeping mask rework; preperatory for further changes
 - NUMA-balancing: deal with CPU-less nodes
 - NUMA-balancing: tune systems that have multiple LLC cache domains per node (eg. AMD)
 - Updates to RSEQ UAPI in preparation for glibc usage
 - Lots of RSEQ/selftests, for same
 - Add Suren as PSI co-maintainer

 Thanks,

	Ingo

------------------>
Bharata B Rao (1):
      sched/debug: Remove mpol_get/put and task_lock/unlock from sched_show_numa

Chengming Zhou (4):
      sched/cpuacct: Fix charge percpu cpuusage
      sched/cpuacct: Optimize away RCU read lock
      sched/cpuacct: Remove redundant RCU read lock
      cgroup: Fix suspicious rcu_dereference_check() usage warning

Dietmar Eggemann (6):
      sched/deadline: Remove unused def_dl_bandwidth
      sched/deadline: Move bandwidth mgmt and reclaim functions into sched class source file
      sched/deadline: Merge dl_task_can_attach() and dl_cpu_busy()
      sched/deadline: Use __node_2_[pdl|dle]() and rb_first_cached() consistently
      sched/deadline,rt: Remove unused functions for !CONFIG_SMP
      sched/deadline,rt: Remove unused parameter from pick_next_[rt|dl]_entity()

Frederic Weisbecker (9):
      pci: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
      sched/isolation: Use single feature type while referring to housekeeping cpumask
      sched/isolation: Consolidate check for housekeeping minimum service
      sched/isolation: Consolidate error handling
      sched/isolation: Fix housekeeping_mask memory leak
      sched/isolation: Split housekeeping cpumask per isolation features
      sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers

Honglei Wang (1):
      sched/numa: initialize numa statistics when forking new task

Huang Ying (3):
      sched/numa-balancing: Move some document to make it consistent with the code
      sched/numa: Fix NUMA topology for systems with CPU-less nodes
      sched/numa: Avoid migrating task to CPU-less node

Huang, Ying (1):
      sched/numa: Fix boot crash on arm64 systems

Ingo Molnar (17):
      sched/headers: Fix header to build standalone: <linux/sched_clock.h>
      sched/headers: Add header guard to kernel/sched/sched.h
      sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
      sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
      sched/headers: Add initial new headers as identity mappings
      sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
      sched/headers: Make the <linux/sched/deadline.h> header build standalone
      sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
      sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
      sched/headers: Standardize kernel/sched/sched.h header dependencies
      sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
      sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
      sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
      sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
      sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
      sched/headers: Only include <linux/entry-common.h> when CONFIG_GENERIC_ENTRY=y
      headers/prep: Fix header to build standalone: <linux/psi.h>

Johannes Weiner (1):
      MAINTAINERS: add Suren as psi co-maintainer

K Prateek Nayak (1):
      sched/topology: Remove redundant variable and fix incorrect type in build_sched_domains

Mark Rutland (7):
      sched/preempt: Move PREEMPT_DYNAMIC logic later
      sched/preempt: Refactor sched_dynamic_update()
      sched/preempt: Simplify irqentry_exit_cond_resched() callers
      sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
      sched/preempt: Add PREEMPT_DYNAMIC using static keys
      arm64: entry: Centralize preemption decision
      arm64: Support PREEMPT_DYNAMIC

Mathieu Desnoyers (16):
      selftests/rseq: introduce own copy of rseq uapi header
      rseq: Remove broken uapi field layout on 32-bit little endian
      selftests/rseq: Remove useless assignment to cpu variable
      selftests/rseq: Remove volatile from __rseq_abi
      selftests/rseq: Introduce rseq_get_abi() helper
      selftests/rseq: Introduce thread pointer getters
      selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35
      selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit field pointer on big endian
      selftests/rseq: Fix ppc32 missing instruction selection "u" and "x" for load/store
      selftests/rseq: Fix ppc32 offsets by using long rather than off_t
      selftests/rseq: Fix warnings about #if checks of undefined tokens
      selftests/rseq: Remove arm/mips asm goto compiler work-around
      selftests/rseq: Fix: work-around asm goto compiler bugs
      selftests/rseq: x86-64: use %fs segment selector for accessing rseq thread area
      selftests/rseq: x86-32: use %gs segment selector for accessing rseq thread area
      selftests/rseq: Change type of rseq_offset to ptrdiff_t

Mel Gorman (2):
      sched/fair: Improve consistency of allowed NUMA balance calculations
      sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs

Qais Yousef (3):
      sched/core: Export pelt_thermal_tp
      sched/sugov: Ignore 'busy' filter when rq is capped by uclamp_max
      sched/uclamp: Fix iowait boost escaping uclamp restriction

Randy Dunlap (1):
      sched/headers: ARM needs asm/paravirt_api_clock.h too

Suren Baghdasaryan (2):
      psi: Fix "defined but not used" warnings when CONFIG_PROC_FS=n
      psi: Fix "no previous prototype" warnings when CONFIG_CGROUPS=n

Valentin Schneider (3):
      sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
      sched/tracing: Don't re-read p->state when emitting sched_switch event
      sched/tracing: Report TASK_RTLOCK_WAIT tasks as TASK_UNINTERRUPTIBLE

Yury Norov (1):
      sched: replace cpumask_weight with cpumask_empty where appropriate

Zhaoyang Huang (1):
      psi: fix possible trigger missing in the window

Zhen Ni (1):
      sched: move autogroup sysctls into its own file


 Documentation/admin-guide/sysctl/kernel.rst        |  46 +-
 Documentation/scheduler/index.rst                  |   1 +
 Documentation/scheduler/sched-debug.rst            |  54 +++
 MAINTAINERS                                        |   1 +
 arch/Kconfig                                       |  37 +-
 arch/arm/include/asm/paravirt_api_clock.h          |   1 +
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/include/asm/paravirt_api_clock.h        |   1 +
 arch/arm64/include/asm/preempt.h                   |  19 +-
 arch/arm64/kernel/entry-common.c                   |  28 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/include/asm/paravirt_api_clock.h          |   1 +
 arch/x86/include/asm/preempt.h                     |  10 +-
 arch/x86/kernel/cpu/aperfmperf.c                   |   6 +-
 arch/x86/kvm/x86.c                                 |   2 +-
 drivers/base/cpu.c                                 |   2 +-
 drivers/pci/pci-driver.c                           |  21 +-
 include/linux/cgroup.h                             |   5 +-
 include/linux/cgroup_api.h                         |   1 +
 include/linux/cpumask_api.h                        |   1 +
 include/linux/entry-common.h                       |  15 +-
 include/linux/fs_api.h                             |   1 +
 include/linux/gfp_api.h                            |   1 +
 include/linux/hashtable_api.h                      |   1 +
 include/linux/hrtimer_api.h                        |   1 +
 include/linux/kernel.h                             |   7 +-
 include/linux/kobject_api.h                        |   1 +
 include/linux/kref_api.h                           |   1 +
 include/linux/ktime_api.h                          |   1 +
 include/linux/llist_api.h                          |   1 +
 include/linux/lockdep_api.h                        |   1 +
 include/linux/mm_api.h                             |   1 +
 include/linux/mutex_api.h                          |   1 +
 include/linux/perf_event_api.h                     |   1 +
 include/linux/pgtable_api.h                        |   1 +
 include/linux/psi.h                                |   1 +
 include/linux/psi_types.h                          |   3 +
 include/linux/ptrace_api.h                         |   1 +
 include/linux/rcuwait_api.h                        |   1 +
 include/linux/refcount_api.h                       |   1 +
 include/linux/sched.h                              |  29 +-
 include/linux/sched/affinity.h                     |   1 +
 include/linux/sched/cond_resched.h                 |   1 +
 include/linux/sched/deadline.h                     |   2 +
 include/linux/sched/isolation.h                    |  43 +-
 include/linux/sched/posix-timers.h                 |   1 +
 include/linux/sched/rseq_api.h                     |   1 +
 include/linux/sched/sysctl.h                       |   4 -
 include/linux/sched/task_flags.h                   |   1 +
 include/linux/sched/thread_info_api.h              |   1 +
 include/linux/sched/topology.h                     |   1 +
 include/linux/sched_clock.h                        |   2 +
 include/linux/seqlock_api.h                        |   1 +
 include/linux/softirq.h                            |   1 +
 include/linux/spinlock_api.h                       |   1 +
 include/linux/swait_api.h                          |   1 +
 include/linux/syscalls_api.h                       |   1 +
 include/linux/u64_stats_sync_api.h                 |   1 +
 include/linux/wait_api.h                           |   1 +
 include/linux/workqueue_api.h                      |   1 +
 include/trace/events/sched.h                       |  11 +-
 include/uapi/linux/rseq.h                          |  20 +-
 init/Makefile                                      |   3 +-
 kernel/Kconfig.preempt                             |   3 +-
 kernel/cgroup/cpuset.c                             |   6 +-
 kernel/cpu.c                                       |   4 +-
 kernel/entry/common.c                              |  23 +-
 kernel/irq/cpuhotplug.c                            |   4 +-
 kernel/irq/manage.c                                |   4 +-
 kernel/kthread.c                                   |   4 +-
 kernel/rcu/tasks.h                                 |   2 +-
 kernel/rcu/tree_plugin.h                           |   6 +-
 kernel/rseq.c                                      |   8 +-
 kernel/sched/Makefile                              |  28 +-
 kernel/sched/autogroup.c                           |  26 +-
 kernel/sched/autogroup.h                           |   6 +
 kernel/sched/build_policy.c                        |  52 +++
 kernel/sched/build_utility.c                       | 109 +++++
 kernel/sched/clock.c                               |  44 +-
 kernel/sched/completion.c                          |   2 +-
 kernel/sched/core.c                                | 466 +++++++++++++--------
 kernel/sched/core_sched.c                          |   3 -
 kernel/sched/cpuacct.c                             |  12 +-
 kernel/sched/cpudeadline.c                         |   3 +-
 kernel/sched/cpufreq.c                             |   3 -
 kernel/sched/cpufreq_schedutil.c                   |  18 +-
 kernel/sched/cpupri.c                              |   1 -
 kernel/sched/cputime.c                             |   1 -
 kernel/sched/deadline.c                            | 155 +++----
 kernel/sched/debug.c                               |  11 -
 kernel/sched/fair.c                                | 113 +++--
 kernel/sched/idle.c                                |   3 -
 kernel/sched/isolation.c                           | 163 ++++---
 kernel/sched/loadavg.c                             |   1 -
 kernel/sched/membarrier.c                          |   1 -
 kernel/sched/pelt.c                                |   4 -
 kernel/sched/psi.c                                 |  61 ++-
 kernel/sched/rt.c                                  |  51 ++-
 kernel/sched/sched.h                               | 354 ++++++++--------
 kernel/sched/stats.c                               |   1 -
 kernel/sched/stats.h                               |   4 +
 kernel/sched/stop_task.c                           |   1 -
 kernel/sched/swait.c                               |   1 -
 kernel/sched/topology.c                            | 268 ++++++++----
 kernel/sched/wait.c                                |   1 -
 kernel/sched/wait_bit.c                            |   2 +-
 kernel/sysctl.c                                    |  11 -
 kernel/trace/fgraph.c                              |   4 +-
 kernel/trace/ftrace.c                              |   4 +-
 kernel/trace/trace_events.c                        |   8 +-
 kernel/trace/trace_osnoise.c                       |   4 +-
 kernel/trace/trace_sched_switch.c                  |   1 +
 kernel/trace/trace_sched_wakeup.c                  |   1 +
 kernel/watchdog.c                                  |   2 +-
 kernel/workqueue.c                                 |   4 +-
 net/core/net-sysfs.c                               |   6 +-
 scripts/mkcompile_h                                |  17 +-
 tools/testing/selftests/rseq/Makefile              |   2 +-
 .../testing/selftests/rseq/basic_percpu_ops_test.c |   2 +-
 tools/testing/selftests/rseq/compiler.h            |  30 ++
 tools/testing/selftests/rseq/param_test.c          |   8 +-
 tools/testing/selftests/rseq/rseq-abi.h            | 151 +++++++
 tools/testing/selftests/rseq/rseq-arm.h            | 110 ++---
 tools/testing/selftests/rseq/rseq-arm64.h          |  79 +++-
 .../selftests/rseq/rseq-generic-thread-pointer.h   |  25 ++
 tools/testing/selftests/rseq/rseq-mips.h           |  71 +---
 .../selftests/rseq/rseq-ppc-thread-pointer.h       |  30 ++
 tools/testing/selftests/rseq/rseq-ppc.h            | 128 ++++--
 tools/testing/selftests/rseq/rseq-s390.h           |  55 ++-
 tools/testing/selftests/rseq/rseq-skip.h           |   2 +-
 tools/testing/selftests/rseq/rseq-thread-pointer.h |  19 +
 .../selftests/rseq/rseq-x86-thread-pointer.h       |  40 ++
 tools/testing/selftests/rseq/rseq-x86.h            | 200 ++++++---
 tools/testing/selftests/rseq/rseq.c                | 164 ++++----
 tools/testing/selftests/rseq/rseq.h                |  30 +-
 135 files changed, 2345 insertions(+), 1307 deletions(-)
 create mode 100644 Documentation/scheduler/sched-debug.rst
 create mode 100644 arch/arm/include/asm/paravirt_api_clock.h
 create mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
 create mode 100644 arch/x86/include/asm/paravirt_api_clock.h
 create mode 100644 include/linux/cgroup_api.h
 create mode 100644 include/linux/cpumask_api.h
 create mode 100644 include/linux/fs_api.h
 create mode 100644 include/linux/gfp_api.h
 create mode 100644 include/linux/hashtable_api.h
 create mode 100644 include/linux/hrtimer_api.h
 create mode 100644 include/linux/kobject_api.h
 create mode 100644 include/linux/kref_api.h
 create mode 100644 include/linux/ktime_api.h
 create mode 100644 include/linux/llist_api.h
 create mode 100644 include/linux/lockdep_api.h
 create mode 100644 include/linux/mm_api.h
 create mode 100644 include/linux/mutex_api.h
 create mode 100644 include/linux/perf_event_api.h
 create mode 100644 include/linux/pgtable_api.h
 create mode 100644 include/linux/ptrace_api.h
 create mode 100644 include/linux/rcuwait_api.h
 create mode 100644 include/linux/refcount_api.h
 create mode 100644 include/linux/sched/affinity.h
 create mode 100644 include/linux/sched/cond_resched.h
 create mode 100644 include/linux/sched/posix-timers.h
 create mode 100644 include/linux/sched/rseq_api.h
 create mode 100644 include/linux/sched/task_flags.h
 create mode 100644 include/linux/sched/thread_info_api.h
 create mode 100644 include/linux/seqlock_api.h
 create mode 100644 include/linux/softirq.h
 create mode 100644 include/linux/spinlock_api.h
 create mode 100644 include/linux/swait_api.h
 create mode 100644 include/linux/syscalls_api.h
 create mode 100644 include/linux/u64_stats_sync_api.h
 create mode 100644 include/linux/wait_api.h
 create mode 100644 include/linux/workqueue_api.h
 create mode 100644 kernel/sched/build_policy.c
 create mode 100644 kernel/sched/build_utility.c
 create mode 100644 tools/testing/selftests/rseq/compiler.h
 create mode 100644 tools/testing/selftests/rseq/rseq-abi.h
 create mode 100644 tools/testing/selftests/rseq/rseq-generic-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-thread-pointer.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
