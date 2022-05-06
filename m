Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BA151DE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444082AbiEFRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 13:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444052AbiEFRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 13:10:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604876A076
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 10:06:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m62so4807718wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBQ5hlnrPgvY98dCxQVZhYMqkwyj+NDrFVgpOGr6MV8=;
        b=VQyoQu0KM6R/80GMq+jm98nrJ7+f9yVAZnmO7fzMOHJb+MBLhnGTD2GW3ZPBHgesHG
         4ZPQJyVCUzrFZI8apzvoRUXKAN9EP5nO0SAnY76iyS2WEjJvzvPY8JhRRbXgF9hP6ev/
         jgjCQjinKu7539EG4+YIg0rTBSUZbI0WfhAJRYVV6Nx8H4WLD2W/DJaDVuQm46iSp1m1
         8/bRqk+9DRkUok/pNO/7DoNv/AevDFtQD8QcFDi/YuyDA4+NOPgz2dZjUimhnTvMqZHf
         MsdWeiIRe/bL9ZIGPWG/gWWDYmWRM4efq9yGkl52EF3xF7fGMm6Ytxv3G0Co72sGXUAO
         /VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBQ5hlnrPgvY98dCxQVZhYMqkwyj+NDrFVgpOGr6MV8=;
        b=mo7njwC/XfxKT5VDtZ1PNXno3ersl0zfJpTyCAVaHjzEDG7S2SNoLrdRiHqz3dpzoJ
         0VE5GZGFtR6WX3EBASPTZLl1bjonnUFY5NWVtdzPm5boBFneVY+4/I31CNfQnhfzpS3I
         v4Th68lcVaWYNIDxGxs8PYR34FTcrh2krLcYmUQ5qEkbBYHM+acosqP0xd2cVLWMJtek
         e60oJ6l267weAriiPtzvTjKhxDLYzpZF4R9qKNnRxuKgBZSCfRK9tbJu3qeB1qUIjpkU
         f25hfCJ+8INh5oUZy/+MD76kcVPpnxJceV7z6Yg1bm/3wvkIm/hkuJwB5MyhD68Xbwut
         gp6w==
X-Gm-Message-State: AOAM531cukYhG1vU8UhcB9kn+ptiEVO27majqrNfOPhMrTtrduxVSMA0
        ba0SbV2VsvCUayK9N8lsaC5B7jvXvqvirqj32oq5Kg==
X-Google-Smtp-Source: ABdhPJwBXHUSv6ADnwsWRsDl9+SFc/pBZrb9mVPF0s4MK/FEF+vP0Nv32HPgY5DZASA/CYENlpFBOZ4HDNEAyWrOrY8=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr4272578wme.67.1651856816754; Fri, 06 May
 2022 10:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-3-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-3-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 10:06:42 -0700
Message-ID: <CAP-5=fWx7kL=d76eSznoz_phiaq=J3OhJEr3KJuYodM+QbTXkA@mail.gmail.com>
Subject: Re: [PATCH V2 02/23] libperf evsel: Add perf_evsel__enable_thread()
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
> Add perf_evsel__enable_thread() as a counterpart to
> perf_evsel__enable_cpu(), to enable all events for a thread.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evsel.c              | 15 +++++++++++++++
>  tools/lib/perf/include/perf/evsel.h |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 20ae9f5f8b30..c1d58673f6ef 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -360,6 +360,21 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>  }
>
> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> +{
> +       struct perf_cpu cpu __maybe_unused;
> +       int idx;
> +       int err;
> +
> +       perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
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
