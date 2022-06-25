Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7F55A871
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiFYJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiFYJ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:28:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2B1146C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:28:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LVTC16wT6zkWPb;
        Sat, 25 Jun 2022 17:26:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 17:28:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <zokeefe@google.com>, <aarcange@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 7/7] mm/khugepaged: try to free transhuge swapcache when possible
Date:   Sat, 25 Jun 2022 17:28:16 +0800
Message-ID: <20220625092816.4856-8-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220625092816.4856-1-linmiaohe@huawei.com>
References: <20220625092816.4856-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
It's because release_pte_page() is not called for these pages and
thus free_page_and_swap_cache can't grab the page lock. These pages
won't be freed from swap cache even if we are the only user until
next time reclaim. It shouldn't hurt indeed, but we could try to
free these pages to save more memory for system.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h | 5 +++++
 mm/khugepaged.c      | 7 ++++++-
 mm/swap.h            | 5 -----
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8672a7123ccd..ccb83b12b724 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -456,6 +456,7 @@ static inline unsigned long total_swapcache_pages(void)
 	return global_node_page_state(NR_SWAPCACHE);
 }
 
+extern void free_swap_cache(struct page *page);
 extern void free_page_and_swap_cache(struct page *);
 extern void free_pages_and_swap_cache(struct page **, int);
 /* linux/mm/swapfile.c */
@@ -540,6 +541,10 @@ static inline void put_swap_device(struct swap_info_struct *si)
 /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
 #define free_swap_and_cache(e) is_pfn_swap_entry(e)
 
+static inline void free_swap_cache(struct page *page)
+{
+}
+
 static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 {
 	return 0;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6cb82a299eb2..cfe231c5958f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -716,7 +716,12 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 
 	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
 		list_del(&src_page->lru);
-		release_pte_page(src_page);
+		mod_node_page_state(page_pgdat(src_page),
+				    NR_ISOLATED_ANON + page_is_file_lru(src_page),
+				    -compound_nr(src_page));
+		unlock_page(src_page);
+		free_swap_cache(src_page);
+		putback_lru_page(src_page);
 	}
 }
 
diff --git a/mm/swap.h b/mm/swap.h
index fa0816af4712..17936e068c1c 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
-void free_swap_cache(struct page *page);
 struct page *lookup_swap_cache(swp_entry_t entry,
 			       struct vm_area_struct *vma,
 			       unsigned long addr);
@@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 	return NULL;
 }
 
-static inline void free_swap_cache(struct page *page)
-{
-}
-
 static inline void show_swap_cache_info(void)
 {
 }
-- 
2.23.0

