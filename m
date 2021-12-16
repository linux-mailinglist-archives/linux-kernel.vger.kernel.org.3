Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F75478030
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhLPWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:53:46 -0500
Received: from foss.arm.com ([217.140.110.172]:49496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236629AbhLPWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:53:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B13C91474;
        Thu, 16 Dec 2021 14:53:43 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22D443F73B;
        Thu, 16 Dec 2021 14:53:42 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 1/2] sched/sugov: Ignore 'busy' filter when rq is capped by uclamp_max
Date:   Thu, 16 Dec 2021 22:53:19 +0000
Message-Id: <20211216225320.2957053-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216225320.2957053-1-qais.yousef@arm.com>
References: <20211216225320.2957053-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sugov_update_single_{freq, perf}() contains a 'busy' filter that ensures
we don't bring the frqeuency down if there's no idle time (CPU is busy).

The problem is that with uclamp_max we will have scenarios where a busy
task is capped to run at a lower frequency and this filter prevents
applying the capping when this task starts running.

We handle this by skipping the filter when uclamp is enabled and the rq
is being capped by uclamp_max.

We introduce a new function uclamp_rq_is_capped() to help detecting when
this capping is taking effect. Some code shuffling was required to allow
using cpu_util_{cfs, rt}() in this new function.

On 2 Core SMT2 Intel laptop I see:

Without this patch:

	uclampset -M 0 sysbench --test=cpu --threads = 4 run

produces a score of ~3200 consistently. Which is the highest possible.

Compiling the kernel also results in frequency running at max 3.1GHz all
the time - running uclampset -M 400 to cap it has no effect without this
patch.

With this patch:

	uclampset -M 0 sysbench --test=cpu --threads = 4 run

produces a score of ~1100 with some outliers in ~1700. Uclamp max
aggregates the performance requirements, so having high values sometimes
is expected if some other task happens to require that frequency starts
running at the same time.

When compiling the kernel with uclampset -M 400 I can see the
frequencies mostly in the ~2GHz region. Helpful to conserve power and
prevent heating when not plugged in.

Fixes: 982d9cdc22c9 ("sched/cpufreq, sched/uclamp: Add clamps for FAIR and RT tasks")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

I haven't dug much into the busy filter, but I assume it is something that is
still required right? If there's a better alternative we can take to make this
filter better instead, I'm happy to hear ideas. Otherwise hopefully this
proposal is logical too.

uclampset is a tool available in util-linux v2.37.2

 kernel/sched/cpufreq_schedutil.c |  10 ++-
 kernel/sched/sched.h             | 139 +++++++++++++++++--------------
 2 files changed, 86 insertions(+), 63 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e7af18857371..48327970552a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -348,8 +348,11 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
+	 *
+	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
+	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
+	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
 		next_f = sg_policy->next_freq;
 
 		/* Restore cached freq as next_freq has changed */
@@ -395,8 +398,11 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	/*
 	 * Do not reduce the target performance level if the CPU has not been
 	 * idle recently, as the reduction is likely to be premature then.
+	 *
+	 * Except when the rq is capped by uclamp_max.
 	 */
-	if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
+	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eb971151e7e4..294ebc22413c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2841,6 +2841,67 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags)
 static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
+#ifdef arch_scale_freq_capacity
+# ifndef arch_scale_freq_invariant
+#  define arch_scale_freq_invariant()	true
+# endif
+#else
+# define arch_scale_freq_invariant()	false
+#endif
+
+#ifdef CONFIG_SMP
+static inline unsigned long capacity_orig_of(int cpu)
+{
+	return cpu_rq(cpu)->cpu_capacity_orig;
+}
+
+/**
+ * enum cpu_util_type - CPU utilization type
+ * @FREQUENCY_UTIL:	Utilization used to select frequency
+ * @ENERGY_UTIL:	Utilization used during energy calculation
+ *
+ * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
+ * need to be aggregated differently depending on the usage made of them. This
+ * enum is used within effective_cpu_util() to differentiate the types of
+ * utilization expected by the callers, and adjust the aggregation accordingly.
+ */
+enum cpu_util_type {
+	FREQUENCY_UTIL,
+	ENERGY_UTIL,
+};
+
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
+				 struct task_struct *p);
+
+static inline unsigned long cpu_bw_dl(struct rq *rq)
+{
+	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
+}
+
+static inline unsigned long cpu_util_dl(struct rq *rq)
+{
+	return READ_ONCE(rq->avg_dl.util_avg);
+}
+
+static inline unsigned long cpu_util_cfs(struct rq *rq)
+{
+	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
+
+	if (sched_feat(UTIL_EST)) {
+		util = max_t(unsigned long, util,
+			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
+	}
+
+	return util;
+}
+
+static inline unsigned long cpu_util_rt(struct rq *rq)
+{
+	return READ_ONCE(rq->avg_rt.util_avg);
+}
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
@@ -2897,6 +2958,21 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 	return clamp(util, min_util, max_util);
 }
 
+/* Is the rq being capped/throttled by uclamp_max? */
+static inline bool uclamp_rq_is_capped(struct rq *rq)
+{
+	unsigned long rq_util;
+	unsigned long max_util;
+
+	if (!static_branch_likely(&sched_uclamp_used))
+		return false;
+
+	rq_util = cpu_util_cfs(rq) + cpu_util_rt(rq);
+	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
+
+	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
+}
+
 /*
  * When uclamp is compiled in, the aggregation at rq level is 'turned off'
  * by default in the fast path and only gets turned on once userspace performs
@@ -2917,73 +2993,14 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 	return util;
 }
 
+static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
+
 static inline bool uclamp_is_used(void)
 {
 	return false;
 }
 #endif /* CONFIG_UCLAMP_TASK */
 
-#ifdef arch_scale_freq_capacity
-# ifndef arch_scale_freq_invariant
-#  define arch_scale_freq_invariant()	true
-# endif
-#else
-# define arch_scale_freq_invariant()	false
-#endif
-
-#ifdef CONFIG_SMP
-static inline unsigned long capacity_orig_of(int cpu)
-{
-	return cpu_rq(cpu)->cpu_capacity_orig;
-}
-
-/**
- * enum cpu_util_type - CPU utilization type
- * @FREQUENCY_UTIL:	Utilization used to select frequency
- * @ENERGY_UTIL:	Utilization used during energy calculation
- *
- * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
- * need to be aggregated differently depending on the usage made of them. This
- * enum is used within effective_cpu_util() to differentiate the types of
- * utilization expected by the callers, and adjust the aggregation accordingly.
- */
-enum cpu_util_type {
-	FREQUENCY_UTIL,
-	ENERGY_UTIL,
-};
-
-unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum cpu_util_type type,
-				 struct task_struct *p);
-
-static inline unsigned long cpu_bw_dl(struct rq *rq)
-{
-	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
-}
-
-static inline unsigned long cpu_util_dl(struct rq *rq)
-{
-	return READ_ONCE(rq->avg_dl.util_avg);
-}
-
-static inline unsigned long cpu_util_cfs(struct rq *rq)
-{
-	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
-
-	if (sched_feat(UTIL_EST)) {
-		util = max_t(unsigned long, util,
-			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
-	}
-
-	return util;
-}
-
-static inline unsigned long cpu_util_rt(struct rq *rq)
-{
-	return READ_ONCE(rq->avg_rt.util_avg);
-}
-#endif
-
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
-- 
2.25.1

