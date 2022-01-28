Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8549FA98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbiA1NUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348758AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=vNVgJYJu6sYRiF4zfC0JNPP4aiQCkGfHC9+Vt/jd9gY=;
 b=jar27umGUl1J/bfnDyN7CaQy9w55QJGtVvNX39hoMdZcLem7v73raVDxfA2rSBgEYBj7T
 FW3lE2XPKdYf+bpAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=vNVgJYJu6sYRiF4zfC0JNPP4aiQCkGfHC9+Vt/jd9gY=;
 b=WvVe6DmTU6TnNrJY6sHATKXNNNhjhY7wc7UuholTUIa1QA3xfdeue7OBzgBBpB+9iM7Z5
 RhIgyaFbCe21MojxOrzub2n8R/HM8WSBJoE9/LPpYMX5JIqMppts4lbruESGIvvJE+LSarS
 mNWE1YJ8dHwR9+qkqgiu/qLOC1LiW6W6eRcZYj67eBlgAr3+FxrNu05WbsmeCg4uBtrB2X/
 BL8Mo8219R3jKHiiiW3JEXRdBaN6L8y5Ht+O9NzG0rTVgE32w6IqOM3yoPYdre/33W2/7cw
 HurcNm4TXXgAu2OXobP2dZZxTGoMvm9TgSvQwFO3WJnffgRArV4jMDITPg5g==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 3EC27160AC9;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 225DA20FB2; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 31/35] mm: anon spf statistics
Date:   Fri, 28 Jan 2022 05:10:02 -0800
Message-Id: <20220128131006.67712-32-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new CONFIG_SPECULATIVE_PAGE_FAULT_STATS config option,
and dump extra statistics about executed spf cases and abort reasons
when the option is set.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c           | 18 ++++++++---
 include/linux/mmap_lock.h     | 19 ++++++++++--
 include/linux/vm_event.h      |  6 ++++
 include/linux/vm_event_item.h | 21 +++++++++++++
 mm/Kconfig.debug              |  7 +++++
 mm/memory.c                   | 56 ++++++++++++++++++++++++++++-------
 mm/vmstat.c                   | 21 +++++++++++++
 7 files changed, 131 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d6f8d4967c49..a5a19561c319 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1337,21 +1337,31 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	count_vm_event(SPF_ATTEMPT);
 	seq = mmap_seq_read_start(mm);
-	if (seq & 1)
+	if (seq & 1) {
+		count_vm_spf_event(SPF_ABORT_ODD);
 		goto spf_abort;
+	}
 	rcu_read_lock();
 	vma = __find_vma(mm, address);
-	if (!vma || vma->vm_start > address || !vma_is_anonymous(vma)) {
+	if (!vma || vma->vm_start > address) {
 		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_UNMAPPED);
+		goto spf_abort;
+	}
+	if (!vma_is_anonymous(vma)) {
+		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_NO_SPECULATE);
 		goto spf_abort;
 	}
 	pvma = *vma;
 	rcu_read_unlock();
-	if (!mmap_seq_read_check(mm, seq))
+	if (!mmap_seq_read_check(mm, seq, SPF_ABORT_VMA_COPY))
 		goto spf_abort;
 	vma = &pvma;
-	if (unlikely(access_error(error_code, vma)))
+	if (unlikely(access_error(error_code, vma))) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
 		goto spf_abort;
+	}
 	fault = do_handle_mm_fault(vma, address,
 				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index a2459eb15a33..747805ce07b8 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -7,6 +7,7 @@
 #include <linux/rwsem.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
+#include <linux/vm_event.h>
 
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 #define MMAP_LOCK_SEQ_INITIALIZER(name) \
@@ -104,12 +105,26 @@ static inline unsigned long mmap_seq_read_start(struct mm_struct *mm)
 	return seq;
 }
 
-static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq)
+static inline bool __mmap_seq_read_check(struct mm_struct *mm,
+					 unsigned long seq)
 {
 	smp_rmb();
 	return seq == READ_ONCE(mm->mmap_seq);
 }
-#endif
+
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq,
+	enum vm_event_item fail_event)
+{
+	if (__mmap_seq_read_check(mm, seq))
+		return true;
+	count_vm_event(fail_event);
+	return false;
+}
+#else
+#define mmap_seq_read_check(mm, seq, fail) __mmap_seq_read_check(mm, seq)
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT_STATS */
+#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
diff --git a/include/linux/vm_event.h b/include/linux/vm_event.h
index b3ae108a3841..689a21387dad 100644
--- a/include/linux/vm_event.h
+++ b/include/linux/vm_event.h
@@ -77,6 +77,12 @@ static inline void vm_events_fold_cpu(int cpu)
 
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+#define count_vm_spf_event(x) count_vm_event(x)
+#else
+#define count_vm_spf_event(x) do {} while (0)
+#endif
+
 #ifdef CONFIG_NUMA_BALANCING
 #define count_vm_numa_event(x)     count_vm_event(x)
 #define count_vm_numa_events(x, y) count_vm_events(x, y)
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f00b3e36ff39..0390b81b1e71 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -137,6 +137,27 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
 		SPF_ATTEMPT,
 		SPF_ABORT,
+#endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+		SPF_ABORT_ODD,
+		SPF_ABORT_UNMAPPED,
+		SPF_ABORT_NO_SPECULATE,
+		SPF_ABORT_VMA_COPY,
+		SPF_ABORT_ACCESS_ERROR,
+		SPF_ABORT_PUD,
+		SPF_ABORT_PMD,
+		SPF_ABORT_ANON_VMA,
+		SPF_ABORT_PTE_MAP_LOCK_SEQ1,
+		SPF_ABORT_PTE_MAP_LOCK_PMD,
+		SPF_ABORT_PTE_MAP_LOCK_PTL,
+		SPF_ABORT_PTE_MAP_LOCK_SEQ2,
+		SPF_ABORT_USERFAULTFD,
+		SPF_ABORT_FAULT,
+		SPF_ABORT_SWAP,
+		SPF_ATTEMPT_ANON,
+		SPF_ATTEMPT_NUMA,
+		SPF_ATTEMPT_PTE,
+		SPF_ATTEMPT_WP,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 5bd5bb097252..73b61cc95562 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -174,3 +174,10 @@ config PTDUMP_DEBUGFS
 	  kernel.
 
 	  If in doubt, say N.
+
+config SPECULATIVE_PAGE_FAULT_STATS
+	bool "Additional statistics for speculative page faults"
+	depends on SPECULATIVE_PAGE_FAULT
+	help
+	  Additional statistics for speculative page faults.
+	  If in doubt, say N.
diff --git a/mm/memory.c b/mm/memory.c
index 7f8dbd729dce..a5754309eaae 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2762,7 +2762,8 @@ bool __pte_map_lock(struct vm_fault *vmf)
 	}
 
 	speculative_page_walk_begin();
-	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq,
+				 SPF_ABORT_PTE_MAP_LOCK_SEQ1))
 		goto fail;
 	/*
 	 * The mmap sequence count check guarantees that the page
@@ -2775,8 +2776,10 @@ bool __pte_map_lock(struct vm_fault *vmf)
 	 * is not a huge collapse operation in progress in our back.
 	 */
 	pmdval = READ_ONCE(*vmf->pmd);
-	if (!pmd_same(pmdval, vmf->orig_pmd))
+	if (!pmd_same(pmdval, vmf->orig_pmd)) {
+		count_vm_spf_event(SPF_ABORT_PTE_MAP_LOCK_PMD);
 		goto fail;
+	}
 #endif
 	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	if (!pte)
@@ -2793,9 +2796,12 @@ bool __pte_map_lock(struct vm_fault *vmf)
 	 * We also don't want to retry until spin_trylock() succeeds,
 	 * because of the starvation potential against a stream of lockers.
 	 */
-	if (unlikely(!spin_trylock(ptl)))
+	if (unlikely(!spin_trylock(ptl))) {
+		count_vm_spf_event(SPF_ABORT_PTE_MAP_LOCK_PTL);
 		goto fail;
-	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq))
+	}
+	if (!mmap_seq_read_check(vmf->vma->vm_mm, vmf->seq,
+				 SPF_ABORT_PTE_MAP_LOCK_SEQ2))
 		goto unlock_fail;
 	speculative_page_walk_end();
 	vmf->pte = pte;
@@ -3091,6 +3097,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 
 	if (unlikely(!vma->anon_vma)) {
 		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_ANON_VMA);
 			ret = VM_FAULT_RETRY;
 			goto out;
 		}
@@ -3367,10 +3374,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_WP);
+
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_USERFAULTFD);
 			return VM_FAULT_RETRY;
+		}
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
 
@@ -3620,6 +3632,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
 		pte_unmap(vmf->pte);
+		count_vm_spf_event(SPF_ABORT_SWAP);
 		return VM_FAULT_RETRY;
 	}
 
@@ -3852,6 +3865,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	pte_t entry;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_ANON);
+
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
 		return VM_FAULT_SIGBUS;
@@ -3881,8 +3897,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	} else {
 		/* Allocate our own private page. */
 		if (unlikely(!vma->anon_vma)) {
-			if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+				count_vm_spf_event(SPF_ABORT_ANON_VMA);
 				return VM_FAULT_RETRY;
+			}
 			if (__anon_vma_prepare(vma))
 				goto oom;
 		}
@@ -3925,8 +3943,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		if (page)
 			put_page(page);
-		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+			count_vm_spf_event(SPF_ABORT_USERFAULTFD);
 			return VM_FAULT_RETRY;
+		}
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
@@ -4470,6 +4490,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	bool was_writable = pte_savedwrite(vmf->orig_pte);
 	int flags = 0;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_NUMA);
+
 	/*
 	 * The "pte" at this point cannot be used safely without
 	 * validation through pte_unmap_same(). It's of NUMA type but
@@ -4651,6 +4674,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+		count_vm_spf_event(SPF_ATTEMPT_PTE);
+
 	if (!pte_spinlock(vmf))
 		return VM_FAULT_RETRY;
 	entry = vmf->orig_pte;
@@ -4718,20 +4744,26 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		speculative_page_walk_begin();
 		pgd = pgd_offset(mm, address);
 		pgdval = READ_ONCE(*pgd);
-		if (pgd_none(pgdval) || unlikely(pgd_bad(pgdval)))
+		if (pgd_none(pgdval) || unlikely(pgd_bad(pgdval))) {
+			count_vm_spf_event(SPF_ABORT_PUD);
 			goto spf_fail;
+		}
 
 		p4d = p4d_offset(pgd, address);
 		p4dval = READ_ONCE(*p4d);
-		if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval)))
+		if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval))) {
+			count_vm_spf_event(SPF_ABORT_PUD);
 			goto spf_fail;
+		}
 
 		vmf.pud = pud_offset(p4d, address);
 		pudval = READ_ONCE(*vmf.pud);
 		if (pud_none(pudval) || unlikely(pud_bad(pudval)) ||
 		    unlikely(pud_trans_huge(pudval)) ||
-		    unlikely(pud_devmap(pudval)))
+		    unlikely(pud_devmap(pudval))) {
+			count_vm_spf_event(SPF_ABORT_PUD);
 			goto spf_fail;
+		}
 
 		vmf.pmd = pmd_offset(vmf.pud, address);
 		vmf.orig_pmd = READ_ONCE(*vmf.pmd);
@@ -4749,8 +4781,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		if (unlikely(pmd_none(vmf.orig_pmd) ||
 			     is_swap_pmd(vmf.orig_pmd) ||
 			     pmd_trans_huge(vmf.orig_pmd) ||
-			     pmd_devmap(vmf.orig_pmd)))
+			     pmd_devmap(vmf.orig_pmd))) {
+			count_vm_spf_event(SPF_ABORT_PMD);
 			goto spf_fail;
+		}
 
 		/*
 		 * The above does not allocate/instantiate page-tables because
diff --git a/mm/vmstat.c b/mm/vmstat.c
index dbb0160e5558..20ac17cf582a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1394,6 +1394,27 @@ const char * const vmstat_text[] = {
 	"spf_attempt",
 	"spf_abort",
 #endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT_STATS
+	"SPF_ABORT_ODD",
+	"SPF_ABORT_UNMAPPED",
+	"SPF_ABORT_NO_SPECULATE",
+	"SPF_ABORT_VMA_COPY",
+	"SPF_ABORT_ACCESS_ERROR",
+	"SPF_ABORT_PUD",
+	"SPF_ABORT_PMD",
+	"SPF_ABORT_ANON_VMA",
+	"SPF_ABORT_PTE_MAP_LOCK_SEQ1",
+	"SPF_ABORT_PTE_MAP_LOCK_PMD",
+	"SPF_ABORT_PTE_MAP_LOCK_PTL",
+	"SPF_ABORT_PTE_MAP_LOCK_SEQ2",
+	"SPF_ABORT_USERFAULTFD",
+	"SPF_ABORT_FAULT",
+	"SPF_ABORT_SWAP",
+	"SPF_ATTEMPT_ANON",
+	"SPF_ATTEMPT_NUMA",
+	"SPF_ATTEMPT_PTE",
+	"SPF_ATTEMPT_WP",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.20.1

