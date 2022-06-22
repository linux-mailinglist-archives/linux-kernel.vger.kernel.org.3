Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E7554892
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354378AbiFVIfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353931AbiFVIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:35:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB38938794
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655886938; x=1687422938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vUd05dvyBiM84Ezjr6E/K54uJBFgUb38qWnD0JwjrJs=;
  b=NsbpYgnxzc1XCmS+a0+VDAzb7olOMhtMKzmkbWy8XBkoicAS8tL+v7Mm
   chLSMzqeQyvxGcM+YGZkZLoPp2s4UoVvswjCyZdBvNjExkNhPM57S4ygu
   MVupDcrob/MDCZQN+NZk4HXPA1kG1JQPd/DxBJoJUPhuniuz79wnJImjK
   WG5Buloqrez7nJomYm26G45YMCxsYxBrPjryDIZ1IUORvopcIT84Ar+6M
   onSLkimF6bPzwEcOKhCyOvVQkb1zkjS7tcf/WfEzZava4XTz4zjjpZsLe
   fOJ14FWddCQdxSgpKO+SELx1hm/EK05JWjMgWZuTJu3ZoYrCiQgVssbXv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281429422"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281429422"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:35:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644076965"
Received: from lzha111-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.232])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:35:34 -0700
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
Subject: [PATCH -V4 2/3] memory tiering: rate limit NUMA migration throughput
Date:   Wed, 22 Jun 2022 16:35:18 +0800
Message-Id: <20220622083519.708236-3-ying.huang@intel.com>
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
 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++
 include/linux/mmzone.h                      |  7 +++++
 include/linux/sched/sysctl.h                |  1 +
 kernel/sched/fair.c                         | 33 +++++++++++++++++++--
 kernel/sysctl.c                             |  8 +++++
 mm/vmstat.c                                 |  1 +
 6 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ddccd1077462..c99bceafd162 100644
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
index aab70355d64f..994a0cd39595 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -221,6 +221,7 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
+	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
@@ -912,6 +913,12 @@ typedef struct pglist_data {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	/* start time in ms of current promote rate limit period */
+	unsigned int nbp_rl_start;
+	/* number of promote candidate pages at start time of current rate limit period */
+	unsigned long nbp_rl_nr_cand;
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
 	/*
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index e650946816d0..303ee7dd0c7e 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -27,6 +27,7 @@ enum sched_tunable_scaling {
 
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
+extern unsigned int sysctl_numa_balancing_promote_rate_limit;
 #else
 #define sysctl_numa_balancing_mode	0
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index edc3d741ef84..d779a91a8ca0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1073,6 +1073,9 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
 /* The page with hint page fault latency < threshold in ms is considered hot */
 unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
 
+/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
+unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -1477,6 +1480,29 @@ static int numa_hint_fault_latency(struct page *page)
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
+	unsigned long nr_cand;
+	unsigned int now, start;
+
+	now = jiffies_to_msecs(jiffies);
+	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
+	nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+	start = pgdat->nbp_rl_start;
+	if (now - start > MSEC_PER_SEC &&
+	    cmpxchg(&pgdat->nbp_rl_start, start, now) == start)
+		pgdat->nbp_rl_nr_cand = nr_cand;
+	if (nr_cand - pgdat->nbp_rl_nr_cand >= rate_limit)
+		return true;
+	return false;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1491,7 +1517,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long latency, th;
+		unsigned long rate_limit, latency, th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1502,7 +1528,10 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
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
index e52b6e372c60..3188698e2c8e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1597,6 +1597,14 @@ static struct ctl_table kern_table[] = {
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
 		.procname	= "panic",
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..068ca7d150ab 100644
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

