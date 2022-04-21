Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2250A8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391743AbiDUTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388267AbiDUTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F31AE45785
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650567951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFWmGejx79OEDDZnBB2ZFPlGKsCZX9RSPrZd1rTZXn0=;
        b=d7L3cJqHfs88JFMo4WKO45GPCAXzPBFxfCL0qHGTYFwngeGoX2w2qtPrIhXaQoxxDWzQK1
        B/gUTRUwIBHg545T4OI8aHJbzAneV9k2rWYSad8WMHgTskwfu+WqMOsYMhCGAUHwToVv2c
        7W0X4eK9cKegN3Ac0NW3fytKCgd4XUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-V_2KtmyYOi2dcxdzsPsvNA-1; Thu, 21 Apr 2022 15:05:49 -0400
X-MC-Unique: V_2KtmyYOi2dcxdzsPsvNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5DC811E90;
        Thu, 21 Apr 2022 19:05:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.16.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A61EFC27E81;
        Thu, 21 Apr 2022 19:05:47 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: [RFC 1/3] mm: change vma_is_anonymous to vma_is_private_anon
Date:   Thu, 21 Apr 2022 15:05:31 -0400
Message-Id: <20220421190533.1601879-2-npache@redhat.com>
In-Reply-To: <20220421190533.1601879-1-npache@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vma_is_anonymous function isn't fully indicative of what it checks.

Without having full knowledge of the mmap process, one may incorrectly
assume this covers all types of anonymous memory; which is not the case.

No functional changes.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 arch/powerpc/mm/book3s64/pgtable.c |  2 +-
 fs/userfaultfd.c                   |  2 +-
 include/linux/huge_mm.h            |  2 +-
 include/linux/mm.h                 |  2 +-
 mm/gup.c                           |  4 ++--
 mm/huge_memory.c                   | 10 +++++-----
 mm/madvise.c                       |  4 ++--
 mm/memory.c                        | 10 +++++-----
 mm/migrate_device.c                |  6 +++---
 mm/mincore.c                       |  2 +-
 mm/mmap.c                          |  4 ++--
 mm/oom_kill.c                      |  2 +-
 mm/userfaultfd.c                   |  8 ++++----
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 052e6590f84f..c8fd68a7965d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -479,7 +479,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 			   struct vm_area_struct *vma)
 {
 	if (radix_enabled())
-		return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+		return (new_pmd_ptl != old_pmd_ptl) && vma_is_private_anon(vma);
 
 	return true;
 }
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..d3fe2c26874a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1269,7 +1269,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 			return false;
 	}
 
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	return vma_is_private_anon(vma) || is_vm_hugetlb_page(vma) ||
 	       vma_is_shmem(vma);
 }
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2999190adc22..40493f53562c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -119,7 +119,7 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 		unsigned long haddr)
 {
 	/* Don't have to check pgoff for anonymous vma */
-	if (!vma_is_anonymous(vma)) {
+	if (!vma_is_private_anon(vma)) {
 		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
 				HPAGE_PMD_NR))
 			return false;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..9a01d053853b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -623,7 +623,7 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 	vma->vm_ops = NULL;
 }
 
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+static inline bool vma_is_private_anon(struct vm_area_struct *vma)
 {
 	return !vma->vm_ops;
 }
diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..7cd3ef329ea2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -398,7 +398,7 @@ static struct page *no_page_table(struct vm_area_struct *vma,
 	 * be zero-filled if handle_mm_fault() actually did handle it.
 	 */
 	if ((flags & FOLL_DUMP) &&
-			(vma_is_anonymous(vma) || !vma->vm_ops->fault))
+			(vma_is_private_anon(vma) || !vma->vm_ops->fault))
 		return ERR_PTR(-EFAULT);
 	return NULL;
 }
@@ -913,7 +913,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
-	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
+	if (gup_flags & FOLL_ANON && !vma_is_private_anon(vma))
 		return -EFAULT;
 
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c468fee595ff..81c2123aeffe 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -82,7 +82,7 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
 
 	if (!transhuge_vma_suitable(vma, addr))
 		return false;
-	if (vma_is_anonymous(vma))
+	if (vma_is_private_anon(vma))
 		return __transparent_hugepage_enabled(vma);
 	if (vma_is_shmem(vma))
 		return shmem_huge_enabled(vma);
@@ -1035,7 +1035,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 
 	/* Skip if can be re-fill on fault */
-	if (!vma_is_anonymous(dst_vma))
+	if (!vma_is_private_anon(dst_vma))
 		return 0;
 
 	pgtable = pte_alloc_one(dst_mm);
@@ -1622,7 +1622,7 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
 	 *
 	 * We also don't deposit and withdraw tables for file pages.
 	 */
-	return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+	return (new_pmd_ptl != old_pmd_ptl) && vma_is_private_anon(vma);
 }
 #endif
 
@@ -1799,7 +1799,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	}
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
-	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
+	BUG_ON(vma_is_private_anon(vma) && !preserve_write && pmd_write(entry));
 unlock:
 	spin_unlock(ptl);
 	return ret;
@@ -1957,7 +1957,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	count_vm_event(THP_SPLIT_PMD);
 
-	if (!vma_is_anonymous(vma)) {
+	if (!vma_is_private_anon(vma)) {
 		old_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
 		/*
 		 * We are going to unmap this huge page. So
diff --git a/mm/madvise.c b/mm/madvise.c
index 1873616a37d2..23771875ae9d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -543,7 +543,7 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
 
 static inline bool can_do_pageout(struct vm_area_struct *vma)
 {
-	if (vma_is_anonymous(vma))
+	if (vma_is_private_anon(vma))
 		return true;
 	if (!vma->vm_file)
 		return false;
@@ -725,7 +725,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 	struct mmu_gather tlb;
 
 	/* MADV_FREE works for only anon vma at the moment */
-	if (!vma_is_anonymous(vma))
+	if (!vma_is_private_anon(vma))
 		return -EINVAL;
 
 	range.start = max(vma->vm_start, start_addr);
diff --git a/mm/memory.c b/mm/memory.c
index 76e3af9639d9..fcb599bc5c33 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4494,7 +4494,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_private_anon(vmf->vma))
 		return do_huge_pmd_anonymous_page(vmf);
 	if (vmf->vma->vm_ops->huge_fault)
 		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
@@ -4504,7 +4504,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 {
-	if (vma_is_anonymous(vmf->vma)) {
+	if (vma_is_private_anon(vmf->vma)) {
 		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf);
@@ -4527,7 +4527,7 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	/* No support for anonymous transparent PUD pages yet */
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_private_anon(vmf->vma))
 		goto split;
 	if (vmf->vma->vm_ops->huge_fault) {
 		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
@@ -4546,7 +4546,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* No support for anonymous transparent PUD pages yet */
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_private_anon(vmf->vma))
 		return VM_FAULT_FALLBACK;
 	if (vmf->vma->vm_ops->huge_fault)
 		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
@@ -4621,7 +4621,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!vmf->pte) {
-		if (vma_is_anonymous(vmf->vma))
+		if (vma_is_private_anon(vmf->vma))
 			return do_anonymous_page(vmf);
 		else
 			return do_fault(vmf);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 70c7dc05bbfc..4a4068c410f7 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -40,7 +40,7 @@ static int migrate_vma_collect_hole(unsigned long start,
 	unsigned long addr;
 
 	/* Only allow populating anonymous memory. */
-	if (!vma_is_anonymous(walk->vma))
+	if (!vma_is_private_anon(walk->vma))
 		return migrate_vma_collect_skip(start, end, walk);
 
 	for (addr = start; addr < end; addr += PAGE_SIZE) {
@@ -120,7 +120,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		pte = *ptep;
 
 		if (pte_none(pte)) {
-			if (vma_is_anonymous(vma)) {
+			if (vma_is_private_anon(vma)) {
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
 			}
@@ -518,7 +518,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pte_t *ptep;
 
 	/* Only allow populating anonymous memory */
-	if (!vma_is_anonymous(vma))
+	if (!vma_is_private_anon(vma))
 		goto abort;
 
 	pgdp = pgd_offset(mm, addr);
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..5aa4a1358ac1 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -156,7 +156,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 static inline bool can_do_mincore(struct vm_area_struct *vma)
 {
-	if (vma_is_anonymous(vma))
+	if (vma_is_private_anon(vma))
 		return true;
 	if (!vma->vm_file)
 		return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..a2968669fd4e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3189,7 +3189,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	 * using the existing file pgoff checks and manipulations.
 	 * Similarly in do_mmap and in do_brk_flags.
 	 */
-	if (vma_is_anonymous(vma)) {
+	if (vma_is_private_anon(vma)) {
 		BUG_ON(vma->anon_vma);
 		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
 	}
@@ -3217,7 +3217,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
+	if (unlikely(vma_is_private_anon(vma) && !vma->anon_vma)) {
 		pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
 	}
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 7ec38194f8e1..aa3e68934fcb 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -536,7 +536,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 		 * we do not want to block exit_mmap by keeping mm ref
 		 * count elevated without a good reason.
 		 */
-		if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
+		if (vma_is_private_anon(vma) || !(vma->vm_flags & VM_SHARED)) {
 			struct mmu_notifier_range range;
 			struct mmu_gather tlb;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0cb8e5ef1713..c94f81bd109b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -540,9 +540,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	err = -EINVAL;
 	/*
 	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
-	 * it will overwrite vm_ops, so vma_is_anonymous must return false.
+	 * it will overwrite vm_ops, so vma_is_private_anon must return false.
 	 */
-	if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
+	if (WARN_ON_ONCE(vma_is_private_anon(dst_vma) &&
 	    dst_vma->vm_flags & VM_SHARED))
 		goto out_unlock;
 
@@ -561,7 +561,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
 						src_start, len, mcopy_mode);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
+	if (!vma_is_private_anon(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
 	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
 		goto out_unlock;
@@ -717,7 +717,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 		goto out_unlock;
 	if (!userfaultfd_wp(dst_vma))
 		goto out_unlock;
-	if (!vma_is_anonymous(dst_vma))
+	if (!vma_is_private_anon(dst_vma))
 		goto out_unlock;
 
 	if (enable_wp)
-- 
2.35.1

