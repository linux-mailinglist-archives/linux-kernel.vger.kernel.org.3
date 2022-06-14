Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7454BD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbiFNW0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbiFNW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:26:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAED5002A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655245572; x=1686781572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gSBoEG1kj/hIctq3Ckgu1ns/0pG+bGgO59Azngc0Rcw=;
  b=ZIsaJU0rVf7VVZvUXj7TPpMDYumTsSF8iu1ZrVQr4/ABeJGOaVApKvGq
   8mCZcCKoPQ0ynzTJHGPWGAouJHgZnuU8ZoQ6tdZ6ZG3l90w+EKOwzaAnt
   cDVITmQvbe5xF4FmiST2kx3uBpmpzGBemYn87Wtyp6iBUIw7J1LXs+tc9
   eM4XLOegdH6G2ZweXilimlZInWDbndyzJi7Uz4z3ofayba2YiBBKjWC75
   QLA0TiIGmwrfFqsyI0mSsb7tbXoP1xrBHtxEbHOe6KCyZkQdhtwaJtWFd
   LcHjYrfFO61aJ9XUOL2VrsjqU+fCf5PKAEDlg8RZm4GnxQjzwGWI52XpJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340422010"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340422010"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 15:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588724718"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 15:26:11 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: [RFC PATCH 1/3] mm/memory-tiers Add functions for tier memory usage in a cgroup
Date:   Tue, 14 Jun 2022 15:25:33 -0700
Message-Id: <94a10c772c50d378b81dad654476551bfc50e3d7.1655242024.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1655242024.git.tim.c.chen@linux.intel.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions to provide tier based memory usage.  This is in preparation
for query via sysfs and for controlling a cgroup's top tier memory usage.

This patch introduces the tiered memory usage query interface and a
simple implementation.  A more efficient implementation to get toptier
memory usage will be introduced in the next patch.
---
 include/linux/memory-tiers.h |  2 ++
 mm/memcontrol.c              | 35 +++++++++++++++++++++++++++++++++++
 mm/memory-tiers.c            |  3 ++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index de4098f6d5d5..1177dcbbdeda 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -31,6 +31,8 @@ struct memory_tier {
 };
 
 extern bool numa_demotion_enabled;
+extern struct list_head memory_tiers;
+
 int node_create_and_set_memory_tier(int node, int tier);
 int next_demotion_node(int node);
 int node_set_memory_tier(int node, int tier);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe6..2f6e95e6d200 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/memory-tiers.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -3921,6 +3922,40 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 
 	return 0;
 }
+
+unsigned long mem_cgroup_memtier_usage(struct mem_cgroup *memcg,
+					struct memory_tier *memtier)
+{
+	int node;
+	struct memory_tier *node_tier;
+	unsigned long usage = 0;
+
+	if (!memcg)
+		return 0;
+
+	rcu_read_lock();
+	for_each_online_node(node) {
+		node_tier = node_get_memory_tier(node);
+		if (node_tier == memtier)
+			usage += mem_cgroup_node_nr_lru_pages(memcg, node,
+					LRU_ALL, true);
+		node_put_memory_tier(node_tier);
+	}
+	rcu_read_unlock();
+	return usage;
+}
+
+unsigned long mem_cgroup_toptier_usage(struct mem_cgroup *memcg)
+{
+	struct memory_tier *top_tier;
+
+	top_tier = list_first_entry(&memory_tiers, struct memory_tier, list);
+	if (top_tier)
+		return mem_cgroup_memtier_usage(memcg, top_tier);
+	else
+		return 0;
+}
+
 #endif /* CONFIG_NUMA */
 
 static const unsigned int memcg1_stats[] = {
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0dae3114e22c..d552ac1e9d57 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -16,7 +16,8 @@ struct demotion_nodes {
 #define to_memory_tier(device) container_of(device, struct memory_tier, dev)
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
-static LIST_HEAD(memory_tiers);
+LIST_HEAD(memory_tiers);
+EXPORT_SYMBOL(memory_tiers);
 static int top_tier_rank;
 /*
  * node_demotion[] examples:
-- 
2.35.1

