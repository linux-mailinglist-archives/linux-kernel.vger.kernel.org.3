Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970151CC53
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386500AbiEEWwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386487AbiEEWwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:52:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD65BD2B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:49:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k2so7837116wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uedg4qEa719vdJ+Zqn6AbL/3oPXYxbSNoFRml+lJnds=;
        b=jHJfv2myfbFEuc1bQulthDC61DAKRpfqYvgRqvL1Otueop0POr35oaBjJLvt6Z0k4Y
         mFqJbl7wIl3HYtcQWeKaLewdcWJYwgWu5bXPl4NQh3Gy7lmjXa+QOLiJy3hq0ZnL2Sbb
         9+7IAMqNqJ7ylSwvbzDoRE7+1Bvv+eLETsglPLnWd6lGplvyAKFPqRWcu3WcGOQb8qCs
         fQLAtmzY7uiEA5EKLvdqSaEbBxAWor0F5c54KTV/wWE9cXHuGjShxX2lvGCzxfidmBjL
         bvMGC9kT78OkkEejU620M1L+MfGXAy8eWsyxb2/zhdoO+Mohc7KAmkwj4uFGZ6QGGUbg
         SfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uedg4qEa719vdJ+Zqn6AbL/3oPXYxbSNoFRml+lJnds=;
        b=ysHMV6/qPh/nKa1ZB9hhph7/rkXUnx35Jh4q9ajxrN7iDEhN85dOIyqRkhK84McKVH
         V5gqppYEMIEcrVNVm3b/8c/EGzlDezfFFijeIRI3RY1dYPZ4emc24C+8rwYwgAbtKCbk
         QnK9Zp9ZxGWwVYsTYrpI5EHjQUOciDfGHXwlF7muwUVlQ9AUNrAOw5OHWkEkZAmbBQmH
         pqK+7yhwY/yBV6Wy7FsDf2ZA59qeh5sF5l6fqC2woLMe6wbyfQkGEA2G/AiKLLr4h3ID
         htmcwUQKGemM7XxYXWGqALtyGnZBx1MyQIGHlpC5gwUBrl6NRdYVImrCj54eBCUhA/Oa
         de0w==
X-Gm-Message-State: AOAM53189i8thGYXfKvnSPUtkfspOqdkeqnmYyNcPwdX8+sUNEkNe5D7
        a5dBvtAIPZYXlPToiX7yEHCQ5XJApGUHY8P5NDuvCw==
X-Google-Smtp-Source: ABdhPJyMM74FcrKHXOKHdDPgZ+MvJIvdnRAR+kCrGVUGABu640Wn09LPsNuOy7fAnd8IO+AvQlPpcw3yTGSqd6B5cqQ=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr260174wro.654.1651790941279; Thu, 05
 May 2022 15:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-3-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-3-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 15:48:47 -0700
Message-ID: <CAP-5=fWyYQbgs99-wm7frfaHQXUFO6b-Lur=BEy48beEsYnehQ@mail.gmail.com>
Subject: Re: [PATCH V1 02/23] libperf evsel: Add perf_evsel__enable_thread()
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
> Add perf_evsel__enable_thread() as a counterpart to
> perf_evsel__enable_cpu(), to enable all events for a thread.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/evsel.c              | 10 ++++++++++
>  tools/lib/perf/include/perf/evsel.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 20ae9f5f8b30..dcc928dd25f8 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>  }
>
> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> +{
> +       int err = 0;
> +       int idx;
> +
> +       for (idx = 0; idx < xyarray__max_x(evsel->fd) && !err; idx++)
> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);

For perf_cpu_map code like this has been replaced with
perf_cpu_map__for_each_cpu, it would be nice here to use a
perf_thread_map__for_each_thread. I understand we don't have that at
the moment. It would be easier to find places to add this if there is
a call to perf_thread_map__nr. Adding an assert of:

assert(perf_thread_map__nr(evsel->thread_map) == xyarray__max_x(evsel->fd));

Would help, or we could add the loop.

Thanks,
Ian

> +       return err;
> +}
> +
>  int perf_evsel__enable(struct perf_evsel *evsel)
>  {
>         int i;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 2a9516b42d15..699c0ed97d34 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -36,6 +36,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int
>                                  struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> +LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> --
> 2.25.1
>
