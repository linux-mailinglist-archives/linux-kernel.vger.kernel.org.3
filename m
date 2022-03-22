Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618C74E3E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiCVML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiCVML0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:11:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C783035
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:09:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso2484056pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tev5pfuhtnVPwxEGApA0jaXuM/+4Um3B3QdIHAHr3/o=;
        b=kaUArhFMQU/+L16rrX9b2jwV0DFyg/7KKILiG0ZcxIQskBESNFBLP7M3gFx+uVlCVj
         avO9dxMpPgatOr+Ffo/TR0MOF8c2/5UegzIOcLKGj4qT7X4XxfcxjMyV1cBum9bQkl8q
         mFoBfBvsnTLsMaiVBg/lTPhSqNiTBW97Po5pEJ1u95yUdeZzyXm7yYS18y497xYfAiF8
         8ZAhj59tvq+uulTJk6AptR9ACeoWfvJfZBpxv/FBmY+O8WMSgYU/lFLS/QHwHMk9zLD7
         lKsdw3/EpcD/2PpntQ4j++GyllOtfUUGldnfK+knqV2+iJUo6gD9H22KzjOun/YSri9R
         bSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tev5pfuhtnVPwxEGApA0jaXuM/+4Um3B3QdIHAHr3/o=;
        b=A8EoGgrHhosCd6JpUSP33LKhs01acEPORY73SmkU5aT8kaUR7S4sfyTOLkfQlTm5Ve
         Ntq1nmYGxRd397rqdxtsbdCbQJxKK5rujw9uXAPBNOhWzCiW3FOtzmcEXDj3Mnb3JhWs
         CsEDOhOI6O3sl0mDm9FMpZIBtWZiCed4frTUg5uU2M/umg1VO2s8ltH4lTQJC7jZLcUv
         xdANpLQU8g8aXkiisnxmBy0uuKPcRgDPSlE1naWEtfH65vuCdkDo7kq63ryBxbgAKox5
         ggdTkt8YimYOwPYKdAki/dTLh81wfQ2Rb5RvFYj99lxOODgOtD0o7wtR1b+9hPHHFERq
         9vCA==
X-Gm-Message-State: AOAM530mtFSsjiY3+FzBk+q5kcqIFPLMI1hDM+siYg22KGFraQtHP1z8
        wIJowcbK5h5MnuKOchUb1cSpaQ==
X-Google-Smtp-Source: ABdhPJy1fYqWhk/nMQc7eASo1t7vayaZA8LoskEZQ75OPP6cBjFvwfhrjLO2mfLltmADfoi4BqIwSw==
X-Received: by 2002:a17:90b:380d:b0:1c7:223:c0d with SMTP id mq13-20020a17090b380d00b001c702230c0dmr4792212pjb.94.1647950992975;
        Tue, 22 Mar 2022 05:09:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:09:52 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 1/6] perf/core: Fix incosistency between cgroup sched_out and sched_in
Date:   Tue, 22 Mar 2022 20:08:29 +0800
Message-Id: <20220322120834.98637-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322120834.98637-1-zhouchengming@bytedance.com>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
in perf_cgroup_switch().

CPU1					CPU2
(in context_switch)			(attach running task)
perf_cgroup_sched_out(prev, next)
	cgrp1 == cgrp2 is True
					next->cgroups = cgrp3
					perf_cgroup_attach()
perf_cgroup_sched_in(prev, next)
	cgrp1 == cgrp3 is False

The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
context switch code") would save cpuctx switch out/in when the
perf_cgroup of "prev" and "next" are the same.

But perf_cgroup of task can change in concurrent with context_switch.
If cgrp1 == cgrp2 in sched_out(), cpuctx won't do switch out. Then
task perf_cgroup changed cause cgrp1 != cgrp2 in sched_in(), cpuctx
will do switch in, and trigger WARN_ON_ONCE(cpuctx->cgrp).

Even though perf_cgroup_switch will be synchronized as the context
switch disables the interrupt, it still can see the task->cgroups
is changing in the middle.

So this patch combine perf_cgroup_sched_in() into perf_cgroup_sched_out(),
rename to perf_cgroup_sched_switch(), to fix the incosistency between
cgroup sched_out and sched_in.

Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context switch code")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 101 ++++++++++---------------------------------
 1 file changed, 24 insertions(+), 77 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6859229497b1..8b5cf2aedfe6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -828,16 +828,10 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
 
-#define PERF_CGROUP_SWOUT	0x1 /* cgroup switch out every event */
-#define PERF_CGROUP_SWIN	0x2 /* cgroup switch in events based on task */
-
 /*
  * reschedule events based on the cgroup constraint of task.
- *
- * mode SWOUT : schedule out everything
- * mode SWIN : schedule in based on cgroup for next
  */
-static void perf_cgroup_switch(struct task_struct *task, int mode)
+static void perf_cgroup_switch(struct task_struct *task)
 {
 	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
@@ -856,28 +850,22 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
-		if (mode & PERF_CGROUP_SWOUT) {
-			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
-			/*
-			 * must not be done before ctxswout due
-			 * to event_filter_match() in event_sched_out()
-			 */
-			cpuctx->cgrp = NULL;
-		}
+		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
+		/*
+		 * must not be done before ctxswout due
+		 * to event_filter_match() in event_sched_out()
+		 */
+		cpuctx->cgrp = perf_cgroup_from_task(task,
+						     &cpuctx->ctx);
+		/*
+		 * set cgrp before ctxsw in to allow
+		 * event_filter_match() to not have to pass
+		 * task around
+		 * we pass the cpuctx->ctx to perf_cgroup_from_task()
+		 * because cgroup events are only per-cpu
+		 */
+		cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
 
-		if (mode & PERF_CGROUP_SWIN) {
-			WARN_ON_ONCE(cpuctx->cgrp);
-			/*
-			 * set cgrp before ctxsw in to allow
-			 * event_filter_match() to not have to pass
-			 * task around
-			 * we pass the cpuctx->ctx to perf_cgroup_from_task()
-			 * because cgorup events are only per-cpu
-			 */
-			cpuctx->cgrp = perf_cgroup_from_task(task,
-							     &cpuctx->ctx);
-			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
-		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 	}
@@ -885,8 +873,8 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	local_irq_restore(flags);
 }
 
-static inline void perf_cgroup_sched_out(struct task_struct *task,
-					 struct task_struct *next)
+static inline void perf_cgroup_sched_switch(struct task_struct *task,
+					    struct task_struct *next)
 {
 	struct perf_cgroup *cgrp1;
 	struct perf_cgroup *cgrp2 = NULL;
@@ -906,33 +894,7 @@ static inline void perf_cgroup_sched_out(struct task_struct *task,
 	 * do no touch the cgroup events.
 	 */
 	if (cgrp1 != cgrp2)
-		perf_cgroup_switch(task, PERF_CGROUP_SWOUT);
-
-	rcu_read_unlock();
-}
-
-static inline void perf_cgroup_sched_in(struct task_struct *prev,
-					struct task_struct *task)
-{
-	struct perf_cgroup *cgrp1;
-	struct perf_cgroup *cgrp2 = NULL;
-
-	rcu_read_lock();
-	/*
-	 * we come here when we know perf_cgroup_events > 0
-	 * we do not need to pass the ctx here because we know
-	 * we are holding the rcu lock
-	 */
-	cgrp1 = perf_cgroup_from_task(task, NULL);
-	cgrp2 = perf_cgroup_from_task(prev, NULL);
-
-	/*
-	 * only need to schedule in cgroup events if we are changing
-	 * cgroup during ctxsw. Cgroup events were not scheduled
-	 * out of ctxsw out if that was not the case.
-	 */
-	if (cgrp1 != cgrp2)
-		perf_cgroup_switch(task, PERF_CGROUP_SWIN);
+		perf_cgroup_switch(task);
 
 	rcu_read_unlock();
 }
@@ -1100,13 +1062,8 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 {
 }
 
-static inline void perf_cgroup_sched_out(struct task_struct *task,
-					 struct task_struct *next)
-{
-}
-
-static inline void perf_cgroup_sched_in(struct task_struct *prev,
-					struct task_struct *task)
+static inline void perf_cgroup_sched_switch(struct task_struct *task,
+					    struct task_struct *next)
 {
 }
 
@@ -1124,7 +1081,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 }
 
 static inline void
-perf_cgroup_switch(struct task_struct *task, struct task_struct *next)
+perf_cgroup_sched_switch(struct task_struct *task, struct task_struct *next)
 {
 }
 
@@ -3668,7 +3625,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * cgroup event are system-wide mode only
 	 */
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_out(task, next);
+		perf_cgroup_sched_switch(task, next);
 }
 
 /*
@@ -3984,16 +3941,6 @@ void __perf_event_task_sched_in(struct task_struct *prev,
 	struct perf_event_context *ctx;
 	int ctxn;
 
-	/*
-	 * If cgroup events exist on this CPU, then we need to check if we have
-	 * to switch in PMU state; cgroup event are system-wide mode only.
-	 *
-	 * Since cgroup events are CPU events, we must schedule these in before
-	 * we schedule in the task events.
-	 */
-	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_in(prev, task);
-
 	for_each_task_context_nr(ctxn) {
 		ctx = task->perf_event_ctxp[ctxn];
 		if (likely(!ctx))
@@ -13564,7 +13511,7 @@ static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
 	rcu_read_lock();
-	perf_cgroup_switch(task, PERF_CGROUP_SWOUT | PERF_CGROUP_SWIN);
+	perf_cgroup_switch(task);
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.20.1

