Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB1582070
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiG0Gu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiG0GuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:50:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437F019C0B;
        Tue, 26 Jul 2022 23:49:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10e4449327aso3573473fac.4;
        Tue, 26 Jul 2022 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OKtz+t1y3nVPcm3HxPHlHG8BsMLUr3K2s5mKwoCV2dg=;
        b=jX47Wgwt4iCeDuXNYQWPW5TnBryEbiJDz6nL1amMTl/tgbmnFHzHfnMTWTFloJOPr6
         K0nB/BxSuzkWAae9Le2WUog7UgH638QwuwAEdFuPd8/RlL6IcLBPA+Thiz4Dc+wOp7JR
         qTWa2o7iPCR0VZOc81LcVGyr2GMF+JT7L4gWMUXW5RFhCf+VAe8BwIMbhwrQnKEy6HDs
         r5kHOyzYits0tCV90OWbR5MbUK/klywYHVspmoeTKm12U/xiaL7gS51H9zB/NaK7DJLW
         PuaMy4WwIHId0jFiM0Qg+JO7GYbQXy3JAPc2MvIAarXKxr+wbjS1bFhQBra5LOz1BuXV
         m35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OKtz+t1y3nVPcm3HxPHlHG8BsMLUr3K2s5mKwoCV2dg=;
        b=IRPmfioEMjyiJh4FiMZsXc7Q4Y4ocSi9OhhIYtVngERanqjbilfbPxU0MNvJ1AwgkC
         byO31Uo2FjE3ZyymIRooBJN5P5UnBFcdMkXgAkoIfTyugGb9CIlw3x60d8RT6CH3BTyR
         QaXDhhjuGXnHk1M77oMpwzgrql+IWSv8gO1BXlQok9dHeBo/VebcOnvPkJA6PnL5nT55
         u8cEmDP+pRfeEpxG9Zg1zZNT+YrHEgE9lLjoPReBLZyG0SC3H+OmxpQaGmZxYXi1/c0p
         5eQ1zfnhAFhOuHUG+ZOakLkdS8PAJFdgfkzP7spZELg8BbNY2+UIe7PY2ohp7WfCHjE+
         VBlw==
X-Gm-Message-State: AJIora9L5XOvO+F3nrWjcYeCTyerJG46JZvjRh3w6i5r7Htwb2mbvLrP
        xpXX8NLuj4MNAw7vuqbJjMfhljX6iVwqEo/dBMY=
X-Google-Smtp-Source: AGRyM1sVJjtGNyOjTM3OqGh9fgu58Ozvg5vJj2cimO4vfaGVr7W5fHcqHWi7Qs0IE6f+MM1MxkYwau0jIanbKQGMks4=
X-Received: by 2002:a05:6870:e30e:b0:10d:c6b4:6396 with SMTP id
 z14-20020a056870e30e00b0010dc6b46396mr1350275oad.128.1658904565295; Tue, 26
 Jul 2022 23:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com> <CA+icZUW-4VT0_O3X59PPh2nt=3=JhLKaqXD764RERwR2eTXZ2A@mail.gmail.com>
 <CAP-5=fV+6X123C5L3pL3Y6bQnix9uNu_37ssVjAQbk4QWzXyXQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV+6X123C5L3pL3Y6bQnix9uNu_37ssVjAQbk4QWzXyXQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 Jul 2022 08:48:49 +0200
Message-ID: <CA+icZUW5F0Cs+fHFkua5pmnRSYTLKCbupA5WAj4OdUsnYvKkXA@mail.gmail.com>
Subject: Re: [PATCH v1 00/31] Add generated latest Intel events and metrics
To:     Ian Rogers <irogers@google.com>
Cc:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 9:08 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sat, Jul 23, 2022 at 10:52 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Jul 23, 2022 at 12:32 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The goal of this patch series is to align the json events for Intel
> > > platforms with those generated by:
> > > https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
> > > This script takes the latest event json and TMA metrics from:
> > > https://download.01.org/perfmon/ and adds to these metrics, in
> > > particular uncore ones, from: https://github.com/intel/perfmon-metrics
> > > The cpu_operating_frequency metric assumes the presence of the
> > > system_tsc_freq literal posted/reviewed in:
> > > https://lore.kernel.org/lkml/20220718164312.3994191-1-irogers@google.com/
> > >

Hi Ian,

thanks for your feedback and sorry for the delay.

In the meantime Arnaldo's Git tree/branches changed.
The above required patchset was integrated.
Some other perf-tools patches were included.

You sent a v2 - unsure if this fits [1] and what your plans are.

Regarding the Sandybridge updates - they seem to be marginal.

We will have - hopefully - Linux v5.19 FINAL this Sunday.
And LLVM project opened release/15.x branch and version 15.0.0-rc1
will be released this week (hope so).
My next testings will focus on these two events.

Anyway, I am still interested in testing your work.

Please let me know.

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
[2] https://github.com/llvm/llvm-project/commits/release/15.x

> > > Some fixes were needed to the script for generating the json and are
> > > contained in this pull request:
> > > https://github.com/intel/event-converter-for-linux-perf/pull/15
> > >
> > > The json files were first downloaded before being used to generate the
> > > perf json files. This fixes non-ascii characters for (R) and (TM) in
> > > the source json files. This can be reproduced with:
> > > $ download_and_gen.py --hermetic-download --outdir data
> > > $ download_and_gen.py --url=file://`pwd`/data/01 --metrics-url=file://`pwd`/data/github
> > >
> > > A minor correction is made in the generated json of:
> > > tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
> > > changing "\\Inbound\\" to just "Inbound" to avoid compilation errors
> > > caused by \I.
> > >
> > > The elkhartlake metrics file is basic and not generated by scripts. It
> > > is retained here although it causes a difference from the generated
> > > files.
> > >
> > > The mapfile.csv is the third and final difference from the generated
> > > version due to a bug in 01.org's models for icelake. The existing
> > > models are preferred and retained.
> > >
> > > As well as the #system_tsc_freq being necessary, a test change is
> > > added here fixing an issue with fake PMU testing exposed in the
> > > new/updated metrics.
> > >
> > > Compared to the previous json, additional changes are the inclusion of
> > > basic meteorlake events and the renaming of tremontx to
> > > snowridgex. The new metrics contribute to the size, but a large
> > > contribution is the inclusion of previously ungenerated and
> > > experimental uncore events.
> > >
> >
> > Hi Ian,
> >
> > Thanks for the patchset.
> >
> > I would like to test this.
> >
> > What is the base for your work?
> > Mainline Git? perf-tools Git [0]?
> > Do you have an own Git repository (look like this is [1]) with all the
> > required/prerequisites and your patchset-v1 for easier fetching?
>
> Hi Sedat,
>
> I have bits of trees all over the place but nowhere I push my kernel
> work at the moment. To test the patches try the following:
>
> 1) Get a copy of Arnaldo's perf/core branch where active perf tool work happens:
>
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> -b perf/core
> $ cd linux
>
> 2) Grab the #system_tsc_freq patches using b4:
>
> $ b4 am https://lore.kernel.org/lkml/20220718164312.3994191-1-irogers@google.com/
> $ git am ./v4_20220718_irogers_add_arch_tsc_frequency_information.mbx
>
> 3) Grab the vendor update patches using b4:
>
> $ b4 am https://lore.kernel.org/lkml/20220722223240.1618013-1-irogers@google.com/
> $ git am ./20220722_irogers_add_generated_latest_intel_events_and_metrics.mbx
>
> Not sure why but this fails on a bunch of patches due to conflicts on
> mapfile.csv. This doesn't matter too much as long as we get the
> mapfile.csv to look like the following:
>
> Family-model,Version,Filename,EventType
> GenuineIntel-6-9[7A],v1.13,alderlake,core
> GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
> GenuineIntel-6-(3D|47),v26,broadwell,core
> GenuineIntel-6-56,v23,broadwellde,core
> GenuineIntel-6-4F,v19,broadwellx,core
> GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
> GenuineIntel-6-96,v1.03,elkhartlake,core
> GenuineIntel-6-5[CF],v13,goldmont,core
> GenuineIntel-6-7A,v1.01,goldmontplus,core
> GenuineIntel-6-(3C|45|46),v31,haswell,core
> GenuineIntel-6-3F,v25,haswellx,core
> GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
> GenuineIntel-6-6[AC],v1.15,icelakex,core
> GenuineIntel-6-3A,v22,ivybridge,core
> GenuineIntel-6-3E,v21,ivytown,core
> GenuineIntel-6-2D,v21,jaketown,core
> GenuineIntel-6-(57|85),v9,knightslanding,core
> GenuineIntel-6-AA,v1.00,meteorlake,core
> GenuineIntel-6-1[AEF],v3,nehalemep,core
> GenuineIntel-6-2E,v3,nehalemex,core
> GenuineIntel-6-2A,v17,sandybridge,core
> GenuineIntel-6-8F,v1.04,sapphirerapids,core
> GenuineIntel-6-(37|4C|4D),v14,silvermont,core
> GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
> GenuineIntel-6-55-[01234],v1.28,skylakex,core
> GenuineIntel-6-86,v1.20,snowridgex,core
> GenuineIntel-6-8[CD],v1.07,tigerlake,core
> GenuineIntel-6-2C,v2,westmereep-dp,core
> GenuineIntel-6-25,v3,westmereep-sp,core
> GenuineIntel-6-2F,v3,westmereex,core
> AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
> AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
>
> When you see git say something like:
> error: patch failed: tools/perf/pmu-events/arch/x86/mapfile.csv:27
> error: tools/perf/pmu-events/arch/x86/mapfile.csv: patch does not apply
> edit tools/perf/pmu-events/arch/x86/mapfile.csv and add the 1 line
> change the patch has, which you can see in the diff with:
> $ git am --show-current-patch=diff
> then:
> $ git add tools/perf/pmu-events/arch/x86/mapfile.csv
> $ git am --continue
>
> I found also that the rename of
> tools/perf/pmu-events/arch/x86/tremontx to
> tools/perf/pmu-events/arch/x86/snowridgex didn't happen (you can mv
> the directory manually). Also that meteorlake files didn't get added,
> so you can just remove the meteorlake line from mapfile.csv.
>
> 4) build and test the perf command
>
> $ mkdir /tmp/perf
> $ make -C tools/perf O=/tmp/perf
> $ /tmp/perf/perf test
>
> Not sure why b4 isn't behaving well in step 3 but this should give you
> something to test with.
>
> Thanks,
> Ian
>
>
>
> > Regards,
> > -Sedat-
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
> > [1] https://github.com/captain5050
> >
> > > Ian Rogers (31):
> > >   perf test: Avoid sysfs state affecting fake events
> > >   perf vendor events: Update Intel broadwellx
> > >   perf vendor events: Update Intel broadwell
> > >   perf vendor events: Update Intel broadwellde
> > >   perf vendor events: Update Intel alderlake
> > >   perf vendor events: Update bonnell mapfile.csv
> > >   perf vendor events: Update Intel cascadelakex
> > >   perf vendor events: Update Intel elkhartlake
> > >   perf vendor events: Update goldmont mapfile.csv
> > >   perf vendor events: Update goldmontplus mapfile.csv
> > >   perf vendor events: Update Intel haswell
> > >   perf vendor events: Update Intel haswellx
> > >   perf vendor events: Update Intel icelake
> > >   perf vendor events: Update Intel icelakex
> > >   perf vendor events: Update Intel ivybridge
> > >   perf vendor events: Update Intel ivytown
> > >   perf vendor events: Update Intel jaketown
> > >   perf vendor events: Update Intel knightslanding
> > >   perf vendor events: Add Intel meteorlake
> > >   perf vendor events: Update Intel nehalemep
> > >   perf vendor events: Update Intel nehalemex
> > >   perf vendor events: Update Intel sandybridge
> > >   perf vendor events: Update Intel sapphirerapids
> > >   perf vendor events: Update Intel silvermont
> > >   perf vendor events: Update Intel skylake
> > >   perf vendor events: Update Intel skylakex
> > >   perf vendor events: Update Intel snowridgex
> > >   perf vendor events: Update Intel tigerlake
> > >   perf vendor events: Update Intel westmereep-dp
> > >   perf vendor events: Update Intel westmereep-sp
> > >   perf vendor events: Update Intel westmereex
> > >
> > >  .../arch/x86/alderlake/adl-metrics.json       |     4 +-
> > >  .../pmu-events/arch/x86/alderlake/cache.json  |   178 +-
> > >  .../arch/x86/alderlake/floating-point.json    |    19 +-
> > >  .../arch/x86/alderlake/frontend.json          |    38 +-
> > >  .../pmu-events/arch/x86/alderlake/memory.json |    40 +-
> > >  .../pmu-events/arch/x86/alderlake/other.json  |    97 +-
> > >  .../arch/x86/alderlake/pipeline.json          |   507 +-
> > >  .../arch/x86/alderlake/uncore-other.json      |     2 +-
> > >  .../arch/x86/alderlake/virtual-memory.json    |    63 +-
> > >  .../pmu-events/arch/x86/bonnell/cache.json    |     2 +-
> > >  .../arch/x86/bonnell/floating-point.json      |     2 +-
> > >  .../pmu-events/arch/x86/bonnell/frontend.json |     2 +-
> > >  .../pmu-events/arch/x86/bonnell/memory.json   |     2 +-
> > >  .../pmu-events/arch/x86/bonnell/other.json    |     2 +-
> > >  .../pmu-events/arch/x86/bonnell/pipeline.json |     2 +-
> > >  .../arch/x86/bonnell/virtual-memory.json      |     2 +-
> > >  .../arch/x86/broadwell/bdw-metrics.json       |   130 +-
> > >  .../pmu-events/arch/x86/broadwell/cache.json  |     2 +-
> > >  .../arch/x86/broadwell/floating-point.json    |     2 +-
> > >  .../arch/x86/broadwell/frontend.json          |     2 +-
> > >  .../pmu-events/arch/x86/broadwell/memory.json |     2 +-
> > >  .../pmu-events/arch/x86/broadwell/other.json  |     2 +-
> > >  .../arch/x86/broadwell/pipeline.json          |     2 +-
> > >  .../arch/x86/broadwell/uncore-cache.json      |   152 +
> > >  .../arch/x86/broadwell/uncore-other.json      |    82 +
> > >  .../pmu-events/arch/x86/broadwell/uncore.json |   278 -
> > >  .../arch/x86/broadwell/virtual-memory.json    |     2 +-
> > >  .../arch/x86/broadwellde/bdwde-metrics.json   |   136 +-
> > >  .../arch/x86/broadwellde/cache.json           |     2 +-
> > >  .../arch/x86/broadwellde/floating-point.json  |     2 +-
> > >  .../arch/x86/broadwellde/frontend.json        |     2 +-
> > >  .../arch/x86/broadwellde/memory.json          |     2 +-
> > >  .../arch/x86/broadwellde/other.json           |     2 +-
> > >  .../arch/x86/broadwellde/pipeline.json        |     2 +-
> > >  .../arch/x86/broadwellde/uncore-cache.json    |  3818 ++-
> > >  .../arch/x86/broadwellde/uncore-memory.json   |  2867 +-
> > >  .../arch/x86/broadwellde/uncore-other.json    |  1246 +
> > >  .../arch/x86/broadwellde/uncore-power.json    |   492 +-
> > >  .../arch/x86/broadwellde/virtual-memory.json  |     2 +-
> > >  .../arch/x86/broadwellx/bdx-metrics.json      |   570 +-
> > >  .../pmu-events/arch/x86/broadwellx/cache.json |    22 +-
> > >  .../arch/x86/broadwellx/floating-point.json   |     9 +-
> > >  .../arch/x86/broadwellx/frontend.json         |     2 +-
> > >  .../arch/x86/broadwellx/memory.json           |    39 +-
> > >  .../pmu-events/arch/x86/broadwellx/other.json |     2 +-
> > >  .../arch/x86/broadwellx/pipeline.json         |     4 +-
> > >  .../arch/x86/broadwellx/uncore-cache.json     |  3788 ++-
> > >  .../x86/broadwellx/uncore-interconnect.json   |  1438 +-
> > >  .../arch/x86/broadwellx/uncore-memory.json    |  2849 +-
> > >  .../arch/x86/broadwellx/uncore-other.json     |  3252 ++
> > >  .../arch/x86/broadwellx/uncore-power.json     |   437 +-
> > >  .../arch/x86/broadwellx/virtual-memory.json   |     2 +-
> > >  .../arch/x86/cascadelakex/cache.json          |     8 +-
> > >  .../arch/x86/cascadelakex/clx-metrics.json    |   724 +-
> > >  .../arch/x86/cascadelakex/floating-point.json |     2 +-
> > >  .../arch/x86/cascadelakex/frontend.json       |     2 +-
> > >  .../arch/x86/cascadelakex/other.json          |    63 +
> > >  .../arch/x86/cascadelakex/pipeline.json       |    11 +
> > >  .../arch/x86/cascadelakex/uncore-memory.json  |     9 +
> > >  .../arch/x86/cascadelakex/uncore-other.json   |   697 +-
> > >  .../arch/x86/cascadelakex/virtual-memory.json |     2 +-
> > >  .../arch/x86/elkhartlake/cache.json           |   956 +-
> > >  .../arch/x86/elkhartlake/floating-point.json  |    19 +-
> > >  .../arch/x86/elkhartlake/frontend.json        |    34 +-
> > >  .../arch/x86/elkhartlake/memory.json          |   388 +-
> > >  .../arch/x86/elkhartlake/other.json           |   527 +-
> > >  .../arch/x86/elkhartlake/pipeline.json        |   203 +-
> > >  .../arch/x86/elkhartlake/virtual-memory.json  |   151 +-
> > >  .../pmu-events/arch/x86/goldmont/cache.json   |     2 +-
> > >  .../arch/x86/goldmont/floating-point.json     |     2 +-
> > >  .../arch/x86/goldmont/frontend.json           |     2 +-
> > >  .../pmu-events/arch/x86/goldmont/memory.json  |     2 +-
> > >  .../arch/x86/goldmont/pipeline.json           |     2 +-
> > >  .../arch/x86/goldmont/virtual-memory.json     |     2 +-
> > >  .../arch/x86/goldmontplus/cache.json          |     2 +-
> > >  .../arch/x86/goldmontplus/floating-point.json |     2 +-
> > >  .../arch/x86/goldmontplus/frontend.json       |     2 +-
> > >  .../arch/x86/goldmontplus/memory.json         |     2 +-
> > >  .../arch/x86/goldmontplus/pipeline.json       |     2 +-
> > >  .../arch/x86/goldmontplus/virtual-memory.json |     2 +-
> > >  .../pmu-events/arch/x86/haswell/cache.json    |    78 +-
> > >  .../arch/x86/haswell/floating-point.json      |     2 +-
> > >  .../pmu-events/arch/x86/haswell/frontend.json |     2 +-
> > >  .../arch/x86/haswell/hsw-metrics.json         |    85 +-
> > >  .../pmu-events/arch/x86/haswell/memory.json   |    75 +-
> > >  .../pmu-events/arch/x86/haswell/other.json    |     2 +-
> > >  .../pmu-events/arch/x86/haswell/pipeline.json |     9 +-
> > >  .../arch/x86/haswell/uncore-other.json        |     7 +-
> > >  .../arch/x86/haswell/virtual-memory.json      |     2 +-
> > >  .../pmu-events/arch/x86/haswellx/cache.json   |    44 +-
> > >  .../arch/x86/haswellx/floating-point.json     |     2 +-
> > >  .../arch/x86/haswellx/frontend.json           |     2 +-
> > >  .../arch/x86/haswellx/hsx-metrics.json        |    85 +-
> > >  .../pmu-events/arch/x86/haswellx/memory.json  |    52 +-
> > >  .../pmu-events/arch/x86/haswellx/other.json   |     2 +-
> > >  .../arch/x86/haswellx/pipeline.json           |     9 +-
> > >  .../arch/x86/haswellx/uncore-cache.json       |  3779 ++-
> > >  .../x86/haswellx/uncore-interconnect.json     |  1430 +-
> > >  .../arch/x86/haswellx/uncore-memory.json      |  2839 +-
> > >  .../arch/x86/haswellx/uncore-other.json       |  3170 ++
> > >  .../arch/x86/haswellx/uncore-power.json       |   477 +-
> > >  .../arch/x86/haswellx/virtual-memory.json     |     2 +-
> > >  .../pmu-events/arch/x86/icelake/cache.json    |     8 +-
> > >  .../arch/x86/icelake/floating-point.json      |     2 +-
> > >  .../pmu-events/arch/x86/icelake/frontend.json |     2 +-
> > >  .../arch/x86/icelake/icl-metrics.json         |   126 +-
> > >  .../arch/x86/icelake/uncore-other.json        |    31 +
> > >  .../arch/x86/icelake/virtual-memory.json      |     2 +-
> > >  .../pmu-events/arch/x86/icelakex/cache.json   |    28 +-
> > >  .../arch/x86/icelakex/floating-point.json     |     2 +-
> > >  .../arch/x86/icelakex/frontend.json           |     2 +-
> > >  .../arch/x86/icelakex/icx-metrics.json        |   691 +-
> > >  .../pmu-events/arch/x86/icelakex/memory.json  |     6 +-
> > >  .../pmu-events/arch/x86/icelakex/other.json   |    51 +-
> > >  .../arch/x86/icelakex/pipeline.json           |    12 +
> > >  .../arch/x86/icelakex/virtual-memory.json     |     2 +-
> > >  .../pmu-events/arch/x86/ivybridge/cache.json  |     2 +-
> > >  .../arch/x86/ivybridge/floating-point.json    |     2 +-
> > >  .../arch/x86/ivybridge/frontend.json          |     2 +-
> > >  .../arch/x86/ivybridge/ivb-metrics.json       |    94 +-
> > >  .../pmu-events/arch/x86/ivybridge/memory.json |     2 +-
> > >  .../pmu-events/arch/x86/ivybridge/other.json  |     2 +-
> > >  .../arch/x86/ivybridge/pipeline.json          |     4 +-
> > >  .../arch/x86/ivybridge/uncore-other.json      |     2 +-
> > >  .../arch/x86/ivybridge/virtual-memory.json    |     2 +-
> > >  .../pmu-events/arch/x86/ivytown/cache.json    |     2 +-
> > >  .../arch/x86/ivytown/floating-point.json      |     2 +-
> > >  .../pmu-events/arch/x86/ivytown/frontend.json |     2 +-
> > >  .../arch/x86/ivytown/ivt-metrics.json         |    94 +-
> > >  .../pmu-events/arch/x86/ivytown/memory.json   |     2 +-
> > >  .../pmu-events/arch/x86/ivytown/other.json    |     2 +-
> > >  .../arch/x86/ivytown/uncore-cache.json        |  3495 ++-
> > >  .../arch/x86/ivytown/uncore-interconnect.json |  1750 +-
> > >  .../arch/x86/ivytown/uncore-memory.json       |  1775 +-
> > >  .../arch/x86/ivytown/uncore-other.json        |  2411 ++
> > >  .../arch/x86/ivytown/uncore-power.json        |   696 +-
> > >  .../arch/x86/ivytown/virtual-memory.json      |     2 +-
> > >  .../pmu-events/arch/x86/jaketown/cache.json   |     2 +-
> > >  .../arch/x86/jaketown/floating-point.json     |     2 +-
> > >  .../arch/x86/jaketown/frontend.json           |     2 +-
> > >  .../arch/x86/jaketown/jkt-metrics.json        |    11 +-
> > >  .../pmu-events/arch/x86/jaketown/memory.json  |     2 +-
> > >  .../pmu-events/arch/x86/jaketown/other.json   |     2 +-
> > >  .../arch/x86/jaketown/pipeline.json           |    16 +-
> > >  .../arch/x86/jaketown/uncore-cache.json       |  1960 +-
> > >  .../x86/jaketown/uncore-interconnect.json     |   824 +-
> > >  .../arch/x86/jaketown/uncore-memory.json      |   445 +-
> > >  .../arch/x86/jaketown/uncore-other.json       |  1551 +
> > >  .../arch/x86/jaketown/uncore-power.json       |   362 +-
> > >  .../arch/x86/jaketown/virtual-memory.json     |     2 +-
> > >  .../arch/x86/knightslanding/cache.json        |     2 +-
> > >  .../x86/knightslanding/floating-point.json    |     2 +-
> > >  .../arch/x86/knightslanding/frontend.json     |     2 +-
> > >  .../arch/x86/knightslanding/memory.json       |     2 +-
> > >  .../arch/x86/knightslanding/pipeline.json     |     2 +-
> > >  .../x86/knightslanding/uncore-memory.json     |    42 -
> > >  .../arch/x86/knightslanding/uncore-other.json |  3890 +++
> > >  .../x86/knightslanding/virtual-memory.json    |     2 +-
> > >  tools/perf/pmu-events/arch/x86/mapfile.csv    |    74 +-
> > >  .../pmu-events/arch/x86/meteorlake/cache.json |   262 +
> > >  .../arch/x86/meteorlake/frontend.json         |    24 +
> > >  .../arch/x86/meteorlake/memory.json           |   185 +
> > >  .../pmu-events/arch/x86/meteorlake/other.json |    46 +
> > >  .../arch/x86/meteorlake/pipeline.json         |   254 +
> > >  .../arch/x86/meteorlake/virtual-memory.json   |    46 +
> > >  .../pmu-events/arch/x86/nehalemep/cache.json  |    14 +-
> > >  .../arch/x86/nehalemep/floating-point.json    |     2 +-
> > >  .../arch/x86/nehalemep/frontend.json          |     2 +-
> > >  .../pmu-events/arch/x86/nehalemep/memory.json |     6 +-
> > >  .../arch/x86/nehalemep/virtual-memory.json    |     2 +-
> > >  .../pmu-events/arch/x86/nehalemex/cache.json  |  2974 +-
> > >  .../arch/x86/nehalemex/floating-point.json    |   182 +-
> > >  .../arch/x86/nehalemex/frontend.json          |    20 +-
> > >  .../pmu-events/arch/x86/nehalemex/memory.json |   672 +-
> > >  .../pmu-events/arch/x86/nehalemex/other.json  |   170 +-
> > >  .../arch/x86/nehalemex/pipeline.json          |   830 +-
> > >  .../arch/x86/nehalemex/virtual-memory.json    |    92 +-
> > >  .../arch/x86/sandybridge/cache.json           |     2 +-
> > >  .../arch/x86/sandybridge/floating-point.json  |     2 +-
> > >  .../arch/x86/sandybridge/frontend.json        |     4 +-
> > >  .../arch/x86/sandybridge/memory.json          |     2 +-
> > >  .../arch/x86/sandybridge/other.json           |     2 +-
> > >  .../arch/x86/sandybridge/pipeline.json        |    10 +-
> > >  .../arch/x86/sandybridge/snb-metrics.json     |    11 +-
> > >  .../arch/x86/sandybridge/uncore-other.json    |     2 +-
> > >  .../arch/x86/sandybridge/virtual-memory.json  |     2 +-
> > >  .../arch/x86/sapphirerapids/cache.json        |   135 +-
> > >  .../x86/sapphirerapids/floating-point.json    |     6 +
> > >  .../arch/x86/sapphirerapids/frontend.json     |    16 +
> > >  .../arch/x86/sapphirerapids/memory.json       |    23 +-
> > >  .../arch/x86/sapphirerapids/other.json        |    68 +-
> > >  .../arch/x86/sapphirerapids/pipeline.json     |    99 +-
> > >  .../arch/x86/sapphirerapids/spr-metrics.json  |   566 +-
> > >  .../arch/x86/sapphirerapids/uncore-other.json |     9 -
> > >  .../x86/sapphirerapids/virtual-memory.json    |    20 +
> > >  .../pmu-events/arch/x86/silvermont/cache.json |     2 +-
> > >  .../arch/x86/silvermont/floating-point.json   |     2 +-
> > >  .../arch/x86/silvermont/frontend.json         |     2 +-
> > >  .../arch/x86/silvermont/memory.json           |     2 +-
> > >  .../pmu-events/arch/x86/silvermont/other.json |     2 +-
> > >  .../arch/x86/silvermont/pipeline.json         |     2 +-
> > >  .../arch/x86/silvermont/virtual-memory.json   |     2 +-
> > >  .../arch/x86/skylake/floating-point.json      |     2 +-
> > >  .../pmu-events/arch/x86/skylake/frontend.json |     2 +-
> > >  .../pmu-events/arch/x86/skylake/other.json    |     2 +-
> > >  .../arch/x86/skylake/skl-metrics.json         |   178 +-
> > >  .../arch/x86/skylake/uncore-cache.json        |   142 +
> > >  .../arch/x86/skylake/uncore-other.json        |    79 +
> > >  .../pmu-events/arch/x86/skylake/uncore.json   |   254 -
> > >  .../arch/x86/skylake/virtual-memory.json      |     2 +-
> > >  .../arch/x86/skylakex/floating-point.json     |     2 +-
> > >  .../arch/x86/skylakex/frontend.json           |     2 +-
> > >  .../pmu-events/arch/x86/skylakex/other.json   |    66 +-
> > >  .../arch/x86/skylakex/pipeline.json           |    11 +
> > >  .../arch/x86/skylakex/skx-metrics.json        |   667 +-
> > >  .../arch/x86/skylakex/uncore-memory.json      |     9 +
> > >  .../arch/x86/skylakex/uncore-other.json       |   730 +-
> > >  .../arch/x86/skylakex/virtual-memory.json     |     2 +-
> > >  .../x86/{tremontx => snowridgex}/cache.json   |    60 +-
> > >  .../floating-point.json                       |     9 +-
> > >  .../{tremontx => snowridgex}/frontend.json    |    20 +-
> > >  .../x86/{tremontx => snowridgex}/memory.json  |     4 +-
> > >  .../x86/{tremontx => snowridgex}/other.json   |    18 +-
> > >  .../{tremontx => snowridgex}/pipeline.json    |    98 +-
> > >  .../arch/x86/snowridgex/uncore-memory.json    |   619 +
> > >  .../arch/x86/snowridgex/uncore-other.json     | 25249 ++++++++++++++++
> > >  .../arch/x86/snowridgex/uncore-power.json     |   235 +
> > >  .../virtual-memory.json                       |    69 +-
> > >  .../pmu-events/arch/x86/tigerlake/cache.json  |    48 +-
> > >  .../arch/x86/tigerlake/floating-point.json    |     2 +-
> > >  .../arch/x86/tigerlake/frontend.json          |     2 +-
> > >  .../pmu-events/arch/x86/tigerlake/memory.json |     2 +-
> > >  .../pmu-events/arch/x86/tigerlake/other.json  |     1 -
> > >  .../arch/x86/tigerlake/pipeline.json          |     4 +-
> > >  .../arch/x86/tigerlake/tgl-metrics.json       |   378 +-
> > >  .../arch/x86/tigerlake/uncore-other.json      |    65 +
> > >  .../arch/x86/tigerlake/virtual-memory.json    |     2 +-
> > >  .../arch/x86/tremontx/uncore-memory.json      |   245 -
> > >  .../arch/x86/tremontx/uncore-other.json       |  2395 --
> > >  .../arch/x86/tremontx/uncore-power.json       |    11 -
> > >  .../arch/x86/westmereep-dp/cache.json         |     2 +-
> > >  .../x86/westmereep-dp/floating-point.json     |     2 +-
> > >  .../arch/x86/westmereep-dp/frontend.json      |     2 +-
> > >  .../arch/x86/westmereep-dp/memory.json        |     2 +-
> > >  .../x86/westmereep-dp/virtual-memory.json     |     2 +-
> > >  .../x86/westmereep-sp/floating-point.json     |     2 +-
> > >  .../arch/x86/westmereep-sp/frontend.json      |     2 +-
> > >  .../x86/westmereep-sp/virtual-memory.json     |     2 +-
> > >  .../arch/x86/westmereex/floating-point.json   |     2 +-
> > >  .../arch/x86/westmereex/frontend.json         |     2 +-
> > >  .../arch/x86/westmereex/virtual-memory.json   |     2 +-
> > >  tools/perf/tests/pmu-events.c                 |     9 +
> > >  252 files changed, 89144 insertions(+), 8438 deletions(-)
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/cache.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/memory.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore.json
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/cache.json (95%)
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/floating-point.json (84%)
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/frontend.json (94%)
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/memory.json (99%)
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/other.json (98%)
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/pipeline.json (89%)
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> > >  rename tools/perf/pmu-events/arch/x86/{tremontx => snowridgex}/virtual-memory.json (91%)
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/uncore-other.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
> > >
> > > --
> > > 2.37.1.359.gd136c6c3e2-goog
> > >
