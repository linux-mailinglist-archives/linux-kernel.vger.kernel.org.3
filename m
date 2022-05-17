Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C3529780
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiEQCwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiEQCwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:52:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA833CFE2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:52:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k126so9709589wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiOx2OZaCbHvMpsuendd/ieTbUuneQzpGndjkRGYT1c=;
        b=k6WCJf4/ijXv40zs1IP6oSplz1ktZoQD1wYX953oRjgT2XKtSpa0duCKTjEY4R8iBh
         pKzZI304kAuLywS3c04W2Ef2rdCqDWueRk0MwtEq7gDDJ9eCfMLtsQP5t5t9QeJmr3c8
         /r72RYZK9CbJT7o9kbZWGseFBZ3B2XrknXp41JWDG80dS3Op1D/VJ2mQb2SZFxmyrC7R
         3F/ZT7jCXk+Z4JLEd7ovxxY4iQMFo0vMA1xuyB3wl7VVapPyyKckhhjS0iCvklPgl1dm
         yQ2jn+iIx+m1Kh2c3DoBi9l7UzkgB1Yiuc0SvODOsGB9Y2/r+bvSqG1vRZy6gsWOLnTk
         31OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiOx2OZaCbHvMpsuendd/ieTbUuneQzpGndjkRGYT1c=;
        b=YLqocRaJ1TdT/oknler/vfxC2gJ6QJc2/1F/BlTR/+0s5PFq50u0k8vlw1sif1LJjq
         7+leDbemdpP+dPpPz5fJZGH439GInt6K1oVQB3qSGlQVjE/39ZO6rp0pVPB2ILMUrTWt
         ItJuIIhDri4snB1325vMB1eWok/jP+MyKgbJHTBUd2oTaZhajZzcbQ+jFggnrZhzEjAt
         2S/PVwR0imGRpf7R0f8dgEC19hxRcgO77RiyF2E3TkEkXo0h/4WyihTWeqm1Do7ZFLm2
         wjEoqo6vKt3clozq9iSRrO07AB3W5DqyV9DT4bq/dhiysXy4AXJabQZ/JpFA6oNdk3ep
         pQnA==
X-Gm-Message-State: AOAM53382Ub6hPtTVGTwRFX+oSdufvn3MFbWwGIilKDO5hD7jdUxTOFX
        HRj5hxu94f57I+IvhaSJRVfbS8y7sLCVXmK1EkMg/A==
X-Google-Smtp-Source: ABdhPJz81zm7AWXwo77l11tlkbklbYgCEsmZsGeKXJbP+obXIMlYUaDNJsfpLxgaDS11gW1xilXkRXfbqcwlD9jmKz8=
X-Received: by 2002:a05:600c:19cc:b0:394:8dc2:a23b with SMTP id
 u12-20020a05600c19cc00b003948dc2a23bmr29677245wmq.182.1652755968899; Mon, 16
 May 2022 19:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220516152436.1104757-1-kan.liang@linux.intel.com> <20220516152436.1104757-2-kan.liang@linux.intel.com>
In-Reply-To: <20220516152436.1104757-2-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 19:52:34 -0700
Message-ID: <CAP-5=fWisSuGR_7fP1d=kdjhM31yYeVdvVq8M8GWPk0=N6N2Yw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] perf evsel: Fixes topdown events in a weak group
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 8:25 AM <kan.liang@linux.intel.com> wrote:
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
>  Performance counter stats for 'system wide':
>
>        751,765,068      cpu_core/slots/                                               (84.07%)
>    <not supported>      cpu_core/topdown-bad-spec/
>    <not supported>      cpu_core/topdown-be-bound/
>    <not supported>      cpu_core/topdown-fe-bound/
>    <not supported>      cpu_core/topdown-retiring/
>         12,398,197      cpu_core/branch-instructions/                                     (84.07%)
>          1,054,218      cpu_core/branch-misses/                                       (84.24%)
>        539,764,637      cpu_core/bus-cycles/                                          (84.64%)
>             14,683      cpu_core/cache-misses/                                        (84.87%)
>          7,277,809      cpu_core/cache-references/                                     (77.30%)
>        222,299,439      cpu_core/cpu-cycles/                                          (77.28%)
>         63,661,714      cpu_core/instructions/                                        (84.85%)
>                  0      cpu_core/mem-loads/                                           (77.29%)
>         12,271,725      cpu_core/mem-stores/                                          (77.30%)
>        542,241,102      cpu_core/ref-cycles/                                          (84.85%)
>              8,854      cpu_core/cache-misses/                                        (76.71%)
>          7,179,013      cpu_core/cache-references/                                     (76.31%)
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
>  Performance counter stats for 'system wide':
>
>        766,620,266      cpu_core/slots/                                               (84.06%)
>         73,172,129      cpu_core/topdown-bad-spec/ #      9.5% bad speculation         (84.06%)
>        193,443,341      cpu_core/topdown-be-bound/ #     25.0% backend bound           (84.06%)
>        403,940,929      cpu_core/topdown-fe-bound/ #     52.3% frontend bound          (84.06%)
>        102,070,237      cpu_core/topdown-retiring/ #     13.2% retiring                (84.06%)
>         12,364,429      cpu_core/branch-instructions/                                     (84.03%)
>          1,080,124      cpu_core/branch-misses/                                       (84.24%)
>        564,120,383      cpu_core/bus-cycles/                                          (84.65%)
>             36,979      cpu_core/cache-misses/                                        (84.86%)
>          7,298,094      cpu_core/cache-references/                                     (77.30%)
>        227,174,372      cpu_core/cpu-cycles/                                          (77.31%)
>         63,886,523      cpu_core/instructions/                                        (84.87%)
>                  0      cpu_core/mem-loads/                                           (77.31%)
>         12,208,782      cpu_core/mem-stores/                                          (77.31%)
>        566,409,738      cpu_core/ref-cycles/                                          (84.87%)
>             23,118      cpu_core/cache-misses/                                        (76.71%)
>          7,212,602      cpu_core/cache-references/                                     (76.29%)
>
>        1.003228667 seconds time elapsed
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evsel.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 00cb4466b4ca..6eda5a491eda 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -31,10 +31,27 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>         free(env.cpuid);
>  }
>
> +static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
> +{

Why have this and not use topdown_sys_has_perf_metrics? It seems
strange to have the mix of evsel and PMU that this function is
testing.

> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
> +
> +       /*
> +        * The PERF_TYPE_RAW type is the core PMU type.
> +        * The slots event is only available for the core PMU, which
> +        * supports the perf metrics feature.

nit: Does "core PMU" mean /sys/devices/cpu_core ? It would be good to
disambiguate possibly by just using "cpu_core PMU".

Thanks,
Ian


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
