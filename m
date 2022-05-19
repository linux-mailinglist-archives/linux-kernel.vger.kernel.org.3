Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7CA52CB21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiESEcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiESEcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:32:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5C9C1EC9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:32:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h14so5380349wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZIuxKEx3Fo89thSnKW2bS1ih4/KHNrKhjF7B7qR0Og=;
        b=aqJa5cMxsehkzQYNhCGehTtomMl+u2ThwjodSHkdvu9+ePWENNa8Z4iTWSVOpMvB8d
         Z/D5Exi0IRXqQb5YjoazkXEE1SJGiBnxPWOjLiCrRozIiX46/er+GROSOa4feHRIelGq
         M8RUy9tidg8+eaYqEc841U4cMhYR+jWgAsL0u04hVGsOYJjg46hvRKQ41ddsAW7zX5FK
         uXwly1ucPxZvt5F2T1/583kfr63x/XRY9ft1yr5EyZSxm+I9ABH/5f5+RUSxu4V2hrbX
         smHbulfRr0PAlkzj4xcIVobSHAzgIzkXh0QAL5Kc6a+sJ54OPAHZxRr1AqvD1U63nUmD
         MzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZIuxKEx3Fo89thSnKW2bS1ih4/KHNrKhjF7B7qR0Og=;
        b=5NIAFWeMn+AIfrN8qqhKXkN2KXK7MsuDUo687hLyXV+vnDYJqX8vo/eS7CwQIActqy
         F6eeeorhdjBtZgE1uLNAFDe7eG+2q9+V/lF/+GcCnW3PV8+DdRREocuhR0sAei3uQpcq
         RquEX95sEgb1iCh8IpeWLQGhwvWDSLaE7pS5I8zOTWSBKY9nsPg0C/h88gSWcnRkdomD
         G9/IYaZ87SjrZKmM45kNAxMklxB1gAySmIXq/Mgu1kMjnTOF71kJHDuDe0CwIl7H79Ye
         OsECt09WsSVDswcA55VjylMXVF/T+3CeBj+k//M8c0lFJNrccuROnBe1lxlI97CrCELD
         6cqw==
X-Gm-Message-State: AOAM533bHFsmxXhHlgUUt7oo60LO/XNVgb8y5n/Xpo6KxV1rs99leOjc
        qI4ipeZkXjCNPAH3UjJtEhkm8RVE3bGUtytmn5Y8UA==
X-Google-Smtp-Source: ABdhPJxETQHCrkQpec9PiAOQD8IDHiXvK7sKpeVz+6eXED71TRvSCNnsVQ0f4d3Nmgcg1LpVGVkH5goY7WExp2ziRZ8=
X-Received: by 2002:a5d:674c:0:b0:20d:87e:8d6f with SMTP id
 l12-20020a5d674c000000b0020d087e8d6fmr2241653wrw.40.1652934730001; Wed, 18
 May 2022 21:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220518143900.1493980-1-kan.liang@linux.intel.com> <20220518143900.1493980-2-kan.liang@linux.intel.com>
In-Reply-To: <20220518143900.1493980-2-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 18 May 2022 21:31:57 -0700
Message-ID: <CAP-5=fVUBm13sGQ8XRx43buBU7odGJ0hNQZ2UBdQR8YeHGjEuw@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] perf evsel: Fixes topdown events in a weak group
 for the hybrid platform
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 7:39 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The patch ("perf evlist: Keep topdown counters in weak group") fixes the
> perf metrics topdown event issue when the topdown events are in a weak
> group on a non-hybrid platform. However, it doesn't work for the hybrid
> platform.
>
> $./perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
> cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
> cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
> cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
> cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
> cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
> cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1
>
> Performance counter stats for 'system wide':
>
>      751,765,068      cpu_core/slots/                        (84.07%)
>  <not supported>      cpu_core/topdown-bad-spec/
>  <not supported>      cpu_core/topdown-be-bound/
>  <not supported>      cpu_core/topdown-fe-bound/
>  <not supported>      cpu_core/topdown-retiring/
>       12,398,197      cpu_core/branch-instructions/          (84.07%)
>        1,054,218      cpu_core/branch-misses/                (84.24%)
>      539,764,637      cpu_core/bus-cycles/                   (84.64%)
>           14,683      cpu_core/cache-misses/                 (84.87%)
>        7,277,809      cpu_core/cache-references/             (77.30%)
>      222,299,439      cpu_core/cpu-cycles/                   (77.28%)
>       63,661,714      cpu_core/instructions/                 (84.85%)
>                0      cpu_core/mem-loads/                    (77.29%)
>       12,271,725      cpu_core/mem-stores/                   (77.30%)
>      542,241,102      cpu_core/ref-cycles/                   (84.85%)
>            8,854      cpu_core/cache-misses/                 (76.71%)
>        7,179,013      cpu_core/cache-references/             (76.31%)
>
>        1.003245250 seconds time elapsed
>
> A hybrid platform has a different PMU name for the core PMUs, while
> the current perf hard code the PMU name "cpu".
>
> The evsel->pmu_name can be used to replace the "cpu" to fix the issue.
> For a hybrid platform, the pmu_name must be non-NULL. Because there are
> at least two core PMUs. The PMU has to be specified.
> For a non-hybrid platform, the pmu_name may be NULL. Because there is
> only one core PMU, "cpu". For a NULL pmu_name, we can safely assume that
> it is a "cpu" PMU.
>
> In case other PMUs also define the "slots" event, checking the PMU type
> as well.
>
> With the patch,
>
> $perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
> cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
> cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
> cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
> cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
> cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
> cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1
>
> Performance counter stats for 'system wide':
>
>    766,620,266   cpu_core/slots/                                        (84.06%)
>     73,172,129   cpu_core/topdown-bad-spec/ #    9.5% bad speculation   (84.06%)
>    193,443,341   cpu_core/topdown-be-bound/ #    25.0% backend bound    (84.06%)
>    403,940,929   cpu_core/topdown-fe-bound/ #    52.3% frontend bound   (84.06%)
>    102,070,237   cpu_core/topdown-retiring/ #    13.2% retiring         (84.06%)
>     12,364,429   cpu_core/branch-instructions/                          (84.03%)
>      1,080,124   cpu_core/branch-misses/                                (84.24%)
>    564,120,383   cpu_core/bus-cycles/                                   (84.65%)
>         36,979   cpu_core/cache-misses/                                 (84.86%)
>      7,298,094   cpu_core/cache-references/                             (77.30%)
>    227,174,372   cpu_core/cpu-cycles/                                   (77.31%)
>     63,886,523   cpu_core/instructions/                                 (84.87%)
>              0   cpu_core/mem-loads/                                    (77.31%)
>     12,208,782   cpu_core/mem-stores/                                   (77.31%)
>    566,409,738   cpu_core/ref-cycles/                                   (84.87%)
>         23,118   cpu_core/cache-misses/                                 (76.71%)
>      7,212,602   cpu_core/cache-references/                             (76.29%)
>
>      1.003228667 seconds time elapsed
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/arch/x86/util/evsel.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 00cb4466b4ca..88306183d629 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -31,10 +31,29 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>         free(env.cpuid);
>  }
>
> +/* Check whether the evsel's PMU supports the perf metrics */
> +static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)

nit: perhaps the function name could be closer to the comment, like
evsel__pmu_has_topdown_metrics. The use of metrics is somewhat
overloaded here with the regular metrics code, but this code lives
under arch/x86 so I guess that's ok.

Thanks,
Ian

> +{
> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
> +
> +       /*
> +        * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
> +        * on a non-hybrid machine, "cpu_core" PMU on a hybrid machine.
> +        * The slots event is only available for the core PMU, which
> +        * supports the perf metrics feature.
> +        * Checking both the PERF_TYPE_RAW type and the slots event
> +        * should be good enough to detect the perf metrics feature.
> +        */
> +       if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
> +           pmu_have_event(pmu_name, "slots"))
> +               return true;
> +
> +       return false;
> +}
> +
>  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  {
> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
> -           !pmu_have_event("cpu", "slots"))
> +       if (!evsel__sys_has_perf_metrics(evsel))
>                 return false;
>
>         return evsel->name &&
> --
> 2.35.1
>
