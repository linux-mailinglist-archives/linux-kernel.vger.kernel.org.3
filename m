Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2B562ED9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbiGAIuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiGAItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A112A86;
        Fri,  1 Jul 2022 01:49:02 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:10:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBwsg8RawBRGSm2qqytwYxoJwH1eNcWOrqpkRPwbHhE=;
        b=tCYPX+tLt4VvnmIXCdjKUsoKcjEWBWGJVhKtKO03J6KWnEhy3eQ+I5YYRoLKnR6nvSj5Ox
        Si6LNy1CVs6UMsUeZ87Y5g5eFZhl6nwiEdq6WrkNc0+2F+x0ccVxI0t4UIDWWeWMo5VqSu
        bWkX4CsZOJESOXV0Dx9mD5I9tzLuPch96I4Ytsgr8uYwR2OL/2iM035MoVym/jsVbescAI
        PwjabxSZjfNVLnPAowgph3F2U7961r20RJ7PMzoG38k2oAzQBHg3Hiuh15G/NgOoIDh//C
        NacKEqDavNpXHIbU5Idzu/AgyCff08xFex/NUJDAquEuXPe6/o6PaewdTM4jAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656665337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YBwsg8RawBRGSm2qqytwYxoJwH1eNcWOrqpkRPwbHhE=;
        b=8f4zOaLoSDouzPzhtiqtPX+0m0OqZnJlyFzzW7HeO7/4vQ7dphPMjJIPNFDOdTdaj8UNer
        B+pYtJuQ0Vfx8YCA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename select_idle_mask to select_rq_mask
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <250691c7-0e2b-05ab-bedf-b245c11d9400@arm.com>
References: <250691c7-0e2b-05ab-bedf-b245c11d9400@arm.com>
MIME-Version: 1.0
Message-ID: <165660183565.15455.15724315362506003969.tip-bot2@tip-bot2>
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

Commit-ID:     ec4fc801a02d96180c597238fe87141471b70971
Gitweb:        https://git.kernel.org/tip/ec4fc801a02d96180c597238fe87141471b70971
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 23 Jun 2022 11:11:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:17:47 +02:00

sched/fair: Rename select_idle_mask to select_rq_mask

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lkml.kernel.org/r/250691c7-0e2b-05ab-bedf-b245c11d9400@arm.com
---
 kernel/sched/core.c |  4 ++--
 kernel/sched/fair.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c538a0a..dd69e85 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9536,7 +9536,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 void __init sched_init(void)
 {
@@ -9585,7 +9585,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6de09b2..e3f7501 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5894,7 +5894,7 @@ dequeue_throttle:
 
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
 	struct sched_domain_shared *sd_share;
 	struct rq *this_rq = this_rq();
@@ -6482,7 +6482,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	task_util = uclamp_task_util(p);
@@ -6532,7 +6532,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	}
 
 	/*
-	 * per-cpu select_idle_mask usage
+	 * per-cpu select_rq_mask usage
 	 */
 	lockdep_assert_irqs_disabled();
 
@@ -9255,7 +9255,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * take care of it.
 			 */
 			if (p->nr_cpus_allowed != NR_CPUS) {
-				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 
 				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
 				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
