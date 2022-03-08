Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30F4D2003
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbiCHSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349504AbiCHSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:21:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 268E056772
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:20:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E11B01516;
        Tue,  8 Mar 2022 10:20:21 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.88.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B77993FA45;
        Tue,  8 Mar 2022 10:20:20 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Subject: [PATCH v3 5/7] sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()
Date:   Tue,  8 Mar 2022 18:19:55 +0000
Message-Id: <20220308181957.280354-6-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308181957.280354-1-vincent.donnefort@arm.com>
References: <20220308181957.280354-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The Perf Domain (PD) cpumask (struct em_perf_domain.cpus) stays
invariant after Energy Model creation, i.e. it is not updated after
CPU hotplug operations.

That's why the PD mask is used in conjunction with the cpu_online_mask
(or Sched Domain cpumask). Thereby the cpu_online_mask is fetched
multiple times (in compute_energy()) during a run-queue selection
for a task.

cpu_online_mask may change during this time which can lead to wrong
energy calculations.

To be able to avoid this, use the select_rq_mask per-cpu cpumask to
create a cpumask out of PD cpumask and cpu_online_mask and pass it
through the function calls of the EAS run-queue selection path.

The PD cpumask for max_spare_cap_cpu/compute_prev_delta selection
(find_energy_efficient_cpu()) is now ANDed not only with the SD mask
but also with the cpu_online_mask. This is fine since this cpumask
has to be in syc with the one used for energy computation
(compute_energy()).
An exclusive cpuset setup with at least one asymmetric CPU capacity
island (hence the additional AND with the SD cpumask) is the obvious
exception here.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ebfaa2fc1f4..07de5c63c75f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6572,14 +6572,14 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
  * task.
  */
 static long
-compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
+compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
+	       struct perf_domain *pd)
 {
-	struct cpumask *pd_mask = perf_domain_span(pd);
 	unsigned long max_util = 0, sum_util = 0, cpu_cap;
 	int cpu;
 
-	cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
-	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
+	cpu_cap = arch_scale_cpu_capacity(cpumask_first(cpus));
+	cpu_cap -= arch_scale_thermal_pressure(cpumask_first(cpus));
 
 	/*
 	 * The capacity state of CPUs of the current rd can be driven by CPUs
@@ -6590,7 +6590,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 * If an entire pd is outside of the current rd, it will not appear in
 	 * its pd list and will not be accounted by compute_energy().
 	 */
-	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+	for_each_cpu(cpu, cpus) {
 		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
 		unsigned long cpu_util, util_running = util_freq;
 		struct task_struct *tsk = NULL;
@@ -6677,6 +6677,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  */
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
@@ -6711,7 +6712,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
-		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
+		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
+
+		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
@@ -6748,12 +6751,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			continue;
 
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy_pd = compute_energy(p, -1, cpus, pd);
 		base_energy += base_energy_pd;
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
-			prev_delta = compute_energy(p, prev_cpu, pd);
+			prev_delta = compute_energy(p, prev_cpu, cpus, pd);
 			if (prev_delta < base_energy_pd)
 				goto unlock;
 			prev_delta -= base_energy_pd;
@@ -6762,7 +6765,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
 		if (max_spare_cap_cpu >= 0) {
-			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
+			cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
+						   pd);
 			if (cur_delta < base_energy_pd)
 				goto unlock;
 			cur_delta -= base_energy_pd;
-- 
2.25.1

