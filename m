Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F344D9ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiCOMKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiCOMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:10:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DB926F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=avPnCDGRv08Z7yhZRMRDGcDyWxTJlz+Jt/bWl0GTYFo=; b=KXuaY7EMO8dbw2Dur6Iic8/1yB
        MMPnKkHH8RZx1Cm65XjDm4R/AhjZ6VQ6WGmwQTzMw8+bE1/U9EsWLnCREqWP9TYNvZ1C3iWZcbqWk
        2Do9SdxEe7U7GhU5yVhx5M1HrCbAo0krxgL5iMPVDixJbCiTNHZOZ8clG/M9ipcNTqqR23B7MHDnB
        Od4e3jN/GpX7TAsJbRZZxysuVLmbgLobhT0QoLB9kASodIzigIPUVDORXWIzRDc/IV9NVxkjdE/fe
        W+U1+1GvQywqArHDXUtD5KLJX7rDLvCQmRwJUC0dZfsdiGyperU9xPpqwPukN+MnVGM6JrotnsrQU
        uhwob0uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU5yx-0050vM-Ma; Tue, 15 Mar 2022 12:08:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A23C098620D; Tue, 15 Mar 2022 13:08:53 +0100 (CET)
Date:   Tue, 15 Mar 2022 13:08:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Subject: Re: [PATCH v6 06/12] perf/x86/amd: add AMD branch sampling period
 adjustment
Message-ID: <20220315120853.GG8939@worktop.programming.kicks-ass.net>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-7-eranian@google.com>
 <YgPedIWUiPIzF8OW@hirez.programming.kicks-ass.net>
 <YiI0DKEzc41bF15C@hirez.programming.kicks-ass.net>
 <CABPqkBRQwYnxcXigKwF83BPhQmombqa6nuF5-krqN=00Loy_gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRQwYnxcXigKwF83BPhQmombqa6nuF5-krqN=00Loy_gg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 03:03:39PM -0800, Stephane Eranian wrote:
> On Fri, Mar 4, 2022 at 7:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Feb 09, 2022 at 04:32:04PM +0100, Peter Zijlstra wrote:
> > > On Tue, Feb 08, 2022 at 01:16:31PM -0800, Stephane Eranian wrote:
> > > > Add code to adjust the sampling event period when used with the Branch
> > > > Sampling feature (BRS). Given the depth of the BRS (16), the period is
> > > > reduced by that depth such that in the best case scenario, BRS saturates at
> > > > the desired sampling period. In practice, though, the processor may execute
> > > > more branches. Given a desired period P and a depth D, the kernel programs
> > > > the actual period at P - D. After P occurrences of the sampling event, the
> > > > counter overflows. It then may take X branches (skid) before the NMI is
> > > > caught and held by the hardware and BRS activates. Then, after D branches,
> > > > BRS saturates and the NMI is delivered.  With no skid, the effective period
> > > > would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
> > > > X + D. There is no way to eliminate X or predict X.
> > > >
> > > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > > ---
> > > >  arch/x86/events/core.c       |  7 +++++++
> > > >  arch/x86/events/perf_event.h | 12 ++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > > >
> > > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > > index c2a890caeb0a..ed285f640efe 100644
> > > > --- a/arch/x86/events/core.c
> > > > +++ b/arch/x86/events/core.c
> > > > @@ -1374,6 +1374,13 @@ int x86_perf_event_set_period(struct perf_event *event)
> > > >         x86_pmu.set_topdown_event_period)
> > > >             return x86_pmu.set_topdown_event_period(event);
> > > >
> > > > +   /*
> > > > +    * decrease period by the depth of the BRS feature to get
> > > > +    * the last N taken branches and approximate the desired period
> > > > +    */
> > > > +   if (has_branch_stack(event))
> > > > +           period = amd_brs_adjust_period(period);
> > > > +
> > > >     /*
> > > >      * If we are way outside a reasonable range then just skip forward:
> > > >      */
> > > > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> > > > index 3485a4cf0241..25b037b571e4 100644
> > > > --- a/arch/x86/events/perf_event.h
> > > > +++ b/arch/x86/events/perf_event.h
> > > > @@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
> > > >     return cpuc->brs_active;
> > > >  }
> > > >
> > > > +static inline s64 amd_brs_adjust_period(s64 period)
> > > > +{
> > > > +   if (period > x86_pmu.lbr_nr)
> > > > +           return period - x86_pmu.lbr_nr;
> > > > +
> > > > +   return period;
> > > > +}
> > >
> > > This makes no sense to me without also enforcing that the event is in
> > > fact that branch retired thing.
> >
> > So what are we going to do with all these patches? Note that I did pick
> > them up for testing and I've fixed at least 2 build problems with them.
> >
> > But I still don't think they're actually completely sane. So there's the
> > above issue, subtracting lbr_nr from a random event just makes no sense.
> 
> 
> You are right. Initially, I had it such that only retired_branch_taken was
> the only event possible. In that case, subtracting lbr_nr made sense.
> Since, I have relaxed the event but it exposes this problem. I think
> given how BRS works, I am okay restricting to retired_br_taken
> because no matter what the hw is going to activate at P (period)
> and wait for 16  taken branches before delivering the NMI. So if I
> am sampling on cycles with P=1000000, then the NMI is delivered
> at P + X + Z, where X = number of cycles elapsed for the 16 taken
> branches (unpredictable) and Z the interrupt skid for NMI (which is
> extremely big on AMD). With retired_branch_taken, that formula
> becomes: P + 16 + Z, where Z is the number of taken branches
> during the skid. But given BRS saturates when full, you do lose
> the content because of the Z skid. My opinion is we keep the
> lbr_nr subtraction and force event to be only retired_branch_taken.

OK, can you do me a delta patch and tell me which commit to merge it in?

> > But there's also the whole exclusion thing, IIRC you're making it
> > exclusive against other LBR users, but AFAICT having one LBR user active
> > will completely screw over any other sampling event due to introducing
> > these massive skids.
> 
> 
> The skid is not massive compared to the actual skid of regular interrupt-based
> sampling. You are looking at the time it takes to execute 16 taken branches
> vs. 2000+ cycles for the NMI skid.  And this would happen only if the other
> events overflow during that 16 taken branch window.

Wait, you're telling me that regs->ip is 2000 cycles/CPI further along
than the instruction that caused the PMI on AMD? That seems beyond
useless.

That's also not what I seem to remember from the last time I used perf
on AMD (admittedly a while ago). Normally the reported IP is a few
instructions beyond the eventing IP. Yielding the normal perf-annotate
output that's shifted but mostly trivially readable.

However, if you delay that NMI for however many instructions it takes to
do 16 branches, the reported IP (regs->ip) will be completely unrelated
to the eventing IP (the one that actually triggered PMI).

In that case the perf-annotate output becomes really hard to interpret.
Esp. if you don't know which IPs were basically garbage.

One possible work-around might be to discard the sample for any
!retired_branch_taken overflow and reprogram those counters with a very
small (1?) value to 'insta' take a new sample without interference. But
that's yuck too.

