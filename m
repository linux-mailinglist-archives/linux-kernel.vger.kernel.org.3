Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E549FA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349010AbiA1NUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:11 -0500
Received: from server.lespinasse.org ([63.205.204.226]:48725 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=h0OB3itXHSsaegtYCAjglB0dKK8hw9ET+M16zSiFNyU=;
 b=xS5mCESfy6y0TI6ONSNvUVVbt4kZJ5FEuG4+8W9WsmR3WuvRkxdSZBFUA3lpIapuHDyRM
 TMjVq3VB/OcODo8Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=h0OB3itXHSsaegtYCAjglB0dKK8hw9ET+M16zSiFNyU=;
 b=LpDorKuWKqjFoH3XY0OMq4Pa43KItEaXJXyu7mK08bI5Ji3kWxrbak6QdNfKkOzLKUbCq
 g/OAyfTR+1m765H905fFlfVQTEnIZ+zosJ9T/4AzVAt0gMs8SyYyFQw39rGQjnFLfRGi4F1
 ctyEGWUGnRTs+tkjbfCYjUOWAy4OWcwwldTmyaAJblOakogBGqRnIWQgODeVVB2GUbgxd8y
 +f/1QjxSujsaarrkwFvlDtv+U5AY46icuP5CKcmDxBKHPmbJHL/5y4goGC/ec0/9Pk5wjO6
 ZYZwyrtUbEv+9K8WSaeZLhXGIJ5xGAxye2z04RQAbIsNL7WeoXk5J/d+8WLA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 33B8A160AAD;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 16FC920F8E; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 27/35] mm: implement and enable speculative fault handling in handle_pte_fault()
Date:   Fri, 28 Jan 2022 05:09:58 -0800
Message-Id: <20220128131006.67712-28-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In handle_pte_fault(), allow speculative execution to proceed.

Use pte_spinlock() to validate the mmap sequence count when locking
the page table.

If speculative execution proceeds through do_wp_page(), ensure that we
end up in the wp_page_reuse() or wp_page_copy() paths, rather than
wp_pfn_shared() or wp_page_shared() (both unreachable as we only
handle anon vmas so far) or handle_userfault() (needs an explicit
abort to handle non-speculatively).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index fd8984d89109..7f8dbd729dce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3293,6 +3293,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
 	if (vma->vm_ops && vma->vm_ops->pfn_mkwrite) {
 		vm_fault_t ret;
 
@@ -3313,6 +3314,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = VM_FAULT_WRITE;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	get_page(vmf->page);
 
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
@@ -3366,6 +3369,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
 
@@ -4646,13 +4651,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
-	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
-		pte_unmap(vmf->pte);
+	if (!pte_spinlock(vmf))
 		return VM_FAULT_RETRY;
-	}
-
-	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
-	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(*vmf->pte, entry))) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
-- 
2.20.1

