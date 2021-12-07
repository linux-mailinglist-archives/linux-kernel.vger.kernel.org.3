Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC846B098
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbhLGCc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:32:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:8199 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243409AbhLGCcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:32:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237700782"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237700782"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:28:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="502397403"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:28:51 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Subject: [PATCH -V10 RESEND 5/6] memory tiering: rate limit NUMA migration throughput
Date:   Tue,  7 Dec 2021 10:27:56 +0800
Message-Id: <20211207022757.2523359-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207022757.2523359-1-ying.huang@intel.com>
References: <20211207022757.2523359-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In NUMA balancing memory tiering mode, the hot slow memory pages could
be promoted to the fast memory node via NUMA balancing.  But this
incurs some overhead too.  So that sometimes the workload performance
may be hurt.  To avoid too much disturbing to the workload in these
situations, we should make it possible to rate limit the promotion
throughput.

So, in this patch, we implement a simple rate limit algorithm as
follows.  The number of the candidate pages to be promoted to the fast
memory node via NUMA balancing is counted, if the count exceeds the
limit specified by the users, the NUMA balancing promotion will be
stopped until the next second.

A new sysctl knob kernel.numa_balancing_rate_limit_mbps is added for
the users to specify the limit.

TODO: Add ABI document for new sysctl knob.

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
Cc: Hasan Al Maruf <hasanalmaruf@fb.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h       |  5 +++++
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/fair.c          | 29 +++++++++++++++++++++++++++--
 kernel/sysctl.c              |  8 ++++++++
 mm/vmstat.c                  |  1 +
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index eda6d2f09d77..f3b044993bc5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -213,6 +213,7 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
+	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
 	NR_VM_NODE_STAT_ITEMS
 };
@@ -902,6 +903,10 @@ typedef struct pglist_data {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+	unsigned long numa_ts;
+	unsigned long numa_nr_candidate;
+#endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
 	/*
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 0ea43b146aee..7d937adaac0f 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -42,6 +42,7 @@ enum sched_tunable_scaling {
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
+extern unsigned int sysctl_numa_balancing_rate_limit;
 #else
 #define sysctl_numa_balancing_mode	0
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b78664a5ce2..7912669a2065 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1028,6 +1028,11 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
 /* The page with hint page fault latency < threshold in ms is considered hot */
 unsigned int sysctl_numa_balancing_hot_threshold = 1000;
+/*
+ * Restrict the NUMA migration per second in MB for each target node
+ * if no enough free space in target node
+ */
+unsigned int sysctl_numa_balancing_rate_limit = 65536;
 
 struct numa_group {
 	refcount_t refcount;
@@ -1401,6 +1406,23 @@ static int numa_hint_fault_latency(struct page *page)
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
 
+static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
+					    unsigned long rate_limit, int nr)
+{
+	unsigned long nr_candidate;
+	unsigned long now = jiffies, last_ts;
+
+	mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
+	nr_candidate = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+	last_ts = pgdat->numa_ts;
+	if (now > last_ts + HZ &&
+	    cmpxchg(&pgdat->numa_ts, last_ts, now) == last_ts)
+		pgdat->numa_nr_candidate = nr_candidate;
+	if (nr_candidate - pgdat->numa_nr_candidate > rate_limit)
+		return false;
+	return true;
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1415,7 +1437,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long latency, th;
+		unsigned long rate_limit, latency, th;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat))
@@ -1426,7 +1448,10 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		if (latency > th)
 			return false;
 
-		return true;
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		return numa_migration_check_rate_limit(pgdat, rate_limit,
+						       thp_nr_pages(page));
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 40432524642a..7be964eb0d13 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1818,6 +1818,14 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "numa_balancing_rate_limit_mbps",
+		.data		= &sysctl_numa_balancing_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
 #endif /* CONFIG_NUMA_BALANCING */
 	{
 		.procname	= "sched_rt_period_us",
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 53a6e92b1efb..787a012de3e2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1244,6 +1244,7 @@ const char * const vmstat_text[] = {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
+	"pgpromote_candidate",
 #endif
 
 	/* enum writeback_stat_item counters */
-- 
2.30.2

