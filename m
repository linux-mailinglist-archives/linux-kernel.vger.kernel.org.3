Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D5480E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhL2AJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:09:58 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46625 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbhL2AJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:09:53 -0500
Received: by mail-lj1-f171.google.com with SMTP id i11so20635398ljm.13;
        Tue, 28 Dec 2021 16:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhPtGQCbuVQkw1vfSzoffiZi105yJTqb5AccIrEq0nc=;
        b=J09iCKfSqrtilGVIuyAgKHweMSvlO6UBQaCd94fIxJDZczZjS5hSYjxiB3BrnKvwfT
         +z9npznzUmAZswuGu3InoNozuYqAv6dQKxnhSyBE2Oaign6ta1EaXbwPkRo2lBkAMaX1
         V4q06RguVPM2tdriZ/f7FH2ULz3/Hd0leUMdV9LJy3vV09iQYj8kqaZZGxwz18evVfnR
         1nWR/31aR7C9xSe+fbQEsfUYUKFnpbF9sGjA+eVWHsmsFxTl60ZKQ8yhfVGylm3r3rPy
         1pewBpFjXilqzlcY9kUOZpNpW1Jv6Vfwr50YE+K3Cw2LxWSUpBJwKwZAC/4U/9QVi/nL
         NC6w==
X-Gm-Message-State: AOAM5328ezyt2qPKuEdMfH9Ije4B/wcygGFq8xzzMPmW5kjp8vpzR66w
        wB/dqReVdnuKfcKYJU72BTdcsjEPy4X7iJZUFXw=
X-Google-Smtp-Source: ABdhPJwLVBfe1pRfb4ha0ZnAi+w0xSRU9mPt7YB2Yuf6o0Vu9WIk0GleEiqoKewt9wUYbjknWADSIq5/CLJJpkusk/4=
X-Received: by 2002:a2e:8854:: with SMTP id z20mr13459873ljj.202.1640736592213;
 Tue, 28 Dec 2021 16:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-26-irogers@google.com>
In-Reply-To: <20211223074541.3318938-26-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 16:09:41 -0800
Message-ID: <CAM9d7cgCoEc5UXCWm9Cstt0_QMNu4jMK1WH3WEjSBxvCnESfYg@mail.gmail.com>
Subject: Re: [PATCH v2 25/48] perf stat-display: Avoid use of core for CPU.
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
> Correct use of cpumap index in print_no_aggr_metric.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> @@ -924,29 +921,32 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>                                  struct evlist *evlist,
>                                  char *prefix)
>  {
> -       int cpu;
> -       int nrcpus = 0;
> -       struct evsel *counter;
> -       u64 ena, run, val;
> -       double uval;
> -       struct aggr_cpu_id id;
> +       int cpu, nrcpus;
>
>         nrcpus = evlist->core.cpus->nr;
>         for (cpu = 0; cpu < nrcpus; cpu++) {
> +               struct evsel *counter;
>                 bool first = true;
>
>                 if (prefix)
>                         fputs(prefix, config->output);
>                 evlist__for_each_entry(evlist, counter) {
> -                       id = aggr_cpu_id__empty();
> -                       id.core = cpu;
> +                       u64 ena, run, val;
> +                       double uval;
> +                       struct aggr_cpu_id id;
> +                       int idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);

Not sure about this.  Here the 'cpu' is an index for the
evlist->core.cpus, not a CPU number.  But the
perf_cpu_map__idx() requires a CPU number, right?

Thanks,
Namhyung


> +
> +                       if (idx < 0)
> +                               continue;
> +
> +                       id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
>                         if (first) {
>                                 aggr_printout(config, counter, id, 0);
>                                 first = false;
>                         }
> -                       val = perf_counts(counter->counts, cpu, 0)->val;
> -                       ena = perf_counts(counter->counts, cpu, 0)->ena;
> -                       run = perf_counts(counter->counts, cpu, 0)->run;
> +                       val = perf_counts(counter->counts, idx, 0)->val;
> +                       ena = perf_counts(counter->counts, idx, 0)->ena;
> +                       run = perf_counts(counter->counts, idx, 0)->run;
>
>                         uval = val * counter->scale;
>                         printout(config, id, 0, counter, uval, prefix,
> --
> 2.34.1.307.g9b7440fafd-goog
>
