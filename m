Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B36562ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiGAItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiGAItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85391262B;
        Fri,  1 Jul 2022 01:48:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:10:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZcFvGeiS6wY4PWTdQBRFYqnlvmdaRSGng4TPww04LoI=;
        b=3aiv62k1D5hncQtlQVKKm7I8hTST2o8Tqj3+FZBY3zRkvSF4HqD0IaDTWEjssQsL1y5Xtf
        +VrbfwyoFR9DbdLt5Oig4SimpeTUMKlRADXPxft13PTpdvnWMbZujevogjh0rOYrXhhq4P
        DPZh3ZX1RmQdiLOyXaZSSPDVk9Pq+beXwqJoCnUejw5uugurS98jgfxwLwbi55snR3MsAv
        Ud5t6Bgbtwo1Uf9U+rJnKO8iC4/OJIrKUNO73zPahguRUbqwK8A5H93hGo/UG/ixm56/Cb
        SN4Iwpzc+1zJkB+/Q37DMkLJw4dKMRdX4LvwylS/2n9n5FottzF8p1Ahjc44yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZcFvGeiS6wY4PWTdQBRFYqnlvmdaRSGng4TPww04LoI=;
        b=XCRKeifCmBoa2q8RlRXYSEhQSVeKpqIUJ3jp50Yw2j4o7yzmNmp4VXqSumf5AKiWUC0Ryv
        SQaObV9/u6nEzZBg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove the energy margin in feec()
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621090414.433602-8-vdonnefort@google.com>
References: <20220621090414.433602-8-vdonnefort@google.com>
MIME-Version: 1.0
Message-ID: <165660183266.15455.13843699448813066343.tip-bot2@tip-bot2>
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

Commit-ID:     b812fc9768e0048582c8e18d7b66559c1758dde1
Gitweb:        https://git.kernel.org/tip/b812fc9768e0048582c8e18d7b66559c1758dde1
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 21 Jun 2022 10:04:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:17:48 +02:00

sched/fair: Remove the energy margin in feec()

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
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/20220621090414.433602-8-vdonnefort@google.com
---
 kernel/sched/fair.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ef7e0a..a78d2e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6868,9 +6868,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -6902,8 +6901,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
 		bool compute_prev_delta = false;
-		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
+		unsigned long base_energy;
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -6961,17 +6960,16 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 		eenv_pd_busy_time(&eenv, cpus, p);
 		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);
-		base_energy += base_energy_pd;
+		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
 		if (compute_prev_delta) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
-			if (prev_delta < base_energy_pd)
+			if (prev_delta < base_energy)
 				goto unlock;
-			prev_delta -= base_energy_pd;
+			prev_delta -= base_energy;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -6980,9 +6978,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
-			if (cur_delta < base_energy_pd)
+			if (cur_delta < base_energy)
 				goto unlock;
-			cur_delta -= base_energy_pd;
+			cur_delta -= base_energy;
 			if (cur_delta < best_delta) {
 				best_delta = cur_delta;
 				best_energy_cpu = max_spare_cap_cpu;
@@ -6991,12 +6989,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
