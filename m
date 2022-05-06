Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB651D994
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441879AbiEFNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiEFNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:51:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B75D67E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:47:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so6869567wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=He8nhWzUX9SurYrWBqr1rbLP29ucNNjO/O6SAV6TuoQ=;
        b=F2ZL0HTwfzDvXaipW9t5Izp7zJteUji6t3nYEuKnBzH9owueCJ18PczVJPv3ldiAhq
         l2bd5ovCJXnuxYFVvTojj2U9CH2eqmjum8pTE8Ty9pWt1102Cjx0csZ+qKc02wn8EMeP
         Hlr+wqyVCuVIF20uBcDICslqLgzAZh2GlNzJmbZIa4NzP31WK3iIlTz5iyCGb4I16nDM
         HlL0CF5aSMtmUX8vSIGNa1N1y5+uyuu9P0wG7hn7kAIUxG8AYQqCgGAmAmWC5IsfUHn2
         GkwZ5Ryi0cZki/Rp+zTowF/i7CeH6aRO8ufpPHJwVt/UXcnm4Xr2DJytdwk534l4SqXS
         Qq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He8nhWzUX9SurYrWBqr1rbLP29ucNNjO/O6SAV6TuoQ=;
        b=nZ318jISQxlo94HgHxNEOKpbD+8R3a2gyahl93I7nPdEVsAJmYnByUrvityyYceLgp
         OFl18lp/Mjvgr1j4MVszEWmx5yB6x77Gbl/CWf280DU7yJRH9RIgGvaZL7ooBg3Hj/15
         HKzcg+IbO9FR1AQoFGLJ0KLnZKJXgFPuLytxdE0LEY5jMj6s/rg0LP4RfMo6UJ0HnLXC
         5oNGTA4FQw7/JC4rWBSAN+QMHpHzUAulrV+eCvwKihGNKyFk3egl3mYHtxtq6OFVuKiy
         vPQXs8Vujx0sLdyg0a+Hq6lp0Cn41FLEpyfcVjgTeoauw42eUjE2fPG/kEZLzItuiU6X
         R6XA==
X-Gm-Message-State: AOAM530X8cMfwUKYptHptQNNp+HYjYjtgpa3c02A0iX19r9Nl2gI8QD2
        o7oECSxfQ671gTEMMfayi5JAiYQdbvXyBg4qnVKErw==
X-Google-Smtp-Source: ABdhPJxB/tg5zYI22fym/OtnKJ+sa/4r27HtBd3hga/Kl96ET586ZzUatDOeaALJnNA7VfpdWxtny+hKUxho6/43g44=
X-Received: by 2002:a05:600c:2258:b0:394:2045:bed with SMTP id
 a24-20020a05600c225800b0039420450bedmr3504144wmm.174.1651844849001; Fri, 06
 May 2022 06:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-14-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-14-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 06:47:14 -0700
Message-ID: <CAP-5=fV3SWDb8uTsUmdkweRrO9t9OZXzP=9GWqKxTYn0bdfriw@mail.gmail.com>
Subject: Re: [PATCH V2 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
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

On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
> event that sets up the system-wide maps before map propagation.
>
> For convenience, add evlist__add_aux_dummy() so that the logic can be used
> whether or not the event needs to be system-wide.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evlist.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h |  5 +++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 78c47cbafbc2..c16bd4836314 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -264,6 +264,46 @@ int evlist__add_dummy(struct evlist *evlist)
>         return 0;
>  }
>
> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
> +{
> +       evsel->core.system_wide = true;
> +
> +       /* All CPUs */
> +       perf_cpu_map__put(evsel->core.own_cpus);
> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> +       perf_cpu_map__put(evsel->core.cpus);
> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> +
> +       /* No threads */
> +       perf_thread_map__put(evsel->core.threads);
> +       evsel->core.threads = perf_thread_map__new_dummy();
> +
> +       evlist__add(evlist, evsel);
> +}
> +
> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> +{
> +       struct evsel *evsel = evlist__dummy_event(evlist);
> +
> +       if (!evsel)
> +               return NULL;
> +
> +       evsel->core.attr.exclude_kernel = 1;
> +       evsel->core.attr.exclude_guest = 1;
> +       evsel->core.attr.exclude_hv = 1;
> +       evsel->core.attr.freq = 0;
> +       evsel->core.attr.sample_period = 1;
> +       evsel->no_aux_samples = true;
> +       evsel->name = strdup("dummy:u");
> +
> +       if (system_wide)
> +               evlist__add_on_all_cpus(evlist, evsel);
> +       else
> +               evlist__add(evlist, evsel);
> +
> +       return evsel;
> +}
> +
>  static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
>  {
>         struct evsel *evsel, *n;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 4062f5aebfc1..1bde9ccf4e7d 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
>  struct evsel *arch_evlist__leader(struct list_head *list);
>
>  int evlist__add_dummy(struct evlist *evlist);
> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
> +static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)

Sorry to be a language lawyer. What I hope to clean up with CPU maps is that:

empty == dummy == any CPU
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279

Given every CPU map should be empty or contain any CPU then it seems
they all meet the definition of empty - so something is wrong.

The cpu map here is explicitly opened so that it gets all online CPUs:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n174

From:
https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/cputopology.rst
there are example topologies like:
kernel_max: 31
   offline: 2,4-31,32-63
    online: 0-1,3
  possible: 0-31
   present: 0-31

all_cpus could mean the union of offline and online CPUs, possible
CPUs or present CPUs. You are saying that in the perf code all_cpus
should be the same as all online cpus as only those CPUs are valid
with perf_event_open. That's true but offline CPUs can be made online.
If that happens here then the dummy events will have a CPU map that
rather than being for all CPUs will be for all online CPUs at the
point it was opened. Having online in the function name I think
captures the time dependent nature of this - but if you think that's
too much could we add a comment? I'm trying to avoid a situation, like
with the CPU map code, where all and online are interchangeable
leading to the code being unnecessarily confusing unless you read
every line.

Thanks,
Ian

> +{
> +       return evlist__add_aux_dummy(evlist, true);
> +}
>
>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>                          evsel__sb_cb_t cb, void *data);
> --
> 2.25.1
>
