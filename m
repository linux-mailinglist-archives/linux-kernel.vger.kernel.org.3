Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91C51E013
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355963AbiEFUU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358606AbiEFUUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:20:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0656833D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:17:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w4so11329816wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8VQy3gjtn+zhArJCSELbT9kKLjgR+2XC745NnUeDmY=;
        b=KQmicTnw9gl1AiwiA0UFYgyEtZKLVoTIaGUS/wbxlHH32kCxKKH2uLCWlEqWIF9N51
         LBc76erIR4nV1vUhlrdfYwGOE0bl1JOC3oaayU/Mh1AzbJOKwcCjRRa83eH7l/h78I25
         xoGWsYqYmWRt52PsOIQjQYIoozFKRH/HY0dBsgbtoMMcY4jTrWNxH9DO9zfHN7K4Y5Tm
         ZE7vw5P1kWJDh8mnzoBAhfHnCcttWUp5U38ueMhPaSw/mF+aA/RawgnLgymass26kjXB
         lQSHlpOu4ztdaJ6G7Wkfqzj0lYAV1vzoPRuo2pkAoRRZdfrjvAc1WlYcIvSwfdOR6ita
         8qKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8VQy3gjtn+zhArJCSELbT9kKLjgR+2XC745NnUeDmY=;
        b=frfwCiRdiH1Y/xqAEELfMlrYvMH4wlgDV2jCoUDYISgtzAjc4g9HDeLNR8yKr2wnnx
         mR5ZBsw/Ujgd7/E762sdk5abToUQFc3fnaby0Nt1ZSTVEOiO7wX3x86JbqnL5Wj7VQPu
         jWi6D+rL5dvSRWEFuEpe8hYyT8OEZ7PWqHtdXLipesvUGIJ2q5YUGkQkXitOxSiIegMc
         sZpVN1OpQqyUwygFTfD7owkU9uTWGzDwoDVsDe97hUMJtAsFBOXE5vZVfbHt+j4y2ax7
         Ay8raUFGBK9qGJ4/5kNQXwfKsCBafKrHaHM2QxcJISMHiAghat6XFKVSe+HUro9eQkV9
         rQSg==
X-Gm-Message-State: AOAM533Xbj4utkjVPU4uupMF2i+Kgnqso2Fl/BX/VJ272VOdIr/QbZj0
        4eliOEcW3GH5HFzLja44GdljgJ2saibunddIP8lDwUXMS/8=
X-Google-Smtp-Source: ABdhPJzRm86cRxUpESHg4rkl/K4h8TSRH3zxsl3sr7IXx1ifUMVHGsWSbPasg/jbasgyRSCXU68/4cna/jnVyqZvtJM=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr4081186wro.654.1651868221704; Fri, 06
 May 2022 13:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-11-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-11-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 13:16:47 -0700
Message-ID: <CAP-5=fXfGjfpK81Gnm4uxZq3gYanKbYpa9wxxVLF9=aD4_3ArA@mail.gmail.com>
Subject: Re: [PATCH V2 10/23] perf auxtrace: Add mmap_needed to auxtrace_mmap_params
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
> Add mmap_needed to auxtrace_mmap_params.
>
> Currently an auxtrace mmap is always attempted even if the event is not an
> auxtrace event. That works because, when AUX area tracing, there is always
> an auxtrace event first for every mmap. Prepare for that not being the
> case, which it won't be when sideband tracking events are allowed on
> all CPUs even when auxtrace is limited to selected CPUs.

Should there be a later patch to remove this option and just not do
the auxtrace mmap when it's not necessary?

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 10 ++++++++--
>  tools/perf/util/auxtrace.h |  8 ++++++--
>  tools/perf/util/evlist.c   |  5 +++--
>  tools/perf/util/mmap.c     |  1 +
>  4 files changed, 18 insertions(+), 6 deletions(-)
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
> index dc38b6f57232..37feae003904 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -344,6 +344,7 @@ struct auxtrace_mmap {
>   * @idx: index of this mmap
>   * @tid: tid for a per-thread mmap (also set if there is only 1 tid on a per-cpu
>   *       mmap) otherwise %0
> + * @mmap_needed: set to %false for non-auxtrace events

Could you add something like:
(ie. we don't want the mmap but we do want the side effects of ...

Thanks,
Ian

>   * @cpu: cpu number for a per-cpu mmap otherwise %-1
>   */
>  struct auxtrace_mmap_params {
> @@ -353,6 +354,7 @@ struct auxtrace_mmap_params {
>         int             prot;
>         int             idx;
>         pid_t           tid;
> +       bool            mmap_needed;
>         struct perf_cpu cpu;
>  };
>
> @@ -490,7 +492,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
>                                 unsigned int auxtrace_pages,
>                                 bool auxtrace_overwrite);
>  void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
> -                                  struct evlist *evlist, int idx,
> +                                  struct evlist *evlist,
> +                                  struct evsel *evsel, int idx,
>                                    bool per_cpu);
>
>  typedef int (*process_auxtrace_t)(struct perf_tool *tool,
> @@ -863,7 +866,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
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
