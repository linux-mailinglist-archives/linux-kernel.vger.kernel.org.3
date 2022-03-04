Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4209C4CCCF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiCDFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiCDFUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13467184B75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wn3ILT0Lxv5s6XkvrMXIyY+ihJQ80lsNhwBboggDj0M=;
        b=d6XhGMTO4JNx7TAyA9UtAGDe203phBfwTEZExJPKqIBLVE8vZPC+SAUGKMXChBRGVoXRuX
        w8LfMPmAlnDIBr1M+Ly4ilu+jhJHqZxvs9rFdMUd2LFIRBmrhlTRFehwtIo7vjlHa88bNp
        ZZMdHXWe4s1xiNEMiXNecIrVBdRD0ac=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-YeHpyN9vP2GHZyPuREOxpw-1; Fri, 04 Mar 2022 00:19:49 -0500
X-MC-Unique: YeHpyN9vP2GHZyPuREOxpw-1
Received: by mail-pj1-f70.google.com with SMTP id m14-20020a17090a4d8e00b001bf2d4926c5so67406pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn3ILT0Lxv5s6XkvrMXIyY+ihJQ80lsNhwBboggDj0M=;
        b=7vjBfIsrbmiEvMibOVuJ1sIyNfq01UNwsDiCjFzJk0M2+IPxo84zd4U3VGjZZVw4f3
         i7MEKy2WCICcpz3oZqPreMjENHO3i7q+x3gT0YCwYq1ntJO+CmibOGNRpCqmNK9ZyYCA
         bJM9+hOy9BPrKA19/W85EkLYqr7wTj+EMNnIWGhxzFdCWfDOYpI3ZyxV/hWIZYAUO5JT
         fwGGu0eU8B4Y/MRSKMd4LZ1cD6Zmi7Nf+cvmRUbez3UU7vmSuzoHuVMB4XgFfo+C6nYk
         bu0RJD6ZwTt7inoIfcETSy4+xQBZeKPMf78mJNvQrsd4IqM5MzOShP+ezR6V87cNqWDc
         jrnw==
X-Gm-Message-State: AOAM533NERY5aGIoZ9dfKRELp2fM/FAJDA+Xb75WQvUqIA3i8w3mPvnZ
        OKRVf5mzu0Fhig33ftJw8RumHrxcf8AAerUE+CttVhGO32+L0GvMn0Y9HNGAipE8AgdLLZaCE1Z
        qaWwmnH9kHlBdMOv3l+W0iOYZ
X-Received: by 2002:a17:90a:f48f:b0:1bc:2521:fb0a with SMTP id bx15-20020a17090af48f00b001bc2521fb0amr9165163pjb.48.1646371187693;
        Thu, 03 Mar 2022 21:19:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycPvMgb2+JEX9mKyCqqvdoYelrEZ2x92Thb/SSCgHsoZmufdyixH7q1XZKq5P8YsP5zDuMwg==
X-Received: by 2002:a17:90a:f48f:b0:1bc:2521:fb0a with SMTP id bx15-20020a17090af48f00b001bc2521fb0amr9165135pjb.48.1646371187413;
        Thu, 03 Mar 2022 21:19:47 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:47 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 18/23] mm/hugetlb: Handle uffd-wp during fork()
Date:   Fri,  4 Mar 2022 13:17:03 +0800
Message-Id: <20220304051708.86193-19-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, we'll need to pass in dst_vma into copy_hugetlb_page_range() because
for uffd-wp it's the dst vma that matters on deciding how we should treat
uffd-wp protected ptes.

We should recognize pte markers during fork and do the pte copy if needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  7 +++++--
 mm/hugetlb.c            | 41 +++++++++++++++++++++++++++--------------
 mm/memory.c             |  2 +-
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ab48b3bbb0e6..6df51d23b7ee 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,7 +137,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     struct vm_area_struct *new_vma,
 			     unsigned long old_addr, unsigned long new_addr,
 			     unsigned long len);
-int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
+int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
+			    struct vm_area_struct *, struct vm_area_struct *);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
 			 unsigned long *, unsigned long *, long, unsigned int,
@@ -268,7 +269,9 @@ static inline struct page *follow_huge_addr(struct mm_struct *mm,
 }
 
 static inline int copy_hugetlb_page_range(struct mm_struct *dst,
-			struct mm_struct *src, struct vm_area_struct *vma)
+					  struct mm_struct *src,
+					  struct vm_area_struct *dst_vma,
+					  struct vm_area_struct *src_vma)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 994d7a3ee871..f2508620f197 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4696,23 +4696,24 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 }
 
 int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
-			    struct vm_area_struct *vma)
+			    struct vm_area_struct *dst_vma,
+			    struct vm_area_struct *src_vma)
 {
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
 	struct page *ptepage;
 	unsigned long addr;
-	bool cow = is_cow_mapping(vma->vm_flags);
-	struct hstate *h = hstate_vma(vma);
+	bool cow = is_cow_mapping(src_vma->vm_flags);
+	struct hstate *h = hstate_vma(src_vma);
 	unsigned long sz = huge_page_size(h);
 	unsigned long npages = pages_per_huge_page(h);
-	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct address_space *mapping = src_vma->vm_file->f_mapping;
 	struct mmu_notifier_range range;
 	int ret = 0;
 
 	if (cow) {
-		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, src,
-					vma->vm_start,
-					vma->vm_end);
+		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_vma, src,
+					src_vma->vm_start,
+					src_vma->vm_end);
 		mmu_notifier_invalidate_range_start(&range);
 	} else {
 		/*
@@ -4724,12 +4725,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		i_mmap_lock_read(mapping);
 	}
 
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
+	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte)
 			continue;
-		dst_pte = huge_pte_alloc(dst, vma, addr, sz);
+		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
 			break;
@@ -4764,6 +4765,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
 				    is_hugetlb_entry_hwpoisoned(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
+			bool uffd_wp = huge_pte_uffd_wp(entry);
 
 			if (is_writable_migration_entry(swp_entry) && cow) {
 				/*
@@ -4773,10 +4775,21 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				swp_entry = make_readable_migration_entry(
 							swp_offset(swp_entry));
 				entry = swp_entry_to_pte(swp_entry);
+				if (userfaultfd_wp(src_vma) && uffd_wp)
+					entry = huge_pte_mkuffd_wp(entry);
 				set_huge_swap_pte_at(src, addr, src_pte,
 						     entry, sz);
 			}
+			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
+		} else if (unlikely(is_pte_marker(entry))) {
+			/*
+			 * We copy the pte marker only if the dst vma has
+			 * uffd-wp enabled.
+			 */
+			if (userfaultfd_wp(dst_vma))
+				set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else {
 			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
@@ -4791,20 +4804,20 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * need to be without the pgtable locks since we could
 			 * sleep during the process.
 			 */
-			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+			if (unlikely(page_needs_cow_for_dma(src_vma, ptepage))) {
 				pte_t src_pte_old = entry;
 				struct page *new;
 
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				/* Do not use reserve as it's private owned */
-				new = alloc_huge_page(vma, addr, 1);
+				new = alloc_huge_page(dst_vma, addr, 1);
 				if (IS_ERR(new)) {
 					put_page(ptepage);
 					ret = PTR_ERR(new);
 					break;
 				}
-				copy_user_huge_page(new, ptepage, addr, vma,
+				copy_user_huge_page(new, ptepage, addr, dst_vma,
 						    npages);
 				put_page(ptepage);
 
@@ -4814,13 +4827,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 				entry = huge_ptep_get(src_pte);
 				if (!pte_same(src_pte_old, entry)) {
-					restore_reserve_on_error(h, vma, addr,
+					restore_reserve_on_error(h, dst_vma, addr,
 								new);
 					put_page(new);
 					/* dst_entry won't change as in child */
 					goto again;
 				}
-				hugetlb_install_page(vma, dst_pte, addr, new);
+				hugetlb_install_page(dst_vma, dst_pte, addr, new);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
diff --git a/mm/memory.c b/mm/memory.c
index 43ab8d6c768e..66c9890b7678 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1282,7 +1282,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return 0;
 
 	if (is_vm_hugetlb_page(src_vma))
-		return copy_hugetlb_page_range(dst_mm, src_mm, src_vma);
+		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
 		/*
-- 
2.32.0

