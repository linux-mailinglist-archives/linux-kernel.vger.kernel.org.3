Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09A751CC80
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbiEEXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiEEXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:10:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC85EBE4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:07:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so3445611wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6QyfJXydIPuFRj+gp2l5Pe1Zu9fkDk5QwEGn/ZKtf8=;
        b=VsefHrs+DqrSiT2rf9d6SAG1yFti62kPzPrnjXwBGeBTakbSa2SeRpohE4Gzgok6Xu
         Y2UN0LSmyw5OwTZje6BAid/jVYhznyZ+ZVMD9z+ij3N5UDK4+vC0pnChvHYOfvkJ8uQ5
         rqizIcLJ8maP0TNsbXRSfv1muvjlFU7qGki8HoUa1yBurl5BnO2P5oYo2AOTaN1y+5Lx
         yqplhoGbh1lAZ2WUtcHMngMoDomXuC0VV+oDtuqdc3jRr+Xm1NZHqZyEDUQTwrfG+G5l
         MYULKRpBebemyp76MazOkHmCKsvdbcaPTHYqA+X+mHn2G9dpuqSxZ9ThVcFQA1svyXEj
         QLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6QyfJXydIPuFRj+gp2l5Pe1Zu9fkDk5QwEGn/ZKtf8=;
        b=ce12XjuxGyAzuCHHLqBALNdJ2Uvtj8ZQzri143IWAYF5hx1ocq8DdPTFSa2HwjKG3b
         Dl8S7e6fomlzY+d/esqFXplOqmORgjgmPC8MZiZCbdfa67dWnc7dpSerm97Ev4buOcSi
         jkM9l9j8mumUSsqETBIvIkGFmaX1pXyGUg/v4eRO1GJxNEI1FRn/jt1o+zhxDBZHWfEl
         /RHy3wNJWclFPLPO8MzGhX20KBuhCVeYV0aRLfgzqFafp0mZjtMTO8MO0I6uiRCe3s1c
         KdP2ZV3hGv9919jNt8w+IcKWzrr4CD7pKtaVbu312IVhSeiho8lh1jOfgKs7JgaA0mhN
         UEHQ==
X-Gm-Message-State: AOAM532r3XtL7RQifblim2EhmV/fp8JhUFqzKiyZbRumwI0RYp36QexO
        uvkkSuWZbNrgdS01D0nj3e3a9UpkedSmVR7kSEq8Yw==
X-Google-Smtp-Source: ABdhPJyoG1KlSj7hkqqC9uipGFcwHqjYxHOEmpdDk0twQs7pcVcbrTL0dvvclj3Q3sGRnPLLU5ht5Gg1Zd+3PFok/l0=
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id
 184-20020a1c19c1000000b00393a19f8f95mr459737wmz.149.1651792025775; Thu, 05
 May 2022 16:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-5-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-5-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:06:52 -0700
Message-ID: <CAP-5=fXy6OO+Gk5MbORAYYiS2xiMzUDQhTo8X8BZKGahHB_hMQ@mail.gmail.com>
Subject: Re: [PATCH V1 04/23] perf auxtrace: Move evlist__enable_event_idx()
 to auxtrace.c
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
> evlist__enable_event_idx() is used only by auxtrace. Move it to auxtrace.c
> in preparation for making it even more auxtrace specific.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Whilst this offends my object oriented encapsulation sensibilities, it
is in the style of the current code and not recommended against by any
style guide.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++++
>  tools/perf/util/evlist.c   | 10 ----------
>  tools/perf/util/evlist.h   |  2 --
>  3 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index df1c5bbbaa0d..10936a38031f 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -636,6 +636,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>         return -EINVAL;
>  }
>
> +static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
> +{
> +       bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +
> +       if (per_cpu_mmaps)
> +               return perf_evsel__enable_cpu(&evsel->core, idx);
> +
> +       return perf_evsel__enable_thread(&evsel->core, idx);
> +}
> +
>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  {
>         struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 9fcecf7daa62..f1309b39afe4 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -538,16 +538,6 @@ void evlist__toggle_enable(struct evlist *evlist)
>         (evlist->enabled ? evlist__disable : evlist__enable)(evlist);
>  }
>
> -int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
> -{
> -       bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> -
> -       if (per_cpu_mmaps)
> -               return perf_evsel__enable_cpu(&evsel->core, idx);
> -
> -       return perf_evsel__enable_thread(&evsel->core, idx);
> -}
> -
>  int evlist__add_pollfd(struct evlist *evlist, int fd)
>  {
>         return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN, fdarray_flag__default);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index a21daaa5fc1b..4062f5aebfc1 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -196,8 +196,6 @@ void evlist__toggle_enable(struct evlist *evlist);
>  void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
>  void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
>
> -int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx);
> -
>  void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
>
>  int evlist__create_maps(struct evlist *evlist, struct target *target);
> --
> 2.25.1
>
