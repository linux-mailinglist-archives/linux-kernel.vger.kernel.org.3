Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38749FA8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349013AbiA1NTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:51 -0500
Received: from server.lespinasse.org ([63.205.204.226]:48179 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348649AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=RYRG+RuiDLezST/iL383W/LGMqkq0+0jM8HYaFAclmo=;
 b=BuXQmxj+3qKNjh5SRNWcL7LLU2E6uJfm8wDD99iZdIdaSW/+achmhWRJVgL+JEBSZlC3j
 OnYzFu0fiC/xuMuCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=RYRG+RuiDLezST/iL383W/LGMqkq0+0jM8HYaFAclmo=;
 b=qovUC5kJOR5SWthTEplixMntG75b2ioozUwSL1SQG2/I0QJfwaCZaveagDAT3SvSW0OSo
 6X0lpayd1t0B+kOvU58pqxi9AQbq1ypQ+MZGGH5jHAQ4/gHtj2w/h3oJKA6hx9FfutTN6iN
 ElE7OO3KTJ2Pt7uN9B7GQWgevhaeA7H6hD5CK/Du826mUrGPxsz8Y4Gdy/k4jllcQptecR0
 MHxHVeMRIICOAatbkGkWnCUhM2foKHhMqtb6BvJyajBZ2un2PPReaDo5NWn04xCJ3YS6POX
 bZFxXLLebTvnUTbza7nsPMPSu2xdDGldD3WgCUazwyK3bAS3tC1QN90SxKbg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 14FC516098E;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id ECAE620478; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 16/35] mm: implement speculative handling in __handle_mm_fault().
Date:   Fri, 28 Jan 2022 05:09:47 -0800
Message-Id: <20220128131006.67712-17-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The speculative path calls speculative_page_walk_begin() before walking
the page table tree to prevent page table reclamation. The logic is
otherwise similar to the non-speculative path, but with additional
restrictions: in the speculative path, we do not handle huge pages or
wiring new pages tables.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h |  6 ++++
 mm/memory.c        | 77 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6f7712179503..2e2122bd3da3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -483,6 +483,10 @@ struct vm_fault {
 	};
 	enum fault_flag flags;		/* FAULT_FLAG_xxx flags
 					 * XXX: should really be 'const' */
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	unsigned long seq;
+	pmd_t orig_pmd;
+#endif
 	pmd_t *pmd;			/* Pointer to pmd entry matching
 					 * the 'address' */
 	pud_t *pud;			/* Pointer to pud entry matching
@@ -490,9 +494,11 @@ struct vm_fault {
 					 */
 	union {
 		pte_t orig_pte;		/* Value of PTE at the time of fault */
+#ifndef CONFIG_SPECULATIVE_PAGE_FAULT
 		pmd_t orig_pmd;		/* Value of PMD at the time of fault,
 					 * used by PMD fault only.
 					 */
+#endif
 	};
 
 	struct page *cow_page;		/* Page handler may use for COW fault */
diff --git a/mm/memory.c b/mm/memory.c
index 37a4b92bd4bf..d0db10bd5bee 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4581,7 +4581,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * return value.  See filemap_fault() and __folio_lock_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags)
+		unsigned long address, unsigned int flags, unsigned long seq)
 {
 	struct vm_fault vmf = {
 		.vma = vma,
@@ -4596,6 +4596,79 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	if (flags & FAULT_FLAG_SPECULATIVE) {
+		pgd_t pgdval;
+		p4d_t p4dval;
+		pud_t pudval;
+
+		vmf.seq = seq;
+
+		speculative_page_walk_begin();
+		pgd = pgd_offset(mm, address);
+		pgdval = READ_ONCE(*pgd);
+		if (pgd_none(pgdval) || unlikely(pgd_bad(pgdval)))
+			goto spf_fail;
+
+		p4d = p4d_offset(pgd, address);
+		p4dval = READ_ONCE(*p4d);
+		if (p4d_none(p4dval) || unlikely(p4d_bad(p4dval)))
+			goto spf_fail;
+
+		vmf.pud = pud_offset(p4d, address);
+		pudval = READ_ONCE(*vmf.pud);
+		if (pud_none(pudval) || unlikely(pud_bad(pudval)) ||
+		    unlikely(pud_trans_huge(pudval)) ||
+		    unlikely(pud_devmap(pudval)))
+			goto spf_fail;
+
+		vmf.pmd = pmd_offset(vmf.pud, address);
+		vmf.orig_pmd = READ_ONCE(*vmf.pmd);
+
+		/*
+		 * pmd_none could mean that a hugepage collapse is in
+		 * progress in our back as collapse_huge_page() mark
+		 * it before invalidating the pte (which is done once
+		 * the IPI is catched by all CPU and we have interrupt
+		 * disabled).  For this reason we cannot handle THP in
+		 * a speculative way since we can't safely identify an
+		 * in progress collapse operation done in our back on
+		 * that PMD.
+		 */
+		if (unlikely(pmd_none(vmf.orig_pmd) ||
+			     is_swap_pmd(vmf.orig_pmd) ||
+			     pmd_trans_huge(vmf.orig_pmd) ||
+			     pmd_devmap(vmf.orig_pmd)))
+			goto spf_fail;
+
+		/*
+		 * The above does not allocate/instantiate page-tables because
+		 * doing so would lead to the possibility of instantiating
+		 * page-tables after free_pgtables() -- and consequently
+		 * leaking them.
+		 *
+		 * The result is that we take at least one non-speculative
+		 * fault per PMD in order to instantiate it.
+		 */
+
+		vmf.pte = pte_offset_map(vmf.pmd, address);
+		vmf.orig_pte = READ_ONCE(*vmf.pte);
+		barrier();
+		if (pte_none(vmf.orig_pte)) {
+			pte_unmap(vmf.pte);
+			vmf.pte = NULL;
+		}
+
+		speculative_page_walk_end();
+
+		return handle_pte_fault(&vmf);
+
+	spf_fail:
+		speculative_page_walk_end();
+		return VM_FAULT_RETRY;
+	}
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
@@ -4815,7 +4888,7 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
-		ret = __handle_mm_fault(vma, address, flags);
+		ret = __handle_mm_fault(vma, address, flags, seq);
 
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
-- 
2.20.1

