Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545C646E7AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhLILie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbhLILid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:38:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D724C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zCopsbGKBV9BpPlCXS61pCDV3DmBNf3UasJSV1vCB6A=; b=OUFSQqAb1EVecmS1bPeJjT9Jev
        ZWRdfaKs1RPKr8yoifIVeTf6Ht9PMm/xc2Qzs1p5G5KzSy4kTxqTGuhNDZ6XRWy4BZIRvfxaAiMzt
        Y2YZv9q52w+4PSJqHiPt/7su6Lkm+ua96LNQE027U42n5CP3GrW+bQJt2j9I3jLEYocxm166fSYEJ
        rSiYfVPv838zxm4d/03/PmgG+BmQvzPttWBYtbH6JVWt+ZQgVS29Pue0Jixa8rq7XINTZfTOR+lag
        iFswr4J8yDVADYiqZTyB6DYOK1HUGo/O6Jaktg958Gc6MfQi8ZPNN05CpAP/aD+A0/JOa+qhez5DY
        SjlQWmzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvHhI-009Iaf-3M; Thu, 09 Dec 2021 11:34:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B895300079;
        Thu,  9 Dec 2021 12:34:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F9982BB95D96; Thu,  9 Dec 2021 12:34:48 +0100 (CET)
Date:   Thu, 9 Dec 2021 12:34:48 +0100
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
Message-ID: <YbHp2MXmP1V5WE4B@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 12:26:32PM +0100, Peter Zijlstra wrote:
> On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> 
> > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > have a negative enabled time.  In fact, bperf keeps values returned by
> > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > accumulates delta between two calls.  When event->shadow_ctx_time is
> > not set, it'd return invalid enabled time which is bigger than normal.
> 
> *that*, how does it happen that shadow_time isn't set? It should be last
> set when the event switches to INACTIVE, no? At which point the logic in
> perf_event_read_local() should make @enabled move forward while @running
> stays put.
> 
> Let me go rummage around a bit... either I'm missing something obvious
> or something's smelly.

How's this then?

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7b7525e9155f..82baa8bdfc86 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -686,9 +686,7 @@ struct perf_event {
 	/*
 	 * timestamp shadows the actual context timing but it can
 	 * be safely used in NMI interrupt context. It reflects the
-	 * context time as it was when the event was last scheduled in,
-	 * or when ctx_sched_in failed to schedule the event because we
-	 * run out of PMC.
+	 * context time as it was when the event was last scheduled in.
 	 *
 	 * ctx_time already accounts for ctx->timestamp. Therefore to
 	 * compute ctx_time for a sample, simply add perf_clock().
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 28aaeacdaea1..20637b7f420c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -640,6 +640,9 @@ __perf_update_times(struct perf_event *event, u64 now, u64 *enabled, u64 *runnin
 		*running += delta;
 }
 
+static void perf_set_shadow_time(struct perf_event *event,
+				 struct perf_event_context *ctx);
+
 static void perf_event_update_time(struct perf_event *event)
 {
 	u64 now = perf_event_time(event);
@@ -647,6 +650,7 @@ static void perf_event_update_time(struct perf_event *event)
 	__perf_update_times(event, now, &event->total_time_enabled,
 					&event->total_time_running);
 	event->tstamp = now;
+	perf_set_shadow_time(event, event->ctx);
 }
 
 static void perf_event_update_sibling_time(struct perf_event *leader)
@@ -2552,8 +2556,6 @@ event_sched_in(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	perf_set_shadow_time(event, ctx);
-
 	perf_log_itrace_start(event);
 
 	if (event->pmu->add(event, PERF_EF_START)) {
@@ -3707,29 +3709,6 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
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
@@ -3748,15 +3727,14 @@ static int merge_sched_in(struct perf_event *event, void *data)
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
@@ -6349,7 +6327,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		ring_buffer_attach(event, rb);
 
 		perf_event_update_time(event);
-		perf_set_shadow_time(event, event->ctx);
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 	} else {
