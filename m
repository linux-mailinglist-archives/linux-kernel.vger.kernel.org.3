Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC251E3E7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 06:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389930AbiEGEHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 00:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiEGEHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 00:07:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F74A3E6
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 21:03:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e24so12445559wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 21:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTZy0JhvpeCTmJ44qDmPx7aAp4p0CEczqW37irds05A=;
        b=lxQc4VPVYtBy3u8Fzk8Wb6oB2xPX2Wu1hbns261iN7inG4MlM1F2LRSH4ddrhjhdxW
         WPIryjYrVozfLnHMRTxjaWueS22LPxt/jRLJc5YTtHTT6lqkJj3dtsQY7HWLKNy4B7Mo
         hqzPPOK8b9/boruzobqeg8OIkAoEue8DpUChCweaIPGtU6+Mdopi/uu7YmkmO0XEn43f
         Qcv1tDfOAhPr3XGMKp1Kn/9yFnU028cEMLnTNp1uEsjNZMjvOff65MfCBirSIq7iFaoC
         7mVmSM49Cf9pdpd5wLEJGOpVT+E+S1gURTRLpadgDFFfdtxDVZOzHNUfzuOxupTAe0qv
         tiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTZy0JhvpeCTmJ44qDmPx7aAp4p0CEczqW37irds05A=;
        b=ST3RkI0ODLjTYNxR4VzvIkq9pfVLj/6fKivmYHc5/g84kS2q5bqNPhx1hkRYcmMN1x
         4L7kxIJQs9BoIeELuzvvTpexSB7F6n5ovXrdgmNTr5B+v443qbSCUnoOr9mrd2sPePyg
         qsqc+tmibBIq7r88543EOqDQZQZ5TN18Bcwsoc8F/+yuDYOxOM6VdqnpaY3ABZbFnzTZ
         gBZm0ea1Z2EURwg6B1hNxjirrXbcOj6eV5OYIeZa6jcnOchx20UhKfANUJt3kUBjJ7rV
         T/0/C4t7cZqUId0N1JwhA0WuH/fgLqnPncQVjnkZm1hQTRff6pxlroPFuednCHCOj9Es
         V7Pw==
X-Gm-Message-State: AOAM530wETn/JxgKstYNvQ+jfIGEfYqr/H1X5kIqbXTDBkIQYDrQsnSg
        x6nA9S0h9pRZcQBY6TaP43OwcgW4oi8srCcYw4NlTw==
X-Google-Smtp-Source: ABdhPJy3rt5s9KGGukMgNaV6YUo/+be9kSuGuUnbzhAT1LWo+ymX2vGI2xhI4ITemIMbTy1+NEkDR7nBYCH/BeaN54w=
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id
 n15-20020a5d598f000000b0020c83c9b05bmr5048233wri.343.1651896210784; Fri, 06
 May 2022 21:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220422065635.767648-1-zhengjun.xing@linux.intel.com> <20220422065635.767648-2-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220422065635.767648-2-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 21:03:16 -0700
Message-ID: <CAP-5=fWaU4d90zkqqokp-sCau5DNX_VNVb-Yz3vdqEdkkRYegw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf stat: Merge event counts from all hybrid PMUs
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Thu, Apr 21, 2022 at 11:57 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> For hybrid events, by default stat aggregates and reports the event counts
> per pmu.
>
>   # ./perf stat -e cycles -a  sleep 1
>
>    Performance counter stats for 'system wide':
>
>       14,066,877,268      cpu_core/cycles/
>        6,814,443,147      cpu_atom/cycles/
>
>          1.002760625 seconds time elapsed
>
> Sometimes, it's also useful to aggregate event counts from all PMUs.
> Create a new option '--hybrid-merge' to enable that behavior and report
> the counts without PMUs.
>
>   # ./perf stat -e cycles -a --hybrid-merge  sleep 1
>
>    Performance counter stats for 'system wide':
>
>       20,732,982,512      cycles
>
>          1.002776793 seconds time elapsed
>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

This feels related to aggregation, but aggregation is for a single
evsel on a single PMU. What happens if you have both instructions and
cycles with --hybrid-merge? Normally we aggregate all counts for each
CPU into a the two evsels and then compute a metric:
```
$ perf stat -e instructions,cycles /bin/true

 Performance counter stats for '/bin/true':

         1,830,554      instructions              #    1.17  insn per
cycle
         1,561,415      cycles
```
This kind of aggregation behavior may be needed more widely for metrics.

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-stat.txt | 10 ++++++++++
>  tools/perf/builtin-stat.c              |  2 ++
>  tools/perf/util/stat-display.c         | 17 +++++++++++++++--
>  tools/perf/util/stat.h                 |  1 +
>  4 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index c06c341e72b9..8d1cde00b8d6 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -454,6 +454,16 @@ Multiple events are created from a single event specification when:
>  2. Aliases, which are listed immediately after the Kernel PMU events
>     by perf list, are used.
>
> +--hybrid-merge::
> +Merge the hybrid event counts from all PMUs.
> +
> +For hybrid events, by default, the stat aggregates and reports the event
> +counts per PMU. But sometimes, it's also useful to aggregate event counts
> +from all PMUs. This option enables that behavior and reports the counts
> +without PMUs.
> +
> +For non-hybrid events, it should be no effect.
> +
>  --smi-cost::
>  Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..ea88ac5bed2d 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1235,6 +1235,8 @@ static struct option stat_options[] = {
>         OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
>                     "disable CPU count aggregation", AGGR_NONE),
>         OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
> +       OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
> +                   "Merge identical named hybrid events"),
>         OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
>                    "print counts with custom separator"),
>         OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 46b3dd134656..d9629a83aa78 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -612,6 +612,19 @@ static bool hybrid_uniquify(struct evsel *evsel)
>         return perf_pmu__has_hybrid() && !is_uncore(evsel);
>  }
>
> +static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
> +                        bool check)
> +{
> +       if (hybrid_uniquify(counter)) {
> +               if (check)
> +                       return config && config->hybrid_merge;
> +               else
> +                       return config && !config->hybrid_merge;
> +       }
> +
> +       return false;
> +}
> +
>  static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>                             void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
>                                        bool first),
> @@ -620,9 +633,9 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>         if (counter->merged_stat)
>                 return false;
>         cb(config, counter, data, true);
> -       if (config->no_merge || hybrid_uniquify(counter))
> +       if (config->no_merge || hybrid_merge(counter, config, false))
>                 uniquify_event_name(counter, config);
> -       else if (counter->auto_merge_stats)
> +       else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
>                 collect_all_aliases(config, counter, cb, data);
>         return true;
>  }
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 335d19cc3063..91d989dfeca4 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -122,6 +122,7 @@ struct perf_stat_config {
>         bool                     ru_display;
>         bool                     big_num;
>         bool                     no_merge;
> +       bool                     hybrid_merge;
>         bool                     walltime_run_table;
>         bool                     all_kernel;
>         bool                     all_user;
> --
> 2.25.1
>
