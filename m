Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D474D3D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiCIXFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiCIXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:04:51 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75C122F7B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:03:52 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d64so4047913vsd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeQi6kiCFo5FC0J2ToEH9QNxl9pFekwn4FCq117LLQw=;
        b=HZuTq/sH7LNaeSxq8d84GyZGCM/pclQ9UQtaKV4mdeYTSP7wyrnOEeAXceyJmAgH/j
         7Klw7FZCCF2HRWBQkX3KiAnqbYdxJhMChfvSrwxQhSe01Gr/lszbEKAAwxbz53/ekeIx
         MkPgXXtGrwmzWw93Dh8tCcrEgLX8Vt3G9B9LYX6EP5+7t8OgXU4C2+d2jbjjnMRAhuZK
         A7XMamZhkYDmBpC1CJRfUOFi+eglUIRF/fb/PV9m5MAwqPbyRRaqo9E1+eYar3sLBP/8
         1Tt0hD+SS5x5w526Xw8klC/G6txpsuukf6uJgFsdG9EV5IBYrIZvkvVOvak71km1rKTO
         l+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeQi6kiCFo5FC0J2ToEH9QNxl9pFekwn4FCq117LLQw=;
        b=dW5l2MV889JRzWEoK2OMCWLKDFKCihtdlBikkuio015ievDj/TAptWvZQgYgzy5JYz
         vBqyz584txYWaAe7sXLbs5Hl6mxZPx2DoG0A98phkWsgTPv/PkHScwoogUc/0gbUUMGx
         eK5kGeBYMAQ8ThvauYXcloAG1pJWQv9Ba+JeDqi2yupPEU3JI8EF/4B6vl/FKdd++UfP
         R384W8toycfnD5zvT/cNiCfuxtW08pK60oJzzSUXaWLO9HIzyYpiXaevoHo1Rr+3Of/J
         bAULeZDKN5W9460kp3wT9IoBYeSHpcHsfs0hIvzMrsFWpFkW7l82L5lnWOLwQ+dJDJyv
         n2ew==
X-Gm-Message-State: AOAM530kMyTzppd04L4YsZZB6nzU+rGCymhKreBXWSFW1w2Wa2VJUMKD
        w5heaEySUgrBzAHvkzGqb2lJQezylbQyzTOSHY/yog==
X-Google-Smtp-Source: ABdhPJyW2Lzm9eBtM0SVhsb0hZbqYu8t0c7BZziKTdVRx17mOj70qBBDwO2BPDcvK8Por2SwuDyFleNfH/nAhjgoC54=
X-Received: by 2002:a67:c09b:0:b0:322:9ac9:4b2e with SMTP id
 x27-20020a67c09b000000b003229ac94b2emr1022475vsi.11.1646867030875; Wed, 09
 Mar 2022 15:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com> <20220208211637.2221872-7-eranian@google.com>
 <YgPedIWUiPIzF8OW@hirez.programming.kicks-ass.net> <YiI0DKEzc41bF15C@hirez.programming.kicks-ass.net>
In-Reply-To: <YiI0DKEzc41bF15C@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 9 Mar 2022 15:03:39 -0800
Message-ID: <CABPqkBRQwYnxcXigKwF83BPhQmombqa6nuF5-krqN=00Loy_gg@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] perf/x86/amd: add AMD branch sampling period adjustment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 7:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 09, 2022 at 04:32:04PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 08, 2022 at 01:16:31PM -0800, Stephane Eranian wrote:
> > > Add code to adjust the sampling event period when used with the Branch
> > > Sampling feature (BRS). Given the depth of the BRS (16), the period is
> > > reduced by that depth such that in the best case scenario, BRS saturates at
> > > the desired sampling period. In practice, though, the processor may execute
> > > more branches. Given a desired period P and a depth D, the kernel programs
> > > the actual period at P - D. After P occurrences of the sampling event, the
> > > counter overflows. It then may take X branches (skid) before the NMI is
> > > caught and held by the hardware and BRS activates. Then, after D branches,
> > > BRS saturates and the NMI is delivered.  With no skid, the effective period
> > > would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
> > > X + D. There is no way to eliminate X or predict X.
> > >
> > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > ---
> > >  arch/x86/events/core.c       |  7 +++++++
> > >  arch/x86/events/perf_event.h | 12 ++++++++++++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > > index c2a890caeb0a..ed285f640efe 100644
> > > --- a/arch/x86/events/core.c
> > > +++ b/arch/x86/events/core.c
> > > @@ -1374,6 +1374,13 @@ int x86_perf_event_set_period(struct perf_event *event)
> > >         x86_pmu.set_topdown_event_period)
> > >             return x86_pmu.set_topdown_event_period(event);
> > >
> > > +   /*
> > > +    * decrease period by the depth of the BRS feature to get
> > > +    * the last N taken branches and approximate the desired period
> > > +    */
> > > +   if (has_branch_stack(event))
> > > +           period = amd_brs_adjust_period(period);
> > > +
> > >     /*
> > >      * If we are way outside a reasonable range then just skip forward:
> > >      */
> > > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> > > index 3485a4cf0241..25b037b571e4 100644
> > > --- a/arch/x86/events/perf_event.h
> > > +++ b/arch/x86/events/perf_event.h
> > > @@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
> > >     return cpuc->brs_active;
> > >  }
> > >
> > > +static inline s64 amd_brs_adjust_period(s64 period)
> > > +{
> > > +   if (period > x86_pmu.lbr_nr)
> > > +           return period - x86_pmu.lbr_nr;
> > > +
> > > +   return period;
> > > +}
> >
> > This makes no sense to me without also enforcing that the event is in
> > fact that branch retired thing.
>
> So what are we going to do with all these patches? Note that I did pick
> them up for testing and I've fixed at least 2 build problems with them.
>
> But I still don't think they're actually completely sane. So there's the
> above issue, subtracting lbr_nr from a random event just makes no sense.


You are right. Initially, I had it such that only retired_branch_taken was
the only event possible. In that case, subtracting lbr_nr made sense.
Since, I have relaxed the event but it exposes this problem. I think
given how BRS works, I am okay restricting to retired_br_taken
because no matter what the hw is going to activate at P (period)
and wait for 16  taken branches before delivering the NMI. So if I
am sampling on cycles with P=1000000, then the NMI is delivered
at P + X + Z, where X = number of cycles elapsed for the 16 taken
branches (unpredictable) and Z the interrupt skid for NMI (which is
extremely big on AMD). With retired_branch_taken, that formula
becomes: P + 16 + Z, where Z is the number of taken branches
during the skid. But given BRS saturates when full, you do lose
the content because of the Z skid. My opinion is we keep the
lbr_nr subtraction and force event to be only retired_branch_taken.

> But there's also the whole exclusion thing, IIRC you're making it
> exclusive against other LBR users, but AFAICT having one LBR user active
> will completely screw over any other sampling event due to introducing
> these massive skids.


The skid is not massive compared to the actual skid of regular interrupt-based
sampling. You are looking at the time it takes to execute 16 taken branches
vs. 2000+ cycles for the NMI skid.  And this would happen only if the other
events overflow during that 16 taken branch window.
