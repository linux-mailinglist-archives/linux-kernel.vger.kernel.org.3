Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E6958A32E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiHDWUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiHDWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:19:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEC86FA14
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:18:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m5-20020a2598c5000000b0066faab590c5so604629ybo.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=sxQ3NgaGvyZvqLsnvSuWrAEklghpO9eHvVo0+qiRlwk=;
        b=eCGMuF7hnql9EdwBvth8dRunrydqTYfauGRZ1iDr/M8VHI27TYViSnq9fyeo4H5JgV
         V6LGbOvcSxRFYepaPl664EYB+jKU10CtEkx4YjZA+KhvUwHnoAX/hW6DQ6LsOGnqb11K
         9ySjaKJKCxLQYKrGyQ4t8WkWuFsGq8vuSaFOaKqAuCKs/vXPwvB/2Wz/I33z7Ztc8rxZ
         efi6mtUND4tQxj3CWZpCBo9aDXGsvY1PK5dVcuk+boRRBTBJ0knpiQo1PYnYiOUK7LYb
         jN7yOMhPZq4xlx85kK4BgobztVs842/pilcTOl3A8zjipZIyobnXz/9RC3rfV3R4lLwH
         EEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=sxQ3NgaGvyZvqLsnvSuWrAEklghpO9eHvVo0+qiRlwk=;
        b=Ugbc0iZxOtF3L+ORs4SOYUV7KcVGlrRk9nQgjAEOVvGuBDsGQJG3IzcUQ6skfZr7kf
         EpthDF0D63VDrnbOjg0W/pSe7z4pn41Qdu7YkUPVzEEDlUXbCH00etPctKpvv77O9ph6
         Z0dAxfrjBEeSmNOwtG5CRGj83vmzxjGWL0tgdO4otPWJppwyZ9fIU8MFLIW5QxldG3KW
         kPOyhYPt3dhcjZxT1hSpuuW9LrGOY5MTO5ZEA+n54/jJPHs+I72ljP7dkOSqsyeBJsQv
         qKAU18yNum7Rov+5tJx+qsv2HpUWo1RWUk3jybUhGKC88E0+GrtEec4Q/lXFSy8xIR1T
         Eqhg==
X-Gm-Message-State: ACgBeo069uUZSBFP1I1a1Y7IbTXS7ZkqWCGqobdC9188w1RadY8IMMM3
        H4+YW+iqWlY59TRJLMxgBuKLvgrMhvsn
X-Google-Smtp-Source: AA6agR4l94lTAOWEwMCCSzuT/joWaQgFNgh/0L1pyiyzsEHL3p12erTz3j18xD0M0Oc7DlkXogsjaMBh2g8X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:b9ce:0:b0:67a:6b58:2444 with SMTP id
 y14-20020a25b9ce000000b0067a6b582444mr3169101ybj.238.1659651532563; Thu, 04
 Aug 2022 15:18:52 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:10 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-12-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 11/17] perf test: Use full metric resolution
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple metric resolution doesn't handle recursion properly, switch
to use the full resolution as with the parse-metric tests which also
increases coverage. Don't set the values for the metric backward as
failures to generate a result are ignored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 222 ++++++++++++----------------------
 1 file changed, 77 insertions(+), 145 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ea8b41b5c4e3..e8df6bc26ebd 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -9,10 +9,12 @@
 #include <linux/zalloc.h>
 #include "debug.h"
 #include "../pmu-events/pmu-events.h"
+#include <perf/evlist.h>
 #include "util/evlist.h"
 #include "util/expr.h"
 #include "util/parse-events.h"
 #include "metricgroup.h"
+#include "stat.h"
 
 struct perf_pmu_test_event {
 	/* used for matching against events from generated pmu-events.c */
@@ -801,27 +803,6 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	return ret;
 }
 
-static int check_parse_cpu(const char *id, bool same_cpu, const struct pmu_event *pe)
-{
-	struct parse_events_error error;
-	int ret;
-
-	parse_events_error__init(&error);
-	ret = check_parse_id(id, &error, NULL);
-	if (ret && same_cpu) {
-		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
-			pe->metric_name, id, pe->metric_expr);
-		pr_warning("Error string '%s' help '%s'\n", error.str,
-			error.help);
-	} else if (ret) {
-		pr_debug3("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
-			  id, pe->metric_name, pe->metric_expr);
-		ret = 0;
-	}
-	parse_events_error__exit(&error);
-	return ret;
-}
-
 static int check_parse_fake(const char *id)
 {
 	struct parse_events_error error;
@@ -838,160 +819,111 @@ struct metric {
 	struct metric_ref metric_ref;
 };
 
-static int resolve_metric_simple(struct expr_parse_ctx *pctx,
-				 struct list_head *compound_list,
-				 const struct pmu_event *map,
-				 const char *metric_name)
-{
-	struct hashmap_entry *cur, *cur_tmp;
-	struct metric *metric, *tmp;
-	size_t bkt;
-	bool all;
-	int rc;
-
-	do {
-		all = true;
-		hashmap__for_each_entry_safe(pctx->ids, cur, cur_tmp, bkt) {
-			struct metric_ref *ref;
-			const struct pmu_event *pe;
-
-			pe = metricgroup__find_metric(cur->key, map);
-			if (!pe)
-				continue;
-
-			if (!strcmp(metric_name, (char *)cur->key)) {
-				pr_warning("Recursion detected for metric %s\n", metric_name);
-				rc = -1;
-				goto out_err;
-			}
-
-			all = false;
-
-			/* The metric key itself needs to go out.. */
-			expr__del_id(pctx, cur->key);
-
-			metric = malloc(sizeof(*metric));
-			if (!metric) {
-				rc = -ENOMEM;
-				goto out_err;
-			}
-
-			ref = &metric->metric_ref;
-			ref->metric_name = pe->metric_name;
-			ref->metric_expr = pe->metric_expr;
-			list_add_tail(&metric->list, compound_list);
-
-			rc = expr__find_ids(pe->metric_expr, NULL, pctx);
-			if (rc)
-				goto out_err;
-			break; /* The hashmap has been modified, so restart */
-		}
-	} while (!all);
-
-	return 0;
-
-out_err:
-	list_for_each_entry_safe(metric, tmp, compound_list, list)
-		free(metric);
-
-	return rc;
-
-}
-
-static void expr_failure(const char *msg, const struct pmu_event *pe)
-{
-	pr_debug("%s\nOn metric %s\nOn expression %s\n", msg, pe->metric_name, pe->metric_expr);
-}
-
-
-struct test__parsing_data {
-	const struct pmu_event *cpus_table;
-	struct expr_parse_ctx *ctx;
-	int failures;
-};
-
 static int test__parsing_callback(const struct pmu_event *pe, const struct pmu_event *table,
-				  void *vdata)
+				  void *data)
 {
-	struct test__parsing_data *data = vdata;
-	struct metric *metric, *tmp;
-	struct hashmap_entry *cur;
-	LIST_HEAD(compound_list);
-	size_t bkt;
+	int *failures = data;
 	int k;
-	double result;
+	struct evlist *evlist;
+	struct perf_cpu_map *cpus;
+	struct runtime_stat st;
+	struct evsel *evsel;
+	struct rblist metric_events = {
+		.nr_entries = 0,
+	};
+	int err = 0;
 
 	if (!pe->metric_expr)
 		return 0;
 
 	pr_debug("Found metric '%s'\n", pe->metric_name);
+	(*failures)++;
 
-	expr__ctx_clear(data->ctx);
-	if (expr__find_ids(pe->metric_expr, NULL, data->ctx) < 0) {
-		expr_failure("Parse find ids failed", pe);
-		data->failures++;
-		return 0;
+	/*
+	 * We need to prepare evlist for stat mode running on CPU 0
+	 * because that's where all the stats are going to be created.
+	 */
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	cpus = perf_cpu_map__new("0");
+	if (!cpus) {
+		evlist__delete(evlist);
+		return -ENOMEM;
 	}
 
-	if (resolve_metric_simple(data->ctx, &compound_list, table,
-				  pe->metric_name)) {
-		expr_failure("Could not resolve metrics", pe);
-		data->failures++;
-		return TEST_FAIL; /* Don't tolerate errors due to severity */
+	perf_evlist__set_maps(&evlist->core, cpus, NULL);
+	runtime_stat__init(&st);
+
+	err = metricgroup__parse_groups_test(evlist, table, pe->metric_name,
+					     false, false,
+					     &metric_events);
+	if (err) {
+		if (!strcmp(pe->metric_name, "M1") || !strcmp(pe->metric_name, "M2") ||
+		    !strcmp(pe->metric_name, "M3")) {
+			(*failures)--;
+			pr_debug("Expected broken metric %s skipping\n", pe->metric_name);
+			err = 0;
+		}
+		goto out_err;
 	}
 
+	err = evlist__alloc_stats(evlist, false);
+	if (err)
+		goto out_err;
 	/*
 	 * Add all ids with a made up value. The value may trigger divide by
 	 * zero when subtracted and so try to make them unique.
 	 */
 	k = 1;
-	hashmap__for_each_entry(data->ctx->ids, cur, bkt)
-		expr__add_id_val(data->ctx, strdup(cur->key), k++);
-
-	hashmap__for_each_entry(data->ctx->ids, cur, bkt) {
-		if (check_parse_cpu(cur->key, table == data->cpus_table, pe))
-			data->failures++;
+	perf_stat__reset_shadow_stats();
+	evlist__for_each_entry(evlist, evsel) {
+		perf_stat__update_shadow_stats(evsel, k, 0, &st);
+		if (!strcmp(evsel->name, "duration_time"))
+			update_stats(&walltime_nsecs_stats, k);
+		k++;
 	}
+	evlist__for_each_entry(evlist, evsel) {
+		struct metric_event *me = metricgroup__lookup(&metric_events, evsel, false);
 
-	list_for_each_entry_safe(metric, tmp, &compound_list, list) {
-		expr__add_ref(data->ctx, &metric->metric_ref);
-		free(metric);
-	}
+		if (me != NULL) {
+			struct metric_expr *mexp;
 
-	if (expr__parse(&result, data->ctx, pe->metric_expr)) {
-		/*
-		 * Parsing failed, make numbers go from large to small which can
-		 * resolve divide by zero issues.
-		 */
-		k = 1024;
-		hashmap__for_each_entry(data->ctx->ids, cur, bkt)
-			expr__add_id_val(data->ctx, strdup(cur->key), k--);
-		if (expr__parse(&result, data->ctx, pe->metric_expr)) {
-			expr_failure("Parse failed", pe);
-			data->failures++;
+			list_for_each_entry (mexp, &me->head, nd) {
+				if (strcmp(mexp->metric_name, pe->metric_name))
+					continue;
+				pr_debug("Result %f\n", test_generic_metric(mexp, 0, &st));
+				err = 0;
+				(*failures)--;
+				goto out_err;
+			}
 		}
 	}
-	return 0;
+	pr_debug("Didn't find parsed metric %s", pe->metric_name);
+	err = 1;
+out_err:
+	if (err)
+		pr_debug("Broken metric %s\n", pe->metric_name);
+
+	/* ... cleanup. */
+	metricgroup__rblist_exit(&metric_events);
+	runtime_stat__exit(&st);
+	evlist__free_stats(evlist);
+	perf_cpu_map__put(cpus);
+	evlist__delete(evlist);
+	return err;
 }
 
 static int test__parsing(struct test_suite *test __maybe_unused,
 			 int subtest __maybe_unused)
 {
-	struct test__parsing_data data = {
-		.cpus_table = pmu_events_map__find(),
-		.ctx = expr__ctx_new(),
-		.failures = 0,
-	};
+	int failures = 0;
 
-	if (!data.ctx) {
-		pr_debug("expr__ctx_new failed");
-		return TEST_FAIL;
-	}
-	pmu_for_each_core_event(test__parsing_callback, &data);
-	pmu_for_each_sys_event(test__parsing_callback, &data);
+	pmu_for_each_core_event(test__parsing_callback, &failures);
+	pmu_for_each_sys_event(test__parsing_callback, &failures);
 
-	expr__ctx_free(data.ctx);
-	return data.failures == 0 ? TEST_OK : TEST_FAIL;
+	return failures == 0 ? TEST_OK : TEST_FAIL;
 }
 
 struct test_metric {
-- 
2.37.1.559.g78731f0fdb-goog

