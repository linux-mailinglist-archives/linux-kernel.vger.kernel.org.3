Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE4D4B781E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbiBOUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:42:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiBOUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:42:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87113C084F;
        Tue, 15 Feb 2022 12:42:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A0B1B81C1F;
        Tue, 15 Feb 2022 20:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71678C340EB;
        Tue, 15 Feb 2022 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644957719;
        bh=tIG7X5rT0wa8mR0aKKKndZLT3YNdO9Dy3wvXcVWekxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ua6SqYBkdcsj2+95lfx/BEz1PHJSZIkDSdU7QYYlffqv8DsD6kri8vsafis+csWLI
         /SVSb4Mc1MCqxszYNNKGaWGJk4qzGgEmCRSBulFGZNMzWdLdZGFqxJVsXP8iB09Kk9
         ec0Cxxd6NMgox5cs9NXDj+00X36yJeBgONVOu8VpKz9E/C7wxmuj7hqRddchrOr+MM
         a5pJ6xXraw6W6Lx8GymvUgK+yyCCZOiWOiNvkBLD1CNMdKdtyH5UOJhbjpc14/Gp/q
         ScDRi/kBPljyxUYSDS/YLR+/WpmDQRB2kPZzNlj3A9gzAPWNafrgwTvU/OB1Auxl9G
         r0DQYO3T8ml2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1C5E9400FE; Tue, 15 Feb 2022 17:41:57 -0300 (-03)
Date:   Tue, 15 Feb 2022 17:41:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf: Fix perf_cpu_map__for_each_cpu macro
Message-ID: <YgwQFbHhhYYnOxtx@kernel.org>
References: <20220215153713.31395-1-jolsa@kernel.org>
 <CAP-5=fVytzO7XexSPC7ymgJ01_QfAaK0Ys-0NQ73QzRM8xwgbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVytzO7XexSPC7ymgJ01_QfAaK0Ys-0NQ73QzRM8xwgbA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 15, 2022 at 09:12:57AM -0800, Ian Rogers escreveu:
> On Tue, Feb 15, 2022 at 7:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Tzvetomir Stoyanov reported an issue with using macro
> > perf_cpu_map__for_each_cpu using private perf_cpu object.
> >
> > The issue is caused by recent change that wrapped cpu in struct
> > perf_cpu to distinguish it from cpu indexes. We need to make
> > struct perf_cpu public.
> >
> > Adding simple test for using perf_cpu_map__for_each_cpu
> > macro.
> >
> > Fixes: 6d18804b963b ("perf cpumap: Give CPUs their own type")
> > Reported-by: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/lib/perf/include/internal/cpumap.h |  6 +-----
> >  tools/lib/perf/include/perf/cpumap.h     |  5 +++++
> >  tools/lib/perf/libperf.map               |  1 +
> >  tools/lib/perf/tests/test-cpumap.c       | 11 +++++++++++
> >  4 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > index 581f9ffb4237..1973a18c096b 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -3,11 +3,7 @@
> >  #define __LIBPERF_INTERNAL_CPUMAP_H
> >
> >  #include <linux/refcount.h>
> > -
> > -/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> > -struct perf_cpu {
> > -       int cpu;
> > -};
> > +#include <perf/cpumap.h>
> >
> >  /**
> >   * A sized, reference counted, sorted array of integers representing CPU
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> > index 15b8faafd615..4a2edbdb5e2b 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -7,6 +7,11 @@
> >  #include <stdio.h>
> >  #include <stdbool.h>
> >
> > +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> > +struct perf_cpu {
> > +       int cpu;
> > +};
> > +
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 93696affda2e..6fa0d651576b 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -2,6 +2,7 @@ LIBPERF_0.0.1 {
> >         global:
> >                 libperf_init;
> >                 perf_cpu_map__dummy_new;
> > +               perf_cpu_map__default_new;
> >                 perf_cpu_map__get;
> >                 perf_cpu_map__put;
> >                 perf_cpu_map__new;
> > diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
> > index d39378eaf897..87b0510a556f 100644
> > --- a/tools/lib/perf/tests/test-cpumap.c
> > +++ b/tools/lib/perf/tests/test-cpumap.c
> > @@ -14,6 +14,8 @@ static int libperf_print(enum libperf_print_level level,
> >  int test_cpumap(int argc, char **argv)
> >  {
> >         struct perf_cpu_map *cpus;
> > +       struct perf_cpu cpu;
> > +       int idx;
> >
> >         __T_START;
> >
> > @@ -27,6 +29,15 @@ int test_cpumap(int argc, char **argv)
> >         perf_cpu_map__put(cpus);
> >         perf_cpu_map__put(cpus);
> >
> > +       cpus = perf_cpu_map__default_new();
> > +       if (!cpus)
> > +               return -1;
> > +
> > +       perf_cpu_map__for_each_cpu(cpu, idx, cpus)
> > +               __T("wrong cpu number", cpu.cpu != -1);
> > +
> > +       perf_cpu_map__put(cpus);
> > +
> >         __T_END;
> >         return tests_failed == 0 ? 0 : -1;
> >  }
> > --
> > 2.35.1
> >

-- 

- Arnaldo
