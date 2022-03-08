Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AA4D19E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbiCHOA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiCHOAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:00:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C04A3DE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:59:57 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b8so17244378pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 05:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ysQ0I/EueUfyxYIrrIDKfqfhbdL33TZ3WhPawjqUkZ4=;
        b=3EP48iIE+Hx1RVP6y/ZAg0qyMXVG9vYd+zLMSON/ec8MszlppWiJspyH7BgTHO213E
         SKa4KSp0LyLMYHXH1IZUiXZHdgWl+ev6CbJ1QeRjQUX83YbVaiItR0yTzIUnz75GBZ3y
         h+IDIWdS1cuPbUajzoDG0QS3Sk3rLlcKAuiAxf88bllH/TAwSiYcDwPJHPYF0Ti8dh2m
         VefwkbYMtcTlljYkcHvG6xE6oYl3NzsHSJE61ZyG3px2uLBGuUGwJvDo1+rYUSp3i2q5
         OvMG2UfJEly3s3Oe2puF6JnCgtpkA33h8wNSMTys4DhKnQqhhc3TIrnvJfZ8d+3SGEc7
         s2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ysQ0I/EueUfyxYIrrIDKfqfhbdL33TZ3WhPawjqUkZ4=;
        b=dF6alDdMBOvcrylIGx2NOqeF21Xs9DPtKlboh4DSpgc1T0okoITsBrsHjwSV4tJ5ul
         gG6J60fIyWJzst9jFKj39CIHr6gbyP9B2GFMH2lqhj/Pc31E5XQINWlbdQcAQreOh3/w
         kbLWZIIVcfmzynBbohDM2gNQWE3JZZX7zUW6jxlFlo2fq+pDQGDnp8ITXQriV4y0PZh1
         9vlB6QnTMoIWjb4sbBkX/gk8RVA6z5vehed7gi3N2A19NKw6bmKNxnAyQ/Gg7Suj8NiJ
         AwQFYDo/jdrs5RXOE3905GdEWQfh9W7G1m9GTiAgcEfJmsFDMNTKG3BCwm+6+GVtEimN
         1kqA==
X-Gm-Message-State: AOAM532mtIoOvEr/k14wDE0HjZKmAXIvOZKXtczXgHwmksaTpOeNznbS
        +jh0MQT8tOo4IgeqLbQizTIz/g==
X-Google-Smtp-Source: ABdhPJwDlg1le8x7719hCEXRfJpFagh+ixCjvOgRBd/mljn0RufhAGAMaVRmSQGIGYM/KfSmboJJlw==
X-Received: by 2002:a17:90b:1e47:b0:1bf:6d84:ca1d with SMTP id pi7-20020a17090b1e4700b001bf6d84ca1dmr4813655pjb.94.1646747997216;
        Tue, 08 Mar 2022 05:59:57 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a910400b001bd171c7fd4sm3020207pjo.25.2022.03.08.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:59:56 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH] perf/core: fix cpuctx cgrp warning
Date:   Tue,  8 Mar 2022 21:59:48 +0800
Message-Id: <20220308135948.55336-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
in perf_cgroup_switch().

CPU1					CPU2
(in context_switch)			(attach running task)
perf_cgroup_sched_out(task, next)
	if (cgrp1 != cgrp2) True
					task->cgroups = xxx
					perf_cgroup_attach()
perf_cgroup_sched_in(prev, task)
	if (cgrp1 != cgrp2) False

The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
context switch code") would save cpuctx switch in/out when the
perf_cgroup of "prev" and "next" are the same.

But perf_cgroup of task can change in concurrent with context_switch.
If cgrp1 == cgrp2 in sched_out(), cpuctx won't do switch out, then
task perf_cgroup changed cause cgrp1 != cgrp2 in sched_in(), cpuctx
will do switch in, and trigger WARN_ON_ONCE(cpuctx->cgrp).

The perf_cgroup of "prev" and "next" can be changed at any time, so we
first have to combine perf_cgroup_sched_in() into perf_cgroup_sched_out(),
so we can get a consistent value of condition (cgrp1 == cgrp2).

And we introduce a percpu "cpu_perf_cgroups" to track the current used
perf_cgroup, instead of using the unstable perf_cgroup of "prev", which
maybe not the cpuctx->cgrp we used to schedule cgroup events on cpu.

Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context
switch code")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 95 +++++++++++---------------------------------
 1 file changed, 23 insertions(+), 72 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6859229497b1..f3bc2841141f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	}
 }
 
+static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroups);
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
 
 #define PERF_CGROUP_SWOUT	0x1 /* cgroup switch out every event */
@@ -837,8 +838,9 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
  * mode SWOUT : schedule out everything
  * mode SWIN : schedule in based on cgroup for next
  */
-static void perf_cgroup_switch(struct task_struct *task, int mode)
+static void perf_cgroup_switch(struct task_struct *task)
 {
+	struct perf_cgroup *cgrp;
 	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
@@ -849,6 +851,9 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	 */
 	local_irq_save(flags);
 
+	cgrp = perf_cgroup_from_task(task, NULL);
+	__this_cpu_write(cpu_perf_cgroups, cgrp);
+
 	list = this_cpu_ptr(&cgrp_cpuctx_list);
 	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
 		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
@@ -856,28 +861,15 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
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
+		cpuctx->cgrp = cgrp;
+
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
@@ -885,8 +877,8 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	local_irq_restore(flags);
 }
 
-static inline void perf_cgroup_sched_out(struct task_struct *task,
-					 struct task_struct *next)
+static inline void perf_cgroup_sched_switch(struct task_struct *task,
+					    struct task_struct *next)
 {
 	struct perf_cgroup *cgrp1;
 	struct perf_cgroup *cgrp2 = NULL;
@@ -897,7 +889,7 @@ static inline void perf_cgroup_sched_out(struct task_struct *task,
 	 * we do not need to pass the ctx here because we know
 	 * we are holding the rcu lock
 	 */
-	cgrp1 = perf_cgroup_from_task(task, NULL);
+	cgrp1 = __this_cpu_read(cpu_perf_cgroups);
 	cgrp2 = perf_cgroup_from_task(next, NULL);
 
 	/*
@@ -906,33 +898,7 @@ static inline void perf_cgroup_sched_out(struct task_struct *task,
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
@@ -1100,13 +1066,8 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
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
 
@@ -1124,7 +1085,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 }
 
 static inline void
-perf_cgroup_switch(struct task_struct *task, struct task_struct *next)
+perf_cgroup_sched_switch(struct task_struct *task, struct task_struct *next)
 {
 }
 
@@ -3668,7 +3629,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * cgroup event are system-wide mode only
 	 */
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_out(task, next);
+		perf_cgroup_sched_switch(task, next);
 }
 
 /*
@@ -3984,16 +3945,6 @@ void __perf_event_task_sched_in(struct task_struct *prev,
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
@@ -13564,7 +13515,7 @@ static int __perf_cgroup_move(void *info)
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

