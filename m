Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FF84CCCFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiCDFUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiCDFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10995186225
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3A1Sw4gSLvq3WpWIO0c1Ts85eaL9QjEv2hQ97BtHXI=;
        b=HmdgJAZ8zrF1KvAZn7ZTifd4/4NGqTA5dHAFWSt58JmrtZ2aNqEuzaFywBPwiSVVatFSEk
        hSEMtsSFQgRpQaTcHzPYsJkhvlNyarL96qa+mRZ3kaSkm5KGQlmD7vNiN4mmEAb5MYQa89
        9KDBJS9K/WSwlVmhowBuqrnmng4jGk4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-kg2NmLfVND2FP1Ik24wbMw-1; Fri, 04 Mar 2022 00:19:40 -0500
X-MC-Unique: kg2NmLfVND2FP1Ik24wbMw-1
Received: by mail-pf1-f200.google.com with SMTP id j204-20020a6280d5000000b004e107ad3488so4454269pfd.15
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3A1Sw4gSLvq3WpWIO0c1Ts85eaL9QjEv2hQ97BtHXI=;
        b=RTsGWwC6V4PorcwCyYzXhZEQcOGg7VyWVFpU4/on1utaq3qneHe2qXgFJMZWi56FKx
         I2fM+LrDCTM0lrh50ss/bgyftRdrrhvhoz3O2gs6FRiOQUhSgK/ywrJKeZ4q+Be9gpVe
         c1eEoteruvOy5jO8yfZ1HDOMKmHqQ0QNdaT4RPHIjmGJWFkUZF3moZdT+NW0GLxk7ALg
         Khouo5t9GqODIAvFhObcLwSR0RtE4eo538rsRJbnpD/F58FlExDn4CQmfeqFQRWBy06W
         bVBEng8J0EYtRP18GDFyC0Id4VRa2J4hS4LpnN6fMXWlKDmR7LN9H+jOnY994Hqd+3G7
         fv9A==
X-Gm-Message-State: AOAM533ai/59ZNmsJZXNFJ94hxfZsEIJCH7OlzNS8MCbATl5ov+u701b
        9MXU2IO39bjYPdyO3X+5QpFz5vXWLdBZtwuk7MxH0D6ETnCz/j72brknvEUnmUopYBVDVrC4Bn2
        7rKl7uR9JSrRxXLs+Y3ZppAyD
X-Received: by 2002:a17:902:b908:b0:151:b8ec:2038 with SMTP id bf8-20020a170902b90800b00151b8ec2038mr2680076plb.76.1646371179418;
        Thu, 03 Mar 2022 21:19:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0oSKjLHhzbwnFEI3D/leuju9Hh++AWa1WGIDqEaacCZODw/P1z3OkOVq6mvSOA7JhcqdiMA==
X-Received: by 2002:a17:902:b908:b0:151:b8ec:2038 with SMTP id bf8-20020a170902b90800b00151b8ec2038mr2680056plb.76.1646371179057;
        Thu, 03 Mar 2022 21:19:39 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:38 -0800 (PST)
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
Subject: [PATCH v7 17/23] mm/hugetlb: Only drop uffd-wp special pte if required
Date:   Fri,  4 Mar 2022 13:17:02 +0800
Message-Id: <20220304051708.86193-18-peterx@redhat.com>
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

As with shmem uffd-wp special ptes, only drop the uffd-wp special swap pte if
unmapping an entire vma or synchronized such that faults can not race with the
unmap operation.  This requires passing zap_flags all the way to the lowest
level hugetlb unmap routine: __unmap_hugepage_range.

In general, unmap calls originated in hugetlbfs code will pass the
ZAP_FLAG_DROP_MARKER flag as synchronization is in place to prevent faults.
The exception is hole punch which will first unmap without any synchronization.
Later when hole punch actually removes the page from the file, it will check to
see if there was a subsequent fault and if so take the hugetlb fault mutex
while unmapping again.  This second unmap will pass in ZAP_FLAG_DROP_MARKER.

The justification of "whether to apply ZAP_FLAG_DROP_MARKER flag when unmap a
hugetlb range" is (IMHO): we should never reach a state when a page fault could
errornously fault in a page-cache page that was wr-protected to be writable,
even in an extremely short period.  That could happen if e.g. we pass
ZAP_FLAG_DROP_MARKER when hugetlbfs_punch_hole() calls hugetlb_vmdelete_list(),
because if a page faults after that call and before remove_inode_hugepages() is
executed, the page cache can be mapped writable again in the small racy window,
that can cause unexpected data overwritten.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/hugetlbfs/inode.c    | 15 +++++++++------
 include/linux/hugetlb.h |  8 +++++---
 mm/hugetlb.c            | 33 +++++++++++++++++++++++++--------
 mm/memory.c             |  5 ++++-
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 171212bdaae6..d017c674f1b8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -404,7 +404,8 @@ static void remove_huge_page(struct page *page)
 }
 
 static void
-hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
+hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
+		      unsigned long zap_flags)
 {
 	struct vm_area_struct *vma;
 
@@ -438,7 +439,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
 		}
 
 		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
-									NULL);
+				     NULL, zap_flags);
 	}
 }
 
@@ -516,7 +517,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 				mutex_lock(&hugetlb_fault_mutex_table[hash]);
 				hugetlb_vmdelete_list(&mapping->i_mmap,
 					index * pages_per_huge_page(h),
-					(index + 1) * pages_per_huge_page(h));
+					(index + 1) * pages_per_huge_page(h),
+					ZAP_FLAG_DROP_MARKER);
 				i_mmap_unlock_write(mapping);
 			}
 
@@ -582,7 +584,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 	i_mmap_lock_write(mapping);
 	i_size_write(inode, offset);
 	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
-		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
+		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
+				      ZAP_FLAG_DROP_MARKER);
 	i_mmap_unlock_write(mapping);
 	remove_inode_hugepages(inode, offset, LLONG_MAX);
 }
@@ -615,8 +618,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		i_mmap_lock_write(mapping);
 		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
 			hugetlb_vmdelete_list(&mapping->i_mmap,
-						hole_start >> PAGE_SHIFT,
-						hole_end  >> PAGE_SHIFT);
+					      hole_start >> PAGE_SHIFT,
+					      hole_end >> PAGE_SHIFT, 0);
 		i_mmap_unlock_write(mapping);
 		remove_inode_hugepages(inode, hole_start, hole_end);
 		inode_unlock(inode);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 38c5ac28b787..ab48b3bbb0e6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -143,11 +143,12 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 unsigned long *, unsigned long *, long, unsigned int,
 			 int *);
 void unmap_hugepage_range(struct vm_area_struct *,
-			  unsigned long, unsigned long, struct page *);
+			  unsigned long, unsigned long, struct page *,
+			  unsigned long);
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
-			  struct page *ref_page);
+			  struct page *ref_page, unsigned long zap_flags);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
@@ -400,7 +401,8 @@ static inline unsigned long hugetlb_change_protection(
 
 static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, struct page *ref_page)
+			unsigned long end, struct page *ref_page,
+			unsigned long zap_flags)
 {
 	BUG();
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a20be29ac3a..994d7a3ee871 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4931,7 +4931,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 
 static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
-				   struct page *ref_page)
+				   struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -4987,7 +4987,18 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		 * unmapped and its refcount is dropped, so just clear pte here.
 		 */
 		if (unlikely(!pte_present(pte))) {
-			huge_pte_clear(mm, address, ptep, sz);
+			/*
+			 * If the pte was wr-protected by uffd-wp in any of the
+			 * swap forms, meanwhile the caller does not want to
+			 * drop the uffd-wp bit in this zap, then replace the
+			 * pte with a marker.
+			 */
+			if (pte_swp_uffd_wp_any(pte) &&
+			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP));
+			else
+				huge_pte_clear(mm, address, ptep, sz);
 			spin_unlock(ptl);
 			continue;
 		}
@@ -5015,7 +5026,11 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
-
+		/* Leave a uffd-wp pte marker if needed */
+		if (huge_pte_uffd_wp(pte) &&
+		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
+			set_huge_pte_at(mm, address, ptep,
+					make_pte_marker(PTE_MARKER_UFFD_WP));
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, vma, true);
 
@@ -5049,9 +5064,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 
 void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page)
+			  unsigned long end, struct page *ref_page,
+			  unsigned long zap_flags)
 {
-	__unmap_hugepage_range(tlb, vma, start, end, ref_page);
+	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
 
 	/*
 	 * Clear this flag so that x86's huge_pmd_share page_table_shareable
@@ -5067,12 +5083,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page)
+			  unsigned long end, struct page *ref_page,
+			  unsigned long zap_flags)
 {
 	struct mmu_gather tlb;
 
 	tlb_gather_mmu(&tlb, vma->vm_mm);
-	__unmap_hugepage_range(&tlb, vma, start, end, ref_page);
+	__unmap_hugepage_range(&tlb, vma, start, end, ref_page, zap_flags);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -5127,7 +5144,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index e9e335ecb5dc..43ab8d6c768e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1679,8 +1679,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			 * safe to do nothing in this case.
 			 */
 			if (vma->vm_file) {
+				unsigned long zap_flags = details ?
+				    details->zap_flags : 0;
 				i_mmap_lock_write(vma->vm_file->f_mapping);
-				__unmap_hugepage_range_final(tlb, vma, start, end, NULL);
+				__unmap_hugepage_range_final(tlb, vma, start, end,
+							     NULL, zap_flags);
 				i_mmap_unlock_write(vma->vm_file->f_mapping);
 			}
 		} else
-- 
2.32.0

