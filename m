Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BE4FA8C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiDINy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiDINyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:54:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FAE9E9DA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:52:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z16so10789341pfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7+54fI+N/qxFO9vVcmvSii7KGTDscwJajxT6dy70+I=;
        b=yMQgNpI491m5t6rJlJqTP6eEpEfw9kFNo6NybotzpFtC/+uAMcddh94rK6EtY7Toy2
         pKbFfhLb5/nhzmEfRZxi+FWSgXm9iKM4Qu9r7QnrFT+i31VOUTAV6a+xZDsGwMUXGzDC
         x5z5I0lMtP5vj7iXtvgb0ZtN8Fu6snJorK0seiXMwF2WtP0FlrkK7RkV2pforQCVG/LP
         C8ihhnbu8cWeezxBIhcYe8PripjmAr9NB2Ld4fcttYoaAKr6dA4TRTs9VeYtp4nMYWHx
         /MLy73hsu8FeHSe2ZnotK+1aj63jBOXnNxWgNdFKnTIQROxAZIFeeafh7F5iTN3BWb5c
         1oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7+54fI+N/qxFO9vVcmvSii7KGTDscwJajxT6dy70+I=;
        b=lhBOF0qB8TlTOSCteD/ACijhBdMgUg5++xmMz33H5CjbaWZR3bW/GaMiERt9quZQdN
         lJFx4byC6TA2nSD4vVuS5NIVDpD+44i7/bIF4JV43MoUcwxBzQ1rDa+5T+WlU0kTD99K
         07wZwa5AbMTCHCttzrtQQ1ZIH8EXt0CWpKGiBpHJuOw37jplJhAApAsfEzwlcuMnS1F1
         rMArGibSDkOZQtsz1BmHm0RykefGLmSVO8pywIw7Nbd9SaNYA2H9UhF72SFkLlz06ngD
         7zWetYyb4EI9+tVO20Szh6KIaclZK7T+jHQwI9Mmvbz1aOBZ9UsNbFheOjYJOrSM4VNv
         V53g==
X-Gm-Message-State: AOAM530gKepaWkWBcJlOXslR+IlkJP7GCBFjKz5sJGH7hON1/vGCmpU7
        z2vqiYR25Y1W8Dj5bdau6KJJqA==
X-Google-Smtp-Source: ABdhPJwaVYjNyA9FFrUGrQGdP4uz96NnRB5HjSo3iATJSZ3p7plrCXURT/NK0dgwo8X30UaTeptgqg==
X-Received: by 2002:a65:5a82:0:b0:386:f95:40fd with SMTP id c2-20020a655a82000000b003860f9540fdmr19931402pgt.256.1649512329068;
        Sat, 09 Apr 2022 06:52:09 -0700 (PDT)
Received: from n227-010-195.byted.org ([121.30.179.44])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm30303357pfe.153.2022.04.09.06.52.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:52:08 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     joshdon@google.com, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [RFC v2 2/2] sched/fair: introduce sched-idle balance
Date:   Sat,  9 Apr 2022 21:51:04 +0800
Message-Id: <20220409135104.3733193-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The periodic (normal/idle) balancing is regulated by intervals on each
sched-domain and the intervals can prevent the unoccupied cpus from
pulling the non-idle tasks. While the newly-idle balancing is triggered
only when the cpus become really idle, and sadly the sched-idle cpus
are not the case. There are also some other constrains to get in the
middle of the way of making unoccupied cpus busier.

Given the above, the sched-idle balancing is an extension to existing
load balance mechanisms on the unoccupied cpus to let them fast pull
non-idle tasks from the overloaded cpus. This is achieved by:

  - Quit early in periodic load balancing if the cpu becomes
    no idle anymore. This is similar to what we do in newly-
    idle case in which we stop balancing once we got some
    work to do (althrough this is partly due to newly-idle
    can be very frequent, while periodic balancing is not).

  - The newly-idle balancing will try harder to pull the non-
    idle tasks if overloaded cpus exist.

In this way we will fill the unoccupied cpus more proactively to get
more cpu capacity for the non-idle tasks.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/idle.h |   1 +
 kernel/sched/core.c        |   1 +
 kernel/sched/fair.c        | 145 ++++++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h       |   2 +
 4 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index d73d314d59c6..50ec5c770f85 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -8,6 +8,7 @@ enum cpu_idle_type {
 	CPU_IDLE,
 	CPU_NOT_IDLE,
 	CPU_NEWLY_IDLE,
+	CPU_SCHED_IDLE,
 	CPU_MAX_IDLE_TYPES
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a372881f8eaf..c05c39541c4e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9495,6 +9495,7 @@ void __init sched_init(void)
 		rq->wake_stamp = jiffies;
 		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
+		rq->sched_idle_balance = 0;
 		rq->overloaded = 0;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbeb05321615..5fca3bb98273 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -456,6 +456,21 @@ static int se_is_idle(struct sched_entity *se)
 	return cfs_rq_is_idle(group_cfs_rq(se));
 }
 
+/* Is this an idle task */
+static int task_h_idle(struct task_struct *p)
+{
+	struct sched_entity *se = &p->se;
+
+	if (task_has_idle_policy(p))
+		return 1;
+
+	for_each_sched_entity(se)
+		if (cfs_rq_is_idle(cfs_rq_of(se)))
+			return 1;
+
+	return 0;
+}
+
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
 #define for_each_sched_entity(se) \
@@ -508,6 +523,11 @@ static int se_is_idle(struct sched_entity *se)
 	return 0;
 }
 
+static inline int task_h_idle(struct task_struct *p)
+{
+	return task_has_idle_policy(p);
+}
+
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
 static __always_inline
@@ -7039,6 +7059,16 @@ static inline bool cfs_rq_overloaded(struct rq *rq)
 	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
 }
 
+static inline bool cfs_rq_busy(struct rq *rq)
+{
+	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running == 1;
+}
+
+static inline bool need_pull_cfs_task(struct rq *rq)
+{
+	return rq->cfs.h_nr_running == rq->cfs.idle_h_nr_running;
+}
+
 /*
  * Use locality-friendly rq->overloaded to cache the status of the rq
  * to minimize the heavy cost on LLC shared data.
@@ -7837,6 +7867,22 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (kthread_is_per_cpu(p))
 		return 0;
 
+	if (unlikely(task_h_idle(p))) {
+		/*
+		 * Disregard hierarchically idle tasks during sched-idle
+		 * load balancing.
+		 */
+		if (env->idle == CPU_SCHED_IDLE)
+			return 0;
+	} else if (!static_branch_unlikely(&sched_asym_cpucapacity)) {
+		/*
+		 * It's not gonna help if stacking non-idle tasks on one
+		 * cpu while leaving some idle.
+		 */
+		if (cfs_rq_busy(env->src_rq) && !need_pull_cfs_task(env->dst_rq))
+			return 0;
+	}
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
@@ -10337,6 +10383,68 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 }
 
 /*
+ * The sched-idle balancing tries to make full use of cpu capacity
+ * for non-idle tasks by pulling them for the unoccupied cpus from
+ * the overloaded ones.
+ *
+ * Return 1 if pulled successfully, 0 otherwise.
+ */
+static int sched_idle_balance(struct rq *dst_rq)
+{
+	struct sched_domain *sd;
+	struct task_struct *p = NULL;
+	int dst_cpu = cpu_of(dst_rq), cpu;
+
+	sd = rcu_dereference(per_cpu(sd_llc, dst_cpu));
+	if (unlikely(!sd))
+		return 0;
+
+	if (!atomic_read(&sd->shared->nr_overloaded))
+		return 0;
+
+	for_each_cpu_wrap(cpu, sdo_mask(sd->shared), dst_cpu + 1) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		struct lb_env env;
+
+		if (cpu == dst_cpu || !cfs_rq_overloaded(rq) ||
+		    READ_ONCE(rq->sched_idle_balance))
+			continue;
+
+		WRITE_ONCE(rq->sched_idle_balance, 1);
+		rq_lock_irqsave(rq, &rf);
+
+		env = (struct lb_env) {
+			.sd		= sd,
+			.dst_cpu	= dst_cpu,
+			.dst_rq		= dst_rq,
+			.src_cpu	= cpu,
+			.src_rq		= rq,
+			.idle		= CPU_SCHED_IDLE, /* non-idle only */
+			.flags		= LBF_DST_PINNED, /* pin dst_cpu */
+		};
+
+		update_rq_clock(rq);
+		p = detach_one_task(&env);
+		if (p)
+			update_overload_status(rq);
+
+		rq_unlock(rq, &rf);
+		WRITE_ONCE(rq->sched_idle_balance, 0);
+
+		if (p) {
+			attach_one_task(dst_rq, p);
+			local_irq_restore(rf.flags);
+			return 1;
+		}
+
+		local_irq_restore(rf.flags);
+	}
+
+	return 0;
+}
+
+/*
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
@@ -10356,6 +10464,15 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	u64 max_cost = 0;
 
 	rcu_read_lock();
+
+	/*
+	 * Quit early if this cpu is no idle any more. It might not be a
+	 * problem since we have already made some contribution to fix
+	 * imbalance.
+	 */
+	if (need_pull_cfs_task(rq) && sched_idle_balance(rq))
+		continue_balancing = 0;
+
 	for_each_domain(cpu, sd) {
 		/*
 		 * Decay the newidle max times here because this is a regular
@@ -10934,7 +11051,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int this_cpu = this_rq->cpu;
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
-	int pulled_task = 0;
+	struct sched_domain_shared *sds;
+	int pulled_task = 0, has_overloaded_cpus = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10985,6 +11103,11 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	update_blocked_averages(this_cpu);
 
 	rcu_read_lock();
+
+	sds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
+	if (likely(sds))
+		has_overloaded_cpus = atomic_read(&sds->nr_overloaded);
+
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
 		u64 domain_cost;
@@ -10996,9 +11119,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
-			pulled_task = load_balance(this_cpu, this_rq,
-						   sd, CPU_NEWLY_IDLE,
-						   &continue_balancing);
+			pulled_task |= load_balance(this_cpu, this_rq,
+						    sd, CPU_NEWLY_IDLE,
+						    &continue_balancing);
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
@@ -11006,13 +11129,21 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 			curr_cost += domain_cost;
 			t0 = t1;
+
+			/*
+			 * Stop searching for tasks to pull if there are
+			 * now runnable tasks on this rq, given that no
+			 * overloaded cpu can be found on this LLC.
+			 */
+			if (pulled_task && !has_overloaded_cpus)
+				break;
 		}
 
 		/*
-		 * Stop searching for tasks to pull if there are
-		 * now runnable tasks on this rq.
+		 * Try harder to pull non-idle tasks to let them use as more
+		 * cpu capacity as it can be.
 		 */
-		if (pulled_task || this_rq->nr_running > 0 ||
+		if (this_rq->nr_running > this_rq->cfs.idle_h_nr_running ||
 		    this_rq->ttwu_pending)
 			break;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index afa1bb68c3ec..dcceaec8d8b4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1012,6 +1012,8 @@ struct rq {
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
+
+	unsigned char		sched_idle_balance;
 	unsigned char		overloaded;
 
 	unsigned long		misfit_task_load;
-- 
2.11.0

