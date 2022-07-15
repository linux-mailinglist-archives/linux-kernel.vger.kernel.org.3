Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722B6575BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGOGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiGOGh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFD6A9C7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31dfe25bd47so1029887b3.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=heM+cYHlj6vP221hxJBcWNj4VjfXKtGYwQwPpYWB198=;
        b=JrG0JMAzXe7dvFygrnJt3fZ7vRSFbR8eW8Okqca1BNxTJJFa9/hvFIFoERMTjlvLTy
         osiGbL9NXBKF6xV6MJ6qsrcw082WHZ9k29za5kQUGw1OwdHjPfbKVTnvEskww0xXrRSm
         Tx3GteU4uQtNgVHZ0vBKrylHve+1VRetFuZ9adP7LSpett44WcHLMhRlvnnA7I2i6oT0
         EoaEGQjxOIWD79Kghj7UefsupZSn28oN5+TONjPaS/XdzJCi5VeEWDcbsxTa5dPWMcVv
         0iqZBR0/Z7nXAiDUtVC6Jk+KO7anHu/UkzZb2yrKTqig7CUlD5WW+UCIwcMxhvYwA7Nt
         kJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=heM+cYHlj6vP221hxJBcWNj4VjfXKtGYwQwPpYWB198=;
        b=7ajatZkPtRcRSO2sNUYcu8U0oJCv3ylrR/rex7YPGjiIYvdccpPO62VX2bTBppbYZl
         SLkXLkwaKbEuQ6i9hlYIAggDRmTtS083xCJkaj7XZIKlKnC5qm22Ia6FWP16ju9OBC3T
         kzcrMP+mb6S4vSVvLTr3+mKTe/1IJnqkG0tv823sBNOrXa0kHuyA5zaGD+MbvLNzwFkr
         ieSYYOyrLBPfnvm9E1s9pAEOABIJAqst3UP0OgsS5N4qQpWxmo3rtCZPH8CPwp1TnhuC
         Ccxg23bIcJ42ZGi6U9LdATX5iqr0N3E6mkWon3g8q5XDMQPyITpdp2hRLPBosPhysmJ8
         bRqA==
X-Gm-Message-State: AJIora9RXXGmNerQqj198/TojMRCFN8W4A+TFmL30rFb/UsleguXqWOp
        yDyqV5GuzeiAmHsKgTZTvp+9wmwM17Pz
X-Google-Smtp-Source: AGRyM1u7paE8z2b/HR/0D6RZuBLguyUxsags1T1DZeWNY+7dyKwGqOLtna4VlkaoLAH/yGqfAgtf2u1x/P2j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr12581178ybq.472.1657867058918; Thu, 14
 Jul 2022 23:37:38 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:48 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-11-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 10/15] perf test: Use full metric resolution
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

The simple metric resolution doesn't handle recursion properly, switch
to use the full resolution as with the parse-metric tests which also
increases coverage. Don't set the values for the metric backward as
failures to generate a result are ignored.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 222 ++++++++++++----------------------
 1 file changed, 77 insertions(+), 145 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 62e41b9c67dd..ccbf1057ba4c 100644
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
@@ -792,27 +794,6 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
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
@@ -829,160 +810,111 @@ struct metric {
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
2.37.0.170.g444d1eabd0-goog

