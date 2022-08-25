Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2E5A0709
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiHYB7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiHYB7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:59:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A098A1A69;
        Wed, 24 Aug 2022 18:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661392413; x=1692928413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VttP1yp8X9Ug0VCfHCUVuG0as2qXu0pUjMbvlRMIt3o=;
  b=DJl+9rWK6Pwe6svs9V+hlZmOXngCmusmf+cEauI+KnFG/4U20WAsisXb
   /ZUb/4wrEgP3nptg+R0oW9qpQ5CvZDp0BBDvHo+T0P94gBQu4BV8EZb0z
   6PMgYEz9H4POMz/4d0xAh+TesrS78iiRqlKbmKFXlJF3QcbzkJXnsc01m
   7RvfBo6/tQL/M8zQbU+XD9PklT+BhL/oJpf6BcZJmbZemR2C7pxnkLKcT
   LT/2RRPjKfMpo7DOzeZDxa5UzHZzEiaSOQ73G2jD66H+XP9NO7WTkscdz
   /6lo+77Ll2dMY1gN94LwGimVt+fC7gLJvBrM0YH4hGuBAOjdPLcnPEnoH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="295399518"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="295399518"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 18:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="639378795"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2022 18:53:30 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH] perf stat: Capitalize topdown metrics' names
Date:   Thu, 25 Aug 2022 09:54:58 +0800
Message-Id: <20220825015458.3252239-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Capitalize topdown metrics' names to follow the intel SDM.

Before:

 # ./perf stat -a  sleep 1

 Performance counter stats for 'system wide':

        228,094.05 msec cpu-clock                        #  225.026 CPUs utilized
               842      context-switches                 #    3.691 /sec
               224      cpu-migrations                   #    0.982 /sec
                70      page-faults                      #    0.307 /sec
        23,164,105      cycles                           #    0.000 GHz
        29,403,446      instructions                     #    1.27  insn per cycle
         5,268,185      branches                         #   23.097 K/sec
            33,239      branch-misses                    #    0.63% of all branches
       136,248,990      slots                            #  597.337 K/sec
        32,976,450      topdown-retiring                 #     24.2% retiring
         4,651,918      topdown-bad-spec                 #      3.4% bad speculation
        26,148,695      topdown-fe-bound                 #     19.2% frontend bound
        72,515,776      topdown-be-bound                 #     53.2% backend bound
         6,008,540      topdown-heavy-ops                #      4.4% heavy operations       #     19.8% light operations
         3,934,049      topdown-br-mispredict            #      2.9% branch mispredict      #      0.5% machine clears
        16,655,439      topdown-fetch-lat                #     12.2% fetch latency          #      7.0% fetch bandwidth
        41,635,972      topdown-mem-bound                #     30.5% memory bound           #     22.7% Core bound

       1.013634593 seconds time elapsed

After:

 # ./perf stat -a  sleep 1

 Performance counter stats for 'system wide':

        228,081.94 msec cpu-clock                        #  225.003 CPUs utilized
               824      context-switches                 #    3.613 /sec
               224      cpu-migrations                   #    0.982 /sec
                67      page-faults                      #    0.294 /sec
        22,647,423      cycles                           #    0.000 GHz
        28,870,551      instructions                     #    1.27  insn per cycle
         5,167,099      branches                         #   22.655 K/sec
            32,383      branch-misses                    #    0.63% of all branches
       133,411,074      slots                            #  584.926 K/sec
        32,352,607      topdown-retiring                 #     24.3% Retiring
         4,456,977      topdown-bad-spec                 #      3.3% Bad Speculation
        25,626,487      topdown-fe-bound                 #     19.2% Frontend Bound
        70,955,316      topdown-be-bound                 #     53.2% Backend Bound
         5,834,844      topdown-heavy-ops                #      4.4% Heavy Operations       #     19.9% Light Operations
         3,738,781      topdown-br-mispredict            #      2.8% Branch Mispredict      #      0.5% Machine Clears
        16,286,803      topdown-fetch-lat                #     12.2% Fetch Latency          #      7.0% Fetch Bandwidth
        40,802,069      topdown-mem-bound                #     30.6% Memory Bound           #     22.6% Core Bound

       1.013683125 seconds time elapsed

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/stat-shadow.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 979c8cb918f7..788ce5e46470 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -1193,7 +1193,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 						  &rsd);
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
-		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
+		print_metric(config, ctxp, color, "%8.1f%%", "Retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
 		   full_td(cpu_map_idx, st, &rsd)) {
@@ -1202,7 +1202,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 						  &rsd);
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
+		print_metric(config, ctxp, color, "%8.1f%%", "Frontend Bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
 		   full_td(cpu_map_idx, st, &rsd)) {
@@ -1211,7 +1211,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 						  &rsd);
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
+		print_metric(config, ctxp, color, "%8.1f%%", "Backend Bound",
 				be_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
 		   full_td(cpu_map_idx, st, &rsd)) {
@@ -1220,7 +1220,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 						  &rsd);
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
+		print_metric(config, ctxp, color, "%8.1f%%", "Bad Speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_HEAVY_OPS) &&
 			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
@@ -1234,13 +1234,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (retiring > 0.7 && heavy_ops > 0.1)
 			color = PERF_COLOR_GREEN;
-		print_metric(config, ctxp, color, "%8.1f%%", "heavy operations",
+		print_metric(config, ctxp, color, "%8.1f%%", "Heavy Operations",
 				heavy_ops * 100.);
 		if (retiring > 0.7 && light_ops > 0.6)
 			color = PERF_COLOR_GREEN;
 		else
 			color = NULL;
-		print_metric(config, ctxp, color, "%8.1f%%", "light operations",
+		print_metric(config, ctxp, color, "%8.1f%%", "Light Operations",
 				light_ops * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BR_MISPREDICT) &&
 			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
@@ -1254,13 +1254,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (bad_spec > 0.1 && br_mis > 0.05)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "branch mispredict",
+		print_metric(config, ctxp, color, "%8.1f%%", "Branch Mispredict",
 				br_mis * 100.);
 		if (bad_spec > 0.1 && m_clears > 0.05)
 			color = PERF_COLOR_RED;
 		else
 			color = NULL;
-		print_metric(config, ctxp, color, "%8.1f%%", "machine clears",
+		print_metric(config, ctxp, color, "%8.1f%%", "Machine Clears",
 				m_clears * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_LAT) &&
 			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
@@ -1274,13 +1274,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (fe_bound > 0.2 && fetch_lat > 0.15)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "fetch latency",
+		print_metric(config, ctxp, color, "%8.1f%%", "Fetch Latency",
 				fetch_lat * 100.);
 		if (fe_bound > 0.2 && fetch_bw > 0.1)
 			color = PERF_COLOR_RED;
 		else
 			color = NULL;
-		print_metric(config, ctxp, color, "%8.1f%%", "fetch bandwidth",
+		print_metric(config, ctxp, color, "%8.1f%%", "Fetch Bandwidth",
 				fetch_bw * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_MEM_BOUND) &&
 			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
@@ -1294,13 +1294,13 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (be_bound > 0.2 && mem_bound > 0.2)
 			color = PERF_COLOR_RED;
-		print_metric(config, ctxp, color, "%8.1f%%", "memory bound",
+		print_metric(config, ctxp, color, "%8.1f%%", "Memory Bound",
 				mem_bound * 100.);
 		if (be_bound > 0.2 && core_bound > 0.1)
 			color = PERF_COLOR_RED;
 		else
 			color = NULL;
-		print_metric(config, ctxp, color, "%8.1f%%", "Core bound",
+		print_metric(config, ctxp, color, "%8.1f%%", "Core Bound",
 				core_bound * 100.);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
-- 
2.25.1

