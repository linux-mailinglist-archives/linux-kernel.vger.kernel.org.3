Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5489F481A58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhL3HXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhL3HWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E87DC061374
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:40 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i203-20020a2554d4000000b0060a529902b3so32489023ybb.21
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PAkAfOINjTuCGiHWDTIf+0Yjva/4FXzSxJX0RgUS+Fo=;
        b=jPY1leECVUsitlNycDXWvx9/KgNSWtmOTLBaoan2PNngnC8JcJ7oPkGrlOqrMSaMmB
         HyK/xzzteb6f3ltqkuEbiKu2qamT48sI0mrukDuxd6eMVMpizko8CeEKDInGrKyVilDX
         YmcNZSDwA0LnnYn9bUfmKy5rfNAYzXL9vS+NbsfSzggYgaXStN7zIUbKMyYPLkUcrU21
         ks6PEw+xjNJrGDDNxiFChbI2iaQgV5LGARat0xKPzvFgxkG5ha1w435GVsqjnREcnU0o
         E4buwC3cGZ5Tfnj0ASzVqimYQ5e+X8YhvUVUjxSjSg5qG+l+zyPysV30OWaBqNNGWtmf
         7biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PAkAfOINjTuCGiHWDTIf+0Yjva/4FXzSxJX0RgUS+Fo=;
        b=A0zYE+ExKZTXcw4iLMwn5uP1NGShljpEar023YWU6E0Wc3IRGuBvbQquxGFYaHEhQD
         EAhTfSbXuqr22S/zlGOPKPeYBoskitVVBDHzmZDWD+yzVPuoYSwV0e9PMTt2svDLVAjJ
         XmRw/MGJ+8L2WaZgbuV+HGH6zA1o3Xey0Hi+fplWpoFK8+36JNbOFUDn3bIkYEeJhpqY
         2PFnRbUKh34p4w+v9ae2SAeVV6kDy4qNeUnXJUPLuoLdbYYSNc7EGnC9I2nzz1CcRPUd
         QjEY+CYOzGwFJA8hPu3HLbCJLemAoacti6CJ0iifhAc7cZYdfToW5RjL9M14q26hID4g
         XitQ==
X-Gm-Message-State: AOAM531D26uvEL3pAOPcF8BaiAooWSQkVlCk9uq/xzVGrQTYhmWJ0XJN
        NfhxwZT+BgQNhwn3TlsulQQkttheySiJ
X-Google-Smtp-Source: ABdhPJys0zJphmBgXgRO/KaietI6HLh4+foPlOriFoZs6aJh1km8IUrfeBa4OmsWF4GXL0ToLrRaXyP5WYxA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:d749:: with SMTP id
 o70mr30307121ybg.415.1640848959353; Wed, 29 Dec 2021 23:22:39 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:30 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-50-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 48/48] perf cpumap: Give CPUs their own type.
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common problem is confusing CPU map indices with the CPU, by wrapping
the CPU with a struct then this is avoided. This approach is similar to
atomic_t.

Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c                       | 121 ++++++++++--------
 tools/lib/perf/evlist.c                       |   4 +-
 tools/lib/perf/evsel.c                        |   9 +-
 tools/lib/perf/include/internal/cpumap.h      |   9 +-
 tools/lib/perf/include/internal/evlist.h      |   3 +-
 tools/lib/perf/include/internal/evsel.h       |   4 +-
 tools/lib/perf/include/internal/mmap.h        |   5 +-
 tools/lib/perf/include/perf/cpumap.h          |   9 +-
 tools/lib/perf/mmap.c                         |   2 +-
 tools/perf/bench/epoll-ctl.c                  |   2 +-
 tools/perf/bench/epoll-wait.c                 |   2 +-
 tools/perf/bench/futex-hash.c                 |   2 +-
 tools/perf/bench/futex-lock-pi.c              |   2 +-
 tools/perf/bench/futex-requeue.c              |   2 +-
 tools/perf/bench/futex-wake-parallel.c        |   2 +-
 tools/perf/bench/futex-wake.c                 |   2 +-
 tools/perf/builtin-c2c.c                      |  13 +-
 tools/perf/builtin-ftrace.c                   |   2 +-
 tools/perf/builtin-kmem.c                     |   2 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/builtin-sched.c                    |  65 +++++-----
 tools/perf/builtin-script.c                   |   5 +-
 tools/perf/builtin-stat.c                     |  80 ++++++------
 tools/perf/tests/attr.c                       |   6 +-
 tools/perf/tests/bitmap.c                     |   2 +-
 tools/perf/tests/cpumap.c                     |   6 +-
 tools/perf/tests/event_update.c               |   6 +-
 tools/perf/tests/mem2node.c                   |   2 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |  17 +--
 tools/perf/tests/stat.c                       |   3 +-
 tools/perf/tests/topology.c                   |  30 +++--
 tools/perf/util/affinity.c                    |   2 +-
 tools/perf/util/auxtrace.c                    |  12 +-
 tools/perf/util/auxtrace.h                    |   5 +-
 tools/perf/util/cpumap.c                      |  91 ++++++-------
 tools/perf/util/cpumap.h                      |  26 ++--
 tools/perf/util/cputopo.c                     |   6 +-
 tools/perf/util/env.c                         |  29 +++--
 tools/perf/util/env.h                         |   3 +-
 tools/perf/util/evlist.c                      |   8 +-
 tools/perf/util/evlist.h                      |   2 +-
 tools/perf/util/evsel.c                       |   6 +-
 tools/perf/util/expr.c                        |   2 +-
 tools/perf/util/header.c                      |   6 +-
 tools/perf/util/mmap.c                        |  19 +--
 tools/perf/util/mmap.h                        |   3 +-
 tools/perf/util/perf_api_probe.c              |  15 ++-
 tools/perf/util/python.c                      |   4 +-
 tools/perf/util/record.c                      |  11 +-
 .../scripting-engines/trace-event-python.c    |   6 +-
 tools/perf/util/session.c                     |  10 +-
 tools/perf/util/stat-display.c                |  34 +++--
 tools/perf/util/stat.c                        |   2 +-
 tools/perf/util/stat.h                        |   2 +-
 tools/perf/util/svghelper.c                   |   6 +-
 tools/perf/util/synthetic-events.c            |  12 +-
 tools/perf/util/synthetic-events.h            |   3 +-
 tools/perf/util/util.h                        |   5 +-
 59 files changed, 408 insertions(+), 347 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index eacea3ab965a..a3afe9ef74ef 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,16 +10,27 @@
 #include <ctype.h>
 #include <limits.h>
 
+static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+{
+	struct perf_cpu_map *cpus;
+
+	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	if (!cpus)
+		return NULL;
+
+	cpus->nr = 1;
+	refcount_set(&cpus->refcnt, 1);
+	return cpus;
+}
+
 struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 {
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
 
-	if (cpus != NULL) {
-		cpus->nr = 1;
-		cpus->map[0] = -1;
-		refcount_set(&cpus->refcnt, 1);
-	}
+	if (!cpus)
+		return NULL;
 
+	cpus->map[0].cpu = -1;
 	return cpus;
 }
 
@@ -54,16 +65,12 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	if (nr_cpus < 0)
 		return NULL;
 
-	cpus = malloc(sizeof(*cpus) + nr_cpus * sizeof(int));
-	if (cpus != NULL) {
-		int i;
-
-		for (i = 0; i < nr_cpus; ++i)
-			cpus->map[i] = i;
+	cpus = perf_cpu_map__alloc(nr_cpus);
+	if (!cpus)
+		return NULL;
 
-		cpus->nr = nr_cpus;
-		refcount_set(&cpus->refcnt, 1);
-	}
+	for (int i = 0; i < nr_cpus; ++i)
+		cpus->map[i].cpu = i;
 
 	return cpus;
 }
@@ -73,31 +80,32 @@ struct perf_cpu_map *perf_cpu_map__default_new(void)
 	return cpu_map__default_new();
 }
 
-static int cmp_int(const void *a, const void *b)
+
+static int cmp_cpu(const void *a, const void *b)
 {
-	return *(const int *)a - *(const int*)b;
+	const struct perf_cpu *cpu_a = a, *cpu_b = b;
+
+	return cpu_a->cpu - cpu_b->cpu;
 }
 
-static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
+static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu *tmp_cpus)
 {
-	size_t payload_size = nr_cpus * sizeof(int);
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
+	size_t payload_size = nr_cpus * sizeof(struct perf_cpu);
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(nr_cpus);
 	int i, j;
 
 	if (cpus != NULL) {
 		memcpy(cpus->map, tmp_cpus, payload_size);
-		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
+		qsort(cpus->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
 		/* Remove dups */
 		j = 0;
 		for (i = 0; i < nr_cpus; i++) {
-			if (i == 0 || cpus->map[i] != cpus->map[i - 1])
-				cpus->map[j++] = cpus->map[i];
+			if (i == 0 || cpus->map[i].cpu != cpus->map[i - 1].cpu)
+				cpus->map[j++].cpu = cpus->map[i].cpu;
 		}
 		cpus->nr = j;
 		assert(j <= nr_cpus);
-		refcount_set(&cpus->refcnt, 1);
 	}
-
 	return cpus;
 }
 
@@ -105,7 +113,7 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
 {
 	struct perf_cpu_map *cpus = NULL;
 	int nr_cpus = 0;
-	int *tmp_cpus = NULL, *tmp;
+	struct perf_cpu *tmp_cpus = NULL, *tmp;
 	int max_entries = 0;
 	int n, cpu, prev;
 	char sep;
@@ -124,24 +132,24 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
 
 			if (new_max >= max_entries) {
 				max_entries = new_max + MAX_NR_CPUS / 2;
-				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
+				tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
 				if (tmp == NULL)
 					goto out_free_tmp;
 				tmp_cpus = tmp;
 			}
 
 			while (++prev < cpu)
-				tmp_cpus[nr_cpus++] = prev;
+				tmp_cpus[nr_cpus++].cpu = prev;
 		}
 		if (nr_cpus == max_entries) {
 			max_entries += MAX_NR_CPUS;
-			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
+			tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
 			if (tmp == NULL)
 				goto out_free_tmp;
 			tmp_cpus = tmp;
 		}
 
-		tmp_cpus[nr_cpus++] = cpu;
+		tmp_cpus[nr_cpus++].cpu = cpu;
 		if (n == 2 && sep == '-')
 			prev = cpu;
 		else
@@ -179,7 +187,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	unsigned long start_cpu, end_cpu = 0;
 	char *p = NULL;
 	int i, nr_cpus = 0;
-	int *tmp_cpus = NULL, *tmp;
+	struct perf_cpu *tmp_cpus = NULL, *tmp;
 	int max_entries = 0;
 
 	if (!cpu_list)
@@ -220,17 +228,17 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 		for (; start_cpu <= end_cpu; start_cpu++) {
 			/* check for duplicates */
 			for (i = 0; i < nr_cpus; i++)
-				if (tmp_cpus[i] == (int)start_cpu)
+				if (tmp_cpus[i].cpu == (int)start_cpu)
 					goto invalid;
 
 			if (nr_cpus == max_entries) {
 				max_entries += MAX_NR_CPUS;
-				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
+				tmp = realloc(tmp_cpus, max_entries * sizeof(struct perf_cpu));
 				if (tmp == NULL)
 					goto invalid;
 				tmp_cpus = tmp;
 			}
-			tmp_cpus[nr_cpus++] = (int)start_cpu;
+			tmp_cpus[nr_cpus++].cpu = (int)start_cpu;
 		}
 		if (*p)
 			++p;
@@ -250,12 +258,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 	return cpus;
 }
 
-int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
+	struct perf_cpu result = {
+		.cpu = -1
+	};
+
 	if (cpus && idx < cpus->nr)
-		return cpus->map[idx];
+		result = cpus->map[idx];
 
-	return -1;
+	return result;
 }
 
 int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
@@ -265,10 +277,10 @@ int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 
 bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
-	return map ? map->map[0] == -1 : true;
+	return map ? map->map[0].cpu == -1 : true;
 }
 
-int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
+int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 {
 	int low, high;
 
@@ -278,13 +290,13 @@ int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 	low = 0;
 	high = cpus->nr;
 	while (low < high) {
-		int idx = (low + high) / 2,
-		    cpu_at_idx = cpus->map[idx];
+		int idx = (low + high) / 2;
+		struct perf_cpu cpu_at_idx = cpus->map[idx];
 
-		if (cpu_at_idx == cpu)
+		if (cpu_at_idx.cpu == cpu.cpu)
 			return idx;
 
-		if (cpu_at_idx > cpu)
+		if (cpu_at_idx.cpu > cpu.cpu)
 			high = idx;
 		else
 			low = idx + 1;
@@ -293,15 +305,22 @@ int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 	return -1;
 }
 
-bool perf_cpu_map__has(const struct perf_cpu_map *cpus, int cpu)
+bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 {
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
-int perf_cpu_map__max(struct perf_cpu_map *map)
+struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 {
+	struct perf_cpu result = {
+		.cpu = -1
+	};
+
 	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return map->nr > 0 ? map->map[map->nr - 1] : -1;
+	if (map->nr > 0)
+		result = map->map[map->nr - 1];
+
+	return result;
 }
 
 /*
@@ -315,7 +334,7 @@ int perf_cpu_map__max(struct perf_cpu_map *map)
 struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 					 struct perf_cpu_map *other)
 {
-	int *tmp_cpus;
+	struct perf_cpu *tmp_cpus;
 	int tmp_len;
 	int i, j, k;
 	struct perf_cpu_map *merged;
@@ -329,19 +348,19 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 	if (!other)
 		return orig;
 	if (orig->nr == other->nr &&
-	    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
+	    !memcmp(orig->map, other->map, orig->nr * sizeof(struct perf_cpu)))
 		return orig;
 
 	tmp_len = orig->nr + other->nr;
-	tmp_cpus = malloc(tmp_len * sizeof(int));
+	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
 		return NULL;
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
 	while (i < orig->nr && j < other->nr) {
-		if (orig->map[i] <= other->map[j]) {
-			if (orig->map[i] == other->map[j])
+		if (orig->map[i].cpu <= other->map[j].cpu) {
+			if (orig->map[i].cpu == other->map[j].cpu)
 				j++;
 			tmp_cpus[k++] = orig->map[i++];
 		} else
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 245acbc53bd3..9a770bfdc804 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -407,7 +407,7 @@ perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
 
 static int
 perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
-			  int output, int cpu)
+			  int output, struct perf_cpu cpu)
 {
 	return perf_mmap__mmap(map, mp, output, cpu);
 }
@@ -426,7 +426,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
-	int evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
+	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->cpus, cpu_idx);
 	struct perf_evsel *evsel;
 	int revent;
 
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index f1e1665ef4bd..7ea86a44eae5 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -78,10 +78,10 @@ static int perf_evsel__alloc_mmap(struct perf_evsel *evsel, int ncpus, int nthre
 
 static int
 sys_perf_event_open(struct perf_event_attr *attr,
-		    pid_t pid, int cpu, int group_fd,
+		    pid_t pid, struct perf_cpu cpu, int group_fd,
 		    unsigned long flags)
 {
-	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
+	return syscall(__NR_perf_event_open, attr, pid, cpu.cpu, group_fd, flags);
 }
 
 static int get_group_fd(struct perf_evsel *evsel, int cpu_map_idx, int thread, int *group_fd)
@@ -113,7 +113,8 @@ static int get_group_fd(struct perf_evsel *evsel, int cpu_map_idx, int thread, i
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		     struct perf_thread_map *threads)
 {
-	int cpu, idx, thread, err = 0;
+	struct perf_cpu cpu;
+	int idx, thread, err = 0;
 
 	if (cpus == NULL) {
 		static struct perf_cpu_map *empty_cpu_map;
@@ -252,7 +253,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
-			int cpu = perf_cpu_map__cpu(evsel->cpus, idx);
+			struct perf_cpu cpu = perf_cpu_map__cpu(evsel->cpus, idx);
 
 			if (fd == NULL || *fd < 0)
 				continue;
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 71a31ed738c9..581f9ffb4237 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -4,6 +4,11 @@
 
 #include <linux/refcount.h>
 
+/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
+struct perf_cpu {
+	int cpu;
+};
+
 /**
  * A sized, reference counted, sorted array of integers representing CPU
  * numbers. This is commonly used to capture which CPUs a PMU is associated
@@ -16,13 +21,13 @@ struct perf_cpu_map {
 	/** Length of the map array. */
 	int		nr;
 	/** The CPU values. */
-	int		map[];
+	struct perf_cpu	map[];
 };
 
 #ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS	2048
 #endif
 
-int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu);
+int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 6f74269a3ad4..4cefade540bd 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -4,6 +4,7 @@
 
 #include <linux/list.h>
 #include <api/fd/array.h>
+#include <internal/cpumap.h>
 #include <internal/evsel.h>
 
 #define PERF_EVLIST__HLIST_BITS 8
@@ -36,7 +37,7 @@ typedef void
 typedef struct perf_mmap*
 (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
 typedef int
-(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, int);
+(*perf_evlist_mmap__cb_mmap_t)(struct perf_mmap*, struct perf_mmap_param*, int, struct perf_cpu);
 
 struct perf_evlist_mmap_ops {
 	perf_evlist_mmap__cb_idx_t	idx;
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 1f3eacbad2e8..cfc9ebd7968e 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -6,8 +6,8 @@
 #include <linux/perf_event.h>
 #include <stdbool.h>
 #include <sys/types.h>
+#include <internal/cpumap.h>
 
-struct perf_cpu_map;
 struct perf_thread_map;
 struct xyarray;
 
@@ -27,7 +27,7 @@ struct perf_sample_id {
 	* queue number.
 	*/
 	int			 idx;
-	int			 cpu;
+	struct perf_cpu		 cpu;
 	pid_t			 tid;
 
 	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5e3422f40ed5..5a062af8e9d8 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <stdbool.h>
+#include <internal/cpumap.h>
 
 /* perf sample has 16 bits size limit */
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)
@@ -24,7 +25,7 @@ struct perf_mmap {
 	void			*base;
 	int			 mask;
 	int			 fd;
-	int			 cpu;
+	struct perf_cpu		 cpu;
 	refcount_t		 refcnt;
 	u64			 prev;
 	u64			 start;
@@ -46,7 +47,7 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map);
 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
 		     bool overwrite, libperf_unmap_cb_t unmap_cb);
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
-		    int fd, int cpu);
+		    int fd, struct perf_cpu cpu);
 void perf_mmap__munmap(struct perf_mmap *map);
 void perf_mmap__get(struct perf_mmap *map);
 void perf_mmap__put(struct perf_mmap *map);
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 3f1c0afa3ccd..15b8faafd615 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -3,11 +3,10 @@
 #define __LIBPERF_CPUMAP_H
 
 #include <perf/core.h>
+#include <perf/cpumap.h>
 #include <stdio.h>
 #include <stdbool.h>
 
-struct perf_cpu_map;
-
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
@@ -16,11 +15,11 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 						     struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
-LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
-LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
-LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, int cpu);
+LIBPERF_API struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map);
+LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index aaa457904008..f7ee07cb5818 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -32,7 +32,7 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 }
 
 int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
-		    int fd, int cpu)
+		    int fd, struct perf_cpu cpu)
 {
 	map->prev = 0;
 	map->mask = mp->mask;
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index ddaca75c3bc0..1a17ec83d3c4 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -253,7 +253,7 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 
 		if (!noaffinity) {
 			CPU_ZERO(&cpuset);
-			CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+			CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 			ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
 			if (ret)
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 79d13dbc0a47..0d1dd8879197 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -342,7 +342,7 @@ static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
 
 		if (!noaffinity) {
 			CPU_ZERO(&cpuset);
-			CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+			CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 			ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
 			if (ret)
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index fcdea3e44937..9627b6ab8670 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -177,7 +177,7 @@ int bench_futex_hash(int argc, const char **argv)
 			goto errmem;
 
 		CPU_ZERO(&cpuset);
-		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+		CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 		ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
 		if (ret)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 137890f78e17..a512a320df74 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -136,7 +136,7 @@ static void create_threads(struct worker *w, pthread_attr_t thread_attr,
 			worker[i].futex = &global_futex;
 
 		CPU_ZERO(&cpuset);
-		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+		CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index f7a5ffebb940..aca47ce8b1e7 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -131,7 +131,7 @@ static void block_threads(pthread_t *w,
 	/* create and block all threads */
 	for (i = 0; i < params.nthreads; i++) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+		CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index 0983f40b4b40..888ee6037945 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -152,7 +152,7 @@ static void block_threads(pthread_t *w, pthread_attr_t thread_attr,
 	/* create and block all threads */
 	for (i = 0; i < params.nthreads; i++) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+		CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 2226a475e782..aa82db51c0ab 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -105,7 +105,7 @@ static void block_threads(pthread_t *w,
 	/* create and block all threads */
 	for (i = 0; i < params.nthreads; i++) {
 		CPU_ZERO(&cpuset);
-		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+		CPU_SET(perf_cpu_map__cpu(cpu, i % perf_cpu_map__nr(cpu)).cpu, &cpuset);
 
 		if (pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset))
 			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index ad1fbeafc93d..77dd4afacca4 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2015,7 +2015,8 @@ static int setup_nodes(struct perf_session *session)
 {
 	struct numa_node *n;
 	unsigned long **nodes;
-	int node, cpu, idx;
+	int node, idx;
+	struct perf_cpu cpu;
 	int *cpu2node;
 
 	if (c2c.node_info > 2)
@@ -2038,8 +2039,8 @@ static int setup_nodes(struct perf_session *session)
 	if (!cpu2node)
 		return -ENOMEM;
 
-	for (cpu = 0; cpu < c2c.cpus_cnt; cpu++)
-		cpu2node[cpu] = -1;
+	for (idx = 0; idx < c2c.cpus_cnt; idx++)
+		cpu2node[idx] = -1;
 
 	c2c.cpu2node = cpu2node;
 
@@ -2058,12 +2059,12 @@ static int setup_nodes(struct perf_session *session)
 			continue;
 
 		perf_cpu_map__for_each_cpu(cpu, idx, map) {
-			set_bit(cpu, set);
+			set_bit(cpu.cpu, set);
 
-			if (WARN_ONCE(cpu2node[cpu] != -1, "node/cpu topology bug"))
+			if (WARN_ONCE(cpu2node[cpu.cpu] != -1, "node/cpu topology bug"))
 				return -EINVAL;
 
-			cpu2node[cpu] = node;
+			cpu2node[cpu.cpu] = node;
 		}
 	}
 
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index f16c39a37a52..71452599f87d 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -281,7 +281,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 	int ret;
 	int last_cpu;
 
-	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1);
+	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1).cpu;
 	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index da03a341c63c..99d7ff9a8eff 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -192,7 +192,7 @@ static int evsel__process_alloc_node_event(struct evsel *evsel, struct perf_samp
 	int ret = evsel__process_alloc_event(evsel, sample);
 
 	if (!ret) {
-		int node1 = cpu__get_node(sample->cpu),
+		int node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu}),
 		    node2 = evsel__intval(evsel, sample, "node");
 
 		if (node1 != node2)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6ac2160913ea..0a63295d30f0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2796,7 +2796,7 @@ int cmd_record(int argc, const char **argv)
 	symbol__init(NULL);
 
 	if (rec->opts.affinity != PERF_AFFINITY_SYS) {
-		rec->affinity_mask.nbits = cpu__max_cpu();
+		rec->affinity_mask.nbits = cpu__max_cpu().cpu;
 		rec->affinity_mask.bits = bitmap_zalloc(rec->affinity_mask.nbits);
 		if (!rec->affinity_mask.bits) {
 			pr_err("Failed to allocate thread mask for %zd cpus\n", rec->affinity_mask.nbits);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9da1da4749c9..72d446de9c60 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -167,7 +167,7 @@ struct trace_sched_handler {
 
 struct perf_sched_map {
 	DECLARE_BITMAP(comp_cpus_mask, MAX_CPUS);
-	int			*comp_cpus;
+	struct perf_cpu		*comp_cpus;
 	bool			 comp;
 	struct perf_thread_map *color_pids;
 	const char		*color_pids_str;
@@ -191,7 +191,7 @@ struct perf_sched {
  * Track the current task - that way we can know whether there's any
  * weird events, such as a task being switched away that is not current.
  */
-	int		 max_cpu;
+	struct perf_cpu	 max_cpu;
 	u32		 curr_pid[MAX_CPUS];
 	struct thread	 *curr_thread[MAX_CPUS];
 	char		 next_shortname1;
@@ -1535,28 +1535,31 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	int new_shortname;
 	u64 timestamp0, timestamp = sample->time;
 	s64 delta;
-	int i, this_cpu = sample->cpu;
+	int i;
+	struct perf_cpu this_cpu = {
+		.cpu = sample->cpu,
+	};
 	int cpus_nr;
 	bool new_cpu = false;
 	const char *color = PERF_COLOR_NORMAL;
 	char stimestamp[32];
 
-	BUG_ON(this_cpu >= MAX_CPUS || this_cpu < 0);
+	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
 
-	if (this_cpu > sched->max_cpu)
+	if (this_cpu.cpu > sched->max_cpu.cpu)
 		sched->max_cpu = this_cpu;
 
 	if (sched->map.comp) {
 		cpus_nr = bitmap_weight(sched->map.comp_cpus_mask, MAX_CPUS);
-		if (!test_and_set_bit(this_cpu, sched->map.comp_cpus_mask)) {
+		if (!test_and_set_bit(this_cpu.cpu, sched->map.comp_cpus_mask)) {
 			sched->map.comp_cpus[cpus_nr++] = this_cpu;
 			new_cpu = true;
 		}
 	} else
-		cpus_nr = sched->max_cpu;
+		cpus_nr = sched->max_cpu.cpu;
 
-	timestamp0 = sched->cpu_last_switched[this_cpu];
-	sched->cpu_last_switched[this_cpu] = timestamp;
+	timestamp0 = sched->cpu_last_switched[this_cpu.cpu];
+	sched->cpu_last_switched[this_cpu.cpu] = timestamp;
 	if (timestamp0)
 		delta = timestamp - timestamp0;
 	else
@@ -1577,7 +1580,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 		return -1;
 	}
 
-	sched->curr_thread[this_cpu] = thread__get(sched_in);
+	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
 
 	printf("  ");
 
@@ -1608,8 +1611,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	for (i = 0; i < cpus_nr; i++) {
-		int cpu = sched->map.comp ? sched->map.comp_cpus[i] : i;
-		struct thread *curr_thread = sched->curr_thread[cpu];
+		struct perf_cpu cpu = {
+			.cpu = sched->map.comp ? sched->map.comp_cpus[i].cpu : i,
+		};
+		struct thread *curr_thread = sched->curr_thread[cpu.cpu];
 		struct thread_runtime *curr_tr;
 		const char *pid_color = color;
 		const char *cpu_color = color;
@@ -1623,13 +1628,13 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
 			cpu_color = COLOR_CPUS;
 
-		if (cpu != this_cpu)
+		if (cpu.cpu != this_cpu.cpu)
 			color_fprintf(stdout, color, " ");
 		else
 			color_fprintf(stdout, cpu_color, "*");
 
-		if (sched->curr_thread[cpu]) {
-			curr_tr = thread__get_runtime(sched->curr_thread[cpu]);
+		if (sched->curr_thread[cpu.cpu]) {
+			curr_tr = thread__get_runtime(sched->curr_thread[cpu.cpu]);
 			if (curr_tr == NULL) {
 				thread__put(sched_in);
 				return -1;
@@ -1929,7 +1934,7 @@ static char *timehist_get_commstr(struct thread *thread)
 
 static void timehist_header(struct perf_sched *sched)
 {
-	u32 ncpus = sched->max_cpu + 1;
+	u32 ncpus = sched->max_cpu.cpu + 1;
 	u32 i, j;
 
 	printf("%15s %6s ", "time", "cpu");
@@ -2008,7 +2013,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 	struct thread_runtime *tr = thread__priv(thread);
 	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
 	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
-	u32 max_cpus = sched->max_cpu + 1;
+	u32 max_cpus = sched->max_cpu.cpu + 1;
 	char tstr[64];
 	char nstr[30];
 	u64 wait_time;
@@ -2389,7 +2394,7 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 	timestamp__scnprintf_usec(sample->time, tstr, sizeof(tstr));
 	printf("%15s [%04d] ", tstr, sample->cpu);
 	if (sched->show_cpu_visual)
-		printf(" %*s ", sched->max_cpu + 1, "");
+		printf(" %*s ", sched->max_cpu.cpu + 1, "");
 
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
@@ -2449,13 +2454,13 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 {
 	struct thread *thread;
 	char tstr[64];
-	u32 max_cpus = sched->max_cpu + 1;
+	u32 max_cpus;
 	u32 ocpu, dcpu;
 
 	if (sched->summary_only)
 		return;
 
-	max_cpus = sched->max_cpu + 1;
+	max_cpus = sched->max_cpu.cpu + 1;
 	ocpu = evsel__intval(evsel, sample, "orig_cpu");
 	dcpu = evsel__intval(evsel, sample, "dest_cpu");
 
@@ -2918,7 +2923,7 @@ static void timehist_print_summary(struct perf_sched *sched,
 
 	printf("    Total scheduling time (msec): ");
 	print_sched_time(hist_time, 2);
-	printf(" (x %d)\n", sched->max_cpu);
+	printf(" (x %d)\n", sched->max_cpu.cpu);
 }
 
 typedef int (*sched_handler)(struct perf_tool *tool,
@@ -2935,9 +2940,11 @@ static int perf_timehist__process_sample(struct perf_tool *tool,
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 	int err = 0;
-	int this_cpu = sample->cpu;
+	struct perf_cpu this_cpu = {
+		.cpu = sample->cpu,
+	};
 
-	if (this_cpu > sched->max_cpu)
+	if (this_cpu.cpu > sched->max_cpu.cpu)
 		sched->max_cpu = this_cpu;
 
 	if (evsel->handler != NULL) {
@@ -3054,10 +3061,10 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		goto out;
 
 	/* pre-allocate struct for per-CPU idle stats */
-	sched->max_cpu = session->header.env.nr_cpus_online;
-	if (sched->max_cpu == 0)
-		sched->max_cpu = 4;
-	if (init_idle_threads(sched->max_cpu))
+	sched->max_cpu.cpu = session->header.env.nr_cpus_online;
+	if (sched->max_cpu.cpu == 0)
+		sched->max_cpu.cpu = 4;
+	if (init_idle_threads(sched->max_cpu.cpu))
 		goto out;
 
 	/* summary_only implies summary option, but don't overwrite summary if set */
@@ -3209,10 +3216,10 @@ static int setup_map_cpus(struct perf_sched *sched)
 {
 	struct perf_cpu_map *map;
 
-	sched->max_cpu  = sysconf(_SC_NPROCESSORS_CONF);
+	sched->max_cpu.cpu  = sysconf(_SC_NPROCESSORS_CONF);
 
 	if (sched->map.comp) {
-		sched->map.comp_cpus = zalloc(sched->max_cpu * sizeof(int));
+		sched->map.comp_cpus = zalloc(sched->max_cpu.cpu * sizeof(int));
 		if (!sched->map.comp_cpus)
 			return -1;
 	}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 935a6edcdcdc..55f243d4a90b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2115,7 +2115,8 @@ static struct scripting_ops	*scripting_ops;
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int idx, cpu, thread;
+	int idx, thread;
+	struct perf_cpu cpu;
 	static int header_printed;
 
 	if (counter->core.system_wide)
@@ -2134,7 +2135,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 			counts = perf_counts(counter->counts, idx, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
-				cpu,
+				cpu.cpu,
 				perf_thread_map__pid(counter->core.threads, thread),
 				counts->val,
 				counts->ena,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68543bc7459f..f81c7f595fd9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -234,7 +234,7 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
 		return false;
 
 	for (int i = 0; i < a->core.cpus->nr; i++) {
-		if (a->core.cpus->map[i] != b->core.cpus->map[i])
+		if (a->core.cpus->map[i].cpu != b->core.cpus->map[i].cpu)
 			return false;
 	}
 
@@ -331,7 +331,7 @@ static int evsel__write_stat_event(struct evsel *counter, int cpu_map_idx, u32 t
 				   struct perf_counts_values *count)
 {
 	struct perf_sample_id *sid = SID(counter, cpu_map_idx, thread);
-	int cpu = perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx);
+	struct perf_cpu cpu = perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx);
 
 	return perf_event__synthesize_stat(NULL, cpu, thread, sid->id, count,
 					   process_synthesized_event, NULL);
@@ -396,7 +396,8 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
 			fprintf(stat_config.output,
 				"%s: %d: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
 					evsel__name(counter),
-					perf_cpu_map__cpu(evsel__cpus(counter), cpu_map_idx),
+					perf_cpu_map__cpu(evsel__cpus(counter),
+							  cpu_map_idx).cpu,
 					count->val, count->ena, count->run);
 		}
 	}
@@ -1328,61 +1329,61 @@ static const char *const aggr_mode__string[] = {
 };
 
 static struct aggr_cpu_id perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
-						int cpu)
+						struct perf_cpu cpu)
 {
 	return aggr_cpu_id__socket(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_die(struct perf_stat_config *config __maybe_unused,
-					     int cpu)
+					     struct perf_cpu cpu)
 {
 	return aggr_cpu_id__die(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
-					      int cpu)
+					      struct perf_cpu cpu)
 {
 	return aggr_cpu_id__core(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __maybe_unused,
-					      int cpu)
+					      struct perf_cpu cpu)
 {
 	return aggr_cpu_id__node(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
-					      aggr_get_id_t get_id, int cpu)
+					      aggr_get_id_t get_id, struct perf_cpu cpu)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu]))
-		config->cpus_aggr_map->map[cpu] = get_id(config, cpu);
+	if (aggr_cpu_id__is_empty(&config->cpus_aggr_map->map[cpu.cpu]))
+		config->cpus_aggr_map->map[cpu.cpu] = get_id(config, cpu);
 
-	id = config->cpus_aggr_map->map[cpu];
+	id = config->cpus_aggr_map->map[cpu.cpu];
 	return id;
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_cached(struct perf_stat_config *config,
-						       int cpu)
+						       struct perf_cpu cpu)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_socket, cpu);
 }
 
 static struct aggr_cpu_id perf_stat__get_die_cached(struct perf_stat_config *config,
-						    int cpu)
+						    struct perf_cpu cpu)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
 }
 
 static struct aggr_cpu_id perf_stat__get_core_cached(struct perf_stat_config *config,
-						     int cpu)
+						     struct perf_cpu cpu)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_core, cpu);
 }
 
 static struct aggr_cpu_id perf_stat__get_node_cached(struct perf_stat_config *config,
-						     int cpu)
+						     struct perf_cpu cpu)
 {
 	return perf_stat__get_aggr(config, perf_stat__get_node, cpu);
 }
@@ -1467,7 +1468,7 @@ static int perf_stat_init_aggr_mode(void)
 	 * taking the highest cpu number to be the size of
 	 * the aggregation translate cpumap.
 	 */
-	nr = perf_cpu_map__max(evsel_list->core.cpus);
+	nr = perf_cpu_map__max(evsel_list->core.cpus).cpu;
 	stat_config.cpus_aggr_map = cpu_aggr_map__empty_new(nr + 1);
 	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
 }
@@ -1495,71 +1496,66 @@ static void perf_stat__exit_aggr_mode(void)
 	stat_config.cpus_aggr_map = NULL;
 }
 
-static inline int perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
+static inline struct perf_cpu perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
 {
 	struct perf_env *env = data;
-	int cpu;
+	struct perf_cpu cpu = perf_cpu_map__cpu(map, idx);
 
-	if (idx > map->nr)
-		return -1;
-
-	cpu = map->map[idx];
-
-	if (cpu >= env->nr_cpus_avail)
-		return -1;
+	if (cpu.cpu >= env->nr_cpus_avail)
+		cpu.cpu = -1;
 
 	return cpu;
 }
 
-static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
+static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	if (cpu != -1)
-		id.socket = env->cpu[cpu].socket_id;
+	if (cpu.cpu != -1)
+		id.socket = env->cpu[cpu.cpu].socket_id;
 
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
+static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	if (cpu != -1) {
+	if (cpu.cpu != -1) {
 		/*
 		 * die_id is relative to socket, so start
 		 * with the socket ID and then add die to
 		 * make a unique ID.
 		 */
-		id.socket = env->cpu[cpu].socket_id;
-		id.die = env->cpu[cpu].die_id;
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
 	}
 
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
+static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	if (cpu != -1) {
+	if (cpu.cpu != -1) {
 		/*
 		 * core_id is relative to socket and die,
 		 * we need a global id. So we set
 		 * socket, die id and core id
 		 */
-		id.socket = env->cpu[cpu].socket_id;
-		id.die = env->cpu[cpu].die_id;
-		id.core = env->cpu[cpu].core_id;
+		id.socket = env->cpu[cpu.cpu].socket_id;
+		id.die = env->cpu[cpu.cpu].die_id;
+		id.core = env->cpu[cpu.cpu].core_id;
 	}
 
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
+static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(struct perf_cpu cpu, void *data)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
@@ -1568,24 +1564,24 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
-						     int cpu)
+						     struct perf_cpu cpu)
 {
 	return perf_env__get_socket_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *config __maybe_unused,
-						  int cpu)
+						  struct perf_cpu cpu)
 {
 	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
 static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
-						   int cpu)
+						   struct perf_cpu cpu)
 {
 	return perf_env__get_core_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
 static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *config __maybe_unused,
-						   int cpu)
+						   struct perf_cpu cpu)
 {
 	return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 0f73e300f207..56fba08a3037 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -65,7 +65,7 @@ do {									\
 
 #define WRITE_ASS(field, fmt) __WRITE_ASS(field, fmt, attr->field)
 
-static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
+static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
 		       int fd, int group_fd, unsigned long flags)
 {
 	FILE *file;
@@ -93,7 +93,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	/* syscall arguments */
 	__WRITE_ASS(fd,       "d", fd);
 	__WRITE_ASS(group_fd, "d", group_fd);
-	__WRITE_ASS(cpu,      "d", cpu);
+	__WRITE_ASS(cpu,      "d", cpu.cpu);
 	__WRITE_ASS(pid,      "d", pid);
 	__WRITE_ASS(flags,   "lu", flags);
 
@@ -144,7 +144,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, int cpu,
 	return 0;
 }
 
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
 		     int fd, int group_fd, unsigned long flags)
 {
 	int errno_saved = errno;
diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 384856347236..0bf399c49849 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -18,7 +18,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++)
-			set_bit(map->map[i], bm);
+			set_bit(map->map[i].cpu, bm);
 	}
 
 	if (map)
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 89a155092f85..84e87e31f119 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -38,7 +38,7 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  map->nr == 20);
 
 	for (i = 0; i < 20; i++) {
-		TEST_ASSERT_VAL("wrong cpu", map->map[i] == i);
+		TEST_ASSERT_VAL("wrong cpu", map->map[i].cpu == i);
 	}
 
 	perf_cpu_map__put(map);
@@ -67,8 +67,8 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 
 	map = cpu_map__new_data(data);
 	TEST_ASSERT_VAL("wrong nr",  map->nr == 2);
-	TEST_ASSERT_VAL("wrong cpu", map->map[0] == 1);
-	TEST_ASSERT_VAL("wrong cpu", map->map[1] == 256);
+	TEST_ASSERT_VAL("wrong cpu", map->map[0].cpu == 1);
+	TEST_ASSERT_VAL("wrong cpu", map->map[1].cpu == 256);
 	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
 	perf_cpu_map__put(map);
 	return 0;
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index d01532d40acb..16b6d6f47f38 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -76,9 +76,9 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong id", ev->id == 123);
 	TEST_ASSERT_VAL("wrong type", ev->type == PERF_EVENT_UPDATE__CPUS);
 	TEST_ASSERT_VAL("wrong cpus", map->nr == 3);
-	TEST_ASSERT_VAL("wrong cpus", map->map[0] == 1);
-	TEST_ASSERT_VAL("wrong cpus", map->map[1] == 2);
-	TEST_ASSERT_VAL("wrong cpus", map->map[2] == 3);
+	TEST_ASSERT_VAL("wrong cpus", map->map[0].cpu == 1);
+	TEST_ASSERT_VAL("wrong cpus", map->map[1].cpu == 2);
+	TEST_ASSERT_VAL("wrong cpus", map->map[2].cpu == 3);
 	perf_cpu_map__put(map);
 	return 0;
 }
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index b17b86391383..f4a4aba33f76 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -31,7 +31,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 
 	if (map && bm) {
 		for (i = 0; i < map->nr; i++) {
-			set_bit(map->map[i], bm);
+			set_bit(map->map[i].cpu, bm);
 		}
 	}
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 90b2feda31ac..0ad62914b4d7 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -59,11 +59,11 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 	}
 
 	CPU_ZERO(&cpu_set);
-	CPU_SET(cpus->map[0], &cpu_set);
+	CPU_SET(cpus->map[0].cpu, &cpu_set);
 	sched_setaffinity(0, sizeof(cpu_set), &cpu_set);
 	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0) {
 		pr_debug("sched_setaffinity() failed on CPU %d: %s ",
-			 cpus->map[0], str_error_r(errno, sbuf, sizeof(sbuf)));
+			 cpus->map[0].cpu, str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_free_cpus;
 	}
 
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index ca0a50e92839..1ab362323d25 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -22,7 +22,8 @@
 static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
 						  int subtest __maybe_unused)
 {
-	int err = -1, fd, idx, cpu;
+	int err = -1, fd, idx;
+	struct perf_cpu cpu;
 	struct perf_cpu_map *cpus;
 	struct evsel *evsel;
 	unsigned int nr_openat_calls = 111, i;
@@ -66,15 +67,15 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		 * without CPU_ALLOC. 1024 cpus in 2010 still seems
 		 * a reasonable upper limit tho :-)
 		 */
-		if (cpu >= CPU_SETSIZE) {
-			pr_debug("Ignoring CPU %d\n", cpu);
+		if (cpu.cpu >= CPU_SETSIZE) {
+			pr_debug("Ignoring CPU %d\n", cpu.cpu);
 			continue;
 		}
 
-		CPU_SET(cpu, &cpu_set);
+		CPU_SET(cpu.cpu, &cpu_set);
 		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0) {
 			pr_debug("sched_setaffinity() failed on CPU %d: %s ",
-				 cpu,
+				 cpu.cpu,
 				 str_error_r(errno, sbuf, sizeof(sbuf)));
 			goto out_close_fd;
 		}
@@ -82,7 +83,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 			fd = openat(0, "/etc/passwd", O_RDONLY);
 			close(fd);
 		}
-		CPU_CLR(cpu, &cpu_set);
+		CPU_CLR(cpu.cpu, &cpu_set);
 	}
 
 	evsel->core.cpus = perf_cpu_map__get(cpus);
@@ -92,7 +93,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		unsigned int expected;
 
-		if (cpu >= CPU_SETSIZE)
+		if (cpu.cpu >= CPU_SETSIZE)
 			continue;
 
 		if (evsel__read_on_cpu(evsel, idx, 0) < 0) {
@@ -104,7 +105,7 @@ static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __mayb
 		expected = nr_openat_calls + idx;
 		if (perf_counts(evsel->counts, idx, 0)->val != expected) {
 			pr_debug("evsel__read_on_cpu: expected to intercept %d calls on cpu %d, got %" PRIu64 "\n",
-				 expected, cpu, perf_counts(evsel->counts, idx, 0)->val);
+				 expected, cpu.cpu, perf_counts(evsel->counts, idx, 0)->val);
 			err = -1;
 		}
 	}
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 2eb096b5e6da..500974040fe3 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -87,7 +87,8 @@ static int test__synthesize_stat(struct test_suite *test __maybe_unused, int sub
 	count.run = 300;
 
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
-		!perf_event__synthesize_stat(NULL, 1, 2, 3, &count, process_stat_event, NULL));
+			!perf_event__synthesize_stat(NULL, (struct perf_cpu){.cpu = 1}, 2, 3,
+						     &count, process_stat_event, NULL));
 
 	return 0;
 }
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 33e4cb81265c..c4ef0c7002f1 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -112,7 +112,9 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
 
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
-		if (!perf_cpu_map__has(map, i))
+		struct perf_cpu cpu = { .cpu = i };
+
+		if (!perf_cpu_map__has(map, cpu))
 			continue;
 		pr_debug("CPU %d, core %d, socket %d\n", i,
 			 session->header.env.cpu[i].core_id,
@@ -122,15 +124,15 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	// Test that CPU ID contains socket, die, core and CPU
 	for (i = 0; i < map->nr; i++) {
 		id = aggr_cpu_id__cpu(perf_cpu_map__cpu(map, i), NULL);
-		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match", map->map[i] == id.cpu);
+		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match", map->map[i].cpu == id.cpu.cpu);
 
 		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
-			session->header.env.cpu[map->map[i]].core_id == id.core);
+			session->header.env.cpu[map->map[i].cpu].core_id == id.core);
 		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id == id.socket);
+			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i]].die_id == id.die);
+			session->header.env.cpu[map->map[i].cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Cpu map - Thread is set", id.thread == -1);
 	}
@@ -139,13 +141,13 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	for (i = 0; i < map->nr; i++) {
 		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
-			session->header.env.cpu[map->map[i]].core_id == id.core);
+			session->header.env.cpu[map->map[i].cpu].core_id == id.core);
 
 		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id == id.socket);
+			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i]].die_id == id.die);
+			session->header.env.cpu[map->map[i].cpu].die_id == id.die);
 		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Core map - Thread is set", id.thread == -1);
 	}
@@ -154,14 +156,14 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	for (i = 0; i < map->nr; i++) {
 		id = aggr_cpu_id__die(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id == id.socket);
+			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
-			session->header.env.cpu[map->map[i]].die_id == id.die);
+			session->header.env.cpu[map->map[i].cpu].die_id == id.die);
 
 		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
-		TEST_ASSERT_VAL("Die map - CPU is set", id.cpu == -1);
+		TEST_ASSERT_VAL("Die map - CPU is set", id.cpu.cpu == -1);
 		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
 	}
 
@@ -169,12 +171,12 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	for (i = 0; i < map->nr; i++) {
 		id = aggr_cpu_id__socket(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
-			session->header.env.cpu[map->map[i]].socket_id == id.socket);
+			session->header.env.cpu[map->map[i].cpu].socket_id == id.socket);
 
 		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
 		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Socket map - Core is set", id.core == -1);
-		TEST_ASSERT_VAL("Socket map - CPU is set", id.cpu == -1);
+		TEST_ASSERT_VAL("Socket map - CPU is set", id.cpu.cpu == -1);
 		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
 	}
 
@@ -186,7 +188,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
 		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
 		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
-		TEST_ASSERT_VAL("Node map - CPU is set", id.cpu == -1);
+		TEST_ASSERT_VAL("Node map - CPU is set", id.cpu.cpu == -1);
 		TEST_ASSERT_VAL("Node map - Thread is set", id.thread == -1);
 	}
 	perf_session__delete(session);
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
index 7b12bd7a3080..f1e30d566db3 100644
--- a/tools/perf/util/affinity.c
+++ b/tools/perf/util/affinity.c
@@ -11,7 +11,7 @@
 
 static int get_cpu_set_size(void)
 {
-	int sz = cpu__max_cpu() + 8 - 1;
+	int sz = cpu__max_cpu().cpu + 8 - 1;
 	/*
 	 * sched_getaffinity doesn't like masks smaller than the kernel.
 	 * Hopefully that's big enough.
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c679394b898d..5632efc44738 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -123,7 +123,7 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 	mm->prev = 0;
 	mm->idx = mp->idx;
 	mm->tid = mp->tid;
-	mm->cpu = mp->cpu;
+	mm->cpu = mp->cpu.cpu;
 
 	if (!mp->len) {
 		mm->base = NULL;
@@ -180,7 +180,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 		else
 			mp->tid = -1;
 	} else {
-		mp->cpu = -1;
+		mp->cpu.cpu = -1;
 		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);
 	}
 }
@@ -292,7 +292,7 @@ static int auxtrace_queues__queue_buffer(struct auxtrace_queues *queues,
 	if (!queue->set) {
 		queue->set = true;
 		queue->tid = buffer->tid;
-		queue->cpu = buffer->cpu;
+		queue->cpu = buffer->cpu.cpu;
 	}
 
 	buffer->buffer_nr = queues->next_buffer_nr++;
@@ -339,11 +339,11 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
 	return 0;
 }
 
-static bool filter_cpu(struct perf_session *session, int cpu)
+static bool filter_cpu(struct perf_session *session, struct perf_cpu cpu)
 {
 	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
 
-	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
+	return cpu_bitmap && cpu.cpu != -1 && !test_bit(cpu.cpu, cpu_bitmap);
 }
 
 static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
@@ -399,7 +399,7 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 	struct auxtrace_buffer buffer = {
 		.pid = -1,
 		.tid = event->auxtrace.tid,
-		.cpu = event->auxtrace.cpu,
+		.cpu = { event->auxtrace.cpu },
 		.data_offset = data_offset,
 		.offset = event->auxtrace.offset,
 		.reference = event->auxtrace.reference,
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index bbf0d78c6401..19910b9011f3 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <internal/cpumap.h>
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
@@ -240,7 +241,7 @@ struct auxtrace_buffer {
 	size_t			size;
 	pid_t			pid;
 	pid_t			tid;
-	int			cpu;
+	struct perf_cpu		cpu;
 	void			*data;
 	off_t			data_offset;
 	void			*mmap_addr;
@@ -350,7 +351,7 @@ struct auxtrace_mmap_params {
 	int		prot;
 	int		idx;
 	pid_t		tid;
-	int		cpu;
+	struct perf_cpu	cpu;
 };
 
 /**
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 0abbee49f637..ca48ca0f87a4 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -13,8 +13,8 @@
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
-static int max_cpu_num;
-static int max_present_cpu_num;
+static struct perf_cpu max_cpu_num;
+static struct perf_cpu max_present_cpu_num;
 static int max_node_num;
 /**
  * The numa node X as read from /sys/devices/system/node/nodeX indexed by the
@@ -37,9 +37,9 @@ static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 			 * otherwise it would become 65535.
 			 */
 			if (cpus->cpu[i] == (u16) -1)
-				map->map[i] = -1;
+				map->map[i].cpu = -1;
 			else
-				map->map[i] = (int) cpus->cpu[i];
+				map->map[i].cpu = (int) cpus->cpu[i];
 		}
 	}
 
@@ -58,7 +58,7 @@ static struct perf_cpu_map *cpu_map__from_mask(struct perf_record_record_cpu_map
 		int cpu, i = 0;
 
 		for_each_set_bit(cpu, mask->mask, nbits)
-			map->map[i++] = cpu;
+			map->map[i++].cpu = cpu;
 	}
 	return map;
 
@@ -91,7 +91,7 @@ struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 
 		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
-			cpus->map[i] = -1;
+			cpus->map[i].cpu = -1;
 
 		refcount_set(&cpus->refcnt, 1);
 	}
@@ -126,13 +126,13 @@ static int cpu__get_topology_int(int cpu, const char *name, int *value)
 	return sysfs__read_int(path, value);
 }
 
-int cpu__get_socket_id(int cpu)
+int cpu__get_socket_id(struct perf_cpu cpu)
 {
-	int value, ret = cpu__get_topology_int(cpu, "physical_package_id", &value);
+	int value, ret = cpu__get_topology_int(cpu.cpu, "physical_package_id", &value);
 	return ret ?: value;
 }
 
-struct aggr_cpu_id aggr_cpu_id__socket(int cpu, void *data __maybe_unused)
+struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
@@ -161,7 +161,8 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 				       aggr_cpu_id_get_t f,
 				       void *data)
 {
-	int cpu, idx;
+	int idx;
+	struct perf_cpu cpu;
 	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
 
 	if (!c)
@@ -201,14 +202,14 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 
 }
 
-int cpu__get_die_id(int cpu)
+int cpu__get_die_id(struct perf_cpu cpu)
 {
-	int value, ret = cpu__get_topology_int(cpu, "die_id", &value);
+	int value, ret = cpu__get_topology_int(cpu.cpu, "die_id", &value);
 
 	return ret ?: value;
 }
 
-struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data)
+struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data)
 {
 	struct aggr_cpu_id id;
 	int die;
@@ -231,13 +232,13 @@ struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data)
 	return id;
 }
 
-int cpu__get_core_id(int cpu)
+int cpu__get_core_id(struct perf_cpu cpu)
 {
-	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
+	int value, ret = cpu__get_topology_int(cpu.cpu, "core_id", &value);
 	return ret ?: value;
 }
 
-struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
+struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data)
 {
 	struct aggr_cpu_id id;
 	int core = cpu__get_core_id(cpu);
@@ -256,7 +257,7 @@ struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data)
 
 }
 
-struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data)
+struct aggr_cpu_id aggr_cpu_id__cpu(struct perf_cpu cpu, void *data)
 {
 	struct aggr_cpu_id id;
 
@@ -270,7 +271,7 @@ struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data)
 
 }
 
-struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data __maybe_unused)
+struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
@@ -318,8 +319,8 @@ static void set_max_cpu_num(void)
 	int ret = -1;
 
 	/* set up default */
-	max_cpu_num = 4096;
-	max_present_cpu_num = 4096;
+	max_cpu_num.cpu = 4096;
+	max_present_cpu_num.cpu = 4096;
 
 	mnt = sysfs__mountpoint();
 	if (!mnt)
@@ -332,7 +333,7 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_cpu_num);
+	ret = get_max_num(path, &max_cpu_num.cpu);
 	if (ret)
 		goto out;
 
@@ -343,11 +344,11 @@ static void set_max_cpu_num(void)
 		goto out;
 	}
 
-	ret = get_max_num(path, &max_present_cpu_num);
+	ret = get_max_num(path, &max_present_cpu_num.cpu);
 
 out:
 	if (ret)
-		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num);
+		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.cpu);
 }
 
 /* Determine highest possible node in the system for sparse allocation */
@@ -386,31 +387,31 @@ int cpu__max_node(void)
 	return max_node_num;
 }
 
-int cpu__max_cpu(void)
+struct perf_cpu cpu__max_cpu(void)
 {
-	if (unlikely(!max_cpu_num))
+	if (unlikely(!max_cpu_num.cpu))
 		set_max_cpu_num();
 
 	return max_cpu_num;
 }
 
-int cpu__max_present_cpu(void)
+struct perf_cpu cpu__max_present_cpu(void)
 {
-	if (unlikely(!max_present_cpu_num))
+	if (unlikely(!max_present_cpu_num.cpu))
 		set_max_cpu_num();
 
 	return max_present_cpu_num;
 }
 
 
-int cpu__get_node(int cpu)
+int cpu__get_node(struct perf_cpu cpu)
 {
 	if (unlikely(cpunode_map == NULL)) {
 		pr_debug("cpu_map not initialized\n");
 		return -1;
 	}
 
-	return cpunode_map[cpu];
+	return cpunode_map[cpu.cpu];
 }
 
 static int init_cpunode_map(void)
@@ -420,13 +421,13 @@ static int init_cpunode_map(void)
 	set_max_cpu_num();
 	set_max_node_num();
 
-	cpunode_map = calloc(max_cpu_num, sizeof(int));
+	cpunode_map = calloc(max_cpu_num.cpu, sizeof(int));
 	if (!cpunode_map) {
 		pr_err("%s: calloc failed\n", __func__);
 		return -1;
 	}
 
-	for (i = 0; i < max_cpu_num; i++)
+	for (i = 0; i < max_cpu_num.cpu; i++)
 		cpunode_map[i] = -1;
 
 	return 0;
@@ -487,35 +488,37 @@ int cpu__setup_cpunode_map(void)
 
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 {
-	int i, cpu, start = -1;
+	int i, start = -1;
 	bool first = true;
 	size_t ret = 0;
 
 #define COMMA first ? "" : ","
 
 	for (i = 0; i < map->nr + 1; i++) {
+		struct perf_cpu cpu = { .cpu = INT_MAX };
 		bool last = i == map->nr;
 
-		cpu = last ? INT_MAX : map->map[i];
+		if (!last)
+			cpu = map->map[i];
 
 		if (start == -1) {
 			start = i;
 			if (last) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[i]);
+						map->map[i].cpu);
 			}
-		} else if (((i - start) != (cpu - map->map[start])) || last) {
+		} else if (((i - start) != (cpu.cpu - map->map[start].cpu)) || last) {
 			int end = i - 1;
 
 			if (start == end) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[start]);
+						map->map[start].cpu);
 			} else {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d-%d", COMMA,
-						map->map[start], map->map[end]);
+						map->map[start].cpu, map->map[end].cpu);
 			}
 			first = false;
 			start = i;
@@ -542,23 +545,23 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	int last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
+	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
 
 	if (buf == NULL)
 		return 0;
 
-	bitmap = zalloc(last_cpu / 8 + 1);
+	bitmap = zalloc(last_cpu.cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
 	}
 
 	for (i = 0; i < map->nr; i++) {
-		cpu = perf_cpu_map__cpu(map, i);
+		cpu = perf_cpu_map__cpu(map, i).cpu;
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
 
-	for (cpu = last_cpu / 4 * 4; cpu >= 0; cpu -= 4) {
+	for (cpu = last_cpu.cpu / 4 * 4; cpu >= 0; cpu -= 4) {
 		unsigned char bits = bitmap[cpu / 8];
 
 		if (cpu % 8)
@@ -594,7 +597,7 @@ bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b
 		a->socket == b->socket &&
 		a->die == b->die &&
 		a->core == b->core &&
-		a->cpu == b->cpu;
+		a->cpu.cpu == b->cpu.cpu;
 }
 
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
@@ -604,7 +607,7 @@ bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a)
 		a->socket == -1 &&
 		a->die == -1 &&
 		a->core == -1 &&
-		a->cpu == -1;
+		a->cpu.cpu == -1;
 }
 
 struct aggr_cpu_id aggr_cpu_id__empty(void)
@@ -615,7 +618,7 @@ struct aggr_cpu_id aggr_cpu_id__empty(void)
 		.socket = -1,
 		.die = -1,
 		.core = -1,
-		.cpu = -1
+		.cpu = (struct perf_cpu){ .cpu = -1 },
 	};
 	return ret;
 }
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 651c6417d3c3..6eedf3d57df5 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -23,7 +23,7 @@ struct aggr_cpu_id {
 	/** The core id as read from /sys/devices/system/cpu/cpuX/topology/core_id. */
 	int core;
 	/** CPU aggregation, note there is one CPU for each SMT thread. */
-	int cpu;
+	struct perf_cpu cpu;
 };
 
 /** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
@@ -48,28 +48,28 @@ const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 int cpu__setup_cpunode_map(void);
 
 int cpu__max_node(void);
-int cpu__max_cpu(void);
-int cpu__max_present_cpu(void);
+struct perf_cpu cpu__max_cpu(void);
+struct perf_cpu cpu__max_present_cpu(void);
 /**
  * cpu__get_node - Returns the numa node X as read from
  * /sys/devices/system/node/nodeX for the given CPU.
  */
-int cpu__get_node(int cpu);
+int cpu__get_node(struct perf_cpu cpu);
 /**
  * cpu__get_socket_id - Returns the socket number as read from
  * /sys/devices/system/cpu/cpuX/topology/physical_package_id for the given CPU.
  */
-int cpu__get_socket_id(int cpu);
+int cpu__get_socket_id(struct perf_cpu cpu);
 /**
  * cpu__get_die_id - Returns the die id as read from
  * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
  */
-int cpu__get_die_id(int cpu);
+int cpu__get_die_id(struct perf_cpu cpu);
 /**
  * cpu__get_core_id - Returns the core id as read from
  * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
  */
-int cpu__get_core_id(int cpu);
+int cpu__get_core_id(struct perf_cpu cpu);
 
 /**
  * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
@@ -77,7 +77,7 @@ int cpu__get_core_id(int cpu);
  */
 struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
-typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
+typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(struct perf_cpu cpu, void *data);
 
 /**
  * cpu_aggr_map__new - Create a cpu_aggr_map with an aggr_cpu_id for each cpu in
@@ -98,29 +98,29 @@ struct aggr_cpu_id aggr_cpu_id__empty(void);
  * the socket for cpu. The function signature is compatible with
  * aggr_cpu_id_get_t.
  */
-struct aggr_cpu_id aggr_cpu_id__socket(int cpu, void *data);
+struct aggr_cpu_id aggr_cpu_id__socket(struct perf_cpu cpu, void *data);
 /**
  * aggr_cpu_id__die - Create an aggr_cpu_id with the die and socket populated
  * with the die and socket for cpu. The function signature is compatible with
  * aggr_cpu_id_get_t.
  */
-struct aggr_cpu_id aggr_cpu_id__die(int cpu, void *data);
+struct aggr_cpu_id aggr_cpu_id__die(struct perf_cpu cpu, void *data);
 /**
  * aggr_cpu_id__core - Create an aggr_cpu_id with the core, die and socket
  * populated with the core, die and socket for cpu. The function signature is
  * compatible with aggr_cpu_id_get_t.
  */
-struct aggr_cpu_id aggr_cpu_id__core(int cpu, void *data);
+struct aggr_cpu_id aggr_cpu_id__core(struct perf_cpu cpu, void *data);
 /**
  * aggr_cpu_id__core - Create an aggr_cpu_id with the cpu, core, die and socket
  * populated with the cpu, core, die and socket for cpu. The function signature
  * is compatible with aggr_cpu_id_get_t.
  */
-struct aggr_cpu_id aggr_cpu_id__cpu(int cpu, void *data);
+struct aggr_cpu_id aggr_cpu_id__cpu(struct perf_cpu cpu, void *data);
 /**
  * aggr_cpu_id__node - Create an aggr_cpu_id with the numa node populated for
  * cpu. The function signature is compatible with aggr_cpu_id_get_t.
  */
-struct aggr_cpu_id aggr_cpu_id__node(int cpu, void *data);
+struct aggr_cpu_id aggr_cpu_id__node(struct perf_cpu cpu, void *data);
 
 #endif /* __PERF_CPUMAP_H */
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 8affb37d90e7..84ca106a3246 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -187,7 +187,7 @@ struct cpu_topology *cpu_topology__new(void)
 	struct perf_cpu_map *map;
 	bool has_die = has_die_topology();
 
-	ncpus = cpu__max_present_cpu();
+	ncpus = cpu__max_present_cpu().cpu;
 
 	/* build online CPU map */
 	map = perf_cpu_map__new(NULL);
@@ -218,7 +218,7 @@ struct cpu_topology *cpu_topology__new(void)
 	tp->core_cpus_list = addr;
 
 	for (i = 0; i < nr; i++) {
-		if (!perf_cpu_map__has(map, i))
+		if (!perf_cpu_map__has(map, (struct perf_cpu){ .cpu = i }))
 			continue;
 
 		ret = build_cpu_topology(tp, i);
@@ -333,7 +333,7 @@ struct numa_topology *numa_topology__new(void)
 	tp->nr = nr;
 
 	for (i = 0; i < nr; i++) {
-		if (load_numa_node(&tp->nodes[i], node_map->map[i])) {
+		if (load_numa_node(&tp->nodes[i], node_map->map[i].cpu)) {
 			numa_topology__delete(tp);
 			tp = NULL;
 			break;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fd12c0dcaefb..579e44c59914 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -285,13 +285,13 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 
 int perf_env__read_cpu_topology_map(struct perf_env *env)
 {
-	int cpu, nr_cpus;
+	int idx, nr_cpus;
 
 	if (env->cpu != NULL)
 		return 0;
 
 	if (env->nr_cpus_avail == 0)
-		env->nr_cpus_avail = cpu__max_present_cpu();
+		env->nr_cpus_avail = cpu__max_present_cpu().cpu;
 
 	nr_cpus = env->nr_cpus_avail;
 	if (nr_cpus == -1)
@@ -301,10 +301,12 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	if (env->cpu == NULL)
 		return -ENOMEM;
 
-	for (cpu = 0; cpu < nr_cpus; ++cpu) {
-		env->cpu[cpu].core_id	= cpu__get_core_id(cpu);
-		env->cpu[cpu].socket_id	= cpu__get_socket_id(cpu);
-		env->cpu[cpu].die_id	= cpu__get_die_id(cpu);
+	for (idx = 0; idx < nr_cpus; ++idx) {
+		struct perf_cpu cpu = { .cpu = idx };
+
+		env->cpu[idx].core_id	= cpu__get_core_id(cpu);
+		env->cpu[idx].socket_id	= cpu__get_socket_id(cpu);
+		env->cpu[idx].die_id	= cpu__get_die_id(cpu);
 	}
 
 	env->nr_cpus_avail = nr_cpus;
@@ -381,7 +383,7 @@ static int perf_env__read_arch(struct perf_env *env)
 static int perf_env__read_nr_cpus_avail(struct perf_env *env)
 {
 	if (env->nr_cpus_avail == 0)
-		env->nr_cpus_avail = cpu__max_present_cpu();
+		env->nr_cpus_avail = cpu__max_present_cpu().cpu;
 
 	return env->nr_cpus_avail ? 0 : -ENOENT;
 }
@@ -487,7 +489,7 @@ const char *perf_env__pmu_mappings(struct perf_env *env)
 	return env->pmu_mappings;
 }
 
-int perf_env__numa_node(struct perf_env *env, int cpu)
+int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 {
 	if (!env->nr_numa_map) {
 		struct numa_node *nn;
@@ -495,7 +497,7 @@ int perf_env__numa_node(struct perf_env *env, int cpu)
 
 		for (i = 0; i < env->nr_numa_nodes; i++) {
 			nn = &env->numa_nodes[i];
-			nr = max(nr, perf_cpu_map__max(nn->map));
+			nr = max(nr, perf_cpu_map__max(nn->map).cpu);
 		}
 
 		nr++;
@@ -514,13 +516,14 @@ int perf_env__numa_node(struct perf_env *env, int cpu)
 		env->nr_numa_map = nr;
 
 		for (i = 0; i < env->nr_numa_nodes; i++) {
-			int tmp, j;
+			struct perf_cpu tmp;
+			int j;
 
 			nn = &env->numa_nodes[i];
-			perf_cpu_map__for_each_cpu(j, tmp, nn->map)
-				env->numa_map[j] = i;
+			perf_cpu_map__for_each_cpu(tmp, j, nn->map)
+				env->numa_map[tmp.cpu] = i;
 		}
 	}
 
-	return cpu >= 0 && cpu < env->nr_numa_map ? env->numa_map[cpu] : -1;
+	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
 }
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 163e5ec503a2..a3541f98e1fc 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/rbtree.h>
+#include "cpumap.h"
 #include "rwsem.h"
 
 struct perf_cpu_map;
@@ -170,5 +171,5 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
-int perf_env__numa_node(struct perf_env *env, int cpu);
+int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 39d294f6c321..11eb95b2106b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -350,13 +350,13 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 		.cpu_map_idx = 0,
 		.evlist_cpu_map_idx = 0,
 		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
-		.cpu = -1,
+		.cpu = (struct perf_cpu){ .cpu = -1},
 		.affinity = affinity,
 	};
 
 	if (itr.affinity) {
 		itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
-		affinity__set(itr.affinity, itr.cpu);
+		affinity__set(itr.affinity, itr.cpu.cpu);
 		itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
 		/*
 		 * If this CPU isn't in the evsel's cpu map then advance through
@@ -385,7 +385,7 @@ void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
 			perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
 					  evlist_cpu_itr->evlist_cpu_map_idx);
 		if (evlist_cpu_itr->affinity)
-			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu);
+			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu.cpu);
 		evlist_cpu_itr->cpu_map_idx =
 			perf_cpu_map__idx(evlist_cpu_itr->evsel->core.cpus,
 					  evlist_cpu_itr->cpu);
@@ -819,7 +819,7 @@ perf_evlist__mmap_cb_get(struct perf_evlist *_evlist, bool overwrite, int idx)
 
 static int
 perf_evlist__mmap_cb_mmap(struct perf_mmap *_map, struct perf_mmap_param *_mp,
-			  int output, int cpu)
+			  int output, struct perf_cpu cpu)
 {
 	struct mmap *map = container_of(_map, struct mmap, core);
 	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 57828ebfcb61..64cba56fbc74 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -344,7 +344,7 @@ struct evlist_cpu_iterator {
 	/** The number of CPU map entries in evlist->core.all_cpus. */
 	int evlist_cpu_map_nr;
 	/** The current CPU of the iterator. */
-	int cpu;
+	struct perf_cpu cpu;
 	/** If present, used to set the affinity when switching between CPUs. */
 	struct affinity *affinity;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2b18b29a534f..7b806cb462bb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1594,7 +1594,7 @@ int __evsel__read_on_cpu(struct evsel *evsel, int cpu_map_idx, int thread, bool
 static int evsel__match_other_cpu(struct evsel *evsel, struct evsel *other,
 				  int cpu_map_idx)
 {
-	int cpu;
+	struct perf_cpu cpu;
 
 	cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
 	return perf_cpu_map__idx(other->core.cpus, cpu);
@@ -2020,9 +2020,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			test_attr__ready();
 
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, cpus->map[idx], group_fd, evsel->open_flags);
+				pid, cpus->map[idx].cpu, group_fd, evsel->open_flags);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[idx],
+			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[idx].cpu,
 						group_fd, evsel->open_flags);
 
 			FD(evsel, idx, thread) = fd;
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 1d532b9fed29..164af5505ed5 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -400,7 +400,7 @@ double expr__get_literal(const char *literal)
 		return smt_on() > 0 ? 1.0 : 0.0;
 
 	if (!strcmp("#num_cpus", literal))
-		return cpu__max_present_cpu();
+		return cpu__max_present_cpu().cpu;
 
 	/*
 	 * Assume that topology strings are consistent, such as CPUs "0-1"
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3c1a532d059..6da12e522edc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -472,7 +472,7 @@ static int write_nrcpus(struct feat_fd *ff,
 	u32 nrc, nra;
 	int ret;
 
-	nrc = cpu__max_present_cpu();
+	nrc = cpu__max_present_cpu().cpu;
 
 	nr = sysconf(_SC_NPROCESSORS_ONLN);
 	if (nr < 0)
@@ -1163,7 +1163,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 *cntp)
 	u32 nr, cpu;
 	u16 level;
 
-	nr = cpu__max_cpu();
+	nr = cpu__max_cpu().cpu;
 
 	for (cpu = 0; cpu < nr; cpu++) {
 		for (level = 0; level < MAX_CACHE_LVL; level++) {
@@ -1195,7 +1195,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 *cntp)
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
-	u32 max_caches = cpu__max_cpu() * MAX_CACHE_LVL;
+	u32 max_caches = cpu__max_cpu().cpu * MAX_CACHE_LVL;
 	struct cpu_cache_level caches[max_caches];
 	u32 cnt = 0, i, version = 1;
 	int ret;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 23ecdba9e670..12261ed8c15b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -94,7 +94,7 @@ static void perf_mmap__aio_free(struct mmap *map, int idx)
 	}
 }
 
-static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
+static int perf_mmap__aio_bind(struct mmap *map, int idx, struct perf_cpu cpu, int affinity)
 {
 	void *data;
 	size_t mmap_len;
@@ -138,7 +138,7 @@ static void perf_mmap__aio_free(struct mmap *map, int idx)
 }
 
 static int perf_mmap__aio_bind(struct mmap *map __maybe_unused, int idx __maybe_unused,
-		int cpu __maybe_unused, int affinity __maybe_unused)
+		struct perf_cpu cpu __maybe_unused, int affinity __maybe_unused)
 {
 	return 0;
 }
@@ -240,7 +240,8 @@ void mmap__munmap(struct mmap *map)
 
 static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 {
-	int c, cpu, nr_cpus;
+	int idx, nr_cpus;
+	struct perf_cpu cpu;
 	const struct perf_cpu_map *cpu_map = NULL;
 
 	cpu_map = cpu_map__online();
@@ -248,16 +249,16 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 		return;
 
 	nr_cpus = perf_cpu_map__nr(cpu_map);
-	for (c = 0; c < nr_cpus; c++) {
-		cpu = cpu_map->map[c]; /* map c index to online cpu index */
+	for (idx = 0; idx < nr_cpus; idx++) {
+		cpu = cpu_map->map[idx]; /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
-			set_bit(cpu, mask->bits);
+			set_bit(cpu.cpu, mask->bits);
 	}
 }
 
 static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
-	map->affinity_mask.nbits = cpu__max_cpu();
+	map->affinity_mask.nbits = cpu__max_cpu().cpu;
 	map->affinity_mask.bits = bitmap_zalloc(map->affinity_mask.nbits);
 	if (!map->affinity_mask.bits)
 		return -1;
@@ -265,12 +266,12 @@ static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
 		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		set_bit(map->core.cpu, map->affinity_mask.bits);
+		set_bit(map->core.cpu.cpu, map->affinity_mask.bits);
 
 	return 0;
 }
 
-int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu cpu)
 {
 	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 8e259b9610f8..83f6bd4d4082 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/ring_buffer.h>
 #include <linux/bitops.h>
+#include <perf/cpumap.h>
 #include <stdbool.h>
 #include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
@@ -52,7 +53,7 @@ struct mmap_params {
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
-int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu);
+int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu cpu);
 void mmap__munmap(struct mmap *map);
 
 union perf_event *perf_mmap__read_forward(struct mmap *map);
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 020411682a3c..734d006d9a8c 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -11,7 +11,7 @@
 
 typedef void (*setup_probe_fn_t)(struct evsel *evsel);
 
-static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
+static int perf_do_probe_api(setup_probe_fn_t fn, struct perf_cpu cpu, const char *str)
 {
 	struct evlist *evlist;
 	struct evsel *evsel;
@@ -29,7 +29,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 	evsel = evlist__first(evlist);
 
 	while (1) {
-		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
+		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu.cpu, -1, flags);
 		if (fd < 0) {
 			if (pid == -1 && errno == EACCES) {
 				pid = 0;
@@ -43,7 +43,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 
 	fn(evsel);
 
-	fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1, flags);
+	fd = sys_perf_event_open(&evsel->core.attr, pid, cpu.cpu, -1, flags);
 	if (fd < 0) {
 		if (errno == EINVAL)
 			err = -EINVAL;
@@ -61,7 +61,8 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 {
 	const char *try[] = {"cycles:u", "instructions:u", "cpu-clock:u", NULL};
 	struct perf_cpu_map *cpus;
-	int cpu, ret, i = 0;
+	struct perf_cpu cpu;
+	int ret, i = 0;
 
 	cpus = perf_cpu_map__new(NULL);
 	if (!cpus)
@@ -136,15 +137,17 @@ bool perf_can_record_cpu_wide(void)
 		.exclude_kernel = 1,
 	};
 	struct perf_cpu_map *cpus;
-	int cpu, fd;
+	struct perf_cpu cpu;
+	int fd;
 
 	cpus = perf_cpu_map__new(NULL);
 	if (!cpus)
 		return false;
+
 	cpu = cpus->map[0];
 	perf_cpu_map__put(cpus);
 
-	fd = sys_perf_event_open(&attr, -1, cpu, -1, 0);
+	fd = sys_perf_event_open(&attr, -1, cpu.cpu, -1, 0);
 	if (fd < 0)
 		return false;
 	close(fd);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 7f782a31bda3..95fb53899bcd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1057,7 +1057,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
-		if (md->core.cpu == cpu)
+		if (md->core.cpu.cpu == cpu)
 			return md;
 	}
 
@@ -1443,7 +1443,7 @@ PyMODINIT_FUNC PyInit_perf(void)
  * Dummy, to avoid dragging all the test_attr infrastructure in the python
  * binding.
  */
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
                      int fd, int group_fd, unsigned long flags)
 {
 }
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index bff669b615ee..20461f174991 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -106,7 +106,7 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 	if (opts->group)
 		evlist__set_leader(evlist);
 
-	if (evlist->core.cpus->map[0] < 0)
+	if (evlist->core.cpus->map[0].cpu < 0)
 		opts->no_inherit = true;
 
 	use_comm_exec = perf_can_comm_exec();
@@ -229,7 +229,8 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
 {
 	struct evlist *temp_evlist;
 	struct evsel *evsel;
-	int err, fd, cpu;
+	int err, fd;
+	struct perf_cpu cpu = { .cpu = 0 };
 	bool ret = false;
 	pid_t pid = -1;
 
@@ -246,14 +247,16 @@ bool evlist__can_select_event(struct evlist *evlist, const char *str)
 	if (!evlist || perf_cpu_map__empty(evlist->core.cpus)) {
 		struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
 
-		cpu =  cpus ? cpus->map[0] : 0;
+		if (cpus)
+			cpu =  cpus->map[0];
+
 		perf_cpu_map__put(cpus);
 	} else {
 		cpu = evlist->core.cpus->map[0];
 	}
 
 	while (1) {
-		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, -1,
+		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu.cpu, -1,
 					 perf_event_open_cloexec_flag());
 		if (fd < 0) {
 			if (pid == -1 && errno == EACCES) {
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 0445bee9290f..bd95d60018a9 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1555,7 +1555,7 @@ static void get_handler_name(char *str, size_t size,
 }
 
 static void
-process_stat(struct evsel *counter, int cpu, int thread, u64 tstamp,
+process_stat(struct evsel *counter, struct perf_cpu cpu, int thread, u64 tstamp,
 	     struct perf_counts_values *count)
 {
 	PyObject *handler, *t;
@@ -1575,7 +1575,7 @@ process_stat(struct evsel *counter, int cpu, int thread, u64 tstamp,
 		return;
 	}
 
-	PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu));
+	PyTuple_SetItem(t, n++, _PyLong_FromLong(cpu.cpu));
 	PyTuple_SetItem(t, n++, _PyLong_FromLong(thread));
 
 	tuple_set_u64(t, n++, tstamp);
@@ -1599,7 +1599,7 @@ static void python_process_stat(struct perf_stat_config *config,
 	int cpu, thread;
 
 	if (config->aggr_mode == AGGR_GLOBAL) {
-		process_stat(counter, -1, -1, tstamp,
+		process_stat(counter, (struct perf_cpu){ .cpu = -1 }, -1, tstamp,
 			     &counter->counts->aggr);
 		return;
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e1a273048681..f19348dddd55 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2538,15 +2538,15 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	}
 
 	for (i = 0; i < map->nr; i++) {
-		int cpu = map->map[i];
+		struct perf_cpu cpu = map->map[i];
 
-		if (cpu >= nr_cpus) {
+		if (cpu.cpu >= nr_cpus) {
 			pr_err("Requested CPU %d too large. "
-			       "Consider raising MAX_NR_CPUS\n", cpu);
+			       "Consider raising MAX_NR_CPUS\n", cpu.cpu);
 			goto out_delete_map;
 		}
 
-		set_bit(cpu, cpu_bitmap);
+		set_bit(cpu.cpu, cpu_bitmap);
 	}
 
 	err = 0;
@@ -2598,7 +2598,7 @@ int perf_event__process_id_index(struct perf_session *session,
 		if (!sid)
 			return -ENOENT;
 		sid->idx = e->idx;
-		sid->cpu = e->cpu;
+		sid->cpu.cpu = e->cpu;
 		sid->tid = e->tid;
 	}
 	return 0;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ba95379efcfb..5db83e51ceef 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -121,10 +121,10 @@ static void aggr_printout(struct perf_stat_config *config,
 				id.die,
 				config->csv_output ? 0 : -3,
 				id.core, config->csv_sep);
-		} else if (id.cpu > -1) {
+		} else if (id.cpu.cpu > -1) {
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
-				id.cpu, config->csv_sep);
+				id.cpu.cpu, config->csv_sep);
 		}
 		break;
 	case AGGR_THREAD:
@@ -331,7 +331,8 @@ static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
 				struct evsel *evsel, const struct aggr_cpu_id *id)
 {
 	struct perf_cpu_map *cpus = evsel__cpus(evsel);
-	int cpu, idx;
+	struct perf_cpu cpu;
+	int idx;
 
 	if (config->aggr_mode == AGGR_NONE)
 		return perf_cpu_map__idx(cpus, id->cpu);
@@ -513,7 +514,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 static void aggr_update_shadow(struct perf_stat_config *config,
 			       struct evlist *evlist)
 {
-	int cpu, idx, s;
+	int idx, s;
+	struct perf_cpu cpu;
 	struct aggr_cpu_id s2, id;
 	u64 val;
 	struct evsel *counter;
@@ -633,7 +635,8 @@ static void aggr_cb(struct perf_stat_config *config,
 		    struct evsel *counter, void *data, bool first)
 {
 	struct aggr_data *ad = data;
-	int idx, cpu;
+	int idx;
+	struct perf_cpu cpu;
 	struct perf_cpu_map *cpus;
 	struct aggr_cpu_id s2;
 
@@ -666,7 +669,7 @@ static void aggr_cb(struct perf_stat_config *config,
 static void print_counter_aggrdata(struct perf_stat_config *config,
 				   struct evsel *counter, int s,
 				   char *prefix, bool metric_only,
-				   bool *first, int cpu)
+				   bool *first, struct perf_cpu cpu)
 {
 	struct aggr_data ad;
 	FILE *output = config->output;
@@ -696,7 +699,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = val * counter->scale;
-	if (cpu != -1)
+	if (cpu.cpu != -1)
 		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 
 	printout(config, id, nr, counter, uval,
@@ -731,8 +734,8 @@ static void print_aggr(struct perf_stat_config *config,
 		first = true;
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, s,
-					       prefix, metric_only,
-					       &first, /*cpu=*/-1);
+					prefix, metric_only,
+					&first, (struct perf_cpu){ .cpu = -1 });
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -893,7 +896,8 @@ static void print_counter(struct perf_stat_config *config,
 	FILE *output = config->output;
 	u64 ena, run, val;
 	double uval;
-	int idx, cpu;
+	int idx;
+	struct perf_cpu cpu;
 	struct aggr_cpu_id id;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
@@ -921,7 +925,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 char *prefix)
 {
-	int all_idx, cpu;
+	int all_idx;
+	struct perf_cpu cpu;
 
 	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.cpus) {
 		struct evsel *counter;
@@ -1211,7 +1216,8 @@ static void print_percore_thread(struct perf_stat_config *config,
 	struct aggr_cpu_id s2, id;
 	struct perf_cpu_map *cpus;
 	bool first = true;
-	int idx, cpu;
+	int idx;
+	struct perf_cpu cpu;
 
 	cpus = evsel__cpus(counter);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
@@ -1247,8 +1253,8 @@ static void print_percore(struct perf_stat_config *config,
 			fprintf(output, "%s", prefix);
 
 		print_counter_aggrdata(config, counter, s,
-				       prefix, metric_only,
-				       &first, /*cpu=*/-1);
+				prefix, metric_only,
+				&first, (struct perf_cpu){ .cpu = -1 });
 	}
 
 	if (metric_only)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 7dbd7c4f3c33..ee6f03481215 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -297,7 +297,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 {
 	struct hashmap *mask = counter->per_pkg_mask;
 	struct perf_cpu_map *cpus = evsel__cpus(counter);
-	int cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
+	struct perf_cpu cpu = perf_cpu_map__cpu(cpus, cpu_map_idx);
 	int s, d, ret = 0;
 	uint64_t *key;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 691c12fd8976..335d19cc3063 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -108,7 +108,7 @@ struct runtime_stat {
 	struct rblist value_list;
 };
 
-typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, int cpu);
+typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, struct perf_cpu cpu);
 
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 96f941e01681..4c9f211249db 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -728,7 +728,7 @@ static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 	int i;
 	int ret = 0;
 	struct perf_cpu_map *m;
-	int c;
+	struct perf_cpu c;
 
 	m = perf_cpu_map__new(s);
 	if (!m)
@@ -736,12 +736,12 @@ static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 
 	for (i = 0; i < m->nr; i++) {
 		c = m->map[i];
-		if (c >= nr_cpus) {
+		if (c.cpu >= nr_cpus) {
 			ret = -1;
 			break;
 		}
 
-		set_bit(c, cpumask_bits(b));
+		set_bit(c.cpu, cpumask_bits(b));
 	}
 
 	perf_cpu_map__put(m);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 198982109f0f..c9ba8050cc2b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1191,7 +1191,7 @@ static void synthesize_cpus(struct cpu_map_entries *cpus,
 	cpus->nr = map->nr;
 
 	for (i = 0; i < map->nr; i++)
-		cpus->cpu[i] = map->map[i];
+		cpus->cpu[i] = map->map[i].cpu;
 }
 
 static void synthesize_mask(struct perf_record_record_cpu_map *mask,
@@ -1203,7 +1203,7 @@ static void synthesize_mask(struct perf_record_record_cpu_map *mask,
 	mask->long_size = sizeof(long);
 
 	for (i = 0; i < map->nr; i++)
-		set_bit(map->map[i], mask->mask);
+		set_bit(map->map[i].cpu, mask->mask);
 }
 
 static size_t cpus_size(struct perf_cpu_map *map)
@@ -1219,7 +1219,7 @@ static size_t mask_size(struct perf_cpu_map *map, int *max)
 
 	for (i = 0; i < map->nr; i++) {
 		/* bit position of the cpu is + 1 */
-		int bit = map->map[i] + 1;
+		int bit = map->map[i].cpu + 1;
 
 		if (bit > *max)
 			*max = bit;
@@ -1354,7 +1354,7 @@ int perf_event__synthesize_stat_config(struct perf_tool *tool,
 }
 
 int perf_event__synthesize_stat(struct perf_tool *tool,
-				u32 cpu, u32 thread, u64 id,
+				struct perf_cpu cpu, u32 thread, u64 id,
 				struct perf_counts_values *count,
 				perf_event__handler_t process,
 				struct machine *machine)
@@ -1366,7 +1366,7 @@ int perf_event__synthesize_stat(struct perf_tool *tool,
 	event.header.misc = 0;
 
 	event.id        = id;
-	event.cpu       = cpu;
+	event.cpu       = cpu.cpu;
 	event.thread    = thread;
 	event.val       = count->val;
 	event.ena       = count->ena;
@@ -1763,7 +1763,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
 			}
 
 			e->idx = sid->idx;
-			e->cpu = sid->cpu;
+			e->cpu = sid->cpu.cpu;
 			e->tid = sid->tid;
 		}
 	}
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index c931433bacbf..78a0450db164 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -6,6 +6,7 @@
 #include <sys/types.h> // pid_t
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <perf/cpumap.h>
 
 struct auxtrace_record;
 struct dso;
@@ -63,7 +64,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
 int perf_event__synthesize_stat_round(struct perf_tool *tool, u64 time, u64 type, perf_event__handler_t process, struct machine *machine);
-int perf_event__synthesize_stat(struct perf_tool *tool, u32 cpu, u32 thread, u64 id, struct perf_counts_values *count, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_stat(struct perf_tool *tool, struct perf_cpu cpu, u32 thread, u64 id, struct perf_counts_values *count, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_thread_map2(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_thread_map(struct perf_tool *tool, struct perf_thread_map *threads, perf_event__handler_t process, struct machine *machine, bool needs_mmap, bool mmap_data);
 int perf_event__synthesize_threads(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine, bool needs_mmap, bool mmap_data, unsigned int nr_threads_synthesize);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9f0d36ba77f2..9443c29afa52 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,6 +11,9 @@
 #include <stddef.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
+#ifndef __cplusplus
+#include <internal/cpumap.h>
+#endif
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -66,6 +69,6 @@ extern bool test_attr__enabled;
 void test_attr__ready(void);
 void test_attr__init(void);
 struct perf_event_attr;
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, int cpu,
+void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
 		     int fd, int group_fd, unsigned long flags);
 #endif /* GIT_COMPAT_UTIL_H */
-- 
2.34.1.448.ga2b2bfdf31-goog

