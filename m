Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2DC515982
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381969AbiD3BNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346943AbiD3BNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:13:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8878EE0C2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:10:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d5so12745090wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/a5ljRFZhYXEjLddAM9nRcuoh3XdDUt0CimFZregVbQ=;
        b=Eg0KawaXriFIrCO0euxBXcWAwOwcYX5INInvWR+nCPeBgfDxdnqQZMBdQbC8gNNhZm
         2dam+bp8L0qivRF47NoAMG9cIhiSf/f3raxshzyntse1yizBoUpyHuZirdxzNrPnw6uR
         y4JncESA8ac+4D2PxQnfNxVmqCnwtDMipzDTEDPJX6dYBU0rqyTcUHeeE2fyTjDAoO8R
         V3FS6cEs215Qw4zjr5cg52Fhr2ddSdqx7L251XuYA09kTr2OfW0QptgTxKsUZmktECBc
         rXOzvEBR9PW5GQUR7qrxYx3tvlDyiDuDwytQkiqqpNmxltk3wlIroF/ggtP7pFlH872D
         xodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/a5ljRFZhYXEjLddAM9nRcuoh3XdDUt0CimFZregVbQ=;
        b=mccqvN26uDzbd3RQXeOC7/ASmM+xevAS55y0prrF5j3AxtZw8d4hASpvaC5bo7gZHN
         aF9hpGVybUu8e9xgMnSFoNlS0fytpjRyszjJnBHUxokx27qUOcPYlMyP9tAEWWg7yeds
         IQJJnKJ+QWg0GZYUuuZKP88xMODugCcf9UxS7ioAF4gzgTFHRhYO3lBcU9ki+LMVKboQ
         0T80FtpozNZXnLnTFYR/hwEqsb+XKdgN97Wwty+neLP5Q0n1+ivgoHw0vvpt2LPlXXc7
         80Y2XeFYsT0e139OxXzt4bizmLjoHgzEcwjuO3mdOb3kw+qicRSKDxqTNjR6XoblW35x
         /Syw==
X-Gm-Message-State: AOAM531g6MTIDLWmaSIVxWsVnzOFDG130LEyZDiisfPdnBW52ayX4t7m
        jlX+aHsKIRgigcmcs8nKk7NFpRhHRnASI+agcOG4vA==
X-Google-Smtp-Source: ABdhPJwr+bhOYRDEPrG49oBVB8RHo2rLLZ59UHqEapXpoYFxm/AiP4EfhMFoQMKWECFa+8X9ZMizPmvrswRBgbg/wCk=
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id
 m1-20020a5d6241000000b00207ac0e3549mr1182184wrv.343.1651281017863; Fri, 29
 Apr 2022 18:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com>
 <20220422162402.147958-20-adrian.hunter@intel.com> <CAM9d7cir40QisAK7AxsO6Rm3ARpPNLy8L6SFHXpHJ=Eu8obA5w@mail.gmail.com>
In-Reply-To: <CAM9d7cir40QisAK7AxsO6Rm3ARpPNLy8L6SFHXpHJ=Eu8obA5w@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Apr 2022 18:10:05 -0700
Message-ID: <CAP-5=fV2Kf2Mj_hZu39xwzYkmeuy999H8TZcEtLtp+XyKeHdBg@mail.gmail.com>
Subject: Re: [PATCH RFC 19/21] perf stat: Add requires_cpu flag for uncore
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 3:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Apr 22, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
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
> Yeah, I like this change!  I was often confused by the two different things.
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/lib/perf/evlist.c                 | 4 +++-
> >  tools/lib/perf/include/internal/evsel.h | 1 +
> >  tools/perf/builtin-stat.c               | 5 +----
> >  tools/perf/util/evsel.c                 | 1 +
> >  tools/perf/util/parse-events.c          | 2 +-
> >  5 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 37dfa9d936a7..9fbcca3fc836 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -42,7 +42,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
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
> >         bool                     system_wide;

Nice cleanup! Could we add some comments here as to what the booleans
mean/imply?

Thanks,
Ian

> > +       bool                     requires_cpu;
> >         int                      idx;
> >  };
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index a96f106dc93a..8972ae546cfe 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -364,9 +364,6 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
> >         if (!counter->supported)
> >                 return -ENOENT;
> >
> > -       if (counter->core.system_wide)
> > -               nthreads = 1;
> > -
> >         for (thread = 0; thread < nthreads; thread++) {
> >                 struct perf_counts_values *count;
> >
> > @@ -2224,7 +2221,7 @@ static void setup_system_wide(int forks)
> >                 struct evsel *counter;
> >
> >                 evlist__for_each_entry(evsel_list, counter) {
> > -                       if (!counter->core.system_wide &&
> > +                       if (!counter->core.requires_cpu &&
> >                             strcmp(counter->name, "duration_time")) {
> >                                 return;
> >                         }
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 2a1729e7aee4..81bbddb6fbc0 100644
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
> > index dd84fed698a3..783359017548 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -350,7 +350,7 @@ __add_event(struct list_head *list, int *idx,
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
