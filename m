Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2046FECF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhLJKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhLJKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:37:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B66C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 02:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UjxuZYCUqW3LDd8ilmqnZe7NbKku+dszBLX5gBdtvgs=; b=aEmifT8e/9PSBcMsO52b1fvYZN
        fARctpLlmMmdmDS/QU9ArWo+1HLibuOJw3G7ONR42De6cMzY9oMHvPkWMxyoOW2bfzDOub+VFqw5r
        f9wz2XauhTtlACaBiVjqstSjCakXY48Cu+6wsRiOcK93ceZVllhpId4eicGHGGZZ1JK3+qP5pvZ/P
        ScrK2C7nFYBSVp8rwrALJzzhHZ29aW6qBGifa7PJ6Im6PzYNxuSolAcCuuWu6V3TKn+1/J9iEaZWs
        jqeZgxGCEZbP2Lsh6L23jdKv2wNL8QwVwz1VPomSo8/uOIvbHBzPViVVZyTbBpYcmk6kxdm7FoWkx
        vmzENeEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvdDh-00AEt3-TR; Fri, 10 Dec 2021 10:33:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6783C984E0B; Fri, 10 Dec 2021 11:33:41 +0100 (CET)
Date:   Fri, 10 Dec 2021 11:33:41 +0100
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
Message-ID: <20211210103341.GS16608@worktop.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:35:11PM -0800, Namhyung Kim wrote:
> On Thu, Dec 9, 2021 at 3:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> >
> > > Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
> > > have a negative enabled time.  In fact, bperf keeps values returned by
> > > bpf_perf_event_read_value() which calls perf_event_read_local(), and
> > > accumulates delta between two calls.  When event->shadow_ctx_time is
> > > not set, it'd return invalid enabled time which is bigger than normal.
> >
> > *that*, how does it happen that shadow_time isn't set? It should be last
> > set when the event switches to INACTIVE, no?
> 
> As you can see, perf_event_set_state() doesn't set the shadow time.
> It's called from event_sched_in() which might result in ACTIVE or
> INACTIVE.  But the problem is that there's a case that event_sched_in
> was not called at all - when group_can_go_on() returns false.
> 
> > At which point the logic in
> > perf_event_read_local() should make @enabled move forward while @running
> > stays put.
> 
> It's not about updating event->total_time_enabled, it only
> afftects the returned value of @enabled.
> 
> I'd say the time calculation is broken so it'd break @running
> as well.  But this case can only happen on INACTIVE -
> otherwise it'd call event_sched_in() and update the shadow
> time properly, so no issue there.  And then we can see
> the broken value of enabled time only.

I'm thinking this is a cgroup specific thing. Normally the shadow_time
thing is simply a relative displacement between event-time and the
global clock. That displacement never changes, except when you do
IOC_DISABLE/IOC_ENABLE.

However, for cgroup things are different, since the cgroup events aren't
unconditionally runnable, that is, the enabled time should only count
when the cgroup is active, right?

So perhaps perf_event_read_local() should use a cgroup clock instead of
perf_clock() for cgroup events.

Let me think about that some more...
