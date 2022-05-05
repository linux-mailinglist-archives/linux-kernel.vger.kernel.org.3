Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614CA51C828
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384691AbiEESmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384398AbiEESmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:42:33 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB6D66AC9
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:31:34 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id t85so5010619vst.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I+s6eSEgX7VT4YaUGMk4yfqAJuzTQqz0OALDSN2MMSU=;
        b=CsbJ2EBkJc0pw1NmzWz9EkEATe4y7DS/nOd5MSXdyvNixrpj9+6/TMyeXyc6fzMhpQ
         5MFt38cLvLoeRLy7qQzgdrRMukjYBI2d/VVrrp9119qUPe+TlmUa6YMGL8xb45xIA+db
         YJw3j9btT4wJ5TIBVxV8OP18kXRdIO0o/dNTIeoqNKFa8j7twcj1haiXKxK2iIFCmco5
         9YLuVhqPj3iMzbEWvHWVKvGC3Dm/mepbbtABgw+jNJ5plEgv8Uds3oxSsakwV7iP5usy
         u8yUnCvREBiad30MTfMk2WVUNDf6XzRYdIU67gdxWMVZVsfKaIkwDz+PRTWqmcjECf6Z
         Ns9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I+s6eSEgX7VT4YaUGMk4yfqAJuzTQqz0OALDSN2MMSU=;
        b=nxHbzZgX672PX/CbopEq7/JpO9zXJmkpDOA7aobybl26csJKBwtU0rxPTvW7a32jmk
         /shY+vQmnS7Grh80phZBSMqMy+7dUTc/ZACD09S3GeTyY0SeZAxCqFPJIO2SQQGWJ4bL
         P+WU8fT6r6ySbPH79PtSKnk3dWAJJedT97gE0SnWXSDGOfHvggDFluLlTYQ6Lir/IEHe
         ybKo5c2BxyhulOqUCh33PUAN87+g67BDU3eyk6pyw7HtqKfOsj8Srou6wT3Xh0rNJPDw
         eO5+dkD9siFk2GwboelV0xP5VvvjIyvlYLpshwfP93KIC5od37tWAYnoyGB6HaqE41Kz
         aRKA==
X-Gm-Message-State: AOAM533xdsvzIZhvGe//zsooq2Db4dwNaFd38JSFjYPE8QMz3uUbeIGO
        0FwrQ2hZoSVfDC8c5gtab/t2mT8dyb4Py2pIpW8XTg==
X-Google-Smtp-Source: ABdhPJy7isFowmjW0tmGC1Z/BsOtM9+GJM4XoeRS0JMAbE1UYpCjcHWh3h9fECkO5Agey+Ti4Z8GVLzn19g6zESncvo=
X-Received: by 2002:a05:6102:2929:b0:32d:6662:72e2 with SMTP id
 cz41-20020a056102292900b0032d666272e2mr3983463vsb.56.1651775493500; Thu, 05
 May 2022 11:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
 <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com> <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com>
In-Reply-To: <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 11:31:20 -0700
Message-ID: <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 5, 2022 at 11:15 AM Liang, Kan <kan.liang@linux.intel.com> wrot=
e:
>
> On 5/5/2022 11:18 AM, Ian Rogers wrote:
> > On Thu, May 5, 2022 at 4:56 AM Liang, Kan <kan.liang@linux.intel.com> w=
rote:
> >>
> >> Hi Ian,
> >>
> >> Thanks for the patches.
> >>
> >> On 5/5/2022 12:38 AM, Ian Rogers wrote:
> >>> On Intel Icelake, topdown events must always be grouped with a slots
> >>> event as leader. When a metric is parsed a weak group is formed and
> >>> retried if perf_event_open fails. The retried events aren't grouped
> >>> breaking the slots leader requirement. This change modifies the weak
> >>> group "reset" behavior so that topdown events aren't broken from the
> >>> group for the retry.
> >>>
> >>> $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-b=
ound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-mi=
sses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycl=
es,baclears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1
> >>>
> >>>    Performance counter stats for 'system wide':
> >>>
> >>>       47,867,188,483      slots                                      =
                   (92.27%)
> >>>      <not supported>      topdown-bad-spec
> >>>      <not supported>      topdown-be-bound
> >>>      <not supported>      topdown-fe-bound
> >>>      <not supported>      topdown-retiring
> >>>        2,173,346,937      branch-instructions                        =
                   (92.27%)
> >>>           10,540,253      branch-misses             #    0.48% of all=
 branches          (92.29%)
> >>>           96,291,140      bus-cycles                                 =
                   (92.29%)
> >>>            6,214,202      cache-misses              #   20.120 % of a=
ll cache refs      (92.29%)
> >>>           30,886,082      cache-references                           =
                   (76.91%)
> >>>       11,773,726,641      cpu-cycles                                 =
                   (84.62%)
> >>>       11,807,585,307      instructions              #    1.00  insn p=
er cycle           (92.31%)
> >>>                    0      mem-loads                                  =
                   (92.32%)
> >>>        2,212,928,573      mem-stores                                 =
                   (84.69%)
> >>>       10,024,403,118      ref-cycles                                 =
                   (92.35%)
> >>>           16,232,978      baclears.any                               =
                   (92.35%)
> >>>           23,832,633      ARITH.DIVIDER_ACTIVE                       =
                   (84.59%)
> >>>
> >>>          0.981070734 seconds time elapsed
> >>>
> >>> After:
> >>>
> >>> $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-b=
ound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-mi=
sses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycl=
es,baclears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1
> >>>
> >>>    Performance counter stats for 'system wide':
> >>>
> >>>          31040189283      slots                                      =
                   (92.27%)
> >>>           8997514811      topdown-bad-spec          #     28.2% bad s=
peculation         (92.27%)
> >>>          10997536028      topdown-be-bound          #     34.5% backe=
nd bound           (92.27%)
> >>>           4778060526      topdown-fe-bound          #     15.0% front=
end bound          (92.27%)
> >>>           7086628768      topdown-retiring          #     22.2% retir=
ing                (92.27%)
> >>>           1417611942      branch-instructions                        =
                   (92.26%)
> >>>              5285529      branch-misses             #    0.37% of all=
 branches          (92.28%)
> >>>             62922469      bus-cycles                                 =
                   (92.29%)
> >>>              1440708      cache-misses              #    8.292 % of a=
ll cache refs      (92.30%)
> >>>             17374098      cache-references                           =
                   (76.94%)
> >>>           8040889520      cpu-cycles                                 =
                   (84.63%)
> >>>           7709992319      instructions              #    0.96  insn p=
er cycle           (92.32%)
> >>>                    0      mem-loads                                  =
                   (92.32%)
> >>>           1515669558      mem-stores                                 =
                   (84.68%)
> >>>           6542411177      ref-cycles                                 =
                   (92.35%)
> >>>              4154149      baclears.any                               =
                   (92.35%)
> >>>             20556152      ARITH.DIVIDER_ACTIVE                       =
                   (84.59%)
> >>>
> >>>          1.010799593 seconds time elapsed
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>    tools/perf/arch/x86/util/evsel.c | 12 ++++++++++++
> >>>    tools/perf/util/evlist.c         | 16 ++++++++++++++--
> >>>    tools/perf/util/evsel.c          | 10 ++++++++++
> >>>    tools/perf/util/evsel.h          |  3 +++
> >>>    4 files changed, 39 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/u=
til/evsel.c
> >>> index ac2899a25b7a..40b171de2086 100644
> >>> --- a/tools/perf/arch/x86/util/evsel.c
> >>> +++ b/tools/perf/arch/x86/util/evsel.c
> >>> @@ -3,6 +3,7 @@
> >>>    #include <stdlib.h>
> >>>    #include "util/evsel.h"
> >>>    #include "util/env.h"
> >>> +#include "util/pmu.h"
> >>>    #include "linux/string.h"
> >>>
> >>>    void arch_evsel__set_sample_weight(struct evsel *evsel)
> >>> @@ -29,3 +30,14 @@ void arch_evsel__fixup_new_cycles(struct perf_even=
t_attr *attr)
> >>>
> >>>        free(env.cpuid);
> >>>    }
> >>> +
> >>> +bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >>> +{
> >>> +     if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> >>> +         !pmu_have_event("cpu", "slots"))
> >>> +             return false;
> >>> +
> >>
> >> The big core of ADL also supports Perf_metrics. At least, we should
> >> check both "cpu" and "cpu_core" here.
> >>
> >> Thanks,
> >> Kan
> >
> > Thanks Kan, we have the same problem for
> > arch_evlist__add_default_attrs and arch_evlist__leader:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/arch/x86/util/evlist.c?h=3Dperf/core
>
> These are known issues. Zhengjun already have some patches to fix them,
> but hasn't posted yet.
>
> The arch_evlist__add_default_attrs impacts the perf stat default. On the
> ADL, perf stat default doesn't display the topdown events.
>
> The arch_evlist__leader impacts the sampling read of the topdown events.
> Sampling read the topdown events should always fail with the current
> perf tool on ADL.
>
> We already have many backlogs on ADL. I think it's better not to
> introduce more issues.
>
> > So I think fixing all of these should be a follow up. I am working to
> > get access to an Alderlake system, could we land this first?
> >
>
> I think we can use pmu_name to replace the "cpu" to fix the issue for
> the hybrid platform. For a hybrid platform, the pmu_name is either
> cpu_atom or cpu_core.
>
> Besides, the topdown events may have a PMU prefix, e.g.,
> cpu_core/topdown-be-bound/. The strcasecmp may not work well for this cas=
e.
>
> How about the below patch?
> If it's OK for you, could you please merge it into your V2 patch set?
> I can do the test on a ADL system.
>
> diff --git a/tools/perf/arch/x86/util/evsel.c
> b/tools/perf/arch/x86/util/evsel.c
> index 40b171de2086..551ae2bab70e 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -33,11 +33,12 @@ void arch_evsel__fixup_new_cycles(struct
> perf_event_attr *attr)
>
>   bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>   {
> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> -           !pmu_have_event("cpu", "slots"))
> +       const char *pmu_name =3D evsel->pmu_name ? evsel->pmu_name : "cpu=
";
> +
> +       if (!pmu_have_event(pmu_name, "slots"))
>                 return false;

Hmm. The idea with this test is to see if the architecture supports
topdown events before going further. There's a similar test in all the
arch_evlist functions. I think with cpu_core this needs to become:

if (!pmu_have_event("cpu", "slots") && !pmu_have_event("cpu_core", "slots")=
 )

But we should add a helper function for this. It is odd to have this
change supporting Alderlake but the existing evlist work not. Perhaps
we should just wait until Zhengjun's patches land.

Thanks,
Ian

>         return evsel->name &&
> -               (!strcasecmp(evsel->name, "slots") ||
> -                !strncasecmp(evsel->name, "topdown", 7));
> +               (strcasestr(evsel->name, "slots") ||
> +                strcasestr(evsel->name, "topdown"));
>   }
>
>
>
> Thanks,
> Kan
>
> > Thanks,
> > Ian
> >
> >>> +     return evsel->name &&
> >>> +             (!strcasecmp(evsel->name, "slots") ||
> >>> +              !strncasecmp(evsel->name, "topdown", 7));
> >>> +}
> >>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >>> index 52ea004ba01e..dfa65a383502 100644
> >>> --- a/tools/perf/util/evlist.c
> >>> +++ b/tools/perf/util/evlist.c
> >>> @@ -1790,8 +1790,17 @@ struct evsel *evlist__reset_weak_group(struct =
evlist *evsel_list, struct evsel *
> >>>                if (evsel__has_leader(c2, leader)) {
> >>>                        if (is_open && close)
> >>>                                perf_evsel__close(&c2->core);
> >>> -                     evsel__set_leader(c2, c2);
> >>> -                     c2->core.nr_members =3D 0;
> >>> +                     /*
> >>> +                      * We want to close all members of the group an=
d reopen
> >>> +                      * them. Some events, like Intel topdown, requi=
re being
> >>> +                      * in a group and so keep these in the group.
> >>> +                      */
> >>> +                     if (!evsel__must_be_in_group(c2) && c2 !=3D lea=
der) {
> >>> +                             evsel__set_leader(c2, c2);
> >>> +                             c2->core.nr_members =3D 0;
> >>> +                             leader->core.nr_members--;
> >>> +                     }
> >>> +
> >>>                        /*
> >>>                         * Set this for all former members of the grou=
p
> >>>                         * to indicate they get reopened.
> >>> @@ -1799,6 +1808,9 @@ struct evsel *evlist__reset_weak_group(struct e=
vlist *evsel_list, struct evsel *
> >>>                        c2->reset_group =3D true;
> >>>                }
> >>>        }
> >>> +     /* Reset the leader count if all entries were removed. */
> >>> +     if (leader->core.nr_members)
> >>> +             leader->core.nr_members =3D 0;
> >>>        return leader;
> >>>    }
> >>>
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index d38722560e80..b7c0c9775673 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -3082,3 +3082,13 @@ int evsel__source_count(const struct evsel *ev=
sel)
> >>>        }
> >>>        return count;
> >>>    }
> >>> +
> >>> +bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel _=
_maybe_unused)
> >>> +{
> >>> +     return false;
> >>> +}
> >>> +
> >>> +bool evsel__must_be_in_group(const struct evsel *evsel)
> >>> +{
> >>> +     return arch_evsel__must_be_in_group(evsel);
> >>> +}
> >>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >>> index 45d674812239..0ed2850b7ebb 100644
> >>> --- a/tools/perf/util/evsel.h
> >>> +++ b/tools/perf/util/evsel.h
> >>> @@ -488,6 +488,9 @@ bool evsel__has_leader(struct evsel *evsel, struc=
t evsel *leader);
> >>>    bool evsel__is_leader(struct evsel *evsel);
> >>>    void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> >>>    int evsel__source_count(const struct evsel *evsel);
> >>> +bool evsel__must_be_in_group(const struct evsel *evsel);
> >>> +
> >>> +bool arch_evsel__must_be_in_group(const struct evsel *evsel);
> >>>
> >>>    /*
> >>>     * Macro to swap the bit-field postition and size.
