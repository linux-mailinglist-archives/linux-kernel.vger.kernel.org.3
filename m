Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3059D54AB91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiFNIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiFNIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:17:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E055A0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655194640; x=1686730640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4QG2XiVbJqz/xC9LjuotKkfae+D+n4VDh6QA+EdAYC0=;
  b=kr7teayzS0v+SIySHkca5n8/GyeVS6JD9pAXmdVZ/GMb65v3zl9VqWlA
   KHiNzph14H050iQXYq0RWCuQ56zq5ojjLXh5womc8N/we29i5PE6oEW4o
   m2Ig4FQwH2QbjTOTfsCGbWxKqBdlV1hTBhse1oQYY2/W+yDo7HSU/U1VX
   e93R4bkPhKjaXHTZJWztI2Ej4XcUCnGwfiNA1QHbRivzrjgAJK2OnXXoK
   gOVMWFIG8+yHBBRLs7uMhOh39Puzj4J0abdzkaqSnWbjRH8mmWOcAiyJ5
   UMkm7/kwtf4kRh0DHuSn80AwX1B4UPBk7rsYhKWTmzy3iaNe7cZEvKRBP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261579579"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261579579"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:17:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="830274985"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.153])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:17:16 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH -V3 3/3] memory tiering: adjust hot threshold automatically
Date:   Tue, 14 Jun 2022 16:16:35 +0800
Message-Id: <20220614081635.194014-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614081635.194014-1-ying.huang@intel.com>
References: <20220614081635.194014-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index bfa7452ca92e..6f9c7a4f647f 100644
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

