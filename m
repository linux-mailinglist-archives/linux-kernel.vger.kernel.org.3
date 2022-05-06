Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE951E015
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442470AbiEFUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442204AbiEFUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:23:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B73674D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:19:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q20so5064548wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXHGT7eAwQNZJisRbYmzy/j4OMoccRHNIAHZL+cKALE=;
        b=T92xlA48yS6euj6Jjfo13thOHVcvhiHfDU6mvhWuSnpM1cz9yh5nresijUC0NxLFXu
         Z/RAhOS69n3tiwBCrpd5XDXt8Di+tDA5lBZoXf03Xf+22OaqLzj2u1fUWvunBpHlKw6P
         0uFADPdiz7Mv58oWw6SkrkqJArzJ+f9ohiilOaTIgLJQvP9OVsWd7dssBIKmuX0LpXaq
         VfSWIFkj3M5/p9lDAjCsijsdsP/SomG17bsVZXdRhDF1h+F/HpP41xLbFVTdYBVMhqxh
         XAgL59b//rtFW9e5lDaPxM3e7NEznXdcJxHsH7rU5bSkut0E0JlgpuYw+SwjYEHygavB
         JVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXHGT7eAwQNZJisRbYmzy/j4OMoccRHNIAHZL+cKALE=;
        b=OIEDxulXq/S7waLJrqU7AlcpOEAMXChYn04NxYhCdou7Hr6KniZ/Ym98fiQefttRXp
         Ex73r2P4KtfehvjuMVa2VlrAcdsZ4qE6TiBpZTF29JE++1SOvzYbe7xQk5yYPKLUQ8V9
         gFEWYufxi21PTrmZ4fKyg7IdMewPeJz13MUDKBPeb5gvhnCrqFCl42VPla9M0sZ4hqyQ
         Zyfzk3DLJRe9oViKk86uB7rrLRMFaTfmzFyqP90yTLHnuRPP5TxMKJvzmJBHQTWowomY
         bU3FSjGvw2Y5zskom7QR+UlLbc2xccHEOrA9VfPfv9l46zrfzw3rdy9gbRGfz59zbgc2
         K9KA==
X-Gm-Message-State: AOAM530SJn7veZwcJ1LOlxKzz3QiKz06xOrc9Syb2oVAKujbQJhji72N
        nbX9lktiXFcf2hNornaWzXHE+Sv9Ks1YrUyGpO2DGw==
X-Google-Smtp-Source: ABdhPJwDpsgM59vWaZYLsLHq+9cow2DWryndl3KG4C8usFGBDtbgT88dbouz41f0dJ4tmxUWMEaCGOjSYE+A2Ppd/Qg=
X-Received: by 2002:a05:600c:2258:b0:394:2045:bed with SMTP id
 a24-20020a05600c225800b0039420450bedmr5015943wmm.174.1651868362460; Fri, 06
 May 2022 13:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-12-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-12-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 13:19:08 -0700
Message-ID: <CAP-5=fWCAs5cmqzruqEsp_sJ-1BfB4zT+CovwJOKFxBPpFzgkg@mail.gmail.com>
Subject: Re: [PATCH V2 11/23] perf auxtrace: Remove auxtrace_mmap_params__set_idx()
 per_cpu parameter
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
> Remove auxtrace_mmap_params__set_idx() per_cpu parameter because it isn't
> needed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/auxtrace.c | 5 +++--
>  tools/perf/util/auxtrace.h | 6 ++----
>  tools/perf/util/evlist.c   | 3 +--
>  tools/perf/util/mmap.c     | 3 +--
>  4 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index b446cfa66469..ac4e4660932d 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -169,9 +169,10 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>                                    struct evlist *evlist,
> -                                  struct evsel *evsel, int idx,
> -                                  bool per_cpu)
> +                                  struct evsel *evsel, int idx)
>  {
> +       bool per_cpu = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
> +
>         mp->mmap_needed = evsel->needs_auxtrace_mmap;
>
>         if (!mp->mmap_needed)
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 37feae003904..87a3b564a7de 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -493,8 +493,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>                                 bool auxtrace_overwrite);
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>                                    struct evlist *evlist,
> -                                  struct evsel *evsel, int idx,
> -                                  bool per_cpu);
> +                                  struct evsel *evsel, int idx);
>
>  typedef int (*process_auxtrace_t)(struct perf_tool *tool,
>                                   struct mmap *map,
> @@ -867,8 +866,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>                                 bool auxtrace_overwrite);
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>                                    struct evlist *evlist,
> -                                  struct evsel *evsel, int idx,
> -                                  bool per_cpu);
> +                                  struct evsel *evsel, int idx);
>
>  #define ITRACE_HELP ""
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 996bdc203616..25eae096bdac 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -753,10 +753,9 @@ perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
>  {
>         struct evlist *evlist = container_of(_evlist, struct evlist, core);
>         struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
> -       bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
>         struct evsel *evsel = container_of(_evsel, struct evsel, core);
>
> -       auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx, per_cpu);
> +       auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx);
>  }
>
>  static struct perf_mmap*
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index de59c4da852b..a4dff881be39 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -63,8 +63,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
>  void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
>                                           struct evlist *evlist __maybe_unused,
>                                           struct evsel *evsel __maybe_unused,
> -                                         int idx __maybe_unused,
> -                                         bool per_cpu __maybe_unused)
> +                                         int idx __maybe_unused)
>  {
>  }
>
> --
> 2.25.1
>
