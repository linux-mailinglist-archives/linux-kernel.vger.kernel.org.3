Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64D547F91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiFMGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiFMGfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21219BC81
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so5031685pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cd5TADEYIw6EN5sUEtH2CBYk3q1W3D399BGmAPG/bAw=;
        b=vEdfjXcvbTsdSeTcxUk5kx5POEj7WY0iyWJKmSGt22Lx3wglGegKrdLGvzJweT1AfH
         cH6HNumJqtGob9JvAQ65Hj0ngIHjw1ODg/2td5bWnuQDN0fcsyjTco7ht5RDsSqp1NI5
         9mw4tmKtNMqMmoHhhdek7rkOUVRQ93m0cV0p+aPlK5ahPwIYQgiJmj1YsN/KSHiUsLat
         XYboVO2+y7ALLL6J6Hvett0jO+TGXUJ+kE9i0lmnx69FivI2/5Ws8UtzUawNq/q6X6yl
         J9pkD174uMVGuXy0l5ILCjcs1esTWjr80/6LNxgDcC/wLNwJ/mvIF4+ePaF1Zc8kuBcQ
         jpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cd5TADEYIw6EN5sUEtH2CBYk3q1W3D399BGmAPG/bAw=;
        b=UOVdE93h1lIYTqmpArV9GzSIt3lWQV4MzufRBtSyGESx4OusoBiMHPR5IEDAzuh+z7
         HjuYUiKcpgioTup6arSh/VKNL9FwA5l2rFpLq+eFhG7LPN3i93zdPiRN4J3hV8W0YQ2/
         +gzGs1CAdRx9sJDZYEZthe6deUtjoiN8QwrLnvWS7zwXiYYI6KTIzWZpS13f4xazGpjF
         KRQDV+tH5Z/g4kL+UKHnMHd/dlF6flPLLgVGnNHOggp1AkW1AcflbUofUXDlwgwnrtB6
         VOXse379WCNo5KP+Ji1IMxULKYFB/Q7i/eukjaxFJp5kjpCrYM5VtzEwdbC9+6GvGKST
         j7Sw==
X-Gm-Message-State: AOAM532PUUr5NhibYQ/gwzTPHfkvMeupg8RBjwV8b6J2waNKGpgm3afH
        8PEmllOvlWaR0GmiIA23UmnKQQ==
X-Google-Smtp-Source: ABdhPJyUPsj3ZCa5CUrkPMU5XgNXd44Hm79QahH4VTCrNacbiTJjMF1MkuSpn9bKxk79RDbBHcwhKA==
X-Received: by 2002:a17:90a:c70a:b0:1e2:eb3e:239f with SMTP id o10-20020a17090ac70a00b001e2eb3e239fmr14202730pjt.94.1655102143315;
        Sun, 12 Jun 2022 23:35:43 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/6] mm: hugetlb_vmemmap: move vmemmap code related to HugeTLB to hugetlb_vmemmap.c
Date:   Mon, 13 Jun 2022 14:35:10 +0800
Message-Id: <20220613063512.17540-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220613063512.17540-1-songmuchun@bytedance.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I first introduced vmemmap manipulation functions related to HugeTLB,
I thought those functions may be reused by other modules (e.g. using
similar approach to optimize vmemmap pages, unfortunately, the DAX used the
same approach but does not use those functions).  After two years, we didn't
see any other users.  So move those functions to hugetlb_vmemmap.c.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h   |   7 -
 mm/hugetlb_vmemmap.c | 391 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/sparse-vmemmap.c  | 391 ---------------------------------------------------
 3 files changed, 390 insertions(+), 399 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 623c2ee8330a..152d0eefe5aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3208,13 +3208,6 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
 }
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int vmemmap_remap_free(unsigned long start, unsigned long end,
-		       unsigned long reuse);
-int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			unsigned long reuse, gfp_t gfp_mask);
-#endif
-
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c10540993577..abdf441215bb 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -10,9 +10,31 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
-#include <linux/memory_hotplug.h>
+#include <linux/pgtable.h>
+#include <linux/bootmem_info.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
 
+/**
+ * struct vmemmap_remap_walk - walk vmemmap page table
+ *
+ * @remap_pte:		called for each lowest-level entry (PTE).
+ * @nr_walked:		the number of walked pte.
+ * @reuse_page:		the page which is reused for the tail vmemmap pages.
+ * @reuse_addr:		the virtual address of the @reuse_page page.
+ * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
+ *			or is mapped from.
+ */
+struct vmemmap_remap_walk {
+	void			(*remap_pte)(pte_t *pte, unsigned long addr,
+					     struct vmemmap_remap_walk *walk);
+	unsigned long		nr_walked;
+	struct page		*reuse_page;
+	unsigned long		reuse_addr;
+	struct list_head	*vmemmap_pages;
+};
+
 /*
  * There are a lot of struct page structures associated with each HugeTLB page.
  * For tail pages, the value of compound_head is the same. So we can reuse first
@@ -23,6 +45,373 @@
 #define RESERVE_VMEMMAP_NR		1U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
+static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+{
+	pmd_t __pmd;
+	int i;
+	unsigned long addr = start;
+	struct page *page = pmd_page(*pmd);
+	pte_t *pgtable = pte_alloc_one_kernel(&init_mm);
+
+	if (!pgtable)
+		return -ENOMEM;
+
+	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
+
+	for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
+		pte_t entry, *pte;
+		pgprot_t pgprot = PAGE_KERNEL;
+
+		entry = mk_pte(page + i, pgprot);
+		pte = pte_offset_kernel(&__pmd, addr);
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pmd_leaf(*pmd))) {
+		/* Make pte visible before pmd. See comment in pmd_install(). */
+		smp_wmb();
+		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		flush_tlb_kernel_range(start, start + PMD_SIZE);
+	} else {
+		pte_free_kernel(&init_mm, pgtable);
+	}
+	spin_unlock(&init_mm.page_table_lock);
+
+	return 0;
+}
+
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+{
+	int leaf;
+
+	spin_lock(&init_mm.page_table_lock);
+	leaf = pmd_leaf(*pmd);
+	spin_unlock(&init_mm.page_table_lock);
+
+	if (!leaf)
+		return 0;
+
+	return __split_vmemmap_huge_pmd(pmd, start);
+}
+
+static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
+			      unsigned long end,
+			      struct vmemmap_remap_walk *walk)
+{
+	pte_t *pte = pte_offset_kernel(pmd, addr);
+
+	/*
+	 * The reuse_page is found 'first' in table walk before we start
+	 * remapping (which is calling @walk->remap_pte).
+	 */
+	if (!walk->reuse_page) {
+		walk->reuse_page = pte_page(*pte);
+		/*
+		 * Because the reuse address is part of the range that we are
+		 * walking, skip the reuse address range.
+		 */
+		addr += PAGE_SIZE;
+		pte++;
+		walk->nr_walked++;
+	}
+
+	for (; addr != end; addr += PAGE_SIZE, pte++) {
+		walk->remap_pte(pte, addr, walk);
+		walk->nr_walked++;
+	}
+}
+
+static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
+			     unsigned long end,
+			     struct vmemmap_remap_walk *walk)
+{
+	pmd_t *pmd;
+	unsigned long next;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		int ret;
+
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		if (ret)
+			return ret;
+
+		next = pmd_addr_end(addr, end);
+		vmemmap_pte_range(pmd, addr, next, walk);
+	} while (pmd++, addr = next, addr != end);
+
+	return 0;
+}
+
+static int vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
+			     unsigned long end,
+			     struct vmemmap_remap_walk *walk)
+{
+	pud_t *pud;
+	unsigned long next;
+
+	pud = pud_offset(p4d, addr);
+	do {
+		int ret;
+
+		next = pud_addr_end(addr, end);
+		ret = vmemmap_pmd_range(pud, addr, next, walk);
+		if (ret)
+			return ret;
+	} while (pud++, addr = next, addr != end);
+
+	return 0;
+}
+
+static int vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
+			     unsigned long end,
+			     struct vmemmap_remap_walk *walk)
+{
+	p4d_t *p4d;
+	unsigned long next;
+
+	p4d = p4d_offset(pgd, addr);
+	do {
+		int ret;
+
+		next = p4d_addr_end(addr, end);
+		ret = vmemmap_pud_range(p4d, addr, next, walk);
+		if (ret)
+			return ret;
+	} while (p4d++, addr = next, addr != end);
+
+	return 0;
+}
+
+static int vmemmap_remap_range(unsigned long start, unsigned long end,
+			       struct vmemmap_remap_walk *walk)
+{
+	unsigned long addr = start;
+	unsigned long next;
+	pgd_t *pgd;
+
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
+
+	pgd = pgd_offset_k(addr);
+	do {
+		int ret;
+
+		next = pgd_addr_end(addr, end);
+		ret = vmemmap_p4d_range(pgd, addr, next, walk);
+		if (ret)
+			return ret;
+	} while (pgd++, addr = next, addr != end);
+
+	/*
+	 * We only change the mapping of the vmemmap virtual address range
+	 * [@start + PAGE_SIZE, end), so we only need to flush the TLB which
+	 * belongs to the range.
+	 */
+	flush_tlb_kernel_range(start + PAGE_SIZE, end);
+
+	return 0;
+}
+
+/*
+ * Free a vmemmap page. A vmemmap page can be allocated from the memblock
+ * allocator or buddy allocator. If the PG_reserved flag is set, it means
+ * that it allocated from the memblock allocator, just free it via the
+ * free_bootmem_page(). Otherwise, use __free_page().
+ */
+static inline void free_vmemmap_page(struct page *page)
+{
+	if (PageReserved(page))
+		free_bootmem_page(page);
+	else
+		__free_page(page);
+}
+
+/* Free a list of the vmemmap pages */
+static void free_vmemmap_page_list(struct list_head *list)
+{
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, list, lru) {
+		list_del(&page->lru);
+		free_vmemmap_page(page);
+	}
+}
+
+static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
+			      struct vmemmap_remap_walk *walk)
+{
+	/*
+	 * Remap the tail pages as read-only to catch illegal write operation
+	 * to the tail pages.
+	 */
+	pgprot_t pgprot = PAGE_KERNEL_RO;
+	pte_t entry = mk_pte(walk->reuse_page, pgprot);
+	struct page *page = pte_page(*pte);
+
+	list_add_tail(&page->lru, walk->vmemmap_pages);
+	set_pte_at(&init_mm, addr, pte, entry);
+}
+
+/*
+ * How many struct page structs need to be reset. When we reuse the head
+ * struct page, the special metadata (e.g. page->flags or page->mapping)
+ * cannot copy to the tail struct page structs. The invalid value will be
+ * checked in the free_tail_pages_check(). In order to avoid the message
+ * of "corrupted mapping in tail page". We need to reset at least 3 (one
+ * head struct page struct and two tail struct page structs) struct page
+ * structs.
+ */
+#define NR_RESET_STRUCT_PAGE		3
+
+static inline void reset_struct_pages(struct page *start)
+{
+	int i;
+	struct page *from = start + NR_RESET_STRUCT_PAGE;
+
+	for (i = 0; i < NR_RESET_STRUCT_PAGE; i++)
+		memcpy(start + i, from, sizeof(*from));
+}
+
+static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
+				struct vmemmap_remap_walk *walk)
+{
+	pgprot_t pgprot = PAGE_KERNEL;
+	struct page *page;
+	void *to;
+
+	BUG_ON(pte_page(*pte) != walk->reuse_page);
+
+	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
+	list_del(&page->lru);
+	to = page_to_virt(page);
+	copy_page(to, (void *)walk->reuse_addr);
+	reset_struct_pages(to);
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
+}
+
+/**
+ * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
+ *			to the page which @reuse is mapped to, then free vmemmap
+ *			which the range are mapped to.
+ * @start:	start address of the vmemmap virtual address range that we want
+ *		to remap.
+ * @end:	end address of the vmemmap virtual address range that we want to
+ *		remap.
+ * @reuse:	reuse address.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_free(unsigned long start, unsigned long end,
+			      unsigned long reuse)
+{
+	int ret;
+	LIST_HEAD(vmemmap_pages);
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= vmemmap_remap_pte,
+		.reuse_addr	= reuse,
+		.vmemmap_pages	= &vmemmap_pages,
+	};
+
+	/*
+	 * In order to make remapping routine most efficient for the huge pages,
+	 * the routine of vmemmap page table walking has the following rules
+	 * (see more details from the vmemmap_pte_range()):
+	 *
+	 * - The range [@start, @end) and the range [@reuse, @reuse + PAGE_SIZE)
+	 *   should be continuous.
+	 * - The @reuse address is part of the range [@reuse, @end) that we are
+	 *   walking which is passed to vmemmap_remap_range().
+	 * - The @reuse address is the first in the complete range.
+	 *
+	 * So we need to make sure that @start and @reuse meet the above rules.
+	 */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	mmap_read_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	if (ret && walk.nr_walked) {
+		end = reuse + walk.nr_walked * PAGE_SIZE;
+		/*
+		 * vmemmap_pages contains pages from the previous
+		 * vmemmap_remap_range call which failed.  These
+		 * are pages which were removed from the vmemmap.
+		 * They will be restored in the following call.
+		 */
+		walk = (struct vmemmap_remap_walk) {
+			.remap_pte	= vmemmap_restore_pte,
+			.reuse_addr	= reuse,
+			.vmemmap_pages	= &vmemmap_pages,
+		};
+
+		vmemmap_remap_range(reuse, end, &walk);
+	}
+	mmap_read_unlock(&init_mm);
+
+	free_vmemmap_page_list(&vmemmap_pages);
+
+	return ret;
+}
+
+static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
+				   gfp_t gfp_mask, struct list_head *list)
+{
+	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
+	int nid = page_to_nid((struct page *)start);
+	struct page *page, *next;
+
+	while (nr_pages--) {
+		page = alloc_pages_node(nid, gfp_mask, 0);
+		if (!page)
+			goto out;
+		list_add_tail(&page->lru, list);
+	}
+
+	return 0;
+out:
+	list_for_each_entry_safe(page, next, list, lru)
+		__free_pages(page, 0);
+	return -ENOMEM;
+}
+
+/**
+ * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
+ *			 to the page which is from the @vmemmap_pages
+ *			 respectively.
+ * @start:	start address of the vmemmap virtual address range that we want
+ *		to remap.
+ * @end:	end address of the vmemmap virtual address range that we want to
+ *		remap.
+ * @reuse:	reuse address.
+ * @gfp_mask:	GFP flag for allocating vmemmap pages.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
+			       unsigned long reuse, gfp_t gfp_mask)
+{
+	LIST_HEAD(vmemmap_pages);
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= vmemmap_restore_pte,
+		.reuse_addr	= reuse,
+		.vmemmap_pages	= &vmemmap_pages,
+	};
+
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
+		return -ENOMEM;
+
+	mmap_read_lock(&init_mm);
+	vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return 0;
+}
+
 DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 49cb15cbe590..473effcb2285 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,400 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
-#include <linux/pgtable.h>
-#include <linux/bootmem_info.h>
 
 #include <asm/dma.h>
 #include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-/**
- * struct vmemmap_remap_walk - walk vmemmap page table
- *
- * @remap_pte:		called for each lowest-level entry (PTE).
- * @nr_walked:		the number of walked pte.
- * @reuse_page:		the page which is reused for the tail vmemmap pages.
- * @reuse_addr:		the virtual address of the @reuse_page page.
- * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
- *			or is mapped from.
- */
-struct vmemmap_remap_walk {
-	void (*remap_pte)(pte_t *pte, unsigned long addr,
-			  struct vmemmap_remap_walk *walk);
-	unsigned long nr_walked;
-	struct page *reuse_page;
-	unsigned long reuse_addr;
-	struct list_head *vmemmap_pages;
-};
-
-static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
-{
-	pmd_t __pmd;
-	int i;
-	unsigned long addr = start;
-	struct page *page = pmd_page(*pmd);
-	pte_t *pgtable = pte_alloc_one_kernel(&init_mm);
-
-	if (!pgtable)
-		return -ENOMEM;
-
-	pmd_populate_kernel(&init_mm, &__pmd, pgtable);
-
-	for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
-		pte_t entry, *pte;
-		pgprot_t pgprot = PAGE_KERNEL;
-
-		entry = mk_pte(page + i, pgprot);
-		pte = pte_offset_kernel(&__pmd, addr);
-		set_pte_at(&init_mm, addr, pte, entry);
-	}
-
-	spin_lock(&init_mm.page_table_lock);
-	if (likely(pmd_leaf(*pmd))) {
-		/* Make pte visible before pmd. See comment in pmd_install(). */
-		smp_wmb();
-		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
-	} else {
-		pte_free_kernel(&init_mm, pgtable);
-	}
-	spin_unlock(&init_mm.page_table_lock);
-
-	return 0;
-}
-
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
-{
-	int leaf;
-
-	spin_lock(&init_mm.page_table_lock);
-	leaf = pmd_leaf(*pmd);
-	spin_unlock(&init_mm.page_table_lock);
-
-	if (!leaf)
-		return 0;
-
-	return __split_vmemmap_huge_pmd(pmd, start);
-}
-
-static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
-			      unsigned long end,
-			      struct vmemmap_remap_walk *walk)
-{
-	pte_t *pte = pte_offset_kernel(pmd, addr);
-
-	/*
-	 * The reuse_page is found 'first' in table walk before we start
-	 * remapping (which is calling @walk->remap_pte).
-	 */
-	if (!walk->reuse_page) {
-		walk->reuse_page = pte_page(*pte);
-		/*
-		 * Because the reuse address is part of the range that we are
-		 * walking, skip the reuse address range.
-		 */
-		addr += PAGE_SIZE;
-		pte++;
-		walk->nr_walked++;
-	}
-
-	for (; addr != end; addr += PAGE_SIZE, pte++) {
-		walk->remap_pte(pte, addr, walk);
-		walk->nr_walked++;
-	}
-}
-
-static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
-			     unsigned long end,
-			     struct vmemmap_remap_walk *walk)
-{
-	pmd_t *pmd;
-	unsigned long next;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		int ret;
-
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
-		if (ret)
-			return ret;
-
-		next = pmd_addr_end(addr, end);
-		vmemmap_pte_range(pmd, addr, next, walk);
-	} while (pmd++, addr = next, addr != end);
-
-	return 0;
-}
-
-static int vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
-			     unsigned long end,
-			     struct vmemmap_remap_walk *walk)
-{
-	pud_t *pud;
-	unsigned long next;
-
-	pud = pud_offset(p4d, addr);
-	do {
-		int ret;
-
-		next = pud_addr_end(addr, end);
-		ret = vmemmap_pmd_range(pud, addr, next, walk);
-		if (ret)
-			return ret;
-	} while (pud++, addr = next, addr != end);
-
-	return 0;
-}
-
-static int vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
-			     unsigned long end,
-			     struct vmemmap_remap_walk *walk)
-{
-	p4d_t *p4d;
-	unsigned long next;
-
-	p4d = p4d_offset(pgd, addr);
-	do {
-		int ret;
-
-		next = p4d_addr_end(addr, end);
-		ret = vmemmap_pud_range(p4d, addr, next, walk);
-		if (ret)
-			return ret;
-	} while (p4d++, addr = next, addr != end);
-
-	return 0;
-}
-
-static int vmemmap_remap_range(unsigned long start, unsigned long end,
-			       struct vmemmap_remap_walk *walk)
-{
-	unsigned long addr = start;
-	unsigned long next;
-	pgd_t *pgd;
-
-	VM_BUG_ON(!PAGE_ALIGNED(start));
-	VM_BUG_ON(!PAGE_ALIGNED(end));
-
-	pgd = pgd_offset_k(addr);
-	do {
-		int ret;
-
-		next = pgd_addr_end(addr, end);
-		ret = vmemmap_p4d_range(pgd, addr, next, walk);
-		if (ret)
-			return ret;
-	} while (pgd++, addr = next, addr != end);
-
-	/*
-	 * We only change the mapping of the vmemmap virtual address range
-	 * [@start + PAGE_SIZE, end), so we only need to flush the TLB which
-	 * belongs to the range.
-	 */
-	flush_tlb_kernel_range(start + PAGE_SIZE, end);
-
-	return 0;
-}
-
-/*
- * Free a vmemmap page. A vmemmap page can be allocated from the memblock
- * allocator or buddy allocator. If the PG_reserved flag is set, it means
- * that it allocated from the memblock allocator, just free it via the
- * free_bootmem_page(). Otherwise, use __free_page().
- */
-static inline void free_vmemmap_page(struct page *page)
-{
-	if (PageReserved(page))
-		free_bootmem_page(page);
-	else
-		__free_page(page);
-}
-
-/* Free a list of the vmemmap pages */
-static void free_vmemmap_page_list(struct list_head *list)
-{
-	struct page *page, *next;
-
-	list_for_each_entry_safe(page, next, list, lru) {
-		list_del(&page->lru);
-		free_vmemmap_page(page);
-	}
-}
-
-static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
-			      struct vmemmap_remap_walk *walk)
-{
-	/*
-	 * Remap the tail pages as read-only to catch illegal write operation
-	 * to the tail pages.
-	 */
-	pgprot_t pgprot = PAGE_KERNEL_RO;
-	pte_t entry = mk_pte(walk->reuse_page, pgprot);
-	struct page *page = pte_page(*pte);
-
-	list_add_tail(&page->lru, walk->vmemmap_pages);
-	set_pte_at(&init_mm, addr, pte, entry);
-}
-
-/*
- * How many struct page structs need to be reset. When we reuse the head
- * struct page, the special metadata (e.g. page->flags or page->mapping)
- * cannot copy to the tail struct page structs. The invalid value will be
- * checked in the free_tail_pages_check(). In order to avoid the message
- * of "corrupted mapping in tail page". We need to reset at least 3 (one
- * head struct page struct and two tail struct page structs) struct page
- * structs.
- */
-#define NR_RESET_STRUCT_PAGE		3
-
-static inline void reset_struct_pages(struct page *start)
-{
-	int i;
-	struct page *from = start + NR_RESET_STRUCT_PAGE;
-
-	for (i = 0; i < NR_RESET_STRUCT_PAGE; i++)
-		memcpy(start + i, from, sizeof(*from));
-}
-
-static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
-				struct vmemmap_remap_walk *walk)
-{
-	pgprot_t pgprot = PAGE_KERNEL;
-	struct page *page;
-	void *to;
-
-	BUG_ON(pte_page(*pte) != walk->reuse_page);
-
-	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
-	list_del(&page->lru);
-	to = page_to_virt(page);
-	copy_page(to, (void *)walk->reuse_addr);
-	reset_struct_pages(to);
-
-	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
-}
-
-/**
- * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
- *			to the page which @reuse is mapped to, then free vmemmap
- *			which the range are mapped to.
- * @start:	start address of the vmemmap virtual address range that we want
- *		to remap.
- * @end:	end address of the vmemmap virtual address range that we want to
- *		remap.
- * @reuse:	reuse address.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-int vmemmap_remap_free(unsigned long start, unsigned long end,
-		       unsigned long reuse)
-{
-	int ret;
-	LIST_HEAD(vmemmap_pages);
-	struct vmemmap_remap_walk walk = {
-		.remap_pte	= vmemmap_remap_pte,
-		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
-	};
-
-	/*
-	 * In order to make remapping routine most efficient for the huge pages,
-	 * the routine of vmemmap page table walking has the following rules
-	 * (see more details from the vmemmap_pte_range()):
-	 *
-	 * - The range [@start, @end) and the range [@reuse, @reuse + PAGE_SIZE)
-	 *   should be continuous.
-	 * - The @reuse address is part of the range [@reuse, @end) that we are
-	 *   walking which is passed to vmemmap_remap_range().
-	 * - The @reuse address is the first in the complete range.
-	 *
-	 * So we need to make sure that @start and @reuse meet the above rules.
-	 */
-	BUG_ON(start - reuse != PAGE_SIZE);
-
-	mmap_read_lock(&init_mm);
-	ret = vmemmap_remap_range(reuse, end, &walk);
-	if (ret && walk.nr_walked) {
-		end = reuse + walk.nr_walked * PAGE_SIZE;
-		/*
-		 * vmemmap_pages contains pages from the previous
-		 * vmemmap_remap_range call which failed.  These
-		 * are pages which were removed from the vmemmap.
-		 * They will be restored in the following call.
-		 */
-		walk = (struct vmemmap_remap_walk) {
-			.remap_pte	= vmemmap_restore_pte,
-			.reuse_addr	= reuse,
-			.vmemmap_pages	= &vmemmap_pages,
-		};
-
-		vmemmap_remap_range(reuse, end, &walk);
-	}
-	mmap_read_unlock(&init_mm);
-
-	free_vmemmap_page_list(&vmemmap_pages);
-
-	return ret;
-}
-
-static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
-				   gfp_t gfp_mask, struct list_head *list)
-{
-	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
-	int nid = page_to_nid((struct page *)start);
-	struct page *page, *next;
-
-	while (nr_pages--) {
-		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
-			goto out;
-		list_add_tail(&page->lru, list);
-	}
-
-	return 0;
-out:
-	list_for_each_entry_safe(page, next, list, lru)
-		__free_pages(page, 0);
-	return -ENOMEM;
-}
-
-/**
- * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
- *			 to the page which is from the @vmemmap_pages
- *			 respectively.
- * @start:	start address of the vmemmap virtual address range that we want
- *		to remap.
- * @end:	end address of the vmemmap virtual address range that we want to
- *		remap.
- * @reuse:	reuse address.
- * @gfp_mask:	GFP flag for allocating vmemmap pages.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			unsigned long reuse, gfp_t gfp_mask)
-{
-	LIST_HEAD(vmemmap_pages);
-	struct vmemmap_remap_walk walk = {
-		.remap_pte	= vmemmap_restore_pte,
-		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
-	};
-
-	/* See the comment in the vmemmap_remap_free(). */
-	BUG_ON(start - reuse != PAGE_SIZE);
-
-	if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
-		return -ENOMEM;
-
-	mmap_read_lock(&init_mm);
-	vmemmap_remap_range(reuse, end, &walk);
-	mmap_read_unlock(&init_mm);
-
-	return 0;
-}
-#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
 /*
  * Allocate a block of memory to be used to back the virtual memory map
-- 
2.11.0

