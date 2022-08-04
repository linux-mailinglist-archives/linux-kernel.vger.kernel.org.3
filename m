Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305C6589D94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiHDOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbiHDOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:36:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D9684B48D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:36:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6785B14BF;
        Thu,  4 Aug 2022 07:36:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.10.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38DC93F73B;
        Thu,  4 Aug 2022 07:36:37 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 2/9] sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
Date:   Thu,  4 Aug 2022 15:36:02 +0100
Message-Id: <20220804143609.515789-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804143609.515789-1-qais.yousef@arm.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that the new uclamp rules in regard to migration margin and capacity
pressure are taken into account correctly.

Fixes: a7008c07a568 ("sched/fair: Make task_fits_capacity() consider uclamp restrictions")
Co-developed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/fair.c  | 26 ++++++++++++++++----------
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00c2de800685..78feb9ca1e41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4377,10 +4377,12 @@ static inline int util_fits_cpu(unsigned long util,
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
@@ -4393,7 +4395,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 		return;
 	}
 
-	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
+	if (task_fits_cpu(p, cpu_of(rq))) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -8234,7 +8236,7 @@ static int detach_tasks(struct lb_env *env)
 
 		case migrate_misfit:
 			/* This is not a misfit task */
-			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
+			if (task_fits_cpu(p, env->src_cpu))
 				goto next;
 
 			env->imbalance = 0;
@@ -9239,6 +9241,10 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	memset(sgs, 0, sizeof(*sgs));
 
+	/* Assume that task can't fit any CPU of the group */
+	if (sd->flags & SD_ASYM_CPUCAPACITY)
+		sgs->group_misfit_task_load = 1;
+
 	for_each_cpu(i, sched_group_span(group)) {
 		struct rq *rq = cpu_rq(i);
 		unsigned int local;
@@ -9258,12 +9264,12 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		if (!nr_running && idle_cpu_without(i, p))
 			sgs->idle_cpus++;
 
-	}
+		/* Check if task fits in the CPU */
+		if (sd->flags & SD_ASYM_CPUCAPACITY &&
+		    sgs->group_misfit_task_load &&
+		    task_fits_cpu(p, i))
+			sgs->group_misfit_task_load = 0;
 
-	/* Check if task fits in the group */
-	if (sd->flags & SD_ASYM_CPUCAPACITY &&
-	    !task_fits_capacity(p, group->sgc->max_capacity)) {
-		sgs->group_misfit_task_load = 1;
 	}
 
 	sgs->group_capacity = group->sgc->capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3ccd35c22f0f..eec1cac3eef4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3047,6 +3047,15 @@ static inline bool uclamp_is_used(void)
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
-- 
2.25.1

