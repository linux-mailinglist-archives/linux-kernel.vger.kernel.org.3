Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0421D4BA4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiBQPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:44:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiBQPoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:44:30 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCCB23AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:15 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 195so5356472pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+yvIhku4QXYZHCkM9HOGBC9iJm2wXLIAwkbGeymkbE=;
        b=x2TiCPsdfRAzb4WvqNWpOV2WZEKxBwHKf9FVM14db4rWZ2wR+FLr9xtVNg946N1Npu
         2PSrMbpQ8RuGuYWZuMIKFCgFrhIrjmsbwGB3XvQTWO0PTt8VrADoAkXE3qhf99C7IkOP
         i0fxoySK/P1swY8R0nBZQNFl26Z5g8rIe8bW2NmC4FRwHoN5o+EpHs3who07tvuTEdHP
         YAF/wKRZMl4nvF28QmKbPN8/u6HjN9PpLtU9vAuMP/A1DU/AUyUSDl8Izf2FJN9AejRF
         hBk3QTb8nGjPZkRCIf7/G59JvOq2hQj+pzVQ9Dr729maoz6ZYNVUEchmhQwF1thWmCaB
         TG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+yvIhku4QXYZHCkM9HOGBC9iJm2wXLIAwkbGeymkbE=;
        b=4f564W4uAvWrVDU87fSl3Qk4qLWnn6aHprQO3JPVck6k3pzU78uLIbX++He9npQwW1
         skum1tKJSKXx6vVD+aJ0mzaNhaXSlqAy+nHrFqSH2JI6gB9Ts3HcQwosaQp9GH+jXVHd
         qLhsix3Fdg0zl4QfThMDvH0qbMaQ+SRVrpGXK4YbRLMxYVt6Zbl+Hg/jBBHzkwOUAAGQ
         OxeCpB2DfXjq7rwteF2a0mzZm9fjD3zUU0X6KoX4OGkntaLUBZEcKIUOWQxAxaMl9rdZ
         kegYTkAxP9qhxR+SFdxWR8gr8pIOdaQXNAJHp2O2x2OgoZBPVhMxUl+EacbHINp2UAv+
         gXtA==
X-Gm-Message-State: AOAM530Rz0zbvLCEspSnZ2p2WHUCjVmnkzuwD9Xqpq0DNo+/ama6utlE
        MxcbMjOsngBnsarFFvnM0rIgJw==
X-Google-Smtp-Source: ABdhPJzUTv/+o1tgFeWYGOhx9y50utJ2NQ3B5/sPu3pXedj38tVjwYbgPpNXi3L9lFwzu4XKTOtZqg==
X-Received: by 2002:a63:4f4d:0:b0:372:8724:8397 with SMTP id p13-20020a634f4d000000b0037287248397mr2865541pgl.598.1645112655058;
        Thu, 17 Feb 2022 07:44:15 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id s6sm24108pfk.86.2022.02.17.07.44.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:14 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] sched/fair: record overloaded cpus
Date:   Thu, 17 Feb 2022 23:43:57 +0800
Message-Id: <20220217154403.6497-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217154403.6497-1-wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An CFS runqueue is considered overloaded when there are
more than one pullable non-idle tasks on it (since sched-
idle cpus are treated as idle cpus). And idle tasks are
counted towards rq->cfs.idle_h_nr_running, that is either
assigned SCHED_IDLE policy or placed under idle cgroups.

The overloaded cfs rqs can cause performance issues to
both task types:

  - for latency critical tasks like SCHED_NORMAL,
    time of waiting in the rq will increase and
    result in higher pct99 latency, and

  - batch tasks may not be able to make full use
    of cpu capacity if sched-idle rq exists, thus
    presents poorer throughput.

The mask of overloaded cpus is updated in periodic tick
and the idle path at the LLC domain basis. This cpumask
will also be used in SIS as a filter, improving idle cpu
searching.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/core.c            |  1 +
 kernel/sched/fair.c            | 43 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h           |  6 ++++++
 kernel/sched/topology.c        |  4 +++-
 5 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 56cffe42abbc..03c9c81dc886 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -81,6 +81,16 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+
+	/*
+	 * The above varibles are used in idle path and
+	 * select_task_rq, and the following two are
+	 * mainly updated in tick. They are all hot but
+	 * for different usage, so start a new cacheline
+	 * to avoid false sharing.
+	 */
+	atomic_t	nr_overloaded	____cacheline_aligned;
+	unsigned long	overloaded[];	/* Must be last */
 };
 
 struct sched_domain {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d863d7f6ad7..a6da2998ec49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9423,6 +9423,7 @@ void __init sched_init(void)
 		rq->wake_stamp = jiffies;
 		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
+		rq->overloaded = 0;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4bfffe8c2c..0a0438c3319b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6968,6 +6968,46 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return newidle_balance(rq, rf) != 0;
 }
+
+static inline int cfs_rq_overloaded(struct rq *rq)
+{
+	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
+}
+
+/* Must be called with rq locked */
+static void update_overload_status(struct rq *rq)
+{
+	struct sched_domain_shared *sds;
+	int overloaded = cfs_rq_overloaded(rq);
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
@@ -7315,6 +7355,8 @@ done: __maybe_unused;
 	if (new_tasks > 0)
 		goto again;
 
+	update_overload_status(rq);
+
 	/*
 	 * rq is about to be idle, check if we need to update the
 	 * lost_idle_time of clock_pelt
@@ -11131,6 +11173,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	update_overload_status(rq);
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b33ba9c3c42..c81a87082b8b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1012,6 +1012,7 @@ struct rq {
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
+	unsigned char		overloaded;
 
 	unsigned long		misfit_task_load;
 
@@ -1762,6 +1763,11 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
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
index e6cd55951304..641f11415819 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1623,6 +1623,8 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		atomic_set(&sd->shared->nr_overloaded, 0);
+		cpumask_clear(sdo_mask(sd->shared));
 	}
 
 	sd->private = sdd;
@@ -2050,7 +2052,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.11.0

