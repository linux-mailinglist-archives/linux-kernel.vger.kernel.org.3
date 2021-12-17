Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB347918C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhLQQfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhLQQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:35:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EO1YbCZoF48PTxZvWH9wDk6ldrGxeni25kmqpTC4lBc=; b=rbxQAwUZHW1I56vAywmulXH58A
        cW3GNvDVwWKWULdrJMVyK+CbFRV4YoijCoUJfI0PJuC9xP0g+YNrkX9UqTepyjr/2LkYI06DrvWVO
        A/lnMujfWEGmVaqksEGjTjOVqVHTSM2k5KxpLlAo2q8taRPRf60jB9nMiLkH2wkVE/BLxOAo+nVMT
        6xpKvDvsaQyyLyIDZtTrztLoNjIxrxZD+pqWtem2GjCo4Y0FLXx1YijwcMF6Thz+DSQoTbffC4XbW
        w9v/jc2G8Us4KfBlkuQvPOqW4Ofw2ucXKfifPtsMuxpEKpoC1WV2v7Eg1tQLUZObpTuJ1Dei3nlW2
        VmJNEi+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myGCZ-00GsVc-Se; Fri, 17 Dec 2021 16:35:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20C60300252;
        Fri, 17 Dec 2021 17:35:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE7D620C87570; Fri, 17 Dec 2021 17:35:22 +0100 (CET)
Date:   Fri, 17 Dec 2021 17:35:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210103341.GS16608@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:33:41AM +0100, Peter Zijlstra wrote:

> I'm thinking this is a cgroup specific thing. Normally the shadow_time
> thing is simply a relative displacement between event-time and the
> global clock. That displacement never changes, except when you do
> IOC_DISABLE/IOC_ENABLE.
> 
> However, for cgroup things are different, since the cgroup events aren't
> unconditionally runnable, that is, the enabled time should only count
> when the cgroup is active, right?
> 
> So perhaps perf_event_read_local() should use a cgroup clock instead of
> perf_clock() for cgroup events.
> 
> Let me think about that some more...

How's this then? Song, could you also please test and or better explain
the problem f79256532682 pretends to cure? Because the below is
reverting that, I *really* hate having to touch the events we're not
scheduling.

So basically enabled runs at ctx->time (or cgroup->info->time) rate but
is offset, the 0-point is when the event is first ENABLED (assuming it
is never disabled thereafter).

Now, ctx->time advances as long as a single event lives in the context,
which means the event's enabled time should advance right along with it,
irrespective of when that even last scheduled.

So the value we need to compute is ctx->time, and shadow_ctx_time is in
completely the wrong place (event vs ctx).

The crucial bit seems to be we should not advance ctx time when the
context isn't actually active. regular ctx seems to have most of the
bits there, except some ordering, while cgroup->info needs to track
activity.

*very* lightly tested, please give it a spin and contribute to perf-test
all failures observed or something.

---
 include/linux/perf_event.h |  15 +---
 kernel/events/core.c       | 214 ++++++++++++++++++++++-----------------------
 2 files changed, 107 insertions(+), 122 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7b7525e9155f..62b921561072 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -683,18 +683,6 @@ struct perf_event {
 	u64				total_time_running;
 	u64				tstamp;
 
-	/*
-	 * timestamp shadows the actual context timing but it can
-	 * be safely used in NMI interrupt context. It reflects the
-	 * context time as it was when the event was last scheduled in,
-	 * or when ctx_sched_in failed to schedule the event because we
-	 * run out of PMC.
-	 *
-	 * ctx_time already accounts for ctx->timestamp. Therefore to
-	 * compute ctx_time for a sample, simply add perf_clock().
-	 */
-	u64				shadow_ctx_time;
-
 	struct perf_event_attr		attr;
 	u16				header_size;
 	u16				id_header_size;
@@ -841,6 +829,7 @@ struct perf_event_context {
 	 */
 	u64				time;
 	u64				timestamp;
+	u64				timeoffset;
 
 	/*
 	 * These fields let us detect when two contexts have both
@@ -923,6 +912,8 @@ struct bpf_perf_event_data_kern {
 struct perf_cgroup_info {
 	u64				time;
 	u64				timestamp;
+	u64				timeoffset;
+	int				active;
 };
 
 struct perf_cgroup {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e364ea5bf167..08e5e9f1a155 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -719,34 +719,54 @@ static inline u64 perf_cgroup_event_time(struct perf_event *event)
 	return t->time;
 }
 
-static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
+static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
 {
-	struct perf_cgroup_info *info;
-	u64 now;
-
-	now = perf_clock();
+	struct perf_cgroup_info *t;
 
-	info = this_cpu_ptr(cgrp->info);
+	t = per_cpu_ptr(event->cgrp->info, event->cpu);
+	if (!t->active) {
+		barrier();
+		return t->time;
+	}
+	now += READ_ONCE(t->timeoffset);
+	return now;
+}
 
+static inline void __update_cgrp_time(struct perf_cgroup_info *info, u64 now)
+{
 	info->time += now - info->timestamp;
 	info->timestamp = now;
+	/*
+	 * see update_context_time()
+	 */
+	WRITE_ONCE(info->timeoffset, info->time - info->timestamp);
 }
 
-static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
+static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
 {
 	struct perf_cgroup *cgrp = cpuctx->cgrp;
 	struct cgroup_subsys_state *css;
+	struct perf_cgroup_info *info;
 
 	if (cgrp) {
+		u64 now = perf_clock();
+
 		for (css = &cgrp->css; css; css = css->parent) {
 			cgrp = container_of(css, struct perf_cgroup, css);
-			__update_cgrp_time(cgrp);
+			info = this_cpu_ptr(cgrp->info);
+
+			__update_cgrp_time(info, now);
+			if (final) {
+				barrier();
+				info->active = 0;
+			}
 		}
 	}
 }
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
+	struct perf_cgroup_info *info;
 	struct perf_cgroup *cgrp;
 
 	/*
@@ -760,8 +780,10 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	/*
 	 * Do not update time when cgroup is not active
 	 */
-	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
-		__update_cgrp_time(event->cgrp);
+	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
+		info = this_cpu_ptr(event->cgrp->info);
+		__update_cgrp_time(info, perf_clock());
+	}
 }
 
 static inline void
@@ -786,6 +808,8 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 		cgrp = container_of(css, struct perf_cgroup, css);
 		info = this_cpu_ptr(cgrp->info);
 		info->timestamp = ctx->timestamp;
+		barrier();
+		info->active = 1;
 	}
 }
 
@@ -981,14 +1005,6 @@ static inline int perf_cgroup_connect(int fd, struct perf_event *event,
 	return ret;
 }
 
-static inline void
-perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
-{
-	struct perf_cgroup_info *t;
-	t = per_cpu_ptr(event->cgrp->info, event->cpu);
-	event->shadow_ctx_time = now - t->timestamp;
-}
-
 static inline void
 perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -1066,7 +1082,8 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
 }
 
-static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
+static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
+						bool final)
 {
 }
 
@@ -1098,12 +1115,12 @@ perf_cgroup_switch(struct task_struct *task, struct task_struct *next)
 {
 }
 
-static inline void
-perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
+static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
+	return 0;
 }
 
-static inline u64 perf_cgroup_event_time(struct perf_event *event)
+static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
 {
 	return 0;
 }
@@ -1531,16 +1548,48 @@ static void update_context_time(struct perf_event_context *ctx)
 
 	ctx->time += now - ctx->timestamp;
 	ctx->timestamp = now;
+
+	/*
+	 * The above: time' = time + (now - timestamp), can be re-arranged
+	 * into: time` = now + (time - timestamp), which gives a single value
+	 * offset to compute future time without locks on.
+	 *
+	 * See perf_event_time_now(), which can be used from NMI context where
+	 * it's (obviously) not possible to acquire ctx->lock in order to read
+	 * both the above values in a consistent manner.
+	 */
+	WRITE_ONCE(ctx->timeoffset, ctx->time - ctx->timestamp);
 }
 
 static u64 perf_event_time(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
 
+	if (unlikely(!ctx))
+		return 0;
+
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
 
-	return ctx ? ctx->time : 0;
+	return ctx->time;
+}
+
+static u64 perf_event_time_now(struct perf_event *event, u64 now)
+{
+	struct perf_event_context *ctx = event->ctx;
+
+	if (unlikely(!ctx))
+		return 0;
+
+	if (is_cgroup_event(event))
+		return perf_cgroup_event_time_now(event, now);
+
+	if (!(ctx->is_active & EVENT_TIME)) {
+		barrier();
+		return ctx->time;
+	}
+	now += READ_ONCE(ctx->timeoffset);
+	return now;
 }
 
 static enum event_type_t get_event_type(struct perf_event *event)
@@ -2346,7 +2395,7 @@ __perf_remove_from_context(struct perf_event *event,
 
 	if (ctx->is_active & EVENT_TIME) {
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
 	event_sched_out(event, cpuctx, ctx);
@@ -2357,6 +2406,9 @@ __perf_remove_from_context(struct perf_event *event,
 	list_del_event(event, ctx);
 
 	if (!ctx->nr_events && ctx->is_active) {
+		if (ctx == &cpuctx->ctx)
+			update_cgrp_time_from_cpuctx(cpuctx, true);
+
 		ctx->is_active = 0;
 		ctx->rotate_necessary = 0;
 		if (ctx->task) {
@@ -2478,40 +2530,6 @@ void perf_event_disable_inatomic(struct perf_event *event)
 	irq_work_queue(&event->pending);
 }
 
-static void perf_set_shadow_time(struct perf_event *event,
-				 struct perf_event_context *ctx)
-{
-	/*
-	 * use the correct time source for the time snapshot
-	 *
-	 * We could get by without this by leveraging the
-	 * fact that to get to this function, the caller
-	 * has most likely already called update_context_time()
-	 * and update_cgrp_time_xx() and thus both timestamp
-	 * are identical (or very close). Given that tstamp is,
-	 * already adjusted for cgroup, we could say that:
-	 *    tstamp - ctx->timestamp
-	 * is equivalent to
-	 *    tstamp - cgrp->timestamp.
-	 *
-	 * Then, in perf_output_read(), the calculation would
-	 * work with no changes because:
-	 * - event is guaranteed scheduled in
-	 * - no scheduled out in between
-	 * - thus the timestamp would be the same
-	 *
-	 * But this is a bit hairy.
-	 *
-	 * So instead, we have an explicit cgroup call to remain
-	 * within the time source all along. We believe it
-	 * is cleaner and simpler to understand.
-	 */
-	if (is_cgroup_event(event))
-		perf_cgroup_set_shadow_time(event, event->tstamp);
-	else
-		event->shadow_ctx_time = event->tstamp - ctx->timestamp;
-}
-
 #define MAX_INTERRUPTS (~0ULL)
 
 static void perf_log_throttle(struct perf_event *event, int enable);
@@ -2552,8 +2570,6 @@ event_sched_in(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	perf_set_shadow_time(event, ctx);
-
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
@@ -3247,16 +3263,6 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 		return;
 	}
 
-	ctx->is_active &= ~event_type;
-	if (!(ctx->is_active & EVENT_ALL))
-		ctx->is_active = 0;
-
-	if (ctx->task) {
-		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
-		if (!ctx->is_active)
-			cpuctx->task_ctx = NULL;
-	}
-
 	/*
 	 * Always update time if it was set; not only when it changes.
 	 * Otherwise we can 'forget' to update time for any but the last
@@ -3270,7 +3276,18 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (is_active & EVENT_TIME) {
 		/* update (and stop) ctx time */
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx);
+		update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
+		barrier();
+	}
+
+	ctx->is_active &= ~event_type;
+	if (!(ctx->is_active & EVENT_ALL))
+		ctx->is_active = 0;
+
+	if (ctx->task) {
+		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
+		if (!ctx->is_active)
+			cpuctx->task_ctx = NULL;
 	}
 
 	is_active ^= ctx->is_active; /* changed bits */
@@ -3707,29 +3724,6 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
-static inline bool event_update_userpage(struct perf_event *event)
-{
-	if (likely(!atomic_read(&event->mmap_count)))
-		return false;
-
-	perf_event_update_time(event);
-	perf_set_shadow_time(event, event->ctx);
-	perf_event_update_userpage(event);
-
-	return true;
-}
-
-static inline void group_update_userpage(struct perf_event *group_event)
-{
-	struct perf_event *event;
-
-	if (!event_update_userpage(group_event))
-		return;
-
-	for_each_sibling_event(event, group_event)
-		event_update_userpage(event);
-}
-
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
@@ -3748,15 +3742,14 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
-		*can_add_hw = 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-		} else {
-			ctx->rotate_necessary = 1;
-			perf_mux_hrtimer_restart(cpuctx);
-			group_update_userpage(event);
 		}
+
+		*can_add_hw = 0;
+		ctx->rotate_necessary = 1;
+		perf_mux_hrtimer_restart(cpuctx);
 	}
 
 	return 0;
@@ -3804,6 +3797,14 @@ ctx_sched_in(struct perf_event_context *ctx,
 	if (likely(!ctx->nr_events))
 		return;
 
+	if (is_active ^ EVENT_TIME) {
+		/* start ctx time */
+		now = perf_clock();
+		ctx->timestamp = now;
+		perf_cgroup_set_timestamp(task, ctx);
+		barrier();
+	}
+
 	ctx->is_active |= (event_type | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
@@ -3814,13 +3815,6 @@ ctx_sched_in(struct perf_event_context *ctx,
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	if (is_active & EVENT_TIME) {
-		/* start ctx time */
-		now = perf_clock();
-		ctx->timestamp = now;
-		perf_cgroup_set_timestamp(task, ctx);
-	}
-
 	/*
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
@@ -4473,10 +4467,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 
 	*value = local64_read(&event->count);
 	if (enabled || running) {
-		u64 now = event->shadow_ctx_time + perf_clock();
+		u64 ctx_time, now = perf_clock();
 		u64 __enabled, __running;
 
-		__perf_update_times(event, now, &__enabled, &__running);
+		ctx_time = perf_event_time_now(event, now);
+		__perf_update_times(event, ctx_time, &__enabled, &__running);
 		if (enabled)
 			*enabled = __enabled;
 		if (running)
@@ -5806,7 +5801,7 @@ static void calc_timer_values(struct perf_event *event,
 	u64 ctx_time;
 
 	*now = perf_clock();
-	ctx_time = event->shadow_ctx_time + *now;
+	ctx_time = perf_event_time_now(event, *now);
 	__perf_update_times(event, ctx_time, enabled, running);
 }
 
@@ -6349,7 +6344,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		ring_buffer_attach(event, rb);
 
 		perf_event_update_time(event);
-		perf_set_shadow_time(event, event->ctx);
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 	} else {
