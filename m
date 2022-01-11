Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6BB48B072
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiAKPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:08:52 -0500
Received: from foss.arm.com ([217.140.110.172]:47904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241575AbiAKPIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:08:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EDF2ED1;
        Tue, 11 Jan 2022 07:08:50 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.36.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B7C23F774;
        Tue, 11 Jan 2022 07:08:47 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com, irogers@google.com,
        ak@linux.intel.com
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH v2 5/5] perf stat: Ensure only topdown kernel events used on x86
Date:   Tue, 11 Jan 2022 15:07:49 +0000
Message-Id: <20220111150749.13365-6-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111150749.13365-1-andrew.kilroy@arm.com>
References: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
 <20220111150749.13365-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on advice here:

  https://lore.kernel.org/linux-perf-users/12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com/#t

Only use the existing kernel events topdown mechanism on x86, not the
json metrics approach.  Disabling the json metrics because of concerns
that due to SMT it's not straightforward to express the various formulas
as json for certain x86 cpus.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 tools/perf/builtin-stat.c | 22 +++++++++++++---------
 tools/perf/util/topdown.c |  6 +++---
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2f579d29f9f5..eee58fbf1986 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1814,16 +1814,20 @@ enum topdown_mechanism {
 
 static enum topdown_mechanism choose_topdown_mechanism(void)
 {
-	int kernel_events_supported = topdown_kernel_events_supported();
-
-	if (kernel_events_supported > 0) {
-		pr_debug("topdown kernel events are supported\n");
-		return TOPDOWN_KERNEL_EVENTS;
-	} else if (kernel_events_supported == 0) {
-		pr_debug("topdown kernel events are unsupported\n");
-		return TOPDOWN_JSON_METRICS;
+	if (topdown_can_use_json_metrics()) {
+		int kernel_events_supported = topdown_kernel_events_supported();
+
+		if (kernel_events_supported > 0) {
+			pr_debug("topdown kernel events are supported\n");
+			return TOPDOWN_KERNEL_EVENTS;
+		} else if (kernel_events_supported == 0) {
+			pr_debug("topdown kernel events are unsupported\n");
+			return TOPDOWN_JSON_METRICS;
+		} else {
+			return TOPDOWN_DETECTION_ERROR;
+		}
 	} else {
-		return TOPDOWN_DETECTION_ERROR;
+		return TOPDOWN_KERNEL_EVENTS;
 	}
 }
 
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
index a542dddd97f3..36f6c29009fb 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -59,10 +59,10 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
 
 bool topdown_can_use_json_metrics(void)
 {
-#if defined(__aarch64__)
-	return true;
-#else
+#if defined(__i386__) || defined(__x86_64__)
 	return false;
+#else
+	return true;
 #endif
 }
 
-- 
2.17.1

