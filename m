Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8173D575BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiGOGiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiGOGhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BAF675A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j2-20020a2597c2000000b0064b3e54191aso3367174ybo.20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z9xTFRxAbsalmBAh8aaG1sGBphgh09dtR9lwa15eXZE=;
        b=D422lL+jg65vnEDoVO0nwAQk1n1l2e9Cs3fOdNChQD4L7VQjBuT8+f0bkqEvMhaXs9
         KOAyhD4PvpQBIZ2W6KO/95lAPxVHya6U5NaA62gYJD0YZuX+/iTVjDLVyEuv5MiDnBEa
         IMWKQa0tJQcaEICRP7Nvq4vR2k43NbILtb1aHxVVPGbrEGc5pVhvbUnXRAGFKhayM+Fu
         yokduYexmTN5j2qsDh3qO3Gaxnrm8W+bXhNP8WOqqR/wPJpl+G+CagiyCMKasbiZ2l/y
         1AKRiL/SgZFLLtMtwqP7KGO8ylxcBdWmUzduo9JFBd7odf7sgOY2QAX8DaeY5fow7kl6
         0R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z9xTFRxAbsalmBAh8aaG1sGBphgh09dtR9lwa15eXZE=;
        b=jVBpBuok26zmSs9o3UwG1wrFWeU9d5ZCd8Gs1Y573uUAOyxnl67Jo5BMOj3KKrNx8D
         GwEQauIpqOFPFgTFvXR01s+c+S36AeTw29NxJzlx9u9ey91E1FxTbgKfzC2DtghOYLM0
         JaKrNNi8eRP784hwKbGQNDB1mMl1ZIDEcIxFAgTcQuJOG1A7R+y90QAJeap7JyCmkW6x
         G1XgxAQ/mMgq66UNRtgBHdMAATvkXp4zCL5wEvC1ZUVWHH73r7E3u9YK2VcRs30n23i/
         ss2zkslFQ8fMJLqMRowqj7GI9i+r95p+h0Whp8yNq3/wOrz33833UCtc/vBY1ft0sZqU
         Lxbg==
X-Gm-Message-State: AJIora/8PTplQrF0hGMzSXAzb0L8rSK4dRjCaLAcmrPjd3dM7Y0ril5o
        FiRPLAJeyixBlNW1zY56WZFl4FEVg45t
X-Google-Smtp-Source: AGRyM1s6yorOIQnW6oCrz6vS+65nPHWdPdTf6qoeXtxnBu8a9eC0o9WZokksDQkIRk193GSmVuCP32laP9PY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1184:b0:66e:756d:3baa with SMTP
 id m4-20020a056902118400b0066e756d3baamr12308695ybu.533.1657867056537; Thu,
 14 Jul 2022 23:37:36 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:47 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-10-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 09/15] perf pmu-events: Hide pmu_events_map
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Move usage of the table to pmu-events.c so it may be hidden. By
abstracting the table the implementation can later be changed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c |  81 ++++++++-
 tools/perf/pmu-events/jevents.py         |  81 ++++++++-
 tools/perf/pmu-events/pmu-events.h       |  29 +--
 tools/perf/tests/pmu-events.c            | 218 +++++++++++------------
 tools/perf/util/metricgroup.c            |  15 +-
 tools/perf/util/pmu.c                    |  34 +---
 tools/perf/util/pmu.h                    |   2 +-
 7 files changed, 280 insertions(+), 180 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 216ea0482c37..8ef75aff996c 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -6,6 +6,8 @@
  * The test cpu/soc is provided for testing.
  */
 #include "pmu-events/pmu-events.h"
+#include "util/header.h"
+#include "util/pmu.h"
 #include <string.h>
 #include <stddef.h>
 
@@ -110,7 +112,26 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 	},
 };
 
-const struct pmu_events_map pmu_events_map[] = {
+
+/*
+ * Map a CPU to its table of PMU events. The CPU is identified by the
+ * cpuid field, which is an arch-specific identifier for the CPU.
+ * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
+ *
+ * The  cpuid can contain any character other than the comma.
+ */
+struct pmu_events_map {
+	const char *arch;
+	const char *cpuid;
+	const struct pmu_event *table;
+};
+
+/*
+ * Global table mapping each known CPU for the architecture to its
+ * table of PMU events.
+ */
+static const struct pmu_events_map pmu_events_map[] = {
 	{
 		.arch = "testarch",
 		.cpuid = "testcpu",
@@ -162,6 +183,62 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 };
 
+const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
+{
+	const struct pmu_event *table = NULL;
+	char *cpuid = perf_pmu__getcpuid(pmu);
+	int i;
+
+	/* on some platforms which uses cpus map, cpuid can be NULL for
+	 * PMUs other than CORE PMUs.
+	 */
+	if (!cpuid)
+		return NULL;
+
+	i = 0;
+	for (;;) {
+		const struct pmu_events_map *map = &pmu_events_map[i++];
+
+		if (!map->table)
+			break;
+
+		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+			table = map->table;
+			break;
+		}
+	}
+	free(cpuid);
+	return table;
+}
+
+const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid)
+{
+	for (const struct pmu_events_map *tables = &pmu_events_map[0];
+	     tables->table;
+	     tables++) {
+		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+			return tables->table;
+	}
+	return NULL;
+}
+
+int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
+{
+	for (const struct pmu_events_map *tables = &pmu_events_map[0];
+	     tables->table;
+	     tables++) {
+		for (const struct pmu_event *pe = &tables->table[0];
+		     pe->name || pe->metric_group || pe->metric_name;
+		     pe++) {
+			int ret = fn(pe, &tables->table[0], data);
+
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 const struct pmu_event *find_sys_events_table(const char *name)
 {
 	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
@@ -181,7 +258,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 		for (const struct pmu_event *pe = &tables->table[0];
 		     pe->name || pe->metric_group || pe->metric_name;
 		     pe++) {
-			int ret = fn(pe, data);
+			int ret = fn(pe, &tables->table[0], data);
 
 			if (ret)
 				return ret;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 432ecb5a33f5..800db6364078 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -334,7 +334,27 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
 def print_mapping_table(archs: Sequence[str]) -> None:
   """Read the mapfile and generate the struct from cpuid string to event table."""
-  _args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
+  _args.output_file.write("""
+/*
+ * Map a CPU to its table of PMU events. The CPU is identified by the
+ * cpuid field, which is an arch-specific identifier for the CPU.
+ * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
+ *
+ * The  cpuid can contain any character other than the comma.
+ */
+struct pmu_events_map {
+        const char *arch;
+        const char *cpuid;
+        const struct pmu_event *table;
+};
+
+/*
+ * Global table mapping each known CPU for the architecture to its
+ * table of PMU events.
+ */
+const struct pmu_events_map pmu_events_map[] = {
+""")
   for arch in archs:
     if arch == 'test':
       _args.output_file.write("""{
@@ -390,6 +410,61 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 \t},
 };
 
+const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
+{
+        const struct pmu_event *table = NULL;
+        char *cpuid = perf_pmu__getcpuid(pmu);
+        int i;
+
+        /* on some platforms which uses cpus map, cpuid can be NULL for
+         * PMUs other than CORE PMUs.
+         */
+        if (!cpuid)
+                return NULL;
+
+        i = 0;
+        for (;;) {
+                const struct pmu_events_map *map = &pmu_events_map[i++];
+                if (!map->table)
+                        break;
+
+                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+                        table = map->table;
+                        break;
+                }
+        }
+        free(cpuid);
+        return table;
+}
+
+const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid)
+{
+        for (const struct pmu_events_map *tables = &pmu_events_map[0];
+             tables->table;
+             tables++) {
+                if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+                        return tables->table;
+        }
+        return NULL;
+}
+
+int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
+{
+        for (const struct pmu_events_map *tables = &pmu_events_map[0];
+             tables->table;
+             tables++) {
+                for (const struct pmu_event *pe = &tables->table[0];
+                     pe->name || pe->metric_group || pe->metric_name;
+                     pe++) {
+                        int ret = fn(pe, &tables->table[0], data);
+
+                        if (ret)
+                                return ret;
+                }
+        }
+        return 0;
+}
+
 const struct pmu_event *find_sys_events_table(const char *name)
 {
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
@@ -409,7 +484,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
                 for (const struct pmu_event *pe = &tables->table[0];
                      pe->name || pe->metric_group || pe->metric_name;
                      pe++) {
-                        int ret = fn(pe, data);
+                        int ret = fn(pe, &tables->table[0], data);
 
                         if (ret)
                                 return ret;
@@ -450,6 +525,8 @@ def main() -> None:
 
   _args.output_file.write("""
 #include "pmu-events/pmu-events.h"
+#include "util/header.h"
+#include "util/pmu.h"
 #include <string.h>
 #include <stddef.h>
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 2386212b1df0..485e730f9922 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -2,6 +2,8 @@
 #ifndef PMU_EVENTS_H
 #define PMU_EVENTS_H
 
+struct perf_pmu;
+
 enum aggr_mode_class {
 	PerChip = 1,
 	PerCore
@@ -28,30 +30,15 @@ struct pmu_event {
 	const char *metric_constraint;
 };
 
-/*
- *
- * Map a CPU to its table of PMU events. The CPU is identified by the
- * cpuid field, which is an arch-specific identifier for the CPU.
- * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
- * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
- *
- * The  cpuid can contain any character other than the comma.
- */
-struct pmu_events_map {
-	const char *arch;
-	const char *cpuid;
-	const struct pmu_event *table;
-};
+typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
+				 const struct pmu_event *table,
+				 void *data);
 
-/*
- * Global table mapping each known CPU for the architecture to its
- * table of PMU events.
- */
-extern const struct pmu_events_map pmu_events_map[];
+const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu);
+const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid);
+int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
 
 const struct pmu_event *find_sys_events_table(const char *name);
-
-typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe, void *data);
 int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data);
 
 #endif
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 6c3d22d00219..62e41b9c67dd 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -272,18 +272,6 @@ static bool is_same(const char *reference, const char *test)
 	return !strcmp(reference, test);
 }
 
-static const struct pmu_event *__test_pmu_get_events_table(void)
-{
-	for (const struct pmu_events_map *map = &pmu_events_map[0]; map->cpuid; map++) {
-		if (!strcmp(map->cpuid, "testcpu"))
-			return map->table;
-	}
-
-	pr_err("could not find test events map\n");
-
-	return NULL;
-}
-
 static int compare_pmu_events(const struct pmu_event *e1, const struct pmu_event *e2)
 {
 	if (!is_same(e1->name, e2->name)) {
@@ -438,7 +426,7 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 				 int subtest __maybe_unused)
 {
 	const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
-	const struct pmu_event *table = __test_pmu_get_events_table();
+	const struct pmu_event *table = find_core_events_table("testarch", "testcpu");
 	int map_events = 0, expected_events;
 
 	/* ignore 3x sentinels */
@@ -534,7 +522,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	struct perf_pmu *pmu;
 	LIST_HEAD(aliases);
 	int res = 0;
-	const struct pmu_event *table = __test_pmu_get_events_table();
+	const struct pmu_event *table = find_core_events_table("testarch", "testcpu");
 	struct perf_pmu_alias *a, *tmp;
 
 	if (!table)
@@ -591,7 +579,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	LIST_HEAD(aliases);
 	int res = 0;
 
-	events_table = __test_pmu_get_events_table();
+	events_table = find_core_events_table("testarch", "testcpu");
 	if (!events_table)
 		return -1;
 	pmu_add_cpu_aliases_map(&aliases, pmu, events_table);
@@ -836,11 +824,6 @@ static int check_parse_fake(const char *id)
 	return ret;
 }
 
-static void expr_failure(const char *msg, const struct pmu_event *pe)
-{
-	pr_debug("%s\nOn metric %s\nOn expression %s\n", msg, pe->metric_name, pe->metric_expr);
-}
-
 struct metric {
 	struct list_head list;
 	struct metric_ref metric_ref;
@@ -906,93 +889,100 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 
 }
 
-static int test__parsing(struct test_suite *test __maybe_unused,
-			 int subtest __maybe_unused)
+static void expr_failure(const char *msg, const struct pmu_event *pe)
 {
-	const struct pmu_event *cpus_table = pmu_events_map__find();
-	const struct pmu_event *pe;
-	int i, j, k;
-	int ret = 0;
+	pr_debug("%s\nOn metric %s\nOn expression %s\n", msg, pe->metric_name, pe->metric_expr);
+}
+
+
+struct test__parsing_data {
+	const struct pmu_event *cpus_table;
 	struct expr_parse_ctx *ctx;
+	int failures;
+};
+
+static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_event *table,
+				  void *vdata)
+{
+	struct test__parsing_data *data = vdata;
+	struct metric *metric, *tmp;
+	struct hashmap_entry *cur;
+	LIST_HEAD(compound_list);
+	size_t bkt;
+	int k;
 	double result;
 
-	ctx = expr__ctx_new();
-	if (!ctx) {
-		pr_debug("expr__ctx_new failed");
-		return TEST_FAIL;
+	if (!pe->metric_expr)
+		return 0;
+
+	pr_debug("Found metric '%s'\n", pe->metric_name);
+
+	expr__ctx_clear(data->ctx);
+	if (expr__find_ids(pe->metric_expr, NULL, data->ctx) < 0) {
+		expr_failure("Parse find ids failed", pe);
+		data->failures++;
+		return 0;
 	}
-	i = 0;
-	for (;;) {
-		const struct pmu_events_map *map = &pmu_events_map[i++];
 
-		if (!map->table)
-			break;
-		j = 0;
-		for (;;) {
-			struct metric *metric, *tmp;
-			struct hashmap_entry *cur;
-			LIST_HEAD(compound_list);
-			size_t bkt;
-
-			pe = &map->table[j++];
-			if (!pe->name && !pe->metric_group && !pe->metric_name)
-				break;
-			if (!pe->metric_expr)
-				continue;
-			expr__ctx_clear(ctx);
-			if (expr__find_ids(pe->metric_expr, NULL, ctx) < 0) {
-				expr_failure("Parse find ids failed", pe);
-				ret++;
-				continue;
-			}
+	if (resolve_metric_simple(data->ctx, &compound_list, table,
+				  pe->metric_name)) {
+		expr_failure("Could not resolve metrics", pe);
+		data->failures++;
+		return TEST_FAIL; /* Don't tolerate errors due to severity */
+	}
 
-			if (resolve_metric_simple(ctx, &compound_list, map->table,
-						  pe->metric_name)) {
-				expr_failure("Could not resolve metrics", pe);
-				ret++;
-				goto exit; /* Don't tolerate errors due to severity */
-			}
+	/*
+	 * Add all ids with a made up value. The value may trigger divide by
+	 * zero when subtracted and so try to make them unique.
+	 */
+	k = 1;
+	hashmap__for_each_entry(data->ctx->ids, cur, bkt)
+		expr__add_id_val(data->ctx, strdup(cur->key), k++);
 
-			/*
-			 * Add all ids with a made up value. The value may
-			 * trigger divide by zero when subtracted and so try to
-			 * make them unique.
-			 */
-			k = 1;
-			hashmap__for_each_entry(ctx->ids, cur, bkt)
-				expr__add_id_val(ctx, strdup(cur->key), k++);
-
-			hashmap__for_each_entry(ctx->ids, cur, bkt) {
-				if (check_parse_cpu(cur->key, map->table == cpus_table,
-						   pe))
-					ret++;
-			}
+	hashmap__for_each_entry(data->ctx->ids, cur, bkt) {
+		if (check_parse_cpu(cur->key, table == data->cpus_table, pe))
+			data->failures++;
+	}
 
-			list_for_each_entry_safe(metric, tmp, &compound_list, list) {
-				expr__add_ref(ctx, &metric->metric_ref);
-				free(metric);
-			}
+	list_for_each_entry_safe(metric, tmp, &compound_list, list) {
+		expr__add_ref(data->ctx, &metric->metric_ref);
+		free(metric);
+	}
 
-			if (expr__parse(&result, ctx, pe->metric_expr)) {
-				/*
-				 * Parsing failed, make numbers go from large to
-				 * small which can resolve divide by zero
-				 * issues.
-				 */
-				k = 1024;
-				hashmap__for_each_entry(ctx->ids, cur, bkt)
-					expr__add_id_val(ctx, strdup(cur->key), k--);
-				if (expr__parse(&result, ctx, pe->metric_expr)) {
-					expr_failure("Parse failed", pe);
-					ret++;
-				}
-			}
+	if (expr__parse(&result, data->ctx, pe->metric_expr)) {
+		/*
+		 * Parsing failed, make numbers go from large to small which can
+		 * resolve divide by zero issues.
+		 */
+		k = 1024;
+		hashmap__for_each_entry(data->ctx->ids, cur, bkt)
+			expr__add_id_val(data->ctx, strdup(cur->key), k--);
+		if (expr__parse(&result, data->ctx, pe->metric_expr)) {
+			expr_failure("Parse failed", pe);
+			data->failures++;
 		}
 	}
-	expr__ctx_free(ctx);
-	/* TODO: fail when not ok */
-exit:
-	return ret == 0 ? TEST_OK : TEST_SKIP;
+	return 0;
+}
+
+static int test__parsing(struct test_suite *test __maybe_unused,
+			 int subtest __maybe_unused)
+{
+	struct test__parsing_data data = {
+		.cpus_table = pmu_events_map__find(),
+		.ctx = expr__ctx_new(),
+		.failures = 0,
+	};
+
+	if (!data.ctx) {
+		pr_debug("expr__ctx_new failed");
+		return TEST_FAIL;
+	}
+	pmu_for_each_core_event(test__parsing_callback, &data);
+	pmu_for_each_sys_event(test__parsing_callback, &data);
+
+	expr__ctx_free(data.ctx);
+	return data.failures == 0 ? TEST_OK : TEST_FAIL;
 }
 
 struct test_metric {
@@ -1064,6 +1054,16 @@ static int metric_parse_fake(const char *str)
 	return ret;
 }
 
+static int test__parsing_fake_callback(const struct pmu_event *pe,
+				       const struct pmu_event *table __maybe_unused,
+				       void *data __maybe_unused)
+{
+	if (!pe->metric_expr)
+		return 0;
+
+	return metric_parse_fake(pe->metric_expr);
+}
+
 /*
  * Parse all the metrics for current architecture,
  * or all defined cpus via the 'fake_pmu'
@@ -1072,37 +1072,19 @@ static int metric_parse_fake(const char *str)
 static int test__parsing_fake(struct test_suite *test __maybe_unused,
 			      int subtest __maybe_unused)
 {
-	unsigned int i, j;
 	int err = 0;
 
-	for (i = 0; i < ARRAY_SIZE(metrics); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(metrics); i++) {
 		err = metric_parse_fake(metrics[i].str);
 		if (err)
 			return err;
 	}
 
-	i = 0;
-	for (;;) {
-		const struct pmu_events_map *map = &pmu_events_map[i++];
+	err = pmu_for_each_core_event(test__parsing_fake_callback, NULL);
+	if (err)
+		return err;
 
-		if (!map->table)
-			break;
-		j = 0;
-		for (;;) {
-			const struct pmu_event *pe = &map->table[j++];
-
-			if (!pe->name && !pe->metric_group && !pe->metric_name)
-				break;
-			if (!pe->metric_expr)
-				continue;
-			pr_debug("Found metric '%s' for '%s'\n", pe->metric_name, map->cpuid);
-			err = metric_parse_fake(pe->metric_expr);
-			if (err)
-				return err;
-		}
-	}
-
-	return 0;
+	return pmu_for_each_sys_event(test__parsing_fake_callback, NULL);
 }
 
 static struct test_case pmu_events_tests[] = {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4d32b4fbf67d..680f7c63838d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -502,14 +502,14 @@ struct metricgroup_print_sys_idata {
 	bool details;
 };
 
-typedef int (*metricgroup_sys_event_iter_fn)(const struct pmu_event *pe, void *);
-
 struct metricgroup_iter_data {
-	metricgroup_sys_event_iter_fn fn;
+	pmu_event_iter_fn fn;
 	void *data;
 };
 
-static int metricgroup__sys_event_iter(const struct pmu_event *pe, void *data)
+static int metricgroup__sys_event_iter(const struct pmu_event *pe,
+				       const struct pmu_event *table __maybe_unused,
+				       void *data)
 {
 	struct metricgroup_iter_data *d = data;
 	struct perf_pmu *pmu = NULL;
@@ -522,13 +522,15 @@ static int metricgroup__sys_event_iter(const struct pmu_event *pe, void *data)
 		if (!pmu->id || strcmp(pmu->id, pe->compat))
 			continue;
 
-		return d->fn(pe, d->data);
+		return d->fn(pe, table, d->data);
 	}
 
 	return 0;
 }
 
-static int metricgroup__print_sys_event_iter(const struct pmu_event *pe, void *data)
+static int metricgroup__print_sys_event_iter(const struct pmu_event *pe,
+					     const struct pmu_event *table __maybe_unused,
+					     void *data)
 {
 	struct metricgroup_print_sys_idata *d = data;
 
@@ -1101,6 +1103,7 @@ static int add_metric(struct list_head *metric_list,
 }
 
 static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
+						  const struct pmu_event *table __maybe_unused,
 						  void *data)
 {
 	struct metricgroup_add_iter_data *d = data;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6dd533106156..893cc0ff7758 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -690,7 +690,7 @@ static int is_arm_pmu_core(const char *name)
 	return file_available(path);
 }
 
-static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
+char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 {
 	char *cpuid;
 	static bool printed;
@@ -710,34 +710,6 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 	return cpuid;
 }
 
-const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
-{
-	const struct pmu_event *table = NULL;
-	char *cpuid = perf_pmu__getcpuid(pmu);
-	int i;
-
-	/* on some platforms which uses cpus map, cpuid can be NULL for
-	 * PMUs other than CORE PMUs.
-	 */
-	if (!cpuid)
-		return NULL;
-
-	i = 0;
-	for (;;) {
-		const struct pmu_events_map *map = &pmu_events_map[i++];
-
-		if (!map->table)
-			break;
-
-		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
-			table = map->table;
-			break;
-		}
-	}
-	free(cpuid);
-	return table;
-}
-
 const struct pmu_event *pmu_events_map__find(void)
 {
 	return perf_pmu__find_table(NULL);
@@ -874,7 +846,9 @@ struct pmu_sys_event_iter_data {
 	struct perf_pmu *pmu;
 };
 
-static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe, void *data)
+static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
+				       const struct pmu_event *table __maybe_unused,
+				       void *data)
 {
 	struct pmu_sys_event_iter_data *idata = data;
 	struct perf_pmu *pmu = idata->pmu;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 015242c83698..06df99ba2029 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -128,7 +128,7 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 			     const struct pmu_event *map);
 
-const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu);
+char *perf_pmu__getcpuid(struct perf_pmu *pmu);
 const struct pmu_event *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
-- 
2.37.0.170.g444d1eabd0-goog

