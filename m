Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9E496A17
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiAVE6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiAVE6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:58:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E9C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n196-20020a25d6cd000000b006139bdfade9so21958489ybg.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I0Fabc8UfZXyFKtZ3EKl6TervoHXtW5AQxzfTAXziFA=;
        b=iMpE0HQnCViuBpZGakSHceL3YQOm5OcgMT25ueAMqMGPpih9Vioc6ZrA9w1d3XiILD
         DpTHob5z9LgVoBh8OvJhLQn4EnFECVPcl+ycsRQgSoffQk0w/BwF/OHmvV66uth4HTm6
         5X3xtykzfav1CUIFSzrZNHFLlEVOyE8aS2R94fIvNXXGtg/HXL1XeETcXpWfK0xsOu4n
         PWM4P4iky/NleuN0J3vOtpNq8KMylxF2x1jfGIOJat/p5ezu17SNh+c+QRAqAZq0m2W4
         TOWfm9ixPVMJRwa7x1Ml0+6ezPzU6nImLpVoZWfVzGD/Ciz34V6iBIdVmtEFTpRcjgvR
         CShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I0Fabc8UfZXyFKtZ3EKl6TervoHXtW5AQxzfTAXziFA=;
        b=zysKdzXZWL+qTJsVjiK1RFCtCL1izM0KDWTMMoYEHh7gOnL6hWQKys5xCLDYfkq5/p
         h+sT9Dwh2n5nblQfbwG3hVwzsB5tqv++Z3Hl0p1WiDBgBocVFgFfBjAacss9gVpEpemh
         zt4b4T7ht2sbQlOKTl6Zt3VImv3aqKAZDoXa2+IOQH75v7w6LCJJua9kjXWpOs7YcN/p
         RdMzJoP3NJ6m7NqYvoAamdsYvEzkmzSoVAhVV8WSGfNYgdWKgL1TTVK6z1PTve3axhK9
         wQ+u5KbiDUc018hoUNS3E2WtwsSyakjlZi9lw7PfNg96Knp702UrZ0VgNlyapX+/0xPb
         5/+w==
X-Gm-Message-State: AOAM532rz1t0BdVjeDnxUlLaeraMXcNn75I7WG3gm2eiu7oaSFntdyQz
        PNA3+z/8ujvftPaTXczOOZzpCduEOwpq
X-Google-Smtp-Source: ABdhPJyujlqViHytgnDmTk41+QjapQziu2K+aYb4G1BOZtFxpBE5xMd9RdMzeAB2uf5RAns0KGw4D3twlXgv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6125:f911:aa9a:59ee])
 (user=irogers job=sendgmr) by 2002:a25:3f86:: with SMTP id
 m128mr10794646yba.500.1642827502900; Fri, 21 Jan 2022 20:58:22 -0800 (PST)
Date:   Fri, 21 Jan 2022 20:58:10 -0800
In-Reply-To: <20220122045811.3402706-1-irogers@google.com>
Message-Id: <20220122045811.3402706-3-irogers@google.com>
Mime-Version: 1.0
References: <20220122045811.3402706-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 2/3] perf cpumap: Migrate to libperf cpumap api
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from directly accessing the perf_cpu_map to using the appropriate
libperf API when possible. Using the API simplifies the job of
refactoring use of perf_cpu_map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c                        |  4 +-
 tools/perf/bench/epoll-ctl.c                  |  2 +-
 tools/perf/bench/epoll-wait.c                 |  2 +-
 tools/perf/bench/evlist-open-close.c          |  4 +-
 tools/perf/bench/futex-hash.c                 |  2 +-
 tools/perf/bench/futex-lock-pi.c              |  2 +-
 tools/perf/bench/futex-requeue.c              |  2 +-
 tools/perf/bench/futex-wake-parallel.c        |  2 +-
 tools/perf/bench/futex-wake.c                 |  2 +-
 tools/perf/builtin-ftrace.c                   |  2 +-
 tools/perf/builtin-stat.c                     |  7 ++--
 tools/perf/tests/bitmap.c                     |  4 +-
 tools/perf/tests/event_update.c               |  8 ++--
 tools/perf/tests/mem2node.c                   |  9 +++--
 tools/perf/tests/mmap-basic.c                 |  5 ++-
 tools/perf/tests/topology.c                   | 37 +++++++++++--------
 tools/perf/util/auxtrace.c                    |  2 +-
 tools/perf/util/counts.c                      |  2 +-
 tools/perf/util/cpumap.h                      |  2 +-
 tools/perf/util/cputopo.c                     |  4 +-
 tools/perf/util/evlist-hybrid.c               | 11 +++---
 tools/perf/util/evsel.c                       | 20 +++++-----
 tools/perf/util/evsel.h                       |  3 +-
 tools/perf/util/mmap.c                        |  2 +-
 tools/perf/util/perf_api_probe.c              |  4 +-
 tools/perf/util/record.c                      |  6 +--
 .../scripting-engines/trace-event-python.c    |  4 +-
 tools/perf/util/session.c                     |  4 +-
 tools/perf/util/svghelper.c                   |  4 +-
 tools/perf/util/synthetic-events.c            | 18 ++++-----
 tools/perf/util/top.c                         |  6 +--
 31 files changed, 99 insertions(+), 87 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 7ea86a44eae5..8543a594ea2f 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -141,7 +141,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 	if (evsel->fd == NULL &&
-	    perf_evsel__alloc_fd(evsel, cpus->nr, threads->nr) < 0)
+		perf_evsel__alloc_fd(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
 		return -ENOMEM;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
@@ -384,7 +384,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
 	int err = 0, i;
 
-	for (i = 0; i < evsel->cpus->nr && !err; i++)
+	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
 				     (void *)filter, i);
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 1a17ec83d3c4..740ae764537e 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -333,7 +333,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 
 	/* default to the number of CPUs */
 	if (!nthreads)
-		nthreads = cpu->nr;
+		nthreads = perf_cpu_map__nr(cpu);
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 0d1dd8879197..37de970c9743 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -452,7 +452,7 @@ int bench_epoll_wait(int argc, const char **argv)
 
 	/* default to the number of CPUs and leave one for the writer pthread */
 	if (!nthreads)
-		nthreads = cpu->nr - 1;
+		nthreads = perf_cpu_map__nr(cpu) - 1;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker) {
diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 482738e9bdad..de56601f69ee 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -71,7 +71,7 @@ static int evlist__count_evsel_fds(struct evlist *evlist)
 	int cnt = 0;
 
 	evlist__for_each_entry(evlist, evsel)
-		cnt += evsel->core.threads->nr * evsel->core.cpus->nr;
+		cnt += evsel->core.threads->nr * perf_cpu_map__nr(evsel->core.cpus);
 
 	return cnt;
 }
@@ -151,7 +151,7 @@ static int bench_evlist_open_close__run(char *evstr)
 
 	init_stats(&time_stats);
 
-	printf("  Number of cpus:\t%d\n", evlist->core.cpus->nr);
+	printf("  Number of cpus:\t%d\n", perf_cpu_map__nr(evlist->core.cpus));
 	printf("  Number of threads:\t%d\n", evlist->core.threads->nr);
 	printf("  Number of events:\t%d (%d fds)\n",
 		evlist->core.nr_entries, evlist__count_evsel_fds(evlist));
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 9627b6ab8670..dbcecec4eeda 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -150,7 +150,7 @@ int bench_futex_hash(int argc, const char **argv)
 	}
 
 	if (!params.nthreads) /* default to the number of CPUs */
-		params.nthreads = cpu->nr;
+		params.nthreads = perf_cpu_map__nr(cpu);
 
 	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index a512a320df74..6fc9a3d55c1f 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -173,7 +173,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	}
 
 	if (!params.nthreads)
-		params.nthreads = cpu->nr;
+		params.nthreads = perf_cpu_map__nr(cpu);
 
 	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index aca47ce8b1e7..2f59d5d1c509 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -175,7 +175,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	}
 
 	if (!params.nthreads)
-		params.nthreads = cpu->nr;
+		params.nthreads = perf_cpu_map__nr(cpu);
 
 	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 888ee6037945..861deb934745 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -252,7 +252,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		err(EXIT_FAILURE, "calloc");
 
 	if (!params.nthreads)
-		params.nthreads = cpu->nr;
+		params.nthreads = perf_cpu_map__nr(cpu);
 
 	/* some sanity checks */
 	if (params.nwakes > params.nthreads ||
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index aa82db51c0ab..cfda48bef1d7 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -151,7 +151,7 @@ int bench_futex_wake(int argc, const char **argv)
 	}
 
 	if (!params.nthreads)
-		params.nthreads = cpu->nr;
+		params.nthreads = perf_cpu_map__nr(cpu);
 
 	worker = calloc(params.nthreads, sizeof(*worker));
 	if (!worker)
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 71452599f87d..dec24dc0e767 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -281,7 +281,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 	int ret;
 	int last_cpu;
 
-	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1).cpu;
+	last_cpu = perf_cpu_map__cpu(cpumap, perf_cpu_map__nr(cpumap) - 1).cpu;
 	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 934e992c966f..3f98689dd687 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -230,11 +230,12 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
 	if (!a->core.cpus || !b->core.cpus)
 		return false;
 
-	if (a->core.cpus->nr != b->core.cpus->nr)
+	if (perf_cpu_map__nr(a->core.cpus) != perf_cpu_map__nr(b->core.cpus))
 		return false;
 
-	for (int i = 0; i < a->core.cpus->nr; i++) {
-		if (a->core.cpus->map[i].cpu != b->core.cpus->map[i].cpu)
+	for (int i = 0; i < perf_cpu_map__nr(a->core.cpus); i++) {
+		if (perf_cpu_map__cpu(a->core.cpus, i).cpu !=
+		    perf_cpu_map__cpu(b->core.cpus, i).cpu)
 			return false;
 	}
 
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 0bf399c49849..4965dd666956 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -17,8 +17,8 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
-		for (i = 0; i < map->nr; i++)
-			set_bit(map->map[i].cpu, bm);
+		for (i = 0; i < perf_cpu_map__nr(map); i++)
+			set_bit(perf_cpu_map__cpu(map, i).cpu, bm);
 	}
 
 	if (map)
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 16b6d6f47f38..78db4d704e76 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -75,10 +75,10 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong type", ev->type == PERF_EVENT_UPDATE__CPUS);
-	TEST_ASSERT_VAL("wrong cpus", map->nr == 3);
-	TEST_ASSERT_VAL("wrong cpus", map->map[0].cpu == 1);
-	TEST_ASSERT_VAL("wrong cpus", map->map[1].cpu == 2);
-	TEST_ASSERT_VAL("wrong cpus", map->map[2].cpu == 3);
+	TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__nr(map) == 3);
+	TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 0).cpu == 1);
+	TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 1).cpu == 2);
+	TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 2).cpu == 3);
 	perf_cpu_map__put(map);
 	return 0;
 }
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index f4a4aba33f76..4c96829510c9 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -25,14 +25,15 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 {
 	struct perf_cpu_map *map = perf_cpu_map__new(str);
 	unsigned long *bm = NULL;
-	int i;
 
 	bm = bitmap_zalloc(nbits);
 
 	if (map && bm) {
-		for (i = 0; i < map->nr; i++) {
-			set_bit(map->map[i].cpu, bm);
-		}
+		struct perf_cpu cpu;
+		int i;
+
+		perf_cpu_map__for_each_cpu(cpu, i, map)
+			set_bit(cpu.cpu, bm);
 	}
 
 	if (map)
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 0ad62914b4d7..c3c17600f29c 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -59,11 +59,12 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	}
 
 	CPU_ZERO(&cpu_set);
-	CPU_SET(cpus->map[0].cpu, &cpu_set);
+	CPU_SET(perf_cpu_map__cpu(cpus, 0).cpu, &cpu_set);
 	sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0) {
 		pr_debug("sched_setaffinity() failed on CPU %d: %s ",
-			 cpus->map[0].cpu, str_error_r(errno, sbuf, sizeof(sbuf)));
+			 perf_cpu_map__cpu(cpus, 0).cpu,
+			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_free_cpus;
 	}
 
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index c4ef0c7002f1..ee1e3dcbc0bd 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -122,44 +122,48 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 
 	// Test that CPU ID contains socket, die, core and CPU
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		id = aggr_cpu_id__cpu(perf_cpu_map__cpu(map, i), NULL);
-		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match", map->map[i].cpu == id.cpu.cpu);
+		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match",
+				perf_cpu_map__cpu(map, i).cpu == id.cpu.cpu);
 
 		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].core_id == id.core);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].core_id == id.core);
 		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			id.socket);
 
 		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].die_id == id.die);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Cpu map - Thread is set", id.thread == -1);
 	}
 
 	// Test that core ID contains socket, die and core
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].core_id == id.core);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].core_id == id.core);
 
 		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			id.socket);
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].die_id == id.die);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Core map - Thread is set", id.thread == -1);
 	}
 
 	// Test that die ID contains socket and die
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		id = aggr_cpu_id__die(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			id.socket);
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].die_id == id.die);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
 
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
@@ -168,10 +172,11 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 
 	// Test that socket ID contains only socket
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		id = aggr_cpu_id__socket(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
+			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
+			id.socket);
 
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
@@ -181,10 +186,10 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	}
 
 	// Test that node ID contains only node
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		id = aggr_cpu_id__node(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
-			cpu__get_node(map->map[i]) == id.node);
+				cpu__get_node(perf_cpu_map__cpu(map, i)) == id.node);
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 5632efc44738..825336304a37 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -174,7 +174,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 	mp->idx = idx;
 
 	if (per_cpu) {
-		mp->cpu = evlist->core.cpus->map[idx];
+		mp->cpu = perf_cpu_map__cpu(evlist->core.cpus, idx);
 		if (evlist->core.threads)
 			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
 		else
diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 2b81707b9dba..7a447d918458 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -61,7 +61,7 @@ int evsel__alloc_counts(struct evsel *evsel)
 	struct perf_cpu_map *cpus = evsel__cpus(evsel);
 	int nthreads = perf_thread_map__nr(evsel->core.threads);
 
-	evsel->counts = perf_counts__new(cpus ? cpus->nr : 1, nthreads);
+	evsel->counts = perf_counts__new(perf_cpu_map__nr(cpus), nthreads);
 	return evsel->counts != NULL ? 0 : -ENOMEM;
 }
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 0d3c2006a15d..5c85fbd709b4 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -57,7 +57,7 @@ struct perf_cpu cpu__max_present_cpu(void);
  */
 static inline bool cpu_map__is_dummy(struct perf_cpu_map *cpus)
 {
-	return cpus->nr == 1 && cpus->map[0].cpu == -1;
+	return perf_cpu_map__nr(cpus) == 1 && perf_cpu_map__cpu(cpus, 0).cpu == -1;
 }
 
 /**
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index e20b835a1194..d275d843c155 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -325,7 +325,7 @@ struct numa_topology *numa_topology__new(void)
 	if (!node_map)
 		goto out;
 
-	nr = (u32) node_map->nr;
+	nr = (u32) perf_cpu_map__nr(node_map);
 
 	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0])*nr);
 	if (!tp)
@@ -334,7 +334,7 @@ struct numa_topology *numa_topology__new(void)
 	tp->nr = nr;
 
 	for (i = 0; i < nr; i++) {
-		if (load_numa_node(&tp->nodes[i], node_map->map[i].cpu)) {
+		if (load_numa_node(&tp->nodes[i], perf_cpu_map__cpu(node_map, i).cpu)) {
 			numa_topology__delete(tp);
 			tp = NULL;
 			break;
diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index 7c554234b43d..7f234215147d 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -124,22 +124,23 @@ int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list)
 
 		events_nr++;
 
-		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
-		    matched_cpus->nr < cpus->nr ||
-		    matched_cpus->nr < pmu->cpus->nr)) {
+		if (perf_cpu_map__nr(matched_cpus) > 0 &&
+		    (perf_cpu_map__nr(unmatched_cpus) > 0 ||
+		     perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(cpus) ||
+		     perf_cpu_map__nr(matched_cpus) < perf_cpu_map__nr(pmu->cpus))) {
 			perf_cpu_map__put(evsel->core.cpus);
 			perf_cpu_map__put(evsel->core.own_cpus);
 			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
 			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
 
-			if (unmatched_cpus->nr > 0) {
+			if (perf_cpu_map__nr(unmatched_cpus) > 0) {
 				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
 				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
 					   buf1, pmu->name, evsel->name);
 			}
 		}
 
-		if (matched_cpus->nr == 0) {
+		if (perf_cpu_map__nr(matched_cpus) == 0) {
 			evlist__remove(evlist, evsel);
 			evsel__delete(evsel);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2f6b18af49e5..fb0a2debf015 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1782,7 +1782,7 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		nthreads = threads->nr;
 
 	if (evsel->core.fd == NULL &&
-	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
+	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
 	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
@@ -2020,9 +2020,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			test_attr__ready();
 
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, cpus->map[idx].cpu, group_fd, evsel->open_flags);
+				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[idx].cpu,
+			fd = sys_perf_event_open(&evsel->core.attr, pid,
+						perf_cpu_map__cpu(cpus, idx).cpu,
 						group_fd, evsel->open_flags);
 
 			FD(evsel, idx, thread) = fd;
@@ -2038,7 +2039,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			bpf_counter__install_pe(evsel, idx, fd);
 
 			if (unlikely(test_attr__enabled)) {
-				test_attr__open(&evsel->core.attr, pid, cpus->map[idx],
+				test_attr__open(&evsel->core.attr, pid,
+						perf_cpu_map__cpu(cpus, idx),
 						fd, group_fd, evsel->open_flags);
 			}
 
@@ -2079,7 +2081,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (evsel__precise_ip_fallback(evsel))
 		goto retry_open;
 
-	if (evsel__ignore_missing_thread(evsel, cpus->nr, idx, threads, thread, err)) {
+	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
+					 idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
 		nthreads--;
 
@@ -2119,7 +2122,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads)
 {
-	return evsel__open_cpu(evsel, cpus, threads, 0, cpus ? cpus->nr : 1);
+	return evsel__open_cpu(evsel, cpus, threads, 0, perf_cpu_map__nr(cpus));
 }
 
 void evsel__close(struct evsel *evsel)
@@ -2131,8 +2134,7 @@ void evsel__close(struct evsel *evsel)
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu_map_idx)
 {
 	if (cpu_map_idx == -1)
-		return evsel__open_cpu(evsel, cpus, NULL, 0,
-					cpus ? cpus->nr : 1);
+		return evsel__open_cpu(evsel, cpus, NULL, 0, perf_cpu_map__nr(cpus));
 
 	return evsel__open_cpu(evsel, cpus, NULL, cpu_map_idx, cpu_map_idx + 1);
 }
@@ -2982,7 +2984,7 @@ int evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 	struct perf_cpu_map *cpus = evsel->core.cpus;
 	struct perf_thread_map *threads = evsel->core.threads;
 
-	if (perf_evsel__alloc_id(&evsel->core, cpus->nr, threads->nr))
+	if (perf_evsel__alloc_id(&evsel->core, perf_cpu_map__nr(cpus), threads->nr))
 		return -ENOMEM;
 
 	return store_evsel_ids(evsel, evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5720ceebffac..041b42d33bf5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -11,6 +11,7 @@
 #include <perf/evsel.h>
 #include "symbol_conf.h"
 #include <internal/cpumap.h>
+#include <perf/cpumap.h>
 
 struct bpf_object;
 struct cgroup;
@@ -191,7 +192,7 @@ static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 
 static inline int evsel__nr_cpus(struct evsel *evsel)
 {
-	return evsel__cpus(evsel)->nr;
+	return perf_cpu_map__nr(evsel__cpus(evsel));
 }
 
 void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 12261ed8c15b..0e8ff8d1e206 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -250,7 +250,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 
 	nr_cpus = perf_cpu_map__nr(cpu_map);
 	for (idx = 0; idx < nr_cpus; idx++) {
-		cpu = cpu_map->map[idx]; /* map c index to online cpu index */
+		cpu = perf_cpu_map__cpu(cpu_map, idx); /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
 			set_bit(cpu.cpu, mask->bits);
 	}
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 734d006d9a8c..c28dd50bd571 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -67,7 +67,7 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	cpus = perf_cpu_map__new(NULL);
 	if (!cpus)
 		return false;
-	cpu = cpus->map[0];
+	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
 	do {
@@ -144,7 +144,7 @@ bool perf_can_record_cpu_wide(void)
 	if (!cpus)
 		return false;
 
-	cpu = cpus->map[0];
+	cpu = perf_cpu_map__cpu(cpus, 0);
 	perf_cpu_map__put(cpus);
 
 	fd = sys_perf_event_open(&attr, -1, cpu.cpu, -1, 0);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 20461f174991..007a64681416 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -106,7 +106,7 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 	if (opts->group)
 		evlist__set_leader(evlist);
 
-	if (evlist->core.cpus->map[0].cpu < 0)
+	if (perf_cpu_map__cpu(evlist->core.cpus, 0).cpu < 0)
 		opts->no_inherit = true;
 
 	use_comm_exec = perf_can_comm_exec();
@@ -248,11 +248,11 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
 		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
 
 		if (cpus)
-			cpu =  cpus->map[0];
+			cpu =  perf_cpu_map__cpu(cpus, 0);
 
 		perf_cpu_map__put(cpus);
 	} else {
-		cpu = evlist->core.cpus->map[0];
+		cpu = perf_cpu_map__cpu(evlist->core.cpus, 0);
 	}
 
 	while (1) {
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index f5ad0e62227a..e752e1f4a5f0 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1607,8 +1607,8 @@ static void python_process_stat(struct perf_stat_config *config,
 	}
 
 	for (thread = 0; thread < threads->nr; thread++) {
-		for (cpu = 0; cpu < cpus->nr; cpu++) {
-			process_stat(counter, cpus->map[cpu],
+		for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
+			process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
 				     perf_thread_map__pid(threads, thread), tstamp,
 				     perf_counts(counter->counts, cpu, thread));
 		}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f19348dddd55..2c0d30f08e78 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2537,8 +2537,8 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 		return -1;
 	}
 
-	for (i = 0; i < map->nr; i++) {
-		struct perf_cpu cpu = map->map[i];
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
+		struct perf_cpu cpu = perf_cpu_map__cpu(map, i);
 
 		if (cpu.cpu >= nr_cpus) {
 			pr_err("Requested CPU %d too large. "
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 4c9f211249db..1e0c731fc539 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -734,8 +734,8 @@ static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 	if (!m)
 		return -1;
 
-	for (i = 0; i < m->nr; i++) {
-		c = m->map[i];
+	for (i = 0; i < perf_cpu_map__nr(m); i++) {
+		c = perf_cpu_map__cpu(m, i);
 		if (c.cpu >= nr_cpus) {
 			ret = -1;
 			break;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c9ba8050cc2b..70f095624a0b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1186,12 +1186,12 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 static void synthesize_cpus(struct cpu_map_entries *cpus,
 			    struct perf_cpu_map *map)
 {
-	int i;
+	int i, map_nr = perf_cpu_map__nr(map);
 
-	cpus->nr = map->nr;
+	cpus->nr = map_nr;
 
-	for (i = 0; i < map->nr; i++)
-		cpus->cpu[i] = map->map[i].cpu;
+	for (i = 0; i < map_nr; i++)
+		cpus->cpu[i] = perf_cpu_map__cpu(map, i).cpu;
 }
 
 static void synthesize_mask(struct perf_record_record_cpu_map *mask,
@@ -1202,13 +1202,13 @@ static void synthesize_mask(struct perf_record_record_cpu_map *mask,
 	mask->nr = BITS_TO_LONGS(max);
 	mask->long_size = sizeof(long);
 
-	for (i = 0; i < map->nr; i++)
-		set_bit(map->map[i].cpu, mask->mask);
+	for (i = 0; i < perf_cpu_map__nr(map); i++)
+		set_bit(perf_cpu_map__cpu(map, i).cpu, mask->mask);
 }
 
 static size_t cpus_size(struct perf_cpu_map *map)
 {
-	return sizeof(struct cpu_map_entries) + map->nr * sizeof(u16);
+	return sizeof(struct cpu_map_entries) + perf_cpu_map__nr(map) * sizeof(u16);
 }
 
 static size_t mask_size(struct perf_cpu_map *map, int *max)
@@ -1217,9 +1217,9 @@ static size_t mask_size(struct perf_cpu_map *map, int *max)
 
 	*max = 0;
 
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		/* bit position of the cpu is + 1 */
-		int bit = map->map[i].cpu + 1;
+		int bit = perf_cpu_map__cpu(map, i).cpu + 1;
 
 		if (bit > *max)
 			*max = bit;
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 27945eeb0cb5..c1ebfc5d2e0c 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -95,15 +95,15 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 
 	if (target->cpu_list)
 		ret += SNPRINTF(bf + ret, size - ret, ", CPU%s: %s)",
-				top->evlist->core.cpus->nr > 1 ? "s" : "",
+				perf_cpu_map__nr(top->evlist->core.cpus) > 1 ? "s" : "",
 				target->cpu_list);
 	else {
 		if (target->tid)
 			ret += SNPRINTF(bf + ret, size - ret, ")");
 		else
 			ret += SNPRINTF(bf + ret, size - ret, ", %d CPU%s)",
-					top->evlist->core.cpus->nr,
-					top->evlist->core.cpus->nr > 1 ? "s" : "");
+					perf_cpu_map__nr(top->evlist->core.cpus),
+					perf_cpu_map__nr(top->evlist->core.cpus) > 1 ? "s" : "");
 	}
 
 	perf_top__reset_sample_counters(top);
-- 
2.35.0.rc0.227.g00780c9af4-goog

