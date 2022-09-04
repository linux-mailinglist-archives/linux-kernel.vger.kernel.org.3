Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB35AC4B0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiIDOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiIDOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:11:19 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Sep 2022 07:11:17 PDT
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 759BA31DF4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 07:11:17 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:42302.846211882
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-222.210.155.225 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id 013A32801A6;
        Sun,  4 Sep 2022 22:03:25 +0800 (CST)
X-189-SAVE-TO-SEND: +lic121@chinatelecom.cn
Received: from  ([172.18.0.218])
        by app0025 with ESMTP id fcb6896dd8644185bf2f35d5547c90c4 for mike.kravetz@oracle.com;
        Sun, 04 Sep 2022 22:03:30 CST
X-Transaction-ID: fcb6896dd8644185bf2f35d5547c90c4
X-Real-From: lic121@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: lic121@chinatelecom.cn
From:   Cheng Li <lic121@chinatelecom.cn>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Cheng Li <lic121@chinatelecom.cn>
Subject: [PATCH] mm: use mem_map_offset instead of mem_map_next
Date:   Sun,  4 Sep 2022 14:02:41 +0000
Message-Id: <1662300161-22049-1-git-send-email-lic121@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle discontiguity case, mem_map_next() has a parameter named
`offset`. As a function caller, one would be confused why "get
next entry" needs a parameter named "offset". The other drawback of
mem_map_next() is that the callers must take care of the map between
parameter "iter" and "offset", otherwise we may get an hole or
duplication during iteration. So we use mem_map_offset instead of
mem_map_next.

Signed-off-by: Cheng Li <lic121@chinatelecom.cn>
Fixes: 69d177c2fc70 ("hugetlbfs: handle pages higher order than MAX_ORDER")
---
 mm/hugetlb.c  | 25 +++++++++++++++----------
 mm/internal.h | 16 ++--------------
 mm/memory.c   | 21 ++++++++++-----------
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e070b8593b37..56d74cdbdbf9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1308,12 +1308,13 @@ static void __destroy_compound_gigantic_page(struct page *page,
 {
 	int i;
 	int nr_pages = 1 << order;
-	struct page *p = page + 1;
+	struct page *p;
 
 	atomic_set(compound_mapcount_ptr(page), 0);
 	atomic_set(compound_pincount_ptr(page), 0);
 
-	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+	for (i = 1; i < nr_pages; i++) {
+		p = mem_map_offset(page, i);
 		p->mapping = NULL;
 		clear_compound_head(p);
 		if (!demote)
@@ -1530,7 +1531,7 @@ static void add_hugetlb_page(struct hstate *h, struct page *page,
 static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
-	struct page *subpage = page;
+	struct page *subpage;
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1561,8 +1562,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (unlikely(PageHWPoison(page)))
 		hugetlb_clear_page_hwpoison(page);
 
-	for (i = 0; i < pages_per_huge_page(h);
-	     i++, subpage = mem_map_next(subpage, page, i)) {
+	for (i = 0; i < pages_per_huge_page(h); i++) {
+		subpage = mem_map_offset(page, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
 				1 << PG_referenced | 1 << PG_dirty |
 				1 << PG_active | 1 << PG_private |
@@ -1769,13 +1770,15 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 {
 	int i, j;
 	int nr_pages = 1 << order;
-	struct page *p = page + 1;
+	struct page *p;
 
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
 	__ClearPageReserved(page);
 	__SetPageHead(page);
-	for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
+	for (i = 1; i < nr_pages; i++) {
+		p = mem_map_offset(p, page, i);
+
 		/*
 		 * For gigantic hugepages allocated through bootmem at
 		 * boot, it's safer to be consistent with the not-gigantic
@@ -1822,14 +1825,16 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 
 out_error:
 	/* undo tail page modifications made above */
-	p = page + 1;
-	for (j = 1; j < i; j++, p = mem_map_next(p, page, j)) {
+	for (j = 1; j < i; j++) {
+		p = mem_map_offset(page, j);
 		clear_compound_head(p);
 		set_page_refcounted(p);
 	}
 	/* need to clear PG_reserved on remaining tail pages  */
-	for (; j < nr_pages; j++, p = mem_map_next(p, page, j))
+	for (; j < nr_pages; j++) {
+		p = mem_map_offset(page, j);
 		__ClearPageReserved(p);
+	}
 	set_compound_order(page, 0);
 #ifdef CONFIG_64BIT
 	page[1].compound_nr = 0;
diff --git a/mm/internal.h b/mm/internal.h
index 785409805ed7..1012a305a60f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -646,25 +646,13 @@ static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
  */
 static inline struct page *mem_map_offset(struct page *base, int offset)
 {
-	if (unlikely(offset >= MAX_ORDER_NR_PAGES))
-		return nth_page(base, offset);
-	return base + offset;
-}
-
-/*
- * Iterator over all subpages within the maximally aligned gigantic
- * page 'base'.  Handle any discontiguity in the mem_map.
- */
-static inline struct page *mem_map_next(struct page *iter,
-						struct page *base, int offset)
-{
-	if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
+	if (unlikely(offset >= MAX_ORDER_NR_PAGES)) {
 		unsigned long pfn = page_to_pfn(base) + offset;
 		if (!pfn_valid(pfn))
 			return NULL;
 		return pfn_to_page(pfn);
 	}
-	return iter + 1;
+	return base + offset;
 }
 
 /* Memory initialisation debug and verification */
diff --git a/mm/memory.c b/mm/memory.c
index 4ba73f5aa8bb..32179c4fd1a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5637,11 +5637,11 @@ static void clear_gigantic_page(struct page *page,
 				unsigned int pages_per_huge_page)
 {
 	int i;
-	struct page *p = page;
+	struct page *p;
 
 	might_sleep();
-	for (i = 0; i < pages_per_huge_page;
-	     i++, p = mem_map_next(p, page, i)) {
+	for (i = 0; i < pages_per_huge_page; i++) {
+		p = mem_map_offset(page, i);
 		cond_resched();
 		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
@@ -5677,13 +5677,12 @@ static void copy_user_gigantic_page(struct page *dst, struct page *src,
 	struct page *dst_base = dst;
 	struct page *src_base = src;
 
-	for (i = 0; i < pages_per_huge_page; ) {
+	for (i = 0; i < pages_per_huge_page; i++) {
+		dst = mem_map_offset(dst_base, i);
+		src = mem_map_offset(src_base, i);
+
 		cond_resched();
 		copy_user_highpage(dst, src, addr + i*PAGE_SIZE, vma);
-
-		i++;
-		dst = mem_map_next(dst, dst_base, i);
-		src = mem_map_next(src, src_base, i);
 	}
 }
 
@@ -5730,10 +5729,10 @@ long copy_huge_page_from_user(struct page *dst_page,
 	void *page_kaddr;
 	unsigned long i, rc = 0;
 	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
-	struct page *subpage = dst_page;
+	struct page *subpage;
 
-	for (i = 0; i < pages_per_huge_page;
-	     i++, subpage = mem_map_next(subpage, dst_page, i)) {
+	for (i = 0; i < pages_per_huge_page; i++) {
+		subpage = mem_map_offset(dst_page, i);
 		if (allow_pagefault)
 			page_kaddr = kmap(subpage);
 		else
-- 
1.8.3.1

