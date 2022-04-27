Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6433E5124D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiD0V5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiD0V5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:57:52 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620EB18A5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:54:39 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y32so5428045lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4KrYzBmL4NujzwJacpNt1nuydCLNk2t1jsYHKT9n8E=;
        b=qoPOttdE4PBu5ieUBLZwJIaFWl7yEVdjED/rWZAU61MDdGDnfadaoUUIRauc5LfJM1
         91H5/Xf4OXivEWDWR3Pqkl23NKgU7ue4j695BHpym12RTrGs7LIF68iwl6qA8QYQ8eDa
         +xbam1gEArIjrYu4vrj7r512hOdxg/csGiQXi31ctK3hm70dsxdNkEldNrhKHNeB4Xeu
         48ZbpL6FGQJLKxhNdOOgekgBpBzVlY5vtp+HmRYdj6rz2PPtc3W5Bvch730x5djwNVzZ
         LBryC7pTVtuAdn9Zjo0AtSJwoVogWTywH2E80QNIQwa/y29PdwbA971lBKbJ9/JuK6rl
         12vA==
X-Gm-Message-State: AOAM532D+vkXwMbYvCdkgXixfe/ooCHkhk1d8E2lPAX4QqUsdheCkbCq
        J2fMuQIbKhJPIT2ijbVUELfqCX04mxNEpQ64Q/U=
X-Google-Smtp-Source: ABdhPJz4WgxQXssJ7gV4+q5NQY+Rux7m8NBtjKRpvLCdQOI8CSVjciVAs9v3cF/07aPMcWb9Htau4mfnZpHte6GmZKo=
X-Received: by 2002:a05:6512:321c:b0:46b:b7fd:1eca with SMTP id
 d28-20020a056512321c00b0046bb7fd1ecamr8586729lfe.481.1651096477389; Wed, 27
 Apr 2022 14:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-6-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-6-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Apr 2022 14:54:26 -0700
Message-ID: <CAM9d7cg8Awh9oXdCL4-GQT_R5FpgTz6DYFCfd=9g1YFQ463xSQ@mail.gmail.com>
Subject: Re: [PATCH RFC 05/21] perf auxtrace: Do not mix up mmap idx
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> The idx is with respect to evlist not evsel. That hasn't mattered because
> they are the same at present. Prepare for that not being the case, which it
> won't be when sideband tracking events are allowed on all CPUs even when
> auxtrace is limited to selected CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 10936a38031f..2d015b0be549 100644
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
> +               int cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);

While it can be thought of as an index from the function name,
it'd be nice if we could be explicit like cpu_map_idx.

Thanks,
Namhyung

> +
> +               if (cpu == -1)
> +                       return -EINVAL;
> +               return perf_evsel__enable_cpu(&evsel->core, cpu);
> +       }
>
>         return perf_evsel__enable_thread(&evsel->core, idx);
>  }
> --
> 2.25.1
>
