Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7B563E92
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 06:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiGBExI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 00:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBExG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 00:53:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426ED35869
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 21:53:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i25so5766594wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J+6Mw4J6BFpScH4mShB+H1lsC4zqQ34NbeYbESG3kXo=;
        b=SCnMrMvima3LoCuC2K+XNPMdf52IXAh66cYRwQQVQwIwb4s6GJNyQ5CVqhhfjXqvo7
         t+KYIh18sbBUpU/6BW2pMSp2mJmxGo7JOGwyucWb9Q26dB6VuEAgwRRo/PECfOsJdhKf
         TZmlNFtwHeyRWZIjqMVUTqgQpRWDA6G/OXJuazk8xG8rVh+pL4/ngqipQx8mtU3YIp5c
         S2jN+Sh/KGwaz/tCfDeKdd9STtfS/258Oy7T4e2L6n/Kqv96TVYQYh+TeJS1bpCZRBC5
         J2hBTfx1k74ElJNcOkDQgwBSTUedQe3GK0KPwGfPMl+SoRnHjWT6mv6w5raxbcKEJENS
         nJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J+6Mw4J6BFpScH4mShB+H1lsC4zqQ34NbeYbESG3kXo=;
        b=cgTllrX/2/tM9j42qykn8CYC3VbW77IAuvnuvjMsG/smFbRZjLelym0Aw5DA8wTS3Y
         KbCy0WXqnzEgZdRN8gXpHt+KuaiBFbY5pDkWn17ZPSbEtlLmXK56z6RQn892yQmruRWI
         KfpIt1hRF6oX4xIuze1n/iuD3hrm9sYKHVEIjmKHcAicPX/AvjXaro7K9NTeNmMTjhvN
         HRrfTzLnVghy0j+ZkQmxPyDJRTnHsFJWvs8UQXIE0+TOskhoPmHg0zFdDbYHc/1zemaR
         59aI5vfTQE9IYe0YmfP/ZfzGWDtfnOw0RxX7n7uXuyPYg1HxzRgon8dLOEbjfD+aDS2g
         n1tA==
X-Gm-Message-State: AJIora/VAZo8ElpaWTZNHkT4MWNFlKHzL+ttV+W+Tne/4BduO3Z20UKn
        E7uv3FqNGhOAMhJO69s4SvZ1rA==
X-Google-Smtp-Source: AGRyM1tn9hbLoFX4JCaT4waRaK8bOXm6fqxW3Kk3qIftabgrtfBAMyqMXyBmSb/9P2xCCiMj/d+vSA==
X-Received: by 2002:a5d:448e:0:b0:21b:887f:23f with SMTP id j14-20020a5d448e000000b0021b887f023fmr16979439wrq.240.1656737583743;
        Fri, 01 Jul 2022 21:53:03 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d4ecb000000b0020fe61acd09sm24475708wrv.12.2022.07.01.21.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 21:53:02 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix case with reduced capacity CPU
Date:   Sat,  2 Jul 2022 06:52:54 +0200
Message-Id: <20220702045254.22922-1-vincent.guittot@linaro.org>
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

The rework of the load balance has filterd the case when the CPU is
classified to be fully busy but its capacity is reduced.

Check if CPU's capacity is reduced while gathering load balance statistics
and classify it group_misfit_task instead of group_fully_busy so we can
try to move the load on another CPU.

Reported-by: David Chen <david.chen@nutanix.com>
Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

David, Zhang,

I haven't put your tested-by because I have reworked and cleaned the patch to
cover more cases.

Could you run some tests with this version ?

Thanks

 kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a78d2e3b9d49..126b82ef4279 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
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
+			   sched_reduced_capacity(rq, env->sd) &&
+			   (sgs->group_misfit_task_load < load)) {
+			/* Check for a task running on a CPU with reduced capacity */
+			sgs->group_misfit_task_load = load;
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
+			 * with reduced capacity
+			 */
+			env->migration_type = migrate_load;
+			env->imbalance = busiest->group_misfit_task_load;
+		}
 		return;
 	}
 
-- 
2.17.1

