Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA448B06E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbiAKPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:33 -0500
Received: from foss.arm.com ([217.140.110.172]:47848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245127AbiAKPIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F61DED1;
        Tue, 11 Jan 2022 07:08:30 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.36.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 064D23F774;
        Tue, 11 Jan 2022 07:08:27 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com, irogers@google.com,
        ak@linux.intel.com
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH v2 2/5] perf stat: Topdown kernel events setup function
Date:   Tue, 11 Jan 2022 15:07:46 +0000
Message-Id: <20220111150749.13365-3-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111150749.13365-1-andrew.kilroy@arm.com>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code block that sets up topdown by using kernel events into its
own function.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 tools/perf/builtin-stat.c | 157 ++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 75 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 975b1e0edaf4..ab956ac97d94 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1649,6 +1649,84 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+static int try_non_json_metrics_topdown(void)
+{
+	int err;
+	const char **metric_attrs = topdown_metric_attrs;
+	unsigned int max_level = 1;
+	char *str = NULL;
+	bool warn = false;
+
+	if (!force_metric_only)
+		stat_config.metric_only = true;
+
+	if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
+		metric_attrs = topdown_metric_L2_attrs;
+		max_level = 2;
+	}
+
+	if (stat_config.topdown_level > max_level) {
+		pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
+		return -1;
+	} else if (!stat_config.topdown_level)
+		stat_config.topdown_level = max_level;
+
+	if (topdown_filter_events(metric_attrs, &str, 1) < 0) {
+		pr_err("Out of memory\n");
+		return -1;
+	}
+	if (metric_attrs[0] && str) {
+		if (!stat_config.interval && !stat_config.metric_only) {
+			fprintf(stat_config.output,
+				"Topdown accuracy may decrease when measuring long periods.\n"
+				"Please print the result regularly, e.g. -I1000\n");
+		}
+		goto setup_metrics;
+	}
+
+	zfree(&str);
+
+	if (stat_config.aggr_mode != AGGR_GLOBAL &&
+		stat_config.aggr_mode != AGGR_CORE) {
+		pr_err("top down event configuration requires --per-core mode\n");
+		return -1;
+	}
+	stat_config.aggr_mode = AGGR_CORE;
+	if (nr_cgroups || !target__has_cpu(&target)) {
+		pr_err("top down event configuration requires system-wide mode (-a)\n");
+		return -1;
+	}
+
+	if (topdown_filter_events(topdown_attrs, &str,
+			arch_topdown_check_group(&warn)) < 0) {
+		pr_err("Out of memory\n");
+		return -1;
+	}
+	if (topdown_attrs[0] && str) {
+		struct parse_events_error errinfo;
+		if (warn)
+			arch_topdown_group_warn();
+setup_metrics:
+		parse_events_error__init(&errinfo);
+		err = parse_events(evsel_list, str, &errinfo);
+		if (err) {
+			fprintf(stderr,
+				"Cannot set up top down events %s: %d\n",
+				str, err);
+			parse_events_error__print(&errinfo, str);
+			parse_events_error__exit(&errinfo);
+			free(str);
+			return -1;
+		}
+		parse_events_error__exit(&errinfo);
+	} else {
+		fprintf(stderr, "System does not support topdown\n");
+		return -1;
+	}
+	free(str);
+	return err;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1848,14 +1926,6 @@ static int add_default_attributes(void)
 	}
 
 	if (topdown_run) {
-		const char **metric_attrs = topdown_metric_attrs;
-		unsigned int max_level = 1;
-		char *str = NULL;
-		bool warn = false;
-
-		if (!force_metric_only)
-			stat_config.metric_only = true;
-
 		if (topdown_can_use_json_metrics()) {
 			if (metricgroup__parse_groups_to_evlist(evsel_list, "TopDownL1",
 								stat_config.metric_no_group,
@@ -1864,75 +1934,12 @@ static int add_default_attributes(void)
 				pr_err("Could not form list of metrics for topdown\n");
 				return -1;
 			}
-
-			goto end_of_topdown_setup;
-		}
-
-		if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
-			metric_attrs = topdown_metric_L2_attrs;
-			max_level = 2;
-		}
-
-		if (stat_config.topdown_level > max_level) {
-			pr_err("Invalid top-down metrics level. The max level is %u.\n", max_level);
-			return -1;
-		} else if (!stat_config.topdown_level)
-			stat_config.topdown_level = max_level;
-
-		if (topdown_filter_events(metric_attrs, &str, 1) < 0) {
-			pr_err("Out of memory\n");
-			return -1;
-		}
-		if (metric_attrs[0] && str) {
-			if (!stat_config.interval && !stat_config.metric_only) {
-				fprintf(stat_config.output,
-					"Topdown accuracy may decrease when measuring long periods.\n"
-					"Please print the result regularly, e.g. -I1000\n");
-			}
-			goto setup_metrics;
-		}
-
-		zfree(&str);
-
-		if (stat_config.aggr_mode != AGGR_GLOBAL &&
-		    stat_config.aggr_mode != AGGR_CORE) {
-			pr_err("top down event configuration requires --per-core mode\n");
-			return -1;
-		}
-		stat_config.aggr_mode = AGGR_CORE;
-		if (nr_cgroups || !target__has_cpu(&target)) {
-			pr_err("top down event configuration requires system-wide mode (-a)\n");
-			return -1;
-		}
-
-		if (topdown_filter_events(topdown_attrs, &str,
-				arch_topdown_check_group(&warn)) < 0) {
-			pr_err("Out of memory\n");
-			return -1;
-		}
-		if (topdown_attrs[0] && str) {
-			struct parse_events_error errinfo;
-			if (warn)
-				arch_topdown_group_warn();
-setup_metrics:
-			parse_events_error__init(&errinfo);
-			err = parse_events(evsel_list, str, &errinfo);
-			if (err) {
-				fprintf(stderr,
-					"Cannot set up top down events %s: %d\n",
-					str, err);
-				parse_events_error__print(&errinfo, str);
-				parse_events_error__exit(&errinfo);
-				free(str);
-				return -1;
-			}
-			parse_events_error__exit(&errinfo);
 		} else {
-			fprintf(stderr, "System does not support topdown\n");
-			return -1;
+			err = try_non_json_metrics_topdown();
+			if (err)
+				return err;
 		}
-end_of_topdown_setup:
-		free(str);
+
 	}
 
 	if (!evsel_list->core.nr_entries) {
-- 
2.17.1

