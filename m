Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44484544052
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiFIAIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFIAII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:08:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCC13CDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 17:08:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso269476wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnlYXnVoQYJPnNV8/iC3fNyGpmORV44baev9cEKD2IY=;
        b=rlG44ICMM4z4bNcMt5KDKsiGZ7e5+g5gPlD3n6KCPMALmsgSLMviYzo5++Ytwl8EEg
         clrF5nU1PA+9yGWshhXdqvHFQxSansRhSL/aS4orgaNjMOtwEXpFDW7J42J7G8C/kU+O
         f6wDlBTnM8YsjTOGNxVI/cyC/Hu7ORI7s8w6ISivX6yn1dlc9j5aN7UAz2mUBPgCc5zY
         dZRUlY+RNoT+h+A9F/eqmWjhF7Rx2cEODLQL4TVR0nmxbqOpEs0mRYh0y7W8wwfWS55V
         A1cfQNxgTpNsajQArIGxBLzBbE2F/YL9zXhd8IqCZMOwB2w1JRM+gaTs9Fq+/3169anP
         K3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnlYXnVoQYJPnNV8/iC3fNyGpmORV44baev9cEKD2IY=;
        b=NFP5f/IPrlu8AbV2iDm3Ymjjqlahofi5xckZw9GXUBxTCuY35Pb081R8JE+eyZJmyo
         7p9hEQThIZEsRH9dykhysnBugl99VQFT0GDBy036GA0yO9bn2e7ddZ7zXInX2V/Rp8K3
         +Y2nQFkTfORfRYhezPHBkZnLVVJLNSFYtCiXnuhB0akheFxEX38lFozaD7XuGVLuw/0H
         eeQTDc5lcgVU2XSBttRTaWeNqPcw6pYnpE5Iwcucw1Itp6R0CZLnkQueYT/XoLBANWyj
         9qBmKwhgcgS3WJ+HwReoUQ2BqFBT2oPhklIGgzcmYGI86te/Xpw01B6twNtb2FMwVvHA
         r84A==
X-Gm-Message-State: AOAM5309OMJQdeIinrga56AI2A3M7IvH0yl2Cl4iv23O6ffM1dsBo4uR
        nGpvwSsnnbAkYMVR1VJhYQlla6qNs9MPPkuiJ06MEQ==
X-Google-Smtp-Source: ABdhPJy54ZnoQBAo63W05vgLEvMwWjLv/9KzfirQgHDWFuLjzwgfXLUiRyRGEYSaQORswgcDGo1zKhC4x2XiqCMNS0g=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr442073wmk.115.1654733284190; Wed, 08
 Jun 2022 17:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com> <20220608224353.1176079-3-irogers@google.com>
 <CAL_Jsq+rWB7AYr4THs2Dg98ss8cuL38QVuvTbQNwar2ePqwuww@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rWB7AYr4THs2Dg98ss8cuL38QVuvTbQNwar2ePqwuww@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Jun 2022 17:07:48 -0700
Message-ID: <CAP-5=fVyb6mc2UFYM0kMQXUwo4gZ2WxgY6G6G8+C5WqdxoxXJw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf: Align user space counter reading with code
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 4:25 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 8, 2022 at 4:44 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Align the user space counter reading documentation with the code in
> > perf_mmap__read_self. Previously the documentation was based on the perf
> > rdpmc test, but now general purpose code is provided by libperf.
>
> IMO, this copy of not quite right code should just be removed perhaps
> with a pointer to perf_mmap__read_self(). It will just get out of date
> again. For example, the read loop might get rewritten with restartable
> sequences.

Thanks. The intent with the rdpmc test and the header is they be in
sync. The test flakes when testing at scale, why I'm here. Having the
code in the header makes it clear this is a Linux API and subject to
the Linux syscall note. I like the code in the header but not that it
is out of sync with the code used currently to read it.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/perf_event.h       | 32 ++++++++++++++++-----------
> >  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++-----------
> >  2 files changed, 38 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index d37629dbad72..3b84e0ad0723 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
> >          *
> >          *     if (pc->cap_usr_time && enabled != running) {
> >          *       cyc = rdtsc();
>
> Kind of x86 specific.

There is a reference to it below and so I let it be, the name rdpmc is
also very x86 but something of a sailed ship.

> > -        *       time_offset = pc->time_offset;
> >          *       time_mult   = pc->time_mult;
> >          *       time_shift  = pc->time_shift;
> > +        *       time_offset = pc->time_offset;
> > +        *       if (pc->cap_user_time_short) {
> > +        *         time_cycles = pc->time_cycles;
> > +        *         time_mask = pc->time_mask;
> > +        *       }
>
> This still misses the need for READ_ONCE().

I'd elided that as it is something of.a kernel API. I can add it back.

> >          *     }
> >          *
> >          *     index = pc->index;
> > @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
> >          *     if (pc->cap_user_rdpmc && index) {
> >          *       width = pc->pmc_width;
> >          *       pmc = rdpmc(index - 1);
> > +        *       pmc <<= 64 - width;
> > +        *       pmc >>= 64 - width;
> > +        *       count += pmc;
> >          *     }
> >          *
> >          *     barrier();
> > @@ -590,25 +597,24 @@ struct perf_event_mmap_page {
> >          * If cap_usr_time the below fields can be used to compute the time
> >          * delta since time_enabled (in ns) using rdtsc or similar.
> >          *
> > -        *   u64 quot, rem;
> > -        *   u64 delta;
> > -        *
> > -        *   quot = (cyc >> time_shift);
> > -        *   rem = cyc & (((u64)1 << time_shift) - 1);
> > -        *   delta = time_offset + quot * time_mult +
> > -        *              ((rem * time_mult) >> time_shift);
> > +        *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> > +        *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
>
> For documentation purposes, the original code was easier to read and
> this is just an optimization. What does mul_u64_u32_shr() do exactly?
> It's not documented.

My concern with expanding the function is the header and the code
aren't in sync and so we're not testing what we're advertising.
Finding the definition is not a huge challenge imo.

Thanks,
Ian

> >          *
> >          * Where time_offset,time_mult,time_shift and cyc are read in the
> >          * seqcount loop described above. This delta can then be added to
> > -        * enabled and possible running (if index), improving the scaling:
> > +        * enabled and possible running (if index) to improve the scaling. Due
> > +        * to event multiplexing, running maybe zero and so care is needed to
> > +        * avoid division by zero.
> >          *
> >          *   enabled += delta;
> > -        *   if (index)
> > +        *   if (idx)
> >          *     running += delta;
> >          *
> > -        *   quot = count / running;
> > -        *   rem  = count % running;
> > -        *   count = quot * enabled + (rem * enabled) / running;
> > +        *   if (running != 0) {
> > +        *     quot = count / running;
> > +        *     rem  = count % running;
> > +        *     count = quot * enabled + (rem * enabled) / running;
> > +        *   }
> >          */
> >         __u16   time_shift;
> >         __u32   time_mult;
