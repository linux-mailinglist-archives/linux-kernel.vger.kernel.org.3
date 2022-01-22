Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF0496A18
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiAVE6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiAVE61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:58:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE2C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g7-20020a25bdc7000000b00611c616bc76so23379396ybk.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0TMY5o/dyQ5SuId4r0p3cjinmuagpPVpu9HxaMjlyFs=;
        b=DeAR0A/54ZEJ8e8t1zmQtC9KB02vVfLnz5iOu0J7GS85FCzaMxZfBZiMXsdb43cy8T
         uO4SydO4tsqYzItIiZn0LdKoJSm7n485pDJUlZPZMJqLZFYg/LuORMxjecV3YR76BNu3
         eXxHUD9plFiCe2cFU2q0NPBI7LTQ7SefNqW2MYgajASwphiJpaWBesGorpN5mg1x316k
         4oHlp+TJ+Fj4+ZCdhgEXHksDM5jGaLVAyJWnGurp2PZBGEi7JZmnhcrdL4X1rpqK8Zde
         rKlO12bO+5mPui7gCX3nJde9HxCuf+7cnufrF6/5Kuu05vVBGkTEIDVrvtkIt/B/HkoW
         /Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0TMY5o/dyQ5SuId4r0p3cjinmuagpPVpu9HxaMjlyFs=;
        b=RKrW+9W3RcbCyIKMJP+I9vBi4BI/KeX6eHyfntd4aXm0qUEUWeiJwCTrWRgVt/BPD/
         6hhMzkv2kWKFCyULg7vlQG4GE5RuAuyneHCn5kq/hniB9hUIGdGRZZnsdkahatpRsEeg
         td1WIWPLS7Gn/NC3n+sFD6aUdL6etGu81auFvpHEcjKBSlbdoa6DgFth3O+0LsfEged3
         wJTeytqCH3rd0wwscb/UT9bQT8gjMQucFXybjPVfRyElHhB1eFatJCWOsXFKhy8kTZSt
         dfU2inJ50DN4uZvuOCKpLaueX3oSME7rZh+HbsjgJT9XaL/AGWEO1uZ6vhVLFUbeWZ5s
         xA0w==
X-Gm-Message-State: AOAM532Agrwzraayx+JXjY4fP3IerQX2T5Ri+pfCB3jCJvOIQx4jLdAM
        MRhwQ7ssLK/QjZ1Xivvrbkn/YLoN3+wt
X-Google-Smtp-Source: ABdhPJzzXjXtpsFzpd5/4L/6+5gc8B+/RoD+lBkRRnRsman8Nk9iCzfcB3Oj7OgqpYPv5w93UgVuOt357CEZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6125:f911:aa9a:59ee])
 (user=irogers job=sendgmr) by 2002:a81:23d4:0:b0:2ca:287c:6c3b with SMTP id
 00721157ae682-2ca287c6e87mr07b3.224.1642827505562; Fri, 21 Jan 2022 20:58:25
 -0800 (PST)
Date:   Fri, 21 Jan 2022 20:58:11 -0800
In-Reply-To: <20220122045811.3402706-1-irogers@google.com>
Message-Id: <20220122045811.3402706-4-irogers@google.com>
Mime-Version: 1.0
References: <20220122045811.3402706-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 3/3] perf cpumap: Add reference count checking
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

Enabled when REFCNT_CHECKING is defined. The change adds a memory
allocated pointer that is interposed between the reference counted
cpu map at a get and freed by a put. The pointer replaces the original
perf_cpu_map struct, so use of the perf_cpu_map via APIs remains
unchanged. Any use of the cpu map without the API requires two versions,
typically handled via an UNWRAP macro.

This change is intended to catch:
 - use after put: using a cpumap after you have put it will cause a
   segv.
 - unbalanced puts: two puts for a get will result in a double free
   that can be captured and reported by tools like address sanitizer,
   including with the associated stack traces of allocation and frees.
 - missing puts: if a put is missing then the get turns into a memory
   leak that can be reported by leak sanitizer, including the stack
   trace at the point the get occurs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c                  | 120 ++++++++++++++++-------
 tools/lib/perf/include/internal/cpumap.h |  14 ++-
 tools/perf/tests/cpumap.c                |  20 ++--
 tools/perf/util/cpumap.c                 |  42 ++++----
 tools/perf/util/pmu.c                    |  24 +++--
 5 files changed, 146 insertions(+), 74 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ee66760f1e63..d401d133f84b 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,10 +10,16 @@
 #include <ctype.h>
 #include <limits.h>
 
-static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+#ifndef REFCNT_CHECKING
+#define UNWRAP_MAP(x) x
+#else
+#define UNWRAP_MAP(x) x->orig
+#endif
+
+#ifndef REFCNT_CHECKING
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
-
 	if (cpus != NULL) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
@@ -21,13 +27,31 @@ static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 	}
 	return cpus;
 }
+#else
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+{
+	struct perf_cpu_map *wrapped_cpus = NULL;
+	struct original_perf_cpu_map *cpus =
+		malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	if (cpus != NULL) {
+		cpus->nr = nr_cpus;
+		refcount_set(&cpus->refcnt, 1);
+		wrapped_cpus = malloc(sizeof(*wrapped_cpus));
+		if (wrapped_cpus != NULL)
+			wrapped_cpus->orig = cpus;
+		else
+			free(cpus);
+	}
+	return wrapped_cpus;
+}
+#endif
 
 struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 {
 	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
 
 	if (cpus)
-		cpus->map[0].cpu = -1;
+		UNWRAP_MAP(cpus)->map[0].cpu = -1;
 
 	return cpus;
 }
@@ -35,23 +59,45 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 static void cpu_map__delete(struct perf_cpu_map *map)
 {
 	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+		WARN_ONCE(refcount_read(&UNWRAP_MAP(map)->refcnt) != 0,
 			  "cpu_map refcnt unbalanced\n");
+#ifdef REFCNT_CHECKING
+		free(map->orig);
+		map->orig = NULL;
+#endif
 		free(map);
 	}
 }
 
 struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
 {
-	if (map)
-		refcount_inc(&map->refcnt);
+	if (map) {
+#ifdef REFCNT_CHECKING
+		struct perf_cpu_map *new_wrapper;
+#endif
+		refcount_inc(&UNWRAP_MAP(map)->refcnt);
+#ifdef REFCNT_CHECKING
+		new_wrapper = malloc(sizeof(*new_wrapper));
+		new_wrapper->orig = map->orig;
+		map = new_wrapper;
+#endif
+	}
 	return map;
 }
 
 void perf_cpu_map__put(struct perf_cpu_map *map)
 {
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_map__delete(map);
+	if (map) {
+		if (refcount_dec_and_test(&UNWRAP_MAP(map)->refcnt))
+			cpu_map__delete(map);
+		else {
+#ifdef REFCNT_CHECKING
+			/* Free the wrapper object but the reference counted object remains. */
+			map->orig = NULL;
+			free(map);
+#endif
+		}
+	}
 }
 
 static struct perf_cpu_map *cpu_map__default_new(void)
@@ -68,7 +114,7 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 		int i;
 
 		for (i = 0; i < nr_cpus; ++i)
-			cpus->map[i].cpu = i;
+			UNWRAP_MAP(cpus)->map[i].cpu = i;
 	}
 
 	return cpus;
@@ -94,15 +140,16 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu
 	int i, j;
 
 	if (cpus != NULL) {
-		memcpy(cpus->map, tmp_cpus, payload_size);
-		qsort(cpus->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
+		memcpy(UNWRAP_MAP(cpus)->map, tmp_cpus, payload_size);
+		qsort(UNWRAP_MAP(cpus)->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
 		/* Remove dups */
 		j = 0;
 		for (i = 0; i < nr_cpus; i++) {
-			if (i == 0 || cpus->map[i].cpu != cpus->map[i - 1].cpu)
-				cpus->map[j++].cpu = cpus->map[i].cpu;
+			if (i == 0 ||
+			    UNWRAP_MAP(cpus)->map[i].cpu != UNWRAP_MAP(cpus)->map[i - 1].cpu)
+				UNWRAP_MAP(cpus)->map[j++].cpu = UNWRAP_MAP(cpus)->map[i].cpu;
 		}
-		cpus->nr = j;
+		UNWRAP_MAP(cpus)->nr = j;
 		assert(j <= nr_cpus);
 	}
 	return cpus;
@@ -263,20 +310,20 @@ struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 		.cpu = -1
 	};
 
-	if (cpus && idx < cpus->nr)
-		return cpus->map[idx];
+	if (cpus && idx < UNWRAP_MAP(cpus)->nr)
+		return UNWRAP_MAP(cpus)->map[idx];
 
 	return result;
 }
 
 int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
-	return cpus ? cpus->nr : 1;
+	return cpus ? UNWRAP_MAP(cpus)->nr : 1;
 }
 
 bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
-	return map ? map->map[0].cpu == -1 : true;
+	return map ? UNWRAP_MAP(map)->map[0].cpu == -1 : true;
 }
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
@@ -287,10 +334,10 @@ int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 		return -1;
 
 	low = 0;
-	high = cpus->nr;
+	high = UNWRAP_MAP(cpus)->nr;
 	while (low < high) {
 		int idx = (low + high) / 2;
-		struct perf_cpu cpu_at_idx = cpus->map[idx];
+		struct perf_cpu cpu_at_idx = UNWRAP_MAP(cpus)->map[idx];
 
 		if (cpu_at_idx.cpu == cpu.cpu)
 			return idx;
@@ -316,7 +363,7 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 	};
 
 	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return map->nr > 0 ? map->map[map->nr - 1] : result;
+	return UNWRAP_MAP(map)->nr > 0 ? UNWRAP_MAP(map)->map[UNWRAP_MAP(map)->nr - 1] : result;
 }
 
 /*
@@ -337,37 +384,36 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 
 	if (!orig && !other)
 		return NULL;
-	if (!orig) {
-		perf_cpu_map__get(other);
-		return other;
-	}
+	if (!orig)
+		return perf_cpu_map__get(other);
 	if (!other)
 		return orig;
-	if (orig->nr == other->nr &&
-	    !memcmp(orig->map, other->map, orig->nr * sizeof(struct perf_cpu)))
+	if (UNWRAP_MAP(orig)->nr == UNWRAP_MAP(other)->nr &&
+	    !memcmp(UNWRAP_MAP(orig)->map, UNWRAP_MAP(other)->map,
+		    UNWRAP_MAP(orig)->nr * sizeof(struct perf_cpu)))
 		return orig;
 
-	tmp_len = orig->nr + other->nr;
+	tmp_len = UNWRAP_MAP(orig)->nr + UNWRAP_MAP(other)->nr;
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
 		return NULL;
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
-	while (i < orig->nr && j < other->nr) {
-		if (orig->map[i].cpu <= other->map[j].cpu) {
-			if (orig->map[i].cpu == other->map[j].cpu)
+	while (i < UNWRAP_MAP(orig)->nr && j < UNWRAP_MAP(other)->nr) {
+		if (UNWRAP_MAP(orig)->map[i].cpu <= UNWRAP_MAP(other)->map[j].cpu) {
+			if (UNWRAP_MAP(orig)->map[i].cpu == UNWRAP_MAP(other)->map[j].cpu)
 				j++;
-			tmp_cpus[k++] = orig->map[i++];
+			tmp_cpus[k++] = UNWRAP_MAP(orig)->map[i++];
 		} else
-			tmp_cpus[k++] = other->map[j++];
+			tmp_cpus[k++] = UNWRAP_MAP(other)->map[j++];
 	}
 
-	while (i < orig->nr)
-		tmp_cpus[k++] = orig->map[i++];
+	while (i < UNWRAP_MAP(orig)->nr)
+		tmp_cpus[k++] = UNWRAP_MAP(orig)->map[i++];
 
-	while (j < other->nr)
-		tmp_cpus[k++] = other->map[j++];
+	while (j < UNWRAP_MAP(other)->nr)
+		tmp_cpus[k++] = UNWRAP_MAP(other)->map[j++];
 	assert(k <= tmp_len);
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 581f9ffb4237..64ad56d167a0 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -16,7 +16,12 @@ struct perf_cpu {
  * gaps if CPU numbers were used. For events associated with a pid, rather than
  * a CPU, a single dummy map with an entry of -1 is used.
  */
-struct perf_cpu_map {
+#ifndef REFCNT_CHECKING
+struct perf_cpu_map
+#else
+struct original_perf_cpu_map
+#endif
+{
 	refcount_t	refcnt;
 	/** Length of the map array. */
 	int		nr;
@@ -24,10 +29,17 @@ struct perf_cpu_map {
 	struct perf_cpu	map[];
 };
 
+#ifdef REFCNT_CHECKING
+struct perf_cpu_map {
+	struct original_perf_cpu_map *orig;
+};
+#endif
+
 #ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS	2048
 #endif
 
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 84e87e31f119..65d9546aec6e 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -11,6 +11,12 @@
 
 struct machine;
 
+#ifndef REFCNT_CHECKING
+#define UNWRAP_CPUMAP(x) x
+#else
+#define UNWRAP_CPUMAP(x) x->orig
+#endif
+
 static int process_event_mask(struct perf_tool *tool __maybe_unused,
 			 union perf_event *event,
 			 struct perf_sample *sample __maybe_unused,
@@ -35,10 +41,10 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
 	}
 
 	map = cpu_map__new_data(data);
-	TEST_ASSERT_VAL("wrong nr",  map->nr == 20);
+	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 20);
 
 	for (i = 0; i < 20; i++) {
-		TEST_ASSERT_VAL("wrong cpu", map->map[i].cpu == i);
+		TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, i).cpu == i);
 	}
 
 	perf_cpu_map__put(map);
@@ -66,10 +72,10 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong cpu",  cpus->cpu[1] == 256);
 
 	map = cpu_map__new_data(data);
-	TEST_ASSERT_VAL("wrong nr",  map->nr == 2);
-	TEST_ASSERT_VAL("wrong cpu", map->map[0].cpu == 1);
-	TEST_ASSERT_VAL("wrong cpu", map->map[1].cpu == 256);
-	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 2);
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
+	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 1).cpu == 256);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&UNWRAP_CPUMAP(map)->refcnt) == 1);
 	perf_cpu_map__put(map);
 	return 0;
 }
@@ -130,7 +136,7 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
 	char buf[100];
 
-	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
+	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
 	perf_cpu_map__put(b);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 12b2243222b0..e9976ca238fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -22,6 +22,12 @@ static int max_node_num;
  */
 static int *cpunode_map;
 
+#ifndef REFCNT_CHECKING
+#define UNWRAP_MAP(x) x
+#else
+#define UNWRAP_MAP(x) x->orig
+#endif
+
 static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 {
 	struct perf_cpu_map *map;
@@ -37,9 +43,9 @@ static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 			 * otherwise it would become 65535.
 			 */
 			if (cpus->cpu[i] == (u16) -1)
-				map->map[i].cpu = -1;
+				UNWRAP_MAP(map)->map[i].cpu = -1;
 			else
-				map->map[i].cpu = (int) cpus->cpu[i];
+				UNWRAP_MAP(map)->map[i].cpu = (int) cpus->cpu[i];
 		}
 	}
 
@@ -58,7 +64,7 @@ static struct perf_cpu_map *cpu_map__from_mask(struct perf_record_record_cpu_map
 		int cpu, i = 0;
 
 		for_each_set_bit(cpu, mask->mask, nbits)
-			map->map[i++].cpu = cpu;
+			UNWRAP_MAP(map)->map[i++].cpu = cpu;
 	}
 	return map;
 
@@ -84,16 +90,13 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 {
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(nr);
 
 	if (cpus != NULL) {
 		int i;
 
-		cpus->nr = nr;
 		for (i = 0; i < nr; i++)
-			cpus->map[i].cpu = -1;
-
-		refcount_set(&cpus->refcnt, 1);
+			UNWRAP_MAP(cpus)->map[i].cpu = -1;
 	}
 
 	return cpus;
@@ -163,7 +166,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 {
 	int idx;
 	struct perf_cpu cpu;
-	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
+	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(perf_cpu_map__nr(cpus));
 
 	if (!c)
 		return NULL;
@@ -187,7 +190,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 		}
 	}
 	/* Trim. */
-	if (c->nr != cpus->nr) {
+	if (c->nr != perf_cpu_map__nr(cpus)) {
 		struct cpu_aggr_map *trimmed_c =
 			realloc(c,
 				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
@@ -494,31 +497,32 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 
 #define COMMA first ? "" : ","
 
-	for (i = 0; i < map->nr + 1; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
 		struct perf_cpu cpu = { .cpu = INT_MAX };
-		bool last = i == map->nr;
+		bool last = i == perf_cpu_map__nr(map);
 
 		if (!last)
-			cpu = map->map[i];
+			cpu = perf_cpu_map__cpu(map, i);
 
 		if (start == -1) {
 			start = i;
 			if (last) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[i].cpu);
+						perf_cpu_map__cpu(map, i).cpu);
 			}
-		} else if (((i - start) != (cpu.cpu - map->map[start].cpu)) || last) {
+		} else if (((i - start) != (cpu.cpu - perf_cpu_map__cpu(map, start).cpu)) || last) {
 			int end = i - 1;
 
 			if (start == end) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[start].cpu);
+						perf_cpu_map__cpu(map, start).cpu);
 			} else {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d-%d", COMMA,
-						map->map[start].cpu, map->map[end].cpu);
+						perf_cpu_map__cpu(map, start).cpu,
+						perf_cpu_map__cpu(map, end).cpu);
 			}
 			first = false;
 			start = i;
@@ -545,7 +549,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
+	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, perf_cpu_map__nr(map) - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -556,7 +560,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 		return 0;
 	}
 
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		cpu = perf_cpu_map__cpu(map, i).cpu;
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8dfbba15aeb8..1649321fe86f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1992,13 +1992,20 @@ int perf_pmu__match(char *pattern, char *name, char *tok)
 	return 0;
 }
 
+#ifndef REFCNT_CHECKING
+#define UNWRAP_CPUMAP(x) x
+#else
+#define UNWRAP_CPUMAP(x) x->orig
+#endif
+
 int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 			 struct perf_cpu_map **mcpus_ptr,
 			 struct perf_cpu_map **ucpus_ptr)
 {
 	struct perf_cpu_map *pmu_cpus = pmu->cpus;
 	struct perf_cpu_map *matched_cpus, *unmatched_cpus;
-	int matched_nr = 0, unmatched_nr = 0;
+	struct perf_cpu cpu;
+	int i, matched_nr = 0, unmatched_nr = 0;
 
 	matched_cpus = perf_cpu_map__default_new();
 	if (!matched_cpus)
@@ -2010,18 +2017,15 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 		return -1;
 	}
 
-	for (int i = 0; i < cpus->nr; i++) {
-		int cpu;
-
-		cpu = perf_cpu_map__idx(pmu_cpus, cpus->map[i]);
-		if (cpu == -1)
-			unmatched_cpus->map[unmatched_nr++] = cpus->map[i];
+	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
+		if (!perf_cpu_map__has(pmu_cpus, cpu))
+			UNWRAP_CPUMAP(unmatched_cpus)->map[unmatched_nr++] = cpu;
 		else
-			matched_cpus->map[matched_nr++] = cpus->map[i];
+			UNWRAP_CPUMAP(matched_cpus)->map[matched_nr++] = cpu;
 	}
 
-	unmatched_cpus->nr = unmatched_nr;
-	matched_cpus->nr = matched_nr;
+	UNWRAP_CPUMAP(unmatched_cpus)->nr = unmatched_nr;
+	UNWRAP_CPUMAP(matched_cpus)->nr = matched_nr;
 	*mcpus_ptr = matched_cpus;
 	*ucpus_ptr = unmatched_cpus;
 	return 0;
-- 
2.35.0.rc0.227.g00780c9af4-goog

