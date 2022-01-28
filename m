Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3086C49FA85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbiA1NTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:36 -0500
Received: from server.lespinasse.org ([63.205.204.226]:34765 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348642AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375406; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=XF266dOIdTNhtq2kUwkT/iSPHVISg780FKYRq+ayge8=;
 b=UeFZeBamF57+P1oaY18fMZj4FfUhNySrD2UNXPENW1jvkUHqpPyzvB2L28sNE+CgigR65
 ao6JdOHgJLf+tDsDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=XF266dOIdTNhtq2kUwkT/iSPHVISg780FKYRq+ayge8=;
 b=nfZdubOk41IB1ilp93OnPaLXStItCyh/kWPsVch1n61p/wqlhDa6Z2RnUpujDx4RAzDs0
 hqplzEUoK3gLT3JDctt2hO4mG8YyC0HZSlUiWlaoOwBbVaf6wBU+jYdU2DVAx3MCVPvlSNN
 id+cetPNT6bvfd8SindRMDhgAMAzbrIDRfi1PILTIwGNFoMs30Ap0u6VPfGvfWuXD9SprYN
 HzHU0ee42fdAITb5o09yNb6h3mvRDMQ16gnFjHQpNqRvwu+DaizbdPQ2spNIqqw31kBgiWo
 3pLpvsZ+tfIGSfnJ8p4edHe9btwdWnTF1v6BzAbGqpMfCAhwr7s8Lsk1yPhw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id E53C716095C;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id CE47E2044B; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 05/35] do_anonymous_page: reduce code duplication
Date:   Fri, 28 Jan 2022 05:09:36 -0800
Message-Id: <20220128131006.67712-6-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_anonymous_page(), we have separate cases for the zero page vs
allocating new anonymous pages. However, once the pte entry has been
computed, the rest of the handling (mapping and locking the page table,
checking that we didn't lose a race with another page fault handler, etc)
is identical between the two cases.

This change reduces the code duplication between the two cases.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 87 +++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index cd9432df3a27..f83e06b1dafb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3726,7 +3726,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct page *page;
+	struct page *page = NULL;
 	vm_fault_t ret = 0;
 	pte_t entry;
 
@@ -3756,78 +3756,67 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			!mm_forbids_zeropage(vma->vm_mm)) {
 		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
 						vma->vm_page_prot));
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				vmf->address, &vmf->ptl);
-		if (!pte_none(*vmf->pte)) {
-			update_mmu_tlb(vma, vmf->address, vmf->pte);
-			goto unlock;
-		}
-		ret = check_stable_address_space(vma->vm_mm);
-		if (ret)
-			goto unlock;
-		/* Deliver the page fault to userland, check inside PT lock */
-		if (userfaultfd_missing(vma)) {
-			pte_unmap_unlock(vmf->pte, vmf->ptl);
-			return handle_userfault(vmf, VM_UFFD_MISSING);
-		}
-		goto setpte;
+	} else {
+		/* Allocate our own private page. */
+		if (unlikely(anon_vma_prepare(vma)))
+			goto oom;
+		page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
+		if (!page)
+			goto oom;
+
+		if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
+			goto oom_free_page;
+		cgroup_throttle_swaprate(page, GFP_KERNEL);
+
+		/*
+		 * The memory barrier inside __SetPageUptodate makes sure that
+		 * preceding stores to the page contents become visible before
+		 * the set_pte_at() write.
+		 */
+		__SetPageUptodate(page);
+
+		entry = mk_pte(page, vma->vm_page_prot);
+		entry = pte_sw_mkyoung(entry);
+		if (vma->vm_flags & VM_WRITE)
+			entry = pte_mkwrite(pte_mkdirty(entry));
 	}
 
-	/* Allocate our own private page. */
-	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
-	page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
-	if (!page)
-		goto oom;
-
-	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
-		goto oom_free_page;
-	cgroup_throttle_swaprate(page, GFP_KERNEL);
-
-	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceding stores to the page contents become visible before
-	 * the set_pte_at() write.
-	 */
-	__SetPageUptodate(page);
-
-	entry = mk_pte(page, vma->vm_page_prot);
-	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
-
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
-		goto release;
+		goto unlock;
 	}
 
 	ret = check_stable_address_space(vma->vm_mm);
 	if (ret)
-		goto release;
+		goto unlock;
 
 	/* Deliver the page fault to userland, check inside PT lock */
 	if (userfaultfd_missing(vma)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		put_page(page);
+		if (page)
+			put_page(page);
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
-	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
-	lru_cache_add_inactive_or_unevictable(page, vma);
-setpte:
+	if (page) {
+		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
+		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		lru_cache_add_inactive_or_unevictable(page, vma);
+	}
+
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	if (page)
+		put_page(page);
 	return ret;
-release:
-	put_page(page);
-	goto unlock;
 oom_free_page:
 	put_page(page);
 oom:
-- 
2.20.1

