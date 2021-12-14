Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912FC474B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhLNSnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:43:03 -0500
Received: from foss.arm.com ([217.140.110.172]:35106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231756AbhLNSnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:43:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122196D;
        Tue, 14 Dec 2021 10:43:02 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.33.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD6FD3F5A1;
        Tue, 14 Dec 2021 10:42:58 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
Date:   Tue, 14 Dec 2021 18:42:40 +0000
Message-Id: <20211214184240.24215-2-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214184240.24215-1-andrew.kilroy@arm.com>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
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
 tools/perf/arch/arm64/util/Build     |  1 +
 tools/perf/arch/arm64/util/topdown.c |  8 ++++++++
 tools/perf/builtin-stat.c            | 13 +++++++++++++
 tools/perf/util/metricgroup.c        | 12 ++++++++++++
 tools/perf/util/metricgroup.h        |  7 +++++++
 tools/perf/util/topdown.c            |  6 ++++++
 tools/perf/util/topdown.h            |  1 +
 7 files changed, 48 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/topdown.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 9fcb4e68add9..9807aed981cd 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -4,6 +4,7 @@ perf-y += perf_regs.o
 perf-y += tsc.o
 perf-y += pmu.o
 perf-y += kvm-stat.o
+perf-y += topdown.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/topdown.c b/tools/perf/arch/arm64/util/topdown.c
new file mode 100644
index 000000000000..a2b1f9c01148
--- /dev/null
+++ b/tools/perf/arch/arm64/util/topdown.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <topdown.h>
+
+
+bool arch_topdown_use_json_metrics(void)
+{
+	return true;
+}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6ca2b054c5b..08ef80ef345e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1856,6 +1856,18 @@ static int add_default_attributes(void)
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
+		if (arch_topdown_use_json_metrics()) {
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
index 1081b20f9891..57c0c5f2c6bd 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
 {
 	return false;
 }
+
+__weak bool arch_topdown_use_json_metrics(void)
+{
+	return false;
+}
+
diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
index 2f0d0b887639..0a5275a3f078 100644
--- a/tools/perf/util/topdown.h
+++ b/tools/perf/util/topdown.h
@@ -6,6 +6,7 @@
 bool arch_topdown_check_group(bool *warn);
 void arch_topdown_group_warn(void);
 bool arch_topdown_sample_read(struct evsel *leader);
+bool arch_topdown_use_json_metrics(void);
 
 int topdown_filter_events(const char **attr, char **str, bool use_group);
 
-- 
2.17.1

