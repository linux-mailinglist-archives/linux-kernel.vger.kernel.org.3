Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C05584844
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiG1WaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiG1W3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:29:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DB87A52C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:29:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k16-20020a252410000000b006718984ef63so2547985ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lGm0A1+bllq0xJSS+pY85+XxmaMBAE8IRab2uQ31Hfs=;
        b=gRw3aSXDQ1aP2KTn8zm4vvMCvJo/jZYxPqBP2BFbsQU8cLt5VWVFRzWBzNFaPkIOMz
         Ovl3bM7OsLhWXKFhgI5AK7rRx+80kx1VcCQnIvpKiDLySQWE32eqnqxLGbjPdSgI715y
         fYAJatmtVcRvlgSEn723JVy/mplEl2Y8DldBWUxCyxSQo8VUP5OVgYy/1v6kvdk6mWSj
         l1HyvfiusLFr6+lN0flE5ifbEZ1teFDtdr7uKlD+ULseYymfKq7r4OC5slm948EG5vs2
         yfzuGM2GLjv1dei8vXEiVHsItsBUwifPLvk7oKXH0/TPHEK78nJFKGSV2JGxoTtWH/AI
         m3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lGm0A1+bllq0xJSS+pY85+XxmaMBAE8IRab2uQ31Hfs=;
        b=E8hoQcAsfXKZlmosOCzqz7u2WTqwxZDpd+q3UEpoW5rw4DtUSfP4NasejLqgoHhHeB
         /AV0uB024evExFqZ0STtMGddIoBPQ3sfsbzpewBZ8+Qkpo9XwbQrEItX8KbKOrpYWClz
         y71t/ZcQLAsmsEHVhkShcnh5Ro9jANyKKCEKE9P1tZfk8lMCLU7ya9EgVQQzq9MDRf0m
         f6E32Gq1Gmh2RJ/gYJOEI3h0GL2M1c5p47ApAf/Qk/k8mbQGqVaPhgsZvE5ZQRMjNnh5
         QIcXtx6wLWOxpXvL2NnadNlyAX4GlywMpVtwF0Hqmid+DyQ57oB4btN8SKmpTWCMi1U3
         FAwA==
X-Gm-Message-State: ACgBeo0x5hkMSMQ1TheaU37BuKOgLmh/kzQtSDCOFHyxSlxn3h01GQ23
        85pxx8s9a6QjlAnrY9LC1/+jIE2UINbv
X-Google-Smtp-Source: AA6agR7eBB1Wo7fRH9f1RfJKN61m0IghcUXYGMD6/4BH9VPUarwlTohuvhy9hLCteaV8ILx/KEovfMVvXU98
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a5b:89:0:b0:671:10c6:4618 with SMTP id
 b9-20020a5b0089000000b0067110c64618mr608977ybp.27.1659047350434; Thu, 28 Jul
 2022 15:29:10 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:31 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-13-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 12/16] perf pmu-events: Don't assume pmu_event is an array
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code assumes that a struct pmu_event can be iterated over
forward until a NULL pmu_event is encountered. This makes it difficult
to refactor pmu_event. Add a loop function taking a callback function
that's passed the struct pmu_event. This way the pmu_event is only
needed for one element and not an entire array.

Switch existing code iterating over the pmu_event arrays to use the new
loop function pmu_events_table_for_each_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c |  34 +++--
 tools/perf/pmu-events/jevents.py         |  34 +++--
 tools/perf/pmu-events/pmu-events.h       |   3 +
 tools/perf/tests/pmu-events.c            | 136 +++++++++--------
 tools/perf/util/metricgroup.c            | 181 ++++++++++++++++-------
 tools/perf/util/pmu.c                    |  65 ++++----
 tools/perf/util/s390-sample-raw.c        |  42 ++++--
 7 files changed, 313 insertions(+), 182 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 028f44efe48d..bee1967baa2b 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -247,6 +247,20 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 };
 
+int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
+				    void *data)
+{
+	for (const struct pmu_event *pe = &table[0];
+	     pe->name || pe->metric_group || pe->metric_name;
+	     pe++) {
+		int ret = fn(pe, table, data);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
 {
 	const struct pmu_event *table = NULL;
@@ -291,14 +305,10 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
 	     tables->table;
 	     tables++) {
-		for (const struct pmu_event *pe = &tables->table[0];
-		     pe->name || pe->metric_group || pe->metric_name;
-		     pe++) {
-			int ret = fn(pe, &tables->table[0], data);
+		int ret = pmu_events_table_for_each_event(tables->table, fn, data);
 
-			if (ret)
-				return ret;
-		}
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -319,14 +329,10 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 	     tables->name;
 	     tables++) {
-		for (const struct pmu_event *pe = &tables->table[0];
-		     pe->name || pe->metric_group || pe->metric_name;
-		     pe++) {
-			int ret = fn(pe, &tables->table[0], data);
+		int ret = pmu_events_table_for_each_event(tables->table, fn, data);
 
-			if (ret)
-				return ret;
-		}
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 800db6364078..3cb8a196a76d 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -410,6 +410,20 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 \t},
 };
 
+int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
+                                    void *data)
+{
+        for (const struct pmu_event *pe = &table[0];
+             pe->name || pe->metric_group || pe->metric_name;
+             pe++) {
+                int ret = fn(pe, table, data);
+
+                if (ret)
+                        return ret;
+        }
+        return 0;
+}
+
 const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
 {
         const struct pmu_event *table = NULL;
@@ -453,14 +467,10 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
              tables->table;
              tables++) {
-                for (const struct pmu_event *pe = &tables->table[0];
-                     pe->name || pe->metric_group || pe->metric_name;
-                     pe++) {
-                        int ret = fn(pe, &tables->table[0], data);
+                int ret = pmu_events_table_for_each_event(tables->table, fn, data);
 
-                        if (ret)
-                                return ret;
-                }
+                if (ret)
+                        return ret;
         }
         return 0;
 }
@@ -481,14 +491,10 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
              tables->name;
              tables++) {
-                for (const struct pmu_event *pe = &tables->table[0];
-                     pe->name || pe->metric_group || pe->metric_name;
-                     pe++) {
-                        int ret = fn(pe, &tables->table[0], data);
+                int ret = pmu_events_table_for_each_event(tables->table, fn, data);
 
-                        if (ret)
-                                return ret;
-                }
+                if (ret)
+                        return ret;
         }
         return 0;
 }
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 485e730f9922..70672842f77f 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -34,6 +34,9 @@ typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_event *table,
 				 void *data);
 
+int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
+				    void *data);
+
 const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu);
 const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index e8df6bc26ebd..1c3479e5890e 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -423,84 +423,104 @@ static int compare_alias_to_test_event(struct perf_pmu_alias *alias,
 	return 0;
 }
 
-/* Verify generated events from pmu-events.c are as expected */
-static int test__pmu_event_table(struct test_suite *test __maybe_unused,
-				 int subtest __maybe_unused)
+static int test__pmu_event_table_core_callback(const struct pmu_event *pe,
+					       const struct pmu_event *table __maybe_unused,
+					       void *data)
 {
-	const struct pmu_event *sys_event_tables = find_sys_events_table("pme_test_soc_sys");
-	const struct pmu_event *table = find_core_events_table("testarch", "testcpu");
-	int map_events = 0, expected_events;
+	int *map_events = data;
+	struct perf_pmu_test_event const **test_event_table;
+	bool found = false;
 
-	/* ignore 3x sentinels */
-	expected_events = ARRAY_SIZE(core_events) +
-			  ARRAY_SIZE(uncore_events) +
-			  ARRAY_SIZE(sys_events) - 3;
+	if (!pe->name)
+		return 0;
 
-	if (!table || !sys_event_tables)
-		return -1;
+	if (pe->pmu)
+		test_event_table = &uncore_events[0];
+	else
+		test_event_table = &core_events[0];
 
-	for (; table->name; table++) {
-		struct perf_pmu_test_event const **test_event_table;
-		bool found = false;
+	for (; *test_event_table; test_event_table++) {
+		struct perf_pmu_test_event const *test_event = *test_event_table;
+		struct pmu_event const *event = &test_event->event;
 
-		if (table->pmu)
-			test_event_table = &uncore_events[0];
-		else
-			test_event_table = &core_events[0];
+		if (strcmp(pe->name, event->name))
+			continue;
+		found = true;
+		(*map_events)++;
 
-		for (; *test_event_table; test_event_table++) {
-			struct perf_pmu_test_event const *test_event = *test_event_table;
-			struct pmu_event const *event = &test_event->event;
+		if (compare_pmu_events(pe, event))
+			return -1;
 
-			if (strcmp(table->name, event->name))
-				continue;
-			found = true;
-			map_events++;
+		pr_debug("testing event table %s: pass\n", pe->name);
+	}
+	if (!found) {
+		pr_err("testing event table: could not find event %s\n", pe->name);
+		return -1;
+	}
+	return 0;
+}
 
-			if (compare_pmu_events(table, event))
-				return -1;
+static int test__pmu_event_table_sys_callback(const struct pmu_event *pe,
+					      const struct pmu_event *table __maybe_unused,
+					      void *data)
+{
+	int *map_events = data;
+	struct perf_pmu_test_event const **test_event_table;
+	bool found = false;
 
-			pr_debug("testing event table %s: pass\n", table->name);
-		}
+	test_event_table = &sys_events[0];
 
-		if (!found) {
-			pr_err("testing event table: could not find event %s\n",
-			       table->name);
-			return -1;
-		}
-	}
+	for (; *test_event_table; test_event_table++) {
+		struct perf_pmu_test_event const *test_event = *test_event_table;
+		struct pmu_event const *event = &test_event->event;
 
-	for (table = sys_event_tables; table->name; table++) {
-		struct perf_pmu_test_event const **test_event_table;
-		bool found = false;
+		if (strcmp(pe->name, event->name))
+			continue;
+		found = true;
+		(*map_events)++;
 
-		test_event_table = &sys_events[0];
+		if (compare_pmu_events(pe, event))
+			return TEST_FAIL;
 
-		for (; *test_event_table; test_event_table++) {
-			struct perf_pmu_test_event const *test_event = *test_event_table;
-			struct pmu_event const *event = &test_event->event;
+		pr_debug("testing sys event table %s: pass\n", pe->name);
+	}
+	if (!found) {
+		pr_debug("testing sys event table: could not find event %s\n", pe->name);
+		return TEST_FAIL;
+	}
+	return TEST_OK;
+}
 
-			if (strcmp(table->name, event->name))
-				continue;
-			found = true;
-			map_events++;
+/* Verify generated events from pmu-events.c are as expected */
+static int test__pmu_event_table(struct test_suite *test __maybe_unused,
+				 int subtest __maybe_unused)
+{
+	const struct pmu_event *sys_event_table = find_sys_events_table("pme_test_soc_sys");
+	const struct pmu_event *table = find_core_events_table("testarch", "testcpu");
+	int map_events = 0, expected_events, err;
 
-			if (compare_pmu_events(table, event))
-				return -1;
+	/* ignore 3x sentinels */
+	expected_events = ARRAY_SIZE(core_events) +
+			  ARRAY_SIZE(uncore_events) +
+			  ARRAY_SIZE(sys_events) - 3;
 
-			pr_debug("testing sys event table %s: pass\n", table->name);
-		}
-		if (!found) {
-			pr_debug("testing event table: could not find event %s\n",
-				   table->name);
-			return -1;
-		}
-	}
+	if (!table || !sys_event_table)
+		return -1;
+
+	err = pmu_events_table_for_each_event(table, test__pmu_event_table_core_callback,
+					      &map_events);
+	if (err)
+		return err;
+
+	err = pmu_events_table_for_each_event(sys_event_table, test__pmu_event_table_sys_callback,
+					      &map_events);
+	if (err)
+		return err;
 
 	if (map_events != expected_events) {
 		pr_err("testing event table: found %d, but expected %d\n",
 		       map_events, expected_events);
-		return -1;
+		return TEST_FAIL;
 	}
 
 	return 0;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 680f7c63838d..f702b73a7609 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -538,12 +538,40 @@ static int metricgroup__print_sys_event_iter(const struct pmu_event *pe,
 				     d->details, d->groups, d->metriclist);
 }
 
+struct metricgroup_print_data {
+	const char *pmu_name;
+	struct strlist *metriclist;
+	char *filter;
+	struct rblist *groups;
+	bool metricgroups;
+	bool raw;
+	bool details;
+};
+
+static int metricgroup__print_callback(const struct pmu_event *pe,
+				       const struct pmu_event *table __maybe_unused,
+				       void *vdata)
+{
+	struct metricgroup_print_data *data = vdata;
+
+	if (!pe->metric_expr)
+		return 0;
+
+	if (data->pmu_name && perf_pmu__is_hybrid(pe->pmu) && strcmp(data->pmu_name, pe->pmu))
+		return 0;
+
+	return metricgroup__print_pmu_event(pe, data->metricgroups, data->filter,
+					    data->raw, data->details, data->groups,
+					    data->metriclist);
+}
+
 void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 			bool raw, bool details, const char *pmu_name)
 {
 	struct rblist groups;
 	struct rb_node *node, *next;
 	struct strlist *metriclist = NULL;
+	const struct pmu_event *table;
 
 	if (!metricgroups) {
 		metriclist = strlist__new(NULL, NULL);
@@ -555,22 +583,22 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
-	for (const struct pmu_event *pe = pmu_events_map__find(); pe; pe++) {
+	table = pmu_events_map__find();
+	if (table) {
+		struct metricgroup_print_data data = {
+			.pmu_name = pmu_name,
+			.metriclist = metriclist,
+			.metricgroups = metricgroups,
+			.filter = filter,
+			.raw = raw,
+			.details = details,
+			.groups = &groups,
+		};
 
-		if (!pe->name && !pe->metric_group && !pe->metric_name)
-			break;
-		if (!pe->metric_expr)
-			continue;
-		if (pmu_name && perf_pmu__is_hybrid(pe->pmu) &&
-		    strcmp(pmu_name, pe->pmu)) {
-			continue;
-		}
-		if (metricgroup__print_pmu_event(pe, metricgroups, filter,
-						 raw, details, &groups,
-						 metriclist) < 0)
-			return;
+		pmu_events_table_for_each_event(table,
+						metricgroup__print_callback,
+						&data);
 	}
-
 	{
 		struct metricgroup_iter_data data = {
 			.fn = metricgroup__print_sys_event_iter,
@@ -1043,30 +1071,35 @@ static int __add_metric(struct list_head *metric_list,
 	return ret;
 }
 
-#define table_for_each_event(__pe, __idx, __table)					\
-	if (__table)								\
-		for (__idx = 0, __pe = &__table[__idx];				\
-		     __pe->name || __pe->metric_group || __pe->metric_name;	\
-		     __pe = &__table[++__idx])
+struct metricgroup__find_metric_data {
+	const char *metric;
+	const struct pmu_event *pe;
+};
+
+static int metricgroup__find_metric_callback(const struct pmu_event *pe,
+					     const struct pmu_event *table  __maybe_unused,
+					     void *vdata)
+{
+	struct metricgroup__find_metric_data *data = vdata;
+
+	if (!match_metric(pe->metric_name, data->metric))
+		return 0;
 
-#define table_for_each_metric(__pe, __idx, __table, __metric)		\
-	table_for_each_event(__pe, __idx, __table)				\
-		if (__pe->metric_expr &&				\
-		    (match_metric(__pe->metric_group, __metric) ||	\
-		     match_metric(__pe->metric_name, __metric)))
+	data->pe = pe;
+	return -1;
+}
 
 const struct pmu_event *metricgroup__find_metric(const char *metric,
 						 const struct pmu_event *table)
 {
-	const struct pmu_event *pe;
-	int i;
+	struct metricgroup__find_metric_data data = {
+		.metric = metric,
+		.pe = NULL,
+	};
 
-	table_for_each_event(pe, i, table) {
-		if (match_metric(pe->metric_name, metric))
-			return pe;
-	}
+	pmu_events_table_for_each_event(table, metricgroup__find_metric_callback, &data);
 
-	return NULL;
+	return data.pe;
 }
 
 static int add_metric(struct list_head *metric_list,
@@ -1151,6 +1184,33 @@ static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
 	return right_count - left_count;
 }
 
+struct metricgroup__add_metric_data {
+	struct list_head *list;
+	const char *metric_name;
+	const char *modifier;
+	bool metric_no_group;
+	bool has_match;
+};
+
+static int metricgroup__add_metric_callback(const struct pmu_event *pe,
+					    const struct pmu_event *table,
+					    void *vdata)
+{
+	struct metricgroup__add_metric_data *data = vdata;
+	int ret = 0;
+
+	if (pe->metric_expr &&
+		(match_metric(pe->metric_group, data->metric_name) ||
+		 match_metric(pe->metric_name, data->metric_name))) {
+
+		data->has_match = true;
+		ret = add_metric(data->list, pe, data->modifier, data->metric_no_group,
+				 /*root_metric=*/NULL,
+				 /*visited_metrics=*/NULL, table);
+	}
+	return ret;
+}
+
 /**
  * metricgroup__add_metric - Find and add a metric, or a metric group.
  * @metric_name: The name of the metric or metric group. For example, "IPC"
@@ -1169,24 +1229,29 @@ static int metricgroup__add_metric(const char *metric_name, const char *modifier
 				   struct list_head *metric_list,
 				   const struct pmu_event *table)
 {
-	const struct pmu_event *pe;
 	LIST_HEAD(list);
-	int i, ret;
+	int ret;
 	bool has_match = false;
 
-	/*
-	 * Iterate over all metrics seeing if metric matches either the name or
-	 * group. When it does add the metric to the list.
-	 */
-	table_for_each_metric(pe, i, table, metric_name) {
-		has_match = true;
-		ret = add_metric(&list, pe, modifier, metric_no_group,
-				 /*root_metric=*/NULL,
-				 /*visited_metrics=*/NULL, table);
+	{
+		struct metricgroup__add_metric_data data = {
+			.list = &list,
+			.metric_name = metric_name,
+			.modifier = modifier,
+			.metric_no_group = metric_no_group,
+			.has_match = false,
+		};
+		/*
+		 * Iterate over all metrics seeing if metric matches either the
+		 * name or group. When it does add the metric to the list.
+		 */
+		ret = pmu_events_table_for_each_event(table, metricgroup__add_metric_callback,
+						      &data);
 		if (ret)
 			goto out;
-	}
 
+		has_match = data.has_match;
+	}
 	{
 		struct metricgroup_iter_data data = {
 			.fn = metricgroup__add_metric_sys_event_iter,
@@ -1602,26 +1667,30 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 			    metric_no_merge, &perf_pmu__fake, metric_events, table);
 }
 
+static int metricgroup__has_metric_callback(const struct pmu_event *pe,
+					    const struct pmu_event *table __maybe_unused,
+					    void *vdata)
+{
+	const char *metric = vdata;
+
+	if (!pe->metric_expr)
+		return 0;
+
+	if (match_metric(pe->metric_name, metric))
+		return 1;
+
+	return 0;
+}
+
 bool metricgroup__has_metric(const char *metric)
 {
 	const struct pmu_event *table = pmu_events_map__find();
-	const struct pmu_event *pe;
-	int i;
 
 	if (!table)
 		return false;
 
-	for (i = 0; ; i++) {
-		pe = &table[i];
-
-		if (!pe->name && !pe->metric_group && !pe->metric_name)
-			break;
-		if (!pe->metric_expr)
-			continue;
-		if (match_metric(pe->metric_name, metric))
-			return true;
-	}
-	return false;
+	return pmu_events_table_for_each_event(table, metricgroup__has_metric_callback,
+					       (void *)metric) ? true : false;
 }
 
 int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 893cc0ff7758..7398a277c742 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -791,6 +791,36 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 	return res;
 }
 
+struct pmu_add_cpu_aliases_map_data {
+	struct list_head *head;
+	const char *name;
+	const char *cpu_name;
+	struct perf_pmu *pmu;
+};
+
+static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
+					const struct pmu_event *table __maybe_unused,
+					void *vdata)
+{
+	struct pmu_add_cpu_aliases_map_data *data = vdata;
+	const char *pname = pe->pmu ? pe->pmu : data->cpu_name;
+
+	if (!pe->name)
+		return 0;
+
+	if (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->name))
+		goto new_alias;
+
+	if (strcmp(pname, data->name))
+		return 0;
+
+new_alias:
+	/* need type casts to override 'const' */
+	__perf_pmu__new_alias(data->head, NULL, (char *)pe->name, (char *)pe->desc,
+			      (char *)pe->event, pe);
+	return 0;
+}
+
 /*
  * From the pmu_events_map, find the table of PMU events that corresponds
  * to the current running CPU. Then, add all PMU events from that table
@@ -799,35 +829,14 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
 			     const struct pmu_event *table)
 {
-	int i;
-	const char *name = pmu->name;
-	/*
-	 * Found a matching PMU events table. Create aliases
-	 */
-	i = 0;
-	while (1) {
-		const char *cpu_name = is_arm_pmu_core(name) ? name : "cpu";
-		const struct pmu_event *pe = &table[i++];
-		const char *pname = pe->pmu ? pe->pmu : cpu_name;
-
-		if (!pe->name) {
-			if (pe->metric_group || pe->metric_name)
-				continue;
-			break;
-		}
-
-		if (pmu->is_uncore && pmu_uncore_alias_match(pname, name))
-			goto new_alias;
-
-		if (strcmp(pname, name))
-			continue;
+	struct pmu_add_cpu_aliases_map_data data = {
+		.head = head,
+		.name = pmu->name,
+		.cpu_name = is_arm_pmu_core(pmu->name) ? pmu->name : "cpu",
+		.pmu = pmu,
+	};
 
-new_alias:
-		/* need type casts to override 'const' */
-		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-				(char *)pe->desc, (char *)pe->event,
-				pe);
-	}
+	pmu_events_table_for_each_event(table, pmu_add_cpu_aliases_map_callback, &data);
 }
 
 static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 1ecb718fc0eb..b1c052c176bb 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -129,6 +129,28 @@ static int get_counterset_start(int setnr)
 	}
 }
 
+struct get_counter_name_data {
+	int wanted;
+	const char *result;
+};
+
+static int get_counter_name_callback(const struct pmu_event *evp,
+				     const struct pmu_event *table __maybe_unused,
+				     void *vdata)
+{
+	struct get_counter_name_data *data = vdata;
+	int rc, event_nr;
+
+	if (evp->name == NULL || evp->event == NULL)
+		return 0;
+	rc = sscanf(evp->event, "event=%x", &event_nr);
+	if (rc == 1 && event_nr == data->wanted) {
+		data->result = evp->name;
+		return 1; /* Terminate the search. */
+	}
+	return 0;
+}
+
 /* Scan the PMU table and extract the logical name of a counter from the
  * PMU events table. Input is the counter set and counter number with in the
  * set. Construct the event number and use this as key. If they match return
@@ -137,20 +159,16 @@ static int get_counterset_start(int setnr)
  */
 static const char *get_counter_name(int set, int nr, const struct pmu_event *table)
 {
-	int rc, event_nr, wanted = get_counterset_start(set) + nr;
+	struct get_counter_name_data data = {
+		.wanted = get_counterset_start(set) + nr,
+		.result = NULL,
+	};
 
-	if (table) {
-		const struct pmu_event *evp = table;
+	if (!table)
+		return NULL;
 
-		for (; evp->name || evp->event || evp->desc; ++evp) {
-			if (evp->name == NULL || evp->event == NULL)
-				continue;
-			rc = sscanf(evp->event, "event=%x", &event_nr);
-			if (rc == 1 && event_nr == wanted)
-				return evp->name;
-		}
-	}
-	return NULL;
+	pmu_events_table_for_each_event(table, get_counter_name_callback, &data);
+	return data.result;
 }
 
 static void s390_cpumcfdg_dump(struct perf_sample *sample)
-- 
2.37.1.455.g008518b4e5-goog

