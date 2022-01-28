Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9234049FA91
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349121AbiA1NUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5E5C061751
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=s8IABzRzP3ySJUm3FAWGVRKOhNvfxqtE36yoL1LaJ64=;
 b=5YyiNFsYpzIQby2cs2RNO6bfzcHVJCc1OHBveg/UD65LrGPfoSpZ46OpZtGa2uzUYJVj/
 0CwrThBTUJzA/lPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=s8IABzRzP3ySJUm3FAWGVRKOhNvfxqtE36yoL1LaJ64=;
 b=RF2Qg4JiQv/B2GTmiJJJgrrzl0zjMUIsaOF/jROil5LtN55Hp11eOn04jBQmSOL/orKqR
 NcRlQHquDKLgJDhikMo0h99LT9sdFuGHryzYZBQV3gj29cL4fKU1FoleONoLfphsNbzACNp
 +k8D1ucVhjB6SzuVMWlasEAGRwzN5/c7KWRSEbagrLzMxcnrW4utpUEfsgs/27LchjqNmCH
 uQx9u9MHz2A/KB0Zi5EcmkAJJpctcV8quh6MV402l66mgoAP+hsmfuQihBBbN4MbgSGT2tN
 IyWX9f8J7LN5Lfo5PIc24TCTKikYUogJPRb0nG7pdVGXMUoZwg/WyIS7ZBbQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 1D48E160AA0;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 00D4520557; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 19/35] mm: enable speculative fault handling through do_anonymous_page()
Date:   Fri, 28 Jan 2022 05:09:50 -0800
Message-Id: <20220128131006.67712-20-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in x86 fault handler, only attempt spf if the vma is anonymous.

In do_handle_mm_fault(), let speculative page faults proceed as long
as they fall into anonymous vmas. This enables the speculative
handling code in __handle_mm_fault() and do_anonymous_page().

In handle_pte_fault(), if vmf->pte is set (the original pte was not
pte_none), catch speculative faults and return VM_FAULT_RETRY as
those cases are not implemented yet. Also assert that do_fault()
is not reached in the speculative case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c |  2 +-
 mm/memory.c         | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 99b0a358154e..6ba109413396 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1334,7 +1334,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		goto spf_abort;
 	rcu_read_lock();
 	vma = __find_vma(mm, address);
-	if (!vma || vma->vm_start > address) {
+	if (!vma || vma->vm_start > address || !vma_is_anonymous(vma)) {
 		rcu_read_unlock();
 		goto spf_abort;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 8d036140634d..74b51aae8166 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4365,6 +4365,8 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
+	VM_BUG_ON(vmf->flags & FAULT_FLAG_SPECULATIVE);
+
 	/*
 	 * The VMA was not fully populated on mmap() or missing VM_DONTEXPAND
 	 */
@@ -4609,6 +4611,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
@@ -4937,8 +4944,7 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 {
 	vm_fault_t ret;
 
-	if (flags & FAULT_FLAG_SPECULATIVE)
-		return VM_FAULT_RETRY;
+	VM_BUG_ON((flags & FAULT_FLAG_SPECULATIVE) && !vma_is_anonymous(vma));
 
 	__set_current_state(TASK_RUNNING);
 
@@ -4960,10 +4966,12 @@ vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
 	if (flags & FAULT_FLAG_USER)
 		mem_cgroup_enter_user_fault();
 
-	if (unlikely(is_vm_hugetlb_page(vma)))
+	if (unlikely(is_vm_hugetlb_page(vma))) {
+		VM_BUG_ON(flags & FAULT_FLAG_SPECULATIVE);
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
-	else
+	} else {
 		ret = __handle_mm_fault(vma, address, flags, seq);
+	}
 
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
-- 
2.20.1

