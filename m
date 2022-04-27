Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E530E5124C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiD0VwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiD0Vv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:51:58 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB0972AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:48:45 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id bu29so5486040lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 14:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxYZtrUpVD8PMoxPVY7/PkqDexOh4UvWIhM6di6wqG4=;
        b=qmm+GzcUwtDz4mxTHX0m3ei5mrwEalYEzk9GGT2t2//Cz/nvAIhJeotIQ1LvahQKX+
         2BEKO07sIb//bZB5E+dNdphouFp4XU9NUkpM+G1hL7MvbTH28HUEAg2R4NIbLLSuDiQ2
         sE5h4SbAJ/ivG13JUwaX1QjNji5pkBl+dNiGQKKxVGAP+16e+P2ZAgbuwpVDxsQ2lwvy
         /XCSPA1kueTVg+K0eP4AIj+8P+dsCfKbbH+kxc0Z58Sfd8rdTVy+Ltqa6KEln94bQa0r
         XwZqpyMh1+iY2j/J8m3Xws3UZPlmXzFZKfeaFaxr4TdjlWsgBzEaz1vW1bUcfF8mdJFm
         W+gg==
X-Gm-Message-State: AOAM532OS9fKAtYOGUOpcManTVDL+WaNr/98sK/SBMDOfy50PuC5l2xj
        R3CLsvtdpNWx+m/Q9Jr4GGsTKvtpqo71iWo+bbE=
X-Google-Smtp-Source: ABdhPJzsozeKm29Gt8hPREpK5sEDAZTTU3rt2SG7n9qYo2yOoJoKN4+H4Yshc0XGWCKn/Uf1VLLX/Lv5RVtY3Mp5AJc=
X-Received: by 2002:a19:6744:0:b0:46d:185f:5322 with SMTP id
 e4-20020a196744000000b0046d185f5322mr20636711lfj.586.1651096123875; Wed, 27
 Apr 2022 14:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220422162402.147958-1-adrian.hunter@intel.com> <20220422162402.147958-3-adrian.hunter@intel.com>
In-Reply-To: <20220422162402.147958-3-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Apr 2022 14:48:32 -0700
Message-ID: <CAM9d7cgbxC_vF2A2JtnOV-we7kO1qB9W5g_X4-zAEyR=vF6AcA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/21] libperf evsel: Add perf_evsel__enable_thread()
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

Hi Adrian,

On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
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
> index 20ae9f5f8b30..2a1f07f877be 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>  }
>
> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> +{
> +       int err = 0;
> +       int i;
> +
> +       for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i, thread);

You might want to break the loop when it fails.

Thanks,
Namhyung


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
