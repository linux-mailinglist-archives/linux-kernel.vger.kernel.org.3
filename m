Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ABD46B099
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbhLGCcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:32:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:8199 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242662AbhLGCca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:32:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237700804"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="237700804"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:29:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="502397448"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.50])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 18:28:56 -0800
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
Subject: [PATCH -V10 RESEND 6/6] memory tiering: adjust hot threshold automatically
Date:   Tue,  7 Dec 2021 10:27:57 +0800
Message-Id: <20211207022757.2523359-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211207022757.2523359-1-ying.huang@intel.com>
References: <20211207022757.2523359-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't easy for the administrator to determine the hot threshold.
So in this patch, a method to adjust the hot threshold automatically
is implemented.  The basic idea is to control the number of the
candidate promotion pages to match the promotion rate limit.  If the
hint page fault latency of a page is less than the hot threshold, we
will try to promote the page, and the page is called the candidate
promotion page.

If the number of the candidate promotion pages in the statistics
interval is much more than the promotion rate limit, the hot threshold
will be decreased to reduce the number of the candidate promotion
pages.  Otherwise, the hot threshold will be increased to increase the
number of the candidate promotion pages.

To make the above method works, in each statistics interval, the total
number of the pages to check (on which the hint page faults occur) and
the hot/cold distribution need to be stable.  Because the page tables
are scanned linearly in NUMA balancing, but the hot/cold distribution
isn't uniform along the address, the statistics interval should be
larger than the NUMA balancing scan period.  So in the patch, the max
scan period is used as statistics interval and it works well in our
tests.

The sysctl knob kernel.numa_balancing_hot_threshold_ms becomes the
initial value and max value of the hot threshold.

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
 include/linux/mmzone.h       |  3 ++
 include/linux/sched/sysctl.h |  2 ++
 kernel/sched/core.c          | 15 +++++++++
 kernel/sched/fair.c          | 64 +++++++++++++++++++++++++++++++++---
 kernel/sysctl.c              |  3 +-
 5 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f3b044993bc5..4ac0ae1cf15d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -906,6 +906,9 @@ typedef struct pglist_data {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long numa_ts;
 	unsigned long numa_nr_candidate;
+	unsigned long numa_threshold_ts;
+	unsigned long numa_threshold_nr_candidate;
+	unsigned long numa_threshold;
 #endif
 	/* Fields commonly accessed by the page reclaim scanner */
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 7d937adaac0f..ff2c43e8ebac 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -84,6 +84,8 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+int sysctl_numa_balancing_threshold(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5dcabc98432f..1cca2c8a3423 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4285,6 +4285,18 @@ void set_numabalancing_state(bool enabled)
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
+		pgdat->numa_threshold_ts = jiffies;
+	}
+}
+
 int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -4301,6 +4313,9 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
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
index 7912669a2065..daa978d2d70d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1423,6 +1423,54 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
 	return true;
 }
 
+int sysctl_numa_balancing_threshold(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	int err;
+	struct pglist_data *pgdat;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	err = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (err < 0 || !write)
+		return err;
+
+	for_each_online_pgdat(pgdat)
+		pgdat->numa_threshold = 0;
+
+	return err;
+}
+
+#define NUMA_MIGRATION_ADJUST_STEPS	16
+
+static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
+					    unsigned long rate_limit,
+					    unsigned long ref_th)
+{
+	unsigned long now = jiffies, last_th_ts, th_period;
+	unsigned long unit_th, th;
+	unsigned long nr_cand, ref_cand, diff_cand;
+
+	th_period = msecs_to_jiffies(sysctl_numa_balancing_scan_period_max);
+	last_th_ts = pgdat->numa_threshold_ts;
+	if (now > last_th_ts + th_period &&
+	    cmpxchg(&pgdat->numa_threshold_ts, last_th_ts, now) == last_th_ts) {
+		ref_cand = rate_limit *
+			sysctl_numa_balancing_scan_period_max / 1000;
+		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
+		diff_cand = nr_cand - pgdat->numa_threshold_nr_candidate;
+		unit_th = ref_th / NUMA_MIGRATION_ADJUST_STEPS;
+		th = pgdat->numa_threshold ? : ref_th;
+		if (diff_cand > ref_cand * 11 / 10)
+			th = max(th - unit_th, unit_th);
+		else if (diff_cand < ref_cand * 9 / 10)
+			th = min(th + unit_th, ref_th);
+		pgdat->numa_threshold_nr_candidate = nr_cand;
+		pgdat->numa_threshold = th;
+	}
+}
+
 bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 				int src_nid, int dst_cpu)
 {
@@ -1437,19 +1485,25 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
-		unsigned long rate_limit, latency, th;
+		unsigned long rate_limit, latency, th, def_th;
 
 		pgdat = NODE_DATA(dst_nid);
-		if (pgdat_free_space_enough(pgdat))
+		if (pgdat_free_space_enough(pgdat)) {
+			/* workload changed, reset hot threshold */
+			pgdat->numa_threshold = 0;
 			return true;
+		}
 
-		th = sysctl_numa_balancing_hot_threshold;
+		def_th = sysctl_numa_balancing_hot_threshold;
+		rate_limit =
+			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
+		numa_migration_adjust_threshold(pgdat, rate_limit, def_th);
+
+		th = pgdat->numa_threshold ? : def_th;
 		latency = numa_hint_fault_latency(page);
 		if (latency > th)
 			return false;
 
-		rate_limit =
-			sysctl_numa_balancing_rate_limit << (20 - PAGE_SHIFT);
 		return numa_migration_check_rate_limit(pgdat, rate_limit,
 						       thp_nr_pages(page));
 	}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7be964eb0d13..38892422ffac 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1816,7 +1816,8 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_numa_balancing_hot_threshold,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= sysctl_numa_balancing_threshold,
+		.extra1		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "numa_balancing_rate_limit_mbps",
-- 
2.30.2

