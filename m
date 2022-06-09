Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C99F544045
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiFIAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFIAEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:04:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8F33361;
        Wed,  8 Jun 2022 17:04:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso16235670otp.8;
        Wed, 08 Jun 2022 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UudnJSD69StN/M4nd3Z1Vr4LTHFp+Hki6amkqMSyqQ=;
        b=YzJqdSHuI71da5Zx3W3OvbVta/06HWcfmNXzNZIy2+Slx+V1yYHbe7aoB+I+2ftzAX
         YsjABqzOHYX4U8imGcibX6vQq5fs+rJ3iF97LloMhZeaeTl6Dkq10rGiUCuT/iDisD0O
         cyJmVnGjeoHurTXD6w+fznxoiTVDAHqwYcW3IaORA/ntOhasZFXSw5MWFWgERPGpYCxi
         sU6rfd5Pp3e04kuj3UMXdE25WtnD6dcNPpAWvRq7ffxESItlnp68DKcl8TcYXRdYzvzQ
         ZI99Be4zw1xAcBySSY4rYCA69JWr5sVV7Se14lrL8mm+VbEzchU0i29KOcE1Vo5Q1tNV
         EGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UudnJSD69StN/M4nd3Z1Vr4LTHFp+Hki6amkqMSyqQ=;
        b=6T/K2UZfFNtMWKm2dV7/ndhvdXGAZgGWxeCB7Zl882BPV6N2+/TxxHAjaSwWURMlKp
         EODwJjzM42y0QNkeppgzuBPTY2MrimmOuAfycvRlJlKb0kof6eBcKtGRJm8gu3Msw4qI
         FAeC4t3r2VyIkU/n0WHjBVa7zx846B/U2CC7kjx/hB7yB300x9RaTb2aDB6bSkzon72t
         nzcrbY8qvPrxp9yz9LGjL8k7wDPjLzgfjwPLnwa+HnjZypuuemRhhO/Y2AjcRRhqdbDe
         SlhVA2hSVearIVcytYw73WEyyl5awL5KpWjM3Abj25mNvvbF1IiCZ/3kLRJuSFLnQbNV
         iOMQ==
X-Gm-Message-State: AOAM533kYdAFGbKLTiEsIBogGbCzBMaCwQKS44bnI2xcalonuHmyqBIw
        VIaZinwBLHylj1LUZfhzB6+zsHVItFNLKA4sjhg=
X-Google-Smtp-Source: ABdhPJwOJ1GyWCTWKhU9Y2HMY/ejvrhiMJ2GkY4X+F1sj1n/C703D4RqqeVHUmnvdjOTS1NbAcJi64zeBx06c0Pg7j4=
X-Received: by 2002:a05:6830:2aa5:b0:60b:7cc:4ee0 with SMTP id
 s37-20020a0568302aa500b0060b07cc4ee0mr15260086otu.247.1654733058779; Wed, 08
 Jun 2022 17:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220607013315.1956301-1-zhengjun.xing@linux.intel.com> <20220607013315.1956301-5-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220607013315.1956301-5-zhengjun.xing@linux.intel.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 8 Jun 2022 17:04:07 -0700
Message-ID: <CAM9d7ci5_276eEDAaRis1CfHe6hyc5bK3RtirsAw5AGdR_KCTw@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf x86 evlist: Add default hybrid events for perf stat
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 7, 2022 at 12:31 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Provide a new solution to replace the reverted commit ac2dc29edd21
> ("perf stat: Add default hybrid events").
>
> For the default software attrs, nothing is changed.
> For the default hardware attrs, create a new evsel for each hybrid pmu.
>
> With the new solution, adding a new default attr will not require the
> special support for the hybrid platform anymore.
>
> Also, the "--detailed" is supported on the hybrid platform
>
> With the patch,
>
> ./perf stat -a -ddd sleep 1
>
>  Performance counter stats for 'system wide':
>
>        32,231.06 msec cpu-clock                 #   32.056 CPUs utilized
>              529      context-switches          #   16.413 /sec
>               32      cpu-migrations            #    0.993 /sec
>               69      page-faults               #    2.141 /sec
>      176,754,151      cpu_core/cycles/          #    5.484 M/sec          (41.65%)
>      161,695,280      cpu_atom/cycles/          #    5.017 M/sec          (49.92%)
>       48,595,992      cpu_core/instructions/    #    1.508 M/sec          (49.98%)
>       32,363,337      cpu_atom/instructions/    #    1.004 M/sec          (58.26%)
>       10,088,639      cpu_core/branches/        #  313.010 K/sec          (58.31%)
>        6,390,582      cpu_atom/branches/        #  198.274 K/sec          (58.26%)
>          846,201      cpu_core/branch-misses/   #   26.254 K/sec          (66.65%)
>          676,477      cpu_atom/branch-misses/   #   20.988 K/sec          (58.27%)
>       14,290,070      cpu_core/L1-dcache-loads/ #  443.363 K/sec          (66.66%)
>        9,983,532      cpu_atom/L1-dcache-loads/ #  309.749 K/sec          (58.27%)
>          740,725      cpu_core/L1-dcache-load-misses/ #   22.982 K/sec    (66.66%)
>  <not supported>      cpu_atom/L1-dcache-load-misses/
>          480,441      cpu_core/LLC-loads/       #   14.906 K/sec          (66.67%)
>          326,570      cpu_atom/LLC-loads/       #   10.132 K/sec          (58.27%)
>              329      cpu_core/LLC-load-misses/ #   10.208 /sec           (66.68%)
>                0      cpu_atom/LLC-load-misses/ #    0.000 /sec           (58.32%)
>  <not supported>      cpu_core/L1-icache-loads/
>       21,982,491      cpu_atom/L1-icache-loads/ #  682.028 K/sec          (58.43%)
>        4,493,189      cpu_core/L1-icache-load-misses/ #  139.406 K/sec    (33.34%)
>        4,711,404      cpu_atom/L1-icache-load-misses/ #  146.176 K/sec    (50.08%)
>       13,713,090      cpu_core/dTLB-loads/      #  425.462 K/sec          (33.34%)
>        9,384,727      cpu_atom/dTLB-loads/      #  291.170 K/sec          (50.08%)
>          157,387      cpu_core/dTLB-load-misses/ #    4.883 K/sec         (33.33%)
>          108,328      cpu_atom/dTLB-load-misses/ #    3.361 K/sec         (50.08%)
>  <not supported>      cpu_core/iTLB-loads/
>  <not supported>      cpu_atom/iTLB-loads/
>           37,655      cpu_core/iTLB-load-misses/ #    1.168 K/sec         (33.32%)
>           61,661      cpu_atom/iTLB-load-misses/ #    1.913 K/sec         (50.03%)
>  <not supported>      cpu_core/L1-dcache-prefetches/
>  <not supported>      cpu_atom/L1-dcache-prefetches/
>  <not supported>      cpu_core/L1-dcache-prefetch-misses/
>  <not supported>      cpu_atom/L1-dcache-prefetch-misses/
>
>        1.005466919 seconds time elapsed
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 52 ++++++++++++++++++++++++++++++-
>  tools/perf/util/evlist.c          |  2 +-
>  tools/perf/util/evlist.h          |  2 ++
>  3 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 777bdf182a58..1b3f9e1a2287 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -4,16 +4,66 @@
>  #include "util/evlist.h"
>  #include "util/parse-events.h"
>  #include "topdown.h"
> +#include "util/event.h"
> +#include "util/pmu-hybrid.h"
>
>  #define TOPDOWN_L1_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
>  #define TOPDOWN_L2_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
>
> +static int ___evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> +{
> +       struct perf_cpu_map *cpus;
> +       struct evsel *evsel, *n;
> +       struct perf_pmu *pmu;
> +       LIST_HEAD(head);
> +       size_t i, j = 0;
> +
> +       for (i = 0; i < nr_attrs; i++)
> +               event_attr_init(attrs + i);
> +
> +       if (!perf_pmu__has_hybrid())
> +               return evlist__add_attrs(evlist, attrs, nr_attrs);
> +
> +       for (i = 0; i < nr_attrs; i++) {
> +               if (attrs[i].type == PERF_TYPE_SOFTWARE) {
> +                       evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + j);

Probably no need to calculate index (j) as it's updated
later when it goes to the evlist...


> +                       if (evsel == NULL)
> +                               goto out_delete_partial_list;
> +                       j++;
> +                       list_add_tail(&evsel->core.node, &head);
> +                       continue;
> +               }
> +
> +               perf_pmu__for_each_hybrid_pmu(pmu) {
> +                       evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries + j);
> +                       if (evsel == NULL)
> +                               goto out_delete_partial_list;
> +                       j++;
> +                       evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> +                       cpus = perf_cpu_map__get(pmu->cpus);
> +                       evsel->core.cpus = cpus;
> +                       evsel->core.own_cpus = perf_cpu_map__get(cpus);
> +                       evsel->pmu_name = strdup(pmu->name);
> +                       list_add_tail(&evsel->core.node, &head);
> +               }
> +       }
> +
> +       evlist__splice_list_tail(evlist, &head);

... like here.

Thanks,
Namhyung


> +
> +       return 0;
> +
> +out_delete_partial_list:
> +       __evlist__for_each_entry_safe(&head, n, evsel)
> +               evsel__delete(evsel);
> +       return -1;
> +}
