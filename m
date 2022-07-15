Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA78575BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiGOGii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiGOGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C366AE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y4-20020a25b9c4000000b0066e573fb0fcso3342721ybj.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e7+QWhCfZO7ckYc4IvpTlLbIpLWqok1CMqNGGWHFPvs=;
        b=o3+8bI5RsLcfROYpnxmNo8JqusV7KQGyh8w7UOZg8HZ/DWjryyQ/nWmAcvvQZIsBqP
         /31Baw1VnO+zA946kMqSb5ubFBpyXGoQvIphzptZ+hLzcnT0GAu/PjhL8lvJ5OLn6PGc
         sqe3zTBTDP0aHirx5EL/ix1g2qFHhYVwyl67BetNcs34M7bUt0sZ5M8W6bJ1ycra6vlp
         4tfbGCdMELUgXyuQT5bx+s0X9pKnIO+twPPahIhm5KCWhVjVhEYCv4+eXZga4DQ1ihQu
         uVy2QyV/nV3/E34xhiwAvJh/UvYkNStQxe2cP43ZlVDPTtY62laUgSYc/EA0hYCUWq9Q
         /mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e7+QWhCfZO7ckYc4IvpTlLbIpLWqok1CMqNGGWHFPvs=;
        b=jU+sAnwLWESMzPP67ALu92XXgQoKqiTvAcY9MboV2RjXYktxv5SwPuyJl98Ow97MUA
         LM5Yo9XsTlvX1AZ6c0rBCaHbMJDWKF/vJyCZk2YhkIEWmpl1NBto8DAdxWS01dONfz7d
         zEZ7apWeZVXwQU8Ror2ys2EYP8E1a4qKtO2YuXAZ6BFKMNTSSxp8c7hxtHAiJnP/vH6+
         0k7nPWpDztQR+5beKLjVoC4j/8HBVbKJPnNZRUi+Q4xgJF6QVBY9ohyGuSMycAjRD9Rr
         GxBobIO7wJjSMdtR8v9K826DLZFjhOrKfn9JCQ4JBfUZ0OTpZ2QIG6+2rI82urv8yqTt
         Z/hw==
X-Gm-Message-State: AJIora9Z41KyQqzu+n3YW8m0Ab7sEPFWbEOg4oi2+5TqOEogDDTQA0n0
        CFaOWVairuBMTLMWvtRa62yFVMJovNm7
X-Google-Smtp-Source: AGRyM1to22h3RpR0ihq2EIU+Gvte6RVJRbPig6rgmRGhjR/EV+MUxBcY8DJbFC1Z2EjLNM+eusNqS8RhSxqs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a81:f0d:0:b0:31c:8860:c59f with SMTP id
 13-20020a810f0d000000b0031c8860c59fmr15120763ywp.31.1657867054082; Thu, 14
 Jul 2022 23:37:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:46 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-9-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 08/15] perf pmu-events: Avoid passing pmu_events_map
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparation for hiding pmu_events_map as an implementation detail. While
the map is passed, the table of events is all that is normally wanted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c  |  4 +-
 tools/perf/tests/expand-cgroup.c  |  6 +--
 tools/perf/tests/parse-metric.c   |  7 +--
 tools/perf/tests/pmu-events.c     | 63 +++++++++++-------------
 tools/perf/util/metricgroup.c     | 82 +++++++++++++++----------------
 tools/perf/util/metricgroup.h     |  4 +-
 tools/perf/util/pmu.c             | 33 +++++++------
 tools/perf/util/pmu.h             |  6 +--
 tools/perf/util/s390-sample-raw.c | 12 ++---
 9 files changed, 99 insertions(+), 118 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 79124bba713e..646af8603227 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -3,7 +3,7 @@
 #include "../../../util/cpumap.h"
 #include "../../../util/pmu.h"
 
-const struct pmu_events_map *pmu_events_map__find(void)
+const struct pmu_event *pmu_events_map__find(void)
 {
 	struct perf_pmu *pmu = NULL;
 
@@ -18,7 +18,7 @@ const struct pmu_events_map *pmu_events_map__find(void)
 		if (pmu->cpus->nr != cpu__max_cpu().cpu)
 			return NULL;
 
-		return perf_pmu__find_map(pmu);
+		return perf_pmu__find_table(pmu);
 	}
 
 	return NULL;
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dc4038f997d7..411fc578e5a4 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -195,16 +195,12 @@ static int expand_metric_events(void)
 			.metric_name	= NULL,
 		},
 	};
-	const struct pmu_events_map ev_map = {
-		.cpuid		= "test",
-		.table		= pme_test,
-	};
 
 	evlist = evlist__new();
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
 	rblist__init(&metric_events);
-	ret = metricgroup__parse_groups_test(evlist, &ev_map, metric_str,
+	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str,
 					     false, false, &metric_events);
 	if (ret < 0) {
 		pr_debug("failed to parse '%s' metric\n", metric_str);
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 1b811a26f4ee..7aebde7c37ec 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -79,11 +79,6 @@ static struct pmu_event pme_test[] = {
 }
 };
 
-static const struct pmu_events_map map = {
-	.cpuid		= "test",
-	.table		= pme_test,
-};
-
 struct value {
 	const char	*event;
 	u64		 val;
@@ -166,7 +161,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	runtime_stat__init(&st);
 
 	/* Parse the metric into metric_events list. */
-	err = metricgroup__parse_groups_test(evlist, &map, name,
+	err = metricgroup__parse_groups_test(evlist, pme_test, name,
 					     false, false,
 					     &metric_events);
 	if (err)
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 4a7dee4ca7da..6c3d22d00219 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -272,13 +272,11 @@ static bool is_same(const char *reference, const char *test)
 	return !strcmp(reference, test);
 }
 
-static const struct pmu_events_map *__test_pmu_get_events_map(void)
+static const struct pmu_event *__test_pmu_get_events_table(void)
 {
-	const struct pmu_events_map *map;
-
-	for (map = &pmu_events_map[0]; map->cpuid; map++) {
+	for (const struct pmu_events_map *map = &pmu_events_map[0]; map->cpuid; map++) {
 		if (!strcmp(map->cpuid, "testcpu"))
-			return map;
+			return map->table;
 	}
 
 	pr_err("could not find test events map\n");
@@ -440,8 +438,7 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 				 int subtest __maybe_unused)
 {
 	const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
-	const struct pmu_events_map *map = __test_pmu_get_events_map();
-	const struct pmu_event *table;
+	const struct pmu_event *table = __test_pmu_get_events_table();
 	int map_events = 0, expected_events;
 
 	/* ignore 3x sentinels */
@@ -449,10 +446,10 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 			  ARRAY_SIZE(uncore_events) +
 			  ARRAY_SIZE(sys_events) - 3;
 
-	if (!map || !sys_event_tables)
+	if (!table || !sys_event_tables)
 		return -1;
 
-	for (table = map->table; table->name; table++) {
+	for (; table->name; table++) {
 		struct perf_pmu_test_event const **test_event_table;
 		bool found = false;
 
@@ -537,10 +534,10 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	struct perf_pmu *pmu;
 	LIST_HEAD(aliases);
 	int res = 0;
-	const struct pmu_events_map *map = __test_pmu_get_events_map();
+	const struct pmu_event *table = __test_pmu_get_events_table();
 	struct perf_pmu_alias *a, *tmp;
 
-	if (!map)
+	if (!table)
 		return -1;
 
 	test_event_table = &core_events[0];
@@ -551,7 +548,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 
 	pmu->name = pmu_name;
 
-	pmu_add_cpu_aliases_map(&aliases, pmu, map);
+	pmu_add_cpu_aliases_map(&aliases, pmu, table);
 
 	for (; *test_event_table; test_event_table++) {
 		struct perf_pmu_test_event const *test_event = *test_event_table;
@@ -590,14 +587,14 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	struct perf_pmu *pmu = &test_pmu->pmu;
 	const char *pmu_name = pmu->name;
 	struct perf_pmu_alias *a, *tmp, *alias;
-	const struct pmu_events_map *map;
+	const struct pmu_event *events_table;
 	LIST_HEAD(aliases);
 	int res = 0;
 
-	map = __test_pmu_get_events_map();
-	if (!map)
+	events_table = __test_pmu_get_events_table();
+	if (!events_table)
 		return -1;
-	pmu_add_cpu_aliases_map(&aliases, pmu, map);
+	pmu_add_cpu_aliases_map(&aliases, pmu, events_table);
 	pmu_add_sys_aliases(&aliases, pmu);
 
 	/* Count how many aliases we generated */
@@ -839,13 +836,9 @@ static int check_parse_fake(const char *id)
 	return ret;
 }
 
-static void expr_failure(const char *msg,
-			 const struct pmu_events_map *map,
-			 const struct pmu_event *pe)
+static void expr_failure(const char *msg, const struct pmu_event *pe)
 {
-	pr_debug("%s for map %s %s\n", msg, map->arch, map->cpuid);
-	pr_debug("On metric %s\n", pe->metric_name);
-	pr_debug("On expression %s\n", pe->metric_expr);
+	pr_debug("%s\nOn metric %s\nOn expression %s\n", msg, pe->metric_name, pe->metric_expr);
 }
 
 struct metric {
@@ -855,7 +848,7 @@ struct metric {
 
 static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 				 struct list_head *compound_list,
-				 const struct pmu_events_map *map,
+				 const struct pmu_event *map,
 				 const char *metric_name)
 {
 	struct hashmap_entry *cur, *cur_tmp;
@@ -916,8 +909,7 @@ static int resolve_metric_simple(struct expr_parse_ctx *pctx,
 static int test__parsing(struct test_suite *test __maybe_unused,
 			 int subtest __maybe_unused)
 {
-	const struct pmu_events_map *cpus_map = pmu_events_map__find();
-	const struct pmu_events_map *map;
+	const struct pmu_event *cpus_table = pmu_events_map__find();
 	const struct pmu_event *pe;
 	int i, j, k;
 	int ret = 0;
@@ -931,7 +923,8 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 	}
 	i = 0;
 	for (;;) {
-		map = &pmu_events_map[i++];
+		const struct pmu_events_map *map = &pmu_events_map[i++];
+
 		if (!map->table)
 			break;
 		j = 0;
@@ -948,14 +941,14 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 				continue;
 			expr__ctx_clear(ctx);
 			if (expr__find_ids(pe->metric_expr, NULL, ctx) < 0) {
-				expr_failure("Parse find ids failed", map, pe);
+				expr_failure("Parse find ids failed", pe);
 				ret++;
 				continue;
 			}
 
-			if (resolve_metric_simple(ctx, &compound_list, map,
+			if (resolve_metric_simple(ctx, &compound_list, map->table,
 						  pe->metric_name)) {
-				expr_failure("Could not resolve metrics", map, pe);
+				expr_failure("Could not resolve metrics", pe);
 				ret++;
 				goto exit; /* Don't tolerate errors due to severity */
 			}
@@ -970,7 +963,7 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 				expr__add_id_val(ctx, strdup(cur->key), k++);
 
 			hashmap__for_each_entry(ctx->ids, cur, bkt) {
-				if (check_parse_cpu(cur->key, map == cpus_map,
+				if (check_parse_cpu(cur->key, map->table == cpus_table,
 						   pe))
 					ret++;
 			}
@@ -990,7 +983,7 @@ static int test__parsing(struct test_suite *test __maybe_unused,
 				hashmap__for_each_entry(ctx->ids, cur, bkt)
 					expr__add_id_val(ctx, strdup(cur->key), k--);
 				if (expr__parse(&result, ctx, pe->metric_expr)) {
-					expr_failure("Parse failed", map, pe);
+					expr_failure("Parse failed", pe);
 					ret++;
 				}
 			}
@@ -1079,8 +1072,6 @@ static int metric_parse_fake(const char *str)
 static int test__parsing_fake(struct test_suite *test __maybe_unused,
 			      int subtest __maybe_unused)
 {
-	const struct pmu_events_map *map;
-	const struct pmu_event *pe;
 	unsigned int i, j;
 	int err = 0;
 
@@ -1092,12 +1083,14 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
 
 	i = 0;
 	for (;;) {
-		map = &pmu_events_map[i++];
+		const struct pmu_events_map *map = &pmu_events_map[i++];
+
 		if (!map->table)
 			break;
 		j = 0;
 		for (;;) {
-			pe = &map->table[j++];
+			const struct pmu_event *pe = &map->table[j++];
+
 			if (!pe->name && !pe->metric_group && !pe->metric_name)
 				break;
 			if (!pe->metric_expr)
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8f7baeabc5cf..4d32b4fbf67d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -539,9 +539,6 @@ static int metricgroup__print_sys_event_iter(const struct pmu_event *pe, void *d
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details, const char *pmu_name)
 {
-	const struct pmu_events_map *map = pmu_events_map__find();
-	const struct pmu_event *pe;
-	int i;
 	struct rblist groups;
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
@@ -556,8 +553,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
-	for (i = 0; map; i++) {
-		pe = &map->table[i];
+	for (const struct pmu_event *pe = pmu_events_map__find(); pe; pe++) {
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
 			break;
@@ -850,7 +846,7 @@ struct metricgroup_add_iter_data {
 	bool metric_no_group;
 	struct metric *root_metric;
 	const struct visited_metric *visited;
-	const struct pmu_events_map *map;
+	const struct pmu_event *table;
 };
 
 static int add_metric(struct list_head *metric_list,
@@ -859,7 +855,7 @@ static int add_metric(struct list_head *metric_list,
 		      bool metric_no_group,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
-		      const struct pmu_events_map *map);
+		      const struct pmu_event *table);
 
 /**
  * resolve_metric - Locate metrics within the root metric and recursively add
@@ -874,7 +870,7 @@ static int add_metric(struct list_head *metric_list,
  *               metrics. When adding a root this argument is NULL.
  * @visited: A singly linked list of metric names being added that is used to
  *           detect recursion.
- * @map: The map that is searched for metrics, most commonly the table for the
+ * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
 static int resolve_metric(struct list_head *metric_list,
@@ -882,7 +878,7 @@ static int resolve_metric(struct list_head *metric_list,
 			  bool metric_no_group,
 			  struct metric *root_metric,
 			  const struct visited_metric *visited,
-			  const struct pmu_events_map *map)
+			  const struct pmu_event *table)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -904,7 +900,7 @@ static int resolve_metric(struct list_head *metric_list,
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
 		const struct pmu_event *pe;
 
-		pe = metricgroup__find_metric(cur->key, map);
+		pe = metricgroup__find_metric(cur->key, table);
 		if (pe) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
@@ -927,7 +923,7 @@ static int resolve_metric(struct list_head *metric_list,
 	 */
 	for (i = 0; i < pending_cnt; i++) {
 		ret = add_metric(metric_list, pending[i].pe, modifier, metric_no_group,
-				root_metric, visited, map);
+				root_metric, visited, table);
 		if (ret)
 			break;
 	}
@@ -950,7 +946,7 @@ static int resolve_metric(struct list_head *metric_list,
  *               metrics. When adding a root this argument is NULL.
  * @visited: A singly linked list of metric names being added that is used to
  *           detect recursion.
- * @map: The map that is searched for metrics, most commonly the table for the
+ * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
 static int __add_metric(struct list_head *metric_list,
@@ -960,7 +956,7 @@ static int __add_metric(struct list_head *metric_list,
 			int runtime,
 			struct metric *root_metric,
 			const struct visited_metric *visited,
-			const struct pmu_events_map *map)
+			const struct pmu_event *table)
 {
 	const struct visited_metric *vm;
 	int ret;
@@ -1032,7 +1028,7 @@ static int __add_metric(struct list_head *metric_list,
 	} else {
 		/* Resolve referenced metrics. */
 		ret = resolve_metric(metric_list, modifier, metric_no_group, root_metric,
-				     &visited_node, map);
+				     &visited_node, table);
 	}
 
 	if (ret) {
@@ -1045,25 +1041,25 @@ static int __add_metric(struct list_head *metric_list,
 	return ret;
 }
 
-#define map_for_each_event(__pe, __idx, __map)					\
-	if (__map)								\
-		for (__idx = 0, __pe = &__map->table[__idx];			\
+#define table_for_each_event(__pe, __idx, __table)					\
+	if (__table)								\
+		for (__idx = 0, __pe = &__table[__idx];				\
 		     __pe->name || __pe->metric_group || __pe->metric_name;	\
-		     __pe = &__map->table[++__idx])
+		     __pe = &__table[++__idx])
 
-#define map_for_each_metric(__pe, __idx, __map, __metric)		\
-	map_for_each_event(__pe, __idx, __map)				\
+#define table_for_each_metric(__pe, __idx, __table, __metric)		\
+	table_for_each_event(__pe, __idx, __table)				\
 		if (__pe->metric_expr &&				\
 		    (match_metric(__pe->metric_group, __metric) ||	\
 		     match_metric(__pe->metric_name, __metric)))
 
 const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_events_map *map)
+						 const struct pmu_event *table)
 {
 	const struct pmu_event *pe;
 	int i;
 
-	map_for_each_event(pe, i, map) {
+	table_for_each_event(pe, i, table) {
 		if (match_metric(pe->metric_name, metric))
 			return pe;
 	}
@@ -1077,7 +1073,7 @@ static int add_metric(struct list_head *metric_list,
 		      bool metric_no_group,
 		      struct metric *root_metric,
 		      const struct visited_metric *visited,
-		      const struct pmu_events_map *map)
+		      const struct pmu_event *table)
 {
 	int ret = 0;
 
@@ -1085,7 +1081,7 @@ static int add_metric(struct list_head *metric_list,
 
 	if (!strstr(pe->metric_expr, "?")) {
 		ret = __add_metric(metric_list, pe, modifier, metric_no_group, 0,
-				   root_metric, visited, map);
+				   root_metric, visited, table);
 	} else {
 		int j, count;
 
@@ -1098,7 +1094,7 @@ static int add_metric(struct list_head *metric_list,
 
 		for (j = 0; j < count && !ret; j++)
 			ret = __add_metric(metric_list, pe, modifier, metric_no_group, j,
-					root_metric, visited, map);
+					root_metric, visited, table);
 	}
 
 	return ret;
@@ -1114,7 +1110,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
 		return 0;
 
 	ret = add_metric(d->metric_list, pe, d->modifier, d->metric_no_group,
-			 d->root_metric, d->visited, d->map);
+			 d->root_metric, d->visited, d->table);
 	if (ret)
 		goto out;
 
@@ -1162,13 +1158,13 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
  * @metric_list: The list that the metric or metric group are added to.
- * @map: The map that is searched for metrics, most commonly the table for the
+ * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
 static int metricgroup__add_metric(const char *metric_name, const char *modifier,
 				   bool metric_no_group,
 				   struct list_head *metric_list,
-				   const struct pmu_events_map *map)
+				   const struct pmu_event *table)
 {
 	const struct pmu_event *pe;
 	LIST_HEAD(list);
@@ -1179,11 +1175,11 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
 	 * Iterate over all metrics seeing if metric matches either the name or
 	 * group. When it does add the metric to the list.
 	 */
-	map_for_each_metric(pe, i, map, metric_name) {
+	table_for_each_metric(pe, i, table, metric_name) {
 		has_match = true;
 		ret = add_metric(&list, pe, modifier, metric_no_group,
 				 /*root_metric=*/NULL,
-				 /*visited_metrics=*/NULL, map);
+				 /*visited_metrics=*/NULL, table);
 		if (ret)
 			goto out;
 	}
@@ -1198,7 +1194,7 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
 				.metric_no_group = metric_no_group,
 				.has_match = &has_match,
 				.ret = &ret,
-				.map = map,
+				.table = table,
 			},
 		};
 
@@ -1227,12 +1223,12 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
  * @metric_list: The list that metrics are added to.
- * @map: The map that is searched for metrics, most commonly the table for the
+ * @table: The table that is searched for metrics, most commonly the table for the
  *       architecture perf is running upon.
  */
 static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 					struct list_head *metric_list,
-					const struct pmu_events_map *map)
+					const struct pmu_event *table)
 {
 	char *list_itr, *list_copy, *metric_name, *modifier;
 	int ret, count = 0;
@@ -1249,7 +1245,7 @@ static int metricgroup__add_metric_list(const char *list, bool metric_no_group,
 
 		ret = metricgroup__add_metric(metric_name, modifier,
 					      metric_no_group, metric_list,
-					      map);
+					      table);
 		if (ret == -EINVAL)
 			pr_err("Cannot find metric or group `%s'\n", metric_name);
 
@@ -1440,7 +1436,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 			bool metric_no_merge,
 			struct perf_pmu *fake_pmu,
 			struct rblist *metric_events_list,
-			const struct pmu_events_map *map)
+			const struct pmu_event *table)
 {
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
@@ -1451,7 +1447,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 	if (metric_events_list->nr_entries == 0)
 		metricgroup__rblist_init(metric_events_list);
 	ret = metricgroup__add_metric_list(str, metric_no_group,
-					   &metric_list, map);
+					   &metric_list, table);
 	if (ret)
 		goto out;
 
@@ -1586,34 +1582,34 @@ int metricgroup__parse_groups(const struct option *opt,
 			      struct rblist *metric_events)
 {
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
-	const struct pmu_events_map *map = pmu_events_map__find();
+	const struct pmu_event *table = pmu_events_map__find();
 
 	return parse_groups(perf_evlist, str, metric_no_group,
-			    metric_no_merge, NULL, metric_events, map);
+			    metric_no_merge, NULL, metric_events, table);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   const struct pmu_events_map *map,
+				   const struct pmu_event *table,
 				   const char *str,
 				   bool metric_no_group,
 				   bool metric_no_merge,
 				   struct rblist *metric_events)
 {
 	return parse_groups(evlist, str, metric_no_group,
-			    metric_no_merge, &perf_pmu__fake, metric_events, map);
+			    metric_no_merge, &perf_pmu__fake, metric_events, table);
 }
 
 bool metricgroup__has_metric(const char *metric)
 {
-	const struct pmu_events_map *map = pmu_events_map__find();
+	const struct pmu_event *table = pmu_events_map__find();
 	const struct pmu_event *pe;
 	int i;
 
-	if (!map)
+	if (!table)
 		return false;
 
 	for (i = 0; ; i++) {
-		pe = &map->table[i];
+		pe = &table[i];
 
 		if (!pe->name && !pe->metric_group && !pe->metric_name)
 			break;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 2b42b778d1bf..5a1390e73d25 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -71,9 +71,9 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
 const struct pmu_event *metricgroup__find_metric(const char *metric,
-						 const struct pmu_events_map *map);
+						 const struct pmu_event *table);
 int metricgroup__parse_groups_test(struct evlist *evlist,
-				   const struct pmu_events_map *map,
+				   const struct pmu_event *table,
 				   const char *str,
 				   bool metric_no_group,
 				   bool metric_no_merge,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d8717c4548a4..6dd533106156 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -710,9 +710,9 @@ static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 	return cpuid;
 }
 
-const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
+const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
 {
-	const struct pmu_events_map *map;
+	const struct pmu_event *table = NULL;
 	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
@@ -724,22 +724,23 @@ const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 
 	i = 0;
 	for (;;) {
-		map = &pmu_events_map[i++];
-		if (!map->table) {
-			map = NULL;
+		const struct pmu_events_map *map = &pmu_events_map[i++];
+
+		if (!map->table)
 			break;
-		}
 
-		if (!strcmp_cpuid_str(map->cpuid, cpuid))
+		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
+			table = map->table;
 			break;
+		}
 	}
 	free(cpuid);
-	return map;
+	return table;
 }
 
-const struct pmu_events_map *__weak pmu_events_map__find(void)
+const struct pmu_event *pmu_events_map__find(void)
 {
-	return perf_pmu__find_map(NULL);
+	return perf_pmu__find_table(NULL);
 }
 
 /*
@@ -824,7 +825,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
  * as aliases.
  */
 void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
-			     const struct pmu_events_map *map)
+			     const struct pmu_event *table)
 {
 	int i;
 	const char *name = pmu->name;
@@ -834,7 +835,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 	i = 0;
 	while (1) {
 		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
-		const struct pmu_event *pe = &map->table[i++];
+		const struct pmu_event *pe = &table[i++];
 		const char *pname = pe->pmu ? pe->pmu : cpu_name;
 
 		if (!pe->name) {
@@ -859,13 +860,13 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 
 static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 {
-	const struct pmu_events_map *map;
+	const struct pmu_event *table;
 
-	map = perf_pmu__find_map(pmu);
-	if (!map)
+	table = perf_pmu__find_table(pmu);
+	if (!table)
 		return;
 
-	pmu_add_cpu_aliases_map(head, pmu, map);
+	pmu_add_cpu_aliases_map(head, pmu, table);
 }
 
 struct pmu_sys_event_iter_data {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7e667eec2a01..015242c83698 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -126,10 +126,10 @@ int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
-			     const struct pmu_events_map *map);
+			     const struct pmu_event *map);
 
-const struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
-const struct pmu_events_map *pmu_events_map__find(void);
+const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu);
+const struct pmu_event *pmu_events_map__find(void);
 bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
 void perf_pmu_free_alias(struct perf_pmu_alias *alias);
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index cd3a34840389..1ecb718fc0eb 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -135,12 +135,12 @@ static int get_counterset_start(int setnr)
  * the name of this counter.
  * If no match is found a NULL pointer is returned.
  */
-static const char *get_counter_name(int set, int nr, const struct pmu_events_map *map)
+static const char *get_counter_name(int set, int nr, const struct pmu_event *table)
 {
 	int rc, event_nr, wanted = get_counterset_start(set) + nr;
 
-	if (map) {
-		const struct pmu_event *evp = map->table;
+	if (table) {
+		const struct pmu_event *evp = table;
 
 		for (; evp->name || evp->event || evp->desc; ++evp) {
 			if (evp->name == NULL || evp->event == NULL)
@@ -159,10 +159,10 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
 	struct cf_ctrset_entry *cep, ce;
-	const struct pmu_events_map *map;
+	const struct pmu_event *table;
 	u64 *p;
 
-	map = pmu_events_map__find();
+	table = pmu_events_map__find();
 	while (offset < len) {
 		cep = (struct cf_ctrset_entry *)(buf + offset);
 
@@ -180,7 +180,7 @@ static void s390_cpumcfdg_dump(struct perf_sample *sample)
 		color_fprintf(stdout, color, "    [%#08zx] Counterset:%d"
 			      " Counters:%d\n", offset, ce.set, ce.ctr);
 		for (i = 0, p = (u64 *)(cep + 1); i < ce.ctr; ++i, ++p) {
-			const char *ev_name = get_counter_name(ce.set, i, map);
+			const char *ev_name = get_counter_name(ce.set, i, table);
 
 			color_fprintf(stdout, color,
 				      "\tCounter:%03d %s Value:%#018lx\n", i,
-- 
2.37.0.170.g444d1eabd0-goog

