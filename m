Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D46595862
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiHPKdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiHPKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:32:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E880E1838C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:38:44 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6PZv4SZ8zXdkF;
        Tue, 16 Aug 2022 16:34:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 16:38:42 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 16:38:42 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
Subject: [PATCH RFC] mm, proc: add PcpFree to meminfo
Date:   Tue, 16 Aug 2022 16:44:26 +0800
Message-ID: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Shixin <liushixin2@huawei.com>

The page on pcplist could be used, but not counted into memory free or
avaliable, and pcp_free is only showed by show_mem(). Since commit
d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
significant decrease in the display of free memory, with a large number
of cpus and nodes, the number of pages in the percpu list can be very
large, so it is better to let user to know the pcp count.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/node.c | 14 +++++++++++++-
 fs/proc/meminfo.c   |  9 +++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb0f43784c2b..846864e45db6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -375,6 +375,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 	struct sysinfo i;
 	unsigned long sreclaimable, sunreclaimable;
 	unsigned long swapcached = 0;
+	unsigned long free_pcp = 0;
+	struct zone *zone;
+	int cpu;
 
 	si_meminfo_node(&i, nid);
 	sreclaimable = node_page_state_pages(pgdat, NR_SLAB_RECLAIMABLE_B);
@@ -382,9 +385,17 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_SWAP
 	swapcached = node_page_state_pages(pgdat, NR_SWAPCACHE);
 #endif
+	for_each_populated_zone(zone) {
+		if (zone_to_nid(zone) != nid)
+			continue;
+		for_each_online_cpu(cpu)
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+	}
+
 	len = sysfs_emit_at(buf, len,
 			    "Node %d MemTotal:       %8lu kB\n"
 			    "Node %d MemFree:        %8lu kB\n"
+			    "Node %d PcpFree:        %8lu kB\n"
 			    "Node %d MemUsed:        %8lu kB\n"
 			    "Node %d SwapCached:     %8lu kB\n"
 			    "Node %d Active:         %8lu kB\n"
@@ -397,7 +408,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 			    "Node %d Mlocked:        %8lu kB\n",
 			    nid, K(i.totalram),
 			    nid, K(i.freeram),
-			    nid, K(i.totalram - i.freeram),
+			    nid, K(free_pcp),
+			    nid, K(i.totalram - i.freeram - free_pcp),
 			    nid, K(swapcached),
 			    nid, K(node_page_state(pgdat, NR_ACTIVE_ANON) +
 				   node_page_state(pgdat, NR_ACTIVE_FILE)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6e89f0e2fd20..672c784dfc8a 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
 	int lru;
+	unsigned long free_pcp = 0;
+	struct zone *zone;
+	int cpu;
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
@@ -55,8 +58,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
 	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
+	for_each_populated_zone(zone) {
+		for_each_online_cpu(cpu)
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+	}
+
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
+	show_val_kb(m, "PcpFree:        ", free_pcp);
 	show_val_kb(m, "MemAvailable:   ", available);
 	show_val_kb(m, "Buffers:        ", i.bufferram);
 	show_val_kb(m, "Cached:         ", cached);
-- 
2.35.3

