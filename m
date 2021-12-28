Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F22480DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhL1XzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:55:10 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37658 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhL1XzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:55:09 -0500
Received: by mail-lj1-f174.google.com with SMTP id k27so32990214ljc.4;
        Tue, 28 Dec 2021 15:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKJz/AtcJmpCiEvIzViyhh95QG7qUmjpMJgihccbkCs=;
        b=PvDVzKTaqiPh2OqgLIJCiu7WbBrGDGQBZJGTF+b1Y7U06FAYwwDooPNg4zdYP6/eap
         hgq76x1yk7fnQDavBI1/7u6vJcwpnF77n2u5gjx9/A9LMU950TbWSBAIdigdzJ3VCvJ+
         ua4nrsU3qb4WkaVi0k9aJbfKaICy2eDZbezTwzrZja94uSrrO0NUG/CtVgU1gXDKSuQQ
         3oc6hLXb8npUHlKfwslmGNZfzeW7H8kJP6h4fP0OL4rMLtRXBLRqFNrPCPikocxWTZVX
         AKFYezzL6KzfUEhC5F2/1pD3cHkjFrWjCzvZprsYSacURrHAq7mQCImy5GMGMStsaNTv
         cHTA==
X-Gm-Message-State: AOAM530Rir0L6E3SGbrDC36txGO/lWZMDaaDLXHQgX1RjV3AR0qDzJY9
        XoOWRjuHNU5StAbKGOT1befZ40QR3PAQcf6VEMw=
X-Google-Smtp-Source: ABdhPJzeVaNtQh2PYBhyRcZvRYpN27TgPCYnrsUr+ZHkFSjQrU+k1+FkqGmEwkHUIhVBUf8j36D39viYfLBFnidZBQI=
X-Received: by 2002:a2e:a288:: with SMTP id k8mr7061145lja.204.1640735707979;
 Tue, 28 Dec 2021 15:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-23-irogers@google.com>
In-Reply-To: <20211223074541.3318938-23-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 15:54:56 -0800
Message-ID: <CAM9d7ch+0gCxGe1yJWDa0cLkcHtQLVcbnW6t04NjBRbwP9ASwQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/48] perf cpumap: Trim the cpu_aggr_map
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:47 PM Ian Rogers <irogers@google.com> wrote:
>
> cpu_aggr_map__new removes duplicates, when this happens shrink the
> array.
>
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/cpumap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 8a72ee996722..985c87f1f1ca 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -185,7 +185,12 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                         c->nr++;
>                 }
>         }
> -
> +       /* Trim. */
> +       if (c->nr != cpus->nr) {
> +               c = realloc(c, sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
> +               if (!c)
> +                       return NULL;

This leaks the original 'c'.  Maybe we can just use it
in case of a failure.

Thanks,
Namhyung


> +       }
>         /* ensure we process id in increasing order */
>         qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
>
> --
> 2.34.1.307.g9b7440fafd-goog
>
