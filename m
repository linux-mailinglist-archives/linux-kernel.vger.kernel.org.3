Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F7450F856
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiDZJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242664AbiDZJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:20:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9163019E3E0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650963259; x=1682499259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUvHGyL+iPQ/PKJq4+PZobhNrtZk5Rv7uaOQB5P06AU=;
  b=D6M0uUjEbtU5TCG82CdgMCU4BQQmvpg3Uu/bfxIDk+UGXmkMDyydHqeS
   4/nW5DToqLg+e3tobiRA2MUDjiNpZIACf6wSgk1a1U3kHDGxaNRbAeK9G
   dHs6mBE6MCdbqbsdY25KAf9fNIJ2r5XXfULQ45/43/mHSKGMar3eeTtE/
   vwo+U9dtD5DOTzYeJuyb30psDdqymLTAzq6aa4w/r/9Q9/YketFskbAE8
   Vt1R4T02VEt6SZH+L076L4T3Gnwa7YxZBP2B6J1FAzdSqLairbp8wJs67
   gkEgRAu3J1F948uKfjxRh/6Sh2Xl/MtJHPChWognl6S/jWLk3f9lus5p1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325993689"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="325993689"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:52:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579775965"
Received: from yyu16-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:52:38 -0700
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
Subject: [PATCH -V2 2/3] memory tiering: rate limit NUMA migration throughput
Date:   Tue, 26 Apr 2022 16:51:04 +0800
Message-Id: <20220426085105.60822-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426085105.60822-1-ying.huang@intel.com>
References: <20220426085105.60822-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In NUMA balancing memory tiering mode, if there are hot pages in slow
memory node and cold pages in fast memory node, we need to
promote/demote hot/cold pages between the fast and cold memory nodes.

A choice is to promote/demote as fast as possible.  But the CPU cycles
and memory bandwidth consumed by the high promoting/demoting
throughput will hurt the latency of some workload because of accessing
inflating and slow memory bandwidth contention.

A way to resolve this issue is to restrict the max promoting/demoting
throughput.  It will take longer to finish the promoting/demoting.
But the workload latency will be better.  This is implemented in this
patch as the page promotion rate limit mechanism.

The number of the candidate pages to be promoted to the fast memory
node via NUMA balancing is counted, if the count exceeds the limit
specified by the users, the NUMA balancing promotion will be stopped
until the next second.

A new sysctl knob kernel.numa_balancing_promote_rate_limit_MBps is
added for the users to specify the limit.

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
 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++
 include/linux/mmzone.h                      |  6 ++++
 include/linux/sched/sysctl.h                |  1 +
 kernel/sched/fair.c                         | 33 +++++++++++++++++++--
 kernel/sysctl.c                             |  8 +++++
 mm/vmstat.c                                 |  1 +
 6 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1144ea3229a3..4a8d50bbdeb1 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -623,6 +623,17 @@ different types of memory (represented as different NUMA nodes) to
 place the hot pages in the fast memory.  This is implemented based on
 unmapping and page fault too.
 
+numa_balancing_promote_rate_limit_MBps
+======================================
+
+Too high promotion/demotion throughput between different memory types
+may hurt application latency.  This can be used to rate limit the
+promotion throughput.  The per-node max promotion throughput in MB/s
+will be limited to be no more than the set value.
+
+A rule of thumb is to set this to less than 1/10 of the PMEM node
+write bandwidth.
+
 oops_all_cpu_backtrace
 ======================
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 46ffab808f03..f2887b1c9b0b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -224,6 +224,7 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
+	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
@@ -915,6 +916,11 @@ typedef struct pglist_data {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned long numa_nr_candidate; /* number of promote candidate pages at
+					  * rate limit start time */
+	unsigned int numa_ts;		 /* promote rate limit start time in ms */
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
 	/*
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c1076b5e17fb..6fb0cf24841c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -29,6 +29,7 @@ enum sched_tunable_scaling {
 
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
+extern unsigned int sysctl_numa_balancing_promote_rate_limit;
 #else
 #define sysctl_numa_balancing_mode	0
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9d1bbfb140f1..2975c1cbdb60 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1061,6 +1061,9 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
 /* The page with hint page fault latency < threshold in ms is considered hot */
 unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
 
+/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
+unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1465,6 +1468,29 @@ static int numa_hint_fault_latency(struct page *page)
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
 
+/*
+ * For memory tiering mode, too high promotion/demotion throughput may
+ * hurt application latency.  So we provide a mechanism to rate limit
+ * the number of pages that are tried to be promoted.
+ */
+static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
+				      unsigned long rate_limit, int nr)
+{
+	unsigned long nr_candidate;
+	unsigned int now, last_ts;
+
+	now = jiffies_to_msecs(jiffies);
+	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
+	nr_candidate = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+	last_ts = pgdat->numa_ts;
+	if (now - last_ts > MSEC_PER_SEC &&
+	    cmpxchg(&pgdat->numa_ts, last_ts, now) == last_ts)
+		pgdat->numa_nr_candidate = nr_candidate;
+	if (nr_candidate - pgdat->numa_nr_candidate >= rate_limit)
+		return true;
+	return false;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1479,7 +1505,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long latency, th;
+		unsigned long rate_limit, latency, th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1490,7 +1516,10 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		if (latency >= th)
 			return false;
 
-		return true;
+		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
+			(20 - PAGE_SHIFT);
+		return !numa_promotion_rate_limit(pgdat, rate_limit,
+						  thp_nr_pages(page));
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 830aaf8ca08e..7247aa777ef8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1698,6 +1698,14 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_FOUR,
 	},
+	{
+		.procname	= "numa_balancing_promote_rate_limit_MBps",
+		.data		= &sysctl_numa_balancing_promote_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 #endif /* CONFIG_NUMA_BALANCING */
 	{
 		.procname	= "sched_rt_period_us",
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b75b1a64b54c..bbaf732df925 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1245,6 +1245,7 @@ const char * const vmstat_text[] = {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
+	"pgpromote_candidate",
 #endif
 
 	/* enum writeback_stat_item counters */
-- 
2.30.2

