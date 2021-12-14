Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8199474CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhLNUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbhLNUdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:33:12 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB767C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 12:33:12 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c3so26424671iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJCqhOmZZA6x2NlKj8akS4dVZNVrCbm+0Yq/kMqKdow=;
        b=hH2rQd48l1mVfYCj+XALrKV2SuTVaWHs4IUpdeDi/R+oZyNmbwVN9IYjZLS3KgCQvm
         cRzLKJZ1JPWGiS+6+0hWJaJdMnaPR+uisR8Il5jd0Ck2qoanp65JRNwX5J1NBmFa2wop
         tKYd1+xti/eqRTRx2jibSUyip1JWnDbJHc7lkI09eDjX6FibgEmFTVpktUgkTMBIbTG5
         VJbI2RORkSSq8BKQzgTGugeW7LE2imvZTN2ubMhVeFp1B65BP2ycpaJBFNtUHLawxLUf
         BvwjcVojnVjtLl+yvWwi5hOxOEWS+xtlSzeAvRZoQKLiC0FvDfmjhuzkOOfuUXq2GaAB
         Kpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJCqhOmZZA6x2NlKj8akS4dVZNVrCbm+0Yq/kMqKdow=;
        b=BLvfLAW2mh5CsCknalxql3GrLfDj1bYJFilHTuT5y+5MCofSGZ5Ei3Bhkhkm2iDBTA
         yO0ZFbKCUWlagaOJjy6QtJPIqOYGxUvMtk1RpZfZpVS0tjT5VuNeLTfZ6hIMNIfmNpAF
         lHStqjc88wJEepQeHzI+SQWR8AjgS+gaG9pzhp0kIw6IXQZ9ko+j3DJ4Jc/uKwL2LY5j
         /m2OPCoaR+Z1f85kMCma9/cfGjxZEmpqZSZWwVscmUNFENGi1Y+76zSUDwQAN7cZkHdz
         Q3wUL5+kxdaKDdNgNU7k62B23aZ0W6mFizdLUNEIcp8wXIZDOignofIq6G4d7a3eHzHQ
         BDNg==
X-Gm-Message-State: AOAM531BjPHRBmnaqCp4RMB/d9zvrvXrUuGapv4soMm5M9XoyJavK20R
        jCREMo2n/6YP5f9wGdgrWZRCe9BTZdQzGR0iZ4eO3g==
X-Google-Smtp-Source: ABdhPJyscJO8kfABWRq8D9hgRijq87/xLsIk9oMvf0+rWFTPFg0LobXGZV9CWifvSLU8g7uPwaumaJw7xsOhL45GsZY=
X-Received: by 2002:a02:7fc3:: with SMTP id r186mr4377243jac.522.1639513991710;
 Tue, 14 Dec 2021 12:33:11 -0800 (PST)
MIME-Version: 1.0
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com> <20211214184240.24215-2-andrew.kilroy@arm.com>
In-Reply-To: <20211214184240.24215-2-andrew.kilroy@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Dec 2021 12:32:58 -0800
Message-ID: <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:43 AM Andrew Kilroy <andrew.kilroy@arm.com> wrote:
>
> This patch implements the --topdown option by making use of metrics to
> dictate what counters are obtained in order to show the various topdown
> columns, e.g.  Frontend Bound, Backend Bound, Retiring and Bad
> Speculation.
>
> The MetricGroup name is used to identify which set of metrics are to be
> shown.  For the moment use TopDownL1 and enable for arm64
>
> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
> ---
>  tools/perf/arch/arm64/util/Build     |  1 +
>  tools/perf/arch/arm64/util/topdown.c |  8 ++++++++
>  tools/perf/builtin-stat.c            | 13 +++++++++++++
>  tools/perf/util/metricgroup.c        | 12 ++++++++++++
>  tools/perf/util/metricgroup.h        |  7 +++++++
>  tools/perf/util/topdown.c            |  6 ++++++
>  tools/perf/util/topdown.h            |  1 +
>  7 files changed, 48 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/topdown.c
>
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 9fcb4e68add9..9807aed981cd 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -4,6 +4,7 @@ perf-y += perf_regs.o
>  perf-y += tsc.o
>  perf-y += pmu.o
>  perf-y += kvm-stat.o
> +perf-y += topdown.o
>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/arm64/util/topdown.c b/tools/perf/arch/arm64/util/topdown.c
> new file mode 100644
> index 000000000000..a2b1f9c01148
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/topdown.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <topdown.h>
> +
> +
> +bool arch_topdown_use_json_metrics(void)
> +{
> +       return true;
> +}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f6ca2b054c5b..08ef80ef345e 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1856,6 +1856,18 @@ static int add_default_attributes(void)
>                 if (!force_metric_only)
>                         stat_config.metric_only = true;
>
> +               if (arch_topdown_use_json_metrics()) {
> +                       if (metricgroup__parse_groups_to_evlist(evsel_list, "TopDownL1",
> +                                                               stat_config.metric_no_group,
> +                                                               stat_config.metric_no_merge,
> +                                                               &stat_config.metric_events) < 0) {
> +                               pr_err("Could not form list of metrics for topdown\n");
> +                               return -1;
> +                       }
> +
> +                       goto end_of_topdown_setup;
> +               }
> +
>                 if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
>                         metric_attrs = topdown_metric_L2_attrs;
>                         max_level = 2;
> @@ -1919,6 +1931,7 @@ static int add_default_attributes(void)
>                         fprintf(stderr, "System does not support topdown\n");
>                         return -1;
>                 }
> +end_of_topdown_setup:
>                 free(str);
>         }
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 51c99cb08abf..9b0394372096 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1535,6 +1535,18 @@ int metricgroup__parse_groups(const struct option *opt,
>                             metric_no_merge, NULL, metric_events, map);
>  }
>
> +int metricgroup__parse_groups_to_evlist(struct evlist *perf_evlist,
> +                                       const char *str,
> +                                       bool metric_no_group,
> +                                       bool metric_no_merge,
> +                                       struct rblist *metric_events)
> +{
> +       const struct pmu_events_map *map = pmu_events_map__find();
> +
> +       return parse_groups(perf_evlist, str, metric_no_group,
> +                           metric_no_merge, NULL, metric_events, map);
> +}
> +
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>                                    const struct pmu_events_map *map,
>                                    const char *str,
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 2b42b778d1bf..1f143ad1d9e1 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -70,6 +70,13 @@ int metricgroup__parse_groups(const struct option *opt,
>                               bool metric_no_group,
>                               bool metric_no_merge,
>                               struct rblist *metric_events);
> +
> +int metricgroup__parse_groups_to_evlist(struct evlist *perf_evlist,
> +                                       const char *str,
> +                                       bool metric_no_group,
> +                                       bool metric_no_merge,
> +                                       struct rblist *metric_events);
> +
>  const struct pmu_event *metricgroup__find_metric(const char *metric,
>                                                  const struct pmu_events_map *map);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
> index 1081b20f9891..57c0c5f2c6bd 100644
> --- a/tools/perf/util/topdown.c
> +++ b/tools/perf/util/topdown.c
> @@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
>  {
>         return false;
>  }
> +
> +__weak bool arch_topdown_use_json_metrics(void)
> +{

I like this extension! I've ranted in the past about weak symbols
breaking with archives due to lazy loading [1]. In this case
tools/perf/arch/arm64/util/topdown.c has no other symbols within it
and so the weak symbol has an extra chance of being linked
incorrectly. We could add a new command line of --topdown-json to
avoid this, but there seems little difference in doing this over just
doing '-M TopDownL1'. Is it possible to use the json metric approach
for when the CPU version fails?

Thanks,
Ian

[1] https://lore.kernel.org/lkml/CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com/

> +       return false;
> +}
> +
> diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
> index 2f0d0b887639..0a5275a3f078 100644
> --- a/tools/perf/util/topdown.h
> +++ b/tools/perf/util/topdown.h
> @@ -6,6 +6,7 @@
>  bool arch_topdown_check_group(bool *warn);
>  void arch_topdown_group_warn(void);
>  bool arch_topdown_sample_read(struct evsel *leader);
> +bool arch_topdown_use_json_metrics(void);
>
>  int topdown_filter_events(const char **attr, char **str, bool use_group);
>
> --
> 2.17.1
>
