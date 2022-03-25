Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E094E6CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355968AbiCYD4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356473AbiCYDz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:55:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7753B00E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so2106269pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kViP0YZwCzQ2NYrGCdQJL04EDq6Hs7gB4dDqIa+z+FQ=;
        b=rZcHFNM9N5rPgY6bOsS1WHrzDFcD7H1ZlCh4SPwRhxG731//pxt+BUDFhy5yEpUDhQ
         nvnoBCHgvoXJ59QAXfS85SkaqNDlfYiHZXwbXCwAxUjby9PuA8G9t/1iOJJdvkHzE1wh
         n/iMCBA9F9NXzTrRMBCTq2nrTWvg8kwLFOXsv/zbHkV+mq3kEqWc15IpxNghfBhHprGB
         hMqVCVlFvarBfZoPReM7UXDaduqUXcxqyIWI7eK+GZyv9PCwyoWpdN37f7yxmhyVnCXF
         HbLlXKeAsmeLr/QgCRrE4zpsKgviyzxUoOuy8xTOiQeDivRSHqLgV8gpCt1wnWG1hDnb
         GHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kViP0YZwCzQ2NYrGCdQJL04EDq6Hs7gB4dDqIa+z+FQ=;
        b=6VIVTOrWaa/PrekCHMPzvbfEaIl1xeFlOFDPIz7fdvqDIqljKwkAlhQp2OIQDcyzPE
         A/8Ab5qaI2twtYrAvC54vc2bnMBMFjGcxNVxRL69weHiBrCJ4jm5HG6AlurZJkrrrb/m
         G362X+hXrsSfkB/HiBuHnN1ewrCleq4XM5f9Bah2HY5sZZTi1GOB92nBAnSDY4y+eCLh
         UjCS8+RgXTOVOPkEfXp0MZ78TJQcfnncIpjFAqFfIQWD9tuH5ZWfvYDOagMp4mnp3/UF
         kGqlFZVx5G4R0unILl5+zudxzrr0yaPMkIdfN+uOwpnXSGnmwFINTXJfYKk4uOj5qiWi
         18gA==
X-Gm-Message-State: AOAM531r/RlLcl9dNN35+g2JHdmKZogl3s/Xw2ZbxqIIYDFAj2KKPkcP
        1TpO1miOsFhs/EdmjkCuLpKQIQ==
X-Google-Smtp-Source: ABdhPJzMRWeLJFCAC3h4QaPVxwge1LOeOKXDMd75mDE1kd1eFPN4J6V5RcwrytxdIvze+g3n2+zPBA==
X-Received: by 2002:a17:90a:c595:b0:1c7:bb62:4487 with SMTP id l21-20020a17090ac59500b001c7bb624487mr7626491pjt.190.1648180462647;
        Thu, 24 Mar 2022 20:54:22 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:54:22 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 4/5] perf/core: Fix perf_cgroup_switch()
Date:   Fri, 25 Mar 2022 11:53:17 +0800
Message-Id: <20220325035318.42168-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325035318.42168-1-zhouchengming@bytedance.com>
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
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

CPU1						CPU2
perf_cgroup_sched_out(prev, next)
  cgrp1 = perf_cgroup_from_task(prev)
  cgrp2 = perf_cgroup_from_task(next)
  if (cgrp1 != cgrp2)
    perf_cgroup_switch(prev, PERF_CGROUP_SWOUT)
						cgroup_migrate_execute()
						  task->cgroups = ?
						  perf_cgroup_attach()
						    task_function_call(task, __perf_cgroup_move)
perf_cgroup_sched_in(prev, next)
  cgrp1 = perf_cgroup_from_task(prev)
  cgrp2 = perf_cgroup_from_task(next)
  if (cgrp1 != cgrp2)
    perf_cgroup_switch(next, PERF_CGROUP_SWIN)
						__perf_cgroup_move()
						  perf_cgroup_switch(task, PERF_CGROUP_SWOUT | PERF_CGROUP_SWIN)

The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
context switch code") want to skip perf_cgroup_switch() when the
perf_cgroup of "prev" and "next" are the same.

But task->cgroups can change in concurrent with context_switch()
in cgroup_migrate_execute(). If cgrp1 == cgrp2 in sched_out(),
cpuctx won't do sched_out. Then task->cgroups changed cause
cgrp1 != cgrp2 in sched_in(), cpuctx will do sched_in. So trigger
WARN_ON_ONCE(cpuctx->cgrp).

Even though __perf_cgroup_move() will be synchronized as the context
switch disables the interrupt, context_switch() still can see the
task->cgroups is changing in the middle, since task->cgroups changed
before sending IPI.

So we have to combine perf_cgroup_sched_in() into perf_cgroup_sched_out(),
unified into perf_cgroup_switch(), to fix the incosistency between
perf_cgroup_sched_out() and perf_cgroup_sched_in().

But we can't just compare prev->cgroups with next->cgroups to decide
whether to skip cpuctx sched_out/in since the prev->cgroups is changing
too. For example:

CPU1					CPU2
					cgroup_migrate_execute()
					  prev->cgroups = ?
					  perf_cgroup_attach()
					    task_function_call(task, __perf_cgroup_move)
perf_cgroup_switch(task)
  cgrp1 = perf_cgroup_from_task(prev)
  cgrp2 = perf_cgroup_from_task(next)
  if (cgrp1 != cgrp2)
    cpuctx sched_out/in ...
					task_function_call() will return -ESRCH

In the above example, prev->cgroups changing cause (cgrp1 == cgrp2)
to be true, so skip cpuctx sched_out/in. And later task_function_call()
would return -ESRCH since the prev task isn't running on cpu anymore.
So we would leave perf_events of the old prev->cgroups still sched on
the CPU, which is wrong.

The solution is that we should use cpuctx->cgrp to compare with
the next task's perf_cgroup. Since cpuctx->cgrp can only be changed
on local CPU, and we have irq disabled, we can read cpuctx->cgrp to
compare without holding ctx lock.

Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context switch code")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 133 ++++++++-----------------------------------
 1 file changed, 25 insertions(+), 108 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 225d408deb1a..d559fbbd3aaa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -824,17 +824,12 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 
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
+	struct perf_cgroup *cgrp;
 	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
@@ -845,36 +840,31 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	 */
 	local_irq_save(flags);
 
+	cgrp = perf_cgroup_from_task(task, NULL);
+
 	list = this_cpu_ptr(&cgrp_cpuctx_list);
 	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
 		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+		if (READ_ONCE(cpuctx->cgrp) == cgrp)
+			continue;
 
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
-		if (mode & PERF_CGROUP_SWOUT) {
-			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
-			/*
-			 * must not be done before ctxswout due
-			 * to update_cgrp_time_from_cpuctx() in
-			 * ctx_sched_out()
-			 */
-			cpuctx->cgrp = NULL;
-		}
+		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
+		/*
+		 * must not be done before ctxswout due
+		 * to update_cgrp_time_from_cpuctx() in
+		 * ctx_sched_out()
+		 */
+		cpuctx->cgrp = cgrp;
+		/*
+		 * set cgrp before ctxsw in to allow
+		 * perf_cgroup_set_timestamp() in ctx_sched_in()
+		 * to not have to pass task around
+		 */
+		cpu_ctx_sched_in(cpuctx, EVENT_ALL);
 
-		if (mode & PERF_CGROUP_SWIN) {
-			WARN_ON_ONCE(cpuctx->cgrp);
-			/*
-			 * set cgrp before ctxsw in to allow
-			 * perf_cgroup_set_timestamp() in ctx_sched_in()
-			 * to not have to pass task around
-			 * we pass the cpuctx->ctx to perf_cgroup_from_task()
-			 * because cgorup events are only per-cpu
-			 */
-			cpuctx->cgrp = perf_cgroup_from_task(task,
-							     &cpuctx->ctx);
-			cpu_ctx_sched_in(cpuctx, EVENT_ALL);
-		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 	}
@@ -882,58 +872,6 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	local_irq_restore(flags);
 }
 
-static inline void perf_cgroup_sched_out(struct task_struct *task,
-					 struct task_struct *next)
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
-	cgrp2 = perf_cgroup_from_task(next, NULL);
-
-	/*
-	 * only schedule out current cgroup events if we know
-	 * that we are switching to a different cgroup. Otherwise,
-	 * do no touch the cgroup events.
-	 */
-	if (cgrp1 != cgrp2)
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
-
-	rcu_read_unlock();
-}
-
 static int perf_cgroup_ensure_storage(struct perf_event *event,
 				struct cgroup_subsys_state *css)
 {
@@ -1097,16 +1035,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 {
 }
 
-static inline void perf_cgroup_sched_out(struct task_struct *task,
-					 struct task_struct *next)
-{
-}
-
-static inline void perf_cgroup_sched_in(struct task_struct *prev,
-					struct task_struct *task)
-{
-}
-
 static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
@@ -1119,11 +1047,6 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 {
 }
 
-static inline void
-perf_cgroup_switch(struct task_struct *task, struct task_struct *next)
-{
-}
-
 static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
 	return 0;
@@ -1143,6 +1066,10 @@ static inline void
 perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
 {
 }
+
+static void perf_cgroup_switch(struct task_struct *task)
+{
+}
 #endif
 
 /*
@@ -3662,7 +3589,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * cgroup event are system-wide mode only
 	 */
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_out(task, next);
+		perf_cgroup_switch(next);
 }
 
 /*
@@ -3973,16 +3900,6 @@ void __perf_event_task_sched_in(struct task_struct *prev,
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
@@ -13551,7 +13468,7 @@ static int __perf_cgroup_move(void *info)
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

