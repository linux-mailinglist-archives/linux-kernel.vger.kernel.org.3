Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF64B2332
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239277AbiBKKfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349037AbiBKKfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5650EB7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso17826696ybs.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6d1r0MKAfef54H2RZ8ZU6nqFJP/LwK7hjdkyzVqNyNE=;
        b=adBVbCtuDAkvGvULrIi9dR+76CQ5f0L1d85ql1LgTNYCSJL5iIr1DWLSacUS9S1216
         KBNU1mOSYB1wUlU+t8tshnhHoEFiVJphdI08sDeT9G+p9N8YT5L/ZgBhHRD23WxQBnVK
         1nvz1E8O2PpRI4OWr7gtuL4+d76T/WPO3y5wn8u6k6tEQITml4g2x5gMX4NgkCzKATKl
         DQDHBCNNRTOpUu8YuNjjEjjQxp724ELO98i9oVFGAWi2AiUB3igSQVaKqU/Q4TUWCLke
         ar0JWeHoufoIgZO24ePXZm0PYoGKVG6Zxt3W9Bg8mALWILFAMnBqa2BzhQGmo8/wKEi3
         mL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6d1r0MKAfef54H2RZ8ZU6nqFJP/LwK7hjdkyzVqNyNE=;
        b=iAv7s/4CjQgq8JL+s57Rgbq0fdQEBQcL4B0Saw8t5L1jZUIr6AgjCmMbgB1LD+5N14
         bRW5eyuv4wnGvNmEU1NokOWpVwfwy30+LbNRFES/478cLMKMLjLdREfTyGd9PfwaNRzP
         RpQi1GI3jvPhkJjJi5Joa+aXzoWdB2MWQlQSya9vDpneo2v8f3G0wkmL+eSUPC19LkOi
         KwmJwIbOqp4nms5jo0U75pPOjUmEbbLJ13zY/M6AcjMiJwxRldVQOMHPAyRbOKbLKR+V
         VTJG/DX7cnlqROOywTGmO/Ce0LHGHos1qE91k3kwUsA2IILhGwAjYi2OOJ00OwY4J9k7
         cNcg==
X-Gm-Message-State: AOAM5303m3qVbYUlGMI8WVsjLNmatShJV9HSmfGZ8An552JQfqvnPelE
        cjl6yrDaY1oNDFQVb5HoQp/NOngNSH2e
X-Google-Smtp-Source: ABdhPJx5N2Rhxk1SA+wWm70Cy0hPH0HhHxn80mBgqfJXr5J94aJH5piE7O8/ZWeAb9W9PSa6DvTbdxQJAJ3J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a81:c644:: with SMTP id
 q4mr938106ywj.206.1644575707943; Fri, 11 Feb 2022 02:35:07 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:12 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-20-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 19/22] perf cpumap: Add reference count checking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabled when REFCNT_CHECKING is defined. The change adds a memory
allocated pointer that is interposed between the reference counted
cpu map at a get and freed by a put. The pointer replaces the original
perf_cpu_map struct, so use of the perf_cpu_map via APIs remains
unchanged. Any use of the cpu map without the API requires two versions,
handled via the RC_CHK_ACCESS macro.

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
 tools/lib/perf/cpumap.c                  | 93 +++++++++++++-----------
 tools/lib/perf/include/internal/cpumap.h |  4 +-
 tools/perf/tests/cpumap.c                |  2 +-
 tools/perf/util/cpumap.c                 | 36 +++++----
 tools/perf/util/pmu.c                    |  8 +-
 5 files changed, 75 insertions(+), 68 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ee66760f1e63..e22cfed7a633 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,16 +10,16 @@
 #include <ctype.h>
 #include <limits.h>
 
-static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
-
-	if (cpus != NULL) {
+	struct perf_cpu_map *result;
+	RC_STRUCT(perf_cpu_map) *cpus =
+		malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-
 	}
-	return cpus;
+	return result;
 }
 
 struct perf_cpu_map *perf_cpu_map__dummy_new(void)
@@ -27,7 +27,7 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
 
 	if (cpus)
-		cpus->map[0].cpu = -1;
+		RC_CHK_ACCESS(cpus)->map[0].cpu = -1;
 
 	return cpus;
 }
@@ -35,23 +35,30 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 static void cpu_map__delete(struct perf_cpu_map *map)
 {
 	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+		WARN_ONCE(refcount_read(&RC_CHK_ACCESS(map)->refcnt) != 0,
 			  "cpu_map refcnt unbalanced\n");
-		free(map);
+		RC_CHK_FREE(map);
 	}
 }
 
 struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
 {
-	if (map)
-		refcount_inc(&map->refcnt);
-	return map;
+	struct perf_cpu_map *result;
+
+	if (RC_CHK_GET(result, map))
+		refcount_inc(&RC_CHK_ACCESS(map)->refcnt);
+
+	return result;
 }
 
 void perf_cpu_map__put(struct perf_cpu_map *map)
 {
-	if (map && refcount_dec_and_test(&map->refcnt))
-		cpu_map__delete(map);
+	if (map) {
+		if (refcount_dec_and_test(&RC_CHK_ACCESS(map)->refcnt))
+			cpu_map__delete(map);
+		else
+			RC_CHK_PUT(map);
+	}
 }
 
 static struct perf_cpu_map *cpu_map__default_new(void)
@@ -68,7 +75,7 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 		int i;
 
 		for (i = 0; i < nr_cpus; ++i)
-			cpus->map[i].cpu = i;
+			RC_CHK_ACCESS(cpus)->map[i].cpu = i;
 	}
 
 	return cpus;
@@ -94,15 +101,16 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu
 	int i, j;
 
 	if (cpus != NULL) {
-		memcpy(cpus->map, tmp_cpus, payload_size);
-		qsort(cpus->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
+		memcpy(RC_CHK_ACCESS(cpus)->map, tmp_cpus, payload_size);
+		qsort(RC_CHK_ACCESS(cpus)->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
 		/* Remove dups */
 		j = 0;
 		for (i = 0; i < nr_cpus; i++) {
-			if (i == 0 || cpus->map[i].cpu != cpus->map[i - 1].cpu)
-				cpus->map[j++].cpu = cpus->map[i].cpu;
+			if (i == 0 ||
+			    RC_CHK_ACCESS(cpus)->map[i].cpu != RC_CHK_ACCESS(cpus)->map[i - 1].cpu)
+				RC_CHK_ACCESS(cpus)->map[j++].cpu = RC_CHK_ACCESS(cpus)->map[i].cpu;
 		}
-		cpus->nr = j;
+		RC_CHK_ACCESS(cpus)->nr = j;
 		assert(j <= nr_cpus);
 	}
 	return cpus;
@@ -263,20 +271,20 @@ struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 		.cpu = -1
 	};
 
-	if (cpus && idx < cpus->nr)
-		return cpus->map[idx];
+	if (cpus && idx < RC_CHK_ACCESS(cpus)->nr)
+		return RC_CHK_ACCESS(cpus)->map[idx];
 
 	return result;
 }
 
 int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
 {
-	return cpus ? cpus->nr : 1;
+	return cpus ? RC_CHK_ACCESS(cpus)->nr : 1;
 }
 
 bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 {
-	return map ? map->map[0].cpu == -1 : true;
+	return map ? RC_CHK_ACCESS(map)->map[0].cpu == -1 : true;
 }
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
@@ -287,10 +295,10 @@ int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 		return -1;
 
 	low = 0;
-	high = cpus->nr;
+	high = RC_CHK_ACCESS(cpus)->nr;
 	while (low < high) {
 		int idx = (low + high) / 2;
-		struct perf_cpu cpu_at_idx = cpus->map[idx];
+		struct perf_cpu cpu_at_idx = RC_CHK_ACCESS(cpus)->map[idx];
 
 		if (cpu_at_idx.cpu == cpu.cpu)
 			return idx;
@@ -316,7 +324,7 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 	};
 
 	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return map->nr > 0 ? map->map[map->nr - 1] : result;
+	return RC_CHK_ACCESS(map)->nr > 0 ? RC_CHK_ACCESS(map)->map[RC_CHK_ACCESS(map)->nr - 1] : result;
 }
 
 /*
@@ -337,37 +345,36 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
 
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
+	if (RC_CHK_ACCESS(orig)->nr == RC_CHK_ACCESS(other)->nr &&
+	    !memcmp(RC_CHK_ACCESS(orig)->map, RC_CHK_ACCESS(other)->map,
+		    RC_CHK_ACCESS(orig)->nr * sizeof(struct perf_cpu)))
 		return orig;
 
-	tmp_len = orig->nr + other->nr;
+	tmp_len = RC_CHK_ACCESS(orig)->nr + RC_CHK_ACCESS(other)->nr;
 	tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
 	if (!tmp_cpus)
 		return NULL;
 
 	/* Standard merge algorithm from wikipedia */
 	i = j = k = 0;
-	while (i < orig->nr && j < other->nr) {
-		if (orig->map[i].cpu <= other->map[j].cpu) {
-			if (orig->map[i].cpu == other->map[j].cpu)
+	while (i < RC_CHK_ACCESS(orig)->nr && j < RC_CHK_ACCESS(other)->nr) {
+		if (RC_CHK_ACCESS(orig)->map[i].cpu <= RC_CHK_ACCESS(other)->map[j].cpu) {
+			if (RC_CHK_ACCESS(orig)->map[i].cpu == RC_CHK_ACCESS(other)->map[j].cpu)
 				j++;
-			tmp_cpus[k++] = orig->map[i++];
+			tmp_cpus[k++] = RC_CHK_ACCESS(orig)->map[i++];
 		} else
-			tmp_cpus[k++] = other->map[j++];
+			tmp_cpus[k++] = RC_CHK_ACCESS(other)->map[j++];
 	}
 
-	while (i < orig->nr)
-		tmp_cpus[k++] = orig->map[i++];
+	while (i < RC_CHK_ACCESS(orig)->nr)
+		tmp_cpus[k++] = RC_CHK_ACCESS(orig)->map[i++];
 
-	while (j < other->nr)
-		tmp_cpus[k++] = other->map[j++];
+	while (j < RC_CHK_ACCESS(other)->nr)
+		tmp_cpus[k++] = RC_CHK_ACCESS(other)->map[j++];
 	assert(k <= tmp_len);
 
 	merged = cpu_map__trim_new(k, tmp_cpus);
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 581f9ffb4237..1a584d4f125c 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_INTERNAL_CPUMAP_H
 
 #include <linux/refcount.h>
+#include <internal/rc_check.h>
 
 /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
 struct perf_cpu {
@@ -16,7 +17,7 @@ struct perf_cpu {
  * gaps if CPU numbers were used. For events associated with a pid, rather than
  * a CPU, a single dummy map with an entry of -1 is used.
  */
-struct perf_cpu_map {
+DECLARE_RC_STRUCT(perf_cpu_map) {
 	refcount_t	refcnt;
 	/** Length of the map array. */
 	int		nr;
@@ -28,6 +29,7 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index f94929ebb54b..d4a7c289b062 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -69,7 +69,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 2);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 1).cpu == 256);
-	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&RC_CHK_ACCESS(map)->refcnt) == 1);
 	perf_cpu_map__put(map);
 	return 0;
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 12b2243222b0..d35a849c896a 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -37,9 +37,9 @@ static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
 			 * otherwise it would become 65535.
 			 */
 			if (cpus->cpu[i] == (u16) -1)
-				map->map[i].cpu = -1;
+				RC_CHK_ACCESS(map)->map[i].cpu = -1;
 			else
-				map->map[i].cpu = (int) cpus->cpu[i];
+				RC_CHK_ACCESS(map)->map[i].cpu = (int) cpus->cpu[i];
 		}
 	}
 
@@ -58,7 +58,7 @@ static struct perf_cpu_map *cpu_map__from_mask(struct perf_record_record_cpu_map
 		int cpu, i = 0;
 
 		for_each_set_bit(cpu, mask->mask, nbits)
-			map->map[i++].cpu = cpu;
+			RC_CHK_ACCESS(map)->map[i++].cpu = cpu;
 	}
 	return map;
 
@@ -84,16 +84,13 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 
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
+			RC_CHK_ACCESS(cpus)->map[i].cpu = -1;
 	}
 
 	return cpus;
@@ -163,7 +160,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 {
 	int idx;
 	struct perf_cpu cpu;
-	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
+	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(perf_cpu_map__nr(cpus));
 
 	if (!c)
 		return NULL;
@@ -187,7 +184,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 		}
 	}
 	/* Trim. */
-	if (c->nr != cpus->nr) {
+	if (c->nr != perf_cpu_map__nr(cpus)) {
 		struct cpu_aggr_map *trimmed_c =
 			realloc(c,
 				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
@@ -494,31 +491,32 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 
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
@@ -545,7 +543,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
+	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, perf_cpu_map__nr(map) - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -556,7 +554,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 		return 0;
 	}
 
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		cpu = perf_cpu_map__cpu(map, i).cpu;
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9a1c7e63e663..015aa92100ab 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2013,13 +2013,13 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 
 	perf_cpu_map__for_each_cpu(cpu, i, cpus) {
 		if (!perf_cpu_map__has(pmu_cpus, cpu))
-			unmatched_cpus->map[unmatched_nr++] = cpu;
+			RC_CHK_ACCESS(unmatched_cpus)->map[unmatched_nr++] = cpu;
 		else
-			matched_cpus->map[matched_nr++] = cpu;
+			RC_CHK_ACCESS(matched_cpus)->map[matched_nr++] = cpu;
 	}
 
-	unmatched_cpus->nr = unmatched_nr;
-	matched_cpus->nr = matched_nr;
+	RC_CHK_ACCESS(unmatched_cpus)->nr = unmatched_nr;
+	RC_CHK_ACCESS(matched_cpus)->nr = matched_nr;
 	*mcpus_ptr = matched_cpus;
 	*ucpus_ptr = unmatched_cpus;
 	return 0;
-- 
2.35.1.265.g69c8d7142f-goog

