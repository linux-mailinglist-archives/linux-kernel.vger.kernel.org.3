Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C14F21CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiDECon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDECnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 946163A37B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zpk9Li6fgqH75i55vcn3N+1Xng1FM6T4OSs35V/WwSY=;
        b=AuyFPVawAUTMJ7DgjsnuWVKTP92a4zATGCq9czhbUkniyPNlNBx8F7G2mJl+u9W8WICXeS
        PnreGcHGxhEvIyhXlRc6vGzjJu8bqKvesjgoUDFNjcl0DD6f7il9R7XTtbx+uijcYy9L01
        rN5PbCOzv85ng9HbNSZpMlsIM5wiEMQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-xScWbi0WPTSzR6cwXTV8kw-1; Mon, 04 Apr 2022 21:49:21 -0400
X-MC-Unique: xScWbi0WPTSzR6cwXTV8kw-1
Received: by mail-io1-f70.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso7462851ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zpk9Li6fgqH75i55vcn3N+1Xng1FM6T4OSs35V/WwSY=;
        b=VKpz4gxTpIoimHG+r1BGZLVN49XDMGXj/hlGnwqg+ANI7JGX+Nsb/3TyXXi4dAQlvi
         iVcbShGir11ibLLbFb+Zypr1s7K/MMuQYPwUJvRDwyCrCZ6Bm8kv+c9LYlqMKpvz+41n
         S0SNThP9FS2Edv2zslwtc43X5vD35VHousWgQe2IfrZFkaJxqn2jb3rJ50SO6vwb+T2O
         yv/1EwfstFcZN6nwh6ebGKAtlyXV2eFOW/oxaV3atqTpToBCpjnnQHDuAswX7QZZToo7
         cR37LSBn/3fFXRTtgvUzrHVjovlcN0VyTD2pI8a6xLCcrUr/np36PG9PeQNJryhPSWpM
         OvEw==
X-Gm-Message-State: AOAM531xjWnj6liRYlgIo26L75Jcu2/wQzR8D9DN2getyA9Ac7HRiZvl
        pSJmMhptdB6JEY706jqmyqZhPev/uWaEEU20PawPGWZjN4oIdVT1qbFkJHNBAFP5DRx9y2kpS+P
        UJ9GCw58MAfFuVDH+L1EyrBQWkWHxtvDALzzInIWTgTxbOCZqEaTQ3UpM8bY7EIda3Q8oTduWfw
        ==
X-Received: by 2002:a05:6638:164b:b0:323:ac42:8d4b with SMTP id a11-20020a056638164b00b00323ac428d4bmr693516jat.75.1649123361107;
        Mon, 04 Apr 2022 18:49:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDhrnP+UnjED6dnxAUMKpLm5xwk/WcwG2E8d8U2B2Tf/WxM+ICv/y59UNBKP9S5t8sm4pR1A==
X-Received: by 2002:a05:6638:164b:b0:323:ac42:8d4b with SMTP id a11-20020a056638164b00b00323ac428d4bmr693489jat.75.1649123360806;
        Mon, 04 Apr 2022 18:49:20 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id t1-20020a056e02060100b002ca41adce5dsm2355369ils.8.2022.04.04.18.49.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:20 -0700 (PDT)
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
Subject: [PATCH v8 18/23] mm/hugetlb: Handle uffd-wp during fork()
Date:   Mon,  4 Apr 2022 21:49:18 -0400
Message-Id: <20220405014918.14932-1-peterx@redhat.com>
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

Firstly, we'll need to pass in dst_vma into copy_hugetlb_page_range() because
for uffd-wp it's the dst vma that matters on deciding how we should treat
uffd-wp protected ptes.

We should recognize pte markers during fork and do the pte copy if needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  7 +++++--
 mm/hugetlb.c            | 42 +++++++++++++++++++++++++++--------------
 mm/memory.c             |  2 +-
 3 files changed, 34 insertions(+), 17 deletions(-)

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
index e4af8b357b90..e1571179698a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4706,23 +4706,24 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
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
 		mmap_assert_write_locked(src);
 		raw_write_seqcount_begin(&src->write_protect_seq);
@@ -4736,12 +4737,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -4776,6 +4777,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
 				    is_hugetlb_entry_hwpoisoned(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
+			bool uffd_wp = huge_pte_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(swp_entry) && cow) {
 				/*
@@ -4785,10 +4787,21 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -4806,20 +4819,21 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			if (!PageAnon(ptepage)) {
 				page_dup_file_rmap(ptepage, true);
-			} else if (page_try_dup_anon_rmap(ptepage, true, vma)) {
+			} else if (page_try_dup_anon_rmap(ptepage, true,
+							  src_vma)) {
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
 
@@ -4829,13 +4843,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
index 9808edfe18d4..d1e9c2517dfb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1278,7 +1278,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 		return 0;
 
 	if (is_vm_hugetlb_page(src_vma))
-		return copy_hugetlb_page_range(dst_mm, src_mm, src_vma);
+		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
 
 	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
 		/*
-- 
2.32.0

