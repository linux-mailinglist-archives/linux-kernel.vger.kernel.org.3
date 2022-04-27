Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D76511B44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbiD0Ogz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiD0Ogf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:36:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F02643F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:33:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F958143D;
        Wed, 27 Apr 2022 07:33:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.44.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92C323F5A1;
        Wed, 27 Apr 2022 07:33:20 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Subject: [PATCH v7 4/7] sched/fair: Rename select_idle_mask to select_rq_mask
Date:   Wed, 27 Apr 2022 15:33:01 +0100
Message-Id: <20220427143304.3950488-5-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427143304.3950488-1-vincent.donnefort@arm.com>
References: <20220427143304.3950488-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Decouple the name of the per-cpu cpumask select_idle_mask from its usage
in select_idle_[cpu/capacity]() of the CFS run-queue selection
(select_task_rq_fair()).

This is to support the reuse of this cpumask in the Energy Aware
Scheduling (EAS) path (find_energy_efficient_cpu()) of the CFS run-queue
selection.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a62d25ec5b0d..f3f5540bae9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9456,7 +9456,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
 #endif
 
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
-DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
+DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 void __init sched_init(void)
 {
@@ -9505,7 +9505,7 @@ void __init sched_init(void)
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
-		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
+		per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
 			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
 	}
 #endif /* CONFIG_CPUMASK_OFFSTACK */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e0d5b1ba565d..a4ad4d82f217 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5850,7 +5850,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 /* Working cpumask for: load_balance, load_balance_newidle. */
 DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
-DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
+DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -6340,7 +6340,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
@@ -6426,7 +6426,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	task_util = uclamp_task_util(p);
-- 
2.25.1

