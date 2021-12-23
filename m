Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFD47DFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbhLWHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhLWHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3CC061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so8596455ybf.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8OacQYAYwPbCfIned3XtwIucyM9DBcJ+V45pY7EGNyE=;
        b=De4m7XhqQ1rRQ2n0wBe9DWLTBQt83b00BijY/S0MxhPf2wR/ZiBu9xg+jjE4222+VC
         3L4EfVeQ6fwLtwcOh8hwYN07y14fswg6CL5/Jjx5vwuHseDVd6lDoaSkPidCT6r00DMH
         m3qSe3OckBkq5TqROF2F4JY63NVWICEMY3z6BOa3Op3atBuT6oz30enzg6yJ0ekwU6iy
         BduSX+Q4XXZzwlwzvs8Bsh6SY8U40CBturyrnVQ6z+MpfZaQzg5v2MqnojbenYqpMJ66
         6q0vahE8eeKgPhFuezA8UiwY2LEP4b59MiVTQ7KvwFceDGmYcpm/Pwo7E8ni9zO3Uor5
         D+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8OacQYAYwPbCfIned3XtwIucyM9DBcJ+V45pY7EGNyE=;
        b=ICZtaOOphXqG8sR/SG/sKyBOKGHu9xB2WEUxQgFryIxcuX+dkjQoLyHUp5NCU2HDAE
         /rDOIz7/muvz3tKYze7WvEjzFoQVIdpKilewhaHMwmQIQNPAcvdwuxzOBe2Tz+gvvpXr
         8LmBsxdjMeuF+zEOFMtP7hR+tPF3beEwksZMYqrpVEHs947UN6LJ+4d4Nokj/VArDKcC
         RjjJtvtU3aywvntn67Y1Eq/tiU1jK+u+v1PAqPluhDlXi6lb/aUbsSuPzXPM3eVepyFd
         nJ5nYr7ffT1zkQ6k9FBoWYuSBGu1Yw0OjygoZwYYNz1r46zvm8lP+l3yd3c93VVZWqWV
         uynA==
X-Gm-Message-State: AOAM530cf+vCXS7tOj7etgbVVonD9oIlbx9UoW9UpL73F+IwxnBT/QaI
        EL1yxK5ULxXu9RqVqVJOWoX0DiSIgl8F
X-Google-Smtp-Source: ABdhPJybyDv6HxTsgTHMPa5EgdxcuJbYv7im1j+H596KI0xDBuyOKMeegC0iPetLNIL3mXlPvexX1cq981fI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a5b:f0e:: with SMTP id x14mr1669372ybr.671.1640245568263;
 Wed, 22 Dec 2021 23:46:08 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:44:53 -0800
Message-Id: <20211223074541.3318938-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 00/48] Refactor perf cpumap
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf cpu map has various functions where a cpumap and index are passed
in order to load the cpu. A problem with this is that the wrong index
may be passed for the cpumap, causing problems like aggregation on the
wrong CPU:
https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/

This patch set refactors the cpu map API, reducing it and explicitly
passing the cpu (rather than the pair) to functions that need
it. Comments are added at the same time. Changes modify the same
file/function more than once as refactoring and fixes are broken apart
for the sake of bisection.

v2. Incorproates fixes suggested Jiri Olsa, rewrites the evlist CPU
    iterator in part in a way suggested by Riccardo Mancini. The new
    fixes start at patch 23. The final change was suggested by John
    Garry to make the CPUs have their own struct wrapper.

Ian Rogers (48):
  libperf: Add comments to perf_cpu_map.
  perf stat: Add aggr creators that are passed a cpu.
  perf stat: Correct aggregation CPU map
  perf stat: Switch aggregation to use for_each loop
  perf stat: Switch to cpu version of cpu_map__get
  perf cpumap: Switch cpu_map__build_map to cpu function
  perf cpumap: Remove map+index get_socket
  perf cpumap: Remove map+index get_die
  perf cpumap: Remove map+index get_core
  perf cpumap: Remove map+index get_node
  perf cpumap: Add comments to aggr_cpu_id
  perf cpumap: Remove unused cpu_map__socket
  perf cpumap: Simplify equal function name.
  perf cpumap: Rename empty functions.
  perf cpumap: Document cpu__get_node and remove redundant function
  perf cpumap: Remove map from function names that don't use a map.
  perf cpumap: Remove cpu_map__cpu, use libperf function.
  perf cpumap: Refactor cpu_map__build_map
  perf cpumap: Rename cpu_map__get_X_aggr_by_cpu functions
  perf cpumap: Move 'has' function to libperf
  perf cpumap: Add some comments to cpu_aggr_map
  perf cpumap: Trim the cpu_aggr_map
  perf stat: Fix memory leak in check_per_pkg
  perf cpumap: Add CPU to aggr_cpu_id
  perf stat-display: Avoid use of core for CPU.
  perf evsel: Derive CPUs and threads in alloc_counts
  libperf: Switch cpu to more accurate cpu_map_idx
  libperf: Use cpu not index for evsel mmap
  perf counts: Switch name cpu to cpu_map_idx
  perf stat: Rename aggr_data cpu to imply it's an index
  perf stat: Use perf_cpu_map__for_each_cpu
  perf script: Use for each cpu to aid readability
  libperf: Allow NULL in perf_cpu_map__idx
  perf evlist: Refactor evlist__for_each_cpu.
  perf evsel: Pass cpu not cpu map index to synthesize
  perf stat: Correct variable name for read counter
  perf evsel: Rename CPU around get_group_fd
  perf evsel: Reduce scope of evsel__ignore_missing_thread
  perf evsel: Rename variable cpu to index
  perf test: Use perf_cpu_map__for_each_cpu
  perf stat: Correct check_per_pkg cpu
  perf stat: Swap variable name cpu to index
  libperf: Sync evsel documentation
  perf bpf: Rename cpu to cpu_map_idx
  perf c2c: Use more intention revealing iterator
  perf script: Fix flipped index and cpu
  perf stat: Correct first_shadow_cpu to return index
  perf cpumap: Give CPUs their own type.

 tools/lib/perf/Documentation/libperf.txt      |  10 +-
 tools/lib/perf/cpumap.c                       | 131 +++--
 tools/lib/perf/evlist.c                       |   4 +-
 tools/lib/perf/evsel.c                        |  92 ++--
 tools/lib/perf/include/internal/cpumap.h      |  18 +-
 tools/lib/perf/include/internal/evlist.h      |   3 +-
 tools/lib/perf/include/internal/evsel.h       |   4 +-
 tools/lib/perf/include/internal/mmap.h        |   5 +-
 tools/lib/perf/include/perf/cpumap.h          |   8 +-
 tools/lib/perf/include/perf/evsel.h           |  10 +-
 tools/lib/perf/mmap.c                         |   2 +-
 tools/perf/arch/arm/util/cs-etm.c             |  16 +-
 tools/perf/bench/epoll-ctl.c                  |   2 +-
 tools/perf/bench/epoll-wait.c                 |   2 +-
 tools/perf/bench/futex-hash.c                 |   2 +-
 tools/perf/bench/futex-lock-pi.c              |   2 +-
 tools/perf/bench/futex-requeue.c              |   2 +-
 tools/perf/bench/futex-wake-parallel.c        |   2 +-
 tools/perf/bench/futex-wake.c                 |   2 +-
 tools/perf/builtin-c2c.c                      |  15 +-
 tools/perf/builtin-ftrace.c                   |   2 +-
 tools/perf/builtin-kmem.c                     |   2 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/builtin-sched.c                    |  71 +--
 tools/perf/builtin-script.c                   |  10 +-
 tools/perf/builtin-stat.c                     | 516 +++++++++---------
 tools/perf/tests/attr.c                       |   6 +-
 tools/perf/tests/bitmap.c                     |   2 +-
 tools/perf/tests/cpumap.c                     |   6 +-
 tools/perf/tests/event_update.c               |   6 +-
 tools/perf/tests/mem2node.c                   |   2 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  39 +-
 tools/perf/tests/stat.c                       |   3 +-
 tools/perf/tests/topology.c                   |  43 +-
 tools/perf/util/affinity.c                    |   2 +-
 tools/perf/util/auxtrace.c                    |  12 +-
 tools/perf/util/auxtrace.h                    |   5 +-
 tools/perf/util/bpf_counter.c                 |  16 +-
 tools/perf/util/bpf_counter.h                 |   4 +-
 tools/perf/util/counts.c                      |   8 +-
 tools/perf/util/counts.h                      |  14 +-
 tools/perf/util/cpumap.c                      | 250 ++++-----
 tools/perf/util/cpumap.h                      | 116 ++--
 tools/perf/util/cputopo.c                     |   6 +-
 tools/perf/util/env.c                         |  29 +-
 tools/perf/util/env.h                         |   3 +-
 tools/perf/util/evlist.c                      | 148 ++---
 tools/perf/util/evlist.h                      |  50 +-
 tools/perf/util/evsel.c                       | 143 ++---
 tools/perf/util/evsel.h                       |  27 +-
 tools/perf/util/expr.c                        |   2 +-
 tools/perf/util/header.c                      |   6 +-
 tools/perf/util/mmap.c                        |  19 +-
 tools/perf/util/mmap.h                        |   3 +-
 tools/perf/util/perf_api_probe.c              |  15 +-
 tools/perf/util/python.c                      |   2 +-
 tools/perf/util/record.c                      |  11 +-
 .../scripting-engines/trace-event-python.c    |   6 +-
 tools/perf/util/session.c                     |  10 +-
 tools/perf/util/stat-display.c                | 138 ++---
 tools/perf/util/stat-shadow.c                 | 308 +++++------
 tools/perf/util/stat.c                        |  47 +-
 tools/perf/util/stat.h                        |   9 +-
 tools/perf/util/svghelper.c                   |   6 +-
 tools/perf/util/synthetic-events.c            |  12 +-
 tools/perf/util/synthetic-events.h            |   3 +-
 tools/perf/util/util.h                        |   5 +-
 68 files changed, 1327 insertions(+), 1154 deletions(-)

-- 
2.34.1.307.g9b7440fafd-goog

