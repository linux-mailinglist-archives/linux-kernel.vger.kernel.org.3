Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4C4F3308
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 15:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354243AbiDEKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB39E0BC;
        Tue,  5 Apr 2022 01:29:05 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i0+diqyVMNWgh8Ab0Jc8rWl/N4lbwGKMcqHWQdo9Do=;
        b=2tsiTj1EVMc5l6ta4P8bhXa5tPRoUsd0VGMJhCG636KFsm8V8XIw2o0l7UZwFWxkmXuDB+
        JtKnaMZVrPH0sbBRRZWwIoJOOqP0pBjsY1+qa/H6zY5YiyUCsxV8zvgNpEuvWQQPEQmlGi
        q/u/IC3aM1e5gxZ1fuvjOA72jMz0DYf5Zteq+Gkpy5ylTZmmzXRs/F1l/IfWHqwTqqfT50
        9BYlV5HrmSaR5rXOPSz9J/264bOcxtd1HE/PUNPrElsCCRlXPO8tbQXZvs0PRpbQYzTqHY
        go3ogFs/C8rhjen8LYpvZ5Zvkcayerpmgb2aPKVzmaN75SVsqkqcMwZ/YCtZRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i0+diqyVMNWgh8Ab0Jc8rWl/N4lbwGKMcqHWQdo9Do=;
        b=qJ4dxfIATJ04NDkkg+q4xGP6JaNBNeE+KpLoQx0tx6F5KihLgBj/AWq076SUzNm2yEMYqb
        u0VfEtVcbdG4JlCw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix perf_cgroup_switch()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329154523.86438-4-zhouchengming@bytedance.com>
References: <20220329154523.86438-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164914734314.389.3848450686189412258.tip-bot2@tip-bot2>
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

Commit-ID:     96492a6c558acb56124844d1409d9ef8624a0322
Gitweb:        https://git.kernel.org/tip/96492a6c558acb56124844d1409d9ef8624a0322
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Tue, 29 Mar 2022 23:45:22 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:45 +02:00

perf/core: Fix perf_cgroup_switch()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220329154523.86438-4-zhouchengming@bytedance.com
---
 kernel/events/core.c | 132 +++++++-----------------------------------
 1 file changed, 25 insertions(+), 107 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a08fb92..bdeb41f 100644
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
@@ -845,35 +840,31 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
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
-			 * to event_filter_match() in event_sched_out()
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
@@ -881,58 +872,6 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
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
@@ -1096,16 +1035,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
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
@@ -1118,11 +1047,6 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
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
@@ -1142,6 +1066,10 @@ static inline void
 perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
 {
 }
+
+static void perf_cgroup_switch(struct task_struct *task)
+{
+}
 #endif
 
 /*
@@ -3661,7 +3589,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * cgroup event are system-wide mode only
 	 */
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_out(task, next);
+		perf_cgroup_switch(next);
 }
 
 /*
@@ -3975,16 +3903,6 @@ void __perf_event_task_sched_in(struct task_struct *prev,
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
@@ -13556,7 +13474,7 @@ static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
 	rcu_read_lock();
-	perf_cgroup_switch(task, PERF_CGROUP_SWOUT | PERF_CGROUP_SWIN);
+	perf_cgroup_switch(task);
 	rcu_read_unlock();
 	return 0;
 }
