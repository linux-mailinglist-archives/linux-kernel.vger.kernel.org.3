Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22BC4AA096
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiBDT7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiBDT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B5C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+5/5LrDdS/xr2Za4ECQgFqz7Jeg8cG7FQU39t6kGWR8=; b=Tx/QEqwyQANQda73p9X49bjuIY
        BJOD673RNTqmaOYafaUYoe+A1c7SjrirW+1Pi0NHp+Q6PDMqoAtZOFFj0O4Q3t0e6uFlj9Kzrc/+f
        2U5w1LGwYvKSo/qtK+Zxd+VX0x0jDfPaZqn0pdOqe+vxHDkLhdW2d4QbfEhSrnNjosTLesyEEqXaR
        ApPyybojIPFNALhtfV8L2EP6fuWWmCb3f9iJXdD7ZkTj7P9VbJvf2+rY8nwRuArBoKZzTVobMYEOk
        KVXZ2B7u5z2xSozEu1Qut1mZOWanJtMoXr/lT7+s1EqpYSUg/Twv9floDNB2Wv8Qbm1csU3xQ6+VT
        PRp9skzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jW-007LmB-Aj; Fri, 04 Feb 2022 19:59:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/75] mm/memcg: Convert mem_cgroup_swapout() to take a folio
Date:   Fri,  4 Feb 2022 19:58:07 +0000
Message-Id: <20220204195852.1751729-31-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes an assumption that THPs are the only kind of compound
pages and removes a couple of hidden calls to compound_head.  It
also documents that you can't pass a tail page to mem_cgroup_swapout().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/swap.h |  4 ++--
 mm/memcontrol.c      | 22 +++++++++++-----------
 mm/vmscan.c          |  2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index de36f140227e..c9949c3bad20 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -741,7 +741,7 @@ static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 #endif
 
 #ifdef CONFIG_MEMCG_SWAP
-extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
+extern void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
 extern int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
 static inline int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 {
@@ -761,7 +761,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct page *page);
 #else
-static inline void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
+static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..326df978cedf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7121,19 +7121,19 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 
 /**
  * mem_cgroup_swapout - transfer a memsw charge to swap
- * @page: page whose memsw charge to transfer
+ * @folio: folio whose memsw charge to transfer
  * @entry: swap entry to move the charge to
  *
- * Transfer the memsw charge of @page to @entry.
+ * Transfer the memsw charge of @folio to @entry.
  */
-void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
+void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
 	unsigned int nr_entries;
 	unsigned short oldid;
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
-	VM_BUG_ON_PAGE(page_count(page), page);
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 
 	if (mem_cgroup_disabled())
 		return;
@@ -7141,9 +7141,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
-	memcg = page_memcg(page);
+	memcg = folio_memcg(folio);
 
-	VM_WARN_ON_ONCE_PAGE(!memcg, page);
+	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
 	if (!memcg)
 		return;
 
@@ -7153,16 +7153,16 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * ancestor for the swap instead and transfer the memory+swap charge.
 	 */
 	swap_memcg = mem_cgroup_id_get_online(memcg);
-	nr_entries = thp_nr_pages(page);
+	nr_entries = folio_nr_pages(folio);
 	/* Get references for the tail pages, too */
 	if (nr_entries > 1)
 		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(swap_memcg),
 				   nr_entries);
-	VM_BUG_ON_PAGE(oldid, page);
+	VM_BUG_ON_FOLIO(oldid, folio);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
-	page->memcg_data = 0;
+	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
@@ -7181,7 +7181,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 */
 	VM_BUG_ON(!irqs_disabled());
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
-	memcg_check_events(memcg, page_to_nid(page));
+	memcg_check_events(memcg, folio_nid(folio));
 
 	css_put(&memcg->css);
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 75223b7d98ec..08dcb1897f58 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1286,7 +1286,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
-		mem_cgroup_swapout(page, swap);
+		mem_cgroup_swapout(folio, swap);
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
 		__delete_from_swap_cache(page, swap, shadow);
-- 
2.34.1

