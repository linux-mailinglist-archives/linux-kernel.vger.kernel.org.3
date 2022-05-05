Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291551C3B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbiEEPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiEEPWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:22:31 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4584B1FF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:18:51 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a127so4508255vsa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VEJvhDTHgb2ZulVOAAJhKz6Jc03RLtxcq5aCbH9WWeY=;
        b=j1u4JRqE0T4SVMIg+AnVjJG4bpeAcNQ8r28TQQCEoBem0faWP3HUYUunyVqm18IJ5e
         ebEVhRRZdck8iORa80Zv88pohYSBuueqlPEP56cjnQ1Fy5XTSor3vdYe+2+CzvRGHyHG
         r3rDn0d4Den+5w/niYqUlM9FOlKcOVWbx1wCwSmRkHQ2maxehSDNo1RiXffSupC0jKrc
         azzAdoAw4+YJl76QVuBF131DOVUGq/MPenQ5XP+LTtC4SDLFG98bghO3IsFS6ghEArVw
         Hpm2UFrXhR3NrH3dsj+oGFxgSvH37BfTILroP0I8bveA/k1EXiJTzZojylzhfJovO3O0
         v9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VEJvhDTHgb2ZulVOAAJhKz6Jc03RLtxcq5aCbH9WWeY=;
        b=kpsRY8oafNamRIm9eB7rTCkbaQDaQy1O0j1/Ha1lgA+QoWQqIAaqacCghtxoPeLZ1G
         g06ZhjhM0Hq5xxXPEehmfXAGGVkcW8Ed2CZ1Mihv9Mp0VagaQWhAvqDvwxRVSH/8mY05
         oPzB3RZGipQSJXFvQX0Mx/5lXQvRcxXeCOy9dTsDRRvh4UsnfMBg+j0kqNXnoKkUupXJ
         HDZeNbEsbsF8UawxaU9xxdcut+E5KL2uRTPnIzYpMIoPaOxJ4KOk4jC7xZk2Gm13h5/f
         dD8eg53oRTKN75enzLzOMx5BEnq0odxgmlL+vNvIoUjDMLpwmon+hwv/qaE2Qb97hw74
         9g6Q==
X-Gm-Message-State: AOAM533bQ5mtdf/Nwgc6A2HDSUFkzqP+AeEk6gRKR3v12b5IL1fsQgzB
        vquBXdNk54/apQYbFVeckr31/yuUJ3I06fQguHyMPw==
X-Google-Smtp-Source: ABdhPJyqX+1rBuUp0/qNBO/cKB+nFdFM/lyWAibJ4OcZwGFjF2PFkKGoIE1oz55aHIsFCsqfF7pKrfK/7xC2NiOHFII=
X-Received: by 2002:a67:cf49:0:b0:32d:1bea:c7b8 with SMTP id
 f9-20020a67cf49000000b0032d1beac7b8mr8916826vsm.39.1651763923180; Thu, 05 May
 2022 08:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com> <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
In-Reply-To: <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 08:18:30 -0700
Message-ID: <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com>
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
        Stephane Eranian <eranian@google.com>
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

On Thu, May 5, 2022 at 4:56 AM Liang, Kan <kan.liang@linux.intel.com> wrote=
:
>
> Hi Ian,
>
> Thanks for the patches.
>
> On 5/5/2022 12:38 AM, Ian Rogers wrote:
> > On Intel Icelake, topdown events must always be grouped with a slots
> > event as leader. When a metric is parsed a weak group is formed and
> > retried if perf_event_open fails. The retried events aren't grouped
> > breaking the slots leader requirement. This change modifies the weak
> > group "reset" behavior so that topdown events aren't broken from the
> > group for the retry.
> >
> > $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bou=
nd,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-miss=
es,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles=
,baclears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >      47,867,188,483      slots                                         =
                (92.27%)
> >     <not supported>      topdown-bad-spec
> >     <not supported>      topdown-be-bound
> >     <not supported>      topdown-fe-bound
> >     <not supported>      topdown-retiring
> >       2,173,346,937      branch-instructions                           =
                (92.27%)
> >          10,540,253      branch-misses             #    0.48% of all br=
anches          (92.29%)
> >          96,291,140      bus-cycles                                    =
                (92.29%)
> >           6,214,202      cache-misses              #   20.120 % of all =
cache refs      (92.29%)
> >          30,886,082      cache-references                              =
                (76.91%)
> >      11,773,726,641      cpu-cycles                                    =
                (84.62%)
> >      11,807,585,307      instructions              #    1.00  insn per =
cycle           (92.31%)
> >                   0      mem-loads                                     =
                (92.32%)
> >       2,212,928,573      mem-stores                                    =
                (84.69%)
> >      10,024,403,118      ref-cycles                                    =
                (92.35%)
> >          16,232,978      baclears.any                                  =
                (92.35%)
> >          23,832,633      ARITH.DIVIDER_ACTIVE                          =
                (84.59%)
> >
> >         0.981070734 seconds time elapsed
> >
> > After:
> >
> > $ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bou=
nd,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-miss=
es,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles=
,baclears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1
> >
> >   Performance counter stats for 'system wide':
> >
> >         31040189283      slots                                         =
                (92.27%)
> >          8997514811      topdown-bad-spec          #     28.2% bad spec=
ulation         (92.27%)
> >         10997536028      topdown-be-bound          #     34.5% backend =
bound           (92.27%)
> >          4778060526      topdown-fe-bound          #     15.0% frontend=
 bound          (92.27%)
> >          7086628768      topdown-retiring          #     22.2% retiring=
                (92.27%)
> >          1417611942      branch-instructions                           =
                (92.26%)
> >             5285529      branch-misses             #    0.37% of all br=
anches          (92.28%)
> >            62922469      bus-cycles                                    =
                (92.29%)
> >             1440708      cache-misses              #    8.292 % of all =
cache refs      (92.30%)
> >            17374098      cache-references                              =
                (76.94%)
> >          8040889520      cpu-cycles                                    =
                (84.63%)
> >          7709992319      instructions              #    0.96  insn per =
cycle           (92.32%)
> >                   0      mem-loads                                     =
                (92.32%)
> >          1515669558      mem-stores                                    =
                (84.68%)
> >          6542411177      ref-cycles                                    =
                (92.35%)
> >             4154149      baclears.any                                  =
                (92.35%)
> >            20556152      ARITH.DIVIDER_ACTIVE                          =
                (84.59%)
> >
> >         1.010799593 seconds time elapsed
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/arch/x86/util/evsel.c | 12 ++++++++++++
> >   tools/perf/util/evlist.c         | 16 ++++++++++++++--
> >   tools/perf/util/evsel.c          | 10 ++++++++++
> >   tools/perf/util/evsel.h          |  3 +++
> >   4 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/uti=
l/evsel.c
> > index ac2899a25b7a..40b171de2086 100644
> > --- a/tools/perf/arch/x86/util/evsel.c
> > +++ b/tools/perf/arch/x86/util/evsel.c
> > @@ -3,6 +3,7 @@
> >   #include <stdlib.h>
> >   #include "util/evsel.h"
> >   #include "util/env.h"
> > +#include "util/pmu.h"
> >   #include "linux/string.h"
> >
> >   void arch_evsel__set_sample_weight(struct evsel *evsel)
> > @@ -29,3 +30,14 @@ void arch_evsel__fixup_new_cycles(struct perf_event_=
attr *attr)
> >
> >       free(env.cpuid);
> >   }
> > +
> > +bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> > +{
> > +     if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> > +         !pmu_have_event("cpu", "slots"))
> > +             return false;
> > +
>
> The big core of ADL also supports Perf_metrics. At least, we should
> check both "cpu" and "cpu_core" here.
>
> Thanks,
> Kan

Thanks Kan, we have the same problem for
arch_evlist__add_default_attrs and arch_evlist__leader:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/arch/x86/util/evlist.c?h=3Dperf/core
So I think fixing all of these should be a follow up. I am working to
get access to an Alderlake system, could we land this first?

Thanks,
Ian

> > +     return evsel->name &&
> > +             (!strcasecmp(evsel->name, "slots") ||
> > +              !strncasecmp(evsel->name, "topdown", 7));
> > +}
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 52ea004ba01e..dfa65a383502 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -1790,8 +1790,17 @@ struct evsel *evlist__reset_weak_group(struct ev=
list *evsel_list, struct evsel *
> >               if (evsel__has_leader(c2, leader)) {
> >                       if (is_open && close)
> >                               perf_evsel__close(&c2->core);
> > -                     evsel__set_leader(c2, c2);
> > -                     c2->core.nr_members =3D 0;
> > +                     /*
> > +                      * We want to close all members of the group and =
reopen
> > +                      * them. Some events, like Intel topdown, require=
 being
> > +                      * in a group and so keep these in the group.
> > +                      */
> > +                     if (!evsel__must_be_in_group(c2) && c2 !=3D leade=
r) {
> > +                             evsel__set_leader(c2, c2);
> > +                             c2->core.nr_members =3D 0;
> > +                             leader->core.nr_members--;
> > +                     }
> > +
> >                       /*
> >                        * Set this for all former members of the group
> >                        * to indicate they get reopened.
> > @@ -1799,6 +1808,9 @@ struct evsel *evlist__reset_weak_group(struct evl=
ist *evsel_list, struct evsel *
> >                       c2->reset_group =3D true;
> >               }
> >       }
> > +     /* Reset the leader count if all entries were removed. */
> > +     if (leader->core.nr_members)
> > +             leader->core.nr_members =3D 0;
> >       return leader;
> >   }
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d38722560e80..b7c0c9775673 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3082,3 +3082,13 @@ int evsel__source_count(const struct evsel *evse=
l)
> >       }
> >       return count;
> >   }
> > +
> > +bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __m=
aybe_unused)
> > +{
> > +     return false;
> > +}
> > +
> > +bool evsel__must_be_in_group(const struct evsel *evsel)
> > +{
> > +     return arch_evsel__must_be_in_group(evsel);
> > +}
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 45d674812239..0ed2850b7ebb 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -488,6 +488,9 @@ bool evsel__has_leader(struct evsel *evsel, struct =
evsel *leader);
> >   bool evsel__is_leader(struct evsel *evsel);
> >   void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
> >   int evsel__source_count(const struct evsel *evsel);
> > +bool evsel__must_be_in_group(const struct evsel *evsel);
> > +
> > +bool arch_evsel__must_be_in_group(const struct evsel *evsel);
> >
> >   /*
> >    * Macro to swap the bit-field postition and size.
