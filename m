Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6834552DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348637AbiFUJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbiFUJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:04:41 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44E61A813
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:39 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 206-20020a1c02d7000000b0039c9a08c52bso4053489wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4KZsNDPCzJ207WML9wXC024ukG812EyGktRwhEK7nuM=;
        b=rxqkeNofePLxPhWW6xKvi8do244IN7uoiswhwgv8j3JwMquRffDY5LsF9pjd7ONtx9
         caJtDnF9unphAAzyRzm2SM2vnjenu70vjxNtuWqXeQzLUb4oraZS+mwy++0AMx+c7SVg
         VhXVH+YQ8xmcjigtlHnugsIUv0bzkPrKRzssEO5uLP7rwWmoUe9FRHQgfsHiDBrqlS0h
         98YvterYZb/P9EnsHSfL5dp3+eC5RsN0NaxlQZeRW4oG1Mmc1iko/rIJNpnmpfjqiIc0
         AtsZ9ZIoTbHIw84LKQa0zpVlOCoT4qed4YuaFU2l/uc5cGJsysR7EJiHOAiNco32LJ6d
         ITSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4KZsNDPCzJ207WML9wXC024ukG812EyGktRwhEK7nuM=;
        b=W6tI5M/6l/GFWx5PTuR/6WWlo7kv0u6k8YVlbf4SfLWNEmeTzyRZ9vrA2rCg8ieRZ4
         8x8GuDk0pFfX4BlvTkR0L9piFlqEnXYEOyfuFHw9oxuCZ5DMx9t0bK3mPvMv8A2WqNr8
         6zhqB8Akoxl5JTfkRJMGRI7M91lUMtqq8qds6hiADH98Dd3fXo/ji3eN1XqwLJ7yT7vZ
         VGmuhqk6QPQ63+nWDPs7AaqIeuhp1bTbFC1jK+8xOXP9ILxX/+1oEqUFJGliDzf3eLaE
         dSQIwLhJUGTgHtOAodh+bapoa9bt2CCtSBt8WJRAsUbUaSIh5603GR4Bq1PIUw0lZ/wA
         BxQw==
X-Gm-Message-State: AOAM531i2IBfK80OYSC0ve5CzvqZvlMfobfqImbwkUFg4f4RdhFxXqUo
        S9Hy767q3Ck2kJ53CwlXjGuanZ2oy4kcuCfh
X-Google-Smtp-Source: ABdhPJxfRe12sbYw0LlETkCtcIUiqVxXk++WdgNbODvvjCW+qqJQadlPUWumCqCiXVn4jT9P9AyYSO6LQ5DEcp9l
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1d12:b0:39c:4307:8b10 with
 SMTP id l18-20020a05600c1d1200b0039c43078b10mr39432649wms.103.1655802278317;
 Tue, 21 Jun 2022 02:04:38 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:04:13 +0100
In-Reply-To: <20220621090414.433602-1-vdonnefort@google.com>
Message-Id: <20220621090414.433602-7-vdonnefort@google.com>
Mime-Version: 1.0
References: <20220621090414.433602-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: [PATCH v11 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
From:   Vincent Donnefort <vdonnefort@google.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        vdonnefort@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

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
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 112f760ff47e..0a28891cb178 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6694,61 +6694,96 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
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
@@ -6757,12 +6792,29 @@ compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
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
@@ -6808,11 +6860,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6835,22 +6888,39 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6863,15 +6933,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6879,13 +6951,16 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6894,8 +6969,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
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
-- 
2.37.0.rc0.104.g0611611a94-goog

