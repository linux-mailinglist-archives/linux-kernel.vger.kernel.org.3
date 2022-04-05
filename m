Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730324F3159
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357069AbiDEKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63AE10FC2;
        Tue,  5 Apr 2022 01:29:07 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPYD5ZolEbkGH+EhuY0/H0+B93v4HcrMEWrGKmEgfjk=;
        b=NoPpCL9D2M8KE0MpeeCKQwpmsK674tf4aCE6EF1D0NehnE11NSOi+UgAOFmRx22U1RYb9p
        bwgU+iIW+CNa+0e0R3/gC9vTaPEB49dcnsezxY6pzj7ThvNipC/SE6DTzCFQ44EKhvQKVk
        oO0Hd2oWg6z+qTRUEDCy1qefIM+dHW4nZlrz4cw0OM+Li7GECMoB5MbzlhxLQRs9n0YSL3
        TzbKIZdHORRtkNGZ81m05njeKLT9D7sNM326NaqRRBqJifyLBBbYzXUxCff4TaIlYm1BUJ
        +25neGhGpohbcvZq+EoCUqX4HbU9spJtPBpcfUOKo8AIvqFIpLgMgkw5lUC3AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPYD5ZolEbkGH+EhuY0/H0+B93v4HcrMEWrGKmEgfjk=;
        b=KF98DyjCtbUL523mRFbxmWU6He9+EW7KR2D4YiCjTc4+PX8R1N+reNKw1iu8qv64dYu6qZ
        0t0JMxQIQ9tN3HCQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Don't pass task around when ctx sched in
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329154523.86438-2-zhouchengming@bytedance.com>
References: <20220329154523.86438-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164914734514.389.17929255348417765123.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a0827713e298d021d3c79ae7423aea408f3f7c3a
Gitweb:        https://git.kernel.org/tip/a0827713e298d021d3c79ae7423aea408f3f7c3a
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Tue, 29 Mar 2022 23:45:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:44 +02:00

perf/core: Don't pass task around when ctx sched in

The current code pass task around for ctx_sched_in(), only
to get perf_cgroup of the task, then update the timestamp
of it and its ancestors and set them to active.

But we can use cpuctx->cgrp to get active perf_cgroup and
its ancestors since cpuctx->cgrp has been set before
ctx_sched_in().

This patch remove the task argument in ctx_sched_in()
and cleanup related code.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220329154523.86438-2-zhouchengming@bytedance.com
---
 kernel/events/core.c | 58 +++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3980efc..6545020 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -574,8 +574,7 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
 			      enum event_type_t event_type);
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type,
-			     struct task_struct *task);
+			     enum event_type_t event_type);
 
 static void update_context_time(struct perf_event_context *ctx);
 static u64 perf_event_time(struct perf_event *event);
@@ -801,10 +800,10 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct task_struct *task,
-			  struct perf_event_context *ctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 {
-	struct perf_cgroup *cgrp;
+	struct perf_event_context *ctx = &cpuctx->ctx;
+	struct perf_cgroup *cgrp = cpuctx->cgrp;
 	struct perf_cgroup_info *info;
 	struct cgroup_subsys_state *css;
 
@@ -813,10 +812,10 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	 * ensure we do not access cgroup data
 	 * unless we have the cgroup pinned (css_get)
 	 */
-	if (!task || !ctx->nr_cgroups)
+	if (!cgrp)
 		return;
 
-	cgrp = perf_cgroup_from_task(task, ctx);
+	WARN_ON_ONCE(!ctx->nr_cgroups);
 
 	for (css = &cgrp->css; css; css = css->parent) {
 		cgrp = container_of(css, struct perf_cgroup, css);
@@ -869,14 +868,14 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 			WARN_ON_ONCE(cpuctx->cgrp);
 			/*
 			 * set cgrp before ctxsw in to allow
-			 * event_filter_match() to not have to pass
-			 * task around
+			 * perf_cgroup_set_timestamp() in ctx_sched_in()
+			 * to not have to pass task around
 			 * we pass the cpuctx->ctx to perf_cgroup_from_task()
 			 * because cgorup events are only per-cpu
 			 */
 			cpuctx->cgrp = perf_cgroup_from_task(task,
 							     &cpuctx->ctx);
-			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
+			cpu_ctx_sched_in(cpuctx, EVENT_ALL);
 		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -1118,8 +1117,7 @@ static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct task_struct *task,
-			  struct perf_event_context *ctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 {
 }
 
@@ -2713,8 +2711,7 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type,
-	     struct task_struct *task);
+	     enum event_type_t event_type);
 
 static void task_ctx_sched_out(struct perf_cpu_context *cpuctx,
 			       struct perf_event_context *ctx,
@@ -2730,15 +2727,14 @@ static void task_ctx_sched_out(struct perf_cpu_context *cpuctx,
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
-				struct perf_event_context *ctx,
-				struct task_struct *task)
+				struct perf_event_context *ctx)
 {
-	cpu_ctx_sched_in(cpuctx, EVENT_PINNED, task);
+	cpu_ctx_sched_in(cpuctx, EVENT_PINNED);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_PINNED, task);
-	cpu_ctx_sched_in(cpuctx, EVENT_FLEXIBLE, task);
+		ctx_sched_in(ctx, cpuctx, EVENT_PINNED);
+	cpu_ctx_sched_in(cpuctx, EVENT_FLEXIBLE);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_FLEXIBLE, task);
+		ctx_sched_in(ctx, cpuctx, EVENT_FLEXIBLE);
 }
 
 /*
@@ -2788,7 +2784,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (ctx_event_type & EVENT_PINNED)
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_event_sched_in(cpuctx, task_ctx);
 	perf_pmu_enable(cpuctx->ctx.pmu);
 }
 
@@ -3011,7 +3007,7 @@ static void __perf_event_enable(struct perf_event *event,
 		return;
 
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
 		return;
 	}
 
@@ -3020,7 +3016,7 @@ static void __perf_event_enable(struct perf_event *event,
 	 * then don't put it on unless the group is on.
 	 */
 	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
 		return;
 	}
 
@@ -3865,8 +3861,7 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type,
-	     struct task_struct *task)
+	     enum event_type_t event_type)
 {
 	int is_active = ctx->is_active;
 
@@ -3878,7 +3873,7 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (is_active ^ EVENT_TIME) {
 		/* start ctx time */
 		__update_context_time(ctx, false);
-		perf_cgroup_set_timestamp(task, ctx);
+		perf_cgroup_set_timestamp(cpuctx);
 		/*
 		 * CPU-release for the below ->is_active store,
 		 * see __load_acquire() in perf_event_time_now()
@@ -3909,12 +3904,11 @@ ctx_sched_in(struct perf_event_context *ctx,
 }
 
 static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type,
-			     struct task_struct *task)
+			     enum event_type_t event_type)
 {
 	struct perf_event_context *ctx = &cpuctx->ctx;
 
-	ctx_sched_in(ctx, cpuctx, event_type, task);
+	ctx_sched_in(ctx, cpuctx, event_type);
 }
 
 static void perf_event_context_sched_in(struct perf_event_context *ctx,
@@ -3956,7 +3950,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
-	perf_event_sched_in(cpuctx, ctx, task);
+	perf_event_sched_in(cpuctx, ctx);
 
 	if (cpuctx->sched_cb_usage && pmu->sched_task)
 		pmu->sched_task(cpuctx->task_ctx, true);
@@ -4267,7 +4261,7 @@ static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
 	if (cpu_event)
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 
-	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_event_sched_in(cpuctx, task_ctx);
 
 	perf_pmu_enable(cpuctx->ctx.pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -4339,7 +4333,7 @@ static void perf_event_enable_on_exec(int ctxn)
 		clone_ctx = unclone_ctx(ctx);
 		ctx_resched(cpuctx, ctx, event_type);
 	} else {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, EVENT_TIME);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
