Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7149FA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbiA1NUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:02 -0500
Received: from server.lespinasse.org ([63.205.204.226]:50107 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348678AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=7ZwO3JSFTMu+I+SD7pVtiWOQ8TjLyD2OehGAIC7WXjM=;
 b=kXZaaQKnfFfdx1WcuV/gsR3sFHyjkkWzgVlVIxl61xzaSmlhPKCw8k9+0tXt42thV1hgh
 76J7O3GfBptE7fSCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=7ZwO3JSFTMu+I+SD7pVtiWOQ8TjLyD2OehGAIC7WXjM=;
 b=N+8pg6EwjJQ3+6Y7V4x16KZEvrtmwYS+Kkac+I8wPHurF9yISlUf9mrEqxGCFMpE8iKWo
 af//9oNNzfjUKvmlV90xDVOpnS9w6rIknF2VlARdpSg5gTndvdvI3korqttpbVfl6IUxQae
 O3VrDU2+4MMBPDgX1SU44DD1De1BaiokD4lkS+M6QKgl6CR1s/U5L7KYI8dBXx6sq7vxC4q
 3pMrI0M/abW1VuAe5ZzAMd9o1YzyS9vkrsGGZhxx0gK2cmOrIUpP3cW3a+eNfZ9eN9Q9WZO
 hd1vFAxrPwIytcuycY+dTWvMIXOnOummJyesV0+o3FKbRWSh/AzaaJFY6OGw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 34F95160AC3;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 1422920F30; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 26/35] mm: implement speculative handling in wp_page_copy()
Date:   Fri, 28 Jan 2022 05:09:57 -0800
Message-Id: <20220128131006.67712-27-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change wp_page_copy() to handle the speculative case. This involves
aborting speculative faults if they have to allocate an anon_vma,
read-locking the mmu_notifier_lock to avoid races with
mmu_notifier_register(), and using pte_map_lock() instead of
pte_offset_map_lock() to complete the page fault.

Also change call sites to clear vmf->pte after unmapping the page table,
in order to satisfy pte_map_lock()'s preconditions.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 73b1a328b797..fd8984d89109 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3087,20 +3087,27 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	vm_fault_t ret = VM_FAULT_OOM;
 
-	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
+	if (unlikely(!vma->anon_vma)) {
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			ret = VM_FAULT_RETRY;
+			goto out;
+		}
+		if (__anon_vma_prepare(vma))
+			goto out;
+	}
 
 	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
 		new_page = alloc_zeroed_user_highpage_movable(vma,
 							      vmf->address);
 		if (!new_page)
-			goto oom;
+			goto out;
 	} else {
 		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
 				vmf->address);
 		if (!new_page)
-			goto oom;
+			goto out;
 
 		if (!cow_user_page(new_page, old_page, vmf)) {
 			/*
@@ -3117,11 +3124,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	}
 
 	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
-		goto oom_free_new;
+		goto out_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
 	__SetPageUptodate(new_page);
 
+	if ((vmf->flags & FAULT_FLAG_SPECULATIVE) &&
+	    !mmu_notifier_trylock(mm)) {
+		ret = VM_FAULT_RETRY;
+		goto out_free_new;
+	}
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
 				vmf->address & PAGE_MASK,
 				(vmf->address & PAGE_MASK) + PAGE_SIZE);
@@ -3130,7 +3142,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		ret = VM_FAULT_RETRY;
+		/* put_page() will uncharge the page */
+		goto out_notify;
+	}
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
 			if (!PageAnon(old_page)) {
@@ -3205,6 +3221,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 * the above ptep_clear_flush_notify() did already call it.
 	 */
 	mmu_notifier_invalidate_range_only_end(&range);
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		mmu_notifier_unlock(mm);
 	if (old_page) {
 		/*
 		 * Don't let another task, with possibly unlocked vma,
@@ -3221,12 +3239,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
-oom_free_new:
+out_notify:
+	mmu_notifier_invalidate_range_only_end(&range);
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		mmu_notifier_unlock(mm);
+out_free_new:
 	put_page(new_page);
-oom:
+out:
 	if (old_page)
 		put_page(old_page);
-	return VM_FAULT_OOM;
+	return ret;
 }
 
 /**
@@ -3369,6 +3391,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			return wp_pfn_shared(vmf);
 
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		vmf->pte = NULL;
 		return wp_page_copy(vmf);
 	}
 
@@ -3407,6 +3430,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	vmf->pte = NULL;
 	return wp_page_copy(vmf);
 }
 
-- 
2.20.1

