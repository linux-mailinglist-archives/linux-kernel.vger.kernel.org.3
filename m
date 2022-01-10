Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50389489FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiAJS5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:57:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54406 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiAJS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:56:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD6D6137D;
        Mon, 10 Jan 2022 18:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE547C36AE3;
        Mon, 10 Jan 2022 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641841018;
        bh=sfAjJa7SO1QyY5lOIBROmF2VH8FL34dnowd5hzvMVbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kvbm4fuVGqE2UYCu52QLiXMA9a8FZIZeYAyyE+rNuv5XJEQiSenRz5QRBbUEq6iER
         t3eYixAlw04XI9tzuPW4YPEWF8W+Ojt02XXVoodEOZAQcef4GpypY+1hDJMPx+BalJ
         NB9Kd2Ues56kA3HZxYOr/fm2e9Hx8hO8eZWdmie/N1+/2/gVj4yOetINsqRR04U4X4
         mhbkbByfpqTdv0gBbjKztg9z4ZIn2QmSDOCFVQLuNzOLe1yOTuTt87niGJRTE4+Jgx
         xnA03dLQUbjVt4FQM1w4miFb5ajOJht+s2jg6gBWHtE2tRE1nko2HyyrfGw/oU2Mou
         pwjnn+QK5chLg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD56E40B92; Mon, 10 Jan 2022 15:56:55 -0300 (-03)
Date:   Mon, 10 Jan 2022 15:56:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a
 cpu.
Message-ID: <YdyBd7FHnyQaDwgu@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-3-irogers@google.com>
 <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
 <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
 <YdyAWxprUpsySNqo@kernel.org>
 <YdyAuTeFjF8n8lyv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdyAuTeFjF8n8lyv@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 03:53:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 10, 2022 at 03:52:11PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 10, 2022 at 09:36:49AM -0800, Ian Rogers escreveu:
> > > On Mon, Jan 10, 2022 at 9:10 AM John Garry <john.garry@huawei.com> wrote:
> > > >
> > > > On 05/01/2022 06:13, Ian Rogers wrote:
> > > > >
> > > > > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > > > > +                                    void *data)
> > > > > +{
> > > > > +     if (idx < 0 || idx > map->nr)
> > > > > +             return cpu_map__empty_aggr_cpu_id();
> > > > > +
> > > > > +     return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> > > > > +}
> > > > > +
> > > >
> > > >
> > > > This is later deleted in the series. Can the series be reworked so that
> > > > we don't add stuff and then later delete it? One reason for that
> > > > approach is that we don't spend time reviewing something which will be
> > > > deleted, especially in such a big series...
> > > 
> > > Hi John,
> > > 
> > > I think you are asking to squash:
> > > https://lore.kernel.org/lkml/20220105061351.120843-8-irogers@google.com/
> > > into this change. There are other  similar related changes that may
> > > also be squashed. The changes are trying to introduce a new API and
> > > then add changes to switch over to using it. This is with a view to
> > > making bisection easier, have each change only do 1 thing and so on. I
> > > believe the format of the patches is house style, but it is fine to
> > > squash changes together too. Having sent patches to Arnaldo and having
> > > had them split I'm reluctant to do a v5 with them squashed without him
> > > expressing a preference.
> > 
> > Right, sometimes this is needed, I'm getting the patchkit now to test
> > build it in my containers and will go patch by patch reviewing.
> 
> Good start:
> 
> ⬢[acme@toolbox perf]$ b4 am -ctsl --cc-trailers CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com
> Looking up https://lore.kernel.org/r/CAP-5%3DfWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA%40mail.gmail.com
> Grabbing thread from lore.kernel.org/all/CAP-5%3DfWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA%40mail.gmail.com/t.mbox.gz
> Checking for newer revisions on https://lore.kernel.org/all/
> Analyzing 58 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH v4 1/48] libperf: Add comments to perf_cpu_map.
>     + Reviewed-by: John Garry <john.garry@huawei.com>
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     + Link: https://lore.kernel.org/r/20220105061351.120843-2-irogers@google.com
> <BIG SNIP>
> Cover: ./v4_20220104_irogers_refactor_perf_cpumap.cover
>  Link: https://lore.kernel.org/r/20220105061351.120843-1-irogers@google.com
>  Base: applies clean to current tree
>        git checkout -b v4_20220104_irogers_google_com HEAD
>        git am ./v4_20220104_irogers_refactor_perf_cpumap.mbx
> 

oops:

  CC      /tmp/build/perf/util/unwind-libunwind-local.o
util/bpf_counter_cgroup.c: In function ‘bperf_load_program’:
util/bpf_counter_cgroup.c:51:26: error: incompatible types when initializing type ‘int’ using type ‘struct perf_cpu’
   51 |         int total_cpus = cpu__max_cpu();
      |                          ^~~~~~~~~~~~
util/bpf_counter_cgroup.c:127:74: error: invalid operands to binary + (have ‘int’ and ‘struct perf_cpu’)
  127 |                                 __u32 idx = evsel->core.idx * total_cpus +
      |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
      |                                                             |
      |                                                             int
  128 |                                         evlist->core.all_cpus->map[cpu];
      |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                                   |
      |                                                                   struct perf_cpu
util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__sync_counters’:
util/bpf_counter_cgroup.c:215:23: error: incompatible types when assigning to type ‘int’ from type ‘struct perf_cpu’
  215 |                 cpu = evlist->core.all_cpus->map[i];
      |                       ^~~~~~
util/bpf_counter_cgroup.c: In function ‘bperf_cgrp__read’:
util/bpf_counter_cgroup.c:248:26: error: incompatible types when initializing type ‘int’ using type ‘struct perf_cpu’
  248 |         int total_cpus = cpu__max_cpu();
      |                          ^~~~~~~~~~~~
util/bpf_counter_cgroup.c:275:31: error: incompatible types when assigning to type ‘int’ from type ‘struct perf_cpu’
  275 |                         cpu = evlist->core.all_cpus->map[i];
      |                               ^~~~~~
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/util/bpf_counter_cgroup.o] Error 1
make[4]: *** Waiting for unfinished jobs....
util/bpf_counter.c: In function ‘bperf__load’:
util/bpf_counter.c:543:31: error: incompatible types when assigning to type ‘__u32’ {aka ‘unsigned int’} from type ‘struct perf_cpu’
  543 |                         key = evsel->core.cpus->map[i];
      |                               ^~~~~
util/bpf_counter.c: In function ‘bperf_sync_counters’:
util/bpf_counter.c:587:23: error: incompatible types when assigning to type ‘int’ from type ‘struct perf_cpu’
  587 |                 cpu = all_cpu_map->map[i];
      |                       ^~~~~~~~~~~
util/bpf_counter.c: In function ‘bperf__read’:
util/bpf_counter.c:608:29: error: incompatible types when initializing type ‘__u32’ {aka ‘unsigned int’} using type ‘struct perf_cpu’
  608 |         __u32 num_cpu_bpf = cpu__max_cpu();
      |                             ^~~~~~~~~~~~
In file included from /var/home/acme/git/perf/tools/perf/util/cpumap.h:8,
                 from /var/home/acme/git/perf/tools/perf/util/env.h:7,
                 from util/cgroup.h:8,
                 from util/bpf_counter.c:22:
/var/home/acme/git/perf/tools/lib/perf/include/perf/cpumap.h:25:33: error: incompatible types when assigning to type ‘__u32’ {aka ‘unsigned int’} from type ‘struct perf_cpu’
   25 |         for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);   \
      |                                 ^~~~~~~~~~~~~~~~~
util/bpf_counter.c:626:25: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
  626 |                         perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
/var/home/acme/git/perf/tools/lib/perf/include/perf/cpumap.h:26:20: error: comparison of integer expressions of different signedness: ‘__u32’ {aka ‘unsigned int’} and ‘int’ [-Werror=sign-compare]
   26 |              (idx) < perf_cpu_map__nr(cpus);                    \
      |                    ^
util/bpf_counter.c:626:25: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
  626 |                         perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
/var/home/acme/git/perf/tools/lib/perf/include/perf/cpumap.h:27:31: error: incompatible types when assigning to type ‘__u32’ {aka ‘unsigned int’} from type ‘struct perf_cpu’
   27 |              (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
      |                               ^~~~~~~~~~~~~~~~~
util/bpf_counter.c:626:25: note: in expansion of macro ‘perf_cpu_map__for_each_cpu’
  626 |                         perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
util/bpf_counter.c:633:31: error: incompatible types when assigning to type ‘__u32’ {aka ‘unsigned int’} from type ‘struct perf_cpu’
  633 |                         cpu = evsel->core.cpus->map[i];
      |                               ^~~~~
util/bpf_counter.c:611:21: error: unused variable ‘num_cpu’ [-Werror=unused-variable]
  611 |         __u32 i, j, num_cpu;
      |                     ^~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_counter.o] Error 1
util/bpf_ftrace.c: In function ‘perf_ftrace__latency_prepare_bpf’:
util/bpf_ftrace.c:66:31: error: implicit declaration of function ‘cpu_map__cpu’; did you mean ‘cpu__max_cpu’? [-Werror=implicit-function-declaration]
   66 |                         cpu = cpu_map__cpu(ftrace->evlist->core.cpus, i);
      |                               ^~~~~~~~~~~~
      |                               cpu__max_cpu
util/bpf_ftrace.c: In function ‘perf_ftrace__latency_read_bpf’:
util/bpf_ftrace.c:125:21: error: incompatible types when initializing type ‘int’ using type ‘struct perf_cpu’
  125 |         int ncpus = cpu__max_cpu();
      |                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf_ftrace.o] Error 1
  LD      /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  LD      /tmp/build/perf/util/scripting-engines/perf-in.o
make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:665: /tmp/build/perf/perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

   279,675,447,200      cycles:u
   348,898,435,627      instructions:u            #    1.25  insn per cycle

       4.978587957 seconds time elapsed

      68.698979000 seconds user
      12.541229000 seconds sys


⬢[acme@toolbox perf]$

This is building with:

$ make BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin


In general for such refactorings its important to run:

make -C tools/perf build-test


But there is no entry there with BUILD_BPF_SKEL=1, will fix that now and
try to fix this in the patchkit as well.

- Arnaldo
