Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB424EB0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiC2Pri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiC2Prg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B959B3AA61
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:45:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w21so15157375pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sR+AGUD6IJfSlX//tE9IvBlX5391lNRFVMozD/58NMw=;
        b=vVx9AbYAQXR2dNV5eh0x3EJ+LbogFysar/7XN+VBC2k1xy/kv/3ZPB/z55oUbDf02Q
         6fC8PQbzMis9xzotcHHE3cVoQ4Or9C+wptqK6kJnWp2y/cfcih5irmscWYDcTfbDIqKh
         FLRPchgp+CbllrsAH3bSs9nI1Y9xCFGvBcGRiyRkhg07DOcTTX/7l01/SJVqW1mzhSE7
         TC1pjXxNSGB4xqnmMiaItc42TDS9hGm5eb7C+JLtll547vyLcwkL72fEkoTll1L2y1ac
         J0ng+qisZGHoZ8DBYv36BcIu7PHMb/KObOrOrViA8yyWrm7Ll1WoElKQGjpsZrUMUcl6
         v3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sR+AGUD6IJfSlX//tE9IvBlX5391lNRFVMozD/58NMw=;
        b=Ebh/GaNoDB1a6+m2FIs99CO8p6v4Z9yi7YD+Om4EDmrv+SVxvP7EALw0NpgX+bfQ+L
         Mp3e0pO7wgiREuc7lbIyD+Z/yuioGS9J3TArNQE/46bc2oponoel5kjMLyte984e1HaC
         nVZS3zsuS3oYK3HgyRPZQcKUQCbUUxa2mipiGTVaJHh4PpJU0A1VK8lguh3FJIDMicx0
         NIJEU3j8GFwi5epxRuSMsIavyYo/AyZZzzC7Fsg3CymFhar2hIaAprbSjHbQPldiM7O4
         Ku6qJut7G6PHHLITEHfZZFU2zJm8J0ZegL4mhCzspicCjG3HlLcEsHncdzZGFAyawcFn
         71Fw==
X-Gm-Message-State: AOAM5338mWTxSGEIZOdxw6lxZuxDHeCURWrAzpQYVGObRgfe3lQNQA8f
        G4kmimErdJ3k8A4xSuhBLKbqbA==
X-Google-Smtp-Source: ABdhPJx6s1QCzN95yDkgEce4/qTzdIQESwqGAFZDm+gKDFnKo5L8OFL4QeMNiVLBngAd+LjJzWVtTQ==
X-Received: by 2002:a62:8308:0:b0:4fa:7bcd:d0e6 with SMTP id h8-20020a628308000000b004fa7bcdd0e6mr28934815pfe.35.1648568751759;
        Tue, 29 Mar 2022 08:45:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:45:51 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 1/4] perf/core: Don't pass task around when ctx sched in
Date:   Tue, 29 Mar 2022 23:45:20 +0800
Message-Id: <20220329154523.86438-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
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

The current code pass task around for ctx_sched_in(), only
to get perf_cgroup of the task, then update the timestamp
of it and its ancestors and set them to active.

But we can use cpuctx->cgrp to get active perf_cgroup and
its ancestors since cpuctx->cgrp has been set before
ctx_sched_in().

This patch remove the task argument in ctx_sched_in()
and cleanup related code.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 58 ++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfde994ce61c..d50f45012c05 100644
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
 
-- 
2.35.1

