Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502C45432CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiFHOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbiFHOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:40:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083913B8CC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:40:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJ8vH6YdpzRj9k;
        Wed,  8 Jun 2022 22:37:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 8 Jun
 2022 22:40:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 3/3] mm/swap: remove swap_cache_info statistics
Date:   Wed, 8 Jun 2022 22:40:31 +0800
Message-ID: <20220608144031.829-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220608144031.829-1-linmiaohe@huawei.com>
References: <20220608144031.829-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_cache_info are not statistics that could be easily used to tune system
performance because they are not easily accessile. Also they can't provide
really useful info when OOM occurs. Remove these statistics can also help
mitigate unneeded global swap_cache_info cacheline contention.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0a2021fc55ad..41c6a6053d5c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -59,24 +59,11 @@ static bool enable_vma_readahead __read_mostly = true;
 #define GET_SWAP_RA_VAL(vma)					\
 	(atomic_long_read(&(vma)->swap_readahead_info) ? : 4)
 
-#define INC_CACHE_INFO(x)	data_race(swap_cache_info.x++)
-#define ADD_CACHE_INFO(x, nr)	data_race(swap_cache_info.x += (nr))
-
-static struct {
-	unsigned long add_total;
-	unsigned long del_total;
-	unsigned long find_success;
-	unsigned long find_total;
-} swap_cache_info;
-
 static atomic_t swapin_readahead_hits = ATOMIC_INIT(4);
 
 void show_swap_cache_info(void)
 {
 	printk("%lu pages in swap cache\n", total_swapcache_pages());
-	printk("Swap cache stats: add %lu, delete %lu, find %lu/%lu\n",
-		swap_cache_info.add_total, swap_cache_info.del_total,
-		swap_cache_info.find_success, swap_cache_info.find_total);
 	printk("Free swap  = %ldkB\n",
 		get_nr_swap_pages() << (PAGE_SHIFT - 10));
 	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
@@ -133,7 +120,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 		address_space->nrpages += nr;
 		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
 		__mod_lruvec_page_state(page, NR_SWAPCACHE, nr);
-		ADD_CACHE_INFO(add_total, nr);
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
@@ -172,7 +158,6 @@ void __delete_from_swap_cache(struct page *page,
 	address_space->nrpages -= nr;
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
 	__mod_lruvec_page_state(page, NR_SWAPCACHE, -nr);
-	ADD_CACHE_INFO(del_total, nr);
 }
 
 /**
@@ -348,12 +333,10 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 	page = find_get_page(swap_address_space(entry), swp_offset(entry));
 	put_swap_device(si);
 
-	INC_CACHE_INFO(find_total);
 	if (page) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
 
-		INC_CACHE_INFO(find_success);
 		/*
 		 * At the moment, we don't support PG_readahead for anon THP
 		 * so let's bail out rather than confusing the readahead stat.
-- 
2.23.0

