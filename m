Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC4D964C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbiCOIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbiCOIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDAA4C789;
        Tue, 15 Mar 2022 01:31:02 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DHVq1YHkfJoVsK90xYQ2UwNfoUa68x0OL2jO2JNLf4o=;
        b=3rZKXVZ3rA4UXJgdqZ083nCkSxg9YXqxPYsTfdk7tVI6rQzGJtLNuysr74ApHvBT9Slg7F
        qhsdYNkz7DbUY2fLW1Qd9BPQRb/ZKfrkD2m+kGhClftqUcXAOvs9cJioFd60Gpbqt5S1nH
        zPFiL6CrsDk6kobELpsdwLGtprqz9aDzLpG/gN+QT/npCq37pYdbuRifhgn9A714DNXd3Q
        ZkucYmdsKUwiDEnKEBkRQOYoCN9BECBJu98Ob4MIts/mtY/Qijh8ZlDlA4EqlJW311+qF0
        P97WtYvflyksK2I7H89nQ4SNrcoHEw9xH1Iyl4ts3IY0MtZj473ounbDrt5CnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DHVq1YHkfJoVsK90xYQ2UwNfoUa68x0OL2jO2JNLf4o=;
        b=hWeTToEgX5Cpr78xsPIn/KPy3akgX3lUw1n/Z9MXB5DnJrW7tutzv/SbVJ7U14YhKPwGty
        jkQvwFqMBdW9pbBw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Introduce
 kernel/sched/build_utility.c and build multiple .c files there
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306005.16921.3541059674681362392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     801c141955108fb7cf1244dda76e6de8b16fd3ae
Gitweb:        https://git.kernel.org/tip/801c141955108fb7cf1244dda76e6de8b16fd3ae
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 13:23:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there

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
 kernel/sched/Makefile            | 25 ++++-------
 kernel/sched/autogroup.c         |  3 +-
 kernel/sched/build_utility.c     | 70 +++++++++++++++++++++++++++++++-
 kernel/sched/clock.c             |  2 +-
 kernel/sched/completion.c        |  2 +-
 kernel/sched/core_sched.c        |  3 +-
 kernel/sched/cpuacct.c           |  3 +-
 kernel/sched/cpufreq.c           |  3 +-
 kernel/sched/cpufreq_schedutil.c |  7 +---
 kernel/sched/cpupri.c            |  1 +-
 kernel/sched/debug.c             |  1 +-
 kernel/sched/isolation.c         |  1 +-
 kernel/sched/loadavg.c           |  1 +-
 kernel/sched/membarrier.c        |  1 +-
 kernel/sched/psi.c               | 15 +-------
 kernel/sched/sched.h             | 57 ++++++++++++++++++++++++-
 kernel/sched/stats.c             |  1 +-
 kernel/sched/stop_task.c         |  1 +-
 kernel/sched/swait.c             |  1 +-
 kernel/sched/topology.c          |  1 +-
 kernel/sched/wait.c              |  1 +-
 kernel/sched/wait_bit.c          |  2 +-
 22 files changed, 139 insertions(+), 63 deletions(-)
 create mode 100644 kernel/sched/build_utility.c

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c0c5202..4a4785c 100644
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
index 31dd259..16092b4 100644
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
index 0000000..31216ce
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
index 540d0e5..d9272d9 100644
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
index a778554..35f15c2 100644
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
index c8746a9..38a2cec 100644
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
index 3d06c5e..2c505cf 100644
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
index 7c2fe50..5252fb1 100644
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
index 6d65ab6..f68885d 100644
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
index d583f2a..fa9ce9d 100644
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
index 102d6f7..bb3d63b 100644
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
index b4d1081..373d42c 100644
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
index 954b229..52c8f82 100644
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
index 3d28254..0c5be7e 100644
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
index 8fb08a1..a4fa3aa 100644
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
index eab4a18..79c7a8a 100644
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
index 07dde29..857f837 100644
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
index 0b165a2..d04073a 100644
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
index e1c655f..76b9b79 100644
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
index 32841c6..e8af72f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2,7 +2,6 @@
 /*
  * Scheduler topology setup/handling methods
  */
-#include "sched.h"
 
 DEFINE_MUTEX(sched_domains_mutex);
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index eca3810..9860bb9 100644
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
index 02ce292..d4788f8 100644
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
