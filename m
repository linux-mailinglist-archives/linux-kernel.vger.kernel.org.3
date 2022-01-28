Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9465349FA89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiA1NTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:47 -0500
Received: from server.lespinasse.org ([63.205.204.226]:55603 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348647AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=JSt5tP5xkVG5wLZyDHEk5pGq0dzCPYUPeDFK2yvWOFo=;
 b=UAVmTeYX7BoelafF+11e5Yij26EpOqoi2+SKLGoVB+sWhqpaTodl8r7ba2TXA4DlhBMj6
 Gv3hKJu1eHEVn2zAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=JSt5tP5xkVG5wLZyDHEk5pGq0dzCPYUPeDFK2yvWOFo=;
 b=njsY8m4dJHMheGaNgReEskIosMqjhGUGKujjCERT5W6pORlzUbLcOBHgYDo85CwJTmyIv
 JrgspqaoGOZsXaacBVouzEF3HBr/vKRB7ltnhGzOhj2d7mrIUemc1oY1nIIXGg0Oljc7kYH
 l8EcRTacsvBuvhEIBsV86TNIm/A01F/vl4mFzqFCcJxefIRWt+5fcLYqNDKj4ijSi9mRFi8
 +zn2VwH2wPleE3koirkvwut300CYH8N39cnnNWoEEgXpbkaRgIGJ0zqWvMr7Y9BPsYRzytO
 n1DDFM/2eTFeTp+lmWOSUICk1L67MCPLTHNx2d8wgj1Lr21vEB67fF3KRNSQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 1331C16098D;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id EF6CC2044B; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 17/35] mm: add pte_map_lock() and pte_spinlock()
Date:   Fri, 28 Jan 2022 05:09:48 -0800
Message-Id: <20220128131006.67712-18-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 2e2122bd3da3..7f1083fb94e0 100644
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
+#define pte_map_lock(__vmf)						\
+({									\
+	struct vm_fault *vmf = __vmf;					\
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,	\
+				       vmf->address, &vmf->ptl);	\
+	true;								\
+})
+
+#define pte_spinlock(__vmf)						\
+({									\
+	struct vm_fault *vmf = __vmf;					\
+	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);		\
+	spin_lock(vmf->ptl);						\
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

