Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E344E24B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbiCUKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiCUKzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:55:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33917E15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:54:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id yy13so29010517ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+LtJ7/yQy2deED3gxwKOnsliAuorl/abrNGd99/iXw0=;
        b=io1fWJ/IfPIlbawDZNHQTfMVUBrth3HWxuhis0gLGr6LocSneciQOgDaszCIuymObP
         NEhIVu2ARqRW5zPlHti3Bn9lGNR3muHCB/ANQcJ9+5X6n5Hz/YWR1uhnbA3P2sGhaByQ
         ALjepV+8MKLjF3wv5nqeF2P23x/8cAlJmd9MGOo3lBUYMDkJx+VVLjW+GMdoVEUVQNag
         f8RzMhTzeovve4kTc2q9QqjBVUErs/KeCKy6NkU5Mu07MhitxTY3sGtDS5KC8m/bzQ65
         NVDGKLo0WkXUN5p8ARqwfGW+XTVMeBwrQ4WSrl6QL/BbPOAfKyt0NfuUuGIf37grfk9z
         dwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+LtJ7/yQy2deED3gxwKOnsliAuorl/abrNGd99/iXw0=;
        b=jOnDcjo19vO+eITZVezc8+f+2hswa2azlSo0ya/KYf+jsyq5EIWRrwYN3x5vZ2JjUu
         CZA+M0zxZUu7T9gjRKs7llIZ88amSE/x6nEuqdqpSFBvCm+spTyUKLKaoC4bPun7SgbI
         abnJcoeBo+T5kbYy6zzkeLyqEqqt66cgwVI9RH0UqrPMv4LFuZqaaV5s3yHv1X/tKsHM
         wHGIiIARCrahjOw5mgLwXk5CcuGvREdlPqGmQKFNH4PsLazPeZcoHZU80qqFYRE1zk60
         8Z9UT519kp9EXQHHgfUuDMelqAEJxlABYaFWPpwYyzbE3hB794XebrnJIB40XeKf4Gtn
         dlbA==
X-Gm-Message-State: AOAM531kMbBZDz0MyBjvk9K5R2I+WGIiuHb6cfPFZu51aiHv1Rk77pKq
        21ng1lHabX1CRgtP67U0GbI=
X-Google-Smtp-Source: ABdhPJzD0cp//sINp3CpM5a8/0Va8L7GVCzSfPYGsyTMB7R4PAFJtXW8pL6QYjxRILbjo3GTnKq3hA==
X-Received: by 2002:a17:907:c082:b0:6df:bc66:93f0 with SMTP id st2-20020a170907c08200b006dfbc6693f0mr12831355ejc.190.1647860052127;
        Mon, 21 Mar 2022 03:54:12 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7dd0a000000b00419286d4824sm2512472edv.40.2022.03.21.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:54:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 21 Mar 2022 11:54:09 +0100
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
Subject: [GIT PULL] scheduler updates for v5.18
Message-ID: <YjhZUezhnamHAl0H@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-03-21

   # HEAD: 3387ce4d8a5f2956fab827edf499fe6780e83faa headers/prep: Fix header to build standalone: <linux/psi.h>

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
 134 files changed, 2344 insertions(+), 1307 deletions(-)
 create mode 100644 Documentation/scheduler/sched-debug.rst
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

