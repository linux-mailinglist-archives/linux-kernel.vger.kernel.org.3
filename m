Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E477D47BFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhLUMj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbhLUMjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:39:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA12C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZSyVtgUzcqAYSWbRKpmBMgzaOQK6Rts/x/asQLpQ5G0=; b=W9xVEaMpdQRGRfahjV+kVyJ4MU
        WBsKIN9auQu8Xz8b7UKmDIBNWd7nTl/iTEdFEqoEQBSbQoXcSDBmDr1DFL+v40hz4FI9vYiojNKfu
        T9gE8NM5AO6fWitSGajCXxe3EnF4LBsXSUrLyLo/j4UzvgJEj/nNiD61kR2vTleB+I52fsqRZdDKO
        LHx7XyDTqm+E7JL1833sUsOjWXVg4vfVeZywI5wxhd5uXJW3PqvGsyCvmXKGMNfHLvjedHUpeTVTl
        QM4vb1T4GqnmLFc/RYRERAlqnGb7QNyAKd51u737or17ulD3JlAZ7yMTkHYlAZaULrtAbx6qqayYp
        xgQ8YaxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzeQU-002jWA-8p; Tue, 21 Dec 2021 12:39:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE0973002AE;
        Tue, 21 Dec 2021 13:39:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A7C42CFD6142; Tue, 21 Dec 2021 13:39:28 +0100 (CET)
Date:   Tue, 21 Dec 2021 13:39:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Vince Weaver <vince@deater.net>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <YcHLALLO1EUJHOjy@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
 <7A415BC0-E6F2-4ED2-8996-8F5871ED8001@fb.com>
 <YcBNOsMG3aGVpnWK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcBNOsMG3aGVpnWK@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:30:34AM +0100, Peter Zijlstra wrote:

> Ohh.. argh. I think I see why, it looses the context time enable edge,
> and because this is all strictly per-event in the uapi (there is no ctx
> representation) it can't be cured by improving ctx time handling :/
> 
> Bah, I so hate this.
> 

I wonder... could we get away with something like this...


---
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2722,13 +2722,17 @@ void arch_perf_update_userpage(struct pe
 	struct cyc2ns_data data;
 	u64 offset;
 
-	userpg->cap_user_time = 0;
-	userpg->cap_user_time_zero = 0;
-	userpg->cap_user_rdpmc =
-		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
+	userpg->cap_user_rdpmc = !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
-	if (!using_native_sched_clock() || !sched_clock_stable())
+	if (unlikely(!using_native_sched_clock() || !sched_clock_stable())) {
+		userpg->cap_user_time = 0;
+		userpg->cap_user_time_zero = 0;
+		return;
+	}
+
+	/* already set the time fields before */
+	if (likely(userpf->cap_user_time))
 		return;
 
 	cyc2ns_read_begin(&data);
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -612,6 +612,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_ITRACE	0x10
 #define PERF_ATTACH_SCHED_CB	0x20
 #define PERF_ATTACH_CHILD	0x40
+#define PERF_ATTACH_SELF	0x80
 
 struct perf_cgroup;
 struct perf_buffer;
@@ -812,6 +813,7 @@ struct perf_event_context {
 
 	int				nr_events;
 	int				nr_active;
+	int				nr_self;
 	int				is_active;
 	int				nr_stat;
 	int				nr_freq;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1877,6 +1877,8 @@ list_add_event(struct perf_event *event,
 	ctx->nr_events++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
+	if (event->attach_state & PERF_ATTACH_SELF)
+		ctx->nr_self++;
 
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_cgroup_event_enable(event, ctx);
@@ -2068,6 +2070,8 @@ list_del_event(struct perf_event *event,
 	ctx->nr_events--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
+	if (event->attach_state & PERF_ATTACH_SELF)
+		ctx->nr_self--;
 
 	list_del_rcu(&event->event_entry);
 
@@ -3755,7 +3759,8 @@ static noinline int visit_groups_merge(s
  */
 static inline bool event_update_userpage(struct perf_event *event)
 {
-	if (likely(!atomic_read(&event->mmap_count)))
+	if (likely(!atomic_read(&event->mmap_count) ||
+		   !(event->attach_state & PERF_ATTACH_SELF)))
 		return false;
 
 	perf_event_update_time(event);
@@ -3800,7 +3805,8 @@ static int merge_sched_in(struct perf_ev
 		} else {
 			ctx->rotate_necessary = 1;
 			perf_mux_hrtimer_restart(cpuctx);
-			group_update_userpage(event);
+			if (ctx->nr_self)
+				group_update_userpage(event);
 		}
 	}
 
@@ -5900,6 +5906,9 @@ void perf_event_update_userpage(struct p
 	if (!rb)
 		goto unlock;
 
+	if (!(event->attach_state & PERF_ATTACH_SELF))
+		goto unlock;
+
 	/*
 	 * compute total_time_enabled, total_time_running
 	 * based on snapshot values taken when the event
@@ -11613,6 +11622,8 @@ perf_event_alloc(struct perf_event_attr
 		 * pmu before we get a ctx.
 		 */
 		event->hw.target = get_task_struct(task);
+		if (event->hw.target == current && !attr->inherit)
+			event->attach_state |= PERF_ATTACH_SELF;
 	}
 
 	event->clock = &local_clock;
