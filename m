Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4717849248E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiARLSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiARLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:17:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC9DC061574;
        Tue, 18 Jan 2022 03:17:57 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:17:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4inixnbD9GSpvHe4grAS2BrtRQ7uQCukD729Jl4x8EM=;
        b=b840H7U32lPIPBCsBCH2As/5keiKKtfSbFLXilixcFeqjwUcv1MPF2aEhVRV3sDot+X94/
        rVX0/Wkx5g8+XPCe6NL8Jc33SMEgDr9QRXhLicsKnTVFVxibT/UHXYVSZU47HHdvKgS752
        Ztc2504l5pvVgvm2Ifxy8vj9RWolVxpPwUNUZxGqXCyn5utiJ28vjdX4BwCFx+FrMYIQHx
        BHgvC2AWMfahFB0ZQ0SAsvnTU71cexwwdOVFpEERCK/gV6TOZMaHURseqXm92QX7/xYas5
        br/b+zSbimNnLWweHhKR8TElg/y6RnOS1aF75GZxzevDlzi3PFGNk9fQ4XXuSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4inixnbD9GSpvHe4grAS2BrtRQ7uQCukD729Jl4x8EM=;
        b=VXbgmJm+m63qQTxLqwpwRXxh6B4kgxk4bYCtp0RSL7aM0x44PG+P43htkWLg8YibVLK6DI
        9488f0SmU4m3fBDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix perf_event_read_local() time
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Song Liu <song@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
References: <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164250467510.16921.8580035251247783944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     09f5e7dc7ad705289e1b1ec065439aa3c42951c4
Gitweb:        https://git.kernel.org/tip/09f5e7dc7ad705289e1b1ec065439aa3c42951c4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Dec 2021 13:19:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:47 +01:00

perf: Fix perf_event_read_local() time

Time readers that cannot take locks (due to NMI etc..) currently make
use of perf_event::shadow_ctx_time, which, for that event gives:

  time' = now + (time - timestamp)

or, alternatively arranged:

  time' = time + (now - timestamp)

IOW, the progression of time since the last time the shadow_ctx_time
was updated.

There's problems with this:

 A) the shadow_ctx_time is per-event, even though the ctx_time it
    reflects is obviously per context. The direct concequence of this
    is that the context needs to iterate all events all the time to
    keep the shadow_ctx_time in sync.

 B) even with the prior point, the context itself might not be active
    meaning its time should not advance to begin with.

 C) shadow_ctx_time isn't consistently updated when ctx_time is

There are 3 users of this stuff, that suffer differently from this:

 - calc_timer_values()
   - perf_output_read()
   - perf_event_update_userpage()	/* A */

 - perf_event_read_local()		/* A,B */

In particular, perf_output_read() doesn't suffer at all, because it's
sample driven and hence only relevant when the event is actually
running.

This same was supposed to be true for perf_event_update_userpage(),
after all self-monitoring implies the context is active *HOWEVER*, as
per commit f79256532682 ("perf/core: fix userpage->time_enabled of
inactive events") this goes wrong when combined with counter
overcommit, in that case those events that do not get scheduled when
the context becomes active (task events typically) miss out on the
EVENT_TIME update and ENABLED time is inflated (for a little while)
with the time the context was inactive. Once the event gets rotated
in, this gets corrected, leading to a non-monotonic timeflow.

perf_event_read_local() made things even worse, it can request time at
any point, suffering all the problems perf_event_update_userpage()
does and more. Because while perf_event_update_userpage() is limited
by the context being active, perf_event_read_local() users have no
such constraint.

Therefore, completely overhaul things and do away with
perf_event::shadow_ctx_time. Instead have regular context time updates
keep track of this offset directly and provide perf_event_time_now()
to complement perf_event_time().

perf_event_time_now() will, in adition to being context wide, also
take into account if the context is active. For inactive context, it
will not advance time.

This latter property means the cgroup perf_cgroup_info context needs
to grow addition state to track this.

Additionally, since all this is strictly per-cpu, we can use barrier()
to order context activity vs context time.

Fixes: 7d9285e82db5 ("perf/bpf: Extend the perf_event_read_local() interface, a.k.a. "bpf: perf event change needed for subsequent bpf helpers"")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Song Liu <song@kernel.org>
Tested-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/YcB06DasOBtU0b00@hirez.programming.kicks-ass.net
---
 include/linux/perf_event.h |  15 +--
 kernel/events/core.c       | 246 +++++++++++++++++++++---------------
 2 files changed, 149 insertions(+), 112 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 117f230..7336491 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -693,18 +693,6 @@ struct perf_event {
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
@@ -852,6 +840,7 @@ struct perf_event_context {
 	 */
 	u64				time;
 	u64				timestamp;
+	u64				timeoffset;
 
 	/*
 	 * These fields let us detect when two contexts have both
@@ -934,6 +923,8 @@ struct bpf_perf_event_data_kern {
 struct perf_cgroup_info {
 	u64				time;
 	u64				timestamp;
+	u64				timeoffset;
+	int				active;
 };
 
 struct perf_cgroup {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc18664..479c9e6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -674,6 +674,23 @@ perf_event_set_state(struct perf_event *event, enum perf_event_state state)
 	WRITE_ONCE(event->state, state);
 }
 
+/*
+ * UP store-release, load-acquire
+ */
+
+#define __store_release(ptr, val)					\
+do {									\
+	barrier();							\
+	WRITE_ONCE(*(ptr), (val));					\
+} while (0)
+
+#define __load_acquire(ptr)						\
+({									\
+	__unqual_scalar_typeof(*(ptr)) ___p = READ_ONCE(*(ptr));	\
+	barrier();							\
+	___p;								\
+})
+
 #ifdef CONFIG_CGROUP_PERF
 
 static inline bool
@@ -719,34 +736,51 @@ static inline u64 perf_cgroup_event_time(struct perf_event *event)
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
+	if (!__load_acquire(&t->active))
+		return t->time;
+	now += READ_ONCE(t->timeoffset);
+	return now;
+}
 
-	info->time += now - info->timestamp;
+static inline void __update_cgrp_time(struct perf_cgroup_info *info, u64 now, bool adv)
+{
+	if (adv)
+		info->time += now - info->timestamp;
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
+			__update_cgrp_time(info, now, true);
+			if (final)
+				__store_release(&info->active, 0);
 		}
 	}
 }
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
+	struct perf_cgroup_info *info;
 	struct perf_cgroup *cgrp;
 
 	/*
@@ -760,8 +794,10 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	/*
 	 * Do not update time when cgroup is not active
 	 */
-	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
-		__update_cgrp_time(event->cgrp);
+	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
+		info = this_cpu_ptr(event->cgrp->info);
+		__update_cgrp_time(info, perf_clock(), true);
+	}
 }
 
 static inline void
@@ -785,7 +821,8 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	for (css = &cgrp->css; css; css = css->parent) {
 		cgrp = container_of(css, struct perf_cgroup, css);
 		info = this_cpu_ptr(cgrp->info);
-		info->timestamp = ctx->timestamp;
+		__update_cgrp_time(info, ctx->timestamp, false);
+		__store_release(&info->active, 1);
 	}
 }
 
@@ -982,14 +1019,6 @@ out:
 }
 
 static inline void
-perf_cgroup_set_shadow_time(struct perf_event *event, u64 now)
-{
-	struct perf_cgroup_info *t;
-	t = per_cpu_ptr(event->cgrp->info, event->cpu);
-	event->shadow_ctx_time = now - t->timestamp;
-}
-
-static inline void
 perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_cpu_context *cpuctx;
@@ -1066,7 +1095,8 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
 }
 
-static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
+static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
+						bool final)
 {
 }
 
@@ -1098,12 +1128,12 @@ perf_cgroup_switch(struct task_struct *task, struct task_struct *next)
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
@@ -1525,22 +1555,59 @@ static void perf_unpin_context(struct perf_event_context *ctx)
 /*
  * Update the record of the current time in a context.
  */
-static void update_context_time(struct perf_event_context *ctx)
+static void __update_context_time(struct perf_event_context *ctx, bool adv)
 {
 	u64 now = perf_clock();
 
-	ctx->time += now - ctx->timestamp;
+	if (adv)
+		ctx->time += now - ctx->timestamp;
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
+}
+
+static void update_context_time(struct perf_event_context *ctx)
+{
+	__update_context_time(ctx, true);
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
+	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
+		return ctx->time;
+
+	now += READ_ONCE(ctx->timeoffset);
+	return now;
 }
 
 static enum event_type_t get_event_type(struct perf_event *event)
@@ -2350,7 +2417,7 @@ __perf_remove_from_context(struct perf_event *event,
 
 	if (ctx->is_active & EVENT_TIME) {
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
 	event_sched_out(event, cpuctx, ctx);
@@ -2361,6 +2428,9 @@ __perf_remove_from_context(struct perf_event *event,
 	list_del_event(event, ctx);
 
 	if (!ctx->nr_events && ctx->is_active) {
+		if (ctx == &cpuctx->ctx)
+			update_cgrp_time_from_cpuctx(cpuctx, true);
+
 		ctx->is_active = 0;
 		ctx->rotate_necessary = 0;
 		if (ctx->task) {
@@ -2482,40 +2552,6 @@ void perf_event_disable_inatomic(struct perf_event *event)
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
@@ -2556,8 +2592,6 @@ event_sched_in(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	perf_set_shadow_time(event, ctx);
-
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
@@ -3251,16 +3285,6 @@ static void ctx_sched_out(struct perf_event_context *ctx,
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
@@ -3274,7 +3298,22 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 	if (is_active & EVENT_TIME) {
 		/* update (and stop) ctx time */
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx);
+		update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
+		/*
+		 * CPU-release for the below ->is_active store,
+		 * see __load_acquire() in perf_event_time_now()
+		 */
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
@@ -3711,13 +3750,19 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
+/*
+ * Because the userpage is strictly per-event (there is no concept of context,
+ * so there cannot be a context indirection), every userpage must be updated
+ * when context time starts :-(
+ *
+ * IOW, we must not miss EVENT_TIME edges.
+ */
 static inline bool event_update_userpage(struct perf_event *event)
 {
 	if (likely(!atomic_read(&event->mmap_count)))
 		return false;
 
 	perf_event_update_time(event);
-	perf_set_shadow_time(event, event->ctx);
 	perf_event_update_userpage(event);
 
 	return true;
@@ -3801,13 +3846,23 @@ ctx_sched_in(struct perf_event_context *ctx,
 	     struct task_struct *task)
 {
 	int is_active = ctx->is_active;
-	u64 now;
 
 	lockdep_assert_held(&ctx->lock);
 
 	if (likely(!ctx->nr_events))
 		return;
 
+	if (is_active ^ EVENT_TIME) {
+		/* start ctx time */
+		__update_context_time(ctx, false);
+		perf_cgroup_set_timestamp(task, ctx);
+		/*
+		 * CPU-release for the below ->is_active store,
+		 * see __load_acquire() in perf_event_time_now()
+		 */
+		barrier();
+	}
+
 	ctx->is_active |= (event_type | EVENT_TIME);
 	if (ctx->task) {
 		if (!is_active)
@@ -3818,13 +3873,6 @@ ctx_sched_in(struct perf_event_context *ctx,
 
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
@@ -4418,6 +4466,18 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
+static void calc_timer_values(struct perf_event *event,
+				u64 *now,
+				u64 *enabled,
+				u64 *running)
+{
+	u64 ctx_time;
+
+	*now = perf_clock();
+	ctx_time = perf_event_time_now(event, *now);
+	__perf_update_times(event, ctx_time, enabled, running);
+}
+
 /*
  * NMI-safe method to read a local event, that is an event that
  * is:
@@ -4477,10 +4537,9 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 
 	*value = local64_read(&event->count);
 	if (enabled || running) {
-		u64 now = event->shadow_ctx_time + perf_clock();
-		u64 __enabled, __running;
+		u64 __enabled, __running, __now;;
 
-		__perf_update_times(event, now, &__enabled, &__running);
+		calc_timer_values(event, &__now, &__enabled, &__running);
 		if (enabled)
 			*enabled = __enabled;
 		if (running)
@@ -5802,18 +5861,6 @@ static int perf_event_index(struct perf_event *event)
 	return event->pmu->event_idx(event);
 }
 
-static void calc_timer_values(struct perf_event *event,
-				u64 *now,
-				u64 *enabled,
-				u64 *running)
-{
-	u64 ctx_time;
-
-	*now = perf_clock();
-	ctx_time = event->shadow_ctx_time + *now;
-	__perf_update_times(event, ctx_time, enabled, running);
-}
-
 static void perf_event_init_userpage(struct perf_event *event)
 {
 	struct perf_event_mmap_page *userpg;
@@ -6353,7 +6400,6 @@ accounting:
 		ring_buffer_attach(event, rb);
 
 		perf_event_update_time(event);
-		perf_set_shadow_time(event, event->ctx);
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 	} else {
