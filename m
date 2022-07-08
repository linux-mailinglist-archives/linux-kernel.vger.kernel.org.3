Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96B356BD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiGHPoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiGHPoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:44:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A907C67593
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:44:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l68so12609240wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+V+zkUMekO4XG1bTdYPDw5Qmp3filqJZgOeosyNq2oM=;
        b=o+W2Ff1NW8PVyJK/h6KHikLcSLCBq9zkTWYGQ0r5LNotEw8uSvY6BHWg4jPsHXiks3
         pPUR2d/MqFaOT1Xt3mJQZWj5+hReov1iu2b2IDwSddGU1fUNgE8IlUyIZ57zhu5KAXRa
         yDyynIg3z4urKy89X6FPxaz5mkv0iwE+uYHLyODQRUIcAP1nr6LTS0aD+K3PYSTe6fpw
         ppk42qSXqMv/6+i93Y7Dpv2oi/Z+CKiaI22bt0n95UB++fKYGARUw4htKvOLcxZkaMWq
         rH9I1WIj8nLL2b3tEOA6zkol281FAbB8ZKkQFCv7pbcqL+pR/HdEpNJJx6aaqxVJ79M8
         swaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+V+zkUMekO4XG1bTdYPDw5Qmp3filqJZgOeosyNq2oM=;
        b=msiK9F+/1jd8jVN3oUqBG/46b0R/l4Ir4JngjM8FE5ld10y7Dj6sbFzuUv98HS4MaR
         38bhvpnV2cVPjExngQjY/dr+v21etegdEDgfLLq7c8Khr5jTrYdP0pO5SAkfL2rdFYTk
         HSC5fM3pdKmSSadmsJ8hU7FwEZE2LUIksFzOJIJxrtCJDlvMBU+ha9PcPge5Hl9jrxWy
         j+YCchXgW+8FBsHqp4tjxG59m4XXOblUqJxcnsk3Wcf4ZciBPTJWTwK8wfRgwPbFzika
         3ObhZ4EG/lbbHDWgW+7j0+biqAFvXlDMHLETxJYh5MNR+6/7SVN/etZwuAz2RY33xCyx
         +k/Q==
X-Gm-Message-State: AJIora/5LsA8XW3r7cbfSyL9zUIw8iUzGfuNf0snP8B23S9Ea5ew3iUf
        et2DWEKUqTxJDtfzgKYQMg61IAYTwJc6Ew==
X-Google-Smtp-Source: AGRyM1smpUrKatpfxvwtDsWj8Jh8NwZ3/7/xp2NzQ+F0TbFtniSIi2Q1u7vZ8EZ6VviZ7HKnh/oX/g==
X-Received: by 2002:a05:600c:3491:b0:3a0:4d4a:2e2d with SMTP id a17-20020a05600c349100b003a04d4a2e2dmr521792wmq.4.1657295045171;
        Fri, 08 Jul 2022 08:44:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:844d:1a43:7e34:efd9])
        by smtp.gmail.com with ESMTPSA id c2-20020adfe702000000b0021d69860b66sm17397879wrm.9.2022.07.08.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:44:04 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix case with reduced capacity CPU
Date:   Fri,  8 Jul 2022 17:44:01 +0200
Message-Id: <20220708154401.21411-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: David Chen <david.chen@nutanix.com>
Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
---

v2:
- fixed typo
- removed useless comments for group_misfit_task
- reorder conditions to make the code easier to read


 kernel/sched/fair.c | 54 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a78d2e3b9d49..914096c5b1ae 100644
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
 
-- 
2.17.1

