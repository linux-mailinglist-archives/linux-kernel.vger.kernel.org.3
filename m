Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9627848C808
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355145AbiALQQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:16:17 -0500
Received: from foss.arm.com ([217.140.110.172]:33008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355057AbiALQOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:14:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7E91FB;
        Wed, 12 Jan 2022 08:14:53 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.10.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C0AC3F774;
        Wed, 12 Jan 2022 08:14:52 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com
Subject: [PATCH v2 5/7] sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()
Date:   Wed, 12 Jan 2022 16:12:28 +0000
Message-Id: <20220112161230.836326-6-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112161230.836326-1-vincent.donnefort@arm.com>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 291be5c00044..cfc0d9b3eb19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6555,14 +6555,14 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
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
@@ -6573,7 +6573,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 	 * If an entire pd is outside of the current rd, it will not appear in
 	 * its pd list and will not be accounted by compute_energy().
 	 */
-	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
+	for_each_cpu(cpu, cpus) {
 		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
 		unsigned long cpu_util, util_running = util_freq;
 		struct task_struct *tsk = NULL;
@@ -6660,6 +6660,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
  */
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
@@ -6694,7 +6695,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
-		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
+		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
+
+		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
@@ -6731,12 +6734,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6745,7 +6748,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
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

