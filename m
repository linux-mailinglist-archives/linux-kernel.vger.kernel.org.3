Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D183A58CAE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbiHHO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243455AbiHHO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:57:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5054E12ACA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659970656; x=1691506656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NvohfDahb9Ga60b7Ddo8K4Xaj4ChBuprZ05/+jYnTA0=;
  b=Eamz4A1bGREqvA1EKPoWGZorR+PJOmNPCE6tw+Fn9cEzP76x8hfPT1Xn
   hld0XXtkhsOBMxx6U/QmA8KilirVpvMq6leB4cHrvIUVQNRMTfjXiTDo6
   M8tGYb7id7SAzrDpO/aZK79VmS6lchdtPskMOsNRJ24tksOgyAXMFN2vN
   MlwS+WGKhjozYHriy2NAxFm65tM6imhFvfWs8I6wYF6PYiCIEUwHQMqZa
   v2kSE7oJSxeOYuEN8EAWv36vg1THTNGbUSnPNoEb9wcG0i+ZgWDf1r29I
   8sMv4dGy09HIJvEeXECgJ076XkE9+wwOLlQ3o0qk+F3Hw5RlNTzDhXt4Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270996888"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270996888"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663980501"
Received: from ziqianlu-desk2.sh.intel.com ([10.238.2.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:34 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 2/4] x86/mm/cpa: merge splitted direct mapping when possible
Date:   Mon,  8 Aug 2022 22:56:47 +0800
Message-Id: <20220808145649.2261258-3-aaron.lu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808145649.2261258-1-aaron.lu@intel.com>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, Linux has direct mapping of almost all physical memory. For
performance reasons, this mapping is usually set as large page like 2M
or 1G per hardware's capability with read, write and non-execute
protection.

There are cases where some pages have to change their protection to RO
and eXecutable, like pages that host module code or bpf prog. When these
pages' protection are changed, the corresponding large mapping that
cover these pages will have to be splitted into 4K first and then individual
4k page's protection changed accordingly, i.e. unaffected pages keep their
original protection as RW and NX while affected pages' protection changed
to RO and X.

There is a problem due to this split: the large mapping will remain
splitted even after the affected pages' protection are changed back to
RW and NX, like when the module is unloaded or bpf progs are freed.
After system runs a long time, there can be more and more large mapping
being splitted, causing more and more dTLB misses and overall system
performance getting hurt.

This patch tries to restore splitted large mapping by tracking how
many entries of the splitted small mapping page table have the same
protection bits and once that number becomes PTRS_PER_PTE, this small
mapping page table can be released with its upper level page table
entry pointing directly to a large page.

Testing: see patch4 for detailed testing.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/mm/pat/set_memory.c | 184 +++++++++++++++++++++++++++++++++--
 include/linux/mm_types.h     |   6 ++
 include/linux/page-flags.h   |   6 ++
 3 files changed, 189 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 33657a54670a..fea2c70ff37f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -718,13 +718,89 @@ phys_addr_t slow_virt_to_phys(void *__virt_addr)
 }
 EXPORT_SYMBOL_GPL(slow_virt_to_phys);
 
+static void merge_splitted_mapping(struct page *pgt, int level);
+static void set_pte_adjust_nr_same_prot(pte_t *kpte, int level, pte_t pte)
+{
+	struct page *pgt = virt_to_page(kpte);
+	pgprot_t old_prot, new_prot;
+	int i;
+
+	/* The purpose of tracking entries with same_prot is to hopefully
+	 * mege splitted small mappings to large ones. Since only 2M and
+	 * 1G mapping are supported, there is no need tracking for page
+	 * tables of level > 2M.
+	 */
+	if (!PageSplitpgt(pgt) || level > PG_LEVEL_2M) {
+		set_pte(kpte, pte);
+		return;
+	}
+
+	/* get old protection before kpte is updated */
+	if (level == PG_LEVEL_4K) {
+		old_prot = pte_pgprot(*kpte);
+		new_prot = pte_pgprot(pte);
+	} else {
+		old_prot = pmd_pgprot(*(pmd_t *)kpte);
+		new_prot = pmd_pgprot(*(pmd_t *)&pte);
+	}
+
+	set_pte(kpte, pte);
+
+	if (pgprot_val(pgt->same_prot) != pgprot_val(old_prot) &&
+	    pgprot_val(pgt->same_prot) == pgprot_val(new_prot))
+		pgt->nr_same_prot++;
+
+	if (pgprot_val(pgt->same_prot) == pgprot_val(old_prot) &&
+	    pgprot_val(pgt->same_prot) != pgprot_val(new_prot))
+		pgt->nr_same_prot--;
+
+	if (unlikely(pgt->nr_same_prot == 0)) {
+		pte_t *entry = page_address(pgt);
+
+		/*
+		 * Now all entries' prot have changed, check again
+		 * to see if all entries have the same new prot.
+		 * Use the 1st entry's prot as the new pgt->same_prot.
+		 */
+		if (level == PG_LEVEL_4K)
+			pgt->same_prot = pte_pgprot(*entry);
+		else
+			pgt->same_prot = pmd_pgprot(*(pmd_t *)entry);
+
+		for (i = 0; i < PTRS_PER_PTE; i++, entry++) {
+			pgprot_t prot;
+
+			if (level == PG_LEVEL_4K)
+				prot = pte_pgprot(*entry);
+			else
+				prot = pmd_pgprot(*(pmd_t *)entry);
+
+			if (pgprot_val(prot) == pgprot_val(pgt->same_prot))
+				pgt->nr_same_prot++;
+		}
+	}
+
+	/*
+	 * If this splitted page table's entries all have the same
+	 * protection now, try merge it. Note that for a PMD level
+	 * page table, if all entries are pointing to PTE page table,
+	 * no merge can be done.
+	 */
+	if (unlikely(pgt->nr_same_prot == PTRS_PER_PTE &&
+		     (pgprot_val(pgt->same_prot) & _PAGE_PRESENT) &&
+		     (level == PG_LEVEL_4K ||
+		      pgprot_val(pgt->same_prot) & _PAGE_PSE)))
+		merge_splitted_mapping(pgt, level);
+
+}
+
 /*
  * Set the new pmd in all the pgds we know about:
  */
-static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
+static void __set_pmd_pte(pte_t *kpte, int level, unsigned long address, pte_t pte)
 {
 	/* change init_mm */
-	set_pte_atomic(kpte, pte);
+	set_pte_adjust_nr_same_prot(kpte, level, pte);
 #ifdef CONFIG_X86_32
 	if (!SHARED_KERNEL_PMD) {
 		struct page *page;
@@ -739,12 +815,68 @@ static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 			p4d = p4d_offset(pgd, address);
 			pud = pud_offset(p4d, address);
 			pmd = pmd_offset(pud, address);
-			set_pte_atomic((pte_t *)pmd, pte);
+			set_pte_adjust_nr_same_prot((pte_t *)pmd, level, pte);
 		}
 	}
 #endif
 }
 
+static void merge_splitted_mapping(struct page *pgt, int level)
+{
+	pte_t *kpte = page_address(pgt);
+	pgprot_t pte_prot, pmd_prot;
+	unsigned long address;
+	unsigned long pfn;
+	pte_t pte;
+	pud_t pud;
+
+	switch (level) {
+	case PG_LEVEL_4K:
+		pte_prot = pte_pgprot(*kpte);
+		pmd_prot = pgprot_4k_2_large(pte_prot);
+		pgprot_val(pmd_prot) |= _PAGE_PSE;
+		pfn = pte_pfn(*kpte);
+		pte = pfn_pte(pfn, pmd_prot);
+
+		/*
+		 * update upper level kpte.
+		 * Note that further merge can happen if all PMD table's
+		 * entries have the same protection bits after this change.
+		 */
+		address = (unsigned long)page_address(pfn_to_page(pfn));
+		__set_pmd_pte(pgt->upper_kpte, level + 1, address, pte);
+		break;
+	case PG_LEVEL_2M:
+		pfn = pmd_pfn(*(pmd_t *)kpte);
+		pmd_prot = pmd_pgprot(*(pmd_t *)kpte);
+		pud = pfn_pud(pfn, pmd_prot);
+		set_pud(pgt->upper_kpte, pud);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	/*
+	 * Current kernel did flush_tlb_all() when splitting a large page
+	 * inside pgd_lock because:
+	 * - an errata of Atom AAH41; as well as
+	 * - avoid another cpu simultaneously changing the just splitted
+	 *   large page's attr.
+	 * The first does not require a full tlb flush according to
+	 * commit 211b3d03c7400("x86: work around Fedora-11 x86-32 kernel
+	 * failures on Intel Atom CPUs") while the 2nd can be already
+	 * achieved by cpa_lock. commit c0a759abf5a68("x86/mm/cpa: Move
+	 * flush_tlb_all()") simplified the code by doing a full tlb flush
+	 * inside pgd_lock. For the same reason, I also did a full tlb
+	 * flush inside pgd_lock after doing a merge.
+	 */
+	flush_tlb_all();
+
+	__ClearPageSplitpgt(pgt);
+	__free_page(pgt);
+}
+
 static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
 {
 	/*
@@ -901,9 +1033,10 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 
 	/* All checks passed. Update the large page mapping. */
 	new_pte = pfn_pte(old_pfn, new_prot);
-	__set_pmd_pte(kpte, address, new_pte);
+	__set_pmd_pte(kpte, level, address, new_pte);
 	cpa->flags |= CPA_FLUSHTLB;
 	cpa_inc_lp_preserved(level);
+
 	return 0;
 }
 
@@ -1023,6 +1156,11 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	for (i = 0; i < PTRS_PER_PTE; i++, pfn += pfninc, lpaddr += lpinc)
 		split_set_pte(cpa, pbase + i, pfn, ref_prot, lpaddr, lpinc);
 
+	__SetPageSplitpgt(base);
+	base->upper_kpte = kpte;
+	base->same_prot = ref_prot;
+	base->nr_same_prot = PTRS_PER_PTE;
+
 	if (virt_addr_valid(address)) {
 		unsigned long pfn = PFN_DOWN(__pa(address));
 
@@ -1037,7 +1175,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * pagetable protections, the actual ptes set above control the
 	 * primary protection behavior:
 	 */
-	__set_pmd_pte(kpte, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
+	__set_pmd_pte(kpte, level, address, mk_pte(base, __pgprot(_KERNPG_TABLE)));
 
 	/*
 	 * Do a global flush tlb after splitting the large page
@@ -1508,6 +1646,23 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
 	}
 }
 
+/*
+ * When debug_pagealloc_enabled():
+ * - direct map will not use large page mapping;
+ * - kernel highmap can still use large mapping.
+ * When !debug_pagealloc_enabled(): both direct map and kernel highmap
+ * can use large page mapping.
+ *
+ * When large page mapping is used, it can be splitted due to reasons
+ * like protection change and thus, it is also possible a merge can
+ * happen for that splitted small mapping page table page.
+ */
+static bool subject_to_merge(unsigned long addr)
+{
+	return !debug_pagealloc_enabled() ||
+		within(addr, (unsigned long)_text, _brk_end);
+}
+
 static int __change_page_attr(struct cpa_data *cpa, int primary)
 {
 	unsigned long address;
@@ -1526,10 +1681,23 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		return __cpa_process_fault(cpa, address, primary);
 
 	if (level == PG_LEVEL_4K) {
-		pte_t new_pte;
+		pte_t new_pte, *tmp;
 		pgprot_t new_prot = pte_pgprot(old_pte);
 		unsigned long pfn = pte_pfn(old_pte);
 
+		if (subject_to_merge(address)) {
+			spin_lock(&pgd_lock);
+			/*
+			 * Check for races, another CPU might have merged
+			 * this page up already.
+			 */
+			tmp = _lookup_address_cpa(cpa, address, &level);
+			if (tmp != kpte) {
+				spin_unlock(&pgd_lock);
+				goto repeat;
+			}
+		}
+
 		pgprot_val(new_prot) &= ~pgprot_val(cpa->mask_clr);
 		pgprot_val(new_prot) |= pgprot_val(cpa->mask_set);
 
@@ -1551,10 +1719,12 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		 * Do we really change anything ?
 		 */
 		if (pte_val(old_pte) != pte_val(new_pte)) {
-			set_pte_atomic(kpte, new_pte);
+			set_pte_adjust_nr_same_prot(kpte, level, new_pte);
 			cpa->flags |= CPA_FLUSHTLB;
 		}
 		cpa->numpages = 1;
+		if (subject_to_merge(address))
+			spin_unlock(&pgd_lock);
 		return 0;
 	}
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c29ab4c0cd5c..6124c575fdad 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -160,6 +160,12 @@ struct page {
 			spinlock_t ptl;
 #endif
 		};
+		struct {        /* splitted page table pages */
+			void *upper_kpte;		/* compound_head */
+			int nr_same_prot;
+			unsigned long _split_pt_pad;	/* mapping */
+			pgprot_t same_prot;
+		};
 		struct {	/* ZONE_DEVICE pages */
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e66f7aa3191d..3fe395dd7dfc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -942,6 +942,7 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PG_offline	0x00000100
 #define PG_table	0x00000200
 #define PG_guard	0x00000400
+#define PG_splitpgt	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -1012,6 +1013,11 @@ PAGE_TYPE_OPS(Table, table)
  */
 PAGE_TYPE_OPS(Guard, guard)
 
+/*
+ * Marks pages in use as splitted page tables
+ */
+PAGE_TYPE_OPS(Splitpgt, splitpgt)
+
 extern bool is_free_buddy_page(struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
-- 
2.37.1

