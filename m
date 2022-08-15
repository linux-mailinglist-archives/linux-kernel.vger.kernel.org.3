Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C520592DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiHOLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiHOLFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:05:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5490824BEF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:04:40 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M5rsm1sb4zXdfs;
        Mon, 15 Aug 2022 19:00:28 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 19:04:36 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 19:04:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: kill find_min_pfn_with_active_regions()
Date:   Mon, 15 Aug 2022 19:10:17 +0800
Message-ID: <20220815111017.39341-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The find_min_pfn_with_active_regions() is only called in free_area_init(),
Move PHYS_PFN(memblock_start_of_DRAM()) into free_area_init(), and kill
find_min_pfn_with_active_regions().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h |  1 -
 mm/page_alloc.c    | 13 +------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3bedc449c14d..59144ad0a54c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2488,7 +2488,6 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
-extern unsigned long find_min_pfn_with_active_regions(void);
 
 #ifndef CONFIG_NUMA
 static inline int early_pfn_to_nid(unsigned long pfn)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..34eda5c18fdb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7908,17 +7908,6 @@ unsigned long __init node_map_pfn_alignment(void)
 	return ~accl_mask + 1;
 }
 
-/**
- * find_min_pfn_with_active_regions - Find the minimum PFN registered
- *
- * Return: the minimum PFN based on information provided via
- * memblock_set_node().
- */
-unsigned long __init find_min_pfn_with_active_regions(void)
-{
-	return PHYS_PFN(memblock_start_of_DRAM());
-}
-
 /*
  * early_calculate_totalpages()
  * Sum pages in active regions for movable zone.
@@ -8211,7 +8200,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	memset(arch_zone_highest_possible_pfn, 0,
 				sizeof(arch_zone_highest_possible_pfn));
 
-	start_pfn = find_min_pfn_with_active_regions();
+	start_pfn = PHYS_PFN(memblock_start_of_DRAM());
 	descending = arch_has_descending_max_zone_pfns();
 
 	for (i = 0; i < MAX_NR_ZONES; i++) {
-- 
2.35.3

