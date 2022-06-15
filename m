Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9554CC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348061AbiFOPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347151AbiFOPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:17:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF93D1D2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:17:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h19so12593980wrc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vvxf8KlSr0ZVRSgLE+viuGfqiYUL867BC1Qcel1jf2Q=;
        b=GEMTMBYeJoJqX8s26fdaEEzaxqmr0OjcZ/ETLkbHSqp12148poShzWT+nvXFcGBtun
         yRnS0XoQL1xVkD2YXR+5YZd6wo8Fwx4sItIrJApJ3+mcTv1lSCCf5vcDmHrLvbWFIKvb
         hhQTq/JDNyosK6xQqBnJUXfJH8DOsMHseZWRiYkl1qtUk6KSo29qrN5YI2SNusR2C4KD
         dmes5PkjPD5gg2UJY9kzX3BIUGUk0qIM7L1nEWiXF9vyVN2YgUqLQ9ILoM2aMbUI1hir
         IrkcVgyg4WEf0zbXLeiHz+y7K6NZn8dMp4p5UMoikyPJtUKiYCAq6DUJKpeJvUPki7W3
         zYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vvxf8KlSr0ZVRSgLE+viuGfqiYUL867BC1Qcel1jf2Q=;
        b=Eqqn/x7BJ+89ZGrYatOgMBZXFSWIUo6oRuiXxBIyAqXL7B8JSdbd4yQx0Jt+XdQ7qi
         fK1z+Tli8Oy78AN0dBz0GoPPmElJLU6XS5xUJxZp4omJiZQDeum5oUqZ/7GVBq3byMZ5
         GY4D8c8UJ0bnV/04OksvLB0LKZVHOB66WTp47AMrQrKD2TS2LWiD16vMT+7acfjjpaIS
         RqfbmCZKBlU3+gy2gDLMjV+62fqU0Wkb0VsbZoQOB/Fc8x7hKYheOZbxLmvnL/u6LhsT
         MVXy/TrxstaGBt/gdyG9p0hpYX8DalIijbYjOrttBnwGbEeE7q/iaH/E7JBKj0Fybwkv
         cpMg==
X-Gm-Message-State: AJIora8Mm9YsAcJuS+fABJ54oWoNsVcyGxc97U6hQoAwI4wi7Cysc46V
        /UjYq9SphL3NpygCbsoeWqoxw1f+Bb+UMJBlimhhFg==
X-Google-Smtp-Source: AGRyM1uV0/TnCCC9vUDVQzVqxqGoC9H1FzouHTEPOyFtLfkjXcB+OqFE+WURMKtbiig/6NgrlT6mS3TfTPw+yvjaoa8=
X-Received: by 2002:a05:6000:1a8d:b0:219:e3f2:c092 with SMTP id
 f13-20020a0560001a8d00b00219e3f2c092mr288061wry.375.1655306227590; Wed, 15
 Jun 2022 08:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220615150823.2230349-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220615150823.2230349-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jun 2022 08:16:54 -0700
Message-ID: <CAP-5=fVnD=jiSav=UAV9E_mc8XtcHad107ww8JSeiJ2y4ucxDw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Support "--cputype" option for hybrid events
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
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

On Wed, Jun 15, 2022 at 8:07 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> perf stat already has the "--cputype" option to enable events only on the
> specified PMU for the hybrid platform, this commit extends the "--cputype"
> support to perf record.
>
> Without "--cputype", it reports events for both cpu_core and cpu_atom.
>
>  # ./perf record  -e cycles -a sleep 1 | ./perf report
>
>  # To display the perf.data header info, please use --header/--header-only options.
>  #
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.000 MB (null) ]
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 335  of event 'cpu_core/cycles/'
>  # Event count (approx.): 35855267
>  #
>  # Overhead  Command          Shared Object      Symbol
>  # ........  ...............  .................  .........................................
>  #
>      10.31%  swapper          [kernel.kallsyms]  [k] poll_idle
>       9.42%  swapper          [kernel.kallsyms]  [k] menu_select
>       ...    ...               ...               ... ...
>
>  # Samples: 61  of event 'cpu_atom/cycles/'
>  # Event count (approx.): 16453825
>  #
>  # Overhead  Command        Shared Object      Symbol
>  # ........  .............  .................  ......................................
>  #
>      26.36%  snapd          [unknown]          [.] 0x0000563cc6d03841
>       7.43%  migration/13   [kernel.kallsyms]  [k] update_sd_lb_stats.constprop.0
>       ...    ...            ...                ... ...
>
> With "--cputype", it reports events only for the specified PMU.
>
>  # ./perf record --cputype core  -e cycles -a sleep 1 | ./perf report
>
>  # To display the perf.data header info, please use --header/--header-only options.
>  #
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.000 MB (null) ]
>  #
>  # Total Lost Samples: 0
>  #
>  # Samples: 221  of event 'cpu_core/cycles/'
>  # Event count (approx.): 27121818
>  #
>  # Overhead  Command          Shared Object      Symbol
>  # ........  ...............  .................  .........................................
>  #
>      11.24%  swapper          [kernel.kallsyms]  [k] e1000_irq_enable
>       7.77%  swapper          [kernel.kallsyms]  [k] mwait_idle_with_hints.constprop.0
>       ...    ...              ...                ... ...

This is already possible by having the PMU name as part of the event,
cpu_atom/cycles/ or cpu_core/cycles/. I don't know why we're adding
"hybrid" all over the code base, I wish it would stop. You are asking
for an option here for an implied PMU for events that don't specify a
PMU. The option should be called --pmutype and consider all PMUs. We
should remove the "hybrid" PMU list and make all of the "hybrid" code
generic.

Thanks,
Ian

> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  4 ++++
>  tools/perf/builtin-record.c              |  3 +++
>  tools/perf/builtin-stat.c                | 20 --------------------
>  tools/perf/util/pmu-hybrid.c             | 19 +++++++++++++++++++
>  tools/perf/util/pmu-hybrid.h             |  2 ++
>  5 files changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index cf8ad50f3de1..ba8d680da1ac 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -402,6 +402,10 @@ Enable weightened sampling. An additional weight is recorded per sample and can
>  displayed with the weight and local_weight sort keys.  This currently works for TSX
>  abort events and some memory events in precise mode on modern Intel CPUs.
>
> +--cputype::
> +Only enable events on applying cpu with this type for hybrid platform(e.g. core or atom).
> +For non-hybrid events, it should be no effect.
> +
>  --namespaces::
>  Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 9a71f0330137..e1edd4e98358 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3183,6 +3183,9 @@ static struct option __record_options[] = {
>         OPT_INCR('v', "verbose", &verbose,
>                     "be more verbose (show counter open errors, etc)"),
>         OPT_BOOLEAN('q', "quiet", &quiet, "don't print any message"),
> +       OPT_CALLBACK(0, "cputype", &record.evlist, "hybrid cpu type",
> +                    "Only enable events on applying cpu with this type for hybrid platform (e.g. core or atom)",
> +                    parse_hybrid_type),
>         OPT_BOOLEAN('s', "stat", &record.opts.inherit_stat,
>                     "per thread counts"),
>         OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 4ce87a8eb7d7..0d95b29273f4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1184,26 +1184,6 @@ static int parse_stat_cgroups(const struct option *opt,
>         return parse_cgroups(opt, str, unset);
>  }
>
> -static int parse_hybrid_type(const struct option *opt,
> -                            const char *str,
> -                            int unset __maybe_unused)
> -{
> -       struct evlist *evlist = *(struct evlist **)opt->value;
> -
> -       if (!list_empty(&evlist->core.entries)) {
> -               fprintf(stderr, "Must define cputype before events/metrics\n");
> -               return -1;
> -       }
> -
> -       evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
> -       if (!evlist->hybrid_pmu_name) {
> -               fprintf(stderr, "--cputype %s is not supported!\n", str);
> -               return -1;
> -       }
> -
> -       return 0;
> -}
> -
>  static struct option stat_options[] = {
>         OPT_BOOLEAN('T', "transaction", &transaction_run,
>                     "hardware transaction statistics"),
> diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
> index f51ccaac60ee..5c490b5201b7 100644
> --- a/tools/perf/util/pmu-hybrid.c
> +++ b/tools/perf/util/pmu-hybrid.c
> @@ -13,6 +13,7 @@
>  #include <stdarg.h>
>  #include <locale.h>
>  #include <api/fs/fs.h>
> +#include "util/evlist.h"
>  #include "fncache.h"
>  #include "pmu-hybrid.h"
>
> @@ -87,3 +88,21 @@ char *perf_pmu__hybrid_type_to_pmu(const char *type)
>         free(pmu_name);
>         return NULL;
>  }
> +
> +int parse_hybrid_type(const struct option *opt, const char *str, int unset __maybe_unused)
> +{
> +       struct evlist *evlist = *(struct evlist **)opt->value;
> +
> +       if (!list_empty(&evlist->core.entries)) {
> +               fprintf(stderr, "Must define cputype before events/metrics\n");
> +               return -1;
> +       }
> +
> +       evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
> +       if (!evlist->hybrid_pmu_name) {
> +               fprintf(stderr, "--cputype %s is not supported!\n", str);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
> index 2b186c26a43e..26101f134a3a 100644
> --- a/tools/perf/util/pmu-hybrid.h
> +++ b/tools/perf/util/pmu-hybrid.h
> @@ -5,6 +5,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
> +#include <subcmd/parse-options.h>
>  #include <stdbool.h>
>  #include "pmu.h"
>
> @@ -18,6 +19,7 @@ bool perf_pmu__hybrid_mounted(const char *name);
>  struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
>  bool perf_pmu__is_hybrid(const char *name);
>  char *perf_pmu__hybrid_type_to_pmu(const char *type);
> +int parse_hybrid_type(const struct option *opt, const char *str, int unset __maybe_unused);
>
>  static inline int perf_pmu__hybrid_pmu_num(void)
>  {
> --
> 2.25.1
>
