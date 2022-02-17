Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AA4BA4B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiBQPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:44:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242675AbiBQPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:44:34 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDDB23AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z17so4893641plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8c8qUSDML4pELaqmow9If9ubJ2YNKV4cb1f0Kg7vIhc=;
        b=DZJEGwcKPRuKMTlN8wElSnrFIVNjERV1GQdLA1u6bMTbcrxKI/CFuusUoSIFs3Hyyh
         uUWYI+tHr6HEiklU3LfcjNGoViUmJY/CY4UVxo2RSQdnNVDw4H8KXTnaluw1WlgiWMkS
         kTYsBxvFFtIPNBqSUdpDSgKC/yP4vtTgZkPghn7sLGAWg8J5QZuVxwbXIOG3w2aXC/wA
         74DBk7OxKZiQg+Kk2QTFERT0sy/fdZpSUJ4E8B/gSiTv74q+rjwjOW2zXQqnfBUXiV2N
         OuYdnHFFZbNoP0BqhQQztpUrHxfDkQICXvcryWOjFX63fHJntzggwTlbQ17bJRoFz98y
         siKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8c8qUSDML4pELaqmow9If9ubJ2YNKV4cb1f0Kg7vIhc=;
        b=MDV3+Uufr451l3xFOJHu5hx06ZpHekemziqw7lI77YRyn6RCsfE5KFQjJPC5ZaqHON
         KcnC6XwZIs4OqPXYZuFo7OokcSmRGAlMfht0OL+FP2Bf6LLfQ8XwMg3HOKE6eQIp0s5g
         Xa1ozNX0wfFeB9m6AzRHJQJ8/+rVqRWROE+cDgn1+mqBpEVAIfo7BNezHBGKgmYQkadu
         ONjQeA2KBBoqA71TiJsefvh210Q0rJhbDlzV3vvib5Y5ThCLqlhy5gRC+TOjk6uOFo2h
         y97AiQM9q/teO+nJLU9yht+wGSEYr6ZriYd17bfsPKe8jNLXeeIpU6OeWMin5Jorw6I8
         3bCQ==
X-Gm-Message-State: AOAM533UjzKHhOHRMthIuz80Nnfo10Ym5WQoTldDmAP6bv0da41C4xZ7
        w5biy9VQP9/VrxA2XPNz2LO1gS+QoR70Pw==
X-Google-Smtp-Source: ABdhPJyJWf0xIPg3G7CLAb8e9ZxCOdulcgJWLUbeDnOUXht7QJ44V3fwvfk0SdNcoBkVWlyX72f16g==
X-Received: by 2002:a17:90b:3755:b0:1b9:bc4a:b9dc with SMTP id ne21-20020a17090b375500b001b9bc4ab9dcmr3576201pjb.159.1645112659553;
        Thu, 17 Feb 2022 07:44:19 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id s6sm24108pfk.86.2022.02.17.07.44.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:19 -0800 (PST)
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
Subject: [RFC PATCH 2/5] sched/fair: introduce sched-idle balance
Date:   Thu, 17 Feb 2022 23:43:58 +0800
Message-Id: <20220217154403.6497-3-wuyun.abel@bytedance.com>
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

The goal of the sched-idle balancing is to let the non-idle
tasks make full use of cpu resources. To achieve that, we
mainly do two things:

  - pull non-idle tasks for sched-idle or idle rqs
    from the overloaded ones, and

  - prevent pulling the last non-idle task in an rq

We do sched-idle balance at normal load balancing and newly
idle if necessary. The idle balancing is ignored due to high
wakeup latency.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/idle.h |   1 +
 kernel/sched/fair.c        | 128 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

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
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a0438c3319b..070a6fb1d2bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -456,6 +456,21 @@ static int se_is_idle(struct sched_entity *se)
 	return cfs_rq_is_idle(group_cfs_rq(se));
 }
 
+/* Is task idle from the top hierarchy POV */
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
@@ -6974,6 +6994,11 @@ static inline int cfs_rq_overloaded(struct rq *rq)
 	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
 }
 
+static inline bool need_pull_cfs_task(struct rq *rq)
+{
+	return rq->cfs.h_nr_running == rq->cfs.idle_h_nr_running;
+}
+
 /* Must be called with rq locked */
 static void update_overload_status(struct rq *rq)
 {
@@ -7767,6 +7792,22 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (kthread_is_per_cpu(p))
 		return 0;
 
+	/*
+	 * Disregard hierarchically idle tasks during sched-idle
+	 * load balancing.
+	 */
+	if (env->idle == CPU_SCHED_IDLE && task_h_idle(p))
+		return 0;
+
+	/*
+	 * Skip p if it is the last non-idle task in src_rq. This
+	 * protects latency and throughput for non-idle tasks at
+	 * the cost of temporary load imbalance (which will probably
+	 * be fixed soon).
+	 */
+	if (!cfs_rq_overloaded(env->src_rq) && !task_h_idle(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
@@ -10265,6 +10306,83 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 }
 
 /*
+ * The sched-idle balancing tries to eliminate overloaded cfs rqs
+ * by spreading out non-idle tasks prior to normal load balancing.
+ */
+static void sched_idle_balance(struct rq *dst_rq)
+{
+	struct sched_domain *sd;
+	struct task_struct *p;
+	int dst_cpu = cpu_of(dst_rq), cpu;
+
+	sd = rcu_dereference(per_cpu(sd_llc, dst_cpu));
+	if (unlikely(!sd))
+		return;
+
+	if (!atomic_read(&sd->shared->nr_overloaded))
+		return;
+
+	for_each_cpu_wrap(cpu, sdo_mask(sd->shared), dst_cpu + 1) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		struct lb_env env;
+
+		if (cpu == dst_cpu)
+			continue;
+
+		if (!cfs_rq_overloaded(rq))
+			continue;
+
+		rq_lock_irqsave(rq, &rf);
+
+		/*
+		 * Check again to ensure there are pullable tasks.
+		 * This is necessary because multiple rqs can pull
+		 * tasks at the same time. IOW contention on this
+		 * rq is heavy, so it would be better clear this
+		 * cpu from overloaded mask.
+		 */
+		if (unlikely(!cfs_rq_overloaded(rq))) {
+			update_overload_status(rq);
+			rq_unlock_irqrestore(rq, &rf);
+			continue;
+		}
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
+
+		/*
+		 * Lazy updating overloaded mask here. If the rq is
+		 * still overloaded then we are just wasting cycles.
+		 * And it's OK even if the rq becomes un-overloaded
+		 * since the cost of peeking rq's data without lock
+		 * won't be much in next loops (during which the rq
+		 * can even be overloaded again).
+		 */
+
+		rq_unlock(rq, &rf);
+
+		if (p) {
+			attach_one_task(dst_rq, p);
+			local_irq_restore(rf.flags);
+			return;
+		}
+
+		local_irq_restore(rf.flags);
+	}
+}
+
+/*
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
@@ -10284,6 +10402,10 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	u64 max_cost = 0;
 
 	rcu_read_lock();
+
+	if (need_pull_cfs_task(rq))
+		sched_idle_balance(rq);
+
 	for_each_domain(cpu, sd) {
 		/*
 		 * Decay the newidle max times here because this is a regular
@@ -10913,6 +11035,12 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	update_blocked_averages(this_cpu);
 
 	rcu_read_lock();
+
+	sched_idle_balance(this_rq);
+	t1 = sched_clock_cpu(this_cpu);
+	curr_cost += t1 - t0;
+	t0 = t1;
+
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
 		u64 domain_cost;
-- 
2.11.0

