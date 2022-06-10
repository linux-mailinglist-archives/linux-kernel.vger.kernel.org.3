Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF5546C30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347442AbiFJSOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFJSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C586D1E3F7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654884885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=soKCAMxScYqxEBM+ZTaC0L8pFaIYy6HqJ4fvnPxOsvE=;
        b=T4prlz3JzgZA3PeK4Hh7N9mM1QoSKlfsR4rJC6SV/HOoLPP5N7ViEq37OZBj9fPE2upiw2
        RxUSiDfVfy4QoFkaoPx0Z25/dD7HjWvuiNVMEj4wwuR+PspgsbjuGfjAj5mmShkdOey1/a
        oByiN6B4kFlHkdAXghboHLqlG/FkvbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-4d3ceCLCMD-jYWFf-VzZKg-1; Fri, 10 Jun 2022 14:14:40 -0400
X-MC-Unique: 4d3ceCLCMD-jYWFf-VzZKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 404A4101A54E;
        Fri, 10 Jun 2022 18:14:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3F5B1121314;
        Fri, 10 Jun 2022 18:14:37 +0000 (UTC)
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
Subject: [PATCH v2] mm/mprotect: try avoiding write faults for exclusive anonymous pages when changing protection
Date:   Fri, 10 Jun 2022 20:14:36 +0200
Message-Id: <20220610181436.84713-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
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
optimization (avoiding write faults) during mprotect() with softdirty
tracking, where we require a write fault.

  Running 1000 iterations each

  ==========================================================
  Measuring memset() of 4096 bytes
   First write access:
    Min: 169 ns, Max: 8997 ns, Avg: 830 ns
   Second write access:
    Min: 80 ns, Max: 251 ns, Avg: 168 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 180 ns, Max: 290 ns, Avg: 190 ns
   Write access after clearing softdirty:
    Min: 451 ns, Max: 1774 ns, Avg: 470 ns
  -> mprotect = 1.131 * second [avg]
  -> mprotect = 0.404 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 4096 bytes
   First write access:
    Min: 761 ns, Max: 1152 ns, Avg: 784 ns
   Second write access:
    Min: 130 ns, Max: 181 ns, Avg: 137 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 150 ns, Max: 1553 ns, Avg: 155 ns
   Write access after clearing softdirty:
    Min: 169 ns, Max: 1783 ns, Avg: 432 ns
  -> mprotect = 1.131 * second [avg]
  -> mprotect = 0.359 * softdirty [avg]
  ==========================================================
  Measuring memset() of 16384 bytes
   First write access:
    Min: 1594 ns, Max: 3497 ns, Avg: 2143 ns
   Second write access:
    Min: 250 ns, Max: 381 ns, Avg: 260 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 290 ns, Max: 1643 ns, Avg: 300 ns
   Write access after clearing softdirty:
    Min: 1242 ns, Max: 8987 ns, Avg: 1297 ns
  -> mprotect = 1.154 * second [avg]
  -> mprotect = 0.231 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 16384 bytes
   First write access:
    Min: 1953 ns, Max: 2945 ns, Avg: 2008 ns
   Second write access:
    Min: 130 ns, Max: 912 ns, Avg: 142 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 160 ns, Max: 240 ns, Avg: 166 ns
   Write access after clearing softdirty:
    Min: 1112 ns, Max: 1513 ns, Avg: 1126 ns
  -> mprotect = 1.169 * second [avg]
  -> mprotect = 0.147 * softdirty [avg]
  ==========================================================
  Measuring memset() of 65536 bytes
   First write access:
    Min: 7524 ns, Max: 15650 ns, Avg: 7680 ns
   Second write access:
    Min: 251 ns, Max: 1323 ns, Avg: 648 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 270 ns, Max: 1282 ns, Avg: 736 ns
   Write access after clearing softdirty:
    Min: 4558 ns, Max: 12524 ns, Avg: 4623 ns
  -> mprotect = 1.136 * second [avg]
  -> mprotect = 0.159 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 65536 bytes
   First write access:
    Min: 7083 ns, Max: 9027 ns, Avg: 7241 ns
   Second write access:
    Min: 140 ns, Max: 201 ns, Avg: 156 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 190 ns, Max: 451 ns, Avg: 197 ns
   Write access after clearing softdirty:
    Min: 3707 ns, Max: 5119 ns, Avg: 3958 ns
  -> mprotect = 1.263 * second [avg]
  -> mprotect = 0.050 * softdirty [avg]
  ==========================================================
  Measuring memset() of 524288 bytes
   First write access:
    Min: 58470 ns, Max: 87754 ns, Avg: 59353 ns
   Second write access:
    Min: 5180 ns, Max: 6863 ns, Avg: 5318 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 5871 ns, Max: 9358 ns, Avg: 6028 ns
   Write access after clearing softdirty:
    Min: 35797 ns, Max: 41338 ns, Avg: 36710 ns
  -> mprotect = 1.134 * second [avg]
  -> mprotect = 0.164 * softdirty [avg]
  ----------------------------------------------------------
  Measuring single byte access per page of 524288 bytes
   First write access:
    Min: 53751 ns, Max: 59431 ns, Avg: 54506 ns
   Second write access:
    Min: 781 ns, Max: 2194 ns, Avg: 1123 ns
   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
    Min: 161 ns, Max: 1282 ns, Avg: 622 ns
   Write access after clearing softdirty:
    Min: 30888 ns, Max: 34565 ns, Avg: 31229 ns
  -> mprotect = 0.554 * second [avg]
  -> mprotect = 0.020 * softdirty [avg]

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

v1 -> v2:
* Rebased on v5.19-rc1
* Rerun benchmark
* Fix minor spelling issues in subject+description
* Drop IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) check
* Move pte_write() check into caller

---
 mm/mprotect.c | 67 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..728772bf41c7 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -38,6 +38,45 @@
 
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
@@ -46,7 +85,6 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	spinlock_t *ptl;
 	unsigned long pages = 0;
 	int target_node = NUMA_NO_NODE;
-	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
@@ -137,21 +175,26 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
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
+			if ((vma->vm_flags & VM_WRITE) && !pte_write(ptent) &&
+			    can_change_pte_writable(vma, addr, ptent, cp_flags))
 				ptent = pte_mkwrite(ptent);
-			}
+
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			if (pte_needs_flush(oldpte, ptent))
 				tlb_flush_pte_range(tlb, addr, PAGE_SIZE);

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.35.3

