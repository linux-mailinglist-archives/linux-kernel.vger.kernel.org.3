Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBC51CCD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386831AbiEEXox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386828AbiEEXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:44:47 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F7C47540
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:41:06 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id s68so2848903vke.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HeZWuYHxFhMYI1ODIpavPj1wZTgKU5ZgSWGVuZk4Ic=;
        b=Bls5M02apNH6TkudwGmIwem2YBYr+ViQCpqWASmiUlmh8S8ftlN3e/akPyutfEQDKO
         zSKmHWUJZizPPDmMt8Ex10/8+Q2XwhKetPvfV23ZvYtozrQOG7Zn3D7Z4E6O0gbBCryK
         sHBHM++AZGT/0qRpmZ+aZ4nPQTE1qgXCpMq6zs5nMyD6pYJ4NhmaJb3TIvCiCFMtL4CM
         Z0iEt0sarU7PQG8udwrFgU4f3lvj1cObN8zu5/oKgMQsZiricF7FyD47ij+kYFkfx2Lj
         7QhwY73sIvf7xz0gXcmMDQnfWHVeuwC3AocdLkyz5/doRTuyZUXw/hEXi1wJfztP9QrP
         LguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HeZWuYHxFhMYI1ODIpavPj1wZTgKU5ZgSWGVuZk4Ic=;
        b=YAyqK0O98tffODXHtevQjP4rX+6NZAo/KmhR2zcI+VAhPlbfwHLybEzt4ZqoUpj/Z+
         KCg13fryR2SrdfDr6M3BGs+PRvF7IkBs2Mio9o2Nj+C8YglwNEhD0iDc1c7j+DWD2FG8
         PGbXmj7enW4UakiRQdYdgh1CGiMXFG7xxH8cgKru6UuXZ9WyqxX8Mg0IDg+Gsw5/UXzC
         pP2UzgkF9lV6huth266Xp9+v91ZUg+1QASMSHHIfZUBrrBsMd2Cru+FhvwumUpCL7CxL
         ENUwomD2nkTDMDJoRYpkINg3PnwFZP26CnOaQBkKr10GwkJ2IKwTVxyCGKfMCDpolll7
         UQTA==
X-Gm-Message-State: AOAM532zfDlBcQJFFZBdPtL6XmXCOFPPQofyKn2l01n25SIGc0gLrxZD
        RIFtSovMPfIhoRC0WfmxLnFtniTp7kLpNOXqYUdUqg==
X-Google-Smtp-Source: ABdhPJykAFOjFHc1Lxkoxp0vxvDl88GW90NcV4v9t2OIun5le4IvF7dRE9NYebr85ww9CBCVVrMp9tu6Kb7T+DOgFIA=
X-Received: by 2002:a1f:9fc4:0:b0:345:5848:4f44 with SMTP id
 i187-20020a1f9fc4000000b0034558484f44mr273976vke.2.1651794065217; Thu, 05 May
 2022 16:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-11-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-11-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:40:52 -0700
Message-ID: <CAP-5=fVta9pbdksMD=p8XGC=Sr0Lj812bSbvVQmKQwbp_n=5Ng@mail.gmail.com>
Subject: Re: [PATCH V1 10/23] perf auxtrace: Add mmap_needed to auxtrace_mmap_params
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
> Add mmap_needed to auxtrace_mmap_params.
>
> Currently an auxtrace mmap is always attempted even if the event is not an
> auxtrace event. That works because, when AUX area tracing, there is always
> an auxtrace event first for every mmap. Prepare for that not being the
> case, which it won't be when sideband tracking events are allowed on
> all CPUs even when auxtrace is limited to selected CPUs.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++--
>  tools/perf/util/auxtrace.h |  7 +++++--
>  tools/perf/util/evlist.c   |  5 +++--
>  tools/perf/util/mmap.c     |  1 +
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index b11549ae39df..b446cfa66469 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -125,7 +125,7 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
>         mm->tid = mp->tid;
>         mm->cpu = mp->cpu.cpu;
>
> -       if (!mp->len) {
> +       if (!mp->len || !mp->mmap_needed) {
>                 mm->base = NULL;
>                 return 0;
>         }
> @@ -168,9 +168,15 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>  }
>
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
> -                                  struct evlist *evlist, int idx,
> +                                  struct evlist *evlist,
> +                                  struct evsel *evsel, int idx,
>                                    bool per_cpu)
>  {
> +       mp->mmap_needed = evsel->needs_auxtrace_mmap;
> +
> +       if (!mp->mmap_needed)
> +               return;
> +
>         mp->idx = idx;
>
>         if (per_cpu) {
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index dc38b6f57232..4e715e2d9291 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -353,6 +353,7 @@ struct auxtrace_mmap_params {
>         int             prot;
>         int             idx;
>         pid_t           tid;
> +       bool            mmap_needed;

It'd be useful to add or fix some context documentation here. Above it says:

* struct auxtrace_mmap_params - parameters to set up struct auxtrace_mmap.

but this flag seems intended for the operation to fail. Clarifying the
intention of the flag would be useful.

Thanks,
Ian

>         struct perf_cpu cpu;
>  };
>
> @@ -490,7 +491,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>                                 unsigned int auxtrace_pages,
>                                 bool auxtrace_overwrite);
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
> -                                  struct evlist *evlist, int idx,
> +                                  struct evlist *evlist,
> +                                  struct evsel *evsel, int idx,
>                                    bool per_cpu);
>
>  typedef int (*process_auxtrace_t)(struct perf_tool *tool,
> @@ -863,7 +865,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>                                 unsigned int auxtrace_pages,
>                                 bool auxtrace_overwrite);
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
> -                                  struct evlist *evlist, int idx,
> +                                  struct evlist *evlist,
> +                                  struct evsel *evsel, int idx,
>                                    bool per_cpu);
>
>  #define ITRACE_HELP ""
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 7ae56b062f44..996bdc203616 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -747,15 +747,16 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
>
>  static void
>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
> -                        struct perf_evsel *_evsel __maybe_unused,
> +                        struct perf_evsel *_evsel,
>                          struct perf_mmap_param *_mp,
>                          int idx)
>  {
>         struct evlist *evlist = container_of(_evlist, struct evlist, core);
>         struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
>         bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
> +       struct evsel *evsel = container_of(_evsel, struct evsel, core);
>
> -       auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
> +       auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx, per_cpu);
>  }
>
>  static struct perf_mmap*
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 50502b4a7ca4..de59c4da852b 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -62,6 +62,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
>
>  void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
>                                           struct evlist *evlist __maybe_unused,
> +                                         struct evsel *evsel __maybe_unused,
>                                           int idx __maybe_unused,
>                                           bool per_cpu __maybe_unused)
>  {
> --
> 2.25.1
>
