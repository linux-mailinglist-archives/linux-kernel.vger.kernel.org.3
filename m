Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AE14F2108
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiDECob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDECnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4030F3A37A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hUkP0cgtQwlbYC5UnwB6jjYdUXBTnNxAup2wyXqQZs=;
        b=H7fBJWYWCzHwWyTHtrz97oEcgfcSwc8y4dzLJq21ixoObioUmX2WF9+u70HaUPKNeOU2Fu
        2YhmVkbrKDj0VblLK0xMLgyQfcwjWabp9EX2uaaeq5x4mvyY73s5dF+XHvrZdrVUn177FO
        puCi2pj/qb8CJbpCHNbgEldFQ6+9q64=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-HJvA1abNNLaSql0eQ_sK4A-1; Mon, 04 Apr 2022 21:49:19 -0400
X-MC-Unique: HJvA1abNNLaSql0eQ_sK4A-1
Received: by mail-il1-f197.google.com with SMTP id d13-20020a056e02214d00b002ca4d440f73so1848533ilv.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hUkP0cgtQwlbYC5UnwB6jjYdUXBTnNxAup2wyXqQZs=;
        b=IlY8ngIBkKUGZyp9gDqVasHXVM27XD1JLb/KRhUsZYQ4Ij+kzC+uuSmZkSqQ1QECqf
         HkaGAImKXvx9qy3gcFvFeczFfM+nvYYG6yR8zAPZLXZyaLDaM5o1edo/5a79BktNkrVR
         mswgrKZR4SWmspBaoa2P+qYuUbBOFeEd3Dp6vJMIFh/F1I87xdv4HpbkW/zli7cmwK9D
         892So5QW9uVgMjkD65DShNCTfiK72NdcnONdpOEclH7clk97feSlCeX7UsrEFrYDGggI
         9SUr+9Zk6P0uinPHtNxQ74lQpeCm+/pcBiAeSO8TiOk0sCofaJ/PxOvXpkXFPfFwkv3G
         rxvA==
X-Gm-Message-State: AOAM533bfI2otFo+ucgCCBMhqh/6ah+ylZYTMH7+8LQxSXzuC9vNDHcT
        hvwncAz1i17+CqtGL4Z0fXOkn8eZ0HU2UJbSE9KVeESFKpxMCKlXfl6RbiX1hkVxEvmoknwkpLE
        prY7+3OKxjHABV+LM3MZ4tawdVJCpAzu/U0zBcngtpv6FXVALMP/X980dpWB+aOX1Yk3iwMZv+g
        ==
X-Received: by 2002:a02:85ac:0:b0:323:4099:dee0 with SMTP id d41-20020a0285ac000000b003234099dee0mr636222jai.189.1649123358273;
        Mon, 04 Apr 2022 18:49:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx10kJiNJ151ApjRhb7SjuIvmsEDPjVdezJB8ZAXTGrM1Yb6bc+vTyyR4bDx+mEDmR1g9tcNQ==
X-Received: by 2002:a02:85ac:0:b0:323:4099:dee0 with SMTP id d41-20020a0285ac000000b003234099dee0mr636201jai.189.1649123357903;
        Mon, 04 Apr 2022 18:49:17 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a3-20020a5ec303000000b006496b4dd21csm7250821iok.5.2022.04.04.18.49.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:17 -0700 (PDT)
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
Subject: [PATCH v8 17/23] mm/hugetlb: Only drop uffd-wp special pte if required
Date:   Mon,  4 Apr 2022 21:49:15 -0400
Message-Id: <20220405014915.14873-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
index 99c7477cee5c..8b5b9df2be7d 100644
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
index 578c48ef931a..e4af8b357b90 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4947,7 +4947,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 
 static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
-				   struct page *ref_page)
+				   struct page *ref_page, unsigned long zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -5003,7 +5003,18 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
@@ -5031,7 +5042,11 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
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
 
@@ -5065,9 +5080,10 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 
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
@@ -5083,12 +5099,13 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
 
@@ -5143,7 +5160,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (!is_vma_resv_set(iter_vma, HPAGE_RESV_OWNER))
 			unmap_hugepage_range(iter_vma, address,
-					     address + huge_page_size(h), page);
+					     address + huge_page_size(h), page, 0);
 	}
 	i_mmap_unlock_write(mapping);
 }
diff --git a/mm/memory.c b/mm/memory.c
index 8ba1bb196095..9808edfe18d4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1675,8 +1675,11 @@ static void unmap_single_vma(struct mmu_gather *tlb,
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

