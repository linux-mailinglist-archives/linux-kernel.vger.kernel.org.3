Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AB48B071
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbiAKPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:44 -0500
Received: from foss.arm.com ([217.140.110.172]:47886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242050AbiAKPIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4399EED1;
        Tue, 11 Jan 2022 07:08:42 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.36.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3B5F3F774;
        Tue, 11 Jan 2022 07:08:39 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com, irogers@google.com,
        ak@linux.intel.com
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH v2 4/5] perf stat: Detect if topdown kernel events supported
Date:   Tue, 11 Jan 2022 15:07:48 +0000
Message-Id: <20220111150749.13365-5-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111150749.13365-1-andrew.kilroy@arm.com>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks if the kernel events topdown implementation can be set
up.

Do this by iterating over two arrays defining what kernel events should
be present.  If one of those arrays define at least one event that is
present, the kernel events are supported.

If no topdown kernel events are detected, the json metrics approach is
attempted.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 tools/perf/builtin-stat.c | 114 +++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6122f3a764f8..2f579d29f9f5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -93,6 +93,7 @@
 
 #include <linux/ctype.h>
 #include <perf/evlist.h>
+#include <linux/string.h>
 
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
@@ -1649,6 +1650,75 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+// Return the number of elements in the array excluding the final
+// NULL array element.
+static size_t str_array_len(const char **str)
+{
+	size_t c = 0;
+	while (str[c] != NULL) {
+		++c;
+	}
+	return c;
+}
+
+// Checks if topdown kernel events listed by the given
+// array of event names are supported.
+//
+// The input array is not modified.
+//
+// Returns 1 if supported,
+//         0 if not supported,
+//         -1 if some unexpected error occurred while checking
+static int check_events_available(const char **orig_events_array)
+{
+	char *str = NULL;
+	size_t basic_events_len = str_array_len(orig_events_array);
+	size_t basic_events_cpy_bytes = sizeof(const char *) * (basic_events_len + 1);
+	const char **basic_events = NULL;
+
+	// This function shouldn't have any side effects.
+	// Since topdown_filter_events mutates the arrays it inspects,
+	// this function takes temporary shallow copies of the input
+	// string array
+	basic_events = memdup(orig_events_array, basic_events_cpy_bytes);
+	if (basic_events == NULL) {
+		pr_err("Out of memory, could not copy topdown events array\n");
+		return -1;
+	}
+
+	if (topdown_filter_events(basic_events, &str, 1) < 0) {
+		pr_err("Out of memory, could not form events string\n");
+		free(basic_events);
+		return -1;
+	}
+	if (basic_events[0] && str) {
+		free(basic_events);
+		free(str);
+		return 1;
+	}
+	free(basic_events);
+	free(str);
+
+	return 0;
+}
+
+// Checks if topdown kernel events support has been detected
+// on this system.
+//
+// Returns 1 if supported,
+//         0 if not supported,
+//         -1 if some unexpected error occurred while checking
+static int topdown_kernel_events_supported(void)
+{
+	int l1_and_l2_available = check_events_available(topdown_metric_L2_attrs);
+
+	if (l1_and_l2_available == 0) {
+		return check_events_available(topdown_attrs);
+	} else {
+		return l1_and_l2_available;
+	}
+}
+
 static int try_non_json_metrics_topdown(void)
 {
 	int err = 0;
@@ -1736,6 +1806,27 @@ static int try_json_metrics_topdown(void)
 	return 0;
 }
 
+enum topdown_mechanism {
+	TOPDOWN_JSON_METRICS,
+	TOPDOWN_KERNEL_EVENTS,
+	TOPDOWN_DETECTION_ERROR,
+};
+
+static enum topdown_mechanism choose_topdown_mechanism(void)
+{
+	int kernel_events_supported = topdown_kernel_events_supported();
+
+	if (kernel_events_supported > 0) {
+		pr_debug("topdown kernel events are supported\n");
+		return TOPDOWN_KERNEL_EVENTS;
+	} else if (kernel_events_supported == 0) {
+		pr_debug("topdown kernel events are unsupported\n");
+		return TOPDOWN_JSON_METRICS;
+	} else {
+		return TOPDOWN_DETECTION_ERROR;
+	}
+}
+
 /*
  * Add default attributes, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -1935,17 +2026,24 @@ static int add_default_attributes(void)
 	}
 
 	if (topdown_run) {
+		int topdown_err = 0;
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		if (topdown_can_use_json_metrics()) {
-			err = try_json_metrics_topdown();
-			if (err)
-				return err;
-		} else {
-			err = try_non_json_metrics_topdown();
-			if (err)
-				return err;
+		switch (choose_topdown_mechanism()) {
+		case TOPDOWN_JSON_METRICS:
+			topdown_err = try_json_metrics_topdown();
+			break;
+		case TOPDOWN_DETECTION_ERROR:
+			return -1;
+		case TOPDOWN_KERNEL_EVENTS:
+		default:
+			topdown_err = try_non_json_metrics_topdown();
+			break;
+		}
+
+		if (topdown_err < 0) {
+			return -1;
 		}
 	}
 
-- 
2.17.1

