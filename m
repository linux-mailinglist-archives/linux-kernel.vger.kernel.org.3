Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546E848A017
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbiAJT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:26:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39228 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbiAJT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:26:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 246E0B817D4;
        Mon, 10 Jan 2022 19:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A53C36AE9;
        Mon, 10 Jan 2022 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641842789;
        bh=tQUDkCICKljQOn/1ICNiOjXp97jhIjg9mBvFnFfvjTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAh8fp/eOpsvvtpEcRSotyG6IrBpsE8dCNR8F34FVa0tO/QopHjYD2MR6sISvpLzS
         3zhnlt2QnZav2gm4NhlMRA2HcaMKJxRqynn23MNxvLvpv/2KaCJx6asgfualJmRNhk
         DWi+07sYd8BnztoMXOMa0IThvfn91mB6yAq6/bKdxfL4eYUASafJOvZ2UJhSKlZPhb
         i4kL9fmfIlfhBmKdRIxuV2fuwx/fyETj6UgoVZQx0xU0nzVogEaoDq3aE/+TwVKkXn
         0Y/mQdoJgqtfVt9xzOXQHt1yTT/3C1Vw+mw8Tauh5U1Rqx4BfU7mL58n2i7hQb18U/
         TyvFQU7Oc7KwQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92D8B40B92; Mon, 10 Jan 2022 16:26:26 -0300 (-03)
Date:   Mon, 10 Jan 2022 16:26:26 -0300
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
Message-ID: <YdyIYhSN0wLhlOh0@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-45-irogers@google.com>
 <YdyEtsLxsZM09y8O@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdyEtsLxsZM09y8O@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 04:10:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 04, 2022 at 10:13:47PM -0800, Ian Rogers escreveu:
> > Synchronize the caller in evsel with the called function.
> > Shorten 3 lines of code in bperf_read by using
> > perf_cpu_map__for_each_cpu.
> > This code is frequently using variables named cpu as cpu map indices,
> > which doesn't matter as all CPUs are in the CPU map. It is strange in
> > some cases the cpumap is used at all.
> 
>   CC      /tmp/build/perf/builtin-stat.o
>   INSTALL trace_plugins
>   CC      /tmp/build/perf/util/evlist.o
>   CC      /tmp/build/perf/util/evsel.o
>   CC      /tmp/build/perf/util/header.o
>   CC      /tmp/build/perf/util/bpf_counter.o
>   CC      /tmp/build/perf/util/bpf_counter_cgroup.o
>   CC      /tmp/build/perf/util/bpf_ftrace.o
> In file included from util/cpumap.h:8,
>                  from util/bpf_counter.c:23:
> util/bpf_counter.c: In function ‘bperf__read’:
> /var/home/acme/git/perf/tools/lib/perf/include/perf/cpumap.h:27:20: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
>    27 |              (idx) < perf_cpu_map__nr(cpus);                    \
>       |                    ^
> util/bpf_counter.c:626:25: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
>   626 |                         perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> util/bpf_counter.c:611:21: error: unused variable ‘num_cpu’ [-Werror=unused-variable]
>   611 |         __u32 i, j, num_cpu;
>       |                     ^~~~~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':
> 
>     15,589,752,360      cycles:u
>     28,227,862,710      instructions:u            #    1.81  insn per cycle
> 
>        1.996638375 seconds time elapsed
> 
>        3.567457000 seconds user
>        0.934840000 seconds sys
> 
> 
> ⬢[acme@toolbox perf]$ git log --oneline -1
> 0083ba4c6a931fd0 (HEAD) perf bpf: Rename cpu to cpu_map_idx
> ⬢[acme@toolbox perf]$
> 
> Trying to fix...

Would be better to have the "Shorten 3 lines of code in bperf_read by
using perf_cpu_map__for_each_cpu." in a separate patch, try to do this
next time.

Below cures the two issues.

- Arnaldo


    Committer notes:

    Found when building with BUILD_BPF_SKEL=1:

    Remove unused 'num_cpu' variable in bperf__read().

    Make 'j' an 'int' as it is used in perf_cpu_map__for_each_cpu() to compare against an 'int'


diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ae5bd87ff02033c2..80d1a3a31052fe55 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -608,7 +608,8 @@ static int bperf__read(struct evsel *evsel)
 	__u32 num_cpu_bpf = cpu__max_cpu();
 	struct bpf_perf_event_value values[num_cpu_bpf];
 	int reading_map_fd, err = 0;
-	__u32 i, j, num_cpu;
+	__u32 i;
+	int j;
 
 	bperf_sync_counters(evsel);
 	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
