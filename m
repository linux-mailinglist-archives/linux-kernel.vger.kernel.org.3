Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA055274B4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 01:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiENXzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 19:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiENXzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 19:55:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C858D13E05
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 16:55:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5232C23A;
        Sat, 14 May 2022 16:55:16 -0700 (PDT)
Received: from airbuntu (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC1C3F73D;
        Sat, 14 May 2022 16:55:14 -0700 (PDT)
Date:   Sun, 15 May 2022 00:55:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220514235513.jm7ul2y6uddj6eh2@airbuntu>
References: <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
 <20220427105844.otru4yohja4s23ye@wubuntu>
 <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
 <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
 <CAB8ipk--Y8HxetcmUhBmtWq6Mmd726QmDbcbibGLERJw_PUqkQ@mail.gmail.com>
 <20220510145625.t5py7atlhgojsfyf@wubuntu>
 <37357c86-bab7-d0c7-88d0-ace63ccdb6c8@arm.com>
 <20220510184436.fdgzzcfqqevinx5p@wubuntu>
 <0505936e-3746-4623-a967-103a0158bfbd@arm.com>
 <CAB8ipk8RUsxYs6JdeMeUPADQRNqT=Jqz15ecwbzbf0RHUDqOXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk8RUsxYs6JdeMeUPADQRNqT=Jqz15ecwbzbf0RHUDqOXg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/22 23:01, Xuewen Yan wrote:
> On Wed, May 11, 2022 at 6:03 AM Lukasz Luba <lukasz.luba@arm.com> wrote:

[...]

> > True, but this is a CFS 'world' and the update path is part of load
> > balance. Your proposed code which sets the new
> > 'rq->cpu_capacity_inverted' is run there, which might have some
> > delays.
> 
> Yes, that's exactly what I'm worried about.

Hmm. In Android world, where we are concerned here, CFS is a first class
citizen. If we have issues in updating capacities there, this might be hurting
other non-RT related use cases too. So something to ponder in general.

Anyways. It's a very valid concern and I agree with it too. We can do better.
See below.

[...]

> > Capacity of other CPU might also be reduced and capacity_orig is not
> > reflecting that. My gut feeling tells me that this capacity_orig
> > assumption might be too optimistic for some platforms.
> 
> In unisoc platform with 3 clusters(little/mid/big), there are cases
> that middle core and big core are throttled at the same time.

Okay. I might have misunderstood you before, but I thought medium cores don't
suffer any meaningful thermal pressure.

[...]

> Okay, I could push patch v2 later. Maybe we can continue to discuss
> this topic based on v2.

Please do.

I have scratched my head and played around implementing the generic solution
using additional cpumasks. If you fancy testing it, that'd be great! I have
tested it very lightly only. If you like it and no one shouts it's terrible, we
can shape it further.

--->8---

From 625209b09bd0eb0eff07fba109e80102c5983c48 Mon Sep 17 00:00:00 2001
From: Qais Yousef <qais.yousef@arm.com>
Date: Fri, 13 May 2022 12:01:15 +0100
Subject: [PATCH] sched/rt: Support multi-criterion fitness search for
 lowest_rq

We have multiple criterion that need to be taken into account when
searching for best fitting lowest_irq.

On big.LITTLE systems, when uclamp is used, we use
rt_task_fits_capacity() to enforce going to a larger CPU if the task's
uclamp_min requested that. But we still would have fallen back to
priority based search if no fitting CPU was found.

There are reports now that severe thermal pressure could make the big
CPUs throttled to the point where they are less performant than the
mediums (capacity inversion).

To cater for that, we need to take into account thermal pressure
reducing the capacity of the CPU in the fitness search.

Note that this could introduce another set of problems if not careful.

For instance if an RT task has uclamp_min = 1024, a small amount of
thermal pressure could mean no CPU will fit this task; which means the
hint will become less effective. The big CPU still provides the max
performance level (which is what uclamp_min=1024 is asking for) so we
still better place it there even if thermal conditions mean we lost some
performance.

This corner case can happen at any boundary conditions for littles,
mediums or bigs. For example if an RT task has uclamp_min
= capacity_orig_of(medium_cpu), then any small thermal pressure will
prevent placing it there and force it to big CPUs instead. Which is not
the desired outcome if no big CPU is available. We should still fallback
to the medium CPU in this case.

This dictates a more complex search method to enable multi-level
fallback.

That is:

	1. If rt_task_fits_capacity_thermal() returns true, we should
	   pick this lowest_mask.
	2. If (1) failed for all priorities, we should fallback to
	   rt_task_fits_capacity() lowest_mask if it found any.
	3. If (1) and (2) failed, we should fallback to the lowest_mask
	   based on lowest priority rq as usual.

We teach cpupri_find_fitness() to do a multi-level search in a single
loop. This is at the cost of allocating more cpumasks for each fitness
criteria/level.

At the moment, the only users are heterogeneous systems which have low
CPU count and this should not lead to a big waste of memory.

The priority of fitness_fn is highest starting from 0.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/cpupri.c | 118 ++++++++++++++++++++++++++++++++----------
 kernel/sched/cpupri.h |  14 +++--
 kernel/sched/rt.c     |  66 ++++++++++++++++++++---
 3 files changed, 162 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index fa9ce9d83683..cfe56bd4e555 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -120,7 +120,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 int cpupri_find(struct cpupri *cp, struct task_struct *p,
 		struct cpumask *lowest_mask)
 {
-	return cpupri_find_fitness(cp, p, lowest_mask, NULL);
+	return cpupri_find_fitness(cp, p, lowest_mask, NULL, NULL);
 }
 
 /**
@@ -142,13 +142,24 @@ int cpupri_find(struct cpupri *cp, struct task_struct *p,
  */
 int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		struct cpumask *lowest_mask,
-		bool (*fitness_fn)(struct task_struct *p, int cpu))
+		cpumask_var_t fitness_mask[], fitness_fn_t fitness_fn[])
 {
 	int task_pri = convert_prio(p->prio);
-	int idx, cpu;
+	bool fallback_found[NUM_FITNESS_FN];
+	int idx, cpu, fn_idx;
 
 	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
 
+	if (NUM_FITNESS_FN && fitness_fn) {
+		/*
+		 * Clear the masks so that we can save a fallback hit in them
+		 */
+		for (fn_idx = 0; fn_idx < NUM_FITNESS_FN; fn_idx++) {
+			cpumask_clear(fitness_mask[fn_idx]);
+			fallback_found[fn_idx] = false;
+		}
+	}
+
 	for (idx = 0; idx < task_pri; idx++) {
 
 		if (!__cpupri_find(cp, p, lowest_mask, idx))
@@ -157,41 +168,94 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 		if (!lowest_mask || !fitness_fn)
 			return 1;
 
-		/* Ensure the capacity of the CPUs fit the task */
+		/*
+		 * We got a hit, save in our fallback masks that are empty.
+		 *
+		 * Note that we use fitness_mask[0] to save the fallback for
+		 * when all fitness_fns fail to find a suitable CPU.
+		 *
+		 * We use lowest_mask to store the results of fitness_fn[0]
+		 * directly.
+		 */
+		if (!fallback_found[0]) {
+				cpumask_copy(fitness_mask[0], lowest_mask);
+				fallback_found[0] = true;
+		}
+		for (fn_idx = 1; fn_idx < NUM_FITNESS_FN; fn_idx++) {
+
+			/*
+			 * We just need one valid fallback at highest level
+			 * (smallest fn_idx). We don't care about checking for
+			 * fallback beyond this once we found one.
+			 */
+			if (fallback_found[fn_idx])
+				break;
+
+			cpumask_copy(fitness_mask[fn_idx], lowest_mask);
+		}
+
+		/*
+		 * fintness_fn[0] hit always terminates the search immediately,
+		 * so do that first.
+		 */
 		for_each_cpu(cpu, lowest_mask) {
-			if (!fitness_fn(p, cpu))
+			if (!fitness_fn[0](p, cpu))
 				cpumask_clear_cpu(cpu, lowest_mask);
 		}
 
 		/*
-		 * If no CPU at the current priority can fit the task
-		 * continue looking
+		 * Stop searching as soon as fitness_fn[0] is happy with the
+		 * results.
 		 */
-		if (cpumask_empty(lowest_mask))
-			continue;
+		if (!cpumask_empty(lowest_mask))
+			return 1;
 
-		return 1;
+		/*
+		 * Find a fallback CPU for the other fitness_fns.
+		 *
+		 * Only do this once. As soon as we get a valid fallback mask,
+		 * we'll remember it so that when fitness_fn[0] fails for all
+		 * priorities, we'll return this fallback mask.
+		 *
+		 * Remember that we use fitnss_mask[0] to store our fallback
+		 * results for when all fitness_fns fail.
+		 */
+		for (fn_idx = 1; fn_idx < NUM_FITNESS_FN; fn_idx++) {
+
+			/*
+			 * We just need one valid fallback at highest level
+			 * (smallest fn_idx). We don't care about checking for
+			 * fallback beyond this once we found one.
+			 */
+			if (fallback_found[fn_idx])
+				break;
+
+			for_each_cpu(cpu, fitness_mask[fn_idx]) {
+				if (!fitness_fn[fn_idx](p, cpu))
+					cpumask_clear_cpu(cpu, fitness_mask[fn_idx]);
+			}
+
+			if (!cpumask_empty(fitness_mask[fn_idx]))
+				fallback_found[fn_idx] = true;
+		}
+	}
+
+	for (fn_idx = 1; fn_idx < NUM_FITNESS_FN; fn_idx++) {
+		if (fallback_found[fn_idx]) {
+			cpumask_copy(lowest_mask, fitness_mask[fn_idx]);
+			return 1;
+		}
 	}
 
 	/*
-	 * If we failed to find a fitting lowest_mask, kick off a new search
-	 * but without taking into account any fitness criteria this time.
-	 *
-	 * This rule favours honouring priority over fitting the task in the
-	 * correct CPU (Capacity Awareness being the only user now).
-	 * The idea is that if a higher priority task can run, then it should
-	 * run even if this ends up being on unfitting CPU.
-	 *
-	 * The cost of this trade-off is not entirely clear and will probably
-	 * be good for some workloads and bad for others.
-	 *
-	 * The main idea here is that if some CPUs were over-committed, we try
-	 * to spread which is what the scheduler traditionally did. Sys admins
-	 * must do proper RT planning to avoid overloading the system if they
-	 * really care.
+	 * No fallback from any of the fitness_fns, fallback to priority based
+	 * lowest_mask which we store at fitness_mask[0].
 	 */
-	if (fitness_fn)
-		return cpupri_find(cp, p, lowest_mask);
+
+	if (fallback_found[0]) {
+		cpumask_copy(lowest_mask, fitness_mask[0]);
+		return 1;
+	}
 
 	return 0;
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index d6cba0020064..1feb6324cf24 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -17,12 +17,20 @@ struct cpupri {
 	int			*cpu_to_pri;
 };
 
+#ifdef CONFIG_UCLAMP_TASK
+#define NUM_FITNESS_FN	2
+#else
+#define NUM_FITNESS_FN	0
+#endif
+
+typedef bool (*fitness_fn_t)(struct task_struct *p, int cpu);
+
 #ifdef CONFIG_SMP
 int  cpupri_find(struct cpupri *cp, struct task_struct *p,
 		 struct cpumask *lowest_mask);
-int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
-			 struct cpumask *lowest_mask,
-			 bool (*fitness_fn)(struct task_struct *p, int cpu));
+int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
+		struct cpumask *lowest_mask,
+		cpumask_var_t fitness_mask[], fitness_fn_t fitness_fn[]);
 void cpupri_set(struct cpupri *cp, int cpu, int pri);
 int  cpupri_init(struct cpupri *cp);
 void cpupri_cleanup(struct cpupri *cp);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a32c46889af8..125b9d360aab 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -452,7 +452,8 @@ static inline int on_rt_rq(struct sched_rt_entity *rt_se)
  * Note that uclamp_min will be clamped to uclamp_max if uclamp_min
  * > uclamp_max.
  */
-static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
+static inline bool __rt_task_fits_capacity(struct task_struct *p, int cpu,
+					   bool thermal)
 {
 	unsigned int min_cap;
 	unsigned int max_cap;
@@ -467,10 +468,39 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 
 	cpu_cap = capacity_orig_of(cpu);
 
+	if (thermal)
+		cpu_cap -= arch_scale_thermal_pressure(cpu);
+
 	return cpu_cap >= min(min_cap, max_cap);
 }
-#else
+
+static inline bool rt_task_fits_capacity_thermal(struct task_struct *p, int cpu)
+{
+	return __rt_task_fits_capacity(p, cpu, true);
+}
+
 static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
+{
+	return __rt_task_fits_capacity(p, cpu, false);
+}
+
+fitness_fn_t fitness_fn[NUM_FITNESS_FN] = {
+	rt_task_fits_capacity_thermal,
+	rt_task_fits_capacity
+};
+
+static inline bool rt_task_fits_cpu(struct task_struct *p, int cpu)
+{
+	/*
+	 * fitness_fn[0] is the ultimate best choice. If it fails, we should
+	 * assume we need to try again/harder to meet this criteria.
+	 */
+	return fitness_fn[0](p, cpu);
+}
+
+#else
+fitness_fn_t *fitness_fn = NULL;
+static inline bool rt_task_fits_cpu(struct task_struct *p, int cpu)
 {
 	return true;
 }
@@ -1591,14 +1621,14 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	       unlikely(rt_task(curr)) &&
 	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
 
-	if (test || !rt_task_fits_capacity(p, cpu)) {
+	if (test || !rt_task_fits_cpu(p, cpu)) {
 		int target = find_lowest_rq(p);
 
 		/*
 		 * Bail out if we were forcing a migration to find a better
 		 * fitting CPU but our search failed.
 		 */
-		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
+		if (!test && target != -1 && !rt_task_fits_cpu(p, target))
 			goto out_unlock;
 
 		/*
@@ -1823,6 +1853,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 }
 
 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);
+static DEFINE_PER_CPU(cpumask_var_t *, local_cpu_fitness_mask);
 
 static int find_lowest_rq(struct task_struct *task)
 {
@@ -1843,11 +1874,12 @@ static int find_lowest_rq(struct task_struct *task)
 	 * If we're on asym system ensure we consider the different capacities
 	 * of the CPUs when searching for the lowest_mask.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (static_branch_unlikely(&sched_asym_cpucapacity) && NUM_FITNESS_FN) {
 
+		cpumask_var_t *fitness_mask = __this_cpu_read(local_cpu_fitness_mask);
 		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
-					  rt_task_fits_capacity);
+					  fitness_mask, fitness_fn);
 	} else {
 
 		ret = cpupri_find(&task_rq(task)->rd->cpupri,
@@ -2460,6 +2492,25 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	rt_queue_pull_task(rq);
 }
 
+void __init init_sched_rt_fitness_mask(int cpu)
+{
+	cpumask_var_t *fitness_mask_array;
+	unsigned int i;
+
+	if (!NUM_FITNESS_FN)
+		return;
+
+	fitness_mask_array = kcalloc_node(NUM_FITNESS_FN, sizeof(cpumask_var_t),
+					  GFP_KERNEL, cpu_to_node(cpu));
+
+	per_cpu(local_cpu_fitness_mask, cpu) = fitness_mask_array;
+
+	for (i = 0; i < NUM_FITNESS_FN; i++) {
+		zalloc_cpumask_var_node(&fitness_mask_array[i], GFP_KERNEL,
+					cpu_to_node(cpu));
+	}
+}
+
 void __init init_sched_rt_class(void)
 {
 	unsigned int i;
@@ -2467,6 +2518,9 @@ void __init init_sched_rt_class(void)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
 					GFP_KERNEL, cpu_to_node(i));
+
+		if (static_branch_unlikely(&sched_asym_cpucapacity))
+			init_sched_rt_fitness_mask(i);
 	}
 }
 #endif /* CONFIG_SMP */
-- 
2.25.1

--->8---

Thanks both!

--
Qais Yousef
