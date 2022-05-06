Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C9B51E016
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442518AbiEFUYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349908AbiEFUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:24:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9E4BBA2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:20:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e24so11365047wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/Ki13NLL1sGncQQ3Tu315inUGCwrgf2ZKaT9XZCXrI=;
        b=Xt4rBM6Cueut4roNHdvKpKyWCLj0hsBaQfBuLbbZFUok36pVDM6J46E9zOOH37fFP4
         WkPnQGh/pFyRJ6KwelsrO1vnXO3fzLKXBKzumy+C/9jMlF0IcNq4XX/NkxJMuNkMfkj3
         tqIdSWz7APiFra4+7eoUY6Xt3x07zb4EAvnm+YP5g3BAVTJ+yXt1yO5EBaSVznyu6Tk/
         7u5LcjH2nPmu/tqAsDl1N5Ecc2ldXyVggzb9VKVnUToU+RGfM+P4W+9lC4kwNU+/fhZJ
         Ipy7tec6WJOmF1kzG+Akw3OkAtudXrgGmIGx7DWgqToBMk/hH2nh1AB/uhaOjuSgN/+P
         RxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/Ki13NLL1sGncQQ3Tu315inUGCwrgf2ZKaT9XZCXrI=;
        b=7iqYOM2FPW8aQsyeBN0zazhmyMCEcUVA7nNin0AErXx6mSChb4LcDBbKIRjIMQDqw1
         TdQGvAs70PJLkdLIWzmnt0e6W7QvJgdjhrla7vyel1Jn5O1V4gAoXxtjKuQNQryYHWqN
         uEFUrEbgx7OOcw2O6A0tDoxRePTbEQOIaMudgyEKJLoKw8rZntF5elhg5RMfrBc0vZco
         D6BgPeACcjPMePU8U12qkG3Nczgml9o4bTbwYOpN8uPg0e4V/ByRp4xAggkk3AAi36Cg
         0zpP9wJD2m5h5kt0py2dCo46dT/nKwCCO7uyy/+0gjLdbjMabfKy4KE5N4GSs+H+Mw52
         5Sow==
X-Gm-Message-State: AOAM5301v7S8tVUy7pnhMe/HUXx0KpHvAoETSNg2UIAx9is9MM7ieQM8
        kNyPmF2jVYPur6JoOgpXXJj3Mbbe1ykOr9bLny49IA==
X-Google-Smtp-Source: ABdhPJy7u+4ml3zz4oUN4dutVgZe3akMeXH6fMY+7p+pSUrZLSQC5HCntH3CHWvZCFCcIR23hTHQQ/80DcL/OWPh7Rs=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr4023039wrm.40.1651868442397; Fri, 06
 May 2022 13:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-20-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-20-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 13:20:28 -0700
Message-ID: <CAP-5=fUPwVupGkO+h+SnXAi9hHxZJhc-OfuQh_x-OUVxp3FqyA@mail.gmail.com>
Subject: Re: [PATCH V2 19/23] libperf evlist: Check nr_mmaps is correct
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
> Print an error message if the predetermined number of mmaps is
> incorrect.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index eae1f6179dad..f51fdb899d19 100644
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
> @@ -428,7 +429,7 @@ static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_
>  static int
>  mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                int idx, struct perf_mmap_param *mp, int cpu_idx,
> -              int thread, int *_output, int *_output_overwrite)
> +              int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
>  {
>         struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
>         struct perf_evsel *evsel;
> @@ -484,6 +485,8 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                         if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>                                 return -1;
>
> +                       *nr_mmaps += 1;
> +
>                         if (!idx)
>                                 perf_evlist__set_mmap_first(evlist, map, overwrite);
>                 } else {
> @@ -518,6 +521,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  {
>         int nr_threads = perf_thread_map__nr(evlist->threads);
>         int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
> +       int nr_mmaps = 0;
>         int cpu, thread;
>
>         for (cpu = 0; cpu < nr_cpus; cpu++) {
> @@ -526,11 +530,14 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
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
> --
> 2.25.1
>
