Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C804E5281
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiCWMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiCWMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:52:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673FE3E0F4;
        Wed, 23 Mar 2022 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FFkik+9BW7YNUY3b/IiErnWXIfw9P++METnOcRrULXg=; b=HJUJIfctKm+YSm0BKYs5EJVpXu
        URVOdRW401LuIn4nsJpbE3f0saMCn5SHLBA8TPplpY0U9JMq26uYDUC4CImELWUM2oGqCl9F0jn4z
        roHEamRkBkvokxlFHzbE8q2g8g3FheGOA3Z2a4LLLr1J3CTkuDIBJldcIzla4k08tKc3slN7+GtVT
        7mDylsUeu/IlBXpxhNx+2iToy+P+LObwuKkn4HUhZv/CnzjTtg1ovJc5evq2WE6ZlQrtMIDu6JfHB
        DRdDag3c6zmHrZ3sPWpMWp14UrClFAoCZUoODVVFPbDVJj00rcaQ/qPW23Jw94sD8vrW8KRwAmYZv
        zD29c1hw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX0SM-00CXZJ-4V; Wed, 23 Mar 2022 12:51:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60DC5986200; Wed, 23 Mar 2022 13:51:16 +0100 (CET)
Date:   Wed, 23 Mar 2022 13:51:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 2/6] perf/core: Introduce percpu perf_cgroup
Message-ID: <20220323125116.GX8939@worktop.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322120834.98637-3-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8b5cf2aedfe6..848a3bfa9513 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

> @@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
>  	 */
>  	local_irq_save(flags);
>  
> +	cgrp = perf_cgroup_from_task(task, NULL);
> +	if (cgrp == __this_cpu_read(cpu_perf_cgroup))
> +		goto out;
> +
> +	__this_cpu_write(cpu_perf_cgroup, cgrp);
> +
>  	list = this_cpu_ptr(&cgrp_cpuctx_list);
>  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>  
>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +		if (cpuctx->cgrp == cgrp)
> +			continue;
> +
>  		perf_pmu_disable(cpuctx->ctx.pmu);
>  
>  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);

This is just straight up broken.. you can't continue after taking a
lock, that'll miss unlock.

Also, I really don't see the point of cpu_perf_cgroup, cpuctx->cgrp
should be able to do this.

Also, perhaps merge this in the previous patch, I'm not sure it makes
sense to split this.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -833,6 +833,7 @@ static DEFINE_PER_CPU(struct list_head,
  */
 static void perf_cgroup_switch(struct task_struct *task)
 {
+	struct perf_cgroup *cgrp;
 	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
@@ -843,11 +844,20 @@ static void perf_cgroup_switch(struct ta
 	 */
 	local_irq_save(flags);
 
+	cgrp = perf_cgroup_from_task(task, NULL);
+
 	list = this_cpu_ptr(&cgrp_cpuctx_list);
 	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
 		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 
+		if (READ_ONCE(cpuctx->cgrp == cgrp))
+			continue
+
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+
+		if (cpuctx->cgrp == cgrp)
+			goto next;
+
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
 		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
@@ -855,50 +865,22 @@ static void perf_cgroup_switch(struct ta
 		 * must not be done before ctxswout due
 		 * to event_filter_match() in event_sched_out()
 		 */
-		cpuctx->cgrp = perf_cgroup_from_task(task,
-						     &cpuctx->ctx);
+		WRITE_ONCE(cpuctx->cgrp, cgrp);
 		/*
 		 * set cgrp before ctxsw in to allow
 		 * event_filter_match() to not have to pass
 		 * task around
-		 * we pass the cpuctx->ctx to perf_cgroup_from_task()
-		 * because cgroup events are only per-cpu
 		 */
 		cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
 
 		perf_pmu_enable(cpuctx->ctx.pmu);
+next:
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 	}
 
 	local_irq_restore(flags);
 }
 
-static inline void perf_cgroup_sched_switch(struct task_struct *task,
-					    struct task_struct *next)
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
-		perf_cgroup_switch(task);
-
-	rcu_read_unlock();
-}
-
 static int perf_cgroup_ensure_storage(struct perf_event *event,
 				struct cgroup_subsys_state *css)
 {
@@ -1062,11 +1044,6 @@ static inline void update_cgrp_time_from
 {
 }
 
-static inline void perf_cgroup_sched_switch(struct task_struct *task,
-					    struct task_struct *next)
-{
-}
-
 static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 				      struct perf_event_attr *attr,
 				      struct perf_event *group_leader)
@@ -1080,11 +1057,6 @@ perf_cgroup_set_timestamp(struct task_st
 {
 }
 
-static inline void
-perf_cgroup_sched_switch(struct task_struct *task, struct task_struct *next)
-{
-}
-
 static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
 	return 0;
@@ -1104,6 +1076,10 @@ static inline void
 perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
 {
 }
+
+static void perf_cgroup_switch(struct task_struct *task)
+{
+}
 #endif
 
 /*
@@ -3625,7 +3601,7 @@ void __perf_event_task_sched_out(struct
 	 * cgroup event are system-wide mode only
 	 */
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_sched_switch(task, next);
+		perf_cgroup_switch(next);
 }
 
 /*
