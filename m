Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1E9484347
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiADOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234134AbiADOYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dM1F6qoiVaYI4ADnvBDdiXq0Zt5MaPOBzlXJBM5Gb9E=;
        b=eT8IM4eaGSlkiIuewYjswvGor2y94+X10rTOg3W2VqwiWa/64Wy91B1qGYR4VPIBxTvRIP
        K1FjMqB6+tnrw5Q4dJTltpU3N800Nq1TVSVMRTBIDxm+bNLizQ3EgHZ4oFxw60N+DtBdXS
        0mapni7Qiwu/AbXJaK2yUTgnCf/53hA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117--7uBPfx8NfSoVVgDXx7Usw-1; Tue, 04 Jan 2022 09:24:23 -0500
X-MC-Unique: -7uBPfx8NfSoVVgDXx7Usw-1
Received: by mail-ed1-f69.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so17575611edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dM1F6qoiVaYI4ADnvBDdiXq0Zt5MaPOBzlXJBM5Gb9E=;
        b=1SDR2bcq/neURCitauD3QliTFNxiHnIDKe22ORPQFqUyCZ3qa0BJcD2rXwwT2c4XHO
         xouzJhRfOPG1HYQD7s1QQFi557ogvNNvPlzJ9bW/VFz4AfyRArmHswCxaFEq1ZV2HtUF
         NE22f6XekJgfRqsilFo2SJJasGwpYrIoIr4QFmWCp/GnPCEbBA7/aif8qbGFNr5Y5ZLB
         bEiNwGlQ1vxRD+LguLemPFOHpuNQlM+T1Yqe5ZXb9lxYgleuq0Sl/LKDs5TS2peP3FER
         ziKt+jn99Iggv5r+gk8kuiunHbOVwVh0y8WFPWZ1ksXjjdLpMgdIs5+gB4A3JFQJnfmj
         svDQ==
X-Gm-Message-State: AOAM532ElLMt2YxfZ767g4Jx9FmP2QenND1wLUFjdMCPO40Ce9zSR+Gk
        TFjTMQf2J0v7Eub+3eRKmejy4AaORUv4DZRG4fZUyE48Oesa8gEmMl4hv9dP38H/D87RGIEFGAU
        YJFQekFaEMHgB/tVIOqbnty4N
X-Received: by 2002:aa7:d541:: with SMTP id u1mr47339037edr.205.1641306262450;
        Tue, 04 Jan 2022 06:24:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzw9wzoxcnORfE/LPWG+FUsrExlT5v7UijsBdx7gPIM2dLh5/0RyKFGMqN97cPFLqSVQJhtQw==
X-Received: by 2002:aa7:d541:: with SMTP id u1mr47339018edr.205.1641306262234;
        Tue, 04 Jan 2022 06:24:22 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id la7sm8984414ejc.94.2022.01.04.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:24:21 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:24:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v3 00/48] Refactor perf cpumap
Message-ID: <YdRYk8Ic8qdEAhQz@krava>
References: <20211230072030.302559-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 11:19:41PM -0800, Ian Rogers wrote:
> Perf cpu map has various functions where a cpumap and index are passed
> in order to load the cpu. A problem with this is that the wrong index
> may be passed for the cpumap, causing problems like aggregation on the
> wrong CPU:
> https://lore.kernel.org/lkml/20211204023409.969668-1-irogers@google.com/
> 
> This patch set refactors the cpu map API, reducing it and explicitly
> passing the cpu (rather than the pair) to functions that need
> it. Comments are added at the same time. Changes modify the same
> file/function more than once as refactoring and fixes are broken apart
> for the sake of bisection.
> 
> v2. Incorproates fixes suggested Jiri Olsa, rewrites the evlist CPU
>     iterator in part in a way suggested by Riccardo Mancini. The new
>     fixes start at patch 23. The final change was suggested by John
>     Garry to make the CPUs have their own struct wrapper.
> 
> v3. Incorporates fixes suggested by Namhyung Kim.
> 
> Ian Rogers (48):

you doubled the amount of patches from v1? ;-)

I had small comments for the first 22 patches and would be ok
with them merged.. will try to go through the rest soon

thanks,
jirka

>   libperf: Add comments to perf_cpu_map.
>   perf stat: Add aggr creators that are passed a cpu.
>   perf stat: Correct aggregation CPU map
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
>   perf cpumap: Add CPU to aggr_cpu_id
>   perf stat-display: Avoid use of core for CPU.
>   perf evsel: Derive CPUs and threads in alloc_counts
>   libperf: Switch cpu to more accurate cpu_map_idx
>   libperf: Use cpu not index for evsel mmap
>   perf counts: Switch name cpu to cpu_map_idx
>   perf stat: Rename aggr_data cpu to imply it's an index
>   perf stat: Use perf_cpu_map__for_each_cpu
>   perf script: Use for each cpu to aid readability
>   libperf: Allow NULL in perf_cpu_map__idx
>   perf evlist: Refactor evlist__for_each_cpu.
>   perf evsel: Pass cpu not cpu map index to synthesize
>   perf stat: Correct variable name for read counter
>   perf evsel: Rename CPU around get_group_fd
>   perf evsel: Reduce scope of evsel__ignore_missing_thread
>   perf evsel: Rename variable cpu to index
>   perf test: Use perf_cpu_map__for_each_cpu
>   perf stat: Correct check_per_pkg cpu
>   perf stat: Swap variable name cpu to index
>   libperf: Sync evsel documentation
>   perf bpf: Rename cpu to cpu_map_idx
>   perf c2c: Use more intention revealing iterator
>   perf script: Fix flipped index and cpu
>   perf stat: Correct first_shadow_cpu to return index
>   perf cpumap: Give CPUs their own type.
> 
>  tools/lib/perf/Documentation/libperf.txt      |  11 +-
>  tools/lib/perf/cpumap.c                       | 131 +++--
>  tools/lib/perf/evlist.c                       |   4 +-
>  tools/lib/perf/evsel.c                        |  92 ++--
>  tools/lib/perf/include/internal/cpumap.h      |  18 +-
>  tools/lib/perf/include/internal/evlist.h      |   3 +-
>  tools/lib/perf/include/internal/evsel.h       |   4 +-
>  tools/lib/perf/include/internal/mmap.h        |   5 +-
>  tools/lib/perf/include/perf/cpumap.h          |   8 +-
>  tools/lib/perf/include/perf/evsel.h           |  10 +-
>  tools/lib/perf/libperf.map                    |   1 +
>  tools/lib/perf/mmap.c                         |   2 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  16 +-
>  tools/perf/bench/epoll-ctl.c                  |   2 +-
>  tools/perf/bench/epoll-wait.c                 |   2 +-
>  tools/perf/bench/futex-hash.c                 |   2 +-
>  tools/perf/bench/futex-lock-pi.c              |   2 +-
>  tools/perf/bench/futex-requeue.c              |   2 +-
>  tools/perf/bench/futex-wake-parallel.c        |   2 +-
>  tools/perf/bench/futex-wake.c                 |   2 +-
>  tools/perf/builtin-c2c.c                      |  15 +-
>  tools/perf/builtin-ftrace.c                   |   2 +-
>  tools/perf/builtin-kmem.c                     |   2 +-
>  tools/perf/builtin-record.c                   |   2 +-
>  tools/perf/builtin-sched.c                    |  71 +--
>  tools/perf/builtin-script.c                   |  10 +-
>  tools/perf/builtin-stat.c                     | 516 +++++++++---------
>  tools/perf/tests/attr.c                       |   6 +-
>  tools/perf/tests/bitmap.c                     |   2 +-
>  tools/perf/tests/cpumap.c                     |   6 +-
>  tools/perf/tests/event_update.c               |   6 +-
>  tools/perf/tests/mem2node.c                   |   2 +-
>  tools/perf/tests/mmap-basic.c                 |   4 +-
>  tools/perf/tests/openat-syscall-all-cpus.c    |  39 +-
>  tools/perf/tests/stat.c                       |   3 +-
>  tools/perf/tests/topology.c                   |  43 +-
>  tools/perf/util/affinity.c                    |   2 +-
>  tools/perf/util/auxtrace.c                    |  12 +-
>  tools/perf/util/auxtrace.h                    |   5 +-
>  tools/perf/util/bpf_counter.c                 |  16 +-
>  tools/perf/util/bpf_counter.h                 |   4 +-
>  tools/perf/util/counts.c                      |   8 +-
>  tools/perf/util/counts.h                      |  14 +-
>  tools/perf/util/cpumap.c                      | 253 ++++-----
>  tools/perf/util/cpumap.h                      | 116 ++--
>  tools/perf/util/cputopo.c                     |   6 +-
>  tools/perf/util/env.c                         |  29 +-
>  tools/perf/util/env.h                         |   3 +-
>  tools/perf/util/evlist.c                      | 148 ++---
>  tools/perf/util/evlist.h                      |  50 +-
>  tools/perf/util/evsel.c                       | 143 ++---
>  tools/perf/util/evsel.h                       |  27 +-
>  tools/perf/util/expr.c                        |   2 +-
>  tools/perf/util/header.c                      |   6 +-
>  tools/perf/util/mmap.c                        |  19 +-
>  tools/perf/util/mmap.h                        |   3 +-
>  tools/perf/util/perf_api_probe.c              |  15 +-
>  tools/perf/util/python.c                      |   4 +-
>  tools/perf/util/record.c                      |  11 +-
>  .../scripting-engines/trace-event-python.c    |   6 +-
>  tools/perf/util/session.c                     |  10 +-
>  tools/perf/util/stat-display.c                | 138 ++---
>  tools/perf/util/stat-shadow.c                 | 308 +++++------
>  tools/perf/util/stat.c                        |  47 +-
>  tools/perf/util/stat.h                        |   9 +-
>  tools/perf/util/svghelper.c                   |   6 +-
>  tools/perf/util/synthetic-events.c            |  12 +-
>  tools/perf/util/synthetic-events.h            |   3 +-
>  tools/perf/util/util.h                        |   5 +-
>  69 files changed, 1333 insertions(+), 1155 deletions(-)
> 
> -- 
> 2.34.1.448.ga2b2bfdf31-goog
> 

