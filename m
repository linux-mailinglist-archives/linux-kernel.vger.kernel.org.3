Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2351CD15
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387029AbiEFABV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386990AbiEFABT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:01:19 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01C47045
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:57:38 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id m203so2840229vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnctbVRxORYL/0JLzkbjpDO1QpbSv8VPedLCJeymXws=;
        b=GZGKufs159IzQbmQa2jGRBm4oU2IeCAHIDpl0rZpRPSFcib0hgIoQla62MnIwNTRLw
         yPaysfAdwIt2N7SGmV8Jnq53j0Y+VDeyOc591q1mYvt9aLKLrrNxCH0zQstouafxN5NK
         uGVMTXlq3N5xFqqO5eSkP4owtzgePS7xgcWLeY/oey8Y4sKTjwT4YorIPn9SvQihYy45
         bUV844O2hHyb6JHKJlx/s6zNQteaOLMalVlJEtLS1a6OtXk2ZjnsKFvHQFSKoIklSS0o
         s40Uf8I1LXuvXNDCEpasUwBWrc0bfxZJcGhGe4v2ivqcsrtJdGqqFuktGeF1u7fcWimS
         67BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnctbVRxORYL/0JLzkbjpDO1QpbSv8VPedLCJeymXws=;
        b=PVkn0NYK7rjNFYI/WSCuJzAQp4kaGYDN2+zYelwNzqs4KrNAyzP7JsI6HGbCpv1LCn
         wkpgbcCqkdDceVYu0kv7tGwVgyco34jZ68YTlbK9SQAN4MRpzOIpVnnP8jBb/UqFNrBj
         rqYuvS3h25LKi3bqKASPnf/mQoYrbju0D2yJWqa1iXn3PB3u3pRtj1fqLP6XeEOvo2eE
         mLm3p9JQRDF+TJFT8f6jtI+rsCLOnECCGok8+a2qSDQ62S90NRZ4ObaXrumeeSG696d1
         MzciXcoaF3B/O4fefoBV6jhXpdgvFiv41LAmIrHqcBd3nzoc8KqZYWNBD0av8uvkfvIA
         GTkA==
X-Gm-Message-State: AOAM532YVG0cdtR/VqYraCRH1v+D7KkKt4SBmZoT5jb1jdkxHYt2f2CH
        tKYfCucVFzFWXV+YeX8Hu8pXXnOM34rSnZsVMe7ASg==
X-Google-Smtp-Source: ABdhPJx44pqdhLjjSdrM1mmTwdTAKr2042ce2vn9Hs2n0hz0YPZtitRVuqnnCDEFYLmmG49/aTRlo9ab/OrUxHQMlYk=
X-Received: by 2002:a05:6122:1810:b0:34e:8f1c:749d with SMTP id
 ay16-20020a056122181000b0034e8f1c749dmr258086vkb.20.1651795057756; Thu, 05
 May 2022 16:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-15-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-15-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:57:25 -0700
Message-ID: <CAP-5=fWHAE-fwPO7kQWJpQMn4XvK8+BFQg885xv6aOjbP+j4NA@mail.gmail.com>
Subject: Re: [PATCH V1 14/23] perf record: Use evlist__add_system_wide_dummy()
 in record__config_text_poke()
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

On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Use evlist__add_system_wide_dummy() in record__config_text_poke() in
> preparation for allowing system-wide events on all CPUs while the user
> requested events are on only user requested CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Delta function names.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 069825c48d40..83d2f2b5dcda 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -869,7 +869,6 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
>  static int record__config_text_poke(struct evlist *evlist)
>  {
>         struct evsel *evsel;
> -       int err;
>
>         /* Nothing to do if text poke is already configured */
>         evlist__for_each_entry(evlist, evsel) {
> @@ -877,27 +876,13 @@ static int record__config_text_poke(struct evlist *evlist)
>                         return 0;
>         }
>
> -       err = parse_events(evlist, "dummy:u", NULL);
> -       if (err)
> -               return err;
> -
> -       evsel = evlist__last(evlist);
> +       evsel = evlist__add_system_wide_dummy(evlist);
> +       if (!evsel)
> +               return -ENOMEM;
>
> -       evsel->core.attr.freq = 0;
> -       evsel->core.attr.sample_period = 1;
>         evsel->core.attr.text_poke = 1;
>         evsel->core.attr.ksymbol = 1;
> -
> -       evsel->core.system_wide = true;
> -       evsel->no_aux_samples = true;
>         evsel->immediate = true;
> -
> -       /* Text poke must be collected on all CPUs */
> -       perf_cpu_map__put(evsel->core.own_cpus);
> -       evsel->core.own_cpus = perf_cpu_map__new(NULL);
> -       perf_cpu_map__put(evsel->core.cpus);
> -       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> -
>         evsel__set_sample_bit(evsel, TIME);
>
>         return 0;
> --
> 2.25.1
>
