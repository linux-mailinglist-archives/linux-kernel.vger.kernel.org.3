Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B87488FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 06:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiAJFuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 00:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiAJFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 00:50:01 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C98C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 21:50:01 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id w9so3041122iol.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 21:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALvm4nc74eB2Wd9VAb2s3UJ9R4m/+S/oxilpPbRkW3A=;
        b=UrVsrwQso0IJkVO6QF2YQtW9l/A725oNGGJf+YZ/359fCEopGJ9XwrL1CWRtZNAX4v
         MwF0Xd2DBUEH9EbSo1XKsyMm8McJL8SeQ02ajzi1HxW+0KOlPkrAAr0bTdcaeAtdmoJz
         aBDV5TU8gK/tCTMmzcBu1MXhyNvRGA18grlWPGPUifNoxBP4kOWuGPycAXj8FD72+uYr
         8rXfbC7m1EL8+Aw4ZpLZJodpVn/4rQpZHQxEiMrYmKveM9cexzEWW12in1QnvHlEUYwk
         A6Fwxvie9bfqoP9g4cnbL5M4kMavDnk80S7DYn/Ukf2vFa3SCE7FZMqCwooNfQs/tD+x
         LAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALvm4nc74eB2Wd9VAb2s3UJ9R4m/+S/oxilpPbRkW3A=;
        b=1qAKRQyMat0W6nNPbcpQJZM1KimRutyU0TfRFpXxGWkZfcIpl434TS+rhif+x+NY+D
         2ElduS+xO4C+J+OUp2/BAL7SU6SvQ4bAD6GsFLM5fE+wnetbF5p80dpLek4cHcCtLNFI
         2biu7Vb7SyUVTJqQdqHOdph2Fz/tYttujeoqFqh6TWI9eWzJu0GTUi2otOTfDNN1LNr0
         4Uib33xZW7vzVeFvIacDIhzEBgjnVsfZlfJEozjRlTEe7xa7ddAC46npXGupVWPwQbtQ
         uc3QKR/PD2BrLpr0IXHE71DA8ilPfVkabJlDpOueW9P2FGCfchEY9v3AKDo3dDrQXX5L
         NNEw==
X-Gm-Message-State: AOAM5307KFlc3vWTjxTBXErVAI+YT+H3JPFHLUNYAepnkcpY1IHsNOo3
        Jk6dF2oVxiVriKxms1rUHsSmY6sLzmTeMtnu3cDXqg==
X-Google-Smtp-Source: ABdhPJxOtknTyji3ATIF1Q9X5pyoX9JjwnRiihSAmLOCzQLNETeSKhBU3GP9sUJllE6Gs+j+DrTgUhjvnM+2DhvNGms=
X-Received: by 2002:a05:6602:2b8b:: with SMTP id r11mr14683655iov.97.1641793800714;
 Sun, 09 Jan 2022 21:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-27-irogers@google.com>
 <Ydsp1d58t/gp/GHd@krava>
In-Reply-To: <Ydsp1d58t/gp/GHd@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 9 Jan 2022 21:49:48 -0800
Message-ID: <CAP-5=fU77-qjcooX5B7qmimUoyNp-nXKNtnGQE9F6TH8Qsx+4A@mail.gmail.com>
Subject: Re: [PATCH v4 26/48] perf evsel: Derive CPUs and threads in alloc_counts
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 10:30 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 04, 2022 at 10:13:29PM -0800, Ian Rogers wrote:
>
> SNIP
>
> > diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> > index 7ff36bf6d644..3e275e9c60d1 100644
> > --- a/tools/perf/util/counts.h
> > +++ b/tools/perf/util/counts.h
> > @@ -40,7 +40,7 @@ void perf_counts__delete(struct perf_counts *counts);
> >  void perf_counts__reset(struct perf_counts *counts);
> >
> >  void evsel__reset_counts(struct evsel *evsel);
> > -int evsel__alloc_counts(struct evsel *evsel, int ncpus, int nthreads);
> > +int evsel__alloc_counts(struct evsel *evsel);
> >  void evsel__free_counts(struct evsel *evsel);
> >
> >  #endif /* __PERF_COUNTS_H */
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 656c30b988ce..6c9af21776e6 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1578,7 +1578,7 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
> >       if (FD(evsel, cpu, thread) < 0)
> >               return -EINVAL;
> >
> > -     if (evsel->counts == NULL && evsel__alloc_counts(evsel, cpu + 1, thread + 1) < 0)
> > +     if (evsel->counts == NULL && evsel__alloc_counts(evsel) < 0)
>
> ugh, nice.. good that it's used only from test code ;-)
>
> btw I noticed evsel__read_on_cpu_scaled is not used at all

I'd noticed that too, but wanted to stay away from making the patch
set larger.  You end up removing the argument to
__evsel__read_on_cpu, etc. Definitely worth cleaning up, but maybe we
can do it later.

Thanks,
Ian

> jirka
>
> >               return -ENOMEM;
> >
> >       if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index c69b221f5e3e..995cb5003133 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -152,11 +152,13 @@ static void evsel__free_stat_priv(struct evsel *evsel)
> >       zfree(&evsel->stats);
> >  }
> >
> > -static int evsel__alloc_prev_raw_counts(struct evsel *evsel, int ncpus, int nthreads)
> > +static int evsel__alloc_prev_raw_counts(struct evsel *evsel)
> >  {
> > +     int cpu_map_nr = evsel__nr_cpus(evsel);
> > +     int nthreads = perf_thread_map__nr(evsel->core.threads);
> >       struct perf_counts *counts;
> >
> > -     counts = perf_counts__new(ncpus, nthreads);
> > +     counts = perf_counts__new(cpu_map_nr, nthreads);
> >       if (counts)
> >               evsel->prev_raw_counts = counts;
> >
> > @@ -177,12 +179,9 @@ static void evsel__reset_prev_raw_counts(struct evsel *evsel)
> >
> >  static int evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
> >  {
> > -     int ncpus = evsel__nr_cpus(evsel);
> > -     int nthreads = perf_thread_map__nr(evsel->core.threads);
> > -
> >       if (evsel__alloc_stat_priv(evsel) < 0 ||
> > -         evsel__alloc_counts(evsel, ncpus, nthreads) < 0 ||
> > -         (alloc_raw && evsel__alloc_prev_raw_counts(evsel, ncpus, nthreads) < 0))
> > +         evsel__alloc_counts(evsel) < 0 ||
> > +         (alloc_raw && evsel__alloc_prev_raw_counts(evsel) < 0))
> >               return -ENOMEM;
> >
> >       return 0;
> > --
> > 2.34.1.448.ga2b2bfdf31-goog
> >
>
