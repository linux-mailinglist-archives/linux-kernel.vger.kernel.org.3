Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86AD5548E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354540AbiFVIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354241AbiFVIfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:35:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D038BC0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655886943; x=1687422943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGU5qVYnZ44PhRhKnwGKDPYjJ6o5iYYEzvHLjp7lw+k=;
  b=FAlqO3dDRhYQcXLr9mlkNLgFmVKdZHAvHEn9rDK0CtCs75mG0Cmvflj5
   csKjgN6NzTeUWn9gPasHhazYjutKlX9MNc6N8MEC4D8dH/LfvLDuZm98K
   WOgKsYGgW6IwowiBCfmAdR8Htk1Hxr7VwgMbSRG08MUQn2PeB9iBddHm5
   cWzeKTPEtm6DpjzpfdQi1tK8+oJrNIIjQ978dLD7nvqr+IhZyn2qq4sp8
   lwLgv4j8JvcJOA07264Tp9hu9cw1hv+uXgzsG41NGlPHHtgS7jXiEbZUM
   v4GjOwP/jfNFCyq2L7fpLU6uFU/vQvDQG+RuVKUMSNbe2comXBmQF8YW3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281429444"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281429444"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:35:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644077005"
Received: from lzha111-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.232])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:35:38 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: [PATCH -V4 3/3] memory tiering: adjust hot threshold automatically
Date:   Wed, 22 Jun 2022 16:35:19 +0800
Message-Id: <20220622083519.708236-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622083519.708236-1-ying.huang@intel.com>
References: <20220622083519.708236-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
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
Cc: Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  9 +++++++++
 kernel/sched/core.c    | 14 +++++++++++++
 kernel/sched/fair.c    | 46 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 994a0cd39595..33d875d23e9a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -918,6 +918,15 @@ typedef struct pglist_data {
 	unsigned int nbp_rl_start;
 	/* number of promote candidate pages at start time of current rate limit period */
 	unsigned long nbp_rl_nr_cand;
+	/* promote threshold in ms */
+	unsigned int nbp_threshold;
+	/* start time in ms of current promote threshold adjustment period */
+	unsigned int nbp_th_start;
+	/*
+	 * number of promote candidate pages at stat time of current promote
+	 * threshold adjustment period
+	 */
+	unsigned long nbp_th_nr_cand;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..2183a368d4b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4361,6 +4361,17 @@ void set_numabalancing_state(bool enabled)
 }
 
 #ifdef CONFIG_PROC_SYSCTL
+static void reset_memory_tiering(void)
+{
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		pgdat->nbp_threshold = 0;
+		pgdat->nbp_th_nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		pgdat->nbp_th_start = jiffies_to_msecs(jiffies);
+	}
+}
+
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -4377,6 +4388,9 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
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
index d779a91a8ca0..cc5b26fefae8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1503,6 +1503,35 @@ static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
 	return false;
 }
 
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned int ref_th)
+{
+	unsigned int now, start, th_period, unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	now = jiffies_to_msecs(jiffies);
+	th_period = sysctl_numa_balancing_scan_period_max;
+	start = pgdat->nbp_th_start;
+	if (now - start > th_period &&
+	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
+		ref_cand = rate_limit *
+			sysctl_numa_balancing_scan_period_max / MSEC_PER_SEC;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
+		unit_th = ref_th * 2 / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->nbp_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th * 2);
+		pgdat->nbp_th_nr_cand = nr_cand;
+		pgdat->nbp_threshold = th;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1517,19 +1546,26 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
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
+			pgdat->nbp_threshold = 0;
 			return true;
+		}
+
+		def_th = sysctl_numa_balancing_hot_threshold;
+		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
+			(20 - PAGE_SHIFT);
+		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
 
-		th = sysctl_numa_balancing_hot_threshold;
+		th = pgdat->nbp_threshold ? : def_th;
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

