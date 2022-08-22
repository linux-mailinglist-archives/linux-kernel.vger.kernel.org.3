Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF359B757
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiHVB6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiHVB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:58:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B935B484
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 18:58:29 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M9wRS4VxnzlVpZ;
        Mon, 22 Aug 2022 09:55:16 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 09:58:27 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 22 Aug
 2022 09:58:26 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] mm, proc: collect percpu free pages into the free pages
Date:   Mon, 22 Aug 2022 10:33:11 +0800
Message-ID: <20220822023311.909316-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page on pcplist could be used, but not counted into memory free or
avaliable, and pcp_free is only showed by show_mem() for now. Since commit
d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
significant decrease in the display of free memory, with a large number
of cpus and zones, the number of pages in the percpu list can be very
large, so it is better to let user to know the pcp count.

On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
After the patch, the lists can hold 324MB. It has been observed to be 114MB
in the idle state after system startup in practice(increased 80 MB).

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/page_alloc.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 033f1e26d15b..f8b46ac2c2a0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5853,6 +5853,26 @@ static unsigned long nr_free_zone_pages(int offset)
 	return sum;
 }
 
+static unsigned long nr_free_zone_pcplist_pages(struct zone *zone)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		sum += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+	return sum;
+}
+
+static unsigned long nr_free_pcplist_pages(void)
+{
+	unsigned long sum = 0;
+	struct zone *zone;
+
+	for_each_zone(zone)
+		sum += nr_free_zone_pcplist_pages(zone);
+	return sum;
+}
+
 /**
  * nr_free_buffer_pages - count number of pages beyond high watermark
  *
@@ -5894,7 +5914,8 @@ long si_mem_available(void)
 	 * Estimate the amount of memory available for userspace allocations,
 	 * without causing swapping or OOM.
 	 */
-	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
+	available = global_zone_page_state(NR_FREE_PAGES) +
+		    nr_free_pcplist_pages() - totalreserve_pages;
 
 	/*
 	 * Not all the page cache can be freed, otherwise the system will
@@ -5924,7 +5945,8 @@ void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages();
 	val->sharedram = global_node_page_state(NR_SHMEM);
-	val->freeram = global_zone_page_state(NR_FREE_PAGES);
+	val->freeram = global_zone_page_state(NR_FREE_PAGES) +
+		       nr_free_pcplist_pages();
 	val->bufferram = nr_blockdev_pages();
 	val->totalhigh = totalhigh_pages();
 	val->freehigh = nr_free_highpages();
@@ -5938,30 +5960,28 @@ void si_meminfo_node(struct sysinfo *val, int nid)
 {
 	int zone_type;		/* needs to be signed */
 	unsigned long managed_pages = 0;
+	unsigned long free_pages = sum_zone_node_page_state(nid, NR_FREE_PAGES);
 	unsigned long managed_highpages = 0;
 	unsigned long free_highpages = 0;
 	pg_data_t *pgdat = NODE_DATA(nid);
 
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
-		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
-	val->totalram = managed_pages;
-	val->sharedram = node_page_state(pgdat, NR_SHMEM);
-	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
-#ifdef CONFIG_HIGHMEM
 	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
 
+		managed_pages += zone_managed_pages(zone);
+		free_pages += nr_free_zone_pcplist_pages(zone);
+#ifdef CONFIG_HIGHMEM
 		if (is_highmem(zone)) {
 			managed_highpages += zone_managed_pages(zone);
 			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
 		}
+#endif
 	}
+	val->totalram = managed_pages;
+	val->sharedram = node_page_state(pgdat, NR_SHMEM);
+	val->freeram = free_pages;
 	val->totalhigh = managed_highpages;
 	val->freehigh = free_highpages;
-#else
-	val->totalhigh = managed_highpages;
-	val->freehigh = free_highpages;
-#endif
 	val->mem_unit = PAGE_SIZE;
 }
 #endif
@@ -6035,8 +6055,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+		free_pcp += nr_free_zone_pcplist_pages(zone);
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
-- 
2.25.1

