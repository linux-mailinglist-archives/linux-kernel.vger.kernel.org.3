Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3A4846AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiADRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiADRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:08:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEAC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 09:08:41 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id o7so43174217ioo.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNWy2s9rz0FLnCuaNfyjnf9kuom2tgn2/ycw/EInc2I=;
        b=pswDZTE8m9o1E7YgwGw4JHpc4nf4cyidZqzTNv0WZv44hV2N12KcXdzYX8OBYBVsSg
         1mt0BMy74iRvSIdmHz18WPLL9UEXG9gcPgQmc3rrlA+AIaaHdZD7Y2G5aC96iLa2BEaW
         ikp5oV3Ir4yr5Rld3A4FSbW4HVPrmXOGKrJ2lj9o0VCkFGM+Z7j7M3ka4JMgCEu511K+
         Y5zyARniP7ovRKZefdS4iMMF/lsR4NrrEZz74gUImD1Rkz+lcjh4mhf6epnvIrfZ7X6V
         GPCYvsYgjBhLcHK5u/BeHJ1As3iASGOVXT51Bl34JmAQ4QLtxDegIXPvNQ4BESPXLe+U
         o1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNWy2s9rz0FLnCuaNfyjnf9kuom2tgn2/ycw/EInc2I=;
        b=6B5friBZnb87O+6MvOPZ73HgUzl1DQ+2shAYHjSIi/EgVapJVcIdYH0AnvMMwDmjBY
         vu1i7bF9k+ci79UBnKbR8PT+3O2qzQYHVTrUKS3+UArfwugzJMqncPwUVg9+bi6JH5qa
         33HOwiQZX3cs0EILl15+ZZvs5pVpJCdgiWGb6lcqlH7CyQwUBXQ0CwejXI+7iY51uvKF
         EzfhovAeal8nGpky+kduMqp0p9b0s02a9wnSyvcS4vik0qZJSwSFa71h8ATdBXmWx87r
         Rs9lvCY03f9CaXF/Q68IFOxx9uRUdA4R9feEJidmyAcqAeXtJZl1TLsdh2FAmQhhtsi5
         sPJw==
X-Gm-Message-State: AOAM5309zTJ03rruFRpdqfN2ObnlMsvQw9h5vuOM3Or9BpRKV4ScCN2t
        dSwuhYQEfW9sJyn9YYh6X/Rr68FtWKxgEOeH0OeNkw==
X-Google-Smtp-Source: ABdhPJzy79VvXhXYiRGwOpMtjUD0yi61E9rAbv6x16EfhG2JnQ9J49w+3y+LnvkZSOQlGOsYp4j9tjfBcqYOadWbkgc=
X-Received: by 2002:a02:294b:: with SMTP id p72mr18328692jap.263.1641316119537;
 Tue, 04 Jan 2022 09:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com> <YdRYk8Ic8qdEAhQz@krava>
In-Reply-To: <YdRYk8Ic8qdEAhQz@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Jan 2022 09:08:27 -0800
Message-ID: <CAP-5=fUbM-miTBqQNhuTdevBF7VMBmd=LH+GxXkP2_z5n9nmtQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/48] Refactor perf cpumap
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

On Tue, Jan 4, 2022 at 6:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Dec 29, 2021 at 11:19:41PM -0800, Ian Rogers wrote:
> > Perf cpu map has various functions where a cpumap and index are passed
> > in order to load the cpu. A problem with this is that the wrong index
> > may be passed for the cpumap, causing problems like aggregation on the
> > wrong CPU:
> > https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/
> >
> > This patch set refactors the cpu map API, reducing it and explicitly
> > passing the cpu (rather than the pair) to functions that need
> > it. Comments are added at the same time. Changes modify the same
> > file/function more than once as refactoring and fixes are broken apart
> > for the sake of bisection.
> >
> > v2. Incorproates fixes suggested Jiri Olsa, rewrites the evlist CPU
> >     iterator in part in a way suggested by Riccardo Mancini. The new
> >     fixes start at patch 23. The final change was suggested by John
> >     Garry to make the CPUs have their own struct wrapper.
> >
> > v3. Incorporates fixes suggested by Namhyung Kim.
> >
> > Ian Rogers (48):
>
> you doubled the amount of patches from v1? ;-)

Ah yes, sorry about that. I wasn't trying to imply you'd reviewed the
new patches but I see where the wording is confusing. I was worried
about the number of patches, but less so after:
https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/
:-)

> I had small comments for the first 22 patches and would be ok
> with them merged.. will try to go through the rest soon

Thanks. The v1 wasn't as complete as I'd have liked and Namhyung had
some feedback to that effect as well (it was great to get feedback to
make sure I wasn't flogging a dead horse). For v4 I see a request to
rename a variable/parameter, which I can do. I'll hold off a bit and
send out a v4 later today hopefully.

Thanks,
Ian

> thanks,
> jirka
>
> >   libperf: Add comments to perf_cpu_map.
> >   perf stat: Add aggr creators that are passed a cpu.
> >   perf stat: Correct aggregation CPU map
> >   perf stat: Switch aggregation to use for_each loop
> >   perf stat: Switch to cpu version of cpu_map__get
> >   perf cpumap: Switch cpu_map__build_map to cpu function
> >   perf cpumap: Remove map+index get_socket
> >   perf cpumap: Remove map+index get_die
> >   perf cpumap: Remove map+index get_core
> >   perf cpumap: Remove map+index get_node
> >   perf cpumap: Add comments to aggr_cpu_id
> >   perf cpumap: Remove unused cpu_map__socket
> >   perf cpumap: Simplify equal function name.
> >   perf cpumap: Rename empty functions.
> >   perf cpumap: Document cpu__get_node and remove redundant function
> >   perf cpumap: Remove map from function names that don't use a map.
> >   perf cpumap: Remove cpu_map__cpu, use libperf function.
> >   perf cpumap: Refactor cpu_map__build_map
> >   perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
> >   perf cpumap: Move 'has' function to libperf
> >   perf cpumap: Add some comments to cpu_aggr_map
> >   perf cpumap: Trim the cpu_aggr_map
> >   perf stat: Fix memory leak in check_per_pkg
> >   perf cpumap: Add CPU to aggr_cpu_id
> >   perf stat-display: Avoid use of core for CPU.
> >   perf evsel: Derive CPUs and threads in alloc_counts
> >   libperf: Switch cpu to more accurate cpu_map_idx
> >   libperf: Use cpu not index for evsel mmap
> >   perf counts: Switch name cpu to cpu_map_idx
> >   perf stat: Rename aggr_data cpu to imply it's an index
> >   perf stat: Use perf_cpu_map__for_each_cpu
> >   perf script: Use for each cpu to aid readability
> >   libperf: Allow NULL in perf_cpu_map__idx
> >   perf evlist: Refactor evlist__for_each_cpu.
> >   perf evsel: Pass cpu not cpu map index to synthesize
> >   perf stat: Correct variable name for read counter
> >   perf evsel: Rename CPU around get_group_fd
> >   perf evsel: Reduce scope of evsel__ignore_missing_thread
> >   perf evsel: Rename variable cpu to index
> >   perf test: Use perf_cpu_map__for_each_cpu
> >   perf stat: Correct check_per_pkg cpu
> >   perf stat: Swap variable name cpu to index
> >   libperf: Sync evsel documentation
> >   perf bpf: Rename cpu to cpu_map_idx
> >   perf c2c: Use more intention revealing iterator
> >   perf script: Fix flipped index and cpu
> >   perf stat: Correct first_shadow_cpu to return index
> >   perf cpumap: Give CPUs their own type.
> >
> >  tools/lib/perf/Documentation/libperf.txt      |  11 +-
> >  tools/lib/perf/cpumap.c                       | 131 +++--
> >  tools/lib/perf/evlist.c                       |   4 +-
> >  tools/lib/perf/evsel.c                        |  92 ++--
> >  tools/lib/perf/include/internal/cpumap.h      |  18 +-
> >  tools/lib/perf/include/internal/evlist.h      |   3 +-
> >  tools/lib/perf/include/internal/evsel.h       |   4 +-
> >  tools/lib/perf/include/internal/mmap.h        |   5 +-
> >  tools/lib/perf/include/perf/cpumap.h          |   8 +-
> >  tools/lib/perf/include/perf/evsel.h           |  10 +-
> >  tools/lib/perf/libperf.map                    |   1 +
> >  tools/lib/perf/mmap.c                         |   2 +-
> >  tools/perf/arch/arm/util/cs-etm.c             |  16 +-
> >  tools/perf/bench/epoll-ctl.c                  |   2 +-
> >  tools/perf/bench/epoll-wait.c                 |   2 +-
> >  tools/perf/bench/futex-hash.c                 |   2 +-
> >  tools/perf/bench/futex-lock-pi.c              |   2 +-
> >  tools/perf/bench/futex-requeue.c              |   2 +-
> >  tools/perf/bench/futex-wake-parallel.c        |   2 +-
> >  tools/perf/bench/futex-wake.c                 |   2 +-
> >  tools/perf/builtin-c2c.c                      |  15 +-
> >  tools/perf/builtin-ftrace.c                   |   2 +-
> >  tools/perf/builtin-kmem.c                     |   2 +-
> >  tools/perf/builtin-record.c                   |   2 +-
> >  tools/perf/builtin-sched.c                    |  71 +--
> >  tools/perf/builtin-script.c                   |  10 +-
> >  tools/perf/builtin-stat.c                     | 516 +++++++++---------
> >  tools/perf/tests/attr.c                       |   6 +-
> >  tools/perf/tests/bitmap.c                     |   2 +-
> >  tools/perf/tests/cpumap.c                     |   6 +-
> >  tools/perf/tests/event_update.c               |   6 +-
> >  tools/perf/tests/mem2node.c                   |   2 +-
> >  tools/perf/tests/mmap-basic.c                 |   4 +-
> >  tools/perf/tests/openat-syscall-all-cpus.c    |  39 +-
> >  tools/perf/tests/stat.c                       |   3 +-
> >  tools/perf/tests/topology.c                   |  43 +-
> >  tools/perf/util/affinity.c                    |   2 +-
> >  tools/perf/util/auxtrace.c                    |  12 +-
> >  tools/perf/util/auxtrace.h                    |   5 +-
> >  tools/perf/util/bpf_counter.c                 |  16 +-
> >  tools/perf/util/bpf_counter.h                 |   4 +-
> >  tools/perf/util/counts.c                      |   8 +-
> >  tools/perf/util/counts.h                      |  14 +-
> >  tools/perf/util/cpumap.c                      | 253 ++++-----
> >  tools/perf/util/cpumap.h                      | 116 ++--
> >  tools/perf/util/cputopo.c                     |   6 +-
> >  tools/perf/util/env.c                         |  29 +-
> >  tools/perf/util/env.h                         |   3 +-
> >  tools/perf/util/evlist.c                      | 148 ++---
> >  tools/perf/util/evlist.h                      |  50 +-
> >  tools/perf/util/evsel.c                       | 143 ++---
> >  tools/perf/util/evsel.h                       |  27 +-
> >  tools/perf/util/expr.c                        |   2 +-
> >  tools/perf/util/header.c                      |   6 +-
> >  tools/perf/util/mmap.c                        |  19 +-
> >  tools/perf/util/mmap.h                        |   3 +-
> >  tools/perf/util/perf_api_probe.c              |  15 +-
> >  tools/perf/util/python.c                      |   4 +-
> >  tools/perf/util/record.c                      |  11 +-
> >  .../scripting-engines/trace-event-python.c    |   6 +-
> >  tools/perf/util/session.c                     |  10 +-
> >  tools/perf/util/stat-display.c                | 138 ++---
> >  tools/perf/util/stat-shadow.c                 | 308 +++++------
> >  tools/perf/util/stat.c                        |  47 +-
> >  tools/perf/util/stat.h                        |   9 +-
> >  tools/perf/util/svghelper.c                   |   6 +-
> >  tools/perf/util/synthetic-events.c            |  12 +-
> >  tools/perf/util/synthetic-events.h            |   3 +-
> >  tools/perf/util/util.h                        |   5 +-
> >  69 files changed, 1333 insertions(+), 1155 deletions(-)
> >
> > --
> > 2.34.1.448.ga2b2bfdf31-goog
> >
>
