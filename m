Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1AA51CC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358131AbiEEXB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiEEXB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:01:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9DB5EBE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:58:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso3139588wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tg9pGfi5Km3VoMJM0LTkjUuUhJHBdyw13Xhhfgqt+cw=;
        b=B4r6h2CwaztRmtxDSYqK7gCNt4eCtjWLDBROB0hbM67sifEx8uZuPGYnY9wTHUl72K
         L2cZC6eatXO14Y927WRfuxsCuWJl4eZ9GGi6mh0RPDXdPLx/w4lhijwe18Pf5VY45R1A
         sxOIma3kdENj1zkG0QiWn6LwlFFYF7F0nkDWrrLyWXZgJgQYXrC1Cz+mrimqVK8mlhXn
         nQ5qk59G4ikDj68CWoFWFu38W30UmRepnUy65KeKbOcNugI9BoG7prPMBTC2xgXF6hz8
         H3dbwaesgJfnMg86T9uJsXw38bq8EO6+XkWIKZU/ASlww6ZcKD/4+tHolP9Pz7mLf1lb
         RlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg9pGfi5Km3VoMJM0LTkjUuUhJHBdyw13Xhhfgqt+cw=;
        b=C0AgpR7k13o/walj5RQWrDnuRIeLPu9zRwepiGybo7NCqwh8O0jYsDhIewZQBsS3gk
         tBODfL9ScGJEr74coSHsuUrXEIcjZXgTiWwmZmbl7ge0sz12AaIAqoJnZhu/FSLXbc+b
         McjICvgnjwNq31st/HnpFTYNP69z3fs4s/pFy8Y69nG1+Mja+bfXadcVWTEzz76XoRcf
         8sanoCUpGnt4lSIOCkuL9RFiiAEss5HYBZUcFlBXO2/VbI2s2YdewEYR3KljpPbkZwlC
         IjrGH3AV8GhBELknnywXpMC1SLUe1ZW6annj8WBT2OWyJ25F+2KeCwTNKIHZHf7gMWWm
         jldg==
X-Gm-Message-State: AOAM530ccfJdQDNdM7ZJGANYrfwEwqYYKY8UzPvO/jGMBKtQZnYfQrul
        r02IMiS+P9UE9i4WIixGGMdyYPg2J8JLwgVGcJ6cLA==
X-Google-Smtp-Source: ABdhPJw3JAX5vU8+JI2cLa5sd1dMq1PwZvG30mWPzocPpq/XzPCbyJhb48dtPKX0ZVoZU0oQU10Yj7G7X0r0T1MDOCc=
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id
 21-20020a05600c231500b0039401f6f663mr6934294wmo.115.1651791493710; Thu, 05
 May 2022 15:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-4-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-4-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 15:58:00 -0700
Message-ID: <CAP-5=fXZ92XJbHviDe229=pvAKRevaOLjD549vpTqPpO=64H3g@mail.gmail.com>
Subject: Re: [PATCH V1 03/23] perf evlist: Use libperf functions in evlist__enable_event_idx()
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

On Thu, May 5, 2022 at 9:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> evlist__enable_event_idx() is used only for auxtrace events which are never
> system_wide. Simplify by using libperf enable event functions.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/evlist.c | 44 ++--------------------------------------
>  1 file changed, 2 insertions(+), 42 deletions(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 52ea004ba01e..9fcecf7daa62 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -334,14 +334,6 @@ int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name,
>         return 0;
>  }
>
> -static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
> -{
> -       if (evsel->core.system_wide)
> -               return 1;
> -       else
> -               return perf_thread_map__nr(evlist->core.threads);
> -}
> -
>  struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
>  {
>         struct evlist_cpu_iterator itr = {
> @@ -546,46 +538,14 @@ void evlist__toggle_enable(struct evlist *evlist)
>         (evlist->enabled ? evlist__disable : evlist__enable)(evlist);
>  }
>
> -static int evlist__enable_event_cpu(struct evlist *evlist, struct evsel *evsel, int cpu)
> -{
> -       int thread;
> -       int nr_threads = evlist__nr_threads(evlist, evsel);
> -
> -       if (!evsel->core.fd)
> -               return -EINVAL;
> -
> -       for (thread = 0; thread < nr_threads; thread++) {
> -               int err = ioctl(FD(evsel, cpu, thread), PERF_EVENT_IOC_ENABLE, 0);
> -               if (err)
> -                       return err;
> -       }
> -       return 0;
> -}
> -
> -static int evlist__enable_event_thread(struct evlist *evlist, struct evsel *evsel, int thread)
> -{
> -       int cpu;
> -       int nr_cpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
> -
> -       if (!evsel->core.fd)
> -               return -EINVAL;
> -
> -       for (cpu = 0; cpu < nr_cpus; cpu++) {
> -               int err = ioctl(FD(evsel, cpu, thread), PERF_EVENT_IOC_ENABLE, 0);
> -               if (err)
> -                       return err;
> -       }
> -       return 0;
> -}
> -
>  int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
>  {
>         bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
>
>         if (per_cpu_mmaps)
> -               return evlist__enable_event_cpu(evlist, evsel, idx);
> +               return perf_evsel__enable_cpu(&evsel->core, idx);
>
> -       return evlist__enable_event_thread(evlist, evsel, idx);
> +       return perf_evsel__enable_thread(&evsel->core, idx);
>  }
>
>  int evlist__add_pollfd(struct evlist *evlist, int fd)
> --
> 2.25.1
>
