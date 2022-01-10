Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B870B489FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiAJTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:02:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57318 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiAJTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:02:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D09226137C;
        Mon, 10 Jan 2022 19:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CC8C36AE9;
        Mon, 10 Jan 2022 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641841371;
        bh=RmpsKia0UwU+uVAs7PdMJIIEidr93n4JdcwbmI8knMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lTA+XHHdVGeefCjNe98KkbNTRWbpDQ6nc6sNMfTJm3zPYHqbtM3TnoywCZsvQ4PII
         LZpDW7/b46rXhnl/VSlyGYoshj3oRuRHvf9P0lS2XqGKKdoqH6PUMhGMW6F3flS3/P
         ToVLfsmW71w1Uel+H0ZmCc3jK02yto1+jfJbVSddob/zU8L16MWaBCsQCkRy5aPEuV
         KI0Rcgoqh+mCart1n0vlJzwiMeJRnbpCV0VZHHxYXGhoecGMXxQenM9xB+VVC/TjrI
         6gqbzrFCP9zb+MhvM9Z+jjhlEX+naWiRA2QmdVUv8ho+pB63q/slzpMgMmYc2TVTzQ
         KTi7yOp3c/edw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 145B040B92; Mon, 10 Jan 2022 16:02:49 -0300 (-03)
Date:   Mon, 10 Jan 2022 16:02:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
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
Subject: Re: [PATCH v4 17/48] perf cpumap: Remove cpu_map__cpu, use libperf
 function.
Message-ID: <YdyC2VdqizF6prb4@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-18-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105061351.120843-18-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 04, 2022 at 10:13:20PM -0800, Ian Rogers escreveu:
> Switch the remaining few users of cpu_map__cpu to perf_cpu_map__cpu and
> remove the function.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

util/bpf_ftrace.c: In function ‘perf_ftrace__latency_prepare_bpf’:
util/bpf_ftrace.c:66:31: error: implicit declaration of function ‘cpu_map__cpu’; did you mean ‘cpu_map__has’? [-Werror=implicit-function-declaration]
   66 |                         cpu = cpu_map__cpu(ftrace->evlist->core.cpus, i);
      |                               ^~~~~~~~~~~~
      |                               cpu_map__has
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_ftrace.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/build/perf/ui/browsers/perf-in.o
  LD      /tmp/build/perf/ui/perf-in.o
  LD      /tmp/build/perf/util/scripting-engines/perf-in.o
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

   163,635,422,196      cycles:u                                                    
   213,602,262,800      instructions:u            #    1.31  insn per cycle         

       3.804738555 seconds time elapsed

      40.622581000 seconds user
       6.589980000 seconds sys


⬢[acme@toolbox perf]$ git log --oneline -1
dfe103e757aeff79 (HEAD) perf cpumap: Remove cpu_map__cpu, use libperf function.

This is the first breakage, trying to fix now.

> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  tools/perf/util/cpumap.c    | 9 ++-------
>  tools/perf/util/cpumap.h    | 1 -
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 2b54e2ddc80a..f16c39a37a52 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -281,7 +281,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
>  	int ret;
>  	int last_cpu;
>  
> -	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
> +	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1);
>  	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
>  	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
>  
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index e0d7f1da5858..32f9fc2dd389 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -485,11 +485,6 @@ bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
>  	return perf_cpu_map__idx(cpus, cpu) != -1;
>  }
>  
> -int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
> -{
> -	return cpus->map[idx];
> -}
> -
>  size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
>  {
>  	int i, cpu, start = -1;
> @@ -547,7 +542,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
>  	int i, cpu;
>  	char *ptr = buf;
>  	unsigned char *bitmap;
> -	int last_cpu = cpu_map__cpu(map, map->nr - 1);
> +	int last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
>  
>  	if (buf == NULL)
>  		return 0;
> @@ -559,7 +554,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
>  	}
>  
>  	for (i = 0; i < map->nr; i++) {
> -		cpu = cpu_map__cpu(map, i);
> +		cpu = perf_cpu_map__cpu(map, i);
>  		bitmap[cpu / 8] |= 1 << (cpu % 8);
>  	}
>  
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index a053bf31a3f0..87545bcd461d 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -80,7 +80,6 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
>  		       struct aggr_cpu_id (*f)(int cpu, void *data),
>  		       void *data);
>  
> -int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
>  bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
>  
>  bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
> -- 
> 2.34.1.448.ga2b2bfdf31-goog

-- 

- Arnaldo
