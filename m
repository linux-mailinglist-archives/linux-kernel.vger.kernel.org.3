Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F219B473739
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbhLMWG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbhLMWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:06:55 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D76C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:06:55 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id s11so16297038ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTPn8auGutn38LvbgcksVlp70zD3zIxdnxqFAr/xw18=;
        b=UdsKx5QAwKAV6vhCEmgcG/KiXBU89WcrU9K87mz06/QwqRIxE2MRNPdp90VlGq1K6q
         1Q1FdyAzVQIIGrHmuR48JEDsdFZETrOFmhKpC7Q7LesjrCsCsGwQmKHDC5hQaOb6xWzz
         vAbkXts4r8QbWQHBtlC0bFOkwTKcomEu2zjuT2ocTCQe2t/wPooUm7rE5qhpNjCdWYPP
         D35i0fu9ijrF0q1COAKePyofG5XwTOtInwbIP/pijUrbOfbt43UEiWIRGLhbxWw1r/N/
         VFdnegr3b5dQqqQpW1z6v7MMH3OnhGGIt9hPgwKGyHaADtKEAw3x5XDDB+w43aN/8G7b
         0AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTPn8auGutn38LvbgcksVlp70zD3zIxdnxqFAr/xw18=;
        b=gk3FOKQy0AZtkovSmI4ppROAuDQJtIXgsEccgvAzG0JgtqNqb7H1cwVXWbrYASY8+G
         KDKlg/rknhpU7bO0suwaF3lVWqYO4RvMMCuFfRyKK384Fdu/pRwnXhU63iGd2WQdVMLY
         HIz5CC4TLFDVIyoeafbIh7CecO9BbC8w9jdGEB88lqHl0tydoNvv0MM3vAWxLFXTtQ7w
         nPtEyIkSVwHxaF3nUyAs8w8exQ4D/wwnrnci5Ousyyi8MIxxh/UMcAPonN7DKTxb2esx
         By97+hSmXExlwYGGe2eJlEjbKDmnifukZb0npY6VSgyPxGV/gBy0gjxDIK5LtBGfrSM/
         rErw==
X-Gm-Message-State: AOAM531GAUewH9+Hdg5OQgVcXnhUrRvK+xMhBi7PUDpJ9Gd+SdVkLbnP
        upYwO7+f/iqxuBay4bd6YA8wb0CLOHMzpGh8rPY6OQ==
X-Google-Smtp-Source: ABdhPJyhSyitxMBa16ebH4CTLm7N7+9UX1SAFoyjyVTUuKqfFMLJg1lVmWnS1g/w6yifUHT3I1BSdBZH/ytTfpR/FOw=
X-Received: by 2002:a05:6e02:168a:: with SMTP id f10mr904394ila.2.1639433214840;
 Mon, 13 Dec 2021 14:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com> <c0c88d24-a609-bf4a-ec23-dfe555ab9cfc@arm.com>
 <CAP-5=fVHNqHym1xNCx_WhmUWHEWa9MDW9QAdOhkLGXuD6+0bqA@mail.gmail.com>
In-Reply-To: <CAP-5=fVHNqHym1xNCx_WhmUWHEWa9MDW9QAdOhkLGXuD6+0bqA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Dec 2021 14:06:43 -0800
Message-ID: <CAP-5=fWkJdW3Jr1NX115=nWdGhUvPMbMzi5fZZ0-REUSq-bkig@mail.gmail.com>
Subject: Re: [PATCH 00/22] Refactor perf cpumap
To:     James Clark <james.clark@arm.com>
Cc:     eranian@google.com, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
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
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 8:10 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Dec 13, 2021 at 3:39 AM James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 08/12/2021 02:45, Ian Rogers wrote:
> > > Perf cpu map has various functions where a cpumap and index are passed
> > > in order to load the cpu. A problem with this is that the wrong index
> > > may be passed for the cpumap, causing problems like aggregation on the
> > > wrong CPU:
> > > https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/
> > >
> > > This patch set refactors the cpu map API, greatly reducing it and
> > > explicitly passing the cpu (rather than the pair) to functions that
> > > need it. Comments are added at the same time.
> > >
> > > Ian Rogers (22):
> > >   libperf: Add comments to perf_cpu_map.
> > >   perf stat: Add aggr creators that are passed a cpu.
> > >   perf stat: Switch aggregation to use for_each loop
> > >   perf stat: Switch to cpu version of cpu_map__get
> > >   perf cpumap: Switch cpu_map__build_map to cpu function
> > >   perf cpumap: Remove map+index get_socket
> > >   perf cpumap: Remove map+index get_die
> > >   perf cpumap: Remove map+index get_core
> > >   perf cpumap: Remove map+index get_node
> > >   perf cpumap: Add comments to aggr_cpu_id
> > >   perf cpumap: Remove unused cpu_map__socket
> > >   perf cpumap: Simplify equal function name.
> > >   perf cpumap: Rename empty functions.
> > >   perf cpumap: Document cpu__get_node and remove redundant function
> > >   perf cpumap: Remove map from function names that don't use a map.
> > >   perf cpumap: Remove cpu_map__cpu, use libperf function.
> > >   perf cpumap: Refactor cpu_map__build_map
> > >   perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
> > >   perf cpumap: Move 'has' function to libperf
> > >   perf cpumap: Add some comments to cpu_aggr_map
> > >   perf cpumap: Trim the cpu_aggr_map
> > >   perf stat: Fix memory leak in check_per_pkg
> > >
> > >  tools/lib/perf/cpumap.c                  |   7 +-
> > >  tools/lib/perf/include/internal/cpumap.h |   9 +-
> > >  tools/lib/perf/include/perf/cpumap.h     |   1 +
> > >  tools/perf/arch/arm/util/cs-etm.c        |  16 +-
> > >  tools/perf/builtin-ftrace.c              |   2 +-
> > >  tools/perf/builtin-sched.c               |   6 +-
> > >  tools/perf/builtin-stat.c                | 273 ++++++++++++-----------
> > >  tools/perf/tests/topology.c              |  10 +-
> > >  tools/perf/util/cpumap.c                 | 182 ++++++---------
> > >  tools/perf/util/cpumap.h                 | 102 ++++++---
> > >  tools/perf/util/cputopo.c                |   2 +-
> > >  tools/perf/util/env.c                    |   6 +-
> > >  tools/perf/util/stat-display.c           |  69 +++---
> > >  tools/perf/util/stat.c                   |   9 +-
> > >  tools/perf/util/stat.h                   |   3 +-
> > >  15 files changed, 361 insertions(+), 336 deletions(-)
> > >
> >
> > For the whole set:
> >
> > Reviewed-by: James Clark <james.clark@arm.com>
> >
> > I didn't see any obvious issues with mixing up aggregation modes or CPU/idx types. Also
> > gave perf stat a test in the different modes and didn't see an issue.
> >
> > But I'm wondering if it's possible to go further and add a struct around the CPU int so that the
> > compiler checks for correctness instead. It still seems quite easy to mix up index and
> > CPU, for example these functions are subtly different, but both use int:
> >
> >   LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
> >   LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, int cpu);
> >
> > Something like this would make it impossible to make a mistake:
> >
> >   struct cpu { int cpu };
> >
> > I mean it's more of a coincidence that CPUs can be identified by an integer, but they are more
> > of an object than an integer, so it could make sense to wrap it. But maybe it could be quite
> > cumbersome to use and be overkill.
>
> Thanks James! I am working on a v2 patch set and will have a go at
> adding this to the end.
>
> Ian

I was checking on the style issues around wrapping an int with a
struct, and it is preferred style to enforce strict type checking (by
way of an old post):
https://lore.kernel.org/all/ancug3$iq1$1@penguin.transmeta.com/

Thanks,
Ian
