Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF924A0356
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiA1WOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiA1WOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:14:09 -0500
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jan 2022 14:14:08 PST
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C7C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 14:14:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-53-ed;
 t=1643407726; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=MgiqllyeJOK6ke8ALz34tVMuWcndkNzeGKveDDtwgdU=;
 b=LoO/GOsvakR3vVPtL+fRsQHD5oCcmLVBOF5LsweZ1jLDYs5y13zouTA654R9b9ZuXNPs9
 pgSs7ASuPkI6vtADw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-53-rsa; t=1643407726; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=MgiqllyeJOK6ke8ALz34tVMuWcndkNzeGKveDDtwgdU=;
 b=ig7DDtU3eMmcYVw8h1wL5+iURSLHTLgFEtFd7x47OQ/jtrSuN/GIQ9qK4P3gSNpWXbUop
 xUWT5xTJM7bKmTUrtPDVslUjcCmYfRYDDtSTFK6Rw8tuCJAx6thziim7BP1XCsXXTRk69g7
 wxkQvl/KfZ0ZDmOXKhnaiXowSDBDVb83JV5WWRqmOwYY20h5BWXumkKuenhv1QnJAsqTUB5
 oBSOJ0rlIdPrDzV0ghe4tcGIpiTF+asNbc+390tLJRuU16VdtmNR3O4iiWifroHYc/tEI3L
 0gFfSp5HNEsAQeiVx/HK2W5y47oziP6pP+haTgv0wMWhwDW5s6kQwVV/080A==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 3EF7F16094C; Fri, 28 Jan 2022 14:08:46 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:08:46 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2 18/35] mm: implement speculative handling in
 do_anonymous_page()
Message-ID: <20220128220846.GA18863@lespinasse.org>
References: <20220128131006.67712-19-michel@lespinasse.org>
 <202201290445.uKuWeLmf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201290445.uKuWeLmf-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 05:03:53AM +0800, kernel test robot wrote:
> >> mm/memory.c:3876:20: warning: variable 'vmf' is uninitialized when used within its own initialization [-Wuninitialized]
>            if (!pte_map_lock(vmf)) {
>                 ~~~~~~~~~~~~~^~~~
>    include/linux/mm.h:3418:25: note: expanded from macro 'pte_map_lock'
>            struct vm_fault *vmf = __vmf;                                   \
>                             ~~~   ^~~~~
>    1 warning generated.

Ah, that's interesting - this works with gcc, but breaks with clang.

The following amended patch should fix this:
(I only added underscores to the pte_map_lock and pte_spinlock macros)

------------------------------------ 8< ---------------------------------

mm: add pte_map_lock() and pte_spinlock()

pte_map_lock() and pte_spinlock() are used by fault handlers to ensure
the pte is mapped and locked before they commit the faulted page to the
mm's address space at the end of the fault.

The functions differ in their preconditions; pte_map_lock() expects
the pte to be unmapped prior to the call, while pte_spinlock() expects
it to be already mapped.

In the speculative fault case, the functions verify, after locking the pte,
that the mmap sequence count has not changed since the start of the fault,
and thus that no mmap lock writers have been running concurrently with
the fault. After that point the page table lock serializes any further
races with concurrent mmap lock writers.

If the mmap sequence count check fails, both functions will return false
with the pte being left unmapped and unlocked.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h | 38 ++++++++++++++++++++++++++
 mm/memory.c        | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2e2122bd3da3..80894db6f01a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3394,5 +3394,43 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+#ifdef CONFIG_MMU
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+bool __pte_map_lock(struct vm_fault *vmf);
+
+static inline bool pte_map_lock(struct vm_fault *vmf)
+{
+	VM_BUG_ON(vmf->pte);
+	return __pte_map_lock(vmf);
+}
+
+static inline bool pte_spinlock(struct vm_fault *vmf)
+{
+	VM_BUG_ON(!vmf->pte);
+	return __pte_map_lock(vmf);
+}
+
+#else	/* !CONFIG_SPECULATIVE_PAGE_FAULT */
+
+#define pte_map_lock(____vmf)						\
+({									\
+	struct vm_fault *__vmf = ____vmf;				\
+	__vmf->pte = pte_offset_map_lock(__vmf->vma->vm_mm, __vmf->pmd,	\
+					 __vmf->address, &__vmf->ptl);	\
+	true;								\
+})
+
+#define pte_spinlock(____vmf)						\
+({									\
+	struct vm_fault *__vmf = ____vmf;				\
+	__vmf->ptl = pte_lockptr(__vmf->vma->vm_mm, __vmf->pmd);	\
+	spin_lock(__vmf->ptl);						\
+	true;								\
+})
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+#endif	/* CONFIG_MMU */
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/memory.c b/mm/memory.c
index d0db10bd5bee..1ce837e47395 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2745,6 +2745,72 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 #define speculative_page_walk_end()   local_irq_enable()
 #endif
 
+bool __pte_map_lock(struct vm_fault *vmf)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	pmd_t pmdval;
+#endif
+	pte_t *pte = vmf->pte;
+	spinlock_t *ptl;
+
+	if (!(vmf->flags & FAULT_FLAG_SPECULATIVE)) {
+		vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+		if (!pte)
+			vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		spin_lock(vmf->ptl);
+		return true;
+	}
+
+	speculative_page_walk_begin();
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+		goto fail;
+	/*
+	 * The mmap sequence count check guarantees that the page
+	 * tables are still valid at that point, and
+	 * speculative_page_walk_begin() ensures that they stay around.
+	 */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/*
+	 * We check if the pmd value is still the same to ensure that there
+	 * is not a huge collapse operation in progress in our back.
+	 */
+	pmdval = READ_ONCE(*vmf->pmd);
+	if (!pmd_same(pmdval, vmf->orig_pmd))
+		goto fail;
+#endif
+	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	if (!pte)
+		pte = pte_offset_map(vmf->pmd, vmf->address);
+	/*
+	 * Try locking the page table.
+	 *
+	 * Note that we might race against zap_pte_range() which
+	 * invalidates TLBs while holding the page table lock.
+	 * We are still under the speculative_page_walk_begin() section,
+	 * and zap_pte_range() could thus deadlock with us if we tried
+	 * using spin_lock() here.
+	 *
+	 * We also don't want to retry until spin_trylock() succeeds,
+	 * because of the starvation potential against a stream of lockers.
+	 */
+	if (unlikely(!spin_trylock(ptl)))
+		goto fail;
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+		goto unlock_fail;
+	speculative_page_walk_end();
+	vmf->pte = pte;
+	vmf->ptl = ptl;
+	return true;
+
+unlock_fail:
+	spin_unlock(ptl);
+fail:
+	if (pte)
+		pte_unmap(pte);
+	speculative_page_walk_end();
+	return false;
+}
+
 #endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 /*
-- 
2.20.1

