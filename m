Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1C49FA7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiA1NTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244752AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB370C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=N1S1NesGU6Y8f8q9IeGf50c8McugHmVCalVHP9Er6AE=;
 b=G3mnG6iArJ3iUlnv5jmCwGBZSi4ZmZNvZum1Io0mtaiwsYz/3xaJREVHKG9TcE9hCnOxk
 eVwcUhjl24gy00cDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=N1S1NesGU6Y8f8q9IeGf50c8McugHmVCalVHP9Er6AE=;
 b=NdoeJxId3UHckIXu3hAFoxtvDqiwDvgJJSGGpoR05QXlMP89KsXW0W+ABD8b/gYA0BhuF
 Mz98ld9u1J576DPaXDTCzvCNgYfR16gNyveBozyLnxl41FS5UKO/RMnGzdj/+9sMR94QUI/
 /M5pshUxt3Oy4+uAL7EUNI195zLs+k05K4+MxeagX7bMTPd41C9gmqMf300MOIpeyNtBJai
 3Ll/zt6OghuoLMkBvzux0MFzo8De6dNhImoV4VxrB+Zc1ap1bi4fpFoqsn6xXahNmU4U9fb
 vCcVuMqB4jx8MrwgeiRxeLbkVXdEzv1b7akE/LEXnrI1ONHHlFu9tlWe7kRQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 0F8FE160985;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id E9CD020330; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 15/35] mm: refactor __handle_mm_fault() / handle_pte_fault()
Date:   Fri, 28 Jan 2022 05:09:46 -0800
Message-Id: <20220128131006.67712-16-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code that initializes vmf->pte and vmf->orig_pte from
handle_pte_fault() to its single call site in __handle_mm_fault().

This ensures vmf->pte is now initialized together with the higher levels
of the page table hierarchy. This also prepares for speculative page fault
handling, where the entire page table walk (higher levels down to ptes)
needs special care in the speculative case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 98 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 663952d14bad..37a4b92bd4bf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3769,7 +3769,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (pte_alloc(vma->vm_mm, vmf->pmd))
 		return VM_FAULT_OOM;
 
-	/* See comment in handle_pte_fault() */
+	/* See comment in __handle_mm_fault() */
 	if (unlikely(pmd_trans_unstable(vmf->pmd)))
 		return 0;
 
@@ -4062,7 +4062,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	/* See comment in handle_pte_fault() */
+	/* See comment in __handle_mm_fault() */
 	if (pmd_devmap_trans_unstable(vmf->pmd))
 		return 0;
 
@@ -4527,53 +4527,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
 	pte_t entry;
 
-	if (unlikely(pmd_none(*vmf->pmd))) {
-		/*
-		 * Leave __pte_alloc() until later: because vm_ops->fault may
-		 * want to allocate huge page, and if we expose page table
-		 * for an instant, it will be difficult to retract from
-		 * concurrent faults and from rmap lookups.
-		 */
-		vmf->pte = NULL;
-	} else {
-		/*
-		 * If a huge pmd materialized under us just retry later.  Use
-		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
-		 * of pmd_trans_huge() to ensure the pmd didn't become
-		 * pmd_trans_huge under us and then back to pmd_none, as a
-		 * result of MADV_DONTNEED running immediately after a huge pmd
-		 * fault in a different thread of this mm, in turn leading to a
-		 * misleading pmd_trans_huge() retval. All we have to ensure is
-		 * that it is a regular pmd that we can walk with
-		 * pte_offset_map() and we can do that through an atomic read
-		 * in C, which is what pmd_trans_unstable() provides.
-		 */
-		if (pmd_devmap_trans_unstable(vmf->pmd))
-			return 0;
-		/*
-		 * A regular pmd is established and it can't morph into a huge
-		 * pmd from under us anymore at this point because we hold the
-		 * mmap_lock read mode and khugepaged takes it in write mode.
-		 * So now it's safe to run pte_offset_map().
-		 */
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-		vmf->orig_pte = *vmf->pte;
-
-		/*
-		 * some architectures can have larger ptes than wordsize,
-		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
-		 * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
-		 * accesses.  The code below just needs a consistent view
-		 * for the ifs and we later double check anyway with the
-		 * ptl lock held. So here a barrier will do.
-		 */
-		barrier();
-		if (pte_none(vmf->orig_pte)) {
-			pte_unmap(vmf->pte);
-			vmf->pte = NULL;
-		}
-	}
-
 	if (!vmf->pte) {
 		if (vma_is_anonymous(vmf->vma))
 			return do_anonymous_page(vmf);
@@ -4713,6 +4666,53 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		}
 	}
 
+	if (unlikely(pmd_none(*vmf.pmd))) {
+		/*
+		 * Leave __pte_alloc() until later: because vm_ops->fault may
+		 * want to allocate huge page, and if we expose page table
+		 * for an instant, it will be difficult to retract from
+		 * concurrent faults and from rmap lookups.
+		 */
+		vmf.pte = NULL;
+	} else {
+		/*
+		 * If a huge pmd materialized under us just retry later.  Use
+		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
+		 * of pmd_trans_huge() to ensure the pmd didn't become
+		 * pmd_trans_huge under us and then back to pmd_none, as a
+		 * result of MADV_DONTNEED running immediately after a huge pmd
+		 * fault in a different thread of this mm, in turn leading to a
+		 * misleading pmd_trans_huge() retval. All we have to ensure is
+		 * that it is a regular pmd that we can walk with
+		 * pte_offset_map() and we can do that through an atomic read
+		 * in C, which is what pmd_trans_unstable() provides.
+		 */
+		if (pmd_devmap_trans_unstable(vmf.pmd))
+			return 0;
+		/*
+		 * A regular pmd is established and it can't morph into a huge
+		 * pmd from under us anymore at this point because we hold the
+		 * mmap_lock read mode and khugepaged takes it in write mode.
+		 * So now it's safe to run pte_offset_map().
+		 */
+		vmf.pte = pte_offset_map(vmf.pmd, vmf.address);
+		vmf.orig_pte = *vmf.pte;
+
+		/*
+		 * some architectures can have larger ptes than wordsize,
+		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
+		 * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
+		 * accesses.  The code below just needs a consistent view
+		 * for the ifs and we later double check anyway with the
+		 * ptl lock held. So here a barrier will do.
+		 */
+		barrier();
+		if (pte_none(vmf.orig_pte)) {
+			pte_unmap(vmf.pte);
+			vmf.pte = NULL;
+		}
+	}
+
 	return handle_pte_fault(&vmf);
 }
 
-- 
2.20.1

