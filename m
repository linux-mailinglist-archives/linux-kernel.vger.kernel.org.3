Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF649FA90
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349105AbiA1NUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:14 -0500
Received: from server.lespinasse.org ([63.205.204.226]:33783 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348692AbiA1NTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:10 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=9LUG5WrBQEb2xTCcRQnwKzWeTPNgCCAgZCv7h4INXy0=;
 b=HoH4UKsoi3piw3Y7Ft9hloWe9vIGQzFqMVsgTxTip2qSR0AuyqsuuqvY2O8W/ZpvxtODE
 Z0fofr6+wkDfoqFCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=9LUG5WrBQEb2xTCcRQnwKzWeTPNgCCAgZCv7h4INXy0=;
 b=v9fnJPF2zKk5woJCEPKhHnu6QX/4Q0liJnlf1qw3UflqWC7A8ZMYjk7zQRxEGtay18Rlc
 CUi/+bzYWT/TniOqJs578nQrhRGMMKqSC4pJL6cxZWU8H41lyVBug6AGwy6vCltQHRjM2Dm
 aCJTil5iQA9QTA3LPMwBFcAGV1JRg+JQm1HB7Jw7KVd/Jrh7xfsGTO0S72fW9qUM8UagwlK
 73zzwhALRQDi0GxhhDTH50AWpwHu6kDigcbgqWulY0Y1UYCN8CRyJywino5762BFo0V/G0P
 Tq0OYR9VH546GjTsHUuwPfaL+FhHeVDVRqiK9a1k8yv0saMpcGbHJt9v1qqw==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 4210A160AE0;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 2812820473; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 33/35] arm64/mm: attempt speculative mm faults first
Date:   Fri, 28 Jan 2022 05:10:04 -0800
Message-Id: <20220128131006.67712-34-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt speculative mm fault handling first, and fall back to the
existing (non-speculative) code if that fails.

This follows the lines of the x86 speculative fault handling code,
but with some minor arch differences such as the way that the
VM_FAULT_BADACCESS case is handled.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/arm64/mm/fault.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 77341b160aca..2598795f4e70 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -25,6 +25,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/vm_event_item.h>
 
 #include <asm/acpi.h>
 #include <asm/bug.h>
@@ -524,6 +525,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct *vma;
+	struct vm_area_struct pvma;
+	unsigned long seq;
+#endif
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -574,6 +580,59 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	/*
+	 * No need to try speculative faults for kernel or
+	 * single threaded user space.
+	 */
+	if (!(mm_flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
+	count_vm_event(SPF_ATTEMPT);
+	seq = mmap_seq_read_start(mm);
+	if (seq & 1) {
+		count_vm_spf_event(SPF_ABORT_ODD);
+		goto spf_abort;
+	}
+	rcu_read_lock();
+	vma = __find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr) {
+		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_UNMAPPED);
+		goto spf_abort;
+	}
+	if (!vma_is_anonymous(vma)) {
+		rcu_read_unlock();
+		count_vm_spf_event(SPF_ABORT_NO_SPECULATE);
+		goto spf_abort;
+	}
+	pvma = *vma;
+	rcu_read_unlock();
+	if (!mmap_seq_read_check(mm, seq, SPF_ABORT_VMA_COPY))
+		goto spf_abort;
+	vma = &pvma;
+	if (!(vma->vm_flags & vm_flags)) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
+		goto spf_abort;
+	}
+	fault = do_handle_mm_fault(vma, addr & PAGE_MASK,
+			mm_flags | FAULT_FLAG_SPECULATIVE, seq, regs);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+	if (!(fault & VM_FAULT_RETRY))
+		goto done;
+
+spf_abort:
+	count_vm_event(SPF_ABORT);
+no_spf:
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	/*
 	 * As per x86, we may deadlock here. However, since the kernel only
 	 * validly references user space from well defined areas of the code,
@@ -612,6 +671,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 		goto retry;
 	}
 	mmap_read_unlock(mm);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 
 	/*
 	 * Handle the "normal" (no error) case first.
-- 
2.20.1

