Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CC50B0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444601AbiDVHAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443796AbiDVHAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:00:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10821506CA;
        Thu, 21 Apr 2022 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650610634; x=1682146634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioBhvk5SeCW3677/2O3dalL0EN7gGU2noVHqmW4XWY0=;
  b=iIQnPtahMgCzN7FcWLqnuYJPGSleEmJU0IvywFx+4w3JYaTEb6Vf66n3
   ygjJkXR+BFnNIPvuZ3J+6ChwB+xhdBZddjoAfGxF8/o61qJ/RxApOOqfY
   9I7k/IdxcfMVv6h3SAlipdFn+AdCiGMU9EF8asmXodDBsPGkyja20CdkG
   Qku1g9AxL8ZdEOy4Zkpcxm9uCL5MvOK3g9ALjHUST3DLXV1AF4fuRF63U
   xnUUjNALtJDlQijKeOThYExbfQsHmq1GrBt9cOoFdn+IHC2QNvZOPlKES
   PooO1Uhqaz8vr6xrlV5+3O61Z9EfC8BCBEmtoVubEAsBknLDlt7nz2jKs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264370137"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264370137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="703427939"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 23:57:09 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 3/3] perf stat: Support hybrid --topdown option
Date:   Fri, 22 Apr 2022 14:56:35 +0800
Message-Id: <20220422065635.767648-3-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422065635.767648-1-zhengjun.xing@linux.intel.com>
References: <20220422065635.767648-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Since for cpu_core or cpu_atom , they have different topdown
events groups.

For cpu_core, --topdown equals to
"{slots,cpu_core/topdown-retiring/,cpu_core/topdown-bad-spec/,
  cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,
  cpu_core/topdown-heavy-ops/,cpu_core/topdown-br-mispredict/,
  cpu_core/topdown-fetch-lat/,cpu_core/topdown-mem-bound/}"

For cpu_atom, --topdown equals to
"{cpu_atom/topdown-retiring/,cpu_atom/topdown-bad-spec/,
 cpu_atom/topdown-fe-bound/,cpu_atom/topdown-be-bound/}"

To simplify the implementation, on hybrid, --topdown is used
together with --cputype. If without --cputype, it uses cpu_core
topdown events by default.

  # ./perf stat --topdown -a  sleep 1
  WARNING: default to use cpu_core topdown events

   Performance counter stats for 'system wide':

              retiring      bad speculation       frontend bound        backend bound     heavy operations     light operations    branch mispredict       machine clears        fetch latency      fetch bandwidth         memory bound           Core bound
                  4.1%                 0.0%                 5.1%                90.8%                 2.3%                 1.8%                 0.0%                 0.0%                 4.2%                 0.9%                 9.9%                81.0%

         1.002624229 seconds time elapsed

  # ./perf stat --topdown -a --cputype atom  sleep 1

   Performance counter stats for 'system wide':

              retiring      bad speculation       frontend bound        backend bound
                 13.5%                 0.1%                31.2%                55.2%

         1.002366987 seconds time elapsed

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c | 21 ++++++++++++++++++---
 tools/perf/util/stat.c    |  4 +++-
 tools/perf/util/topdown.c | 17 +++++++++++++----
 tools/perf/util/topdown.h |  3 ++-
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ea88ac5bed2d..084b0e53fb62 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1844,11 +1844,23 @@ static int add_default_attributes(void)
 		unsigned int max_level = 1;
 		char *str = NULL;
 		bool warn = false;
+		const char *pmu_name = "cpu";
 
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
+		if (perf_pmu__has_hybrid()) {
+			if (!evsel_list->hybrid_pmu_name) {
+				pr_warning("WARNING: default to use cpu_core topdown events\n");
+				evsel_list->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
+			}
+
+			pmu_name = evsel_list->hybrid_pmu_name;
+			if (!pmu_name)
+				return -1;
+		}
+
+		if (pmu_have_event(pmu_name, topdown_metric_L2_attrs[5])) {
 			metric_attrs = topdown_metric_L2_attrs;
 			max_level = 2;
 		}
@@ -1859,10 +1871,11 @@ static int add_default_attributes(void)
 		} else if (!stat_config.topdown_level)
 			stat_config.topdown_level = max_level;
 
-		if (topdown_filter_events(metric_attrs, &str, 1) < 0) {
+		if (topdown_filter_events(metric_attrs, &str, 1, pmu_name) < 0) {
 			pr_err("Out of memory\n");
 			return -1;
 		}
+
 		if (metric_attrs[0] && str) {
 			if (!stat_config.interval && !stat_config.metric_only) {
 				fprintf(stat_config.output,
@@ -1886,10 +1899,12 @@ static int add_default_attributes(void)
 		}
 
 		if (topdown_filter_events(topdown_attrs, &str,
-				arch_topdown_check_group(&warn)) < 0) {
+				arch_topdown_check_group(&warn),
+				pmu_name) < 0) {
 			pr_err("Out of memory\n");
 			return -1;
 		}
+
 		if (topdown_attrs[0] && str) {
 			struct parse_events_error errinfo;
 			if (warn)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 817a2de264b4..4a5f3b8ff820 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -117,7 +117,9 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
 	/* ps->id is 0 hence PERF_STAT_EVSEL_ID__NONE by default */
 
 	for (i = 0; i < PERF_STAT_EVSEL_ID__MAX; i++) {
-		if (!strcmp(evsel__name(evsel), id_str[i])) {
+		if (!strcmp(evsel__name(evsel), id_str[i]) ||
+		    (strstr(evsel__name(evsel), id_str[i]) && evsel->pmu_name
+		     && strstr(evsel__name(evsel), evsel->pmu_name))) {
 			ps->id = i;
 			break;
 		}
diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
index 1081b20f9891..a369f84ceb6a 100644
--- a/tools/perf/util/topdown.c
+++ b/tools/perf/util/topdown.c
@@ -1,18 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include "pmu.h"
+#include "pmu-hybrid.h"
 #include "topdown.h"
 
-int topdown_filter_events(const char **attr, char **str, bool use_group)
+int topdown_filter_events(const char **attr, char **str, bool use_group,
+			  const char *pmu_name)
 {
 	int off = 0;
 	int i;
 	int len = 0;
 	char *s;
+	bool is_hybrid = perf_pmu__is_hybrid(pmu_name);
 
 	for (i = 0; attr[i]; i++) {
-		if (pmu_have_event("cpu", attr[i])) {
-			len += strlen(attr[i]) + 1;
+		if (pmu_have_event(pmu_name, attr[i])) {
+			if (is_hybrid)
+				len += strlen(attr[i]) + strlen(pmu_name) + 3;
+			else
+				len += strlen(attr[i]) + 1;
 			attr[i - off] = attr[i];
 		} else
 			off++;
@@ -30,7 +36,10 @@ int topdown_filter_events(const char **attr, char **str, bool use_group)
 	if (use_group)
 		*s++ = '{';
 	for (i = 0; attr[i]; i++) {
-		strcpy(s, attr[i]);
+		if (!is_hybrid)
+			strcpy(s, attr[i]);
+		else
+			sprintf(s, "%s/%s/", pmu_name, attr[i]);
 		s += strlen(s);
 		*s++ = ',';
 	}
diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
index 2f0d0b887639..118e75281f93 100644
--- a/tools/perf/util/topdown.h
+++ b/tools/perf/util/topdown.h
@@ -7,6 +7,7 @@ bool arch_topdown_check_group(bool *warn);
 void arch_topdown_group_warn(void);
 bool arch_topdown_sample_read(struct evsel *leader);
 
-int topdown_filter_events(const char **attr, char **str, bool use_group);
+int topdown_filter_events(const char **attr, char **str, bool use_group,
+			  const char *pmu_name);
 
 #endif
-- 
2.25.1

