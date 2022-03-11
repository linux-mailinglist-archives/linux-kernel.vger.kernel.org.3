Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D674D68F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351076AbiCKTId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351030AbiCKTIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:08:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67431AEEC1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id bx5so8984170pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LbC4rtnRLWUDSZPi6OsRf96JKBt4h4/bksG42SwEfI=;
        b=F1UYwaa2k5vatuDJuzz8czxivrvp56a2zOz9FcOfcVATziO9z4q5kMuO7cJRq2TtBe
         z7GFG2fGc4dxuETRWnvjDMyBOF64QIOgqw2oaCkCvJWcSykgYGBnNsSW4fh2o9fZenFF
         YwN8hAdffgL/rLGFcgksKhO8B3nPirW4F/phDtgRlCKMcQMtnjke2e9NAQEw48KcVI3w
         YvJ/pSu91sc23Gq/1GI7VrOMzf/+7bly42aeBlatslU1jD312uEru8JFklm7NFNPZ52R
         truux597/4a+P1EwzXR27qQcXIOvOgoH7zMhl1THQJdS9ukveXzeZCEskrDgo2n9Ynqm
         JWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LbC4rtnRLWUDSZPi6OsRf96JKBt4h4/bksG42SwEfI=;
        b=x4te6RPO4256SGG249I6whfERK+QyycfThcHs39H/J62OGptRhNdxU7PYDSBSWxpQR
         7dRi/G8BIk2cEoAIb0Y+xFcVOijHxX+7kBI5aDzJdWjKjJ7ivJJjzriBkjV5EVIyeAre
         gQimTj/g7xES81PardiETtoadW8EpuuGiRIU+gaHeItP3FsLxhDiYi3CWPisxJG2483g
         /M+4fbcS+mbuX55Z9/dppf5osH6p3EYb2jNbvlBbAx8cc7gO1DGLeumqZ2lKY2npDAEs
         Ch+wEzPK5+LcCPXGB/TpR6gXlvjVNNwLfFfmJFLROGt9U/ZI7aK144hmks9j1NFj0w90
         fVAg==
X-Gm-Message-State: AOAM533lZWbzfJYwlKOqiq2v7+k+xJ/S7mhsTIAGZvhcv42V7jbPNowi
        Ce3YGVJMPGRxfo2xdYXMCuc=
X-Google-Smtp-Source: ABdhPJzBIwAITKATgJ5VordwQElrkdESdlbnwskA2egFvcHirC7gnYd7GSBtWEaXYC0PK6+HLCp6eA==
X-Received: by 2002:a17:902:b485:b0:14d:77eb:1675 with SMTP id y5-20020a170902b48500b0014d77eb1675mr11635498plr.147.1647025626903;
        Fri, 11 Mar 2022 11:07:06 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004f79f8f795fsm857329pfa.0.2022.03.11.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:07:06 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RESEND PATCH v3 3/5] mm/mprotect: use mmu_gather
Date:   Fri, 11 Mar 2022 11:07:47 -0800
Message-Id: <20220311190749.338281-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311190749.338281-1-namit@vmware.com>
References: <20220311190749.338281-1-namit@vmware.com>
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

change_pXX_range() currently does not use mmu_gather, but instead
implements its own deferred TLB flushes scheme. This both complicates
the code, as developers need to be aware of different invalidation
schemes, and prevents opportunities to avoid TLB flushes or perform them
in finer granularity.

The use of mmu_gather for modified PTEs has benefits in various
scenarios even if pages are not released. For instance, if only a single
page needs to be flushed out of a range of many pages, only that page
would be flushed. If a THP page is flushed, on x86 a single TLB invlpg
instruction can be used instead of 512 instructions (or a full TLB
flush, which would Linux would actually use by default). mprotect() over
multiple VMAs requires a single flush.

Use mmu_gather in change_pXX_range(). As the pages are not released,
only record the flushed range using tlb_flush_pXX_range().

Handle THP similarly and get rid of flush_cache_range() which becomes
redundant since tlb_start_vma() calls it when needed.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 fs/exec.c               |  6 ++-
 include/linux/huge_mm.h |  5 ++-
 include/linux/mm.h      |  5 ++-
 mm/huge_memory.c        | 10 ++++-
 mm/mprotect.c           | 93 ++++++++++++++++++++++-------------------
 mm/userfaultfd.c        |  6 ++-
 6 files changed, 75 insertions(+), 50 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a39108c1190a..1c46b7d7c32c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -759,6 +759,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_size;
 	unsigned long stack_expand;
 	unsigned long rlim_stack;
+	struct mmu_gather tlb;
 
 #ifdef CONFIG_STACK_GROWSUP
 	/* Limit stack size */
@@ -813,8 +814,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	vm_flags |= mm->def_flags;
 	vm_flags |= VM_STACK_INCOMPLETE_SETUP;
 
-	ret = mprotect_fixup(vma, &prev, vma->vm_start, vma->vm_end,
+	tlb_gather_mmu(&tlb, mm);
+	ret = mprotect_fixup(&tlb, vma, &prev, vma->vm_start, vma->vm_end,
 			vm_flags);
+	tlb_finish_mmu(&tlb);
+
 	if (ret)
 		goto out_unlock;
 	BUG_ON(prev != vma);
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2999190adc22..9a26bd10e083 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -36,8 +36,9 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma, pud_t *pud,
 		 unsigned long addr);
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		   unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd);
-int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
-		    pgprot_t newprot, unsigned long cp_flags);
+int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
+		    unsigned long cp_flags);
 vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 				   pgprot_t pgprot, bool write);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc69d2a69912..b2574bbdb76d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1969,10 +1969,11 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
 
-extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+extern unsigned long change_protection(struct mmu_gather *tlb,
+			      struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
 			      unsigned long cp_flags);
-extern int mprotect_fixup(struct vm_area_struct *vma,
+extern int mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
 			  unsigned long end, unsigned long newflags);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3557aabe86fe..d58a5b498011 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1692,8 +1692,9 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  *      or if prot_numa but THP migration is not supported
  *  - HPAGE_PMD_NR if protections changed and TLB flush necessary
  */
-int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, pgprot_t newprot, unsigned long cp_flags)
+int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
+		    unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
@@ -1704,6 +1705,8 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
+	tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
+
 	if (prot_numa && !thp_migration_supported())
 		return 1;
 
@@ -1799,6 +1802,9 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
+
+	tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE);
+
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
 unlock:
 	spin_unlock(ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..f9730bac2d78 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -33,12 +33,13 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
-static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+static unsigned long change_pte_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
@@ -49,6 +50,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
+	tlb_change_page_size(tlb, PAGE_SIZE);
+
 	/*
 	 * Can be called with only the mmap_lock for reading by
 	 * prot_numa so we must check the pmd isn't constantly
@@ -149,6 +152,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
+			tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
@@ -230,9 +234,9 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
-		pud_t *pud, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline unsigned long change_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -272,8 +276,12 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
-				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-							      newprot, cp_flags);
+				/*
+				 * change_huge_pmd() does not defer TLB flushes,
+				 * so no need to propagate the tlb argument.
+				 */
+				int nr_ptes = change_huge_pmd(tlb, vma, pmd,
+						addr, newprot, cp_flags);
 
 				if (nr_ptes) {
 					if (nr_ptes == HPAGE_PMD_NR) {
@@ -287,8 +295,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			}
 			/* fall through, the trans huge pmd just split */
 		}
-		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-					      cp_flags);
+		this_pages = change_pte_range(tlb, vma, pmd, addr, next,
+					      newprot, cp_flags);
 		pages += this_pages;
 next:
 		cond_resched();
@@ -302,9 +310,9 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	return pages;
 }
 
-static inline unsigned long change_pud_range(struct vm_area_struct *vma,
-		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline unsigned long change_pud_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -315,16 +323,16 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		pages += change_pmd_range(vma, pud, addr, next, newprot,
+		pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
 					  cp_flags);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
 }
 
-static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
-		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, unsigned long cp_flags)
+static inline unsigned long change_p4d_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -335,44 +343,40 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		pages += change_pud_range(vma, p4d, addr, next, newprot,
+		pages += change_pud_range(tlb, vma, p4d, addr, next, newprot,
 					  cp_flags);
 	} while (p4d++, addr = next, addr != end);
 
 	return pages;
 }
 
-static unsigned long change_protection_range(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end, pgprot_t newprot,
-		unsigned long cp_flags)
+static unsigned long change_protection_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	unsigned long next;
-	unsigned long start = addr;
 	unsigned long pages = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
-	flush_cache_range(vma, addr, end);
-	inc_tlb_flush_pending(mm);
+	tlb_start_vma(tlb, vma);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		pages += change_p4d_range(vma, pgd, addr, next, newprot,
+		pages += change_p4d_range(tlb, vma, pgd, addr, next, newprot,
 					  cp_flags);
 	} while (pgd++, addr = next, addr != end);
 
-	/* Only flush the TLB if we actually modified any entries: */
-	if (pages)
-		flush_tlb_range(vma, start, end);
-	dec_tlb_flush_pending(mm);
+	tlb_end_vma(tlb, vma);
 
 	return pages;
 }
 
-unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
+unsigned long change_protection(struct mmu_gather *tlb,
+		       struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
 		       unsigned long cp_flags)
 {
@@ -383,7 +387,7 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
 	else
-		pages = change_protection_range(vma, start, end, newprot,
+		pages = change_protection_range(tlb, vma, start, end, newprot,
 						cp_flags);
 
 	return pages;
@@ -417,8 +421,9 @@ static const struct mm_walk_ops prot_none_walk_ops = {
 };
 
 int
-mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
-	unsigned long start, unsigned long end, unsigned long newflags)
+mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
+	       struct vm_area_struct **pprev, unsigned long start,
+	       unsigned long end, unsigned long newflags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long oldflags = vma->vm_flags;
@@ -505,7 +510,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
 	vma_set_page_prot(vma);
 
-	change_protection(vma, start, end, vma->vm_page_prot,
+	change_protection(tlb, vma, start, end, vma->vm_page_prot,
 			  dirty_accountable ? MM_CP_DIRTY_ACCT : 0);
 
 	/*
@@ -539,6 +544,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	const int grows = prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	struct mmu_gather tlb;
 
 	start = untagged_addr(start);
 
@@ -598,6 +604,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	else
 		prev = vma->vm_prev;
 
+	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart = start ; ; ) {
 		unsigned long mask_off_old_flags;
 		unsigned long newflags;
@@ -624,18 +631,18 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		/* newflags >> 4 shift VM_MAY% in place of VM_% */
 		if ((newflags & ~(newflags >> 4)) & VM_ACCESS_FLAGS) {
 			error = -EACCES;
-			goto out;
+			goto out_tlb;
 		}
 
 		/* Allow architectures to sanity-check the new flags */
 		if (!arch_validate_flags(newflags)) {
 			error = -EINVAL;
-			goto out;
+			goto out_tlb;
 		}
 
 		error = security_file_mprotect(vma, reqprot, prot);
 		if (error)
-			goto out;
+			goto out_tlb;
 
 		tmp = vma->vm_end;
 		if (tmp > end)
@@ -644,27 +651,29 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		if (vma->vm_ops && vma->vm_ops->mprotect) {
 			error = vma->vm_ops->mprotect(vma, nstart, tmp, newflags);
 			if (error)
-				goto out;
+				goto out_tlb;
 		}
 
-		error = mprotect_fixup(vma, &prev, nstart, tmp, newflags);
+		error = mprotect_fixup(&tlb, vma, &prev, nstart, tmp, newflags);
 		if (error)
-			goto out;
+			goto out_tlb;
 
 		nstart = tmp;
 
 		if (nstart < prev->vm_end)
 			nstart = prev->vm_end;
 		if (nstart >= end)
-			goto out;
+			goto out_tlb;
 
 		vma = prev->vm_next;
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
-			goto out;
+			goto out_tlb;
 		}
 		prot = reqprot;
 	}
+out_tlb:
+	tlb_finish_mmu(&tlb);
 out:
 	mmap_write_unlock(current->mm);
 	return error;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e9bb6db002aa..0fd7fc8010d7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -16,6 +16,7 @@
 #include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
 #include <asm/tlbflush.h>
+#include <asm/tlb.h>
 #include "internal.h"
 
 static __always_inline
@@ -687,6 +688,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	struct mmu_gather tlb;
 	pgprot_t newprot;
 	int err;
 
@@ -728,8 +730,10 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	else
 		newprot = vm_get_page_prot(dst_vma->vm_flags);
 
-	change_protection(dst_vma, start, start + len, newprot,
+	tlb_gather_mmu(&tlb, dst_mm);
+	change_protection(&tlb, dst_vma, start, start + len, newprot,
 			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
+	tlb_finish_mmu(&tlb);
 
 	err = 0;
 out_unlock:
-- 
2.25.1

