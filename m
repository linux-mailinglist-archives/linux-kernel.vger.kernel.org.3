Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2342050F76D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiDZJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346811AbiDZJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:18:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F2019ADBE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650963241; x=1682499241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zi5acPYW8kItYABL06yrdnT8ZAOgTg+ybOskYR3O5U0=;
  b=g/tLjL6J1MCJAFv4b0lilf/fVYoq899sF8DzgnBenqnr7IBVyIHnTVbw
   4DXMoNmxa/Rb0cTSlOEDuEfNyfh1oDAwZnBauLhxjH4SGVwaVpKxdk0aK
   RlXGDwmwqCKxCypYWlnisnxoxFIKd+Hf9EdJwmhP0FyOwMGTPUpig+CMW
   uiEjWHM00IurHMsaoQT4LplmoD1nk3Hn7ziDvTboHKy5GlPGWHY3GM9VO
   aumqsGJeRG+Fk1asbY3rzq0EyiucUrDia5nFgPtR3QxoKJO7aUmafgzvv
   IVbCfLEbkcYjq7TBsvaoDwA6Q35NDqE8GbwVJ/fzx5uSKEG45LoEJqM57
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247437758"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="247437758"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:52:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579776078"
Received: from yyu16-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:52:46 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH -V2 3/3] memory tiering: adjust hot threshold automatically
Date:   Tue, 26 Apr 2022 16:51:05 +0800
Message-Id: <20220426085105.60822-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426085105.60822-1-ying.huang@intel.com>
References: <20220426085105.60822-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The promotion hot threshold is workload and system configuration
dependent.  So in this patch, a method to adjust the hot threshold
automatically is implemented.  The basic idea is to control the number
of the candidate promotion pages to match the promotion rate limit.
If the hint page fault latency of a page is less than the hot
threshold, we will try to promote the page, and the page is called the
candidate promotion page.

If the number of the candidate promotion pages in the statistics
interval is much more than the promotion rate limit, the hot threshold
will be decreased to reduce the number of the candidate promotion
pages.  Otherwise, the hot threshold will be increased to increase the
number of the candidate promotion pages.

To make the above method works, in each statistics interval, the total
number of the pages to check (on which the hint page faults occur) and
the hot/cold distribution need to be stable.  Because the page tables
are scanned linearly in NUMA balancing, but the hot/cold distribution
isn't uniform along the address usually, the statistics interval
should be larger than the NUMA balancing scan period.  So in the
patch, the max scan period is used as statistics interval and it works
well in our tests.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  5 +++++
 kernel/sched/core.c    | 15 ++++++++++++++
 kernel/sched/fair.c    | 46 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f2887b1c9b0b..d542b03b9d5c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -920,6 +920,11 @@ typedef struct pglist_data {
 	unsigned long numa_nr_candidate; /* number of promote candidate pages at
 					  * rate limit start time */
 	unsigned int numa_ts;		 /* promote rate limit start time in ms */
+	/* promote threshold adjusting start time in ms */
+	unsigned int numa_threshold_ts;
+	unsigned int numa_threshold;	 /* promote threshold in ms */
+	/* number of promote candidate pages at numa_threshold_ts */
+	unsigned long numa_threshold_nr_candidate;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..671eef0c6a21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4364,6 +4364,18 @@ void set_numabalancing_state(bool enabled)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
+static void reset_memory_tiering(void)
+{
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		pgdat->numa_threshold = 0;
+		pgdat->numa_threshold_nr_candidate =
+			node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		pgdat->numa_threshold_ts = jiffies_to_msecs(jiffies);
+	}
+}
+
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -4380,6 +4392,9 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
 	if (err < 0)
 		return err;
 	if (write) {
+		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+		    (state & NUMA_BALANCING_MEMORY_TIERING))
+			reset_memory_tiering();
 		sysctl_numa_balancing_mode = state;
 		__set_numabalancing_state(state);
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2975c1cbdb60..e8ba1e977708 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1491,6 +1491,35 @@ static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
 	return false;
 }
 
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned int ref_th)
+{
+	unsigned int now, last_th_ts, th_period, unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	now = jiffies_to_msecs(jiffies);
+	th_period = sysctl_numa_balancing_scan_period_max;
+	last_th_ts = pgdat->numa_threshold_ts;
+	if (now - last_th_ts > th_period &&
+	    cmpxchg(&pgdat->numa_threshold_ts, last_th_ts, now) == last_th_ts) {
+		ref_cand = rate_limit *
+			sysctl_numa_balancing_scan_period_max / MSEC_PER_SEC;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->numa_threshold_nr_candidate;
+		unit_th = ref_th * 2 / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->numa_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th * 2);
+		pgdat->numa_threshold_nr_candidate = nr_cand;
+		pgdat->numa_threshold = th;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1505,19 +1534,26 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit, latency, th;
+		unsigned long rate_limit;
+		unsigned int latency, th, def_th;
 
 		pgdat = NODE_DATA(dst_nid);
-		if (pgdat_free_space_enough(pgdat))
+		if (pgdat_free_space_enough(pgdat)) {
+			/* workload changed, reset hot threshold */
+			pgdat->numa_threshold = 0;
 			return true;
+		}
+
+		def_th = sysctl_numa_balancing_hot_threshold;
+		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
+			(20 - PAGE_SHIFT);
+		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
 
-		th = sysctl_numa_balancing_hot_threshold;
+		th = pgdat->numa_threshold ? : def_th;
 		latency = numa_hint_fault_latency(page);
 		if (latency >= th)
 			return false;
 
-		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
-			(20 - PAGE_SHIFT);
 		return !numa_promotion_rate_limit(pgdat, rate_limit,
 						  thp_nr_pages(page));
 	}
-- 
2.30.2

