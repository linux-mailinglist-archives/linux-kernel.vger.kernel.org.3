Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37A453D4A8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349998AbiFDBcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245331AbiFDBcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:32:46 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399612D1B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:32:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VFHJab9_1654306360;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFHJab9_1654306360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jun 2022 09:32:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] mm: Add kernel PTE level pagetable pages account
Date:   Sat,  4 Jun 2022 09:32:31 +0800
Message-Id: <d35f42f7b598f629437940f941826e2cc49a97f6.1654271618.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
References: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
References: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the kernel PTE level ptes are always protected by mm->page_table_lock
instead of split pagetable lock, so the kernel PTE level pagetable pages
are not accounted. To get an accurate pagetable accounting, calling new
helpers pgtable_set_and_inc()/pgtable_clear_and_dec() when allocating or
freeing a kernel PTE level pagetable page.

Meanwhile converting architectures to use corresponding generic PTE pagetable
allocation and freeing functions.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/csky/include/asm/pgalloc.h |  2 +-
 arch/microblaze/mm/pgtable.c    |  2 +-
 arch/openrisc/mm/ioremap.c      |  2 +-
 include/asm-generic/pgalloc.h   | 10 +++++++++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bbbd069..2443226 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -29,7 +29,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 	pte_t *pte;
 	unsigned long i;
 
-	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	pte = __pte_alloc_one_kernel(mm);
 	if (!pte)
 		return NULL;
 
diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index 9f73265..e96dd1b 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -245,7 +245,7 @@ unsigned long iopa(unsigned long addr)
 __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	if (mem_init_done)
-		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		return __pte_alloc_one_kernel(mm);
 	else
 		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
 					      MEMBLOCK_LOW_LIMIT,
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a..3453acc 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -118,7 +118,7 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm)
 	pte_t *pte;
 
 	if (likely(mem_init_done)) {
-		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
+		pte = __pte_alloc_one_kernel(mm);
 	} else {
 		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		if (!pte)
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 78ab9f6..f5345b2 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -18,7 +18,14 @@
  */
 static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+	struct page *page;
+	gfp_t gfp = GFP_PGTABLE_KERNEL;
+
+	page = alloc_pages(gfp & ~__GFP_HIGHMEM, 0);
+	if (!page)
+		return NULL;
+	pgtable_set_and_inc(page);
+	return (pte_t *)page_address(page);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
@@ -41,6 +48,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
+	pgtable_clear_and_dec(virt_to_page(pte));
 	free_page((unsigned long)pte);
 }
 
-- 
1.8.3.1

