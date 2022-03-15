Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4E04D969A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbiCOIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346184AbiCOIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:45:43 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0674D625
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1047779wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtIgN6AdT+17GwfQORoopmuViWKlchoqVYSRUx3tKDQ=;
        b=WWTl831h1hLrRHyCXf3DytETojLSGftQmq77K3b9N6eMDev4tsL2JkFygqgLTWg0T8
         SSYTmW86s5aeqymS+/bdzXS5jBTr9c9k+xMjvYog9Ta3A7u8knfZufuQYCLqCV2J+MDj
         /y94pG/ew0r8fACxrEUa/6vOd/l7uofCIGpV9cDAMTvSfFTVaPRVdHLLIBMCdU7ABEfR
         DyuMGuIAMT+warBnYOcVmWtWqLYWeD6Fk60xMim05nVz/9FuXSsXWgSofWlP9/nWIUM6
         y5JDj9wiBzcupoK1ANdeEWi+dPnkj7ntUdEwaJhrq0Rptt661684HD8VSF2U+YbLYdCC
         bd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HtIgN6AdT+17GwfQORoopmuViWKlchoqVYSRUx3tKDQ=;
        b=h/Qf47MAfuHAqvjvhPBv333VChmFSHOGKm0VfhuXv4AbDSFKiwhq2AIfF0xbHQUyeT
         cQQho0gBhElaZMP21SAhREdwsYhZnBe9Re2AptL+MNiQaaGAJD1s9c3z0LBLvvK0T+2n
         5xgC2AExvB1m3X0/tPZ9vMjdgP4Ib7Pnm4y/UHoN0mM3uhqPmYakVH4HowkR9dMejYz9
         nfYdi8FJxkRC09dJanugTlTeoBj50CipF1pMmVBifqc+F1H0zJo33qJM9pwYUWpcknYX
         ogeCEgBdUV8+fuqqQ5oblg7dCspgXW16agIZ7yHwpkBvtTILrE+qQ0wtoUypZNFpC3Z8
         wkGg==
X-Gm-Message-State: AOAM53374RhRap1Obc288uUydnsxOhfcdcC5PldXlbSXrnEmdGe3ieJO
        uGYZUZKHMdyduTB5F+Dc1kEXMBWw18U=
X-Google-Smtp-Source: ABdhPJzI+uQwQtzHEiBagL8inR3+Kp0cko+5UjrbOcyh997XWjdXRe67i8cO6jBrnWrzU4G7Ulz26g==
X-Received: by 2002:a05:600c:3203:b0:381:b544:7970 with SMTP id r3-20020a05600c320300b00381b5447970mr2354447wmp.144.1647333845370;
        Tue, 15 Mar 2022 01:44:05 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:44:04 -0700 (PDT)
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
Subject: [PATCH 15/15] sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
Date:   Tue, 15 Mar 2022 09:42:47 +0100
Message-Id: <20220315084247.40783-16-mingo@kernel.org>
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
 kernel/sched/build_policy.c  |   4 --
 kernel/sched/build_utility.c |   6 +--
 kernel/sched/sched.h         | 147 +++++++++++++++++++--------------------------------------------
 kernel/sched/stats.h         |   2 -
 4 files changed, 46 insertions(+), 113 deletions(-)

diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
index a2e4023771a0..e0104b45029a 100644
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
index bc2f4d648209..eec0849b2aae 100644
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
index f255ec2afeca..0d4217965561 100644
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
index a0df79e6038c..baa839c1ba96 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -2,8 +2,6 @@
 #ifndef _KERNEL_STATS_H
 #define _KERNEL_STATS_H
 
-#include "sched.h"
-
 #ifdef CONFIG_SCHEDSTATS
 
 extern struct static_key_false sched_schedstats;
-- 
2.32.0

