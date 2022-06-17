Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF33854F864
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiFQNhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiFQNhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:37:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021230F6F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WTZjpmSd9Sa8I5fXdqOJI0Hd0b041Bi/Q5/PQGVy9v4=; b=eR4ZWbWomSPuYSDUvbBqn1HdAG
        SG3LsoZRz7xC6B/Lll6d+WfGR8cIks43mTHnPg0XJdhZZ2hLEUt2Cp4N9loXZsaeys+7FO02nRNwy
        6iI0ffNCls6cK3kED5vQ6QD6O6pW82sdZsDDtCHiszlejfAtU6/NGgozmK9FRDVtBkuscWEBQDDnu
        SDT0ZKSEImQSkcsbEK8/MBjI8WpykjdusbzCyRefdW1G4SrWpSP7Bi1/hqI0ZxycBLQ/tHFcimkGy
        12oZUSD1c92eT/2wHl6ZxS47HWSaDZcv3bIY87O3NdOco52PrEZszvGnDNsNx8/B9gih0uh2kD5i3
        gwEzqv6g==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2C9b-008hWW-NE; Fri, 17 Jun 2022 13:36:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A1279816B5; Fri, 17 Jun 2022 15:36:51 +0200 (CEST)
Date:   Fri, 17 Jun 2022 15:36:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YqyDc0i3C9OpNiPx@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> +/* XXX: No need of list now. Convert it to per-cpu variable */
>  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);

Something like so I suppose...

---
 include/linux/perf_event.h |    1 
 kernel/events/core.c       |   70 ++++++++++++++-------------------------------
 2 files changed, 22 insertions(+), 49 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -936,7 +936,6 @@ struct perf_cpu_context {
 
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
-	struct list_head		cgrp_cpuctx_entry;
 #endif
 
 	/*
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -829,55 +829,41 @@ perf_cgroup_set_timestamp(struct perf_cp
 	}
 }
 
-/* XXX: No need of list now. Convert it to per-cpu variable */
-static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
-
 /*
  * reschedule events based on the cgroup constraint of task.
  */
 static void perf_cgroup_switch(struct task_struct *task)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct perf_cgroup *cgrp;
-	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
 
-	/*
-	 * Disable interrupts and preemption to avoid this CPU's
-	 * cgrp_cpuctx_entry to change under us.
-	 */
-	local_irq_save(flags);
-
 	cgrp = perf_cgroup_from_task(task, NULL);
 
-	list = this_cpu_ptr(&cgrp_cpuctx_list);
-	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
-		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
-		if (READ_ONCE(cpuctx->cgrp) == cgrp)
-			continue;
-
-		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-		perf_ctx_disable(&cpuctx->ctx);
+	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+	if (READ_ONCE(cpuctx->cgrp) == cgrp)
+		continue;
 
-		ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
-		/*
-		 * must not be done before ctxswout due
-		 * to update_cgrp_time_from_cpuctx() in
-		 * ctx_sched_out()
-		 */
-		cpuctx->cgrp = cgrp;
-		/*
-		 * set cgrp before ctxsw in to allow
-		 * perf_cgroup_set_timestamp() in ctx_sched_in()
-		 * to not have to pass task around
-		 */
-		ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
+	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	perf_ctx_disable(&cpuctx->ctx);
 
-		perf_ctx_enable(&cpuctx->ctx);
-		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-	}
+	ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
+	/*
+	 * must not be done before ctxswout due
+	 * to update_cgrp_time_from_cpuctx() in
+	 * ctx_sched_out()
+	 */
+	cpuctx->cgrp = cgrp;
+	/*
+	 * set cgrp before ctxsw in to allow
+	 * perf_cgroup_set_timestamp() in ctx_sched_in()
+	 * to not have to pass task around
+	 */
+	ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
 
-	local_irq_restore(flags);
+	perf_ctx_enable(&cpuctx->ctx);
+	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,
@@ -979,8 +965,6 @@ perf_cgroup_event_enable(struct perf_eve
 		return;
 
 	cpuctx->cgrp = perf_cgroup_from_task(current, ctx);
-	list_add(&cpuctx->cgrp_cpuctx_entry,
-			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
 }
 
 static inline void
@@ -1001,7 +985,6 @@ perf_cgroup_event_disable(struct perf_ev
 		return;
 
 	cpuctx->cgrp = NULL;
-	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -2372,11 +2355,7 @@ static void perf_remove_from_context(str
 	 * event_function_call() user.
 	 */
 	raw_spin_lock_irq(&ctx->lock);
-	/*
-	 * Cgroup events are per-cpu events, and must IPI because of
-	 * cgrp_cpuctx_list.
-	 */
-	if (!ctx->is_active && !is_cgroup_event(event)) {
+	if (!ctx->is_active) {
 		__perf_remove_from_context(event, this_cpu_ptr(&cpu_context),
 					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
@@ -2807,8 +2786,6 @@ perf_install_in_context(struct perf_even
 	 * perf_event_attr::disabled events will not run and can be initialized
 	 * without IPI. Except when this is the first event for the context, in
 	 * that case we need the magic of the IPI to set ctx->is_active.
-	 * Similarly, cgroup events for the context also needs the IPI to
-	 * manipulate the cgrp_cpuctx_list.
 	 *
 	 * The IOC_ENABLE that is sure to follow the creation of a disabled
 	 * event will issue the IPI and reprogram the hardware.
@@ -13301,9 +13278,6 @@ static void __init perf_event_init_all_c
 		INIT_LIST_HEAD(&per_cpu(pmu_sb_events.list, cpu));
 		raw_spin_lock_init(&per_cpu(pmu_sb_events.lock, cpu));
 
-#ifdef CONFIG_CGROUP_PERF
-		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
-#endif
 		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 
 		cpuctx = per_cpu_ptr(&cpu_context, cpu);
