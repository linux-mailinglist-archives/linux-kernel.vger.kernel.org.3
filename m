Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA8514C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377070AbiD2OQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376814AbiD2OQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:16:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A92972CCBB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:13:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E9F1063;
        Fri, 29 Apr 2022 07:13:13 -0700 (PDT)
Received: from localhost.localdomain (FVFF7649Q05P.cambridge.arm.com [10.1.32.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7CA913F774;
        Fri, 29 Apr 2022 07:13:12 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v8 7/7] sched/fair: Remove the energy margin in feec()
Date:   Fri, 29 Apr 2022 15:11:48 +0100
Message-Id: <20220429141148.181816-8-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429141148.181816-1-vincent.donnefort@arm.com>
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_energy_efficient_cpu() integrates a margin to protect tasks from
bouncing back and forth from a CPU to another. This margin is set as being
6% of the total current energy estimated on the system. This however does
not work for two reasons:

1. The energy estimation is not a good absolute value:

compute_energy() used in feec() is a good estimation for task placement as
it allows to compare the energy with and without a task. The computed
delta will give a good overview of the cost for a certain task placement.
It, however, doesn't work as an absolute estimation for the total energy
of the system. First it adds the contribution to idle CPUs into the
energy, second it mixes util_avg with util_est values. util_avg contains
the near history for a CPU usage, it doesn't tell at all what the current
utilization is. A system that has been quite busy in the near past will
hold a very high energy and then a high margin preventing any task
migration to a lower capacity CPU, wasting energy. It even creates a
negative feedback loop: by holding the tasks on a less efficient CPU, the
margin contributes in keeping the energy high.

2. The margin handicaps small tasks:

On a system where the workload is composed mostly of small tasks (which is
often the case on Android), the overall energy will be high enough to
create a margin none of those tasks can cross. On a Pixel4, a small
utilization of 5% on all the CPUs creates a global estimated energy of 140
joules, as per the Energy Model declaration of that same device. This
means, after applying the 6% margin that any migration must save more than
8 joules to happen. No task with a utilization lower than 40 would then be
able to migrate away from the biggest CPU of the system.

The 6% of the overall system energy was brought by the following patch:

 (eb92692b2544 sched/fair: Speed-up energy-aware wake-ups)

It was previously 6% of the prev_cpu energy. Also, the following one
made this margin value conditional on the clusters where the task fits:

 (8d4c97c105ca sched/fair: Only compute base_energy_pd if necessary)

We could simply revert that margin change to what it was, but the original
version didn't have strong grounds neither and as demonstrated in (1.) the
estimated energy isn't a good absolute value. Instead, removing it
completely. It is indeed, made possible by recent changes that improved
energy estimation comparison fairness (sched/fair: Remove task_util from
effective utilization in feec()) (PM: EM: Increase energy calculation
precision) and task utilization stabilization (sched/fair: Decay task
util_avg during migration)

Without a margin, we could have feared bouncing between CPUs. But running
LISA's eas_behaviour test coverage on three different platforms (Hikey960,
RB-5 and DB-845) showed no issue.

Removing the energy margin enables more energy-optimized placements for a
more energy efficient system.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 83a6eb99d938..97551d7be8a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6887,9 +6887,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	int cpu, best_energy_cpu = prev_cpu, target = -1;
 	struct root_domain *rd = this_rq()->rd;
-	unsigned long base_energy = 0;
+	int cpu, best_energy_cpu, target = -1;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -6921,8 +6920,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		bool compute_prev_delta = false;
-		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -6977,16 +6976,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		/* Compute the 'base' energy of the pd, without @p */
 		eenv_pd_busy_time(&eenv, cpus, p);
-		base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
-		base_energy += base_energy_pd;
+		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
-			if (prev_delta < base_energy_pd)
+			if (prev_delta < base_energy)
 				goto unlock;
-			prev_delta -= base_energy_pd;
+			prev_delta -= base_energy;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -6994,9 +6992,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
-			if (cur_delta < base_energy_pd)
+			if (cur_delta < base_energy)
 				goto unlock;
-			cur_delta -= base_energy_pd;
+			cur_delta -= base_energy;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
@@ -7005,12 +7003,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	}
 	rcu_read_unlock();
 
-	/*
-	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
-	 * least 6% of the energy used by prev_cpu.
-	 */
-	if ((prev_delta == ULONG_MAX) ||
-	    (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
+	if (best_delta < prev_delta)
 		target = best_energy_cpu;
 
 	return target;
-- 
2.25.1

