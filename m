Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6057C52F3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348866AbiETTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiETTjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:39:08 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E71195BF7;
        Fri, 20 May 2022 12:39:07 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id m6-20020a05683023a600b0060612720715so6149112ots.10;
        Fri, 20 May 2022 12:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+KT5O2MPCFWhXmNzU927SlHQKaod6IokF9udHrhLrs=;
        b=cvKqP+MavJaT5jBCClzEw7dLfT9RitYgiSSMqqzG6qXSeUOMV4MZl8dqh1MKdj0uTW
         peOqi5UDIHPYZQKV4qD9mEzwDrhIRNJSbdTCTU49toNZjQpUAoWk8W4kK1YatiHDDX4F
         kimkPVxwrqWZJhcKE+5PgnenVKHp9hEFVMTQEqpYfOFbuJbgNCidw0CTEHHOk+k17dP+
         SIXJKrq3lrWr52fRn9DL0tkiVdzsPg7J5I7e6WIyR3/HAm3C7drUtCyiCgQAZB2qwmoD
         DpAT/l6bMmwANUIE2Xuvm2p9cPrwdjloHtUfq8BZjqVyOtuXOfNYnftptKROCm/oaL4m
         nGTw==
X-Gm-Message-State: AOAM532I6E9k8YTQ26SCDbjQHbl/DfK72jBayFeP1HfTdzWErL4dYVDK
        Gq0IDIMVUDw0flT+5fwnmaLOWpCjTd01U5be3eg=
X-Google-Smtp-Source: ABdhPJyQLdoVf84znfujSIuBk52pu6KWT90xaxpsXjfjQslIGFtmEwo0/9x9C2XyXT8e685OYrZcDihzFTu9QMEPXEs=
X-Received: by 2002:a05:6830:224d:b0:606:e0e4:347a with SMTP id
 t13-20020a056830224d00b00606e0e4347amr4565134otd.247.1653075546329; Fri, 20
 May 2022 12:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com> <20220422093833.340873-6-nakamura.shun@fujitsu.com>
In-Reply-To: <20220422093833.340873-6-nakamura.shun@fujitsu.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 May 2022 12:38:55 -0700
Message-ID: <CAM9d7cix9Oe3tjCV_w-ZRw6bTJpqe-g2n+ezn5mTvmPPri+Xdw@mail.gmail.com>
Subject: Re: [PATCH 5/7] libperf: Add perf_evsel__{refresh, period}() functions
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 2:45 AM Shunsuke Nakamura
<nakamura.shun@fujitsu.com> wrote:
>
> Add the following functions:
>
>   perf_evsel__refresh()
>   perf_evsel__period()
>
> to set the over flow limit and period.
>
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  2 ++
>  tools/lib/perf/evsel.c                   | 44 ++++++++++++++++++++----
>  tools/lib/perf/include/perf/evsel.h      |  2 ++
>  tools/lib/perf/libperf.map               |  2 ++
>  4 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index bc7881348c76..773224a96bd3 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -162,6 +162,8 @@ SYNOPSIS
>    int perf_evsel__disable(struct perf_evsel *evsel);
>    int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>    bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
> +  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
> +  int perf_evsel__period(struct perf_evsel *evsel, int period);
>    struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>    struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
>    struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 446934c0e5e5..578ae0050036 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -334,7 +334,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
>  }
>
>  static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
> -                                int ioc,  void *arg,
> +                                int ioc, unsigned long arg,
>                                  int cpu_map_idx)
>  {
>         int thread;
> @@ -357,7 +357,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
>
>  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>  {
> -       return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
> +       return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
>  }
>
>  int perf_evsel__enable(struct perf_evsel *evsel)
> @@ -366,13 +366,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
>         int err = 0;
>
>         for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> -               err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
> +               err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
>         return err;
>  }
>
>  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>  {
> -       return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
> +       return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu_map_idx);
>  }
>
>  int perf_evsel__disable(struct perf_evsel *evsel)
> @@ -381,7 +381,39 @@ int perf_evsel__disable(struct perf_evsel *evsel)
>         int err = 0;
>
>         for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> -               err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
> +               err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
> +       return err;
> +}
> +
> +int perf_evsel__refresh(struct perf_evsel *evsel, int refresh)
> +{
> +       int i;
> +       int err = 0;
> +
> +       for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> +               err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, i);
> +       return err;
> +}
> +
> +int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
> +{
> +       struct perf_event_attr *attr;
> +       int i;
> +       int err = 0;
> +
> +       attr = perf_evsel__attr(evsel);
> +       if (!attr)
> +               return -EINVAL;

I don't think it'd return NULL..

Thanks,
Namhyung


> +
> +       for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
> +               err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
> +                                           (unsigned long)&period, i);
> +               if (err)
> +                       return err;
> +       }
> +
> +       attr->sample_period = period;
> +
>         return err;
>  }
>
> @@ -392,7 +424,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
>         for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
>                 err = perf_evsel__run_ioctl(evsel,
>                                      PERF_EVENT_IOC_SET_FILTER,
> -                                    (void *)filter, i);
> +                                    (unsigned long)filter, i);
>         return err;
>  }
>
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 19a7993d9021..2c5e52c17d28 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -60,6 +60,8 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> +LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
> +LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index b2ace16bbc32..d97e208c5be8 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -31,6 +31,8 @@ LIBPERF_0.0.1 {
>                 perf_evsel__munmap;
>                 perf_evsel__mmap_base;
>                 perf_evsel__read;
> +               perf_evsel__refresh;
> +               perf_evsel__period;
>                 perf_evsel__cpus;
>                 perf_evsel__threads;
>                 perf_evsel__attr;
> --
> 2.25.1
>
