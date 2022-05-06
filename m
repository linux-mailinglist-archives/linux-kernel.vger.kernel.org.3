Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17051CDB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387453AbiEFARU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387500AbiEFARM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:17:12 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D135546A2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:13:28 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 63so2233464uaw.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 17:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLJ9FJ32m3bBcXwGOFaicCplk/peelZWNu/fkW2GFKc=;
        b=IP/HfqSpU0+jYTEqaLVCKt5A5zpfAvfIlGjU0U9jQybjQIG3TrIDef08EqwJtodwjw
         Jd5hgQfwOSKKwaegblUxfIOx6ol3yoej6QUNLkB4zt8torAmTe/wET+CbhAsB6nn3aQ3
         X/pBTzG2+6+C3gMy2aRd4IOj89lDyhAbZrafu7nU4iiFK0D+6fcG99FMIL3iNw9By2EN
         t8yU7/bGKuHe7lum3dLKPgxK1K77ZUJApU+M/kI0cnSZvO9lONkyOLwd0HJqzEI2qFU/
         HHaIHwEIX4XN7h8EjMc+Jaypj2HSnJbImVH/cQI7BYygfhjiuHoTyGMAZB9xq10p1joj
         729A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLJ9FJ32m3bBcXwGOFaicCplk/peelZWNu/fkW2GFKc=;
        b=edfdHL52B3u3AkTyxMPQvdn7iZkePczmdJC93eHHWmtK8hzf1iglZcYs30Cmm6BXON
         EiPvmdGIllKSSf47+IDIYRyzEY3yRWnf2MvEjWEcwJFpMbatTg2QBuY/WF8JSPnXTd3g
         wZn47TRP3Fu/3baRPpT0FiK5vCAlJZlszcDQ9cMdkV0izJyia3yDegZzjBdYJ2EaMgXM
         iL+TrRlGhBWyfVYhT/lOXp2a76bel72+CqtwySZFAOs0NZe4wy5GutlPys5A/gREYGbz
         bminu1H8aWDUuJBqGTAyCaOBStA8u8UHjASy5b8lva6uGXqU1wbm61Y47/IpQtfnDrmo
         aeUQ==
X-Gm-Message-State: AOAM533DppTWALoeVy6v8YFKCuFuDfhs++qcrCHr3CHUln230LheV4yf
        idlB1F2mmvT98mqn1PllYtNoRVqHu6l6HcElNPpXKw==
X-Google-Smtp-Source: ABdhPJwxAKL8x7RCvjWu54CLInqqajTsKbdvD7+ivdbAzy9AWSKPYbQdwB2evhUAhzg8AZlLSWZj+TNdE5O3WkHy5lA=
X-Received: by 2002:ab0:2a87:0:b0:362:9cdb:8b64 with SMTP id
 h7-20020ab02a87000000b003629cdb8b64mr201222uar.83.1651796007533; Thu, 05 May
 2022 17:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-20-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-20-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 17:13:14 -0700
Message-ID: <CAP-5=fUOomWXpd6we7DpNcJ7GpFCqN2Kf2AV9otvBaZ87UmpCA@mail.gmail.com>
Subject: Re: [PATCH V1 19/23] libperf evlist: Check nr_mmaps is correct
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

On Thu, May 5, 2022 at 9:58 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Print an error message if the predetermined number of mmaps is
> incorrect.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evlist.c                | 11 +++++++++--
>  tools/lib/perf/include/internal/mmap.h |  5 +++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 0acf43946479..8a82b4b94b99 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -23,6 +23,7 @@
>  #include <perf/cpumap.h>
>  #include <perf/threadmap.h>
>  #include <api/fd/array.h>
> +#include "internal.h"
>
>  void perf_evlist__init(struct perf_evlist *evlist)
>  {
> @@ -424,7 +425,7 @@ static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_
>  static int
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                int idx, struct perf_mmap_param *mp, int cpu_idx,
> -              int thread, int *_output, int *_output_overwrite)
> +              int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
>  {
>         struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
>         struct perf_evsel *evsel;
> @@ -480,6 +481,8 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                         if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>                                 return -1;
>
> +                       *nr_mmaps += 1;
> +
>                         if (!idx)
>                                 perf_evlist__set_mmap_first(evlist, map, overwrite);
>                 } else {
> @@ -514,6 +517,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  {
>         int nr_threads = perf_thread_map__nr(evlist->threads);
>         int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
> +       int nr_mmaps = 0;
>         int cpu, thread;
>
>         for (cpu = 0; cpu < nr_cpus; cpu++) {
> @@ -522,11 +526,14 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>
>                 for (thread = 0; thread < nr_threads; thread++) {
>                         if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
> -                                          thread, &output, &output_overwrite))
> +                                          thread, &output, &output_overwrite, &nr_mmaps))
>                                 goto out_unmap;
>                 }
>         }
>
> +       if (nr_mmaps != evlist->nr_mmaps)
> +               pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
> +
>         return 0;
>
>  out_unmap:
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index 5a062af8e9d8..9b00828e70ef 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -56,4 +56,9 @@ u64 perf_mmap__read_head(struct perf_mmap *map);
>
>  int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count);
>
> +static inline bool perf_mmap__is_mmapped(struct perf_mmap *map)
> +{
> +       return map->base;
> +}
> +

This function is added here but not actually used by the patch.

Thanks,
Ian

>  #endif /* __LIBPERF_INTERNAL_MMAP_H */
> --
> 2.25.1
>
