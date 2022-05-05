Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FD751CCBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386780AbiEEXc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiEEXcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:32:50 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F7D606C4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:29:07 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id q4so2223564uas.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdbqApY4mXOrsopHiwTuXyJqO4fovzNIApQhEhiIOIs=;
        b=cSBJbzSUlf0wo0uXhF33Ck9A95SE897nbI9zqLy9bXeOUif8YE8fsYF5w377jCCID4
         vrwLC+HkrWQew+zOmB0TeXyI7+e1QrXlSL7wG9O23y7RT56KuMXuzsixWX6Gl3sEZrPw
         oxb291qtOa6XUtZfTib/a6/u1pCCXXfNn4F9+14MuqUepackp42j9UhX3q6YeoFb3PnB
         Fgn8TNYnGi1FPM7rbw+uFmDwd1urobCWtI4SL+l6M3NsUe+EP5bWhJnviUKmTAYt0DEG
         Ao5LTrS+ODiCSK7Z2UOyURz/Z22GFHWs/LdUedaL5lVdBleGwxKuWt7Xw2S0Z+VMztt3
         zQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdbqApY4mXOrsopHiwTuXyJqO4fovzNIApQhEhiIOIs=;
        b=7MXjBpI9Z0mlJj8fUzxHuDVcukCu4NWIYr9D/qX1dpTSCeTVT4E07TsgLLwvjvoXlK
         HW2ZX9iFGquXhtKo4tFPOHkOaLqPZ4BmgRx5rHPQ/Aq8pHF7pyAMunGyu0sOppZjFDnE
         vY5kpsxCB2k6l17wUidH7XP0u6lf9xAxAaH2+p/GcKv65zZcCliEuJjUb9o2CZg7KEC/
         +iG1a9BRqCDosdYIvp4j0PbZ6r5wFG+TJidc5dRT9cZp4h9TK0MRlNnvaFCABDmgJFA9
         4oC1tnEyZ2RfZFLUnH5aC38dg3YQpa7sc+DqR3IL6KuKGflFy5wkKKUAbCTKw3izhCZL
         1jJQ==
X-Gm-Message-State: AOAM532XLhEozcGPmD7jzxTBuiHfqdmhdcbb1DDR7ivOqa7hPnjvTqXk
        pp786bJI6c98iuXGgG1O7ZDE+PoQSSF38Bd6u1OVyg==
X-Google-Smtp-Source: ABdhPJy5p2odCHH/eWHwLIrBfAIUIWsyad2BVsfuWLkY6Nu6P0KXfS/h6cDL1Zv3x1sboQ0cOMPV+qVZsc5+ZQIjOF0=
X-Received: by 2002:ab0:2a87:0:b0:362:9cdb:8b64 with SMTP id
 h7-20020ab02a87000000b003629cdb8b64mr148066uar.83.1651793346155; Thu, 05 May
 2022 16:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-10-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-10-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 16:28:53 -0700
Message-ID: <CAP-5=fXxjJfb+Cm3ZJjKU7P266QUDB8ZVBPJKtf5-eAh9a=NpA@mail.gmail.com>
Subject: Re: [PATCH V1 09/23] perf auxtrace: Record whether an auxtrace mmap
 is needed
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
> Add a flag needs_auxtrace_mmap to record whether an auxtrace mmap is
> needed, in preparation for correctly determining whether or not an
> auxtrace mmap is needed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 1 +
>  tools/perf/arch/arm64/util/arm-spe.c | 1 +
>  tools/perf/arch/s390/util/auxtrace.c | 1 +
>  tools/perf/arch/x86/util/intel-bts.c | 1 +
>  tools/perf/arch/x86/util/intel-pt.c  | 1 +
>  tools/perf/util/evsel.h              | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 11c71aa219f7..1b54638d53b0 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -319,6 +319,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>                         }
>                         evsel->core.attr.freq = 0;
>                         evsel->core.attr.sample_period = 1;
> +                       evsel->needs_auxtrace_mmap = true;
>                         cs_etm_evsel = evsel;
>                         opts->full_auxtrace = true;
>                 }
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index e8b577d33e53..6f4db2ac5420 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -160,6 +160,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>                         }
>                         evsel->core.attr.freq = 0;
>                         evsel->core.attr.sample_period = arm_spe_pmu->default_config->sample_period;
> +                       evsel->needs_auxtrace_mmap = true;
>                         arm_spe_evsel = evsel;
>                         opts->full_auxtrace = true;
>                 }
> diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
> index 0db5c58c98e8..5068baa3e092 100644
> --- a/tools/perf/arch/s390/util/auxtrace.c
> +++ b/tools/perf/arch/s390/util/auxtrace.c
> @@ -98,6 +98,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>         evlist__for_each_entry(evlist, pos) {
>                 if (pos->core.attr.config == PERF_EVENT_CPUM_SF_DIAG) {
>                         diagnose = 1;
> +                       pos->needs_auxtrace_mmap = true;
>                         break;
>                 }
>         }
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index d68a0f48e41e..bcccfbade5c6 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -129,6 +129,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
>                         }
>                         evsel->core.attr.freq = 0;
>                         evsel->core.attr.sample_period = 1;
> +                       evsel->needs_auxtrace_mmap = true;
>                         intel_bts_evsel = evsel;
>                         opts->full_auxtrace = true;
>                 }
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 38ec2666ec12..2eaac4638aab 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -649,6 +649,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>                         evsel->core.attr.freq = 0;
>                         evsel->core.attr.sample_period = 1;
>                         evsel->no_aux_samples = true;
> +                       evsel->needs_auxtrace_mmap = true;
>                         intel_pt_evsel = evsel;
>                         opts->full_auxtrace = true;
>                 }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 45d674812239..544fbed98df1 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -124,6 +124,7 @@ struct evsel {
>         bool                    merged_stat;
>         bool                    reset_group;
>         bool                    errored;
> +       bool                    needs_auxtrace_mmap;
>         struct hashmap          *per_pkg_mask;
>         int                     err;
>         struct {
> --
> 2.25.1
>
