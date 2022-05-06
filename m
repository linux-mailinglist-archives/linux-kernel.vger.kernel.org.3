Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B838851CEA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387690AbiEFA4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387682AbiEFA4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:56:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51731EEEA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:52:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so8088451wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3osFXp0WfQmXfGW5Ofy95IMQTPeb2J9u7TSSHzZLME4=;
        b=kmdim9OTmD223Fk65osgWy4WVzzVwaS32xr7wZQTr2MBHb7oFPbSXgAKP/yWEVBNV7
         btQ+b5SGRWZWaj9hBSLPGNloFvtkH+7cdnPGJ49AOam9QYFT5qR4C4a6DUM4cje5hJQn
         iKAy3EHpX2uPCi/fUc3hY8FMMVJOjJ0KPrUolRLxzsMAgFwK1wuN/MvyFvvbh0TW4iuz
         oWKmdeaRZ9k8iMY7DsWM4Xw26AT0fxVaYmHxP85n642RbKWxPkKcqSuKZSVHRBIHxw9D
         nbfFc6CBXaW8kmRGhAvjegRMyN+F5Z2NeDXXsf/XvKGTkhLAa4WgI1MpGCeasOpVf1lj
         3mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3osFXp0WfQmXfGW5Ofy95IMQTPeb2J9u7TSSHzZLME4=;
        b=5xB+azWxbmOxvfEzUxrMZBEwZ6FLSmPvFtJcTiUGQt401MlE1gYlJzXVBSy0L1pEfY
         aiIvKGaS5AOw1CWo2yOFhMiOS/KKPI5JDlchIe3Z6Os8Y/Lx5KOZFthFWo3VTxupPloy
         BYd2fMuObp6SAHOuspoY7USKilC7P4z7gAAtezGYj+2NR+GEB47EMpbC2FsbsQxBk29L
         /Het0I14tp5dCW2mATmwqCZ7Z+lR93R/p/Lnca1LO3UD38itVERnEtMAsyl8EGLR+dOF
         XuAxpgl53PtKvP7cHzYZOY5+KX0lT4gVyFknimqOwdZX7HUOsxFncnrybvrJ44YtmOuH
         mXCg==
X-Gm-Message-State: AOAM531ek8bGVJYw4RtPOFLAGG69YM6IfibOfmQ0Zi4PI4CbxfAZ12GT
        I1E+HYL+roM3OJWiIDBZdMhVqXzhUCeja13Qp5qv1g==
X-Google-Smtp-Source: ABdhPJx8yk14UJNO/CRX2fACL175omfsOPF0sIg6VcinASB8xF9LBJ928opQ2Tc/HUardOkr/aZljBYYQi0X4HNhnYU=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr545517wrm.40.1651798356090; Thu, 05 May
 2022 17:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com>
 <20220505165639.361733-21-adrian.hunter@intel.com> <CAP-5=fUQbEDvgftWRSHvWEhHqboNxxwWSK7dhTe=8G6i+wXpfg@mail.gmail.com>
In-Reply-To: <CAP-5=fUQbEDvgftWRSHvWEhHqboNxxwWSK7dhTe=8G6i+wXpfg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 17:52:21 -0700
Message-ID: <CAP-5=fUoJYg+Hg4S9yHHGC4R02sjeiJtfMues1X=mxTbu=57OA@mail.gmail.com>
Subject: Re: [PATCH V1 20/23] perf stat: Add requires_cpu flag for uncore
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
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

On Thu, May 5, 2022 at 5:50 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, May 5, 2022 at 9:58 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Uncore events require a CPU i.e. it cannot be -1.
> >
> > The evsel system_wide flag is intended for events that should be on every
> > CPU, which does not make sense for uncore events because uncore events do
> > not map one-to-one with CPUs.
> >
> > These 2 requirements are not exactly the same, so introduce a new flag
> > 'requires_cpu' the uncore case.
>
> nit: typo missing 'for' the uncore case.
>
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Comments coming up in 2 patches time :-)

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/lib/perf/evlist.c                 | 4 +++-
> >  tools/lib/perf/include/internal/evsel.h | 1 +
> >  tools/perf/builtin-stat.c               | 5 +----
> >  tools/perf/util/evsel.c                 | 1 +
> >  tools/perf/util/parse-events.c          | 2 +-
> >  5 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 8a82b4b94b99..3bf77f9617b6 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -43,7 +43,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >         if (!evsel->own_cpus || evlist->has_user_cpus) {
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> > -       } else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
> > +       } else if (!evsel->system_wide &&
> > +                  !evsel->requires_cpu &&
> > +                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
> >         } else if (evsel->cpus != evsel->own_cpus) {
> > diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> > index cfc9ebd7968e..77fbb8b97e5c 100644
> > --- a/tools/lib/perf/include/internal/evsel.h
> > +++ b/tools/lib/perf/include/internal/evsel.h
> > @@ -50,6 +50,7 @@ struct perf_evsel {
> >         /* parse modifier helper */
> >         int                      nr_members;
>
> From the commit message, could we add the comment:
>
> /* True for events that should be on every CPU. */
>
> However, shouldn't this be captured by the CPU map? Perhaps we can
> have an invariant check that they agree.
>
> >         bool                     system_wide;
>
> /* True for events that cannot be the any CPU (-1), for example,
> uncore events. */
>
> > +       bool                     requires_cpu;
> >         int                      idx;
> >  };
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 1b96636df01e..c049533f74e4 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -385,9 +385,6 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
> >         if (!counter->supported)
> >                 return -ENOENT;
> >
> > -       if (counter->core.system_wide)
> > -               nthreads = 1;
> > -
> >         for (thread = 0; thread < nthreads; thread++) {
> >                 struct perf_counts_values *count;
> >
> > @@ -2264,7 +2261,7 @@ static void setup_system_wide(int forks)
> >                 struct evsel *counter;
> >
> >                 evlist__for_each_entry(evsel_list, counter) {
> > -                       if (!counter->core.system_wide &&
> > +                       if (!counter->core.requires_cpu &&
> >                             strcmp(counter->name, "duration_time")) {
>
> Off-topic of the patch: this test is a tool event check, it'd be better to do:
>
> if (!counter->core.requires_cpu && counter->tool_event != PERF_TOOL_NONE)
>
> Otherwise changes like:
> https://lore.kernel.org/linux-perf-users/20220420102354.468173-1-florian.fischer@muhq.space/
>
> Will break the test. I'll make a note to do a round of clean up.
>
> Thanks,
> Ian
>
>
> >                                 return;
> >                         }
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d38722560e80..12346293706b 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -382,6 +382,7 @@ struct evsel *evsel__clone(struct evsel *orig)
> >         evsel->core.threads = perf_thread_map__get(orig->core.threads);
> >         evsel->core.nr_members = orig->core.nr_members;
> >         evsel->core.system_wide = orig->core.system_wide;
> > +       evsel->core.requires_cpu = orig->core.requires_cpu;
> >
> >         if (orig->name) {
> >                 evsel->name = strdup(orig->name);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 937f6c9434a2..5227174099b5 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -365,7 +365,7 @@ __add_event(struct list_head *list, int *idx,
> >         (*idx)++;
> >         evsel->core.cpus = cpus;
> >         evsel->core.own_cpus = perf_cpu_map__get(cpus);
> > -       evsel->core.system_wide = pmu ? pmu->is_uncore : false;
> > +       evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
> >         evsel->auto_merge_stats = auto_merge_stats;
> >
> >         if (name)
> > --
> > 2.25.1
> >
