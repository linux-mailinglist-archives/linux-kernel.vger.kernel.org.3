Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B64ED520
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiCaIEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiCaIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:04:42 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3C14924B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:02:52 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 22V81Fcs034261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 31 Mar 2022 16:01:15 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 31 Mar 2022 16:01:15 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <ke.wang@unisoc.com>
Subject: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Date:   Thu, 31 Mar 2022 16:00:56 +0800
Message-ID: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 22V81Fcs034261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

For some kind of memcg, the usage is varies greatly from scenarios. Such as
multimedia app could have the usage range from 50MB to 500MB, which generated
by loading an special algorithm into its virtual address space and make it hard
to protect the expanded usage without userspace's interaction. Furthermore, fixed
memory.low is a little bit against its role of soft protection as it will response
any system's memory pressure in same way.

Taking all above into consideration, we introduce a kind of dynamic protection
based on group's watermark and system's memory pressure in this patch. Our aims are:
1. dynamic protection with no fixed setting
2. proper protection value on memory.current
3. time based decay protection
4. memory pressue related protection

The basic concept could be descripted as bellowing, where we take group->watermark
as a representative of usage
		group->memory.low = decayed_watermark * decay_factor
		decayed_watermark = group->watermark * func_wm_decay(time)
		decay_factor = psi_system[PSI_MEM][time]

func_wm_decay could be deemed as a linear decay funcion that will decay 1/2 in
68s(36bit).If we take 2048 as "1", it could be descripted as:
		decayed_watermark = time >> (group->wm_dec_factor - 10)
		decayed_watermark = new_usage(if new_usage > decayed_watermark)

decay_factor is as simple as a table lookingup and compose the final value by
weight of some and full as
		some = psi_system.avg[PSI_MEM * 2][time]
		full = psi_system.avg[PSI_MEM * 2 + 1][time]
		decay_factor = some * 70% + full *30%

We simply test above change on a v5.4 based system in bellowing topology and
observe some behavious as we expected:
      A
     / \
    B   C
1. With regard to the protection, elow is in a proper range as proportion of watermark.
2. Elapsed time has positive impact on elow via decayed_watermark.
3. Memory pressure has negitive impact on elow which could keep more usage when
   system is under less pressure.

PS: It should be configured as a sub-type of memcg and choosed by the user when
create the group.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/memcontrol.h   | 50 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/page_counter.h |  4 ++++
 include/linux/psi.h          |  2 ++
 kernel/sched/psi.c           | 18 ++++++++++++++++
 mm/memcontrol.c              |  4 ++++
 mm/page_counter.c            |  4 ++++
 6 files changed, 82 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c5c403..a510057 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -21,6 +21,9 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/clock.h>
+#include <linux/psi.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
@@ -28,6 +31,8 @@
 struct mm_struct;
 struct kmem_cache;
 
+#define MEMCG_INTERVAL	(2*HZ+1)	/* 2 sec intervals */
+
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
@@ -340,6 +345,10 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
+	u64 wm_dec_fact;
+	u64 avg_next_update;
+	u64 avg_last_update;
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
@@ -608,6 +617,47 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
+/*
+ * calculate memory.low based on the historic watermark and memory pressure
+ */
+static inline void calc_protected_low(struct mem_cgroup *group)
+{
+	u64 now, decay_factor;
+	u64 decayed_watermark;
+	u64 delta_time;
+
+	now = sched_clock();
+
+	if (!group->avg_next_update) {
+		group->avg_next_update = now + jiffies_to_nsecs(5*HZ);
+		return;
+	}
+
+	if (time_before((unsigned long)now, (unsigned long)group->avg_next_update))
+		return;
+
+	delta_time = group->avg_last_update ? now - group->avg_last_update : 0;
+	/*
+	 * we take 2048 as "1" and 68s decay 1/2(36bit) by default
+	 * decay_factor = 1024 * delta_time / 68s(0x1000000000)
+	 * 0.5(1024)/68s = decay_factor/delta_time ==> decay_factor = delta_time >> 26
+	 */
+	decay_factor = (2048 - min(2048ULL, delta_time >> (group->wm_dec_fact - 10)));
+	decayed_watermark = group->memory.decayed_watermark * decay_factor / 2048;
+	/* decay_factor: based on average memory pressure over elapsed time */
+	decay_factor = psi_mem_get(delta_time);
+	group->memory.low = decayed_watermark * (100 - decay_factor) / 100;
+
+	/*
+	 * avg_next_update: expected expire time according to current status
+	 */
+	group->memory.decayed_watermark = decayed_watermark;
+	group->avg_last_update = now;
+	group->avg_next_update = now + jiffies_to_nsecs(2*HZ);
+
+	return;
+}
+
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 6795913..2720eb9f 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -25,8 +25,12 @@ struct page_counter {
 
 	/* legacy */
 	unsigned long watermark;
+	unsigned long decayed_watermark;
 	unsigned long failcnt;
 
+	/* proportional protection */
+	unsigned long min_prop;
+	unsigned long low_prop;
 	/*
 	 * 'parent' is placed here to be far from 'usage' to reduce
 	 * cache false sharing, as 'usage' is written mostly while
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb147..6c76993 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -25,6 +25,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 
+unsigned long psi_mem_get(unsigned long time);
+
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgrp);
 void psi_cgroup_free(struct cgroup *cgrp);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index dd80bd2..8d315e0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -291,6 +291,24 @@ static void get_recent_times(struct psi_group *group, int cpu,
 	}
 }
 
+unsigned long psi_mem_get(unsigned long time_ns)
+{
+	unsigned long time_sec = time_ns / (1000 * 1000 * 1000);
+	unsigned long some, full;
+	if (time_sec < 10) {
+		some = LOAD_INT(psi_system.avg[PSI_MEM * 2][0]);
+		full = LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][0]);
+	} else if (time_sec < 60) {
+		some = LOAD_INT(psi_system.avg[PSI_MEM * 2][1]);
+		full = LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][1]);
+	} else {
+		some = LOAD_INT(psi_system.avg[PSI_MEM * 2][2]);
+		full = LOAD_INT(psi_system.avg[PSI_MEM * 2 + 1][2]);
+	}
+
+	return (some * 768 + full * 256) / 1024;
+}
+
 static void calc_avgs(unsigned long avg[3], int missed_periods,
 		      u64 time, u64 period)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 508bcea..6b579a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5188,6 +5188,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	memcg->wm_dec_fact = 36;
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
 		memcg->oom_kill_disable = parent->oom_kill_disable;
@@ -6616,6 +6617,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 	unsigned long usage, parent_usage;
 	struct mem_cgroup *parent;
+	unsigned long memcg_emin, memcg_elow, parent_emin, parent_elow;
+	unsigned long watermark;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -6642,6 +6645,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	if (!parent)
 		return;
 
+	calc_protected_low(memcg);
 	if (parent == root) {
 		memcg->memory.emin = READ_ONCE(memcg->memory.min);
 		memcg->memory.elow = READ_ONCE(memcg->memory.low);
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 7d83641..18abfdd 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -83,6 +83,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		 */
 		if (new > READ_ONCE(c->watermark))
 			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->decayed_watermark))
+			WRITE_ONCE(c->decayed_watermark, new);
 	}
 }
 
@@ -137,6 +139,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 */
 		if (new > READ_ONCE(c->watermark))
 			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->decayed_watermark))
+			WRITE_ONCE(c->decayed_watermark, new);
 	}
 	return true;
 
-- 
1.9.1

