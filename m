Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC854AD73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352521AbiFNJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiFNJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B64743AF7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655199397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0O29TeHPsb2Za/S4u6fCnNg6vUkIU4pC/LEpJrWXqWw=;
        b=do8tBHDAwwtQkqptEe0aBXV1GvJe2hq/IR+kO1VIMh2Wdby82RPyaiKgYJDOYh3KiQEDSq
        h0Y8x+ZCEEuTyLCpwCG/KgfMK2kX530x5IgOqGagzN6sZNhrFCk6s69xjCPZtoPLS9rmDd
        LDeuLwFeB9dQ5ljHaf4coaumMLnb0TM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-65Hjd6FqOMePd9zG_6Vwzw-1; Tue, 14 Jun 2022 05:36:34 -0400
X-MC-Unique: 65Hjd6FqOMePd9zG_6Vwzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0F1E29ABA3A;
        Tue, 14 Jun 2022 09:36:33 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA57F2166B26;
        Tue, 14 Jun 2022 09:36:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3] mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection
Date:   Tue, 14 Jun 2022 11:36:29 +0200
Message-Id: <20220614093629.76309-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
can try mapping anonymous pages in a private writable mapping writable if
they are exclusive, the PTE is already dirty, and no special handling
applies. Mapping the anonymous page writable is essentially the same thing
the write fault handler would do in this case.

Special handling is required for uffd-wp and softdirty tracking, so take
care of that properly. Also, leave PROT_NONE handling alone for now;
in the future, we could similarly extend the logic in do_numa_page() or
use pte_mk_savedwrite() here.

While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
performance, it should also be a valuable optimization for uffd-wp, when
un-protecting.

This has been previously suggested by Peter Collingbourne in [1],
relevant in the context of the Scudo memory allocator, before we had
PageAnonExclusive.

This commit doesn't add the same handling for PMDs (i.e., anonymous THP,
anonymous hugetlb); benchmark results from Andrea indicate that there
are minor performance gains, so it's might still be valuable to streamline
that logic for all anonymous pages in the future.

As we now also set MM_CP_DIRTY_ACCT for private mappings, let's rename
it to MM_CP_TRY_CHANGE_WRITABLE, to make it clearer what's actually
happening.

Micro-benchmark courtesy of Andrea:

===
 #define _GNU_SOURCE
 #include <sys/mman.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
 #include <unistd.h>

 #define SIZE (1024*1024*1024)

int main(int argc, char *argv[])
{
	char *p;
	if (posix_memalign((void **)&p, sysconf(_SC_PAGESIZE)*512, SIZE))
		perror("posix_memalign"), exit(1);
	if (madvise(p, SIZE, argc > 1 ? MADV_HUGEPAGE : MADV_NOHUGEPAGE))
		perror("madvise");
	explicit_bzero(p, SIZE);
	for (int loops = 0; loops < 40; loops++) {
		if (mprotect(p, SIZE, PROT_READ))
			perror("mprotect"), exit(1);
		if (mprotect(p, SIZE, PROT_READ|PROT_WRITE))
			perror("mprotect"), exit(1);
		explicit_bzero(p, SIZE);
	}
}
===

Results on my Ryzen 9 3900X:


Stock 10 runs (lower is better):   AVG 6.398s, STDEV 0.043
Patched 10 runs (lower is better): AVG 3.780s, STDEV 0.026

===

[1] https://lkml.kernel.org/r/20210429214801.2583336-1-pcc@google.com

Suggested-by: Peter Collingbourne <pcc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Collingbourne <pcc@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v2 -> v3:
* Check some VMA flags early and glue them to MM_CP_TRY_CHANGE_WRITABLE
* MM_CP_DIRTY_ACCT -> MM_CP_TRY_CHANGE_WRITABLE
* Use benchmark from Andrea and add updated results
* Add reference to Peter's patch
* Rephrase patch description + code comments

v1 -> v2:
* Rebased on v5.19-rc1
* Rerun benchmark
* Fix minor spelling issues in subject+description
* Drop IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) check
* Move pte_write() check into caller

---
 include/linux/mm.h |  8 +++--
 mm/mprotect.c      | 77 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..ae66d26dd708 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1962,8 +1962,12 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
  * for now all the callers are only use one of the flags at the same
  * time.
  */
-/* Whether we should allow dirty bit accounting */
-#define  MM_CP_DIRTY_ACCT                  (1UL << 0)
+/*
+ * Whether we should manually check if we can map individual PTEs writable,
+ * because something (e.g., COW, uffd-wp) blocks that from happening for all
+ * PTEs automatically in a writable mapping.
+ */
+#define  MM_CP_TRY_CHANGE_WRITABLE	   (1UL << 0)
 /* Whether this protection change is for NUMA hints */
 #define  MM_CP_PROT_NUMA                   (1UL << 1)
 /* Whether this change is for write protecting */
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..996a97e213ad 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -38,6 +38,39 @@
 
 #include "internal.h"
 
+static inline bool can_change_pte_writable(struct vm_area_struct *vma,
+					   unsigned long addr, pte_t pte)
+{
+	struct page *page;
+
+	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
+
+	if (pte_protnone(pte) || !pte_dirty(pte))
+		return false;
+
+	/* Do we need write faults for softdirty tracking? */
+	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
+		return false;
+
+	/* Do we need write faults for uffd-wp tracking? */
+	if (userfaultfd_pte_wp(vma, pte))
+		return false;
+
+	if (!(vma->vm_flags & VM_SHARED)) {
+		/*
+		 * We can only special-case on exclusive anonymous pages,
+		 * because we know that our write-fault handler similarly would
+		 * map them writable without any additional checks while holding
+		 * the PT lock.
+		 */
+		page = vm_normal_page(vma, addr, pte);
+		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
+			return false;
+	}
+
+	return true;
+}
+
 static unsigned long change_pte_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
@@ -46,7 +79,6 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	spinlock_t *ptl;
 	unsigned long pages = 0;
 	int target_node = NUMA_NO_NODE;
-	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
@@ -137,21 +169,27 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 				ptent = pte_wrprotect(ptent);
 				ptent = pte_mkuffd_wp(ptent);
 			} else if (uffd_wp_resolve) {
-				/*
-				 * Leave the write bit to be handled
-				 * by PF interrupt handler, then
-				 * things like COW could be properly
-				 * handled.
-				 */
 				ptent = pte_clear_uffd_wp(ptent);
 			}
 
-			/* Avoid taking write faults for known dirty pages */
-			if (dirty_accountable && pte_dirty(ptent) &&
-					(pte_soft_dirty(ptent) ||
-					 !(vma->vm_flags & VM_SOFTDIRTY))) {
+			/*
+			 * In some writable, shared mappings, we might want
+			 * to catch actual write access -- see
+			 * vma_wants_writenotify().
+			 *
+			 * In all writable, private mappings, we have to
+			 * properly handle COW.
+			 *
+			 * In both cases, we can sometimes still change PTEs
+			 * writable and avoid the write-fault handler, for
+			 * example, if a PTE is already dirty and no other
+			 * COW or special handling is required.
+			 */
+			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
+			    !pte_write(ptent) &&
+			    can_change_pte_writable(vma, addr, ptent))
 				ptent = pte_mkwrite(ptent);
-			}
+
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			if (pte_needs_flush(oldpte, ptent))
 				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);
@@ -505,9 +543,9 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	unsigned long oldflags = vma->vm_flags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	bool try_change_writable;
 	pgoff_t pgoff;
 	int error;
-	int dirty_accountable = 0;
 
 	if (newflags == oldflags) {
 		*pprev = vma;
@@ -583,11 +621,20 @@ mprotect_fixup(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
-	dirty_accountable = vma_wants_writenotify(vma, vma->vm_page_prot);
+	/*
+	 * We want to check manually if we can change individual PTEs writable
+	 * if we can't do that automatically for all PTEs in a mapping. For
+	 * private mappings, that's always the case when we have write
+	 * permissions as we properly have to handle COW.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		try_change_writable = vma_wants_writenotify(vma, vma->vm_page_prot);
+	else
+		try_change_writable = !!(vma->vm_flags & VM_WRITE);
 	vma_set_page_prot(vma);
 
 	change_protection(tlb, vma, start, end, vma->vm_page_prot,
-			  dirty_accountable ? MM_CP_DIRTY_ACCT : 0);
+			  try_change_writable ? MM_CP_TRY_CHANGE_WRITABLE : 0);
 
 	/*
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major

base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
-- 
2.35.3

