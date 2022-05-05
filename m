Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC3551CBF2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386225AbiEEWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386177AbiEEWQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:16:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A85EBCF
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:13:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so7799479wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqUrx2G73vCZU3RKcd1QDtqQBikNfcSkQr6QFJTd/RI=;
        b=S959801w4vdtlsza92BrRIUGnFjCeKV2Y+izFx2I3sC62pe/+7Q80xrV7Xagcv54Fn
         /FjZsa8tjCnmwsnodGMvUZusxWjxV3N3JFU2H8caiVJtWfQLs41NJFrjt6gxbMKZFJtH
         b8wIglZAzlG1/a3ILKWXxNnGeYFi99ORwFCt+NWdVZwFAFupXavZDZeH+5yDjoD4kbuv
         pReCVEmFPYqNo3tqT++zHhzQlHfpGzodgaVdYmj9059hU6/Q/KzJEign6GoP+M/plv+J
         DOwjlRDO8ni8Rw27n+4NNTkVOfnSPsdwimwRjMI7PhJgBPQcRaov/g0L9CMqtlIJk7A5
         dgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqUrx2G73vCZU3RKcd1QDtqQBikNfcSkQr6QFJTd/RI=;
        b=1FBE0KCvLnFAZCRWeGajs6d624HYVhfQQrPcIneEKa5kfSUFmfe0q6qJUAdfVMo4AD
         X8rF88WtNgR40Unal8HeOkYfl7t3CaY5rCTgCIzje5kwUU/rNnYmh17AfKqED01BLb5U
         JUfStmWyQgwxMvbaP+9hHccMefgvpiKC8LuiYRbf/xOPIPW/mwAaGPvsE07c2//C0NjB
         AgL0A9nwNvnJPZytj7Oe11gq/hD7Y0r0KxkE20vM5ksu/0MO1BSylk0NoZg1QTHMp8dz
         Z9cTur+KMDQyMmdr0Dj84Tlj4Sp3r2ZLXF/ZqwC9KrnOifbnWp4V4eBwTHAy5anmxdqN
         na5A==
X-Gm-Message-State: AOAM531iEolA7eOQr6nLd5lx4Du8tayETsfj/fgyUTr6CwyZrGtICXxA
        HVtDlXzCl+VdkGmuCoO62BSmXiXhMY6dkEjBw+PuqytB31CEig==
X-Google-Smtp-Source: ABdhPJyckM9L+k3pCxnqo7frUskiB7nV7HLmfhb3ujWuEI0FVvqnQKyEN431BiXvhMZ5xz7NjvJp5N84EUSm69biBaI=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr171232wrd.375.1651788797279; Thu, 05 May
 2022 15:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-12-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-12-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 15:13:03 -0700
Message-ID: <CAP-5=fVHsH5Q=nQpNdhPZGuYMDDB6HPYqPG5x24u7pjGLxsEcA@mail.gmail.com>
Subject: Re: [PATCH V1 11/23] perf auxtrace: Remove auxtrace_mmap_params__set_idx()
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

On Thu, May 5, 2022 at 9:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Remove auxtrace_mmap_params__set_idx() per_cpu parameter because it isn't
> needed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 5 +++--
>  tools/perf/util/auxtrace.h | 3 +--
>  tools/perf/util/evlist.c   | 3 +--
>  tools/perf/util/mmap.c     | 3 +--
>  4 files changed, 6 insertions(+), 8 deletions(-)
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
> index 4e715e2d9291..7931c34f749a 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -492,8 +492,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>                                 bool auxtrace_overwrite);
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>                                    struct evlist *evlist,
> -                                  struct evsel *evsel, int idx,
> -                                  bool per_cpu);
> +                                  struct evsel *evsel, int idx);

A similar change is needed on line 868 for when HAVE_AUXTRACE_SUPPORT
isn't defined.

Thanks,
Ian

>
>  typedef int (*process_auxtrace_t)(struct perf_tool *tool,
>                                   struct mmap *map,
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
