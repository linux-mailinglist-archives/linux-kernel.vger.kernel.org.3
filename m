Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018C348B06D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbiAKPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:29 -0500
Received: from foss.arm.com ([217.140.110.172]:47824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244776AbiAKPIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 124AA1FB;
        Tue, 11 Jan 2022 07:08:25 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.36.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E7923F774;
        Tue, 11 Jan 2022 07:08:22 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com, irogers@google.com,
        ak@linux.intel.com
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH v2 1/5] perf stat: Implement --topdown with metrics
Date:   Tue, 11 Jan 2022 15:07:45 +0000
Message-Id: <20220111150749.13365-2-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111150749.13365-1-andrew.kilroy@arm.com>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the --topdown option by making use of metrics to
dictate what counters are obtained in order to show the various topdown
columns, e.g.  Frontend Bound, Backend Bound, Retiring and Bad
Speculation.

The MetricGroup name is used to identify which set of metrics are to be
shown.  For the moment use TopDownL1 and enable for arm64

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 tools/perf/builtin-stat.c     | 13 +++++++++++++
 tools/perf/util/metricgroup.c | 12 ++++++++++++
 tools/perf/util/metricgroup.h |  7 +++++++
 tools/perf/util/topdown.c     | 10 ++++++++++
 tools/perf/util/topdown.h     |  1 +
 5 files changed, 43 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6ca2b054c5b..975b1e0edaf4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1856,6 +1856,18 @@ static int add_default_attributes(void)
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
+		if (topdown_can_use_json_metrics()) {
+			if (metricgroup__parse_groups_to_evlist(evsel_list, "TopDownL1",
+								stat_config.metric_no_group,
+								stat_config.metric_no_merge,
+								&stat_config.metric_events) < 0) {
+				pr_err("Could not form list of metrics for topdown\n");
+				return -1;
+			}
+
+			goto end_of_topdown_setup;
+		}
+
 		if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
 			metric_attrs = topdown_metric_L2_attrs;
 			max_level = 2;
@@ -1919,6 +1931,7 @@ static int add_default_attributes(void)
 			fprintf(stderr, "System does not support topdown\n");
 			return -1;
 		}
+end_of_topdown_setup:
 		free(str);
 	}
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 51c99cb08abf..9b0394372096 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1535,6 +1535,18 @@ int metricgroup__parse_groups(const struct option *opt,
 			    metric_no_merge, NULL, metric_events, map);
 }
 
+int metricgroup__parse_groups_to_evlist(struct evlist *perf_evlist,
+					const char *str,
+					bool metric_no_group,
+					bool metric_no_merge,
+					struct rblist *metric_events)
+{
+	const struct pmu_events_map *map = pmu_events_map__find();
+
+	return parse_groups(perf_evlist, str, metric_no_group,
+			    metric_no_merge, NULL, metric_events, map);
+}
+
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_events_map *map,
 				   const char *str,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 2b42b778d1bf..1f143ad1d9e1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -70,6 +70,13 @@ int metricgroup__parse_groups(const struct option *opt,
 			      bool metric_no_group,
 			      bool metric_no_merge,
 			      struct rblist *metric_events);
+
+int metricgroup__parse_groups_to_evlist(struct evlist *perf_evlist,
+					const char *str,
+					bool metric_no_group,
+					bool metric_no_merge,
+					struct rblist *metric_events);
+
 const struct pmu_event *metricgroup__find_metric(const char *metric,
 						 const struct pmu_events_map *map);
 int metricgroup__parse_groups_test(struct evlist *evlist,
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
index 1081b20f9891..a542dddd97f3 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -56,3 +56,13 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
 {
 	return false;
 }
+
+bool topdown_can_use_json_metrics(void)
+{
+#if defined(__aarch64__)
+	return true;
+#else
+	return false;
+#endif
+}
+
diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
index 2f0d0b887639..3e28f77443d3 100644
--- a/tools/perf/util/topdown.h
+++ b/tools/perf/util/topdown.h
@@ -8,5 +8,6 @@ void arch_topdown_group_warn(void);
 bool arch_topdown_sample_read(struct evsel *leader);
 
 int topdown_filter_events(const char **attr, char **str, bool use_group);
+bool topdown_can_use_json_metrics(void);
 
 #endif
-- 
2.17.1

