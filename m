Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35F4D9640
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbiCOIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbiCOIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B324C415;
        Tue, 15 Mar 2022 01:30:55 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mu73k6T0eRhzXNXG6ZNwBHwmn6Hf3dOvK/yDq4DQ9lE=;
        b=2kkIzX9jvASGxMn1TIhFiegpT1Jm1ztm4RA3NAIuCJb5fpqX/15+MoSWkfeFuhLuQ+sV7m
        5Mebs5o+4K185ijT21OcYTw1OaWwB6QIPpEKM5FVOd08K/oT1mwmGqShBkOL+uEyAnHq+y
        5FHfiCT9Qbpl5HdcxuctWqoVHRpkwtjCNimc02mTeBBmwfrVc31a7z2Rt5AlMqhk2zwHIS
        +FblvuSiw5iFzrLWRbnr6cV0/1DWPJFRmg2ZN6OJPri3m9TJIPF9bMvhOC0dTPc99H2eed
        2dfqYYN3ymM/RWMs3OfxemLkjMZ9lfsCmTTn0ujLuQ3lZsudxfPuT0xLjOJyGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mu73k6T0eRhzXNXG6ZNwBHwmn6Hf3dOvK/yDq4DQ9lE=;
        b=I9ZbCh8wnBozXZhwrxRT+NXtt4uc0h0jMsHTkzuzE1/M5mW9MFWb3B7nqk0aHirD7KSvlG
        ZcWanYiG75HADFCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Reorganize, clean up and optimize
 kernel/sched/sched.h dependencies
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305217.16921.16969063947874969598.tip-bot2@tip-bot2>
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

Commit-ID:     4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
Gitweb:        https://git.kernel.org/tip/4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 14:51:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:34 +01:00

sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies

Remove all headers, except the ones required to make this header
build standalone.

Also include stats.h in sched.h explicitly - dependencies already
require this.

Summary of the build speedup gained through the last ~15 scheduler build &
header dependency patches:

Cumulative scheduler (kernel/sched/) build time speedup on a
Linux distribution's config, which enables all scheduler features,
compared to the vanilla kernel:

  _____________________________________________________________________________
 |
 |  Vanilla kernel (v5.13-rc7):
 |_____________________________________________________________________________
 |
 |  Performance counter stats for 'make -j96 kernel/sched/' (3 runs):
 |
 |   126,975,564,374      instructions              #    1.45  insn per cycle           ( +-  0.00% )
 |    87,637,847,671      cycles                    #    3.959 GHz                      ( +-  0.30% )
 |         22,136.96 msec cpu-clock                 #    7.499 CPUs utilized            ( +-  0.29% )
 |
 |            2.9520 +- 0.0169 seconds time elapsed  ( +-  0.57% )
 |_____________________________________________________________________________
 |
 |  Patched kernel:
 |_____________________________________________________________________________
 |
 | Performance counter stats for 'make -j96 kernel/sched/' (3 runs):
 |
 |    50,420,496,914      instructions              #    1.47  insn per cycle           ( +-  0.00% )
 |    34,234,322,038      cycles                    #    3.946 GHz                      ( +-  0.31% )
 |          8,675.81 msec cpu-clock                 #    3.053 CPUs utilized            ( +-  0.45% )
 |
 |            2.8420 +- 0.0181 seconds time elapsed  ( +-  0.64% )
 |_____________________________________________________________________________

Summary:

  - CPU time used to build the scheduler dropped by -60.9%, a reduction
    from 22.1 clock-seconds to 8.7 clock-seconds.

  - Wall-clock time to build the scheduler dropped by -3.9%, a reduction
    from 2.95 seconds to 2.84 seconds.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/build_policy.c  |   4 +-
 kernel/sched/build_utility.c |   6 +-
 kernel/sched/sched.h         | 147 ++++++++++------------------------
 kernel/sched/stats.h         |   2 +-
 4 files changed, 46 insertions(+), 113 deletions(-)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index a2e4023..e0104b4 100644
--- a/kernel/sched/build_policy.c
+++ b/kernel/sched/build_policy.c
@@ -28,10 +28,6 @@
 #include <linux/tsacct_kern.h>
 #include <linux/vtime.h>
 
-#ifdef CONFIG_PARAVIRT
-# include <asm/paravirt.h>
-#endif
-
 #include <uapi/linux/sched/types.h>
 
 #include "sched.h"
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index bc2f4d6..eec0849 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -44,13 +44,11 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 
-#ifdef CONFIG_PARAVIRT
-# include <asm/paravirt.h>
-#endif
-
 #include <uapi/linux/prctl.h>
 #include <uapi/linux/sched/types.h>
 
+#include <asm/switch_to.h>
+
 #include "sched.h"
 #include "sched-pelt.h"
 #include "stats.h"
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f255ec2..0d42179 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,158 +5,97 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
-#include <linux/sched.h>
-#include <linux/cpumask.h>
-#include <linux/ktime_api.h>
-#include <linux/cgroup_api.h>
-#include <linux/topology.h>
-#include <linux/prctl.h>
-#include <linux/ptrace_api.h>
-#include <linux/gfp_api.h>
-#include <linux/posix-timers.h>
-#include <linux/sched/clock.h>
-#include <linux/workqueue_api.h>
-#include <linux/tick.h>
-#include <linux/ktime_api.h>
-#include <linux/swait_api.h>
-#include <linux/hashtable_api.h>
-#include <linux/cpufreq.h>
-#include <linux/utsname.h>
-
-#include <asm/irq_regs.h>
-
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
-#include <linux/sched/clock.h>
-#include <linux/sched/coredump.h>
 #include <linux/sched/cpufreq.h>
-#include <linux/sched/cputime.h>
 #include <linux/sched/deadline.h>
-#include <linux/sched/debug.h>
-#include <linux/sched/hotplug.h>
-#include <linux/sched/idle.h>
-#include <linux/sched/init.h>
-#include <linux/sched/isolation.h>
-#include <linux/sched/jobctl.h>
+#include <linux/sched.h>
 #include <linux/sched/loadavg.h>
 #include <linux/sched/mm.h>
-#include <linux/sched/nohz.h>
-#include <linux/sched/numa_balancing.h>
-#include <linux/sched/prio.h>
 #include <linux/sched/rseq_api.h>
-#include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/smt.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/task_flags.h>
 #include <linux/sched/task.h>
-#include <linux/sched/task_stack.h>
-#include <linux/sched/thread_info_api.h>
 #include <linux/sched/topology.h>
-#include <linux/sched/user.h>
-#include <linux/sched/wake_q.h>
-#include <linux/sched/xacct.h>
-
-#include <uapi/linux/sched/types.h>
-
-#include <linux/binfmts.h>
-#include <linux/bitops.h>
-#include <linux/compat.h>
-#include <linux/context_tracking.h>
-#include <linux/cpufreq.h>
-#include <linux/cpuidle.h>
-#include <linux/cpuset.h>
-#include <linux/ctype.h>
-#include <linux/debugfs.h>
-#include <linux/delayacct.h>
-#include <linux/energy_model.h>
-#include <linux/init_task.h>
-#include <linux/kprobes.h>
-#include <linux/kthread.h>
-#include <linux/membarrier.h>
-#include <linux/migrate.h>
-#include <linux/mmu_context.h>
-#include <linux/nmi.h>
-#include <linux/proc_fs.h>
-#include <linux/prefetch.h>
-#include <linux/profile.h>
-#include <linux/psi.h>
-#include <linux/ratelimit.h>
-#include <linux/rcupdate_wait.h>
-#include <linux/security.h>
-#include <linux/stop_machine.h>
-#include <linux/suspend.h>
-#include <linux/swait.h>
-#include <linux/syscalls.h>
-#include <linux/task_work.h>
-#include <linux/tsacct_kern.h>
-#include <linux/hrtimer_api.h>
-
-#ifdef CONFIG_PARAVIRT
-# include <asm/paravirt.h>
-#endif
-
-#include <trace/events/sched.h>
-
-#ifdef CONFIG_CGROUP_SCHED
-#include <linux/cgroup.h>
-#include <linux/psi.h>
-#endif
-
-#ifdef CONFIG_SCHED_DEBUG
-# include <linux/static_key.h>
-#endif
-
-#include "cpupri.h"
-#include "cpudeadline.h"
-
-#ifdef CONFIG_SCHED_DEBUG
-# define SCHED_WARN_ON(x)	WARN_ONCE(x, #x)
-#else
-# define SCHED_WARN_ON(x)	({ (void)(x), 0; })
-#endif
 
+#include <linux/atomic.h>
 #include <linux/bitmap.h>
+#include <linux/bug.h>
 #include <linux/capability.h>
+#include <linux/cgroup_api.h>
 #include <linux/cgroup.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
+#include <linux/fs_api.h>
 #include <linux/hrtimer_api.h>
 #include <linux/interrupt.h>
+#include <linux/irq_work.h>
 #include <linux/jiffies.h>
 #include <linux/kref_api.h>
+#include <linux/kthread.h>
 #include <linux/ktime_api.h>
 #include <linux/lockdep_api.h>
+#include <linux/lockdep.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex_api.h>
+#include <linux/plist.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
+#include <linux/profile.h>
 #include <linux/psi.h>
-#include <linux/sched/affinity.h>
-#include <linux/sched.h>
-#include <linux/sched/loadavg.h>
-#include <linux/sched/mm.h>
-#include <linux/sched/rseq_api.h>
-#include <linux/sched/signal.h>
+#include <linux/rcupdate.h>
 #include <linux/seq_file.h>
 #include <linux/seqlock.h>
 #include <linux/softirq.h>
 #include <linux/spinlock_api.h>
+#include <linux/static_key.h>
+#include <linux/stop_machine.h>
 #include <linux/syscalls_api.h>
 #include <linux/syscalls.h>
+#include <linux/tick.h>
 #include <linux/topology.h>
 #include <linux/types.h>
 #include <linux/u64_stats_sync_api.h>
 #include <linux/uaccess.h>
 #include <linux/wait_api.h>
+#include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
 
 #include <trace/events/power.h>
+#include <trace/events/sched.h>
 
 #include "../workqueue_internal.h"
 
+#ifdef CONFIG_CGROUP_SCHED
+#include <linux/cgroup.h>
+#include <linux/psi.h>
+#endif
+
+#ifdef CONFIG_SCHED_DEBUG
+# include <linux/static_key.h>
+#endif
+
+#ifdef CONFIG_PARAVIRT
+# include <asm/paravirt.h>
+# include <asm/paravirt_api_clock.h>
+#endif
+
+#include "cpupri.h"
+#include "cpudeadline.h"
+
+#ifdef CONFIG_SCHED_DEBUG
+# define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
+#else
+# define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
+#endif
+
 struct rq;
 struct cpuidle_state;
 
@@ -1925,6 +1864,8 @@ extern void flush_smp_call_function_from_idle(void);
 static inline void flush_smp_call_function_from_idle(void) { }
 #endif
 
+#include "stats.h"
+
 #if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
 
 extern void __sched_core_account_forceidle(struct rq *rq);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index a0df79e..baa839c 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,8 +2,6 @@
 #ifndef _KERNEL_STATS_H
 #define _KERNEL_STATS_H
 
-#include "sched.h"
-
 #ifdef CONFIG_SCHEDSTATS
 
 extern struct static_key_false sched_schedstats;
