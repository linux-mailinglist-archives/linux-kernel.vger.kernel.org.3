Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFD529783
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiEQCyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiEQCyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:54:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3123A4579B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:54:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so7561647wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogwqf23Klwp9j3f+tkv7Xz3HefBp63TbWbDqRWio0dA=;
        b=KSA2PxSN4WfHF6X4XOj1Wrg6lS4OTVpoviWMiUzWfUWhs5exm9kHxYjfSheRIr4EZB
         PWYlQ9m1eaI3cmaw0Uo2OoRa3KrgonRHYdmhMtYaF4usPTV6YxlIm47Pxr0sVjwiFbOr
         7t8ZR8f2B3Hsvz72JlL6llW3Nm/4uDlVszbO5vkvM/jSrdET+PTQ9ygtYoni3yWOCeDh
         Pzf9x0iXVskwvB0auOiWW8tRm6+DovXib3bjKQ97dWX8tNBY+8SHvbUdntngmSimK4wk
         ezddMQl2do/i1XrNvZ4lkM3revgDva6U5Jz4WTc74lMsj0z5uGY7D3uOrpvKSWANykGV
         TooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogwqf23Klwp9j3f+tkv7Xz3HefBp63TbWbDqRWio0dA=;
        b=Gx2D+VECw7ThMbq88+NEPdA+ms7zm8MxZ0S9qKCv7mLln2beNJbw2qz+bHPr1kvPIH
         I/99W3SvQSspeKsAcPupwSqLd6mbvNfBg/gB23/aP53hhDRsEUkpE4GR1oALhW9n15wo
         iPAhyiLJaf8vw0GJNz+0n5m75tb3Hhvo3ld85c0YchD4NC69a7Q/QI+UFjjkfQ3tClhR
         IjVi3ZTd8W9hLYfsSFV2vwoQSFQ3Cy6Z0DKqtlK/2vd+88MBL620Vi1bolRphwN5xGKB
         lp1YYZR5V2XFIphEdCnFwKgdUjlkcViF9IjswJtmhpyvjNqnFpucvYUZtPGWwc+QH+kD
         ZQug==
X-Gm-Message-State: AOAM532BPPdVz9jj5OgqPnMnzchWqy8+zu3GuPLoam6swYQV3LQQ/Ghw
        Ili8+S9ts/4dyyrt42rggHnm4to+7D6ZcN3wuGw5Uw==
X-Google-Smtp-Source: ABdhPJyq4YeUkQ3b8WJdUd66WXxR/cXXj+RD9Jf+akN7d03gOnLeuzlfWkPvqjM9aC5sgHxPbrOchObXLu8JFMbWwrg=
X-Received: by 2002:a05:6000:78b:b0:20d:101b:2854 with SMTP id
 bu11-20020a056000078b00b0020d101b2854mr3837402wrb.300.1652756053462; Mon, 16
 May 2022 19:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220516152436.1104757-1-kan.liang@linux.intel.com> <20220516152436.1104757-5-kan.liang@linux.intel.com>
In-Reply-To: <20220516152436.1104757-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 19:54:00 -0700
Message-ID: <CAP-5=fXwAyJDkntgf-WPsiTg73sFpobZ5J-pr+cAFK4QKPhJtw@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] perf parse-events: Move slots event for the hybrid
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

On Mon, May 16, 2022 at 8:25 AM <kan.liang@linux.intel.com> wrote:
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/arch/x86/util/evlist.c  |  5 +++--
>  tools/perf/arch/x86/util/topdown.c | 24 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  7 +++++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
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
> index 2f3d96aa92a5..5e86859279e3 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -3,6 +3,30 @@
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
> +       /*
> +        * The perf metrics feature is a core PMU feature.
> +        * The PERF_TYPE_RAW type is the type of a core PMU.
> +        * The slots event is only available when the core PMU
> +        * supports the perf metrics feature.
> +        */
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
