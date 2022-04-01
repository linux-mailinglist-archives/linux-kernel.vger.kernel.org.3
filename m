Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B84EEB13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244516AbiDAKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiDAKPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E11195DAE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648808021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DfvuPMWdvc4+G3JUpkqcya8XC3atgp6avWIwZAaEb+8=;
        b=NT2H2B6GwDDnWUsenpND4SkIOkqrI/rMrs7TH961nJqMjDeCav+NvwijE6iPyaMJiYY7LT
        Q4VW6jweByyIUBhgJ2QpR3hjdexkOEx6fZLqAoLd0XO9Rhn2lgBF8DKnV9SF3+yLNmpaQD
        zGb3wnJbKKsKPV4wrqa7xbTExkE9k+o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-lR0r3DxPPJ-1YlEArRg8QA-1; Fri, 01 Apr 2022 06:13:38 -0400
X-MC-Unique: lR0r3DxPPJ-1YlEArRg8QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42DB41C09056;
        Fri,  1 Apr 2022 10:13:38 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61B451400C2F;
        Fri,  1 Apr 2022 10:13:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v1 mmotm] mm/mprotect: try avoiding write faults for exclusive anonynmous pages when changing protection
Date:   Fri,  1 Apr 2022 12:13:34 +0200
Message-Id: <20220401101334.68859-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
can try mapping anonymous pages writable if they are exclusive,
the PTE is already dirty, and no special handling applies. Mapping the
PTE writable is essentially the same thing the write fault handler would do
in this case.

Special handling is required for uffd-wp and softdirty tracking, so take
care of that properly. Also, leave PROT_NONE handling alone for now;
in the future, we could similarly extend the logic in do_numa_page() or
use pte_mk_savedwrite() here. Note that we'll now also check for uffd-wp in
case of VM_SHARED -- which is harmless and prepares for uffd-wp support for
shmem.

While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
performance, it should also be a valuable optimization for uffd-wp, when
un-protecting.

Applying the same logic to PMDs (anonymous THP, anonymous hugetlb) is
probably not worth the trouble, but could similarly be added if there is
demand.

Results of a simple microbenchmark on my Ryzen 9 3900X, comparing the new
optimization (avoiding write faults) during mrprotect() with softdirty
tracking, where we require a write fault.

  Running 1000 iterations each

  ==========================================================
  Measuring memset() of 4096 bytes
   First write access:
    Min: 741 ns, Max: 3566 ns, Avg: 770 ns
   Second write access:
    Min: 150 ns, Max: 441 ns, Avg: 158 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 170 ns, Max: 420 ns, Avg: 177 ns
   Write access after clearing softdirty:
    Min: 440 ns, Max: 1533 ns, Avg: 454 ns
  -> mprotect = 1.120 * second [avg]
  -> mprotect = 0.390 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 4096 bytes
   First write access:
    Min: 281 ns, Max: 1022 ns, Avg: 732 ns
   Second write access:
    Min: 120 ns, Max: 160 ns, Avg: 129 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 140 ns, Max: 191 ns, Avg: 146 ns
   Write access after clearing softdirty:
    Min: 301 ns, Max: 561 ns, Avg: 416 ns
  -> mprotect = 1.132 * second [avg]
  -> mprotect = 0.351 * softdirty [avg]
  ==========================================================
  Measuring memset() of 16384 bytes
   First write access:
    Min: 1923 ns, Max: 3497 ns, Avg: 1986 ns
   Second write access:
    Min: 211 ns, Max: 310 ns, Avg: 249 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 9 ns, Max: 361 ns, Avg: 281 ns
   Write access after clearing softdirty:
    Min: 1203 ns, Max: 1974 ns, Avg: 1232 ns
  -> mprotect = 1.129 * second [avg]
  -> mprotect = 0.228 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 16384 bytes
   First write access:
    Min: 961 ns, Max: 9317 ns, Avg: 1855 ns
   Second write access:
    Min: 130 ns, Max: 171 ns, Avg: 132 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 150 ns, Max: 191 ns, Avg: 153 ns
   Write access after clearing softdirty:
    Min: 1061 ns, Max: 1513 ns, Avg: 1085 ns
  -> mprotect = 1.159 * second [avg]
  -> mprotect = 0.141 * softdirty [avg]
  ==========================================================
  Measuring memset() of 65536 bytes
   First write access:
    Min: 6933 ns, Max: 14366 ns, Avg: 7068 ns
   Second write access:
    Min: 601 ns, Max: 772 ns, Avg: 614 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 671 ns, Max: 7795 ns, Avg: 715 ns
   Write access after clearing softdirty:
    Min: 4238 ns, Max: 11703 ns, Avg: 4367 ns
  -> mprotect = 1.164 * second [avg]
  -> mprotect = 0.164 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 65536 bytes
   First write access:
    Min: 6082 ns, Max: 13866 ns, Avg: 6637 ns
   Second write access:
    Min: 130 ns, Max: 190 ns, Avg: 145 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 170 ns, Max: 992 ns, Avg: 184 ns
   Write access after clearing softdirty:
    Min: 3367 ns, Max: 4709 ns, Avg: 3759 ns
  -> mprotect = 1.269 * second [avg]
  -> mprotect = 0.049 * softdirty [avg]
  ==========================================================
  Measuring memset() of 524288 bytes
   First write access:
    Min: 54712 ns, Max: 86162 ns, Avg: 55544 ns
   Second write access:
    Min: 4989 ns, Max: 7714 ns, Avg: 5106 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 5561 ns, Max: 7044 ns, Avg: 5710 ns
   Write access after clearing softdirty:
    Min: 34224 ns, Max: 41848 ns, Avg: 34610 ns
  -> mprotect = 1.118 * second [avg]
  -> mprotect = 0.165 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 524288 bytes
   First write access:
    Min: 50695 ns, Max: 56617 ns, Avg: 51353 ns
   Second write access:
    Min: 390 ns, Max: 1553 ns, Avg: 1090 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 471 ns, Max: 2074 ns, Avg: 675 ns
   Write access after clearing softdirty:
    Min: 29115 ns, Max: 35076 ns, Avg: 29521 ns
  -> mprotect = 0.619 * second [avg]
  -> mprotect = 0.023 * softdirty [avg]

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This is based on:
	"[PATCH v2 00/15] mm: COW fixes part 2: reliable GUP pins of
	 anonymous pages"
-> https://lkml.kernel.org/r/20220315104741.63071-1-david@redhat.com

... which is in -mm but not yet in -next. Sending this out for early
discussion.

---
 mm/mprotect.c | 70 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 56060acdabd3..69770b547ec1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -36,6 +36,49 @@
 
 #include "internal.h"
 
+static inline bool can_change_pte_writable(struct vm_area_struct *vma,
+					   unsigned long addr, pte_t pte,
+					   unsigned long cp_flags)
+{
+	struct page *page;
+
+	if ((vma->vm_flags & VM_SHARED) && !(cp_flags & MM_CP_DIRTY_ACCT))
+		/*
+		 * MM_CP_DIRTY_ACCT is only expressive for shared mappings;
+		 * without MM_CP_DIRTY_ACCT, there is nothing to do.
+		 */
+		return false;
+
+	if (!(vma->vm_flags & VM_WRITE))
+		return false;
+
+	if (pte_write(pte) || pte_protnone(pte) || !pte_dirty(pte))
+		return false;
+
+	/* Do we need write faults for softdirty tracking? */
+	if (IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) && !pte_soft_dirty(pte) &&
+	    (vma->vm_flags & VM_SOFTDIRTY))
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
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags)
@@ -44,7 +87,6 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	spinlock_t *ptl;
 	unsigned long pages = 0;
 	int target_node = NUMA_NO_NODE;
-	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
@@ -133,21 +175,25 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
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
+			 * In both cases, we can sometimes still map PTEs
+			 * writable and avoid the write-fault handler, for
+			 * example, if the PTE is already dirty and no other
+			 * COW or special handling is required.
+			 */
+			if (can_change_pte_writable(vma, addr, ptent, cp_flags))
 				ptent = pte_mkwrite(ptent);
-			}
+
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
 		} else if (is_swap_pte(oldpte)) {
-- 
2.35.1

