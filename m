Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58252552D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357808AbiELSxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245570AbiELSxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:53:38 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E65EBC1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:53:37 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-ed9a75c453so7739424fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GoERZWL9kpL8imWUhy43te5wetYw2TXLQqKFXsoQks=;
        b=khGuMYETArJ09N5CIWfaDdKQ+5pLGkYIn/4P4oJIO2ZmFYhQxhb8aKwPU2BL+rTQ7z
         fmLy5XGuL/RSw27+LxdcasxojLDGU/vWFCmm2HIeSkt3cORuRTihQfkKD1n9s3zoIRvp
         pMMHGBOn5ndBnKFqHx4A4X+sVWk0KCOgTwBeCUieLrxZdOUS3nsei6cemRVQE9vXcRXy
         +eiFYZ+2T+v1lEnysLUrLpWKd9ylhn6AEuFKHVR+JPS/gYD5knULkIJkmLbfEjA85H96
         DSP7Sdk6rhWJ+JmFcXNh7CHGXn5QTDumJJKy9+oATlJVv3KaAZlKfBQ2+x49si/7KiFy
         cIjg==
X-Gm-Message-State: AOAM530BcEiDnI6JoLoYiOQgtLP2AEB/RMO1m/muvyKFiRW8mR7usV7T
        rXCn9H3LbSkgLptuZV+uvPPVJwPupAKf1hmSMpfGsDZx
X-Google-Smtp-Source: ABdhPJyIL7xqsk432mh/AXfnjBDWbg/NFKxnKnYDDOldNVflYp/+7LEraujNVjyzf7asHxlc8C0Vf3XlF+EkOgTMxt0=
X-Received: by 2002:a05:6870:d1cd:b0:e1:e7ee:faa0 with SMTP id
 b13-20020a056870d1cd00b000e1e7eefaa0mr6347762oac.5.1652381616532; Thu, 12 May
 2022 11:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com> <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
 <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com>
In-Reply-To: <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 May 2022 11:53:25 -0700
Message-ID: <CAM9d7cgDCd2uUJbWcvqmCDGMoPc9kppx--_rcO2OVp_GarLJkg@mail.gmail.com>
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 3:35 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 12/05/22 08:27, Namhyung Kim wrote:
> > On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
> >> has_user_cpus. Change that so that system-wide events retain their own
> >> CPUs and they are added to all_cpus.
> >>
> >> Acked-by: Ian Rogers <irogers@google.com>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/lib/perf/evlist.c | 11 +++++------
> >>  1 file changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> >> index 1c801f8da44f..9a6801b53274 100644
> >> --- a/tools/lib/perf/evlist.c
> >> +++ b/tools/lib/perf/evlist.c
> >> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >>          * We already have cpus for evsel (via PMU sysfs) so
> >>          * keep it, if there's no target cpu list defined.
> >>          */
> >> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
> >> -               perf_cpu_map__put(evsel->cpus);
> >> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >> -       } else if (!evsel->system_wide &&
> >> -                  !evsel->requires_cpu &&
> >> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
> >> +       if (!evsel->own_cpus ||
> >> +           (!evsel->system_wide && evlist->has_user_cpus) ||
> >> +           (!evsel->system_wide &&
> >> +            !evsel->requires_cpu &&
> >> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
> >
> > This is getting hard to understand.  IIUC this propagation basically
> > sets user requested cpus to evsel unless it has its own cpus, right?
>
> I put the conditional logic altogether because that is kernel style but
> it does make it practically unreadable.
>
> If we start with the original logic:
>
>         if (!evsel->own_cpus || evlist->has_user_cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>         } else if (evsel->cpus != evsel->own_cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
>         }
>
> Then make it more readable, i.e. same functionality
>
>         struct perf_cpu_map *cpus;
>
>         if (!evsel->own_cpus || evlist->has_user_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus))
>                 cpus = evlist->user_requested_cpus;
>         else
>                 cpus = evsel->own_cpus;
>
>         if (evsel->cpus != cpus) {
>                 perf_cpu_map__put(evsel->cpus);
>                 evsel->cpus = perf_cpu_map__get(cpus);
>         }
>
> Then separate out the conditions, i.e. still same functionality
>
>         if (!evsel->own_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (evlist->has_user_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (evsel->system_wide)
>                 cpus = evsel->own_cpus;
>         else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>                 cpus = evlist->user_requested_cpus;
>         else
>                 cpus = evsel->own_cpus;
>
> Then add the new requires_cpu flag:
>
>         if (!evsel->own_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (evlist->has_user_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (evsel->system_wide)
>                 cpus = evsel->own_cpus;
> -       else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
> +       else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>                 cpus = evlist->user_requested_cpus;
>         else
>                 cpus = evsel->own_cpus;
>
> Then make system_wide keep own_cpus even if has_user_cpus:
>
>         if (!evsel->own_cpus)
>                 cpus = evlist->user_requested_cpus;
> +       else if (evsel->system_wide)
> +               cpus = evsel->own_cpus;
>         else if (evlist->has_user_cpus)
>                 cpus = evlist->user_requested_cpus;
> -       else if (evsel->system_wide)
> -               cpus = evsel->own_cpus;
>         else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>                 cpus = evlist->user_requested_cpus;
>         else
>                 cpus = evsel->own_cpus;
>
> Which leaves:
>
>         if (!evsel->own_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (evsel->system_wide)
>                 cpus = evsel->own_cpus;
>         else if (evlist->has_user_cpus)
>                 cpus = evlist->user_requested_cpus;
>         else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
>                 cpus = evlist->user_requested_cpus;
>         else
>                 cpus = evsel->own_cpus;
>
> And putting it back together:
>
>         if (!evsel->own_cpus ||
>             (!evsel->system_wide && evlist->has_user_cpus) ||
>             (!evsel->system_wide &&
>              !evsel->requires_cpu &&
>              perf_cpu_map__empty(evlist->user_requested_cpus))) {
>                 cpus = evlist->user_requested_cpus;
>         else
>                 cpus = evsel->own_cpus;
>
> Perhaps I shouldn't put it together?

Cool, thanks a lot for explaining it in detail.
I do not oppose your change but little worried about the
complexity.  And I think we have some issues with uncore
events already.

So do you have any idea where evsel->own_cpus
doesn't propagate to evsel->cpus?

I think evsel->system_wide and evsel->requires_cpu
can be replaced to check evsel->own_cpus instead.

Actually evlist->has_user_cpus is checked first so
uncore events' own_cpus might not be used.

In my laptop, perf stat -a -A -e imc/data_reads/
will use cpu 0 as it's listed in the pmu cpumask.
But when I use -C1,2 it'll use the both cpus and
returns the similar values each (so the sum is 2x).

I'm not sure if it's intended.  I expect it runs on
cpu 0 or one of the given cpus.  Or it runs on both
cpus and returns value in half so that the sum is
the same as the original value (from a cpu).

>
> >
> > But the hybrid pmus make this complex.  Maybe we can move the
> > logic in evlist__fix_hybrid_cpus() here and simplify it like below
> >
> > if (evsel->own_cpus) {
> >    if (evsel->pmu->is_hybrid)
> >       evsel->cpus = fixup_hybrid_cpus(evsel>own_cpus,
> >                                       evlist->user_requested_cpus);  //?
> >    else
> >       evsel->cpus = evlist->own_cpus;  // put + get
> > } else {
> >    evsel->cpus = evlist->user_requested_cpus;  // put + get
> > }
> >
> > Then we need to make sure evsel->pmu is set properly.
> >
> > What do you think?
>
> Hybrid handling looks complicated.  I would have to spend time
> better understanding it.
>
> So, in the context of this patch set, I don't want to look at
> issues with hybrid CPUs, except that there should be no change
> to how they are handled.

Fair enough.  But I think we have to look at it again soon.

Thanks,
Namhyung
