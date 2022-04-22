Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72F50B0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444596AbiDVHAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444592AbiDVG76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:59:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F050B0F;
        Thu, 21 Apr 2022 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650610626; x=1682146626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXFbwxz87qlM883YuYAWF64Fqso0Pit6aDGqdGNhaRU=;
  b=Cw0PWY6WPHTxTczrIFAH7ElTsTjdVzZSUjEXI6YIIQrvY3jYuMLcIt4X
   cWt7HtrdW/N9oLsw3bGsIRHz/v2GIzF1UyNqNG7oylqQrzm9e/aBJvd3E
   /l2LXDqGYybn5A9DkNtMRc1L9q/FSR/Yz1HQ2UQcJ741kP7/0HEVoLlGN
   YDq9wdXYmuvkq2VCGt8oknG8ZxzAWWQdOe0SOhrPRV1VnkYo23p3j0Cq3
   yw3PqNpJsJqhgbkxVOu0+IZv535PcTbfjKgsmid+HSUdeD/NdlH3dA+K+
   lktJCD0hgaWeLDpkCH+9af7cJV0+hcdWbehEIyXX01Wuy96y/hPEB320S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327508177"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="327508177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="703427902"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 23:57:02 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 2/3] perf stat: Merge event counts from all hybrid PMUs
Date:   Fri, 22 Apr 2022 14:56:34 +0800
Message-Id: <20220422065635.767648-2-zhengjun.xing@linux.intel.com>
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

For hybrid events, by default stat aggregates and reports the event counts
per pmu.

  # ./perf stat -e cycles -a  sleep 1

   Performance counter stats for 'system wide':

      14,066,877,268      cpu_core/cycles/
       6,814,443,147      cpu_atom/cycles/

         1.002760625 seconds time elapsed

Sometimes, it's also useful to aggregate event counts from all PMUs.
Create a new option '--hybrid-merge' to enable that behavior and report
the counts without PMUs.

  # ./perf stat -e cycles -a --hybrid-merge  sleep 1

   Performance counter stats for 'system wide':

      20,732,982,512      cycles

         1.002776793 seconds time elapsed

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 10 ++++++++++
 tools/perf/builtin-stat.c              |  2 ++
 tools/perf/util/stat-display.c         | 17 +++++++++++++++--
 tools/perf/util/stat.h                 |  1 +
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index c06c341e72b9..8d1cde00b8d6 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -454,6 +454,16 @@ Multiple events are created from a single event specification when:
 2. Aliases, which are listed immediately after the Kernel PMU events
    by perf list, are used.
 
+--hybrid-merge::
+Merge the hybrid event counts from all PMUs.
+
+For hybrid events, by default, the stat aggregates and reports the event
+counts per PMU. But sometimes, it's also useful to aggregate event counts
+from all PMUs. This option enables that behavior and reports the counts
+without PMUs.
+
+For non-hybrid events, it should be no effect.
+
 --smi-cost::
 Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..ea88ac5bed2d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1235,6 +1235,8 @@ static struct option stat_options[] = {
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
 		    "disable CPU count aggregation", AGGR_NONE),
 	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
+	OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
+		    "Merge identical named hybrid events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 46b3dd134656..d9629a83aa78 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -612,6 +612,19 @@ static bool hybrid_uniquify(struct evsel *evsel)
 	return perf_pmu__has_hybrid() && !is_uncore(evsel);
 }
 
+static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
+			 bool check)
+{
+	if (hybrid_uniquify(counter)) {
+		if (check)
+			return config && config->hybrid_merge;
+		else
+			return config && !config->hybrid_merge;
+	}
+
+	return false;
+}
+
 static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
 				       bool first),
@@ -620,9 +633,9 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
 	if (counter->merged_stat)
 		return false;
 	cb(config, counter, data, true);
-	if (config->no_merge || hybrid_uniquify(counter))
+	if (config->no_merge || hybrid_merge(counter, config, false))
 		uniquify_event_name(counter, config);
-	else if (counter->auto_merge_stats)
+	else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
 		collect_all_aliases(config, counter, cb, data);
 	return true;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 335d19cc3063..91d989dfeca4 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -122,6 +122,7 @@ struct perf_stat_config {
 	bool			 ru_display;
 	bool			 big_num;
 	bool			 no_merge;
+	bool			 hybrid_merge;
 	bool			 walltime_run_table;
 	bool			 all_kernel;
 	bool			 all_user;
-- 
2.25.1

