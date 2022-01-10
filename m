Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD6489FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiAJTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbiAJTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:10:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495D3C06173F;
        Mon, 10 Jan 2022 11:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA6D0B817D2;
        Mon, 10 Jan 2022 19:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49571C36AE3;
        Mon, 10 Jan 2022 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641841848;
        bh=BviR9AO948+AxEkZi8lpYCUTy13tfIVuc/eANGIUeEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/QnIhXhIHqSauopd2gNKW9XvMT3qoUcZX/c2g3qnHE72XVsJtJOlm6vBB6dpcbns
         yDcvXGxnvxj9j8gsu2YmlTRXxI0hOdf+ot+mDer4FQAEJyXg3YDJs5XhK/Hk00FbQH
         Kng7yVCAVAjjDBai8M1/Efis+ybbRGBNTJx0RL5N1CyP6Bj+2TNVS93da7xrzBsmRr
         UozYg79DH5eZIhULtrjQoY8jQop+7GJLFx1ecZV+nkSOdWeTvg8fWMghWJ5J4uQSnJ
         5asQt57ymcijQ6FEYT6nFEbaPYd2WKcGmyObUtbuZOHsXJ0NzoHGa14JiJCuGWylca
         Lu3zVevaOiHvg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 64D7B40B92; Mon, 10 Jan 2022 16:10:46 -0300 (-03)
Date:   Mon, 10 Jan 2022 16:10:46 -0300
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
Subject: Re: [PATCH v4 44/48] perf bpf: Rename cpu to cpu_map_idx
Message-ID: <YdyEtsLxsZM09y8O@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-45-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220105061351.120843-45-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 04, 2022 at 10:13:47PM -0800, Ian Rogers escreveu:
> Synchronize the caller in evsel with the called function.
> Shorten 3 lines of code in bperf_read by using
> perf_cpu_map__for_each_cpu.
> This code is frequently using variables named cpu as cpu map indices,
> which doesn't matter as all CPUs are in the CPU map. It is strange in
> some cases the cpumap is used at all.

  CC      /tmp/build/perf/builtin-stat.o
  INSTALL trace_plugins
  CC      /tmp/build/perf/util/evlist.o
  CC      /tmp/build/perf/util/evsel.o
  CC      /tmp/build/perf/util/header.o
  CC      /tmp/build/perf/util/bpf_counter.o
  CC      /tmp/build/perf/util/bpf_counter_cgroup.o
  CC      /tmp/build/perf/util/bpf_ftrace.o
In file included from util/cpumap.h:8,
                 from util/bpf_counter.c:23:
util/bpf_counter.c: In function ‘bperf__read’:
/var/home/acme/git/perf/tools/lib/perf/include/perf/cpumap.h:27:20: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
   27 |              (idx) < perf_cpu_map__nr(cpus);                    \
      |                    ^
util/bpf_counter.c:626:25: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
  626 |                         perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
util/bpf_counter.c:611:21: error: unused variable ‘num_cpu’ [-Werror=unused-variable]
  611 |         __u32 i, j, num_cpu;
      |                     ^~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

    15,589,752,360      cycles:u
    28,227,862,710      instructions:u            #    1.81  insn per cycle

       1.996638375 seconds time elapsed

       3.567457000 seconds user
       0.934840000 seconds sys


⬢[acme@toolbox perf]$ git log --oneline -1
0083ba4c6a931fd0 (HEAD) perf bpf: Rename cpu to cpu_map_idx
⬢[acme@toolbox perf]$

Trying to fix...
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf_counter.c | 16 +++++++---------
>  tools/perf/util/bpf_counter.h |  4 ++--
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index c17d4a43ce06..ae5bd87ff020 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -265,7 +265,7 @@ static int bpf_program_profiler__read(struct evsel *evsel)
>  	return 0;
>  }
>  
> -static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx,
>  					    int fd)
>  {
>  	struct bpf_prog_profiler_bpf *skel;
> @@ -277,7 +277,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
>  		assert(skel != NULL);
>  
>  		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> -					  &cpu, &fd, BPF_ANY);
> +					  &cpu_map_idx, &fd, BPF_ANY);
>  		if (ret)
>  			return ret;
>  	}
> @@ -566,12 +566,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
>  	return err;
>  }
>  
> -static int bperf__install_pe(struct evsel *evsel, int cpu, int fd)
> +static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
>  {
>  	struct bperf_leader_bpf *skel = evsel->leader_skel;
>  
>  	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> -				   &cpu, &fd, BPF_ANY);
> +				   &cpu_map_idx, &fd, BPF_ANY);
>  }
>  
>  /*
> @@ -623,9 +623,7 @@ static int bperf__read(struct evsel *evsel)
>  		case BPERF_FILTER_GLOBAL:
>  			assert(i == 0);
>  
> -			num_cpu = all_cpu_map->nr;
> -			for (j = 0; j < num_cpu; j++) {
> -				cpu = all_cpu_map->map[j];
> +			perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
>  				perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
>  				perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
>  				perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
> @@ -757,11 +755,11 @@ static inline bool bpf_counter_skip(struct evsel *evsel)
>  		evsel->follower_skel == NULL;
>  }
>  
> -int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
>  {
>  	if (bpf_counter_skip(evsel))
>  		return 0;
> -	return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
> +	return evsel->bpf_counter_ops->install_pe(evsel, cpu_map_idx, fd);
>  }
>  
>  int bpf_counter__load(struct evsel *evsel, struct target *target)
> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> index 65ebaa6694fb..4dbf26408b69 100644
> --- a/tools/perf/util/bpf_counter.h
> +++ b/tools/perf/util/bpf_counter.h
> @@ -16,7 +16,7 @@ typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
>  typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
>  					   struct target *target);
>  typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
> -					       int cpu,
> +					       int cpu_map_idx,
>  					       int fd);
>  
>  struct bpf_counter_ops {
> @@ -40,7 +40,7 @@ int bpf_counter__enable(struct evsel *evsel);
>  int bpf_counter__disable(struct evsel *evsel);
>  int bpf_counter__read(struct evsel *evsel);
>  void bpf_counter__destroy(struct evsel *evsel);
> -int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
>  
>  #else /* HAVE_BPF_SKEL */
>  
> -- 
> 2.34.1.448.ga2b2bfdf31-goog

-- 

- Arnaldo
