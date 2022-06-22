Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2A5547D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355507AbiFVI7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356393AbiFVI7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:59:09 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12192AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:59:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VH5BRms_1655888344;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VH5BRms_1655888344)
          by smtp.aliyun-inc.com;
          Wed, 22 Jun 2022 16:59:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] mm: Add PUD level pagetable account
Date:   Wed, 22 Jun 2022 16:58:53 +0800
Message-Id: <f7b2a6f6f5dfecbcac07fa3e187f10860c3a39ee.1655887440.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the PUD level ptes are always protected by mm->page_table_lock,
which means no split pagetable lock needed. So the generic PUD level
pagetable pages allocation will not call pgtable_pte_page_ctor/dtor(),
that means we will miss to account PUD level pagetable pages.

Adding pagetable account by calling pgtable_set_and_inc() or
pgtable_clear_and_dec() when allocating or freeing PUD level pagetable
pages to help to get an accurate pagetable accounting.

Moreover this patch will also mark the PUD level pagetable with PG_table
flag, which will help to do sanity validation in unpoison_memory() and
get more accurate pagetable accounting by /proc/kpageflags interface.

Meanwhile converting the architectures with using generic PUD pagatable
allocation to add corresponding pgtable_set_and_inc() or pgtable_clear_and_dec()
to account PUD level pagetable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 arch/arm64/include/asm/tlb.h         |  5 ++++-
 arch/loongarch/include/asm/pgalloc.h | 11 ++++++++---
 arch/mips/include/asm/pgalloc.h      | 11 ++++++++---
 arch/s390/include/asm/tlb.h          |  1 +
 arch/x86/mm/pgtable.c                |  5 ++++-
 include/asm-generic/pgalloc.h        | 12 ++++++++++--
 6 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f..47e0623 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -94,7 +94,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pudp));
+	struct page *page = virt_to_page(pudp);
+
+	pgtable_clear_and_dec(page);
+	tlb_remove_table(tlb, page);
 }
 #endif
 
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index b0a57b2..50a896f 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pud_t *pud;
+	struct page *pg;
+
+	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);
+	if (!pg)
+		return NULL;
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
-	if (pud)
-		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
+	pgtable_set_and_inc(pg);
+	pud = (pud_t *)page_address(pg);
+	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
 	return pud;
 }
 
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 867e9c3..0950f5f 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -89,11 +89,16 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
 {
+	struct page *pg;
 	pud_t *pud;
 
-	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
-	if (pud)
-		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
+	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);
+	if (!pg)
+		return NULL;
+
+	pgtable_set_and_inc(pg);
+	pud = (pud_t *)page_address(pg);
+	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
 	return pud;
 }
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index fe6407f..45f9541 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -125,6 +125,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 {
 	if (mm_pud_folded(tlb->mm))
 		return;
+	pgtable_clear_and_dec(virt_to_page(pud));
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a932d77..a8ab3f9 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -76,8 +76,11 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
+	struct page *page = virt_to_page(pud);
+
+	pgtable_clear_and_dec(page);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
+	paravirt_tlb_remove_table(tlb, page);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 977bea1..328a714 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -149,11 +149,16 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 
 static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
+	struct page *page;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	return (pud_t *)get_zeroed_page(gfp);
+	page = alloc_pages((gfp | __GFP_ZERO) & ~__GFP_HIGHMEM, 0);
+	if (!page)
+		return NULL;
+	pgtable_set_and_inc(page);
+	return (pud_t *)page_address(page);
 }
 
 #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
@@ -174,8 +179,11 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 
 static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 {
+	struct page *page = virt_to_page(pud);
+
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	free_page((unsigned long)pud);
+	pgtable_clear_and_dec(page);
+	__free_page(page);
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
-- 
1.8.3.1

