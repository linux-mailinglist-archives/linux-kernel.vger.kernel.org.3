Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F53559FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFXRiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiFXRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9EF609EF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 130-20020a251288000000b0066c81091670so1025006ybs.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Prs/g0eAXOv/ZKQzs92554GHZM/jn5SpuUFUCkOXcEo=;
        b=Px4lWScALFzFiAT+UIjCnXt+kA7DjkP32e6aEOW4CwgMESdfSnOQVe0TMA2O89nVFQ
         2FSb4AFEEui36dp7cEO2cCeeW25R3wvs2P0Pw293UvGXo1bFkXyTw3c22GRwbp6ZeroB
         BKYDs88dfDTkiN+2kUji3gPFSrrfiflHbvNAwBPQkx1aAAnlNFHrCyf3UirmhSLZm9oL
         nyAorTU4OhiyKwV0sm0qey3GF9yE03pGEq+AkLOcUeZfuKYpmDNlnep1AHlKc5CHBoWs
         lchQ3wZR304ZcaHQH9yJaAqziuHYgjAFwrM+TJW+0jvW+Bqrs/0OMU3uJ876q5Jq/AM4
         BUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Prs/g0eAXOv/ZKQzs92554GHZM/jn5SpuUFUCkOXcEo=;
        b=b7WABfmSxiIwPUihl23DWHPBzquADWSYe3wpq28Xmh2npw83tf6RZW7Xh84noL2Pva
         6C7LHHh2Z+8pI4d1F/PnMLgkdNRNc/113DPOmLGKSpQE+PZZ8f0Z9kLuPayj9FFi7AQn
         IPm+KNAzTYSMHJ6iOTJZj7iavSb2ddjADtiR4FHWdDoSppwCGDL4c6FQ/OzUBjsKY1up
         rug4G0SUst7+Sj+/RN1BnrKIIHfCIKvD2g48Dq7XIlNpn55gFCCi+DHzYG7SkiacPtxl
         BOJVSPX1tfmdQVrynqOqDQJBXbuQeTGdlFFF53IuDHnV7kAY8n/mUoToPJXcDlER7Xrl
         H6VA==
X-Gm-Message-State: AJIora9/awiFIQ1WuPzPBJYg1QjQ1j43QkNj+PzOFcVywrNyPz97xBIB
        ydBhxQ1J74vAY0AgB6F7sQ1YJHM17hglEoXe
X-Google-Smtp-Source: AGRyM1vNqp1siTq4+vM6xRRCFB8ViZUf9ItF5XtUfUff2x9P2l161GxyqwN1706DB9irdsmvY90a1AH0gr7PPFum
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:b19a:0:b0:668:a921:310d with SMTP
 id h26-20020a25b19a000000b00668a921310dmr271313ybj.341.1656092235523; Fri, 24
 Jun 2022 10:37:15 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:34 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-5-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to handle PTL locking with high-granularity mapping. We
won't always be using the PMD-level PTL even if we're using the 2M
hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
case, we need to lock the PTL for the 4K PTE.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/powerpc/mm/pgtable.c |  3 ++-
 include/linux/hugetlb.h   | 19 ++++++++++++++-----
 mm/hugetlb.c              |  9 +++++----
 mm/migrate.c              |  3 ++-
 mm/page_vma_mapped.c      |  3 ++-
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index e6166b71d36d..663d591a8f08 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -261,7 +261,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 		psize = hstate_get_psize(h);
 #ifdef CONFIG_DEBUG_VM
-		assert_spin_locked(huge_pte_lockptr(h, vma->vm_mm, ptep));
+		assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),
+						    vma->vm_mm, ptep));
 #endif
 
 #else
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 498a4ae3d462..5fe1db46d8c9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -868,12 +868,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
+static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
 					   struct mm_struct *mm, pte_t *pte)
 {
-	if (huge_page_size(h) == PMD_SIZE)
+	if (shift == PMD_SHIFT)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
 	return &mm->page_table_lock;
 }
 
@@ -1076,7 +1075,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
+static inline spinlock_t *huge_pte_lockptr(unsigned int shift,
 					   struct mm_struct *mm, pte_t *pte)
 {
 	return &mm->page_table_lock;
@@ -1116,7 +1115,17 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 {
 	spinlock_t *ptl;
 
-	ptl = huge_pte_lockptr(h, mm, pte);
+	ptl = huge_pte_lockptr(huge_page_shift(h), mm, pte);
+	spin_lock(ptl);
+	return ptl;
+}
+
+static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
+					      struct mm_struct *mm, pte_t *pte)
+{
+	spinlock_t *ptl;
+
+	ptl = huge_pte_lockptr(shift, mm, pte);
 	spin_lock(ptl);
 	return ptl;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0eec34edf3b2..d6d0d4c03def 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4817,7 +4817,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			continue;
 
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(h, src, src_pte);
+		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
@@ -4894,7 +4894,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 
 				/* Install the new huge page if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
-				src_ptl = huge_pte_lockptr(h, src, src_pte);
+				src_ptl = huge_pte_lockptr(huge_page_shift(h),
+							   src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
@@ -4948,7 +4949,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	pte_t pte;
 
 	dst_ptl = huge_pte_lock(h, mm, dst_pte);
-	src_ptl = huge_pte_lockptr(h, mm, src_pte);
+	src_ptl = huge_pte_lockptr(huge_page_shift(h), mm, src_pte);
 
 	/*
 	 * We don't have to worry about the ordering of src and dst ptlocks
@@ -6024,7 +6025,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		page_in_pagecache = true;
 	}
 
-	ptl = huge_pte_lockptr(h, dst_mm, dst_pte);
+	ptl = huge_pte_lockptr(huge_page_shift(h), dst_mm, dst_pte);
 	spin_lock(ptl);
 
 	/*
diff --git a/mm/migrate.c b/mm/migrate.c
index e51588e95f57..a8a960992373 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -318,7 +318,8 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 void migration_entry_wait_huge(struct vm_area_struct *vma,
 		struct mm_struct *mm, pte_t *pte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
+	spinlock_t *ptl = huge_pte_lockptr(huge_page_shift(hstate_vma(vma)),
+					   mm, pte);
 	__migration_entry_wait(mm, pte, ptl);
 }
 
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index c10f839fc410..8921dd4e41b1 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -174,7 +174,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (!pvmw->pte)
 			return false;
 
-		pvmw->ptl = huge_pte_lockptr(hstate, mm, pvmw->pte);
+		pvmw->ptl = huge_pte_lockptr(huge_page_shift(hstate),
+					     mm, pvmw->pte);
 		spin_lock(pvmw->ptl);
 		if (!check_pte(pvmw))
 			return not_found(pvmw);
-- 
2.37.0.rc0.161.g10f37bed90-goog

