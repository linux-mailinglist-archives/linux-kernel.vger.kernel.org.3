Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C199346E411
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbhLIIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhLIIZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:25:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 00:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ol70Jzb4JZjBtLw/AHMxUk+CAuEmSVNNm4q56a85dcU=; b=JtSy40sJ38vwhhBVhUUZnBg+g4
        ywaG3SwG5bRQC7QRwBjB95E5FeSG66Mo+eUSA00i/I1ANFNPi6M368HmqdLuf+lDNfCOBnMuuhBdt
        hL3a5PyOIDgWqHW4p/uKWG4vwR2J0kBkpg9ktYv2w4usQ0TdUoKFTvUO7iAInjz2NbPWBsa+cSyTK
        kmE4/Ry3GAFDgb6dK28ibhtQQYTJERqtd4hQYAvMlAR2+mg5Di75RFL1KacAEMFxC6eW+Rf3+QHhy
        SdhJoTICgDaflUGEL8CvHDQXiv+TPlB+1cuTZW8jt+TuBSg8S11nPMNEzOEt+AnWsBoFh9eVHYlAm
        X8MHAqlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvEgE-000Kgo-W1; Thu, 09 Dec 2021 08:21:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8ABF09817E0; Thu,  9 Dec 2021 09:21:29 +0100 (CET)
Date:   Thu, 9 Dec 2021 09:21:29 +0100
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
Message-ID: <20211209082129.GD16608@worktop.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <20211208232203.GC16608@worktop.programming.kicks-ass.net>
 <CAM9d7cizkX_oOj2UCWnbqS9P+VDW8NLxC7BE23xa4moJQS_+vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cizkX_oOj2UCWnbqS9P+VDW8NLxC7BE23xa4moJQS_+vg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 09:52:16PM -0800, Namhyung Kim wrote:
> Hi Peter,
> 
> On Wed, Dec 8, 2021 at 3:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Dec 05, 2021 at 02:48:43PM -0800, Namhyung Kim wrote:
> > > While commit f79256532682 ("perf/core: fix userpage->time_enabled of
> > > inactive events") fixed this problem for user rdpmc usage,
> >
> > You're referring to 'this problem' before actually describing a problem :-(
> 
> Well, it's a problem of reporting incorrect 'enabled' time.
> I'm sorry if it was not clear.
> 
> >
> > Also, you now have me looking at that commit again, and I'm still hating
> > it. Also, I'm again struggling to make sense of it; all except the very
> > last hunk that is.
> >
> > So the whole, full-fat, mmap self-monitor thing looks like:
> >
> >
> >         u32 seq, time_mult, time_shift, index, width = 64;
> >         u64 count, enabled, running;
> >         u64 cyc, time_offset, time_cycles = 0, time_mask = ~0ULL;
> >         u64 quot, rem, delta;
> >         s64 pmc = 0;
> >
> >         do {
> >                 seq = pc->lock;
> >                 barrier();
> >
> >                 enabled = pc->time_enabled;
> >                 running = pc->time_running;
> >
> >                 if (pc->cap_user_time && enabled != running) {
> >                         cyc = rdtsc();
> >                         time_offset = pc->time_offset;
> >                         time_mult   = pc->time_mult;
> >                         time_shift  = pc->time_shift;
> >                 }
> >
> >                 if (pc->cap_user_time_short) {
> >                         time_cycles = pc->time_cycles;
> >                         time_mask   = pc->time_mask;
> >                 }
> >
> >                 index = pc->index;
> >                 count = pc->offset;
> >                 if (pc->cap_user_rdpmc && index) {
> >                         width = pc->pmc_width;
> >                         pmc = rdpmc(index - 1);
> >                 }
> >
> >                 barrier();
> >         } while (pc->lock != seq);
> >
> >         if (width < 64) {
> >                 pmc <<= 64 - width;
> >                 pmc >>= 64 - width;
> >         }
> >         count += pmc;
> >
> >         cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> >
> >         quot = (cyc >> time_shift);
> >         rem = cyc & ((1ULL < time_shift) - 1);
> >         delta = time_offset + quot * time_mult +
> >                 ((rem * time_mult) >> time_shift);
> >
> >         enabled += delta;
> >         if (index)
> >                 running += delta;
> >
> >         quot = count / running;
> >         rem  = count % running;
> >         count = quot * enabled + (rem * enabled) / running;
> >
> >
> > Now, the thing that sticks out to me is that 'enabled' is
> > unconditionally advanced. It *always* runs.
> >
> > So how can not updating ->time_enabled when the counter is INACTIVE due
> > to rotation (which causes ->index == 0), cause enabled to not be
> > up-to-date?
> 
> Hmm.. I don't get it.  In my understanding, that's the whole point
> of the enabled time - tracking time it was not active due to the
> multiplexing (rotation).  So that users might want to scale the
> count based on the ratio of running vs enabled.

Correct, and AFAICT that works as advertised.

> Do I miss something?

Where do we actually need the crap that is commit f79256532682 ?
