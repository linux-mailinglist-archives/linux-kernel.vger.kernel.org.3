Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4809D4F21D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiDECnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDECnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51C442AE9CA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fw6KWLeUFN89OSB0e6nh5J0fTPBfve4te3QhwRo4Loc=;
        b=LUEylUBj5/6qb4WhFA/BsuRVsHZM/JmHgyEEgIlkR2WooOJ2QmMzHQ1jGAVA5BYkGnJVji
        QjZ0C9huFQhFdVynzG8GZ15Jhhp/q4Xr1ps6fcegNGDos2mLAYlG2YEtn4Hg6z7WZ69euJ
        a2fFGIHj71fGtLqbiwcHnGWge+2/Mhc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-rX5Fmf9mP729tvveIqKRzQ-1; Mon, 04 Apr 2022 21:48:48 -0400
X-MC-Unique: rX5Fmf9mP729tvveIqKRzQ-1
Received: by mail-il1-f197.google.com with SMTP id x1-20020a056e020f0100b002c98fce9c13so7221709ilj.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fw6KWLeUFN89OSB0e6nh5J0fTPBfve4te3QhwRo4Loc=;
        b=aB3SJyspUqmMxm7d9nV3lRVQA2ioCBs3REhZT4i0LsXyEPDWH/Z59Z1JSM0ozF2JmD
         8A+iPN9e96etRzQF8tmBBafeALA/DU7ebRJkNAQhhUSGSrMnpAwBR2Ry+ZBdPWmYgBCR
         NXk0jT+Sjme1L1nUtzYjd1OtfIYnJqd8wF4TnCMrhYOPJ1/AauAGJf0fMz7FI80yisM1
         lGGxrTnQn2VNODFUlG15Sm37mrPd8gYC7kjm/FyRR2Tk2hO1ZDLZRRRfMVHzuQxSLnFp
         4PSN5ACPqnH/JH/XclunIi+GmS/A+ph91K74SCPBF5XFvibw7+0fDaZjkDcxAYuJZM6X
         Jvgg==
X-Gm-Message-State: AOAM533JFaeZTE+5iTTVEe2am2+40GoH93QRXcAn2W0mfk+TtDyfnz9L
        i6hgoz6WtyDjt+1mFZjH7wGjROkVrVSLVsUISNTyMEywr6W3gK1XGFSsKTTUiVGNKQPb6n3XI/f
        2NMZVk/ZWP2+aR1+HEk5czlNre259fr/o3+mU7LB0YDRrX7G4JmAbZX/4ymuih5Lrq40tK99FHg
        ==
X-Received: by 2002:a92:6c0c:0:b0:2c7:ace3:7ecc with SMTP id h12-20020a926c0c000000b002c7ace37eccmr567927ilc.124.1649123327554;
        Mon, 04 Apr 2022 18:48:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx84rejRE/kakXdjuASUjJL9LRrkKumCkwNt6LzBT3SqnMgqMybL7GwNEjDRDEuJ5YeMeE60w==
X-Received: by 2002:a92:6c0c:0:b0:2c7:ace3:7ecc with SMTP id h12-20020a926c0c000000b002c7ace37eccmr567899ilc.124.1649123327154;
        Mon, 04 Apr 2022 18:48:47 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id m4-20020a0566022e8400b006463059bf2fsm7314659iow.49.2022.04.04.18.48.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 06/23] mm/shmem: Handle uffd-wp special pte in page fault handler
Date:   Mon,  4 Apr 2022 21:48:44 -0400
Message-Id: <20220405014844.14239-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memories are prone to unmap/swap so the ptes are always unstable,
because they can be easily faulted back later using the page cache.  This could
lead to uffd-wp getting lost when unmapping or swapping out such memory.  One
example is shmem.  PTE markers are needed to store those information.

This patch prepares it by handling uffd-wp pte markers first it is applied
elsewhere, so that the page fault handler can recognize uffd-wp pte markers.

The handling of uffd-wp pte markers is similar to missing fault, it's just that
we'll handle this "missing fault" when we see the pte markers, meanwhile we
need to make sure the marker information is kept during processing the fault.

This is a slow path of uffd-wp handling, because zapping of wr-protected shmem
ptes should be rare.  So far it should only trigger in two conditions:

  (1) When trying to punch holes in shmem_fallocate(), there is an optimization
      to zap the pgtables before evicting the page.

  (2) When swapping out shmem pages.

Because of this, the page fault handling is simplifed too by not sending the
wr-protect message in the 1st page fault, instead the page will be installed
read-only, so the uffd-wp message will be generated in the next fault, which
will trigger the do_wp_page() path of general uffd-wp handling.

Disable fault-around for all uffd-wp registered ranges for extra safety just
like uffd-minor fault, and clean the code up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 17 +++++++++
 mm/memory.c                   | 67 ++++++++++++++++++++++++++++++-----
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index bd09c3c89b59..827e38b7be65 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -96,6 +96,18 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
+/*
+ * Don't do fault around for either WP or MINOR registered uffd range.  For
+ * MINOR registered range, fault around will be a total disaster and ptes can
+ * be installed without notifications; for WP it should mostly be fine as long
+ * as the fault around checks for pte_none() before the installation, however
+ * to be super safe we just forbid it.
+ */
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
@@ -236,6 +248,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/mm/memory.c b/mm/memory.c
index b1af996b09ca..21abb8a30553 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3559,6 +3559,39 @@ static inline bool should_try_to_free_swap(struct page *page,
 		page_count(page) == 2;
 }
 
+static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	/*
+	 * Be careful so that we will only recover a special uffd-wp pte into a
+	 * none pte.  Otherwise it means the pte could have changed, so retry.
+	 */
+	if (is_pte_marker(*vmf->pte))
+		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
+}
+
+/*
+ * This is actually a page-missing access, but with uffd-wp special pte
+ * installed.  It means this pte was wr-protected before being unmapped.
+ */
+static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
+{
+	/*
+	 * Just in case there're leftover special ptes even after the region
+	 * got unregistered - we can simply clear them.  We can also do that
+	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
+	 * ranges, but it should be more efficient to be done lazily here.
+	 */
+	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+		return pte_marker_clear(vmf);
+
+	/* do_fault() can handle pte markers too like none pte */
+	return do_fault(vmf);
+}
+
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 {
 	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
@@ -3572,8 +3605,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
 		return VM_FAULT_SIGBUS;
 
-	/* TODO: handle pte markers */
-	return 0;
+	if (pte_marker_entry_uffd_wp(entry))
+		return pte_marker_handle_uffd_wp(vmf);
+
+	/* This is an unknown pte marker */
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -4157,6 +4193,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = pte_marker_uffd_wp(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -4171,6 +4208,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (unlikely(uffd_wp))
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -4344,9 +4383,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 }
 
+/* Return true if we should do read fault-around, false otherwise */
+static inline bool should_fault_around(struct vm_fault *vmf)
+{
+	/* No ->map_pages?  No way to fault around... */
+	if (!vmf->vma->vm_ops->map_pages)
+		return false;
+
+	if (uffd_disable_fault_around(vmf->vma))
+		return false;
+
+	return fault_around_bytes >> PAGE_SHIFT > 1;
+}
+
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
 	/*
@@ -4354,12 +4405,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		if (likely(!userfaultfd_minor(vmf->vma))) {
-			ret = do_fault_around(vmf);
-			if (ret)
-				return ret;
-		}
+	if (should_fault_around(vmf)) {
+		ret = do_fault_around(vmf);
+		if (ret)
+			return ret;
 	}
 
 	ret = __do_fault(vmf);
-- 
2.32.0

