Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611215618CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiF3LLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiF3LLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:11:32 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6006845052
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:11:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHsIczw_1656587486;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHsIczw_1656587486)
          by smtp.aliyun-inc.com;
          Thu, 30 Jun 2022 19:11:27 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/3] mm: Add kernel PTE level pagetable pages account
Date:   Thu, 30 Jun 2022 19:11:16 +0800
Message-Id: <2d09ded7a78fdd531d3c6fa86787ba310bc19dc4.1656586863.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the kernel PTE level ptes are always protected by mm->page_table_lock
instead of split pagetable lock, so the kernel PTE level pagetable pages
are not accounted. Especially the vmalloc()/vmap() can consume lots of
kernel pagetable, so to get an accurate pagetable accounting, calling new
helpers pgtable_page_inc()/pgtable_page_dec() when allocating or freeing a
kernel PTE level pagetable page.

Meanwhile converting architectures to use corresponding generic PTE pagetable
allocation and freeing functions.

Note this patch only adds accounting to the page tables allocated after boot.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 arch/csky/include/asm/pgalloc.h |  2 +-
 arch/microblaze/mm/pgtable.c    |  2 +-
 arch/openrisc/mm/ioremap.c      |  2 +-
 arch/x86/mm/pgtable.c           |  5 ++++-
 include/asm-generic/pgalloc.h   | 14 ++++++++++++--
 5 files changed, 19 insertions(+), 6 deletions(-)

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
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 5e46e31..645868b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -851,6 +851,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {
 	pte_t *pte;
+	struct page *page;
 
 	pte = (pte_t *)pmd_page_vaddr(*pmd);
 	pmd_clear(pmd);
@@ -858,7 +859,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 	/* INVLPG to clear all paging-structure caches */
 	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
 
-	free_page((unsigned long)pte);
+	page = virt_to_page(pte);
+	pgtable_page_dec(page);
+	__free_page(page);
 
 	return 1;
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 11350f7..e1a6771 100644
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
+	page = alloc_pages(gfp, 0);
+	if (!page)
+		return NULL;
+	pgtable_page_inc(page);
+	return (pte_t *)page_address(page);
 }
 
 #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
@@ -41,7 +48,10 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
  */
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	free_page((unsigned long)pte);
+	struct page *page = virt_to_page(pte);
+
+	pgtable_page_dec(page);
+	__free_page(page);
 }
 
 /**
-- 
1.8.3.1

