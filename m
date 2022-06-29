Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0EA560AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiF2TsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2TsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:48:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94AC43A1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:48:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B95D1480;
        Wed, 29 Jun 2022 12:48:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0792B3F792;
        Wed, 29 Jun 2022 12:47:59 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 2/7] sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
Date:   Wed, 29 Jun 2022 20:46:27 +0100
Message-Id: <20220629194632.1117723-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629194632.1117723-1-qais.yousef@arm.com>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that the new uclamp rules in regard to migration margin and capacity
pressure are taken into account correctly.

To cater for update_sg_wakeup_stats() user, we add new
{min,max}_capacity_cpu to struct sched_group_capacity since
util_fits_cpu() takes the cpu rather than capacity as an argument.

This includes updating capacity_greater() definition to take cpu as an
argument instead of capacity.

Fixes: a7008c07a568 ("sched/fair: Make task_fits_capacity() consider uclamp restrictions")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c     | 67 ++++++++++++++++++++++++++---------------
 kernel/sched/sched.h    | 13 ++++++--
 kernel/sched/topology.c | 18 ++++++-----
 3 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eecae32a0f6..313437bea5a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -160,7 +160,7 @@ int __weak arch_asym_cpu_priority(int cpu)
  *
  * (default: ~5%)
  */
-#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
+#define capacity_greater(cpu1, cpu2) ((capacity_of(cpu1)) * 1024 > (capacity_of(cpu2)) * 1078)
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -4317,10 +4317,12 @@ static inline int util_fits_cpu(unsigned long util,
 	return fits;
 }
 
-static inline int task_fits_capacity(struct task_struct *p,
-				     unsigned long capacity)
+static inline int task_fits_cpu(struct task_struct *p, int cpu)
 {
-	return fits_capacity(uclamp_task_util(p), capacity);
+	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
+	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+	unsigned long util = task_util_est(p);
+	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -4333,7 +4335,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
+	if (task_fits_cpu(p, cpu_of(rq))) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -8104,7 +8106,7 @@ static int detach_tasks(struct lb_env *env)
 
 		case migrate_misfit:
 			/* This is not a misfit task */
-			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
+			if (task_fits_cpu(p, env->src_cpu))
 				goto next;
 
 			env->imbalance = 0;
@@ -8502,15 +8504,16 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
 
 	sdg->sgc->capacity = capacity;
-	sdg->sgc->min_capacity = capacity;
-	sdg->sgc->max_capacity = capacity;
+	sdg->sgc->min_capacity_cpu = cpu;
+	sdg->sgc->max_capacity_cpu = cpu;
 }
 
 void update_group_capacity(struct sched_domain *sd, int cpu)
 {
-	struct sched_domain *child = sd->child;
 	struct sched_group *group, *sdg = sd->groups;
-	unsigned long capacity, min_capacity, max_capacity;
+	struct sched_domain *child = sd->child;
+	int min_capacity_cpu, max_capacity_cpu;
+	unsigned long capacity;
 	unsigned long interval;
 
 	interval = msecs_to_jiffies(sd->balance_interval);
@@ -8523,8 +8526,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 	}
 
 	capacity = 0;
-	min_capacity = ULONG_MAX;
-	max_capacity = 0;
+	min_capacity_cpu = max_capacity_cpu = cpu;
 
 	if (child->flags & SD_OVERLAP) {
 		/*
@@ -8536,29 +8538,44 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 			unsigned long cpu_cap = capacity_of(cpu);
 
 			capacity += cpu_cap;
-			min_capacity = min(cpu_cap, min_capacity);
-			max_capacity = max(cpu_cap, max_capacity);
+			if (cpu_cap < capacity_of(min_capacity_cpu))
+				min_capacity_cpu = cpu;
+
+			if (cpu_cap > capacity_of(max_capacity_cpu))
+				max_capacity_cpu = cpu;
 		}
 	} else  {
 		/*
 		 * !SD_OVERLAP domains can assume that child groups
 		 * span the current group.
 		 */
+		unsigned long min_capacity = ULONG_MAX;
+		unsigned long max_capacity = 0;
 
 		group = child->groups;
 		do {
 			struct sched_group_capacity *sgc = group->sgc;
+			unsigned long cpu_cap_min = capacity_of(sgc->min_capacity_cpu);
+			unsigned long cpu_cap_max = capacity_of(sgc->max_capacity_cpu);
 
 			capacity += sgc->capacity;
-			min_capacity = min(sgc->min_capacity, min_capacity);
-			max_capacity = max(sgc->max_capacity, max_capacity);
+			if (cpu_cap_min < min_capacity) {
+				min_capacity = cpu_cap_min;
+				min_capacity_cpu = sgc->min_capacity_cpu;
+			}
+
+			if (cpu_cap_max > max_capacity) {
+				max_capacity = cpu_cap_max;
+				max_capacity_cpu = sgc->max_capacity_cpu;
+			}
+
 			group = group->next;
 		} while (group != child->groups);
 	}
 
 	sdg->sgc->capacity = capacity;
-	sdg->sgc->min_capacity = min_capacity;
-	sdg->sgc->max_capacity = max_capacity;
+	sdg->sgc->min_capacity_cpu = min_capacity_cpu;
+	sdg->sgc->max_capacity_cpu = max_capacity_cpu;
 }
 
 /*
@@ -8902,7 +8919,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * internally or be covered by avg_load imbalance (eventually).
 	 */
 	if (sgs->group_type == group_misfit_task &&
-	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
+	    (!capacity_greater(env->dst_cpu, sg->sgc->max_capacity_cpu) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
@@ -8986,7 +9003,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
 	    (sgs->group_type <= group_fully_busy) &&
-	    (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
+	    (capacity_greater(sg->sgc->min_capacity_cpu, env->dst_cpu)))
 		return false;
 
 	return true;
@@ -9108,7 +9125,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	/* Check if task fits in the group */
 	if (sd->flags & SD_ASYM_CPUCAPACITY &&
-	    !task_fits_capacity(p, group->sgc->max_capacity)) {
+	    !task_fits_cpu(p, group->sgc->max_capacity_cpu)) {
 		sgs->group_misfit_task_load = 1;
 	}
 
@@ -9159,7 +9176,8 @@ static bool update_pick_idlest(struct sched_group *idlest,
 
 	case group_misfit_task:
 		/* Select group with the highest max capacity */
-		if (idlest->sgc->max_capacity >= group->sgc->max_capacity)
+		if (capacity_of(idlest->sgc->max_capacity_cpu) >=
+		    capacity_of(group->sgc->max_capacity_cpu))
 			return false;
 		break;
 
@@ -9290,7 +9308,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_misfit_task:
 		/* Select group with the highest max capacity */
-		if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
+		if (capacity_of(local->sgc->max_capacity_cpu) >=
+		    capacity_of(idlest->sgc->max_capacity_cpu))
 			return NULL;
 		break;
 
@@ -9860,7 +9879,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * average load.
 		 */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
+		    !capacity_greater(env->dst_cpu, i) &&
 		    nr_running == 1)
 			continue;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 02c970501295..9599d2eea3e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1766,8 +1766,8 @@ struct sched_group_capacity {
 	 * for a single CPU.
 	 */
 	unsigned long		capacity;
-	unsigned long		min_capacity;		/* Min per-CPU capacity in group */
-	unsigned long		max_capacity;		/* Max per-CPU capacity in group */
+	int			min_capacity_cpu;
+	int			max_capacity_cpu;
 	unsigned long		next_update;
 	int			imbalance;		/* XXX unrelated to capacity but shared group state */
 
@@ -2988,6 +2988,15 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 #else /* CONFIG_UCLAMP_TASK */
+static inline unsigned long uclamp_eff_value(struct task_struct *p,
+					     enum uclamp_id clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+
+	return SCHED_CAPACITY_SCALE;
+}
+
 static inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 				  struct task_struct *p)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..25e6a346ad70 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -979,8 +979,8 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	 */
 	sg_span = sched_group_span(sg);
 	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
-	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
-	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
+	sg->sgc->min_capacity_cpu = cpumask_first(sg_span);
+	sg->sgc->max_capacity_cpu = cpumask_first(sg_span);
 }
 
 static struct sched_domain *
@@ -1178,6 +1178,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 {
 	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
 	struct sched_domain *child = sd->child;
+	struct cpumask *sg_span;
 	struct sched_group *sg;
 	bool already_visited;
 
@@ -1186,6 +1187,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 
 	sg = *per_cpu_ptr(sdd->sg, cpu);
 	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
+	sg_span = sched_group_span(sg);
 
 	/* Increase refcounts for claim_allocations: */
 	already_visited = atomic_inc_return(&sg->ref) > 1;
@@ -1197,17 +1199,17 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 		return sg;
 
 	if (child) {
-		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
-		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		cpumask_copy(sg_span, sched_domain_span(child));
+		cpumask_copy(group_balance_mask(sg), sg_span);
 		sg->flags = child->flags;
 	} else {
-		cpumask_set_cpu(cpu, sched_group_span(sg));
+		cpumask_set_cpu(cpu, sg_span);
 		cpumask_set_cpu(cpu, group_balance_mask(sg));
 	}
 
-	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sched_group_span(sg));
-	sg->sgc->min_capacity = SCHED_CAPACITY_SCALE;
-	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
+	sg->sgc->capacity = SCHED_CAPACITY_SCALE * cpumask_weight(sg_span);
+	sg->sgc->min_capacity_cpu = cpumask_first(sg_span);
+	sg->sgc->max_capacity_cpu = cpumask_first(sg_span);
 
 	return sg;
 }
-- 
2.25.1

