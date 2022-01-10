Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3043248A06F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbiAJTuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:50:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50582 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiAJTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:50:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F746612C6;
        Mon, 10 Jan 2022 19:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639DDC36AE3;
        Mon, 10 Jan 2022 19:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641844248;
        bh=s7yyClaY5hOEwaxBzE0Enpf/zhXkDhA+9wtWbXWwSBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B32/LtDMMB4TsYjJXTaUDffYjM5fnNucxEFfk5an03h5Lb4r6k7IclbB4QCiMhX6t
         JpvtnjCIcxajH0BFNHwe4zrXdIVmY8ayEUOk5OhhuP3zmnJmhU5Ryd6j19hujYwU7b
         AWUGOw8Xb1Si8HSlEljwXIj43GRrROmgxO9WgNAX6YAQBiUsulengi8p0jrZ/kvZ9S
         VLfP2DB6azQADYZtSw3ionIjoqq4WgW5RXWd5ubLga3+urPhFeQhiSwIFp5059mrlF
         aAXOe4s3ADSSwtYsNjRgi0Aqrfux4TdmSpMboe/ZI4oAB2SzHIAS7cgIhtOrd6YblG
         z4ABlcK71piIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9648640714; Mon, 10 Jan 2022 16:50:45 -0300 (-03)
Date:   Mon, 10 Jan 2022 16:50:45 -0300
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
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
Message-ID: <YdyOFd8JJHbm1W+m@kernel.org>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-49-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105061351.120843-49-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers escreveu:
> A common problem is confusing CPU map indices with the CPU, by wrapping
> the CPU with a struct then this is avoided. This approach is similar to
> atomic_t.

This one needed this to build with BUILD_BPF_SKEL=1, please check, I'll
soon push this to tmp.perf/perf_cpu so that you can take a look and test
it.

- Arnaldo

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 80d1a3a31052fe55..328479df5e16a638 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -540,7 +540,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 		    filter_type == BPERF_FILTER_TGID)
 			key = evsel->core.threads->map[i].pid;
 		else if (filter_type == BPERF_FILTER_CPU)
-			key = evsel->core.cpus->map[i];
+			key = evsel->core.cpus->map[i].cpu;
 		else
 			break;
 
@@ -584,7 +584,7 @@ static int bperf_sync_counters(struct evsel *evsel)
 
 	num_cpu = all_cpu_map->nr;
 	for (i = 0; i < num_cpu; i++) {
-		cpu = all_cpu_map->map[i];
+		cpu = all_cpu_map->map[i].cpu;
 		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
 	}
 	return 0;
@@ -605,7 +605,7 @@ static int bperf__disable(struct evsel *evsel)
 static int bperf__read(struct evsel *evsel)
 {
 	struct bperf_follower_bpf *skel = evsel->follower_skel;
-	__u32 num_cpu_bpf = cpu__max_cpu();
+	__u32 num_cpu_bpf = cpu__max_cpu().cpu;
 	struct bpf_perf_event_value values[num_cpu_bpf];
 	int reading_map_fd, err = 0;
 	__u32 i;
@@ -615,6 +615,7 @@ static int bperf__read(struct evsel *evsel)
 	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
 
 	for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
+		struct perf_cpu entry;
 		__u32 cpu;
 
 		err = bpf_map_lookup_elem(reading_map_fd, &i, values);
@@ -624,14 +625,15 @@ static int bperf__read(struct evsel *evsel)
 		case BPERF_FILTER_GLOBAL:
 			assert(i == 0);
 
-			perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
+			perf_cpu_map__for_each_cpu(entry, j, all_cpu_map) {
+				cpu = entry.cpu;
 				perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
 				perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
 				perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
 			}
 			break;
 		case BPERF_FILTER_CPU:
-			cpu = evsel->core.cpus->map[i];
+			cpu = evsel->core.cpus->map[i].cpu;
 			perf_counts(evsel->counts, i, 0)->val = values[cpu].counter;
 			perf_counts(evsel->counts, i, 0)->ena = values[cpu].enabled;
 			perf_counts(evsel->counts, i, 0)->run = values[cpu].running;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index cbc6c2bca488f6bf..631e34a0b66ff084 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -48,7 +48,7 @@ static int bperf_load_program(struct evlist *evlist)
 	struct cgroup *cgrp, *leader_cgrp;
 	__u32 i, cpu;
 	__u32 nr_cpus = evlist->core.all_cpus->nr;
-	int total_cpus = cpu__max_cpu();
+	int total_cpus = cpu__max_cpu().cpu;
 	int map_size, map_fd;
 	int prog_fd, err;
 
@@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
 			for (cpu = 0; cpu < nr_cpus; cpu++) {
 				int fd = FD(evsel, cpu);
 				__u32 idx = evsel->core.idx * total_cpus +
-					evlist->core.all_cpus->map[cpu];
+					evlist->core.all_cpus->map[cpu].cpu;
 
 				err = bpf_map_update_elem(map_fd, &idx, &fd,
 							  BPF_ANY);
@@ -212,7 +212,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
 	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
 
 	for (i = 0; i < nr_cpus; i++) {
-		cpu = evlist->core.all_cpus->map[i];
+		cpu = evlist->core.all_cpus->map[i].cpu;
 		bperf_trigger_reading(prog_fd, cpu);
 	}
 
@@ -245,7 +245,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 {
 	struct evlist *evlist = evsel->evlist;
 	int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
-	int total_cpus = cpu__max_cpu();
+	int total_cpus = cpu__max_cpu().cpu;
 	struct perf_counts_values *counts;
 	struct bpf_perf_event_value *values;
 	int reading_map_fd, err = 0;
@@ -272,7 +272,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 		}
 
 		for (i = 0; i < nr_cpus; i++) {
-			cpu = evlist->core.all_cpus->map[i];
+			cpu = evlist->core.all_cpus->map[i].cpu;
 
 			counts = perf_counts(evsel->counts, i, 0);
 			counts->val = values[cpu].counter;
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 28dc4c60c7884818..d756cc66eef32ae8 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -63,7 +63,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 		fd = bpf_map__fd(skel->maps.cpu_filter);
 
 		for (i = 0; i < ncpus; i++) {
-			cpu = perf_cpu_map__cpu(ftrace->evlist->core.cpus, i);
+			cpu = perf_cpu_map__cpu(ftrace->evlist->core.cpus, i).cpu;
 			bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
 		}
 	}
@@ -122,7 +122,7 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
 	int i, fd, err;
 	u32 idx;
 	u64 *hist;
-	int ncpus = cpu__max_cpu();
+	int ncpus = cpu__max_cpu().cpu;
 
 	fd = bpf_map__fd(skel->maps.latency);
 
