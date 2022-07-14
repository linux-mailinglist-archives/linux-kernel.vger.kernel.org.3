Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C3574C41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiGNLfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiGNLfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:35:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A55927B;
        Thu, 14 Jul 2022 04:35:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:35:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657798533;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=up1HiDpQLpyxuWkd7NU5c0wZC/w3JzgDQG83OzRQZVI=;
        b=2ZmN54dyc+f45Pa6htYKBQ6fl623K4PNtyoayJ29R1USW1SG/uAPyCZH1vX4ob9DMf8XCH
        FhuIDo/DAcXYXaEUKc5ivJejOurSrgN8P7dtNoW2aLIA1+lPZWqD86E3ff5g3PiyJWm59v
        GfB9rwf7trMs9qAGKpIIy7nigB9X57d/wR7Vf8CRXeqzpmjvjy1P5qUiT8oSNwSGUTY9jB
        3csjQ3KbnftkqEIAypcaolT1l1M45rEIGID/fa4OIg1XKInp3vtTZmN/GNuJL3i1jURQuy
        qVkKouA8Lm4ZO51XKdsxF7vfuXmlNM8v7kH/LVTGB0NU+tr8caxGWvO35ExeKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657798533;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=up1HiDpQLpyxuWkd7NU5c0wZC/w3JzgDQG83OzRQZVI=;
        b=2vFt1QmPebt8jAZTS30/YO1jJo094Zcw3Z5mou2bakT6qr7Jx/Iq/AWMtOmGByqfy/jmGU
        BxU7oU/QqD87LyBw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: fix case with reduced capacity CPU
Cc:     David Chen <david.chen@nutanix.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220708154401.21411-1-vincent.guittot@linaro.org>
References: <20220708154401.21411-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <165779853202.15455.11200413501635211610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c82a69629c53eda5233f13fc11c3c01585ef48a2
Gitweb:        https://git.kernel.org/tip/c82a69629c53eda5233f13fc11c3c01585ef48a2
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 08 Jul 2022 17:44:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 13 Jul 2022 11:29:17 +02:00

sched/fair: fix case with reduced capacity CPU

The capacity of the CPU available for CFS tasks can be reduced because of
other activities running on the latter. In such case, it's worth trying to
move CFS tasks on a CPU with more available capacity.

The rework of the load balance has filtered the case when the CPU is
classified to be fully busy but its capacity is reduced.

Check if CPU's capacity is reduced while gathering load balance statistic
and classify it group_misfit_task instead of group_fully_busy so we can
try to move the load on another CPU.

Reported-by: David Chen <david.chen@nutanix.com>
Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: David Chen <david.chen@nutanix.com>
Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
Link: https://lkml.kernel.org/r/20220708154401.21411-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a78d2e3..914096c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7711,8 +7711,8 @@ enum group_type {
 	 */
 	group_fully_busy,
 	/*
-	 * SD_ASYM_CPUCAPACITY only: One task doesn't fit with CPU's capacity
-	 * and must be migrated to a more powerful CPU.
+	 * One task doesn't fit with CPU's capacity and must be migrated to a
+	 * more powerful CPU.
 	 */
 	group_misfit_task,
 	/*
@@ -8798,6 +8798,19 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
+static inline bool
+sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
+{
+	/*
+	 * When there is more than 1 task, the group_overloaded case already
+	 * takes care of cpu with reduced capacity
+	 */
+	if (rq->cfs.h_nr_running != 1)
+		return false;
+
+	return check_cpu_capacity(rq, sd);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8820,8 +8833,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
+		unsigned long load = cpu_load(rq);
 
-		sgs->group_load += cpu_load(rq);
+		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
@@ -8851,11 +8865,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (local_group)
 			continue;
 
-		/* Check for a misfit task on the cpu */
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    sgs->group_misfit_task_load < rq->misfit_task_load) {
-			sgs->group_misfit_task_load = rq->misfit_task_load;
-			*sg_status |= SG_OVERLOAD;
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
+			/* Check for a misfit task on the cpu */
+			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
+				sgs->group_misfit_task_load = rq->misfit_task_load;
+				*sg_status |= SG_OVERLOAD;
+			}
+		} else if ((env->idle != CPU_NOT_IDLE) &&
+			   sched_reduced_capacity(rq, env->sd)) {
+			/* Check for a task running on a CPU with reduced capacity */
+			if (sgs->group_misfit_task_load < load)
+				sgs->group_misfit_task_load = load;
 		}
 	}
 
@@ -8908,7 +8928,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * CPUs in the group should either be possible to resolve
 	 * internally or be covered by avg_load imbalance (eventually).
 	 */
-	if (sgs->group_type == group_misfit_task &&
+	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
+	    (sgs->group_type == group_misfit_task) &&
 	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
@@ -9517,9 +9538,18 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	busiest = &sds->busiest_stat;
 
 	if (busiest->group_type == group_misfit_task) {
-		/* Set imbalance to allow misfit tasks to be balanced. */
-		env->migration_type = migrate_misfit;
-		env->imbalance = 1;
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
+			/* Set imbalance to allow misfit tasks to be balanced. */
+			env->migration_type = migrate_misfit;
+			env->imbalance = 1;
+		} else {
+			/*
+			 * Set load imbalance to allow moving task from cpu
+			 * with reduced capacity.
+			 */
+			env->migration_type = migrate_load;
+			env->imbalance = busiest->group_misfit_task_load;
+		}
 		return;
 	}
 
