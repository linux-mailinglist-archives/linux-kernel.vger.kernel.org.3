Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C1A46AB4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356335AbhLFWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244680AbhLFWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:20:12 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598CC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 14:16:43 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p23so14720769iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 14:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdydPCWcOK3Lf25mMx9KIVTsHVxARjPf2sEPVcZZwOQ=;
        b=Bq3nU3kvGsEqBDlLP9hTXVGa3a8VT6Egn2ci2lgTBc7jJT9kC0cCPzWMqUbfdjRNHm
         /wIKRl5S802VhrTseAFkOgf4J495Bcwusq92uIaeEBPmPPS8fR7fKccquCCNmRMI2zHm
         2xPw8AK8jV5PX0OHcw9vw1+LNG2GgWKYGch+7lwGxc/y5Tv6dQknwuodBI1YlqSTt36y
         g0DEJgu7MJYR16Sh/mWEG/y94pXxGv6rZLmpQoY3+P3+w1tMYZjDEwVPCyRKYdNDx82U
         TFNBIOS8N5S4FoJ8+tY8lV4upAZfYyBytH0s5DozB2lnyP1Hu0TGAfbvStpLfyu/i+2d
         lseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdydPCWcOK3Lf25mMx9KIVTsHVxARjPf2sEPVcZZwOQ=;
        b=GL50ZOk9AnXQCX52l/7zquC1KxK/QKWoLY0+8Yrm0Ek7zSU52wk01JhkW91eMODgx8
         Eplbb8YPgxRw2cNBL5xXKLtyR9zMPTwDIBrsyaLAfOlxqdFaEFts9cPHJeBlre/YqbBH
         Woq8YFMUWAjPcDtGr++F+4yEpRFLnV91HYa+81coGOFckExKGKLkThgzTgIlMKG1NJqh
         5Rv2Wlh4v7Poir8iITeRqKIE/KXzoC8sGppgQqsKswlzE72TTGGXlm7cOHTuaIe0UFcB
         uqOaxSdCnQHRx6frvQ43QY2O+WnIFUZ2Mtc6ci8YuXyKIy1szCu7Upw60TASYopwHJ0x
         74iw==
X-Gm-Message-State: AOAM531sizYgWnVhS3fFIfmM/p0wgj9/99o8ltQDwteYMnclqqu85hdG
        YcAZHoeDyu4L86QTNPfwMJy7ud01zasaMeRFDacpzg==
X-Google-Smtp-Source: ABdhPJyoK5X24y2TuJW6TgcA5V06pOxhr1ou0E+YwqYsbkh3t1AgzXNj1LAkOY1J/bl+vVLdJ1La/cyy4D7n50CbJsM=
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr37009252iov.32.1638829002287;
 Mon, 06 Dec 2021 14:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20211204023409.969668-1-irogers@google.com> <52237d2a-2be2-cb93-e29d-ac6eea82a2f9@arm.com>
In-Reply-To: <52237d2a-2be2-cb93-e29d-ac6eea82a2f9@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 6 Dec 2021 14:16:30 -0800
Message-ID: <CAP-5=fVn-uKs+_647D+O6r=n9N98iK=Z3U53WYkPm9NxMEz3gg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix per socket shadow aggregation
To:     James Clark <james.clark@arm.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 2:44 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 04/12/2021 02:34, Ian Rogers wrote:
> > An uncore device may have a CPU mask that specifies one CPU per socket:
> > $ cat /sys/devices/uncore_imc_0/cpumask
> > 0,18
> > The perf_stat_config aggr_map will map a CPU to the socket and other
> > aggregation values for it. Fix an error where the index into CPU mask
> > was being used as the index into the aggr_map. For the cpumask above the
> > indexes 0 and 1 are passed to aggr_map rather than the CPUs 0 and 18.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 588601000f3f..7cfad5cfec38 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -516,7 +516,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
> >  static void aggr_update_shadow(struct perf_stat_config *config,
> >                              struct evlist *evlist)
> >  {
> > -     int cpu, s;
> > +     int idx, cpu, s;
> >       struct aggr_cpu_id s2, id;
> >       u64 val;
> >       struct evsel *counter;
> > @@ -525,11 +525,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
> >               id = config->aggr_map->map[s];
> >               evlist__for_each_entry(evlist, counter) {
> >                       val = 0;
> > -                     for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
> > +                     for (idx = 0; idx < evsel__nr_cpus(counter); idx++) {
> > +                             cpu = perf_cpu_map__cpu(evsel__cpus(counter), idx);
> >                               s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
>
> Hi Ian,
>
> This same pattern of looping over the CPUs and calling aggr_get_id() is used a couple of
> other times. For example in aggr_cb() and first_shadow_cpu(). Do you think these also
> need updating?

Thanks for the feedback James!

For first_shadow_cpu the index is translated to the the cpu via the
cpu map here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n343
so I think it is sound.

aggr_cb looks to have the same bug as the index is being passed as the cpu:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n643

> Or could we fix it in the aggr_get_id() functions so that they expect an index instead
> of CPU ID and do the conversion themselves? The callbacks do say "idx" rather than "cpu"
> so maybe there is still come confusion.
>
> For example:
>
>         perf_stat__get_die_cached(struct perf_stat_config *config,
>                                         struct perf_cpu_map *map, int idx)

Agreed on the naming confusion. I'm a fan of using single element
structs to get type safety in code like this. I wonder here if a
for_each_cpu on perf_cpu_map would clean this up best. I'll play with
a v2 patch set that addresses this problem more widely.

Thanks,
Ian

> >                               if (!cpu_map__compare_aggr_cpu_id(s2, id))
> >                                       continue;
> > -                             val += perf_counts(counter->counts, cpu, 0)->val;
> > +                             val += perf_counts(counter->counts, idx, 0)->val;
> >                       }
> >                       perf_stat__update_shadow_stats(counter, val,
> >                                       first_shadow_cpu(config, counter, id),
> >
