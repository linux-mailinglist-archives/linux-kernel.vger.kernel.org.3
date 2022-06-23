Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F6555765C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiFWJLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFWJLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:11:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1A535A85
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:11:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F1F12FC;
        Thu, 23 Jun 2022 02:11:17 -0700 (PDT)
Received: from [192.168.178.35] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4108F3F792;
        Thu, 23 Jun 2022 02:11:15 -0700 (PDT)
Message-ID: <250691c7-0e2b-05ab-bedf-b245c11d9400@arm.com>
Date:   Thu, 23 Jun 2022 11:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v11 4/7] sched/fair: Rename select_idle_mask to
 select_rq_mask
Content-Language: en-US
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev,
        kernel-team@android.com, Lukasz Luba <lukasz.luba@arm.com>
References: <20220621090414.433602-1-vdonnefort@google.com>
 <20220621090414.433602-5-vdonnefort@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220621090414.433602-5-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 11:04, Vincent Donnefort wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>

https://lkml.kernel.org/r/202206221253.ZVyGQvPX-lkp@intel.com discovered
that this patch doesn't build anymore (on tip sched/core or linux-next)
because of commit f5b2eeb499910 ("sched/fair: Consider CPU affinity when
allowing NUMA imbalance in find_idlest_group()").

New version of [PATCH v11 4/7] sched/fair: Rename select_idle_mask to
select_rq_mask below.

-- >8 --

Decouple the name of the per-cpu cpumask select_idle_mask from its usage
in select_idle_[cpu/capacity]() of the CFS run-queue selection
(select_task_rq_fair()).

This is to support the reuse of this cpumask in the Energy Aware
Scheduling (EAS) path (find_energy_efficient_cpu()) of the CFS run-queue
selection.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/core.c |  4 ++--
 kernel/sched/fair.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 68bd9cd7aeb3..618cdb38ba11 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9508,7 +9508,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 void __init sched_init(void)
 {
@@ -9557,7 +9557,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f81bad489a7e..e0af847320b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5894,7 +5894,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -6384,7 +6384,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
@@ -6470,7 +6470,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	task_util = uclamp_task_util(p);
@@ -6520,7 +6520,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	}
 
 	/*
-	 * per-cpu select_idle_mask usage
+	 * per-cpu select_rq_mask usage
 	 */
 	lockdep_assert_irqs_disabled();
 
@@ -9243,7 +9243,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * take care of it.
 			 */
 			if (p->nr_cpus_allowed != NR_CPUS) {
-				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 
 				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
 				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
-- 
2.25.1
