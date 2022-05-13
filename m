Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20145267E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382737AbiEMRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356224AbiEMRHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:07:55 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E661294
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:07:52 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id ay15so3412396uab.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SO6cZ4vcFdH6Gw26Rsfe2kTJJS3GLmvIu7jUCMoqB/c=;
        b=tEwwqEf/QAgZncrVrgI1PvCqCEVehtgalfmgsWRT4PqAixI+ItZ5QYDRJpav5HHIJ9
         cXOftSG5RIM+jYbU4H7IYYvM2O+tHSiu8S4J9hV7tr2ZT9tzf6reIf9IUtXz0myUFmot
         cElfczSxUQilGQgTbatodWYMDYHplQjDCW42vrcFSaCImCcPcHc9Zsm5M+NFqPIZr96z
         6XhxP2RNLl6+epuZKn1Sk2latVMfA7D/BkMo65zjP9/GMCU61+EIRcFOfLFM0qSiCrT7
         zieWnrn+8idxl91BE8ZF5GGnvYvQs5h8hhsBb4FBwgOOkgP+HX/fjmA+4wkLZo6pTL9q
         AvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SO6cZ4vcFdH6Gw26Rsfe2kTJJS3GLmvIu7jUCMoqB/c=;
        b=1wqSA6jOLV2y1F1x5dSQYDcOK6JWDo8Gdb5+o6Moj/95hVfzIxxQIgi3XlYmkWkRDO
         dEe6CKIVd9vkbzg3c6PvY8/oIqr/UjBOq5gNbJ3ppA0N2qJkHVVqSBMCjKnoJhZGb+mx
         XxNNsZjyXgy1y3I1b5zqNunwIWOQdyVd6QmwFSX+BLo90FYNrcnK8niDSwEHfT2RjEre
         Izknaoe8s4uDv4PI2LYC8Ds0DNjpkMjwj4S3TIuiRCwqINR4zgFLj3Nn2edlm9D4OSb7
         LArDnUB3EbqHTnO3Xt0NqYuOb2qJLN9Gr/uEANY+3cd6n7NWugg6DVs2NHatOTHTJZ3H
         /u1Q==
X-Gm-Message-State: AOAM5301BIlZ0GpYbp84x7GO+Adv+T/E4tAtanDDDavT12rv+pD78m65
        NsVH4JoflOCev7Q8EI7UMq5r4frr6BQ35xt9kfsuBErfiDApyA==
X-Google-Smtp-Source: ABdhPJxpH83FSHQPHQczwK/rOF+Gbj+oCuJ9KL9UX9oGm665pOLLR/ZVftQEO8pC79yumKEkXBXmgL3qcw0OP7CcI1w=
X-Received: by 2002:ab0:240a:0:b0:360:7c96:2f8c with SMTP id
 f10-20020ab0240a000000b003607c962f8cmr2718694uan.48.1652461671005; Fri, 13
 May 2022 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220513151554.1054452-1-kan.liang@linux.intel.com> <20220513151554.1054452-5-kan.liang@linux.intel.com>
In-Reply-To: <20220513151554.1054452-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 10:07:39 -0700
Message-ID: <CAP-5=fUv1LRnMg7PvfvtN1rhc5BXfv_W181LovXe4nptDmwLmQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf parse-events: Move slots event for the hybrid
 platform too
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

On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The commit 94dbfd6781a0 ("perf parse-events: Architecture specific
> leader override") introduced a feature to reorder the slots event to
> fulfill the restriction of the perf metrics topdown group. But the
> feature doesn't work on the hybrid machine.
>
> $perf stat -e "{cpu_core/instructions/,cpu_core/slots/,cpu_core/topdown-retiring/}" -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      <not counted>      cpu_core/instructions/
>      <not counted>      cpu_core/slots/
>    <not supported>      cpu_core/topdown-retiring/
>
>        1.002871801 seconds time elapsed
>
> A hybrid platform has a different PMU name for the core PMUs, while
> current perf hard code the PMU name "cpu".
>
> Introduce a new function to check whether the system supports the perf
> metrics feature. The result is cached for the future usage.
>
> For X86, the core PMU name always has "cpu" prefix.
>
> With the patch,
>
> $perf stat -e "{cpu_core/instructions/,cpu_core/slots/,cpu_core/topdown-retiring/}" -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>         76,337,010      cpu_core/slots/
>         10,416,809      cpu_core/instructions/
>         11,692,372      cpu_core/topdown-retiring/
>
>        1.002805453 seconds time elapsed
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c  |  5 +++--
>  tools/perf/arch/x86/util/topdown.c | 18 ++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  7 +++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/topdown.h
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 75564a7df15b..68f681ad54c1 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -3,6 +3,7 @@
>  #include "util/pmu.h"
>  #include "util/evlist.h"
>  #include "util/parse-events.h"
> +#include "topdown.h"
>
>  #define TOPDOWN_L1_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
>  #define TOPDOWN_L2_EVENTS      "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
> @@ -25,12 +26,12 @@ struct evsel *arch_evlist__leader(struct list_head *list)
>
>         first = list_first_entry(list, struct evsel, core.node);
>
> -       if (!pmu_have_event("cpu", "slots"))
> +       if (!topdown_sys_has_perf_metrics())
>                 return first;
>
>         /* If there is a slots event and a topdown event then the slots event comes first. */
>         __evlist__for_each_entry(list, evsel) {
> -               if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") && evsel->name) {
> +               if (evsel->pmu_name && !strncmp(evsel->pmu_name, "cpu", 3) && evsel->name) {
>                         if (strcasestr(evsel->name, "slots")) {
>                                 slots = evsel;
>                                 if (slots == first)
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 2f3d96aa92a5..95b9fdef59ab 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -3,6 +3,24 @@
>  #include "api/fs/fs.h"
>  #include "util/pmu.h"
>  #include "util/topdown.h"
> +#include "topdown.h"
> +
> +bool topdown_sys_has_perf_metrics(void)
> +{
> +       static bool has_perf_metrics;
> +       static bool cached;
> +       struct perf_pmu *pmu;
> +
> +       if (cached)
> +               return has_perf_metrics;
> +

Worth a comment here for the meaning of looking up PERF_TYPE_RAW.

Thanks,
Ian

> +       pmu = perf_pmu__find_by_type(PERF_TYPE_RAW);
> +       if (pmu && pmu_have_event(pmu->name, "slots"))
> +               has_perf_metrics = true;
> +
> +       cached = true;
> +       return has_perf_metrics;
> +}
>
>  /*
>   * Check whether we can use a group for top down.
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> new file mode 100644
> index 000000000000..46bf9273e572
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOPDOWN_H
> +#define _TOPDOWN_H 1
> +
> +bool topdown_sys_has_perf_metrics(void);
> +
> +#endif
> --
> 2.35.1
>
