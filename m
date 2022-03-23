Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19484E4F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiCWJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCWJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:35:48 -0400
X-Greylist: delayed 2454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 02:34:17 PDT
Received: from SHSQR01.unisoc.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C36E7AE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:34:17 -0700 (PDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id 22N8rMe3044587
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:53:22 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 22N8qRiS042884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Wed, 23 Mar 2022 16:52:27 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 23 Mar 2022 16:52:27 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] cgroup: introduce usage expansion for memcg
Date:   Wed, 23 Mar 2022 16:52:07 +0800
Message-ID: <1648025527-30507-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 22N8qRiS042884
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Some kind of memcg want to keep the memory usage in a certain range of time and
let them free when time expired. So we introduce a kind of expanding methods to
expand the usage when calculate the memcg's protection.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/memcontrol.h | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            |  7 +++++
 mm/vmscan.c                |  4 +++
 3 files changed, 75 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403..3c7a2e4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -21,6 +21,8 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/clock.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -28,6 +30,11 @@
 struct mm_struct;
 struct kmem_cache;
 
+#define MEMCG_INTERVAL	(2*HZ+1)	/* 2 sec intervals */
+#define EXP_10s		1677		/* 1/exp(2s/10s) as fixed-point */
+#define EXP_60s		1981		/* 1/exp(2s/60s) */
+#define EXP_300s	2034		/* 1/exp(2s/300s) */
+
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
@@ -340,6 +347,12 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
+	u64 avg_next_update;
+	u64 avg_last_update;
+	u64 prot_period;
+	struct page_counter memory_latest;
+	bool allow_expand;
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -608,6 +621,57 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
+/*
+ * expand the usage via a linear proportion method
+ */
+static inline unsigned long calc_expanded_usage(struct mem_cgroup *group)
+{
+	u64 now, decay_factor;
+	u64 usage_expanded;
+	s64 growth, usage, last_usage;
+	u64 delta_time;
+
+	usage = page_counter_read(&group->memory);
+	last_usage = page_counter_read(&group->memory_latest);
+	growth = usage - last_usage;
+	usage_expanded = (unsigned long)usage;
+	now = sched_clock();
+
+	if (!usage || !group->avg_next_update) {
+		group->avg_next_update = now + group->prot_period;
+		return 0;
+	}
+
+	if (time_before((unsigned long)now, (unsigned long)group->avg_next_update))
+		return 0;
+
+	/*
+	 * skip the expansion if the usage is growing while expand the usage when
+	 * it remains stable or shrinking.
+	 * usage_exp = usage * (1 + delta_time / 34s), which is designed as
+	 * an effective way of linear calculation.
+	 */
+	if (growth > 0)
+		;
+	else {
+		delta_time = group->avg_last_update ? now - group->avg_last_update : 0;
+		/*
+		 * we take 2048 as "1" and 17s decay 1/2(34bit). then we can get
+		 * decay_factor = 1024 * delta_time / 17s(0x400000000)
+		 * 0.5/17s = decay_factor/delta_time ==> decay_factor = delta_time >> 24
+		 */
+		decay_factor = delta_time >> (34 - 10);
+		usage_expanded += usage * decay_factor / 2048;
+		/*
+		 * avg_next_update: expected expire time according to current status
+		 */
+		group->avg_last_update = now;
+		group->avg_next_update = now + jiffies_to_nsecs(2*HZ);
+	}
+	atomic_long_set(&group->memory_latest.usage, usage);
+	return usage_expanded;
+}
+
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 508bcea..0e7b5b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6616,6 +6616,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
+	unsigned long growth;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -6637,6 +6638,12 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	if (!usage)
 		return;
 
+	/*
+	 * expand the usage by the time if it is allowed
+	 */
+	if (memcg->allow_expand)
+		usage = calc_expanded_usage(memcg);
+
 	parent = parent_mem_cgroup(memcg);
 	/* No parent means a non-hierarchical mode on v1 memcg */
 	if (!parent)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ef4a6dc..ea56b5d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3101,8 +3101,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
 			 */
+			atomic_long_set(&memcg->memory_latest.usage,
+				page_counter_read(&memcg->memory));
 			continue;
 		} else if (mem_cgroup_below_low(memcg)) {
+			atomic_long_set(&memcg->memory_latest.usage,
+				page_counter_read(&memcg->memory));
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
-- 
1.9.1

