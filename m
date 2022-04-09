Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0F4FA8C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbiDINyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiDINyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:54:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB9F2558C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:52:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q19so10190679pgm.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhWe9vjYU7p/PCLLznOYW7dtirlxHpMtsOxO7api5GQ=;
        b=zQpvs/eZxOUqkdUs5/v6hJ79Sy7Eqm9erMDdiP8J54oULUKj0CeIE4NP8bDd7Bng3z
         H1i8AhBhDqGITtLNdvHUe/rAQFNpk+jRCCQfz8+kAcY0vkDoyf8y3I32KU1UmjrBd1dE
         pASPyOTdVhehT8Q1XenPMyCF6XsHVV7N951/PsY2fmLtJNvkI0YEL9OPWx9hRzm+chpD
         4jMDxXtipL33q3NMmCwGTWXjFkftrirxWEf2E/coOQfQjzvc/riwAQupMd1ZeyIk35+r
         MDXdl+BT0gm+WhBuvQxHuav4IWqnQ713vginv1Qlww1T/FpwJtD0bXnkJ7SvJbYcoaXu
         HbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhWe9vjYU7p/PCLLznOYW7dtirlxHpMtsOxO7api5GQ=;
        b=FBNPWDew1h6uQ5rdOMwBpNRG0Rg5joQjuE0UNbJCduR0QhCjJSuMMAeV+vN4anEGBF
         wdtL8TTgCjCs0wnGBrr15lBoaV+fHtHg8+Xy++sj6f9Tx2zhzTVoj6poPCMaz6jgLtbf
         WOURpfkt8wqKFJnH50jUqc8WiuDfHTs658NwEl7ZHYJgWIxBY2/BOTFYZX4eIUp1XT2A
         PENjPcjFr4O5jzHnVrh9Gvh4cunPM0QiUL+V9qKcz7qdRt4fLxVTOVP9s7fx7rqlmpww
         72w/sPgA1KJRl/Lh60eeItN1xCY4iP2nXtEbfcpZVjn4tDI+XbEyB1NzQ15RkrgqDB0G
         0rDA==
X-Gm-Message-State: AOAM531ul/B6CsxZuQUHsFAUJAIUUhUspsgl4rdSzuNbRuox4YjpBc6E
        KvSMbq+m+tdzMxOCitg4PuKwYQ==
X-Google-Smtp-Source: ABdhPJyOBAM9kTlLTuvz+cykOyavt1JWXrQITfrq/pb/dJ1r87L0WnSpOfs0O9Z4xn1XF9DCCHIjdQ==
X-Received: by 2002:a63:ec46:0:b0:381:81c4:ebbd with SMTP id r6-20020a63ec46000000b0038181c4ebbdmr19564561pgj.534.1649512323316;
        Sat, 09 Apr 2022 06:52:03 -0700 (PDT)
Received: from n227-010-195.byted.org ([121.30.179.44])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm30303357pfe.153.2022.04.09.06.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:52:02 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     joshdon@google.com, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS
Date:   Sat,  9 Apr 2022 21:51:03 +0800
Message-Id: <20220409135104.3733193-2-wuyun.abel@bytedance.com>
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

It would bring benefit if the unoccupied cpus (sched-idle/idle cpus) can
start serving as soon as the non-idle tasks are available. Lots of effort
has already done, and task wakeup path is one of them.

When a task is woken up, the scheduler tends to put it on an unoccupied
cpu to make full use of cpu capacity. But due to scalability issues, the
search depth is bounded to a reasonable limit. IOW it's possible that a
task is woken up on a busy cpu while unoccupied cpus are still out there.

This patch focuses on improving the SIS searching efficiency by filtering
out the overloaded cpus, so as a result the more overloaded the system
is, the less cpus we will search.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 12 ++++++++
 kernel/sched/core.c            |  1 +
 kernel/sched/fair.c            | 65 +++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h           |  6 ++++
 kernel/sched/topology.c        |  4 ++-
 5 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 56cffe42abbc..fb35a1983568 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -81,6 +81,18 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+
+	/*
+	 * The state of overloaded cpus is for different use against
+	 * the above elements and they are all hot, so start a new
+	 * cacheline to avoid false sharing.
+	 */
+	atomic_t	nr_overloaded	____cacheline_aligned;
+
+	/*
+	 * Must be last
+	 */
+	unsigned long	overloaded[];
 };
 
 struct sched_domain {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ef946123e9af..a372881f8eaf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9495,6 +9495,7 @@ void __init sched_init(void)
 		rq->wake_stamp = jiffies;
 		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
+		rq->overloaded = 0;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 16874e112fe6..fbeb05321615 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6284,6 +6284,15 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 #endif /* CONFIG_SCHED_SMT */
 
 /*
+ * It would be very unlikely to find an unoccupied cpu when system is heavily
+ * overloaded. Even if we could, the cost might bury the benefit.
+ */
+static inline bool sched_domain_overloaded(struct sched_domain *sd, int nr_overloaded)
+{
+	return nr_overloaded > sd->span_weight - (sd->span_weight >> 4);
+}
+
+/*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
@@ -6291,7 +6300,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1, nr = INT_MAX, nro;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
@@ -6301,7 +6310,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!this_sd)
 		return -1;
 
+	nro = atomic_read(&sd->shared->nr_overloaded);
+	if (sched_domain_overloaded(sd, nro))
+		return -1;
+
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	if (nro)
+		cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
@@ -7018,6 +7033,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return newidle_balance(rq, rf) != 0;
 }
+
+static inline bool cfs_rq_overloaded(struct rq *rq)
+{
+	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
+}
+
+/*
+ * Use locality-friendly rq->overloaded to cache the status of the rq
+ * to minimize the heavy cost on LLC shared data.
+ *
+ * Must be called with rq locked
+ */
+static void update_overload_status(struct rq *rq)
+{
+	struct sched_domain_shared *sds;
+	bool overloaded = cfs_rq_overloaded(rq);
+	int cpu = cpu_of(rq);
+
+	lockdep_assert_rq_held(rq);
+
+	if (rq->overloaded == overloaded)
+		return;
+
+	rcu_read_lock();
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (unlikely(!sds))
+		goto unlock;
+
+	if (overloaded) {
+		cpumask_set_cpu(cpu, sdo_mask(sds));
+		atomic_inc(&sds->nr_overloaded);
+	} else {
+		cpumask_clear_cpu(cpu, sdo_mask(sds));
+		atomic_dec(&sds->nr_overloaded);
+	}
+
+	rq->overloaded = overloaded;
+unlock:
+	rcu_read_unlock();
+}
+
+#else
+
+static inline void update_overload_status(struct rq *rq) { }
+
 #endif /* CONFIG_SMP */
 
 static unsigned long wakeup_gran(struct sched_entity *se)
@@ -7365,6 +7425,8 @@ done: __maybe_unused;
 	if (new_tasks > 0)
 		goto again;
 
+	update_overload_status(rq);
+
 	/*
 	 * rq is about to be idle, check if we need to update the
 	 * lost_idle_time of clock_pelt
@@ -11183,6 +11245,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	update_overload_status(rq);
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718cd641..afa1bb68c3ec 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1012,6 +1012,7 @@ struct rq {
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
+	unsigned char		overloaded;
 
 	unsigned long		misfit_task_load;
 
@@ -1764,6 +1765,11 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
+static inline struct cpumask *sdo_mask(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->overloaded);
+}
+
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 32841c6741d1..fea1294ebd16 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1621,6 +1621,8 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		atomic_set(&sd->shared->nr_overloaded, 0);
+		cpumask_clear(sdo_mask(sd->shared));
 	}
 
 	sd->private = sdd;
@@ -2086,7 +2088,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.11.0

