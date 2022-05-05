Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA73851CC85
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386585AbiEEXMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiEEXMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:12:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705E75EDCB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:08:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so7876553wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmCkDNpwH+4l8mVyBprXxHl161Mq2BAlrvB4VyEbFSc=;
        b=dBj0ChooYJVQ1cX8CLka9qMcWZmUKJ6M1AWxgdq8bfFmMD+NwUqK/d0fQ3YCwHvhHt
         lqhQABaos7wqUfsU9yVR2Sr7G70bjnzHkFXTAhPUOzZ1X4DwcAEyTdWiwwQxYp/uO30W
         a9i6EUYkr2vxSlh2/ovH3PkFim4ahmCeTpLswWAypT5GiRd5DlFaAqQD0pDXVBaXS71W
         GpjSxeQ6oWLlZJGuw7MEHwSR/VnSznnwGTu4Sm09QIe4S0o+rjHiCmUlLzXneRFLEAC/
         yxpl9Bn0jKBMySn4/6yWgR7v03rFV8s2aU+0tE5LiX2Tmj1lZsYTA0VrZj3H8wIQVcR2
         Lm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmCkDNpwH+4l8mVyBprXxHl161Mq2BAlrvB4VyEbFSc=;
        b=romD14DAwoa9tJkWWSHvoj+cP7xAAlzU7NE+sOSK5XQ+8LOhnGNiKYN6vsGbwiFCNh
         GzZ0DDKLUbm1cpIqCKxx6/pg/V7Bxzg96yQTef+T5C7XoDDL92TVaLnYE6TbnpFUWINT
         ZVzGgYThhVn+lIRS28EdlPQeG2SgDV5RjSKaIl+bWKzOIu5OBLmTpSq3/pR5VSdXa20Q
         tNCXUH01rR9/esCTfNxu1iXnpm5mek5L8BXsCvzY6/xU8Gm45Yu8XkAWyUpcSKOLpUI6
         FzxABFYe6LdanWBmfkptD8CzpY9/1rulGPywzQS3TYGuvlb8Nm8T8BdDPpjP/qxSPsQS
         BkSg==
X-Gm-Message-State: AOAM530GtOwKAHYBniWgWUPCqlFTYtSywIKUQFt27bGyZNueOKqlaEb4
        KO+4t2RfDar4ZPOnUKKrs84CKewiYBcxGXY9bOkaDQ==
X-Google-Smtp-Source: ABdhPJySogy/rQv0nFUZB/fIIXB9Pko+BoWxa7lwTLZLdkqs8Hxs4cyn/qTDQxriXnnj+cHQsecHsVWDjSZ0JUTAEmM=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr305477wro.654.1651792132888; Thu, 05
 May 2022 16:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-7-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-7-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:08:39 -0700
Message-ID: <CAP-5=fWO5Nq2DdU7bndtFX4g+uFk+9s8XDkeZOLnp5RB_g88mA@mail.gmail.com>
Subject: Re: [PATCH V1 06/23] libperf evlist: Remove ->idx() per_cpu parameter
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
> Remove ->idx() per_cpu parameter because it isn't needed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c                  | 4 ++--
>  tools/lib/perf/include/internal/evlist.h | 2 +-
>  tools/perf/util/evlist.c                 | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index a09315538a30..6d0fa7b2f417 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -517,7 +517,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                 int output_overwrite = -1;
>
>                 if (ops->idx)
> -                       ops->idx(evlist, mp, thread, false);
> +                       ops->idx(evlist, mp, thread);
>
>                 if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
>                                    &output, &output_overwrite))
> @@ -544,7 +544,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>                 int output_overwrite = -1;
>
>                 if (ops->idx)
> -                       ops->idx(evlist, mp, cpu, true);
> +                       ops->idx(evlist, mp, cpu);
>
>                 for (thread = 0; thread < nr_threads; thread++) {
>                         if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index e3e64f37db7b..0d5c830431a7 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -38,7 +38,7 @@ struct perf_evlist {
>  };
>
>  typedef void
> -(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
> +(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int);
>  typedef struct perf_mmap*
>  (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
>  typedef int
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f1309b39afe4..09a1d3400fd9 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -748,10 +748,11 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
>  static void
>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
>                          struct perf_mmap_param *_mp,
> -                        int idx, bool per_cpu)
> +                        int idx)
>  {
>         struct evlist *evlist = container_of(_evlist, struct evlist, core);
>         struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
> +       bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
>
>         auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
>  }
> --
> 2.25.1
>
