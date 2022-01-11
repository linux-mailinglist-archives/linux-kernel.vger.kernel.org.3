Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0313148B070
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349363AbiAKPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:39 -0500
Received: from foss.arm.com ([217.140.110.172]:47868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245726AbiAKPIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845A7ED1;
        Tue, 11 Jan 2022 07:08:36 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.36.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D27533F774;
        Tue, 11 Jan 2022 07:08:33 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com, irogers@google.com,
        ak@linux.intel.com
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH v2 3/5] perf stat: Topdown json metrics setup function
Date:   Tue, 11 Jan 2022 15:07:47 +0000
Message-Id: <20220111150749.13365-4-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111150749.13365-1-andrew.kilroy@arm.com>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move into its own function, the set up of json metrics to measure L1
topdown statistics

Also move the setup of the metrics_only member of stat_config outside,
since its supposed to be common to both the kernel events and json
metrics implementations

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 tools/perf/builtin-stat.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ab956ac97d94..6122f3a764f8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1651,15 +1651,12 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 
 static int try_non_json_metrics_topdown(void)
 {
-	int err;
+	int err = 0;
 	const char **metric_attrs = topdown_metric_attrs;
 	unsigned int max_level = 1;
 	char *str = NULL;
 	bool warn = false;
 
-	if (!force_metric_only)
-		stat_config.metric_only = true;
-
 	if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
 		metric_attrs = topdown_metric_L2_attrs;
 		max_level = 2;
@@ -1727,6 +1724,18 @@ static int try_non_json_metrics_topdown(void)
 	return err;
 }
 
+static int try_json_metrics_topdown(void)
+{
+	if (metricgroup__parse_groups_to_evlist(evsel_list, "TopDownL1",
+						stat_config.metric_no_group,
+						stat_config.metric_no_merge,
+						&stat_config.metric_events) < 0) {
+		pr_err("Could not form list of metrics for topdown\n");
+		return -1;
+	}
+	return 0;
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1926,20 +1935,18 @@ static int add_default_attributes(void)
 	}
 
 	if (topdown_run) {
+		if (!force_metric_only)
+			stat_config.metric_only = true;
+
 		if (topdown_can_use_json_metrics()) {
-			if (metricgroup__parse_groups_to_evlist(evsel_list, "TopDownL1",
-								stat_config.metric_no_group,
-								stat_config.metric_no_merge,
-								&stat_config.metric_events) < 0) {
-				pr_err("Could not form list of metrics for topdown\n");
-				return -1;
-			}
+			err = try_json_metrics_topdown();
+			if (err)
+				return err;
 		} else {
 			err = try_non_json_metrics_topdown();
 			if (err)
 				return err;
 		}
-
 	}
 
 	if (!evsel_list->core.nr_entries) {
-- 
2.17.1

