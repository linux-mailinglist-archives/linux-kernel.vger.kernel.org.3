Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1C5221E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347748AbiEJRCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiEJRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:02:18 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121082A4A26
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:58:20 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id y74so17502833vsy.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBZ8yzXWBGsOpOpeLa5W0W9gRThAtsIA/zK3DproKJI=;
        b=SC248B+drte04xKdlQ70/zo28TnMIDVRKbL6KdxKVvaTy+BJw6zg7/mjEXaavzrMmj
         1JPdB5mZLYfVCMfUys8sAc1VSknImedaRwvCFYWR7QglbUeYtJwgU88cZ9KbJgKgHQU4
         8azFzw1r/SamSGo2j/cf8Kk+jUSConbdAdQoh2O0kfmIsBMFaVG87w1CWx7/tgjje34H
         OCcmQ1XISmveOhDYocRsXWU+5HTir+riALOgCy+DzwqA+0UrUDbr1ATTezC5coRfvtKy
         mzZl2m+DSXh1EKdRX3r0aV5XtvIN8kTKYAum+qzE4F/daR2EWznYHnilxlp/r9++r+Dv
         n1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBZ8yzXWBGsOpOpeLa5W0W9gRThAtsIA/zK3DproKJI=;
        b=Lac1Mlc0aGcwkJnU16qIDXZluW2wjEiDZvSKYnBbcI3rphvt5A3FMexDs8acenbIRV
         g3hgg9Az54tR5bfL+2De/TYz3z403PCNJI3Ikw02ESJKfIZHCyHx+nwwu78qa8Ro+boN
         NSUX7zFDzBAG/vcJEdrN36mqPZQjwy3vVd2faYkApohVxGyGISRHHh+Y+oG5eLY6AwBF
         Fcd1MvKIJ5nPaCJyvDcur47AapN1ZlgNDX2T9PQHmc5JwQKcjdVve2Lj9bt1RIL/pfP0
         PzssOWhmrPsHzg5eXMd3UqFNef0pTmF4Jf4Z+GpgMM9L71BCgU1JaxPc9u3e0tKWcRNY
         ouQw==
X-Gm-Message-State: AOAM531wEFJc1ngsxs9JIKy2fpg1e+/1vLp85y1JiXniYMappegphWdi
        MA6po56lBRCnkX4rZdXfAWt/wyzDt0cMONBI4d9P/Q==
X-Google-Smtp-Source: ABdhPJwoFonBDxjusEqLqiTK0uVTTNt5Xf4FZQwxFLlkjsdpB74jRGEf2PVrPcKre2Q7qsqcT2Rww1gU6SvfHRGAcp8=
X-Received: by 2002:a05:6102:244d:b0:32c:dfc4:d818 with SMTP id
 g13-20020a056102244d00b0032cdfc4d818mr12312772vss.74.1652201898969; Tue, 10
 May 2022 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
 <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com>
 <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com> <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
 <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com> <CAP-5=fXnYUnbT89q9W0Ax3d-26jbL5Mcd7O5X=JcXq9FnOUm7Q@mail.gmail.com>
 <0c8da8b4-4f77-4329-9e63-721d05fd258d@linux.intel.com>
In-Reply-To: <0c8da8b4-4f77-4329-9e63-721d05fd258d@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 May 2022 09:58:07 -0700
Message-ID: <CAP-5=fUwSkikUiLpXURYKM4FEf=0zMW9a3Q5h8=Wg08ht5KXHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf evlist: Keep topdown counters in weak group
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
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

On Mon, May 9, 2022 at 2:01 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
> On 5/9/2022 1:28 PM, Ian Rogers wrote:
> > On Thu, May 5, 2022 at 12:44 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 5/5/2022 2:31 PM, Ian Rogers wrote:
> >>>>> So I think fixing all of these should be a follow up. I am working to
> >>>>> get access to an Alderlake system, could we land this first?
> >>>>>
> >>>> I think we can use pmu_name to replace the "cpu" to fix the issue for
> >>>> the hybrid platform. For a hybrid platform, the pmu_name is either
> >>>> cpu_atom or cpu_core.
> >>>>
> >>>> Besides, the topdown events may have a PMU prefix, e.g.,
> >>>> cpu_core/topdown-be-bound/. The strcasecmp may not work well for this case.
> >>>>
> >>>> How about the below patch?
> >>>> If it's OK for you, could you please merge it into your V2 patch set?
> >>>> I can do the test on a ADL system.
> >>>>
> >>>> diff --git a/tools/perf/arch/x86/util/evsel.c
> >>>> b/tools/perf/arch/x86/util/evsel.c
> >>>> index 40b171de2086..551ae2bab70e 100644
> >>>> --- a/tools/perf/arch/x86/util/evsel.c
> >>>> +++ b/tools/perf/arch/x86/util/evsel.c
> >>>> @@ -33,11 +33,12 @@ void arch_evsel__fixup_new_cycles(struct
> >>>> perf_event_attr *attr)
> >>>>
> >>>>     bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >>>>     {
> >>>> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> >>>> -           !pmu_have_event("cpu", "slots"))
> >>>> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
> >>>> +
> >>>> +       if (!pmu_have_event(pmu_name, "slots"))
> >>>>                   return false;
> >>> Hmm. The idea with this test is to see if the architecture supports
> >>> topdown events before going further. There's a similar test in all the
> >>> arch_evlist functions. I think with cpu_core this needs to become:
> >>>
> >>
> >> The case is a little bit different here. For the arch_evlist functions,
> >> the input is the evlist, not the specific evsel. So we have to check all
> >> the possible PMU names which are "cpu" and "cpu_core". Then we decide
> >> whether going further.
> >>
> >> The input of the evsel__must_be_in_group() is the evsel. The PMU name is
> >> stored in the evsel->pmu_name. I don't think we need to check all the
> >> possible PMU names. Using evsel->pmu_name should be good enough.
> >>
> >>> if (!pmu_have_event("cpu", "slots") && !pmu_have_event("cpu_core", "slots") )
> >>>
> >>> But we should add a helper function for this. It is odd to have this
> >>> change supporting Alderlake but the existing evlist work not. Perhaps
> >>> we should just wait until Zhengjun's patches land.
> >>
> >> Yes, a helper function is good for the arch_evlist functions. But I
> >> don't think this patch needs the helper function. Zhengjun's patches are
> >> to fix the other topdown issues on ADL. There is no dependency between
> >> this patch and zhengjun's patches.
> >>
> >> Thanks,
> >> Kan
> >
> > TL;DR I think we can move forward with landing these patches to fix Icelake.
>
> This patch doesn't work with the hybrid platform for sure. I can send
> you a fix for the hybrid part if you prefer this way? Then I guess you
> may append it as the patch 3 for V2.
>
> Besides the hybrid thing, the patch set also has other two issues I
> mentioned in the previous reply.
> - I don't think the strcasecmp() can handle the case like
> cpu/topdown-bad-spec/ or cpu/slots/. It should be an issue for both
> hybrid and non-hybrid platforms.
> - It's better not to use non-architecture events, e.g., baclears.any,
> ARITH.DIVIDER_ACTIVE, even in the test case. The non-architecture events
> may be disappear in the future platforms. If so, you have to update the
> test case again for the future platforms.
> IMHO, I don't think the patch set is ready.

So all the stated objections are that I'm checking cpu/slots/ for an
indication of topdown support and this doesn't work for hybrid? This
is identical to the arch evlist code:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/arch/x86/util/evlist.c?h=perf/core#n10
both in the functions arch_evlist__add_default_attrs and
arch_evlist__leader (one I wrote and one I didn't). So the patch set
isn't ready because I haven't fixed alderlake, but alderlake already
isn't working? And there is no example of how to make this work for
alderlake. So basically your ask is that I bring up alderlake. I think
this is stretching things for a patch fixing icelake. The value here
is in fixing icelake and alderlake will have to be the next problem.

> >
> > For Alderlake/hybrid we have a problem. To determine what happens with
> > grouping we need to know does the CPU have topdown events? This is a
> > runtime question for doing perf_event_open and so an arch test and
> > weak symbol are appropriate. For Icelake we are determining the
> > presence of topdown events by looking at the special PMU cpu. For
> > Alderlake the same information can be found by looking at the PMUs
> > cpu_core and cpu_atom, but how to discover those PMU names?
>
> The PMU name can be retrieved either from the event list or perf command.
> For the non-hybrid, the PMU name is hard code to "cpu" for the core
> events. So users/event files don't need to specify the PMU name.
> For the hybrid platform, a PMU name is required and stored in the
> evsel->pmu_name. If the evsel->pmu_name is NULL, we can assume that it's
> a non-hybrid PMU, CPU.

This doesn't make sense. Hybrid implies more than 1 CPU type, how can
more than one be the same as 1 type to be used for the PMU? Again, you
are asking I make all the alderlake logic work and I think that should
be follow up. As shown above the arch evlist code also needs fixing as
follow up.

Thanks,
Ian

> > It is
> > already somewhat concerning that we've hard coded "cpu" and we don't
> > want to have an ever growing list of PMU names.
> >
> > We have similarly hard coded "cpu" in the topology code here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/cputopo.c?h=tmp.perf/core#n18
> > Is this unreasonable given cpu is already supposed to be ABI stable:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/Documentation/ABI/stable/sysfs-devices-system-cpu?h=tmp.perf/core
>
> I don't think there is a stable ABI for a PMU name.
> The PMU name may be changed generation by generation because of the
> different micro arch. We will try our best to keep it unchanged in X86
> but it's not guaranteed especially when the hybrid is introduced.
>
>
> >
> > It is hard to say what the right hybrid fix is here. I should get a
> > system I can poke shortly. I'd also like to compare what's in sysfs
> > for Alderlake with ARM's big.little approach. I can imagine we need a
> > function that returns a list of CPU like PMUs for probing. Ideally we
> > could work this out from sysfs and use some stable ABI.
> >
>
> I don't think there is a standard PMU naming rule for all the ARCHs. For
> X86, it may be possible. You can assume that the name like "cpu" or
> "cpu_*" are for core PMUs. But for other ARCH e.g., ARM, AFAIK, they use
> a quite different naming rule.
>
>
> Thanks,
> Kan
