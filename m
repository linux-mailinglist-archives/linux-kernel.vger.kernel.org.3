Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81624E6CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348036AbiCYDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346155AbiCYDzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:55:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802803615E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id t2so5483111pfj.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGpRT3RxXk4Z+RfR3AojOlITuboxzWYBrYGSuiIe62w=;
        b=0n3o9lEO7HMh1Ibbvwofn5MhvEUv16HR8EAAwUriiSOE90yW0FijiFEknOzu9YvjV4
         HhU2WE6N1ci1Y0YaSsx/Gko/31tOcZjQqora6kOJSNRmbzidIihNXzvhaVbHnpr+BWVn
         qohbXL0XjLUsS/g76JYe5i6aoD7jfWG2S3hnFrvUXDfW0obobntT0CR0QGVgf9FMRH+m
         D+Q7rjGmGOCsIBVVC2IMwJG2XjYvlr6nQ6Lbp3VhbtiaXwcHbG+PkMt/RYJ/cm8Jicwa
         JsQ7LFggflYV3LWZ1KiMFlyheFV7DxLAFyJinon/McdWdv2H8L6NuhO9+BHkclHzL2gx
         +VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGpRT3RxXk4Z+RfR3AojOlITuboxzWYBrYGSuiIe62w=;
        b=8QMVdvbg1cz9nlqEPNJ3hDVvcy3xQp37/UhQtQCXY/6PNtTVUrjav44GQDbE9SOEPP
         N/HGu/Z9LgxqPoJ3OfBAFlDTxW3hPwM10M/1vt3xUe47jLOVX8O+obriuMziTESvW2O1
         UY51lvzxd9RLLX9p367rXMU/uUxm5cq1MQXQpdi5j45aZzJLP5bAbW3mKUEQkK0MtjUg
         2TGhi88jBhDjVmwsyRsPEKKVIM4gCiyYtHdFq9NvbXOrnJHklL4PmkR5mbjLbTi6jYL9
         6DQceAvgy2Aqj0J+UK4X6o1y11FtI9m+eVqkSCmNTyUeMyeHJ7GmDMNDhHTmGvGpr13G
         VdXg==
X-Gm-Message-State: AOAM533v18pRVtxhgC9AjkwrI37FKMUzYYV6LuKL6qQNhygMa+z/DxFs
        VgYO9LbMySontj2t+RtKiBf/zEoT0qCEEQ==
X-Google-Smtp-Source: ABdhPJymYZEopM6Js2KSnwiNLa/qHCUe6hsL81AMukl23CTJqDFabGSoTIB1oLb2bAWbQQ0OITEw5Q==
X-Received: by 2002:a65:568d:0:b0:382:2e6f:f098 with SMTP id v13-20020a65568d000000b003822e6ff098mr6357523pgs.242.1648180443050;
        Thu, 24 Mar 2022 20:54:03 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:54:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 1/5] perf/core: Don't pass task around when ctx sched in
Date:   Fri, 25 Mar 2022 11:53:14 +0800
Message-Id: <20220325035318.42168-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325035318.42168-1-zhouchengming@bytedance.com>
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
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
2.20.1

