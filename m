Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A4B49FA82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348797AbiA1NT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E76C061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=wJYZVoGBeqX86Eqhj6uJBnmDNtLP3Y+lAn8JeAXF+pA=;
 b=N1Op9TLaSFCt4mNfV9WN12B/y/XV9KdPR31gHO7zQOJxTkmYVquAISEr99VplqYXcbsxo
 a8jPDgMsCbvLN+FDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=wJYZVoGBeqX86Eqhj6uJBnmDNtLP3Y+lAn8JeAXF+pA=;
 b=a/HWmRNlZfInCeg5CFkoGnLKyBm9LZzL0mkQXB4G3DE8RCm2Hrw9gJPQGMI4I82hcZQmj
 m7Y2BwukOgFpswfKym8uyfr9W+CJw9hM6S1FLUqCy7DZnG9n3VA0GrkKMp0KKC4z5GOrCYx
 kO5b0o/d7sxVVtRTIWZxj77H2C0BMj2unRyWmSjdh6Sq9APLe9lRz00uaqD4WNSw/ElPdmk
 jXMtQ/moy5slLpZ3Asq43eoE2u1DH0iggYWx7iF7QOZrpjM+/96NGmJLj22KGqn4C+rRFjm
 TsQpRRTwCZw/1sQxPQ2iBz2SPCpg+e936J2SgmYY7SBssJL4z46io1zscSgQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 09E85160976;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id E469420477; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 13/35] x86/mm: attempt speculative mm faults first
Date:   Fri, 28 Jan 2022 05:09:44 -0800
Message-Id: <20220128131006.67712-14-michel@lespinasse.org>
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

The speculative handling closely mirrors the non-speculative logic.
This includes some x86 specific bits such as the access_error() call.
This is why we chose to implement the speculative handling in arch/x86
rather than in common code.

The vma is first looked up and copied, under protection of the rcu
read lock. The mmap lock sequence count is used to verify the
integrity of the copied vma, and passed to do_handle_mm_fault() to
allow checking against races with mmap writers when finalizing the fault.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c           | 44 +++++++++++++++++++++++++++++++++++
 include/linux/mm_types.h      |  5 ++++
 include/linux/vm_event_item.h |  4 ++++
 mm/vmstat.c                   |  4 ++++
 4 files changed, 57 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d0074c6ed31a..99b0a358154e 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1226,6 +1226,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	struct mm_struct *mm;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct pvma;
+	unsigned long seq;
+#endif
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1323,6 +1327,43 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	count_vm_event(SPF_ATTEMPT);
+	seq = mmap_seq_read_start(mm);
+	if (seq & 1)
+		goto spf_abort;
+	rcu_read_lock();
+	vma = __find_vma(mm, address);
+	if (!vma || vma->vm_start > address) {
+		rcu_read_unlock();
+		goto spf_abort;
+	}
+	pvma = *vma;
+	rcu_read_unlock();
+	if (!mmap_seq_read_check(mm, seq))
+		goto spf_abort;
+	vma = &pvma;
+	if (unlikely(access_error(error_code, vma)))
+		goto spf_abort;
+	fault = do_handle_mm_fault(vma, address,
+				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
+
+	if (!(fault & VM_FAULT_RETRY))
+		goto done;
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR,
+						 ARCH_DEFAULT_PKEY);
+		return;
+	}
+
+spf_abort:
+	count_vm_event(SPF_ABORT);
+#endif
+
 	/*
 	 * Kernel-mode access to the user address space should only occur
 	 * on well-defined single instructions listed in the exception
@@ -1419,6 +1460,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b6678578a729..305f05d2a4bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -370,6 +370,11 @@ struct anon_vma_name {
  * per VM-area/task. A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
+ *
+ * Note that speculative page faults make an on-stack copy of the VMA,
+ * so the structure size matters.
+ * (TODO - it would be preferable to copy only the required vma attributes
+ *  rather than the entire vma).
  */
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 7b2363388bfa..f00b3e36ff39 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -133,6 +133,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+#endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		SPF_ATTEMPT,
+		SPF_ABORT,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..dbb0160e5558 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1390,6 +1390,10 @@ const char * const vmstat_text[] = {
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
 #endif
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	"spf_attempt",
+	"spf_abort",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.20.1

