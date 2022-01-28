Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F034449FA81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348886AbiA1NT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:27 -0500
Received: from server.lespinasse.org ([63.205.204.226]:49217 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244929AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Y8IXLxDDo2uMYY4ajZ7hmxbwiY+i3sSuKQUk/LNtie0=;
 b=JulGTkO46MGgZky++qtpQvRETNq3Kvq78SzsTBHZsrHaUN9jXkTfXps3VAXviSm18hICX
 LVSWndI82XWWqqdCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Y8IXLxDDo2uMYY4ajZ7hmxbwiY+i3sSuKQUk/LNtie0=;
 b=4enGUh1ZmMgQDoOfcwGDX6So/GAUJzChFZrj0x0JBbHZKScmZ+TBT55iyG5zBKYpXL28h
 NrBvAXE6QHVK2mUNGqxc36/lRElOKGSv9R9kgQ5OOVI+rFSImBPsqh9NywYl2FCI/ffiYGx
 UzIFaW8nKVjB3WZPa8XIhhvGglpAEqQDdRJB2ph2OPAbpF3/sudBMhAemmqgc9zLmKuNGpb
 kT3ltigDwFTH5EZ/6mnLDzWUzu72aqKHQ9rUQudTPDcl7vl31w9KO+cOET3hhaQJbzUnFNK
 KcmghUoMfRWQkZzgtyVaCqaRfI7XKb9rtQsyClQb6Vwf5vMkCbyCnefxf7fA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 0031F160966;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id D9AAA20132; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 09/35] mm: add do_handle_mm_fault()
Date:   Fri, 28 Jan 2022 05:09:40 -0800
Message-Id: <20220128131006.67712-10-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new do_handle_mm_fault function, which extends the existing
handle_mm_fault() API by adding an mmap sequence count, to be used
in the FAULT_FLAG_SPECULATIVE case.

In the initial implementation, FAULT_FLAG_SPECULATIVE always fails
(by returning VM_FAULT_RETRY).

The existing handle_mm_fault() API is kept as a wrapper around
do_handle_mm_fault() so that we do not have to immediately update
every handle_mm_fault() call site.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm.h | 12 +++++++++---
 mm/memory.c        | 10 +++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7f7aa3f0a396..4600dbb98cef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1851,9 +1851,15 @@ int generic_error_remove_page(struct address_space *mapping, struct page *page);
 int invalidate_inode_page(struct page *page);
 
 #ifdef CONFIG_MMU
-extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
-				  unsigned long address, unsigned int flags,
-				  struct pt_regs *regs);
+extern vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		unsigned long seq, struct pt_regs *regs);
+static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		struct pt_regs *regs)
+{
+	return do_handle_mm_fault(vma, address, flags, 0, regs);
+}
 extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
diff --git a/mm/memory.c b/mm/memory.c
index f83e06b1dafb..aa24cd8c06e9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4761,11 +4761,15 @@ static inline void mm_account_fault(struct pt_regs *regs,
  * The mmap_lock may have been released depending on flags and our
  * return value.  See filemap_fault() and __folio_lock_or_retry().
  */
-vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
-			   unsigned int flags, struct pt_regs *regs)
+vm_fault_t do_handle_mm_fault(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		unsigned long seq, struct pt_regs *regs)
 {
 	vm_fault_t ret;
 
+	if (flags & FAULT_FLAG_SPECULATIVE)
+		return VM_FAULT_RETRY;
+
 	__set_current_state(TASK_RUNNING);
 
 	count_vm_event(PGFAULT);
@@ -4807,7 +4811,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(handle_mm_fault);
+EXPORT_SYMBOL_GPL(do_handle_mm_fault);
 
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
-- 
2.20.1

