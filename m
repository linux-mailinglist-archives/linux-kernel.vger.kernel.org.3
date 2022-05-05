Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016ED51CC84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386608AbiEEXMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378983AbiEEXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:11:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE95EDCA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:08:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b19so7864583wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpnL7Y34VkNl+QPwMDgzggjgR+jtF3skcJLn7tbi1vw=;
        b=ZztM9mhS6W2/C6sELpPS8Cmn+ajskHdr12C60QjWwmhGDVntb/M6q2E3u7zuHgva2K
         TsYgCt0PHrn/LhjnTI5e8oWPpy5CsmpGe/5ZdU7x9MObFwZGWkSpH1x95TtbhGr9I3hx
         eh8lzsfQL3d4Keq7k89mXLwrwD6rLsHEA1jwDjOA1HbVaG3dteJ0CNhPpnwzJOvB9Cke
         GQVekz0U7OnpB/1ULtr4CyEFAMHJXURmb/tgCpMe9t8P5o2UuB86dyXyeZBRX1WHWBVP
         /QlWq30d3qwOwVf3tyMdDMF6fXUpq4rWXGyAeYGRBdu/2a/KOaNYIJb5u1fMxJZ74LJZ
         /D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpnL7Y34VkNl+QPwMDgzggjgR+jtF3skcJLn7tbi1vw=;
        b=0iDdjvM7bobILRmW5l0TH8PZZlYGyKXNRJdWjKfjPoodHvwj5+pyEj1VEZKbJx/14r
         FHhj2QTMA/J5jCG5C+ZyCGvs72GAwFc9MNMGsQbWErF7780AX23G5Ri1qmW53J0GD8ru
         5gFviOtbPSO3gk5/Zfc7On0u3DKluXVjgaSyRM5uLlVHhR/5zGMHDNAD5quVgNUnJ0KK
         GomnUZI9/y3IcycDL+/Wc6Ihov/vwApO2HRQwpjedgZznl9rIdE0aG5rJCvwRuaRDD6/
         zSXv9sMz9U6tCuD2U9pewQZbL6nUmDSJOgIGkkfDdQhlb1gUg+2BS1c4SzoYhwTUd1UH
         AVyQ==
X-Gm-Message-State: AOAM532H8tIYxA/fiQ5n8g1OxT7H86efMO8AaNfZUPamDALAjSD1CAPU
        rxy9tt/ZLmk8Co7Knfj6WlAnSi2TsqvPkwH2sfeJY8SZMYA=
X-Google-Smtp-Source: ABdhPJxmpa/79Wa00IBx1Yr+7b5P0w6mEY3KDDMtMib2IINUnQwdXSj0ICsLBkizN5ifCGSYNtdT/puyV96rVIhi3wg=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr312612wrm.40.1651792096846; Thu, 05 May
 2022 16:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-6-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-6-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:08:03 -0700
Message-ID: <CAP-5=fUepmFkTxmOKrgfHrttind+hdGciQ4-ZUjArZJ4XQq9iA@mail.gmail.com>
Subject: Re: [PATCH V1 05/23] perf auxtrace: Do not mix up mmap idx
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
> The idx is with respect to evlist not evsel. That hasn't mattered because
> they are the same at present. Prepare for that not being the case, which it
> won't be when sideband tracking events are allowed on all CPUs even when
> auxtrace is limited to selected CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 10936a38031f..b11549ae39df 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -640,8 +640,14 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>  {
>         bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
>
> -       if (per_cpu_mmaps)
> -               return perf_evsel__enable_cpu(&evsel->core, idx);
> +       if (per_cpu_mmaps) {
> +               struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> +               int cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
> +
> +               if (cpu_map_idx == -1)
> +                       return -EINVAL;
> +               return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
> +       }
>
>         return perf_evsel__enable_thread(&evsel->core, idx);
>  }
> --
> 2.25.1
>
