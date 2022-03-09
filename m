Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA204D27D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiCIELN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiCIEK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:10:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9661012E74A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:10:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z11so896278pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 20:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ez1m8ji0DENiS3MZwucDKYsoMBLcsLLT3XVhtPvMlT4=;
        b=U5A/W2GZbKyK6yaa2yDxAGx2o+Cr+9AiMdh8ZAWJh40RnGqF89ukEyA1NFGPpGZILo
         KdiPP24EazLqpZGSQu+upKmGQ/T5zQBMJhhiA1ItBobsUjPCieUIIqrN62hqlK6H+KPA
         1+ZHQjG+kQ2aQWdJ5F+ZwMXTeNt0L3A0Y7JFUFMYntWaTSIy+IsFON/WO4ouC7vt8ET3
         CMxF27zzSkEHU+18I7vr21yOMEGDj2h7B230iyFqS67I0KTMtMKl2ZHg1NKkijS1KlsA
         ZlCv723S3/CeLxglvJn8d5lFzvzjCBfOiOCzcVHQizcRONlZQKPY5g1Q7KZUDEGJrruU
         5Dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ez1m8ji0DENiS3MZwucDKYsoMBLcsLLT3XVhtPvMlT4=;
        b=dnzsBab4knTvamsEHE5bmUxVtPa9IgM5NFffwQoYuHuGojutFMEEUqOgSG3V9lHque
         9wvNKZyCcIimY4tuqiK2aCQ7jdevUQg3LewJoVqOogRh4DJi/xt9USwXvpzCayosCD+K
         LlerAxLGBBkzXHzyKpJTLDdwGviQ1fWYRpIs5Au+I1sVgqop/vgYtwowvzYpzsKGDEHU
         lnqLpqvh6cJS9ZDEPpgfUoXfbjIQuapUAjpQ7oKW6f2M4hfld0hMIoR6ZCIvh4+mEdS4
         hgneG79GQEnCYnrKBy8PH0tCnXmEbjxj6vDVWjHSXzPZ0V5x3KTKFYPgNy3J1GM0VOBw
         Yxug==
X-Gm-Message-State: AOAM530sKQmi//3onrBHLk//OzC+gdk3gJb1HJQ6q1UQQNZC23doU5Ti
        T3uXBVyKlGTlRTbIWC9wt+k=
X-Google-Smtp-Source: ABdhPJznzV9dNAlSFw12FJZ84elyTwyB9gevjJEG0RSovL4CfmAS8zF7YMvbufKjXT+UMn7QeqpMpQ==
X-Received: by 2002:a17:90a:a887:b0:1bc:388a:329f with SMTP id h7-20020a17090aa88700b001bc388a329fmr8315963pjq.17.1646798999891;
        Tue, 08 Mar 2022 20:09:59 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm604343pgr.24.2022.03.08.20.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 20:09:59 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v3 4/5] mm/mprotect: do not flush on permission promotion
Date:   Tue,  8 Mar 2022 20:10:42 -0800
Message-Id: <20220309041043.302261-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309041043.302261-1-namit@vmware.com>
References: <20220309041043.302261-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Currently, using mprotect() to unprotect a memory region or uffd to
unprotect a memory region causes a TLB flush. At least on x86, as
protection is promoted, no TLB flush is needed.

Add an arch-specific pte_may_need_flush() which tells whether a TLB
flush is needed based on the old PTE and the new one. Implement an x86
pte_may_need_flush().

For x86, besides the simple logic that PTE protection promotion or
changes of software bits does require a flush, also add logic that
considers the dirty-bit. If the dirty-bit is clear and write-protect is
set, no TLB flush is needed, as x86 updates the dirty-bit atomically
on write, and if the bit is clear, the PTE is reread.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pgtable_types.h |  2 +
 arch/x86/include/asm/tlbflush.h      | 82 ++++++++++++++++++++++++++++
 include/asm-generic/tlb.h            | 14 +++++
 mm/huge_memory.c                     |  9 +--
 mm/mprotect.c                        |  3 +-
 5 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..8668bc661026 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -110,9 +110,11 @@
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
 #define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
+#define _PAGE_SOFTW4	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW4)
 #else
 #define _PAGE_NX	(_AT(pteval_t, 0))
 #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
+#define _PAGE_SOFTW4	(_AT(pteval_t, 0))
 #endif
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 98fa0a114074..ec01e6cff137 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -259,6 +259,88 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+/*
+ * The enabled_mask tells which bits that were present and gets cleared require
+ * flush.
+ *
+ * The disabled_mask tells which bits that were missing and gets set require
+ * flush.
+ *
+ * All the other bits except the ignored bits will require a flush no matter if
+ * they gets set or cleared.
+ *
+ * This function ignores the global bit, as it is used for protnone. This
+ * function should therefore not be used if the global bit might really be
+ * cleared.
+ *
+ * The function allows to ignore_access flags (provide _PAGE_ACCESS as argument
+ * to do so). The expected use is that the access bit would be ignored for PTEs
+ * but not for PMDs. That is the way the kernel perform TLB flushes after
+ * updates of the access-bit in other situations.
+ */
+static inline bool pte_flags_need_flush(unsigned long oldflags,
+					unsigned long newflags,
+					pteval_t ignore_access)
+{
+	const pteval_t ignore_mask = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
+		_PAGE_SOFTW3 | _PAGE_SOFTW4 | _PAGE_GLOBAL | ignore_access;
+	const pteval_t enable_mask = _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT |
+				     (_PAGE_ACCESSED & ~ignore_access);
+	const pteval_t disable_mask = _PAGE_NX;
+	unsigned long diff = oldflags ^ newflags;
+
+	VM_BUG_ON(ignore_access != 0 && ignore_access != _PAGE_ACCESSED);
+
+	return diff & ((oldflags & enable_mask) |
+		       (newflags & disable_mask) |
+		       ~(enable_mask | disable_mask | ignore_mask));
+}
+
+/*
+ * pte_needs_flush() checks whether permissions were demoted and require a
+ * flush. It should only be used for userspace PTEs.
+ */
+static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
+{
+	/* !PRESENT -> * ; no need for flush */
+	if (!pte_present(oldpte))
+		return false;
+
+	/* PRESENT -> !PRESENT ; needs flush */
+	if (!pte_present(newpte))
+		return true;
+
+	/* PFN changed ; needs flush */
+	if (pte_pfn(oldpte) != pte_pfn(newpte))
+		return true;
+
+	return pte_flags_need_flush(pte_flags(oldpte), pte_flags(newpte),
+				    _PAGE_ACCESSED);
+}
+#define pte_needs_flush pte_needs_flush
+
+/*
+ * huge_pmd_needs_flush() checks whether permissions were demoted and
+ * require a flush. It should only be used for userspace huge PMDs.
+ */
+static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
+{
+	/* !PRESENT -> * ; no need for flush */
+	if (!pmd_present(oldpmd))
+		return false;
+
+	/* PRESENT -> !PRESENT ; needs flush */
+	if (!pmd_present(newpmd))
+		return true;
+
+	/* PFN changed ; needs flush */
+	if (pmd_pfn(oldpmd) != pmd_pfn(newpmd))
+		return true;
+
+	return pte_flags_need_flush(pmd_flags(oldpmd), pmd_flags(newpmd), 0);
+}
+#define huge_pmd_needs_flush huge_pmd_needs_flush
+
 #endif /* !MODULE */
 
 static inline void __native_tlb_flush_global(unsigned long cr4)
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fd7feb5c7894..3a30e23fa35d 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -654,6 +654,20 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
 	} while (0)
 #endif
 
+#ifndef pte_needs_flush
+static inline bool pte_needs_flush(pte_t oldpte, pte_t newpte)
+{
+	return true;
+}
+#endif
+
+#ifndef huge_pmd_needs_flush
+static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
+{
+	return true;
+}
+#endif
+
 #endif /* CONFIG_MMU */
 
 #endif /* _ASM_GENERIC__TLB_H */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d58a5b498011..51b0f3cb1ba0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1698,7 +1698,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
-	pmd_t entry;
+	pmd_t oldpmd, entry;
 	bool preserve_write;
 	int ret;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
@@ -1784,9 +1784,9 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * pmdp_invalidate() is required to make sure we don't miss
 	 * dirty/young flags set by hardware.
 	 */
-	entry = pmdp_invalidate(vma, addr, pmd);
+	oldpmd = pmdp_invalidate(vma, addr, pmd);
 
-	entry = pmd_modify(entry, newprot);
+	entry = pmd_modify(oldpmd, newprot);
 	if (preserve_write)
 		entry = pmd_mk_savedwrite(entry);
 	if (uffd_wp) {
@@ -1803,7 +1803,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 
-	tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
+	if (huge_pmd_needs_flush(oldpmd, entry))
+		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
 
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index f9730bac2d78..97967d589ddb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -152,7 +152,8 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
-			tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
+			if (pte_needs_flush(oldpte, ptent))
+				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
-- 
2.25.1

