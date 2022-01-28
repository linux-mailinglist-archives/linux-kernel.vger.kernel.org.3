Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF249FA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbiA1NTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244893AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB293C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:07 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=oZA2R37ZdQsPKRya4evD/1AxU5M2JserIU8FqrANBD0=;
 b=qW+sQ7HyABXKBsze8DrBwRseqXMce9RCfxlhrUvp9AMkFrpRRy4fHhhD3Kt+/3yVzvqTr
 yudQB2bVFoLPLJEBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=oZA2R37ZdQsPKRya4evD/1AxU5M2JserIU8FqrANBD0=;
 b=CTWnbr/BOodTzck8x1znoxdaW3l5DVCyKQbkGJ8mGFqrhPK4thb9kYgNu/C+uBXfuICLr
 WB6qqJHNs96os/5WLhVkJGSRdtV8229d8QKw3uzPFMxnADFVZ1yziiZTrVi18UYqSryWkSa
 OV0ZaV7NTu7wdGC9yxpIx7lPT1rMwu6hc+cRdXSy9x9rSRuU4CAQh+oYgx4k3e7d3AoGtPU
 MgSSDjF6szOCkRHrmG69ho3BWQFZUDfi/TX4AUolM5NFpi5kPy00kdGGkMpj/1WfIJ9e7s4
 EodZMIXxQC1pAukAcCBnXNhuzahxpjbkJbbWVbP85BvMtgdKmGCMyhKNmd5w==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 04071160968;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id DC56A2023B; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 10/35] mm: add per-mm mmap sequence counter for speculative page fault handling.
Date:   Fri, 28 Jan 2022 05:09:41 -0800
Message-Id: <20220128131006.67712-11-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counter's write side is hooked into the existing mmap locking API:
mmap_write_lock() increments the counter to the next (odd) value, and
mmap_write_unlock() increments it again to the next (even) value.

The counter's speculative read side is supposed to be used as follows:

seq = mmap_seq_read_start(mm);
if (seq & 1)
	goto fail;
.... speculative handling here ....
if (!mmap_seq_read_check(mm, seq)
	goto fail;

This API guarantees that, if none of the "fail" tests abort
speculative execution, the speculative code section did not run
concurrently with any mmap writer.

This is very similar to a seqlock, but both the writer and speculative
readers are allowed to block. In the fail case, the speculative reader
does not spin on the sequence counter; instead it should fall back to
a different mechanism such as grabbing the mmap lock read side.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mm_types.h  |  4 +++
 include/linux/mmap_lock.h | 58 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0ae3bf854aad..e4965a6f34f2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -523,6 +523,10 @@ struct mm_struct {
 		 * cacheline.
 		 */
 		struct rw_semaphore mmap_lock;
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+		unsigned long mmap_seq;
+#endif
+
 
 		struct list_head mmlist; /* List of maybe swapped mm's.	These
 					  * are globally strung together off
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 1b14468183d7..a2459eb15a33 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -8,8 +8,16 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/types.h>
 
-#define MMAP_LOCK_INITIALIZER(name) \
-	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+#define MMAP_LOCK_SEQ_INITIALIZER(name) \
+	.mmap_seq = 0,
+#else
+#define MMAP_LOCK_SEQ_INITIALIZER(name)
+#endif
+
+#define MMAP_LOCK_INITIALIZER(name)				\
+	.mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),	\
+	MMAP_LOCK_SEQ_INITIALIZER(name)
 
 DECLARE_TRACEPOINT(mmap_lock_start_locking);
 DECLARE_TRACEPOINT(mmap_lock_acquire_returned);
@@ -63,13 +71,52 @@ static inline void __mmap_lock_trace_released(struct mm_struct *mm, bool write)
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	mm->mmap_seq = 0;
+#endif
 }
 
+static inline void __mmap_seq_write_lock(struct mm_struct *mm)
+{
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	VM_BUG_ON_MM(mm->mmap_seq & 1, mm);
+	mm->mmap_seq++;
+	smp_wmb();
+#endif
+}
+
+static inline void __mmap_seq_write_unlock(struct mm_struct *mm)
+{
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+	smp_wmb();
+	mm->mmap_seq++;
+	VM_BUG_ON_MM(mm->mmap_seq & 1, mm);
+#endif
+}
+
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+static inline unsigned long mmap_seq_read_start(struct mm_struct *mm)
+{
+	unsigned long seq;
+
+	seq = READ_ONCE(mm->mmap_seq);
+	smp_rmb();
+	return seq;
+}
+
+static inline bool mmap_seq_read_check(struct mm_struct *mm, unsigned long seq)
+{
+	smp_rmb();
+	return seq == READ_ONCE(mm->mmap_seq);
+}
+#endif
+
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
+	__mmap_seq_write_lock(mm);
 }
 
 static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
@@ -77,6 +124,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
+	__mmap_seq_write_lock(mm);
 }
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
@@ -86,6 +134,8 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 	__mmap_lock_trace_start_locking(mm, true);
 	error = down_write_killable(&mm->mmap_lock);
 	__mmap_lock_trace_acquire_returned(mm, true, !error);
+	if (likely(!error))
+		__mmap_seq_write_lock(mm);
 	return error;
 }
 
@@ -96,18 +146,22 @@ static inline bool mmap_write_trylock(struct mm_struct *mm)
 	__mmap_lock_trace_start_locking(mm, true);
 	ok = down_write_trylock(&mm->mmap_lock) != 0;
 	__mmap_lock_trace_acquire_returned(mm, true, ok);
+	if (likely(ok))
+		__mmap_seq_write_lock(mm);
 	return ok;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
+	__mmap_seq_write_unlock(mm);
 	up_write(&mm->mmap_lock);
 }
 
 static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 	__mmap_lock_trace_acquire_returned(mm, false, true);
+	__mmap_seq_write_unlock(mm);
 	downgrade_write(&mm->mmap_lock);
 }
 
-- 
2.20.1

