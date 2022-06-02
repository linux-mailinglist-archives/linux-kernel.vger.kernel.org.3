Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C854353BFD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiFBUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiFBUaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:30:14 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DB624954;
        Thu,  2 Jun 2022 13:30:12 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 30-20020a9d0121000000b0060ae97b9967so4197389otu.7;
        Thu, 02 Jun 2022 13:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fhty1rGbx32mIVi7Ge6pky804Pd0/lzjVw+dFGZ23Uw=;
        b=VjbX+vIY+QS/cwaP8NoqmQvEVSEw55/PgXUyNl8D3NoyqGa4kSvLpzgQjeNOgl9wtZ
         J1viugDyf+LM0vMT4NY4fQP5Bt1qNaFfuCVafzicyhqPb+XKBvfQivSrQdTjdxM4mYQf
         c4S8vmDWXp+rB4EOnqLNQyiKjokrB51gTQNtBwaCBkPeChYSYD2zIOMMtN4brdxe45+8
         sRpDvJfPf8Rjui+61OTXN1e5KnPU+Q6ReBz1jyg9qQ3q1ykxBOefcE0nM5xp3joNQcgi
         NKeBtBluDI+jTIGgX23dtwLCfMFoVHqRnJ/sWfef9lzP2FLgHW/ExYZjhC6vO2neWR/R
         DXZw==
X-Gm-Message-State: AOAM5309umW8SVMqqod0i4D+rG/3BBko0KyyekgrfS3N+ZhwzTTAyVsM
        ADDrz+DzA6MTUeGjnD768YJhSAQJnVK6gJxd3II=
X-Google-Smtp-Source: ABdhPJyxJQkCPOhgqo2PH9H9+RI4DQaU7powqdI2LYkTZho2nUbIBf3sXEM47EsiYXOYabUa0LUuoJdyWkc7ex2/sIg=
X-Received: by 2002:a05:6830:2aa5:b0:60b:7cc:4ee0 with SMTP id
 s37-20020a0568302aa500b0060b07cc4ee0mr2737534otu.247.1654201812036; Thu, 02
 Jun 2022 13:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220601032608.1034-1-ravi.bangoria@amd.com> <20220601032608.1034-2-ravi.bangoria@amd.com>
In-Reply-To: <20220601032608.1034-2-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Jun 2022 13:30:01 -0700
Message-ID: <CAM9d7ch2dtTjhSt9i96yr4JLEWy7EgNArRvSURE4h5gLL6=7EQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] perf record ibs: Warn about sampling period skew
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rrichter@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Tue, May 31, 2022 at 8:27 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Samples without an L3 miss are discarded and counter is reset with
> random value (between 1-15 for fetch pmu and 1-127 for op pmu) when
> IBS L3 miss filtering is enabled. This causes a sampling period skew
> but there is no way to reconstruct aggregated sampling period. So
> print a warning at perf record if user sets l3missonly=1.
>
> Ex:
>   # perf record -c 10000 -C 0 -e ibs_op/l3missonly=1/
>   WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled
>   and tagged operation does not cause L3 Miss. This causes sampling period skew.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evsel.c | 49 ++++++++++++++++++++++++++++++++
>  tools/perf/util/evsel.c          |  7 +++++
>  tools/perf/util/evsel.h          |  1 +
>  3 files changed, 57 insertions(+)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 88306183d629..fceb904902ab 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -5,6 +5,7 @@
>  #include "util/env.h"
>  #include "util/pmu.h"
>  #include "linux/string.h"
> +#include "util/debug.h"
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel)
>  {
> @@ -60,3 +61,51 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>                 (!strcasecmp(evsel->name, "slots") ||
>                  strcasestr(evsel->name, "topdown"));
>  }
> +
> +static void ibs_l3miss_warn(void)
> +{
> +       pr_warning(
> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
> +}
> +
> +void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
> +{
> +       struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
> +       static int warned_once;
> +       /* 0: Uninitialized, 1: Yes, -1: No */
> +       static int is_amd;
> +
> +       if (warned_once || is_amd == -1)
> +               return;
> +
> +       if (!is_amd) {
> +               struct perf_env *env = evsel__env(evsel);
> +
> +               if (!perf_env__cpuid(env) || !env->cpuid ||
> +                   !strstarts(env->cpuid, "AuthenticAMD")) {
> +                       is_amd = -1;
> +                       return;
> +               }
> +               is_amd = 1;
> +       }
> +
> +       evsel_pmu = evsel__find_pmu(evsel);
> +       if (!evsel_pmu)
> +               return;
> +
> +       ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
> +       ibs_op_pmu = perf_pmu__find("ibs_op");
> +
> +       if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
> +               if (attr->config & (1ULL << 59)) {

It'd be nice if we used a macro or something instead of the
magic number.

> +                       ibs_l3miss_warn();
> +                       warned_once = 1;
> +               }
> +       } else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
> +               if (attr->config & (1ULL << 16)) {

Ditto.

Thanks,
Namhyung


> +                       ibs_l3miss_warn();
> +                       warned_once = 1;
> +               }
> +       }
> +}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ce499c5da8d7..8fea51a9cd90 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1091,6 +1091,11 @@ void __weak arch_evsel__fixup_new_cycles(struct perf_event_attr *attr __maybe_un
>  {
>  }
>
> +void __weak arch__post_evsel_config(struct evsel *evsel __maybe_unused,
> +                                   struct perf_event_attr *attr __maybe_unused)
> +{
> +}
> +
>  static void evsel__set_default_freq_period(struct record_opts *opts,
>                                            struct perf_event_attr *attr)
>  {
> @@ -1366,6 +1371,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>          */
>         if (evsel__is_dummy_event(evsel))
>                 evsel__reset_sample_bit(evsel, BRANCH_STACK);
> +
> +       arch__post_evsel_config(evsel, attr);
>  }
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 73ea48e94079..92bed8e2f7d8 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -297,6 +297,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
>  void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr);
> +void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr);
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> --
> 2.31.1
>
