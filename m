Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAF472BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhLMLjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:39:40 -0500
Received: from foss.arm.com ([217.140.110.172]:52630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236352AbhLMLjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:39:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3F3D6E;
        Mon, 13 Dec 2021 03:39:35 -0800 (PST)
Received: from [10.57.34.21] (unknown [10.57.34.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D894E3F793;
        Mon, 13 Dec 2021 03:39:31 -0800 (PST)
Subject: Re: [PATCH 00/22] Refactor perf cpumap
To:     Ian Rogers <irogers@google.com>
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
References: <20211208024607.1784932-1-irogers@google.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <c0c88d24-a609-bf4a-ec23-dfe555ab9cfc@arm.com>
Date:   Mon, 13 Dec 2021 11:39:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/12/2021 02:45, Ian Rogers wrote:
> Perf cpu map has various functions where a cpumap and index are passed
> in order to load the cpu. A problem with this is that the wrong index
> may be passed for the cpumap, causing problems like aggregation on the
> wrong CPU:
> https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/
> 
> This patch set refactors the cpu map API, greatly reducing it and
> explicitly passing the cpu (rather than the pair) to functions that
> need it. Comments are added at the same time.
> 
> Ian Rogers (22):
>   libperf: Add comments to perf_cpu_map.
>   perf stat: Add aggr creators that are passed a cpu.
>   perf stat: Switch aggregation to use for_each loop
>   perf stat: Switch to cpu version of cpu_map__get
>   perf cpumap: Switch cpu_map__build_map to cpu function
>   perf cpumap: Remove map+index get_socket
>   perf cpumap: Remove map+index get_die
>   perf cpumap: Remove map+index get_core
>   perf cpumap: Remove map+index get_node
>   perf cpumap: Add comments to aggr_cpu_id
>   perf cpumap: Remove unused cpu_map__socket
>   perf cpumap: Simplify equal function name.
>   perf cpumap: Rename empty functions.
>   perf cpumap: Document cpu__get_node and remove redundant function
>   perf cpumap: Remove map from function names that don't use a map.
>   perf cpumap: Remove cpu_map__cpu, use libperf function.
>   perf cpumap: Refactor cpu_map__build_map
>   perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
>   perf cpumap: Move 'has' function to libperf
>   perf cpumap: Add some comments to cpu_aggr_map
>   perf cpumap: Trim the cpu_aggr_map
>   perf stat: Fix memory leak in check_per_pkg
> 
>  tools/lib/perf/cpumap.c                  |   7 +-
>  tools/lib/perf/include/internal/cpumap.h |   9 +-
>  tools/lib/perf/include/perf/cpumap.h     |   1 +
>  tools/perf/arch/arm/util/cs-etm.c        |  16 +-
>  tools/perf/builtin-ftrace.c              |   2 +-
>  tools/perf/builtin-sched.c               |   6 +-
>  tools/perf/builtin-stat.c                | 273 ++++++++++++-----------
>  tools/perf/tests/topology.c              |  10 +-
>  tools/perf/util/cpumap.c                 | 182 ++++++---------
>  tools/perf/util/cpumap.h                 | 102 ++++++---
>  tools/perf/util/cputopo.c                |   2 +-
>  tools/perf/util/env.c                    |   6 +-
>  tools/perf/util/stat-display.c           |  69 +++---
>  tools/perf/util/stat.c                   |   9 +-
>  tools/perf/util/stat.h                   |   3 +-
>  15 files changed, 361 insertions(+), 336 deletions(-)
> 

For the whole set:

Reviewed-by: James Clark <james.clark@arm.com>

I didn't see any obvious issues with mixing up aggregation modes or CPU/idx types. Also
gave perf stat a test in the different modes and didn't see an issue.

But I'm wondering if it's possible to go further and add a struct around the CPU int so that the
compiler checks for correctness instead. It still seems quite easy to mix up index and
CPU, for example these functions are subtly different, but both use int:

  LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, int cpu);

Something like this would make it impossible to make a mistake:

  struct cpu { int cpu };

I mean it's more of a coincidence that CPUs can be identified by an integer, but they are more
of an object than an integer, so it could make sense to wrap it. But maybe it could be quite
cumbersome to use and be overkill.

