Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A46578B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiGRThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGRThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D02C11C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c6so9964741pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxBEaDHDH5iA0Z434ccAU48aZkF7F2lqG0NFB8y3nyA=;
        b=my81onu1OySYd5QwEPgIH8cJCe9cT3LzQcW5my3gA9nCFtR9e6T1J/1lK1jjSII47b
         XzLYG4wNMKvD5zk7A9NXnPcVfA8pkuT9KKksuuwF5ZQ6O6UnPvamyCGOQ2LJPk9KXu9L
         kgMe/KjW3ZnacjULEPlULSqWBoMSvDgcVQWCZ9dS7E3A/VHBu+CNLPn3udaU8MDL3n3e
         YNJ5VbOlgdKf/OCAkw4+dhshaaH/47yLYrsGZocGFV5uh828uMeXJTxExa4skk442DN4
         6DVjWBCvEQYvI/SVz4Bd5YjpqSzAHvvVxTopGeS4OpNTTVU93jEq1ZlERdDACOhI0soH
         TYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxBEaDHDH5iA0Z434ccAU48aZkF7F2lqG0NFB8y3nyA=;
        b=Oa1qxDaXXgvzNplHvOLdLNPYTNy2FL3KIwFA4OWTQFHdS4cnTKfEYwyncR31NwprYN
         00vVyeH44K5gF9OGE3x2K4+K4QQdqxlPEaxRh93zcWsxU8/VFrPPLzM2SveQGP97Q0bX
         lYNqdbjxtoi5hKrUNaLwAK9fPfXp9WaP0aKYdRneRucWBGccaX+9gNlI5zGyEWnD1HKl
         dop+M8fbgH+17rKha7+jPDK/a6MHStI5hFPmA/E5M99gcrq0gizAAb/0xrval0Icp/9A
         Fgl8hVyfZ2WMTXcJvphgycKgyJlKP4AIs5lGLGeWf0PlEODCpn+dv6WJxQtF6nRJbqmL
         zS2w==
X-Gm-Message-State: AJIora+KmJBfgZMOlQT0ol1lTtiZFORogmJXvZ4g9y5qDViuJ5CzncL7
        P/MBAKSbzvGyy6vB9WqnFCw=
X-Google-Smtp-Source: AGRyM1ukZTqzinGmKpw0KyjuFIJDx0R0wkssnJUHMEvYck6xu6OkrvRKPvj8jOGhO6Icx6YjPWbjsw==
X-Received: by 2002:a17:902:ab13:b0:16c:bc10:85a9 with SMTP id ik19-20020a170902ab1300b0016cbc1085a9mr21694648plb.7.1658173036246;
        Mon, 18 Jul 2022 12:37:16 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:15 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 09/14] mm: introduce relaxed TLB flushes
Date:   Mon, 18 Jul 2022 05:02:07 -0700
Message-Id: <20220718120212.3180-10-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120212.3180-1-namit@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Introduce the concept of strict and relaxed TLB flushes. Relaxed TLB
flushes are TLB flushes that can be skipped but might lead to degraded
performance. It is down to arch code (in the next patches) to deal with
relaxed flushes correctly. One such behavior is flushing the local TLB
eagerly and remote TLBs lazily.

Track whether a flush is strict in the mmu_gather struct and introduce
the required constants for tracking.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h |  41 ++++++------
 include/asm-generic/tlb.h       | 114 ++++++++++++++++++--------------
 include/linux/mm_types.h        |   6 ++
 mm/huge_memory.c                |   7 +-
 mm/hugetlb.c                    |   2 +-
 mm/mmu_gather.c                 |   1 +
 mm/mprotect.c                   |   8 ++-
 mm/rmap.c                       |   2 +-
 8 files changed, 107 insertions(+), 74 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 4af5579c7ef7..77d4810e5a5d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -259,7 +259,7 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
-static inline bool pte_flags_need_flush(unsigned long oldflags,
+static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)
 {
@@ -290,71 +290,72 @@ static inline bool pte_flags_need_flush(unsigned long oldflags,
 		diff &= ~_PAGE_ACCESSED;
 
 	/*
-	 * Did any of the 'flush_on_clear' flags was clleared set from between
-	 * 'oldflags' and 'newflags'?
+	 * Did any of the 'flush_on_clear' flags was cleared between 'oldflags'
+	 * and 'newflags'?
 	 */
 	if (diff & oldflags & flush_on_clear)
-		return true;
+		return PTE_FLUSH_STRICT;
 
 	/* Flush on modified flags. */
 	if (diff & flush_on_change)
-		return true;
+		return PTE_FLUSH_STRICT;
 
 	/* Ensure there are no flags that were left behind */
 	if (IS_ENABLED(CONFIG_DEBUG_VM) &&
 	    (diff & ~(flush_on_clear | software_flags | flush_on_change))) {
 		VM_WARN_ON_ONCE(1);
-		return true;
+		return PTE_FLUSH_STRICT;
 	}
 
-	return false;
+	return PTE_FLUSH_NONE;
 }
 
 /*
- * pte_needs_flush() checks whether permissions were demoted and require a
- * flush. It should only be used for userspace PTEs.
+ * pte_flush_type() checks whether permissions were demoted or promoted and
+ * whether a strict or relaxed TLB flush is need. It should only be used on
+ * userspace PTEs.
  */
-static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
+static inline enum pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte)
 {
 	/* !PRESENT -> * ; no need for flush */
 	if (!(pte_flags(oldpte) & _PAGE_PRESENT))
-		return false;
+		return PTE_FLUSH_NONE;
 
 	/* PFN changed ; needs flush */
 	if (pte_pfn(oldpte) != pte_pfn(newpte))
-		return true;
+		return PTE_FLUSH_STRICT;
 
 	/*
 	 * check PTE flags; ignore access-bit; see comment in
 	 * ptep_clear_flush_young().
 	 */
-	return pte_flags_need_flush(pte_flags(oldpte), pte_flags(newpte),
+	return pte_flags_flush_type(pte_flags(oldpte), pte_flags(newpte),
 				    true);
 }
-#define pte_needs_flush pte_needs_flush
+#define pte_flush_type pte_flush_type
 
 /*
- * huge_pmd_needs_flush() checks whether permissions were demoted and require a
+ * huge_pmd_flush_type() checks whether permissions were demoted and require a
  * flush. It should only be used for userspace huge PMDs.
  */
-static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
+static inline enum pte_flush_type huge_pmd_flush_type(pmd_t oldpmd, pmd_t newpmd)
 {
 	/* !PRESENT -> * ; no need for flush */
 	if (!(pmd_flags(oldpmd) & _PAGE_PRESENT))
-		return false;
+		return PTE_FLUSH_NONE;
 
 	/* PFN changed ; needs flush */
 	if (pmd_pfn(oldpmd) != pmd_pfn(newpmd))
-		return true;
+		return PTE_FLUSH_STRICT;
 
 	/*
 	 * check PMD flags; do not ignore access-bit; see
 	 * pmdp_clear_flush_young().
 	 */
-	return pte_flags_need_flush(pmd_flags(oldpmd), pmd_flags(newpmd),
+	return pte_flags_flush_type(pmd_flags(oldpmd), pmd_flags(newpmd),
 				    false);
 }
-#define huge_pmd_needs_flush huge_pmd_needs_flush
+#define huge_pmd_flush_type huge_pmd_flush_type
 
 #endif /* !MODULE */
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index ff3e82553a76..07b3eb8caf63 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -289,6 +289,11 @@ struct mmu_gather {
 	unsigned int		vma_exec : 1;
 	unsigned int		vma_huge : 1;
 
+	/*
+	 * wheteher we made flushing strict (add protection) or changed
+	 * mappings.
+	 */
+	unsigned int		strict : 1;
 	unsigned int		batch_count;
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
@@ -325,6 +330,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
 	tlb->cleared_pmds = 0;
 	tlb->cleared_puds = 0;
 	tlb->cleared_p4ds = 0;
+	tlb->strict = 0;
 	/*
 	 * Do not reset mmu_gather::vma_* fields here, we do not
 	 * call into tlb_start_vma() again to set them if there is an
@@ -518,31 +524,43 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
  * and set corresponding cleared_*.
  */
 static inline void tlb_flush_pte_range(struct mmu_gather *tlb,
-				     unsigned long address, unsigned long size)
+				     unsigned long address, unsigned long size,
+				     bool strict)
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_ptes = 1;
+	if (strict)
+		tlb->strict = 1;
 }
 
 static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
-				     unsigned long address, unsigned long size)
+				     unsigned long address, unsigned long size,
+				     bool strict)
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_pmds = 1;
+	if (strict)
+		tlb->strict = 1;
 }
 
 static inline void tlb_flush_pud_range(struct mmu_gather *tlb,
-				     unsigned long address, unsigned long size)
+				     unsigned long address, unsigned long size,
+				     bool strict)
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_puds = 1;
+	if (strict)
+		tlb->strict = 1;
 }
 
 static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
-				     unsigned long address, unsigned long size)
+				     unsigned long address, unsigned long size,
+				     bool strict)
 {
 	__tlb_adjust_range(tlb, address, size);
 	tlb->cleared_p4ds = 1;
+	if (strict)
+		tlb->strict = 1;
 }
 
 #ifndef __tlb_remove_tlb_entry
@@ -556,24 +574,24 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
  * so we can later optimise away the tlb invalidate.   This helps when
  * userspace is unmapping already-unmapped pages, which happens quite a lot.
  */
-#define tlb_remove_tlb_entry(tlb, ptep, address)		\
-	do {							\
-		tlb_flush_pte_range(tlb, address, PAGE_SIZE);	\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+#define tlb_remove_tlb_entry(tlb, ptep, address)			\
+	do {								\
+		tlb_flush_pte_range(tlb, address, PAGE_SIZE, true);	\
+		__tlb_remove_tlb_entry(tlb, ptep, address);		\
 	} while (0)
 
-#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
-	do {							\
-		unsigned long _sz = huge_page_size(h);		\
-		if (_sz >= P4D_SIZE)				\
-			tlb_flush_p4d_range(tlb, address, _sz);	\
-		else if (_sz >= PUD_SIZE)			\
-			tlb_flush_pud_range(tlb, address, _sz);	\
-		else if (_sz >= PMD_SIZE)			\
-			tlb_flush_pmd_range(tlb, address, _sz);	\
-		else						\
-			tlb_flush_pte_range(tlb, address, _sz);	\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)		\
+	do {								\
+		unsigned long _sz = huge_page_size(h);			\
+		if (_sz >= P4D_SIZE)					\
+			tlb_flush_p4d_range(tlb, address, _sz, true);	\
+		else if (_sz >= PUD_SIZE)				\
+			tlb_flush_pud_range(tlb, address, _sz, true);	\
+		else if (_sz >= PMD_SIZE)				\
+			tlb_flush_pmd_range(tlb, address, _sz, true);	\
+		else							\
+			tlb_flush_pte_range(tlb, address, _sz, true);	\
+		__tlb_remove_tlb_entry(tlb, ptep, address);		\
 	} while (0)
 
 /**
@@ -586,7 +604,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 
 #define tlb_remove_pmd_tlb_entry(tlb, pmdp, address)			\
 	do {								\
-		tlb_flush_pmd_range(tlb, address, HPAGE_PMD_SIZE);	\
+		tlb_flush_pmd_range(tlb, address, HPAGE_PMD_SIZE, true);\
 		__tlb_remove_pmd_tlb_entry(tlb, pmdp, address);		\
 	} while (0)
 
@@ -600,7 +618,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 
 #define tlb_remove_pud_tlb_entry(tlb, pudp, address)			\
 	do {								\
-		tlb_flush_pud_range(tlb, address, HPAGE_PUD_SIZE);	\
+		tlb_flush_pud_range(tlb, address, HPAGE_PUD_SIZE, true);\
 		__tlb_remove_pud_tlb_entry(tlb, pudp, address);		\
 	} while (0)
 
@@ -623,52 +641,52 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
  */
 
 #ifndef pte_free_tlb
-#define pte_free_tlb(tlb, ptep, address)			\
-	do {							\
-		tlb_flush_pmd_range(tlb, address, PAGE_SIZE);	\
-		tlb->freed_tables = 1;				\
-		__pte_free_tlb(tlb, ptep, address);		\
+#define pte_free_tlb(tlb, ptep, address)				\
+	do {								\
+		tlb_flush_pmd_range(tlb, address, PAGE_SIZE, true);	\
+		tlb->freed_tables = 1;					\
+		__pte_free_tlb(tlb, ptep, address);			\
 	} while (0)
 #endif
 
 #ifndef pmd_free_tlb
-#define pmd_free_tlb(tlb, pmdp, address)			\
-	do {							\
-		tlb_flush_pud_range(tlb, address, PAGE_SIZE);	\
-		tlb->freed_tables = 1;				\
-		__pmd_free_tlb(tlb, pmdp, address);		\
+#define pmd_free_tlb(tlb, pmdp, address)				\
+	do {								\
+		tlb_flush_pud_range(tlb, address, PAGE_SIZE, true);	\
+		tlb->freed_tables = 1;					\
+		__pmd_free_tlb(tlb, pmdp, address);			\
 	} while (0)
 #endif
 
 #ifndef pud_free_tlb
-#define pud_free_tlb(tlb, pudp, address)			\
-	do {							\
-		tlb_flush_p4d_range(tlb, address, PAGE_SIZE);	\
-		tlb->freed_tables = 1;				\
-		__pud_free_tlb(tlb, pudp, address);		\
+#define pud_free_tlb(tlb, pudp, address)				\
+	do {								\
+		tlb_flush_p4d_range(tlb, address, PAGE_SIZE, true);	\
+		tlb->freed_tables = 1;					\
+		__pud_free_tlb(tlb, pudp, address);			\
 	} while (0)
 #endif
 
 #ifndef p4d_free_tlb
-#define p4d_free_tlb(tlb, pudp, address)			\
-	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
-		tlb->freed_tables = 1;				\
-		__p4d_free_tlb(tlb, pudp, address);		\
+#define p4d_free_tlb(tlb, pudp, address)				\
+	do {								\
+		__tlb_adjust_range(tlb, address, PAGE_SIZE, true);	\
+		tlb->freed_tables = 1;					\
+		__p4d_free_tlb(tlb, pudp, address);			\
 	} while (0)
 #endif
 
-#ifndef pte_needs_flush
-static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
+#ifndef pte_flush_type
+static inline struct pte_flush_type pte_flush_type(pte_t oldpte, pte_t newpte)
 {
-	return true;
+	return PTE_FLUSH_STRICT;
 }
 #endif
 
-#ifndef huge_pmd_needs_flush
-static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
+#ifndef huge_pmd_flush_type
+static inline bool huge_pmd_flush_type(pmd_t oldpmd, pmd_t newpmd)
 {
-	return true;
+	return PTE_FLUSH_STRICT;
 }
 #endif
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b961a29bf26..8825f1314a28 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -698,6 +698,12 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_finish_mmu(struct mmu_gather *tlb);
 
+enum pte_flush_type {
+	PTE_FLUSH_NONE		= 0,	/* not necessary */
+	PTE_FLUSH_STRICT	= 1,	/* required */
+	PTE_FLUSH_RELAXED	= 2,	/* can cause spurious page-faults */
+};
+
 struct vm_fault;
 
 /**
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 60d742c33de3..09e6608a6431 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1713,6 +1713,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
+	enum pte_flush_type flush_type;
 
 	tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 
@@ -1815,8 +1816,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 
-	if (huge_pmd_needs_flush(oldpmd, entry))
-		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
+	flush_type = huge_pmd_flush_type(oldpmd, entry);
+	if (flush_type != PTE_FLUSH_NONE)
+		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE,
+				    flush_type == PTE_FLUSH_STRICT);
 
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6621d3fe4991..9a667237a69a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5022,7 +5022,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
 			spin_unlock(ptl);
-			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
+			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE, true);
 			force_flush = true;
 			continue;
 		}
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index a71924bd38c0..9a8bd2f23543 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -348,6 +348,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
 		tlb->fullmm = 1;
 		__tlb_reset_range(tlb);
 		tlb->freed_tables = 1;
+		tlb->strict = 1;
 	}
 
 	tlb_flush_mmu(tlb);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 92bfb17dcb8a..ead20dc66d34 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -117,6 +117,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			pte_t ptent;
 			bool preserve_write = (prot_numa || try_change_writable) &&
 					       pte_write(oldpte);
+			enum pte_flush_type flush_type;
 
 			/*
 			 * Avoid trapping faults against the zero or KSM
@@ -200,8 +201,11 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			}
 
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
-			if (pte_needs_flush(oldpte, ptent))
-				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
+
+			flush_type = pte_flush_type(oldpte, ptent);
+			if (flush_type != PTE_FLUSH_NONE)
+				tlb_flush_pte_range(tlb, addr, PAGE_SIZE,
+						flush_type == PTE_FLUSH_STRICT);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 23997c387858..62f4b2a4f067 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -974,7 +974,7 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 			entry = pte_wrprotect(oldpte);
 			entry = pte_mkclean(entry);
 
-			if (pte_needs_flush(oldpte, entry) ||
+			if (pte_flush_type(oldpte, entry) != PTE_FLUSH_NONE ||
 			    mm_tlb_flush_pending(vma->vm_mm))
 				flush_tlb_page(vma, address);
 
-- 
2.25.1

