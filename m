Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54F49FA97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348986AbiA1NU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:29 -0500
Received: from server.lespinasse.org ([63.205.204.226]:54317 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348741AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Ws6nSBPjrVyMpiYOH2Cl/taOt/D/Mr8ccdsRtTt0KNg=;
 b=hZUoPYqCiSZU/TZEOEN3hUdTisHLznIpWUYnuiF4iT5phPKIe7MHJlrRXGB51QKAU7t8p
 tm979gzz3ai95sUBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Ws6nSBPjrVyMpiYOH2Cl/taOt/D/Mr8ccdsRtTt0KNg=;
 b=05qrSfOE11cRELTpZK5FABvk64z57z07taWkOiDYqtdoFu2bmZLuEQAjGKjj/MH0ZvTkm
 p6BJDLlUAOtvNI4JmkRFKG9ml3GDuOMGAbpKn7p1XJle0rrCxJZOSJqEOM6dkuuI+0R1fu3
 wLjgl8np3i5Hetx1zPKy6+1seCqxTWLB89owIomdh0CCra0zkxLKWk+erkEmj3tqrxL+JIU
 UYyhGcMfQAosylV0usu6jbJz8PGjmIVuY1e26bh1EwsCXM9cAORG9AmhA6uJIqThjEKYVMn
 8h7uIC1xHx6NyJ3ma9cGi8IpvVZkD6slsz36NBeMAZUIDr7Mbwrdmi1ANzGA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 4784B160AE1;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 2DBAD20FB5; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 35/35] powerpc/mm: attempt speculative mm faults first
Date:   Fri, 28 Jan 2022 05:10:06 -0800
Message-Id: <20220128131006.67712-36-michel@lespinasse.org>
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
access_pkey_error case is handled

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/powerpc/mm/fault.c | 64 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index eb8ecd7343a9..3f039504e8fd 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -395,6 +395,10 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_write = page_fault_is_write(error_code);
 	vm_fault_t fault, major = 0;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	struct vm_area_struct pvma;
+	unsigned long seq;
+#endif
 
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
 		return 0;
@@ -451,6 +455,63 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (is_exec)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	/*
+	 * No need to try speculative faults for kernel or
+	 * single threaded user space.
+	 */
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
+	count_vm_event(SPF_ATTEMPT);
+	seq = mmap_seq_read_start(mm);
+	if (seq & 1) {
+		count_vm_spf_event(SPF_ABORT_ODD);
+		goto spf_abort;
+	}
+	rcu_read_lock();
+	vma = __find_vma(mm, address);
+	if (!vma || vma->vm_start > address) {
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
+#ifdef CONFIG_PPC_MEM_KEYS
+	if (unlikely(access_pkey_error(is_write, is_exec,
+				       (error_code & DSISR_KEYFAULT), vma))) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
+		goto spf_abort;
+	}
+#endif /* CONFIG_PPC_MEM_KEYS */
+	if (unlikely(access_error(is_write, is_exec, vma))) {
+		count_vm_spf_event(SPF_ABORT_ACCESS_ERROR);
+		goto spf_abort;
+	}
+	fault = do_handle_mm_fault(vma, address,
+				   flags | FAULT_FLAG_SPECULATIVE, seq, regs);
+	major |= fault & VM_FAULT_MAJOR;
+
+	if (fault_signal_pending(fault, regs))
+		return user_mode(regs) ? 0 : SIGBUS;
+	if (!(fault & VM_FAULT_RETRY))
+		goto done;
+
+spf_abort:
+	count_vm_event(SPF_ABORT);
+no_spf:
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunately, in the case of an
@@ -522,6 +583,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	mmap_read_unlock(current->mm);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+done:
+#endif
 
 	if (unlikely(fault & VM_FAULT_ERROR))
 		return mm_fault_error(regs, address, fault);
-- 
2.20.1

