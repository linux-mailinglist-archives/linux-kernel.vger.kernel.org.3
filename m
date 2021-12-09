Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53146ECDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhLIQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:16:13 -0500
Received: from foss.arm.com ([217.140.110.172]:58726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237141AbhLIQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:16:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9FD911FB;
        Thu,  9 Dec 2021 08:12:34 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.83.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5EAD03F5A1;
        Thu,  9 Dec 2021 08:12:33 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 3/4] sched/fair: Remove task_util from effective utilization in feec()
Date:   Thu,  9 Dec 2021 16:11:58 +0000
Message-Id: <20211209161159.1596018-4-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209161159.1596018-1-vincent.donnefort@arm.com>
References: <20211209161159.1596018-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The energy estimation in find_energy_efficient_cpu() (feec()) relies on
the computation of the effective utilization for each CPU of a perf domain
(PD). This effective utilization is then used as an estimation of the busy
time for this pd. The function effective_cpu_util() which gives this value,
scales the utilization relative to IRQ pressure on the CPU to take into
account that the IRQ time is hidden from the task clock. The IRQ scaling is
as follow:

   effective_cpu_util = irq + (cpu_cap - irq)/cpu_cap * util

Where util is the sum of CFS/RT/DL utilization, cpu_cap the capacity of
the CPU and irq the IRQ avg time.

If now we take as an example a task placement which doesn't raise the OPP
on the candidate CPU, we can write the energy delta as:

  delta = OPPcost/cpu_cap * (effective_cpu_util(cpu_util + task_util) -
                             effective_cpu_util(cpu_util))
        = OPPcost/cpu_cap * (cpu_cap - irq)/cpu_cap * task_util

We end-up with an energy delta depending on the IRQ avg time, which is a
problem: first the time spent on IRQs by a CPU has no effect on the
additional energy that would be consumed by a task. Second, we don't want
to favour a CPU with a higher IRQ avg time value.

Nonetheless, we need to take the IRQ avg time into account. If a task
placement raises the PD's frequency, it will increase the energy cost for
the entire time where the CPU is busy. A solution is to only use
effective_cpu_util() with the CPU contribution part. The task contribution
is added separately and scaled according to prev_cpu's IRQ time.

No change for the FREQUENCY_UTIL component of the energy estimation. We
still want to get the actual frequency that would be selected after the
task placement.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d640d519866..c40252a96671 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6599,23 +6599,83 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 	return min(util, capacity_orig_of(cpu));
 }
 
+/*
+ * Compute the task busy time for compute_energy(). This time cannot be
+ * injected directly into effective_cpu_util() because of the IRQ scaling.
+ * The latter only makes sense with the most recent CPUs where the task has
+ * run.
+ */
+static inline unsigned long
+task_busy_time(struct task_struct *p, int prev_cpu)
+{
+	unsigned long cpu_cap = arch_scale_cpu_capacity(prev_cpu);
+	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
+
+	return scale_irq_capacity(task_util_est(p), irq, cpu_cap);
+}
+
+/*
+ * Compute the busy time for compute_energy(). Based on the utilization, it
+ * however doesn't take into account clamping since the ratio (utilization /
+ * cpu_capacity) is already enough to scale the EM reported power consumption
+ * at the (eventually clamped) cpu_capacity.
+ *
+ * The contribution of the task @p for which we want to estimate the energy
+ * cost is removed (by cpu_util_next()) and must be compted separalyte (see
+ * task_busy_time). This ensures:
+ *
+ *   - A stable PD utilization, no matter which CPU of that PD we want to place
+ *     the task on.
+ *
+ *   - A fair comparison between CPUs as the task contribution (task_util())
+ *     will always be the same no matter which CPU utilization we rely on
+ *     (util_avg or util_est).
+ *
+ * Returns the busy time for @pd. @pd_task_busy_time gives the sum of pd's and
+ * task's busy time.
+ */
+static inline unsigned long
+pd_task_busy_time(struct task_struct *p, struct perf_domain *pd,
+		  unsigned long cpu_cap, unsigned long tsk_busy_time,
+		  unsigned long *pd_tsk_busy_time)
+{
+	unsigned long max_cap, pd_cap = 0, pd_busy_time = 0;
+	struct cpumask *pd_mask = perf_domain_span(pd);
+	int cpu;
+
+	max_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
+
+	/* see compute_energy() */
+	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+		unsigned long util = cpu_util_next(cpu, p, -1);
+
+		pd_cap += cpu_cap;
+		pd_busy_time += effective_cpu_util(cpu, util, max_cap,
+						     ENERGY_UTIL, NULL);
+	}
+
+	pd_busy_time = min(pd_cap, pd_busy_time);
+	*pd_tsk_busy_time = min(pd_cap, pd_busy_time + tsk_busy_time);
+
+	return pd_busy_time;
+}
+
 /*
  * compute_energy(): Estimates the energy that @pd would consume if @p was
- * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
- * landscape of @pd's CPUs after the task migration, and uses the Energy Model
- * to compute what would be the energy if we decided to actually migrate that
- * task.
+ * migrated to @dst_cpu. compute_energy(), in conjunction with
+ * pd_task_busy_time() predicts what will be the utilization landscape of @pd's
+ * CPUs after the task migration, and uses the Energy Model to compute what
+ * would be the energy if we decided to actually migrate that task.
  */
 static long
-compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
+compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd,
+	       unsigned long cpu_cap, unsigned long busy_time)
 {
 	struct cpumask *pd_mask = perf_domain_span(pd);
-	unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
-	unsigned long max_util = 0, sum_util = 0;
-	unsigned long _cpu_cap = cpu_cap;
+	unsigned long max_cap, max_util = 0;
 	int cpu;
 
-	_cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
+	max_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
 
 	/*
 	 * The capacity state of CPUs of the current rd can be driven by CPUs
@@ -6628,34 +6688,11 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 */
 	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
 		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
-		unsigned long cpu_util, util_running = util_freq;
+		unsigned long cpu_util;
 		struct task_struct *tsk = NULL;
 
-		/*
-		 * When @p is placed on @cpu:
-		 *
-		 * util_running = max(cpu_util, cpu_util_est) +
-		 *		  max(task_util, _task_util_est)
-		 *
-		 * while cpu_util_next is: max(cpu_util + task_util,
-		 *			       cpu_util_est + _task_util_est)
-		 */
-		if (cpu == dst_cpu) {
+		if (cpu == dst_cpu)
 			tsk = p;
-			util_running =
-				cpu_util_next(cpu, p, -1) + task_util_est(p);
-		}
-
-		/*
-		 * Busy time computation: utilization clamping is not
-		 * required since the ratio (sum_util / cpu_capacity)
-		 * is already enough to scale the EM reported power
-		 * consumption at the (eventually clamped) cpu_capacity.
-		 */
-		cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
-					      ENERGY_UTIL, NULL);
-
-		sum_util += min(cpu_util, _cpu_cap);
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -6664,12 +6701,12 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
+		cpu_util = effective_cpu_util(cpu, util_freq, max_cap,
 					      FREQUENCY_UTIL, tsk);
-		max_util = max(max_util, min(cpu_util, _cpu_cap));
+		max_util = max(max_util, min(cpu_util, cpu_cap));
 	}
 
-	return em_cpu_energy(pd->em_pd, max_util, sum_util, _cpu_cap);
+	return em_cpu_energy(pd->em_pd, max_util, busy_time, cpu_cap);
 }
 
 /*
@@ -6714,9 +6751,11 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
+	unsigned long tsk_busy_time, pd_busy_time, pd_tsk_busy_time;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
-	unsigned long cpu_cap, util, base_energy = 0;
+	unsigned long cpu_cap, cpu_thermal_cap, util;
+	unsigned long base_energy = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 
@@ -6741,6 +6780,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	if (!task_util_est(p))
 		goto unlock;
 
+	tsk_busy_time = task_busy_time(p, prev_cpu);
+
 	for (; pd; pd = pd->next) {
 		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
 		bool compute_prev_delta = false;
@@ -6783,13 +6824,27 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
 			continue;
 
+		/* Account thermal pressure for the energy estimation */
+		cpu_thermal_cap = arch_scale_cpu_capacity(
+					cpumask_first(perf_domain_span(pd)));
+		cpu_thermal_cap -= arch_scale_thermal_pressure(
+					cpumask_first(perf_domain_span(pd)));
+
+		/* Get the effective utilization for energy estimation */
+		pd_busy_time = pd_task_busy_time(p, pd, cpu_thermal_cap,
+						 tsk_busy_time,
+						 &pd_tsk_busy_time);
+
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy_pd = compute_energy(p, -1, pd, cpu_thermal_cap,
+						pd_busy_time);
 		base_energy += base_energy_pd;
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
-			prev_delta = compute_energy(p, prev_cpu, pd);
+			prev_delta = compute_energy(p, prev_cpu, pd,
+						    cpu_thermal_cap,
+						    pd_tsk_busy_time);
 			if (prev_delta < base_energy_pd)
 				goto unlock;
 			prev_delta -= base_energy_pd;
@@ -6798,7 +6853,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			cur_delta = compute_energy(p, max_spare_cap_cpu, pd,
+						   cpu_thermal_cap,
+						   pd_tsk_busy_time);
 			if (cur_delta < base_energy_pd)
 				goto unlock;
 			cur_delta -= base_energy_pd;
-- 
2.25.1

