Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFEE5203AC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiEIRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiEIRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:32:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9D27EBB1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:28:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so20476104wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1bopt98I3waHgLq149Sd9tf4yf2YLICVLzIky9yT44=;
        b=awdyFHQXUThM7hZBNq5IZTN2yJXos41Ya6tdkWwTzxJoXZ0oRrWN63N4bIybTRPTCU
         slhLnNquBMhiKHxO85fAmOUkj0Cqr7W5TZu0U3U27hkyk4Xyopzb60ZGA5vRuDBuzfB4
         zP9izLcfs4u1vjx8MF++iTi3nuWkCmUx8zZbUAgXi9mYLApQEZwSs0YgLH3Jg3vkVPMg
         zVao8W3/ENV4LORtI8hoIL0RmVinhd/oFFRlqwolgIhSk78XhMI/E2bY4o1OSsWVFLvO
         eWjT5OA7Vs719cDFD1/MYmJE5RGaveizFjji6AhMi2OqE2C6ml+h/FhHSVQGDNPRbfo2
         eYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1bopt98I3waHgLq149Sd9tf4yf2YLICVLzIky9yT44=;
        b=dU5cic/Le6DnvAg4B4wm3Z0XO7j+pu0xqY1cf0OkBVPplypREiCaNDFri5XWDzxYPm
         x10lS7bwlArhrdhpM2DUUaC/au8Ci7H+4tKvmLNNa54q7fMfLMm9Lv4GDnarc+flcI3U
         Xw/GpuinNo8etf5vO9Eqp/1EkzolsOqcVwC6lnFhNmykuKyv9GfXuGdqG1NDh4YZ5Y9U
         47BlhNvd0srq5yj6ugXgre6JbWzQAIimlF9xlENIslWefdpYqHhJiTOhQWoOfaB6brf3
         iyf76qOEEDZbqE/OSq4toRha9QFSotFno/avL2L86U4hfMX8LdwqHMIVJKTNQ6kTH0qc
         2X6w==
X-Gm-Message-State: AOAM530bmxboo+FifEy2QmUnH328taUZf+F2KBhe/O+a7ochbNOzwAql
        jM8e/tYj03T2WYehhAovsa6tyz+V5UHh25peswttag==
X-Google-Smtp-Source: ABdhPJx5Yp1mhs3PbL+YlzJ8QfnGAWyT+iIEUSGvXjh60h9PdXr4MWUOuogBwUQBI9DBINxcHoUXY1U4apmuSGmazwE=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr14940551wro.654.1652117332485; Mon, 09
 May 2022 10:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
 <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com>
 <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com> <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
 <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com>
In-Reply-To: <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 May 2022 10:28:40 -0700
Message-ID: <CAP-5=fXnYUnbT89q9W0Ax3d-26jbL5Mcd7O5X=JcXq9FnOUm7Q@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 12:44 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 5/5/2022 2:31 PM, Ian Rogers wrote:
> >>> So I think fixing all of these should be a follow up. I am working to
> >>> get access to an Alderlake system, could we land this first?
> >>>
> >> I think we can use pmu_name to replace the "cpu" to fix the issue for
> >> the hybrid platform. For a hybrid platform, the pmu_name is either
> >> cpu_atom or cpu_core.
> >>
> >> Besides, the topdown events may have a PMU prefix, e.g.,
> >> cpu_core/topdown-be-bound/. The strcasecmp may not work well for this case.
> >>
> >> How about the below patch?
> >> If it's OK for you, could you please merge it into your V2 patch set?
> >> I can do the test on a ADL system.
> >>
> >> diff --git a/tools/perf/arch/x86/util/evsel.c
> >> b/tools/perf/arch/x86/util/evsel.c
> >> index 40b171de2086..551ae2bab70e 100644
> >> --- a/tools/perf/arch/x86/util/evsel.c
> >> +++ b/tools/perf/arch/x86/util/evsel.c
> >> @@ -33,11 +33,12 @@ void arch_evsel__fixup_new_cycles(struct
> >> perf_event_attr *attr)
> >>
> >>    bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >>    {
> >> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> >> -           !pmu_have_event("cpu", "slots"))
> >> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
> >> +
> >> +       if (!pmu_have_event(pmu_name, "slots"))
> >>                  return false;
> > Hmm. The idea with this test is to see if the architecture supports
> > topdown events before going further. There's a similar test in all the
> > arch_evlist functions. I think with cpu_core this needs to become:
> >
>
> The case is a little bit different here. For the arch_evlist functions,
> the input is the evlist, not the specific evsel. So we have to check all
> the possible PMU names which are "cpu" and "cpu_core". Then we decide
> whether going further.
>
> The input of the evsel__must_be_in_group() is the evsel. The PMU name is
> stored in the evsel->pmu_name. I don't think we need to check all the
> possible PMU names. Using evsel->pmu_name should be good enough.
>
> > if (!pmu_have_event("cpu", "slots") && !pmu_have_event("cpu_core", "slots") )
> >
> > But we should add a helper function for this. It is odd to have this
> > change supporting Alderlake but the existing evlist work not. Perhaps
> > we should just wait until Zhengjun's patches land.
>
> Yes, a helper function is good for the arch_evlist functions. But I
> don't think this patch needs the helper function. Zhengjun's patches are
> to fix the other topdown issues on ADL. There is no dependency between
> this patch and zhengjun's patches.
>
> Thanks,
> Kan

TL;DR I think we can move forward with landing these patches to fix Icelake.

For Alderlake/hybrid we have a problem. To determine what happens with
grouping we need to know does the CPU have topdown events? This is a
runtime question for doing perf_event_open and so an arch test and
weak symbol are appropriate. For Icelake we are determining the
presence of topdown events by looking at the special PMU cpu. For
Alderlake the same information can be found by looking at the PMUs
cpu_core and cpu_atom, but how to discover those PMU names? It is
already somewhat concerning that we've hard coded "cpu" and we don't
want to have an ever growing list of PMU names.

We have similarly hard coded "cpu" in the topology code here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/cputopo.c?h=tmp.perf/core#n18
Is this unreasonable given cpu is already supposed to be ABI stable:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/Documentation/ABI/stable/sysfs-devices-system-cpu?h=tmp.perf/core

It is hard to say what the right hybrid fix is here. I should get a
system I can poke shortly. I'd also like to compare what's in sysfs
for Alderlake with ARM's big.little approach. I can imagine we need a
function that returns a list of CPU like PMUs for probing. Ideally we
could work this out from sysfs and use some stable ABI.

Thanks,
Ian
