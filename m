Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76E4D969F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiCOIpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbiCOIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2681D4D254
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so5450064wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bIT+MO6Wzh71jbnQvGmvD9o987UoAOQlI8zhc6bmOc=;
        b=bOdSmN8V1vL/uYZkouDicXadfeYRX7jkJWfYiGfSGCtVtJDonEkiosHCifVKqC0Ze7
         63aryfIcLou4fy0ZLTo5sYnud25NnwGpQnjArKOyHzF0jF7JzOHmpwyrPe+Wy9kD5hTb
         eEANS2bDrfWIKlcOGRlp+5b/MHOFHW/hYQQtKtJZusU7whqID5dxZstJqh7yN0k3MDff
         a7NykqDEzBMilO96NDsPPZf8iQASQG9JOINscETIPzVPDiESz6zXdae9h/FKTGwNzzbH
         lOKYyTkKRviLm8W6cOLOqfK/qF83cdF2pQtAjzDE1KJ3Zr5QwTr4VYPWb97/fiV774FI
         UJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5bIT+MO6Wzh71jbnQvGmvD9o987UoAOQlI8zhc6bmOc=;
        b=gS53TG63jLD+zKDKIDJM6/IlxXzfN155oaezOD0VpTh0Rg6GUuRRIQ70LzbN+oXpD+
         wgh7WZ3haJeV7jm/ErOIc2x3zo0FAzKXCVTccKmSH/zwnJAH8nuMalsyiYcI47+iXyzk
         xo/TsSCLLDeQ01+2aztz24AEgLFgrNx+xuJJtlYXHJ3OlizMUgSY87tj8aJdvJFs46iq
         4lzMY86aWswzsNY7w9ayk0BFPuIOHWOVhc05lBuGr0QP7CdykFIVNnnc5OLSrdHWFl4h
         NQLoDbcUylxPOWM4AN7VZpRYoYUC/QnUD/jHlJ7+DKB6Bv0QocgiBR6iQ8xGLZK++vCE
         hmTg==
X-Gm-Message-State: AOAM530P0ytSsxOL4hq3LHHR//YB60PsAiTag9zLd5aI/qJSfKQuYP2m
        kGGL21ooXXtrn28CCRSCFVqgzO1VlMQ=
X-Google-Smtp-Source: ABdhPJyJEm5iM15aA4Tv8N5vA/kppxkJfIzaasyyZncHMwW52CYJLXJBG4kfS8bhLrH19qMHzGn+Jg==
X-Received: by 2002:a05:6000:1786:b0:1f0:4c5f:63ba with SMTP id e6-20020a056000178600b001f04c5f63bamr19085158wrg.377.1647333837359;
        Tue, 15 Mar 2022 01:43:57 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/15] sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
Date:   Tue, 15 Mar 2022 09:42:40 +0100
Message-Id: <20220315084247.40783-9-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220315084247.40783-1-mingo@kernel.org>
References: <20220315084247.40783-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Collect all utility functionality source code files into a single kernel/sched/build_utility.c file,
via #include-ing the .c files:

    kernel/sched/clock.c
    kernel/sched/completion.c
    kernel/sched/loadavg.c
    kernel/sched/swait.c
    kernel/sched/wait_bit.c
    kernel/sched/wait.c

CONFIG_CPU_FREQ:
    kernel/sched/cpufreq.c

CONFIG_CPU_FREQ_GOV_SCHEDUTIL:
    kernel/sched/cpufreq_schedutil.c

CONFIG_CGROUP_CPUACCT:
    kernel/sched/cpuacct.c

CONFIG_SCHED_DEBUG:
    kernel/sched/debug.c

CONFIG_SCHEDSTATS:
    kernel/sched/stats.c

CONFIG_SMP:
   kernel/sched/cpupri.c
   kernel/sched/stop_task.c
   kernel/sched/topology.c

CONFIG_SCHED_CORE:
   kernel/sched/core_sched.c

CONFIG_PSI:
   kernel/sched/psi.c

CONFIG_MEMBARRIER:
   kernel/sched/membarrier.c

CONFIG_CPU_ISOLATION:
   kernel/sched/isolation.c

CONFIG_SCHED_AUTOGROUP:
   kernel/sched/autogroup.c

The goal is to amortize the 60+ KLOC header bloat from over a dozen build units into
a single build unit.

The build time of build_utility.c also roughly matches the build time of core.c and
fair.c - allowing better load-balancing of scheduler-only rebuilds.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/Makefile            | 25 +++++++++-------------
 kernel/sched/autogroup.c         |  3 +--
 kernel/sched/build_utility.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/clock.c             |  2 --
 kernel/sched/completion.c        |  2 +-
 kernel/sched/core_sched.c        |  3 ---
 kernel/sched/cpuacct.c           |  3 +--
 kernel/sched/cpufreq.c           |  3 ---
 kernel/sched/cpufreq_schedutil.c |  7 ------
 kernel/sched/cpupri.c            |  1 -
 kernel/sched/debug.c             |  1 -
 kernel/sched/isolation.c         |  1 -
 kernel/sched/loadavg.c           |  1 -
 kernel/sched/membarrier.c        |  1 -
 kernel/sched/psi.c               | 15 -------------
 kernel/sched/sched.h             | 57 +++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/stats.c             |  1 -
 kernel/sched/stop_task.c         |  1 -
 kernel/sched/swait.c             |  1 -
 kernel/sched/topology.c          |  1 -
 kernel/sched/wait.c              |  1 -
 kernel/sched/wait_bit.c          |  2 +-
 22 files changed, 139 insertions(+), 63 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c0c52026ad0d..4a4785cb3cd2 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -22,18 +22,13 @@ ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
-obj-y += core.o loadavg.o clock.o cputime.o
-obj-y += idle.o fair.o rt.o deadline.o
-obj-y += wait.o wait_bit.o swait.o completion.o
-
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
-obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
-obj-$(CONFIG_SCHEDSTATS) += stats.o
-obj-$(CONFIG_SCHED_DEBUG) += debug.o
-obj-$(CONFIG_CGROUP_CPUACCT) += cpuacct.o
-obj-$(CONFIG_CPU_FREQ) += cpufreq.o
-obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
-obj-$(CONFIG_MEMBARRIER) += membarrier.o
-obj-$(CONFIG_CPU_ISOLATION) += isolation.o
-obj-$(CONFIG_PSI) += psi.o
-obj-$(CONFIG_SCHED_CORE) += core_sched.o
+#
+# Build efficiency:
+#
+# These compilation units have roughly the same size and complexity - so their
+# build parallelizes well and finishes roughly at once:
+#
+obj-y += core.o
+obj-y += fair.o
+obj-y += build_utility.o
+obj-y += idle.o rt.o deadline.o cputime.o cpudeadline.o pelt.o
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 31dd2593145e..16092b49ff6a 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+
 /*
  * Auto-group scheduling implementation:
  */
-#include <linux/nospec.h>
-#include "sched.h"
 
 unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
new file mode 100644
index 000000000000..31216ce0b4b3
--- /dev/null
+++ b/kernel/sched/build_utility.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * These are various utility functions of the scheduler,
+ * built in a single compilation unit for build efficiency reasons.
+ *
+ * ( Incidentally, the size of the compilation unit is roughly
+ *   comparable to core.c, fair.c, smp.c and policy.c, the other
+ *   big compilation units. This helps balance build time, while
+ *   coalescing source files to amortize header inclusion
+ *   cost. )
+ */
+
+#include "sched.h"
+#include "sched-pelt.h"
+
+#include <linux/sched_clock.h>
+
+#include "clock.c"
+
+#ifdef CONFIG_CGROUP_CPUACCT
+# include "cpuacct.c"
+#endif
+
+#ifdef CONFIG_CPU_FREQ
+# include "cpufreq.c"
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+# include "cpufreq_schedutil.c"
+#endif
+
+#ifdef CONFIG_SCHED_DEBUG
+# include "debug.c"
+#endif
+
+#ifdef CONFIG_SCHEDSTATS
+# include "stats.c"
+#endif
+
+#include "loadavg.c"
+#include "completion.c"
+#include "swait.c"
+#include "wait_bit.c"
+#include "wait.c"
+
+#ifdef CONFIG_SMP
+# include "cpupri.c"
+# include "stop_task.c"
+# include "topology.c"
+#endif
+
+#ifdef CONFIG_SCHED_CORE
+# include "core_sched.c"
+#endif
+
+#ifdef CONFIG_PSI
+# include "psi.c"
+#endif
+
+#ifdef CONFIG_MEMBARRIER
+# include "membarrier.c"
+#endif
+
+#ifdef CONFIG_CPU_ISOLATION
+# include "isolation.c"
+#endif
+
+#ifdef CONFIG_SCHED_AUTOGROUP
+# include "autogroup.c"
+#endif
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 540d0e50e31c..d9272d9061a3 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -53,8 +53,6 @@
  * that is otherwise invisible (TSC gets stopped).
  *
  */
-#include "sched.h"
-#include <linux/sched_clock.h>
 
 /*
  * Scheduler clock - returns current time in nanosec units.
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index a778554f9dad..35f15c26ed54 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+
 /*
  * Generic wait-for-completion handler;
  *
@@ -11,7 +12,6 @@
  * typically be used for exclusion which gives rise to priority inversion.
  * Waiting for completion is a typically sync point, but not an exclusion point.
  */
-#include "sched.h"
 
 /**
  * complete: - signals a single thread waiting on this completion
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index c8746a9a7ada..38a2cec21014 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <linux/prctl.h>
-#include "sched.h"
-
 /*
  * A simple wrapper around refcount. An allocated sched_core_cookie's
  * address is used to compute the cookie of the task.
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3d06c5e4220d..2c505cf800aa 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+
 /*
  * CPU accounting code for task groups.
  *
  * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
  * (balbir@in.ibm.com).
  */
-#include <asm/irq_regs.h>
-#include "sched.h"
 
 /* Time spent by the tasks of the CPU accounting group executing in ... */
 enum cpuacct_stat_index {
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 7c2fe50fd76d..5252fb191fae 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -5,9 +5,6 @@
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
-#include <linux/cpufreq.h>
-
-#include "sched.h"
 
 DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 6d65ab6e484e..f68885d049f2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -6,13 +6,6 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include "sched.h"
-
-#include <linux/sched/cpufreq.h>
-#include <trace/events/power.h>
-
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 struct sugov_tunables {
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index d583f2aa744e..fa9ce9d83683 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -22,7 +22,6 @@
  *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
-#include "sched.h"
 
 /*
  * p->rt_priority   p->prio   newpri   cpupri
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 102d6f70e84d..bb3d63bdf4ae 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -6,7 +6,6 @@
  *
  * Copyright(C) 2007, Red Hat, Inc., Ingo Molnar
  */
-#include "sched.h"
 
 /*
  * This allows printing both to /proc/sched_debug and
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b4d10815c45a..373d42c707bc 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2017-2018 SUSE, Frederic Weisbecker
  *
  */
-#include "sched.h"
 
 enum hk_flags {
 	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 954b229868d9..52c8f8226b0d 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -6,7 +6,6 @@
  * figure. Its a silly number but people think its important. We go through
  * great pains to make it work on big machines and tickless kernels.
  */
-#include "sched.h"
 
 /*
  * Global load-average calculations
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 3d2825408e3a..0c5be7ebb1dc 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -4,7 +4,6 @@
  *
  * membarrier system call
  */
-#include "sched.h"
 
 /*
  * For documentation purposes, here are some membarrier ordering
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8fb08a12f602..a4fa3aadfcba 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -137,21 +137,6 @@
  * sampling of the aggregate task states would be.
  */
 
-#include "../workqueue_internal.h"
-#include <linux/sched/loadavg.h>
-#include <linux/seq_file.h>
-#include <linux/proc_fs.h>
-#include <linux/seqlock.h>
-#include <linux/uaccess.h>
-#include <linux/cgroup.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/ctype.h>
-#include <linux/file.h>
-#include <linux/poll.h>
-#include <linux/psi.h>
-#include "sched.h"
-
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eab4a18f71c2..79c7a8a2be65 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -6,7 +6,25 @@
 #define _KERNEL_SCHED_SCHED_H
 
 #include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/ktime_api.h>
+#include <linux/cgroup_api.h>
+#include <linux/topology.h>
+#include <linux/prctl.h>
+#include <linux/ptrace_api.h>
+#include <linux/gfp_api.h>
+#include <linux/sched/clock.h>
+#include <linux/workqueue_api.h>
+#include <linux/tick.h>
+#include <linux/ktime_api.h>
+#include <linux/swait_api.h>
+#include <linux/hashtable_api.h>
+#include <linux/cpufreq.h>
+#include <linux/utsname.h>
 
+#include <asm/irq_regs.h>
+
+#include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/coredump.h>
@@ -24,6 +42,7 @@
 #include <linux/sched/nohz.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/prio.h>
+#include <linux/sched/rseq_api.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/smt.h>
@@ -31,6 +50,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/thread_info_api.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/user.h>
 #include <linux/sched/wake_q.h>
@@ -69,8 +89,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/tsacct_kern.h>
-
-#include <asm/tlb.h>
+#include <linux/hrtimer_api.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -87,6 +106,40 @@
 # define SCHED_WARN_ON(x)	({ (void)(x), 0; })
 #endif
 
+#include <linux/bitmap.h>
+#include <linux/capability.h>
+#include <linux/cgroup.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask_api.h>
+#include <linux/ctype.h>
+#include <linux/file.h>
+#include <linux/jiffies.h>
+#include <linux/kref_api.h>
+#include <linux/lockdep_api.h>
+#include <linux/module.h>
+#include <linux/mutex_api.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/psi.h>
+#include <linux/sched/affinity.h>
+#include <linux/sched.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/rseq_api.h>
+#include <linux/seq_file.h>
+#include <linux/seqlock.h>
+#include <linux/syscalls_api.h>
+#include <linux/syscalls.h>
+#include <linux/topology.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/wait_api.h>
+#include <linux/workqueue_api.h>
+
+#include <trace/events/power.h>
+
+#include "../workqueue_internal.h"
+
 struct rq;
 struct cpuidle_state;
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 07dde2928c79..857f837f52cb 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -2,7 +2,6 @@
 /*
  * /proc/schedstat implementation
  */
-#include "sched.h"
 
 void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
 			       struct sched_statistics *stats)
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 0b165a25f22f..d04073a93eb4 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -7,7 +7,6 @@
  *
  * See kernel/stop_machine.c
  */
-#include "sched.h"
 
 #ifdef CONFIG_SMP
 static int
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e1c655f928c7..76b9b796e695 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -2,7 +2,6 @@
 /*
  * <linux/swait.h> (simple wait queues ) implementation:
  */
-#include "sched.h"
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 32841c6741d1..e8af72fd70bd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2,7 +2,6 @@
 /*
  * Scheduler topology setup/handling methods
  */
-#include "sched.h"
 
 DEFINE_MUTEX(sched_domains_mutex);
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index eca38107b32f..9860bb9a847c 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -4,7 +4,6 @@
  *
  * (C) 2004 Nadia Yvette Chambers, Oracle
  */
-#include "sched.h"
 
 void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *key)
 {
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 02ce292b9bc0..d4788f810b55 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
 /*
  * The implementation of the wait_bit*() and related waiting APIs:
  */
-#include "sched.h"
 
 #define WAIT_TABLE_BITS 8
 #define WAIT_TABLE_SIZE (1 << WAIT_TABLE_BITS)
-- 
2.32.0

