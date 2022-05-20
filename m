Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5515052E3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiETEcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbiETEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:32:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7D8579A9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:32:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u27so9004614wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+yLwX4v2kJDuTdhPmFkHWTh5EbBsLz6n6h1cv0PsHE=;
        b=l4UUOYRepzob/HFyAF2Rl6gwo8FbLs4V2ylF9L4Aele+X1dKOZDCu93dLjeMtJOO28
         QXum7nQMlIz1Mza0YhEnjd38y5eFmyu1Tdi1MnRFBdptOjrMkjdifzIijNlNg+uP3pp4
         cyi1M2xWQGOujm7/0dB18yhCS34gPdxosiotphU+Z8lT4jtoSSWy8ccuKPEq8lxTog3B
         fQcZGa1Z+8hHeXXPrMkYjdh7HeZhmGzDG3rV7RqO7+im6R9JoJ4IJA4lzqVk9XvBrH0J
         xL2sFwmmt1uOjla9JJzKMWXiHh5FTdmAdLZjh3jhAGgVmPk+jsTLKHsOyshYaJvewkre
         xMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+yLwX4v2kJDuTdhPmFkHWTh5EbBsLz6n6h1cv0PsHE=;
        b=s/NCDDwEQWOihXUVS5UmTLC4B5p3/DrSrH1zTlGKovgJGCnrMX0E3b2w1r3eQZ4qWi
         ZNdKR7X6S8tzijO2klmfXG9DdYKcvDfsg88w6huXYdM6aI3iHmhGj6zhTex3Oqw7KsiW
         oStXb2OmbRfIudrGLni+qOuTqcK5bn3P5k3sADZ8vhbnbYABidEKu1+KJBB+OEn9PKY9
         n3YB+7W1Znxdjs/bMPKXJh9R5h3JgeimzVsTQvYJFpLp9qyXi1EUTXz6mhSa+iih/PJr
         ElVB1f6OstYIg3pqmKw6QMKA9mi/Wd105cktqN40LrGD9+GKKoHvbZgh0Olx5CgKJNcA
         WrNg==
X-Gm-Message-State: AOAM532ZuCyjEvcw4cGtwXGnyN5lBQPedq/MFFgz/E1gjnpC+ZWBTyKE
        xB1e4Omg5+hMMFHEM2p2TnU3kHuxV7ATkAsQjHkpOw==
X-Google-Smtp-Source: ABdhPJwQN/0YILiNXWjmTMiG3mOUXqk0m3Fwxd7G7ym80oOOIkivHTG/LVUHBmB2V75Nev6A+wsACLruMGgRETw9Qlo=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr6647011wrq.654.1653021124626; Thu, 19
 May 2022 21:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-3-ravi.bangoria@amd.com>
 <CAP-5=fXiZj+EBqmg89faK0pZD-Af3V1fHWMOkds1oKoaz+ucFA@mail.gmail.com> <e578d274-946f-2c73-026d-9b172ce32f19@amd.com>
In-Reply-To: <e578d274-946f-2c73-026d-9b172ce32f19@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 21:31:52 -0700
Message-ID: <CAP-5=fXJQcVEUEz3taSXsm0Kd0Fs3Vc4+++vz1fVEHLjB3nMPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] perf header: Parse non-cpu pmu capabilities
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
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

On Thu, May 19, 2022 at 8:49 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Ian,
>
> On 20-May-22 3:57 AM, Ian Rogers wrote:
> > On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>
> >> Pmus advertise their capabilities via sysfs attribute files but
> >> perf tool currently parses only core(cpu) pmu capabilities. Add
> >> support for parsing non-cpu pmu capabilities.
> >>
> >> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >> ---
> >>  .../Documentation/perf.data-file-format.txt   |  18 ++
> >>  tools/perf/util/env.c                         |  48 +++++
> >>  tools/perf/util/env.h                         |  11 +
> >>  tools/perf/util/header.c                      | 198 ++++++++++++++++++
> >>  tools/perf/util/header.h                      |   1 +
> >>  tools/perf/util/pmu.c                         |  15 +-
> >>  tools/perf/util/pmu.h                         |   2 +
> >>  7 files changed, 289 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> >> index f56d0e0fbff6..7f8341db9134 100644
> >> --- a/tools/perf/Documentation/perf.data-file-format.txt
> >> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> >> @@ -435,6 +435,24 @@ struct {
> >>         } [nr_pmu];
> >>  };
> >>
> >> +       HEADER_PMU_CAPS = 32,
> >> +
> >> +       List of pmu capabilities (except cpu pmu which is already
> >> +       covered by HEADER_CPU_PMU_CAPS)
> >
> > Sorry for the ignorance, is this currently broken for hybrid then?
> > Will hybrid have a HEADER_CPU_PMU_CAPS? Presumably this varies between
> > ARM's big.little and Alderlake.
>
> It's covered by HEADER_HYBRID_CPU_PMU_CAPS, but that too covers only
> cpu pmu. I think I should update the above comment to:
>
>         List of pmu capabilities (except cpu pmu which is already
>         covered by HEADER_CPU_PMU_CAPS / HEADER_HYBRID_CPU_PMU_CAPS)
>
> >> +
> >> +struct {
> >> +       u32 nr_pmus;
> >> +       struct {
> >> +               u32 core_type;  /* For hybrid topology */
> >
> > Could this be pmu_type as presumably we can have capabilities on any
> > kind of PMU?
>
> Not sure I follow that question but let me just put my thoughts here.
>
> {core_type, pmu_name} is the unique key here. Considering a hypothetical
> scenario: A system has two types of cores P-core and E-core. Certain pmu
> inside P-core has some capabilities which are missing in the identical
> pmu belonging to E-core. The header will look something like:
>
> struct {
>         .nr_pmus = 2,
>         [0] = struct {
>                 .core_type = 0, /* P-core */
>                 .pmu_name = xyz_pmu,
>                 .nr_caps = 2,
>                 [0] = { .name = cap1, .value = value1 },
>                 [1] = { .name = cap2, .value = value2 },
>         },
>         [1] = struct {
>                 .core_type = 1; /* E-core */
>                 .pmu_name = xyz_pmu;
>                 .nr_caps = 1;
>                 [0] = { .name = cap1, .value = value1 };
>         },
> };
>
> Does that answer your question?
>
> Thanks for the review,
> Ravi

I may be being a little ahead of the current code as I'm wondering
about heterogeneous systems with many non-CPU PMUs. It seems such a
scenario just wouldn't touch the core_type field here. Could the p or
e core-ness of a PMU be implied by the name? Is there something
similar to core_type in sysfs or would we use the name in that case?

Thanks,
Ian
