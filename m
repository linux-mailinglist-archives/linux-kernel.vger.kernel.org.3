Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56C548C80A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355005AbiALQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:16:27 -0500
Received: from foss.arm.com ([217.140.110.172]:33030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355064AbiALQO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:14:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7EA1FB;
        Wed, 12 Jan 2022 08:14:57 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.10.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8DE63F774;
        Wed, 12 Jan 2022 08:14:55 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 7/7] sched/fair: Remove the energy margin in feec()
Date:   Wed, 12 Jan 2022 16:12:30 +0000
Message-Id: <20220112161230.836326-8-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112161230.836326-1-vincent.donnefort@arm.com>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_energy_efficient_cpu() integrates a margin to protect tasks from
bouncing back and forth from a CPU to another. This margin is set as being
6% of the total current energy estimated on the system. This however does
not work for two reasons:

1. The energy estimation is not a good absolute value:

The function, compute_energy() used in feec() is a good estimation for
task placement as it allows to compare the energy with and without a task.
The computed delta will give a good overview of the cost for a certain
task placement. It, however, doesn't work as an absolute estimation for
the total energy of the system. First it adds the contribution to idle
CPUs into the energy, second it mixes util_avg with util_est values.
util_avg represents integrates the near history for a CPU usage,
it doesn't tell at all what the current utilization is. A system that has
been quite busy in the near past will hold a very high energy and then a
high margin preventing any task migration to a lower capacity CPU, wasting
energy. It even creates a negative feedback loop: by holding the tasks on
a less efficient CPU, the margin contributes in keeping the energy high.

2. The margin handicaps small tasks:

On a system where the workload is composed mostly of small tasks (which is
often the case on Android), the overall energy will be high enough to
create a margin none of those tasks can cross. e.g. On a Pixel4, a small
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
RB-5 and DB-845) showed no issue and even fixed previously known failures.

Removing the energy margin enables more energy-optimized placements for a
more energy efficient system.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efb2e0739015..c8d100decbae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6694,7 +6694,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
 	int cpu, best_energy_cpu = prev_cpu, target = -1;
 	unsigned long cpu_cap, cpu_thermal_cap, util;
-	unsigned long base_energy = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 
@@ -6724,8 +6723,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
 		bool compute_prev_delta = false;
-		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -6778,9 +6777,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		/* Compute the 'base' energy of the pd, without @p */
 		busy_time = get_pd_busy_time(p, cpus, pd_cap);
 		max_util = get_pd_max_util(p, -1, cpus, cpu_thermal_cap);
-		base_energy_pd = compute_energy(pd, max_util, busy_time,
-						cpu_thermal_cap);
-		base_energy += base_energy_pd;
+		base_energy = compute_energy(pd, max_util, busy_time,
+					     cpu_thermal_cap);
 
 		/* Take task into account for the next energy computations */
 		busy_time = min(pd_cap, busy_time + tsk_busy_time);
@@ -6791,9 +6789,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 						   cpu_thermal_cap);
 			prev_delta = compute_energy(pd, max_util, busy_time,
 						    cpu_thermal_cap);
-			if (prev_delta < base_energy_pd)
+			if (prev_delta < base_energy)
 				goto unlock;
-			prev_delta -= base_energy_pd;
+			prev_delta -= base_energy;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -6803,9 +6801,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 						   cpu_thermal_cap);
 			cur_delta = compute_energy(pd, max_util, busy_time,
 						   cpu_thermal_cap);
-			if (cur_delta < base_energy_pd)
+			if (cur_delta < base_energy)
 				goto unlock;
-			cur_delta -= base_energy_pd;
+			cur_delta -= base_energy;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
@@ -6814,12 +6812,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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

