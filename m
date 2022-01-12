Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5C48C809
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355157AbiALQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:16:24 -0500
Received: from foss.arm.com ([217.140.110.172]:33018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355061AbiALQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:14:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 999A3ED1;
        Wed, 12 Jan 2022 08:14:55 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.10.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04F2A3F774;
        Wed, 12 Jan 2022 08:14:53 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 6/7] sched/fair: Remove task_util from effective utilization in feec()
Date:   Wed, 12 Jan 2022 16:12:29 +0000
Message-Id: <20220112161230.836326-7-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112161230.836326-1-vincent.donnefort@arm.com>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
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
index cfc0d9b3eb19..efb2e0739015 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6548,61 +6548,77 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 }
 
 /*
- * compute_energy(): Estimates the energy that @pd would consume if @p was
- * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
- * landscape of @pd's CPUs after the task migration, and uses the Energy Model
- * to compute what would be the energy if we decided to actually migrate that
- * task.
+ * Compute the task busy time for compute_energy(). This time cannot be
+ * injected directly into effective_cpu_util() because of the IRQ scaling.
+ * The latter only makes sense with the most recent CPUs where the task has
+ * run.
  */
-static long
-compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
-	       struct perf_domain *pd)
+static inline unsigned long
+get_task_busy_time(struct task_struct *p, int prev_cpu)
 {
-	unsigned long max_util = 0, sum_util = 0, cpu_cap;
-	int cpu;
+	unsigned long max_cap = arch_scale_cpu_capacity(prev_cpu);
+	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
 
-	cpu_cap = arch_scale_cpu_capacity(cpumask_first(cpus));
-	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(cpus));
+	if (unlikely(irq >= max_cap))
+		return max_cap;
+
+	return scale_irq_capacity(task_util_est(p), irq, max_cap);
+}
+
+/*
+ * Compute the perf_domain (PD) busy time for compute_energy(). Based on the
+ * utilization for each @cpus, it however doesn't take into account clamping
+ * since the ratio (utilization /  cpu_capacity) is already enough to scale
+ * the EM reported power consumption at the (eventually clamped) cpu_capacity.
+ *
+ * The contribution of the task @p for which we want to estimate the energy
+ * cost is removed (by cpu_util_next()) and must be calculated separately (see
+ * get_task_busy_time). This ensures:
+ *
+ *   - A stable PD utilization, no matter which CPU of that PD we want to place
+ *     the task on.
+ *
+ *   - A fair comparison between CPUs as the task contribution (task_util())
+ *     will always be the same no matter which CPU utilization we rely on
+ *     (util_avg or util_est).
+ *
+ * Returns the busy time for the PD that spans @cpus. This busy time can't
+ * exceed @pd_cap.
+ */
+static inline unsigned long
+get_pd_busy_time(struct task_struct *p, struct cpumask *cpus,
+		 unsigned long pd_cap)
+{
+	unsigned long busy_time = 0;
+	int cpu;
 
-	/*
-	 * The capacity state of CPUs of the current rd can be driven by CPUs
-	 * of another rd if they belong to the same pd. So, account for the
-	 * utilization of these CPUs too by masking pd with cpu_online_mask
-	 * instead of the rd span.
-	 *
-	 * If an entire pd is outside of the current rd, it will not appear in
-	 * its pd list and will not be accounted by compute_energy().
-	 */
 	for_each_cpu(cpu, cpus) {
-		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
-		unsigned long cpu_util, util_running = util_freq;
-		struct task_struct *tsk = NULL;
+		unsigned long util = cpu_util_next(cpu, p, -1);
 
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
-			tsk = p;
-			util_running =
-				cpu_util_next(cpu, p, -1) + task_util_est(p);
-		}
+		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
+	}
 
-		/*
-		 * Busy time computation: utilization clamping is not
-		 * required since the ratio (sum_util / cpu_capacity)
-		 * is already enough to scale the EM reported power
-		 * consumption at the (eventually clamped) cpu_capacity.
-		 */
-		cpu_util = effective_cpu_util(cpu, util_running, ENERGY_UTIL,
-					      NULL);
+	return min(pd_cap, busy_time);
+}
+
+/*
+ * Compute the maximum utilization for compute_energy() when the task @p is
+ * placed on the cpu @dst_cpu.
+ *
+ * Returns the maximum utilization among @cpus. This utilization can't exceed
+ * @cpu_cap.
+ */
+static inline unsigned long
+get_pd_max_util(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
+		unsigned long cpu_cap)
+{
+	unsigned long max_util = 0;
+	int cpu;
 
-		sum_util += min(cpu_util, cpu_cap);
+	for_each_cpu(cpu, cpus) {
+		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
+		unsigned long util = cpu_util_next(cpu, p, dst_cpu);
+		unsigned long cpu_util;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -6611,12 +6627,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = effective_cpu_util(cpu, util_freq, FREQUENCY_UTIL,
-					      tsk);
-		max_util = max(max_util, min(cpu_util, cpu_cap));
+		cpu_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
+		max_util = max(max_util, cpu_util);
 	}
 
-	return em_cpu_energy(pd->em_pd, max_util, sum_util, cpu_cap);
+	return min(max_util, cpu_cap);
+}
+
+/*
+ * compute_energy(): Use the Energy Model to estimate the energy that @pd would
+ * consume for a given utilization landscape. @max_util can be predicted with
+ * get_pd_max_util(), @busy_time can be predicted with get_task_busy_time() and
+ * get_pd_busy_time().
+ */
+static inline unsigned long
+compute_energy(struct perf_domain *pd, unsigned long max_util,
+	       unsigned long busy_time, unsigned long cpu_cap)
+{
+	return em_cpu_energy(pd->em_pd, max_util, busy_time, cpu_cap);
 }
 
 /*
@@ -6662,9 +6690,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
+	unsigned long busy_time, tsk_busy_time, max_util, pd_cap;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
-	unsigned long cpu_cap, util, base_energy = 0;
+	unsigned long cpu_cap, cpu_thermal_cap, util;
+	unsigned long base_energy = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 
@@ -6689,6 +6719,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	if (!task_util_est(p))
 		goto unlock;
 
+	tsk_busy_time = get_task_busy_time(p, prev_cpu);
+
 	for (; pd; pd = pd->next) {
 		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
 		bool compute_prev_delta = false;
@@ -6697,7 +6729,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
-		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
+		/* Account thermal pressure for the energy estimation */
+		cpu = cpumask_first(cpus);
+		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
+		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
+
+		for_each_cpu(cpu, cpus) {
+			pd_cap += cpu_thermal_cap;
+
+			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
+				continue;
+
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
@@ -6734,12 +6776,21 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			continue;
 
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, cpus, pd);
+		busy_time = get_pd_busy_time(p, cpus, pd_cap);
+		max_util = get_pd_max_util(p, -1, cpus, cpu_thermal_cap);
+		base_energy_pd = compute_energy(pd, max_util, busy_time,
+						cpu_thermal_cap);
 		base_energy += base_energy_pd;
 
+		/* Take task into account for the next energy computations */
+		busy_time = min(pd_cap, busy_time + tsk_busy_time);
+
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
-			prev_delta = compute_energy(p, prev_cpu, cpus, pd);
+			max_util = get_pd_max_util(p, prev_cpu, cpus,
+						   cpu_thermal_cap);
+			prev_delta = compute_energy(pd, max_util, busy_time,
+						    cpu_thermal_cap);
 			if (prev_delta < base_energy_pd)
 				goto unlock;
 			prev_delta -= base_energy_pd;
@@ -6748,8 +6799,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
-						   pd);
+			max_util = get_pd_max_util(p, max_spare_cap_cpu, cpus,
+						   cpu_thermal_cap);
+			cur_delta = compute_energy(pd, max_util, busy_time,
+						   cpu_thermal_cap);
 			if (cur_delta < base_energy_pd)
 				goto unlock;
 			cur_delta -= base_energy_pd;
-- 
2.25.1

