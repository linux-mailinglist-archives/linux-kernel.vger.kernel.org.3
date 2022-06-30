Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA9562EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiGAIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiGAItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE0112AD7;
        Fri,  1 Jul 2022 01:48:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:10:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hs3xHjYWjz6q7SteTKc5qsIGPNHxkO9MuvcBbtWtqI=;
        b=C5nkyp+6BmAbhYqwQ1/4mWpF8vS+JPoKt+F5w5vHSWyhFUdYePcuiwFvNs/YE8mL1pCb9Z
        hOlB3zAzPgyHDO9kkSiEZa3Clc4gdcT7fp/7Hs48/ySegfp8bGgoTpROL5eM+b4Htzs1UE
        F65/0yFHiVLYn/Tb67U0hkfu6Lxwn1fiGo3Q0jY9oiud/aVaD3BmDeKtcPjTgTLaHRqoJz
        V2/G2cjAhj4rXvUE4aC2mLEhMEaFKFEE225g21Cyoc2N5wvCIE8x8D4j9DxxAE+Nq+Uq8R
        BpkPez8sDfnQ9my3sT/blO0aEllE32gJ3iZxJ/dpFVjjqDk0M8hztH1uSAXINg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hs3xHjYWjz6q7SteTKc5qsIGPNHxkO9MuvcBbtWtqI=;
        b=pRpblIuL7RKP4pkiTWfw+GyMErTTjZpW7lUvuvIOyEqNGaztFr0jkaobmFm8dMgbm0UJRN
        TRoUDM371CPOyHDA==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove task_util from effective
 utilization in feec()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621090414.433602-7-vdonnefort@google.com>
References: <20220621090414.433602-7-vdonnefort@google.com>
MIME-Version: 1.0
Message-ID: <165660183379.15455.4431382691572745363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3e8c6c9aac42ced4ca705714b6dd34cf4d305cf0
Gitweb:        https://git.kernel.org/tip/3e8c6c9aac42ced4ca705714b6dd34cf4d305cf0
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 21 Jun 2022 10:04:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:17:47 +02:00

sched/fair: Remove task_util from effective utilization in feec()

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
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20220621090414.433602-7-vdonnefort@google.com
---
 kernel/sched/fair.c | 202 +++++++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 63 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46d6692..0ef7e0a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6702,61 +6702,96 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 }
 
 /*
- * compute_energy(): Estimates the energy that @pd would consume if @p was
- * migrated to @dst_cpu. compute_energy() predicts what will be the utilization
- * landscape of @pd's CPUs after the task migration, and uses the Energy Model
- * to compute what would be the energy if we decided to actually migrate that
- * task.
+ * energy_env - Utilization landscape for energy estimation.
+ * @task_busy_time: Utilization contribution by the task for which we test the
+ *                  placement. Given by eenv_task_busy_time().
+ * @pd_busy_time:   Utilization of the whole perf domain without the task
+ *                  contribution. Given by eenv_pd_busy_time().
+ * @cpu_cap:        Maximum CPU capacity for the perf domain.
+ * @pd_cap:         Entire perf domain capacity. (pd->nr_cpus * cpu_cap).
+ */
+struct energy_env {
+	unsigned long task_busy_time;
+	unsigned long pd_busy_time;
+	unsigned long cpu_cap;
+	unsigned long pd_cap;
+};
+
+/*
+ * Compute the task busy time for compute_energy(). This time cannot be
+ * injected directly into effective_cpu_util() because of the IRQ scaling.
+ * The latter only makes sense with the most recent CPUs where the task has
+ * run.
  */
-static long
-compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
-	       struct perf_domain *pd)
+static inline void eenv_task_busy_time(struct energy_env *eenv,
+				       struct task_struct *p, int prev_cpu)
 {
-	unsigned long max_util = 0, sum_util = 0, cpu_cap;
+	unsigned long busy_time, max_cap = arch_scale_cpu_capacity(prev_cpu);
+	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
+
+	if (unlikely(irq >= max_cap))
+		busy_time = max_cap;
+	else
+		busy_time = scale_irq_capacity(task_util_est(p), irq, max_cap);
+
+	eenv->task_busy_time = busy_time;
+}
+
+/*
+ * Compute the perf_domain (PD) busy time for compute_energy(). Based on the
+ * utilization for each @pd_cpus, it however doesn't take into account
+ * clamping since the ratio (utilization / cpu_capacity) is already enough to
+ * scale the EM reported power consumption at the (eventually clamped)
+ * cpu_capacity.
+ *
+ * The contribution of the task @p for which we want to estimate the
+ * energy cost is removed (by cpu_util_next()) and must be calculated
+ * separately (see eenv_task_busy_time). This ensures:
+ *
+ *   - A stable PD utilization, no matter which CPU of that PD we want to place
+ *     the task on.
+ *
+ *   - A fair comparison between CPUs as the task contribution (task_util())
+ *     will always be the same no matter which CPU utilization we rely on
+ *     (util_avg or util_est).
+ *
+ * Set @eenv busy time for the PD that spans @pd_cpus. This busy time can't
+ * exceed @eenv->pd_cap.
+ */
+static inline void eenv_pd_busy_time(struct energy_env *eenv,
+				     struct cpumask *pd_cpus,
+				     struct task_struct *p)
+{
+	unsigned long busy_time = 0;
 	int cpu;
 
-	cpu_cap = arch_scale_cpu_capacity(cpumask_first(cpus));
-	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(cpus));
+	for_each_cpu(cpu, pd_cpus) {
+		unsigned long util = cpu_util_next(cpu, p, -1);
 
-	/*
-	 * The capacity state of CPUs of the current rd can be driven by CPUs
-	 * of another rd if they belong to the same pd. So, account for the
-	 * utilization of these CPUs too by masking pd with cpu_online_mask
-	 * instead of the rd span.
-	 *
-	 * If an entire pd is outside of the current rd, it will not appear in
-	 * its pd list and will not be accounted by compute_energy().
-	 */
-	for_each_cpu(cpu, cpus) {
-		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
-		unsigned long cpu_util, util_running = util_freq;
-		struct task_struct *tsk = NULL;
+		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
+	}
 
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
+	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
+}
 
-		/*
-		 * Busy time computation: utilization clamping is not
-		 * required since the ratio (sum_util / cpu_capacity)
-		 * is already enough to scale the EM reported power
-		 * consumption at the (eventually clamped) cpu_capacity.
-		 */
-		cpu_util = effective_cpu_util(cpu, util_running, ENERGY_UTIL,
-					      NULL);
+/*
+ * Compute the maximum utilization for compute_energy() when the task @p
+ * is placed on the cpu @dst_cpu.
+ *
+ * Returns the maximum utilization among @eenv->cpus. This utilization can't
+ * exceed @eenv->cpu_cap.
+ */
+static inline unsigned long
+eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
+		 struct task_struct *p, int dst_cpu)
+{
+	unsigned long max_util = 0;
+	int cpu;
 
-		sum_util += min(cpu_util, cpu_cap);
+	for_each_cpu(cpu, pd_cpus) {
+		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
+		unsigned long util = cpu_util_next(cpu, p, dst_cpu);
+		unsigned long cpu_util;
 
 		/*
 		 * Performance domain frequency: utilization clamping
@@ -6765,12 +6800,29 @@ compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
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
+	return min(max_util, eenv->cpu_cap);
+}
+
+/*
+ * compute_energy(): Use the Energy Model to estimate the energy that @pd would
+ * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
+ * contribution is ignored.
+ */
+static inline unsigned long
+compute_energy(struct energy_env *eenv, struct perf_domain *pd,
+	       struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
+{
+	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
+	unsigned long busy_time = eenv->pd_busy_time;
+
+	if (dst_cpu >= 0)
+		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
+
+	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
 }
 
 /*
@@ -6816,11 +6868,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
-	unsigned long cpu_cap, util, base_energy = 0;
+	struct root_domain *rd = this_rq()->rd;
+	unsigned long base_energy = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
+	struct energy_env eenv;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
@@ -6843,22 +6896,39 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	if (!task_util_est(p))
 		goto unlock;
 
+	eenv_task_busy_time(&eenv, p, prev_cpu);
+
 	for (; pd; pd = pd->next) {
-		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		unsigned long cpu_cap, cpu_thermal_cap, util;
+		unsigned long cur_delta, max_spare_cap = 0;
 		bool compute_prev_delta = false;
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
-		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
+		if (cpumask_empty(cpus))
+			continue;
+
+		/* Account thermal pressure for the energy estimation */
+		cpu = cpumask_first(cpus);
+		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
+		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
+
+		eenv.cpu_cap = cpu_thermal_cap;
+		eenv.pd_cap = 0;
+
+		for_each_cpu(cpu, cpus) {
+			eenv.pd_cap += cpu_thermal_cap;
+
+			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
+				continue;
+
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
-			spare_cap = cpu_cap;
-			lsub_positive(&spare_cap, util);
 
 			/*
 			 * Skip CPUs that cannot satisfy the capacity request.
@@ -6871,15 +6941,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!fits_capacity(util, cpu_cap))
 				continue;
 
+			lsub_positive(&cpu_cap, util);
+
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
 				compute_prev_delta = true;
-			} else if (spare_cap > max_spare_cap) {
+			} else if (cpu_cap > max_spare_cap) {
 				/*
 				 * Find the CPU with the maximum spare capacity
 				 * in the performance domain.
 				 */
-				max_spare_cap = spare_cap;
+				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
 			}
 		}
@@ -6887,13 +6959,16 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
 			continue;
 
+		eenv_pd_busy_time(&eenv, cpus, p);
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, cpus, pd);
+		base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
 		base_energy += base_energy_pd;
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
-			prev_delta = compute_energy(p, prev_cpu, cpus, pd);
+			prev_delta = compute_energy(&eenv, pd, cpus, p,
+						    prev_cpu);
+			/* CPU utilization has changed */
 			if (prev_delta < base_energy_pd)
 				goto unlock;
 			prev_delta -= base_energy_pd;
@@ -6902,8 +6977,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
-						   pd);
+			cur_delta = compute_energy(&eenv, pd, cpus, p,
+						   max_spare_cap_cpu);
+			/* CPU utilization has changed */
 			if (cur_delta < base_energy_pd)
 				goto unlock;
 			cur_delta -= base_energy_pd;
