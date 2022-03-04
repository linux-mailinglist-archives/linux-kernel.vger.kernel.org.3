Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB53F4CCCF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiCDFUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbiCDFUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEE04182BE9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7O5uZll4sV1zFyOKkIfzUXmTvhYgtYwRuXLomdEwgYM=;
        b=c+01xZcWsWWnqKBYokd5JeJT5fc5GvN7XJAJ2C3iv2zKUVu9eHun2d2s4wod6QAxwcVQa4
        Ta8E/9Bdj52Jp5cRkHDz5vpSvwCcRWCdNvWEmd3znxg3JQxl48Ucf9nhyXEQd+lMeVKQW5
        CU3ww06HdvJEzdeH1YDmPsWEKdOe8CY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-3jyxDXRFPaK7qlAQhQ0Yig-1; Fri, 04 Mar 2022 00:19:17 -0500
X-MC-Unique: 3jyxDXRFPaK7qlAQhQ0Yig-1
Received: by mail-pf1-f200.google.com with SMTP id a23-20020aa794b7000000b004f6a3ac7a87so1396759pfl.23
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7O5uZll4sV1zFyOKkIfzUXmTvhYgtYwRuXLomdEwgYM=;
        b=iQG2qBnaheRa030MqY4deFu2yDr1ufFkf/FOnyBjsbI1pPhP8wHVA8fyGHaHpLADTR
         +FShsHpG5Uj9uS9qv0Ym7ijHAVZpoAYwM7jXBMQ0zcyantdJkcR17KDe3tLD96W4Mgyi
         qYzJONaG+l6r9Y2arP+x5k/dZFO/NFn4T1NFw3E1aSaUoW35amSDoqLqmn1EcdmdwJ3s
         oG37TBfBrLXN4kUQl2KJJESQXOAqnYFBYIaHgjoS6kT0mNXzSrn1Tx7zfQlZfS7+PRr8
         d2WFwwhooUaO7CYdBB85NATEa5dmRpBhhHxtmmzDCyAqCdafqh96ooL5CTXVWjAKShjV
         KZdw==
X-Gm-Message-State: AOAM531Bwmv0wZBwRg90sTolBlVuyMxpjhQ53uftNZjx3xSZRtKeNU2J
        dcQxxiLhzi6qNiIhoxR72FcdstP0OpVIs90eW5C8P2zlnSgDFTtQk3glOMcA1zFg0ZOQMDrm7C1
        NjH4G9OfP6S8CrMMrIOBZZNEI
X-Received: by 2002:a05:6a00:1a92:b0:4f0:edf6:83f5 with SMTP id e18-20020a056a001a9200b004f0edf683f5mr41896945pfv.31.1646371155355;
        Thu, 03 Mar 2022 21:19:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjpsXb3Z+my2n7fkg0RxYfFGgIXvxEsSLrg+d/2jd0WAHT4xitgJREhUKjI7MHFmmcFfIeRA==
X-Received: by 2002:a05:6a00:1a92:b0:4f0:edf6:83f5 with SMTP id e18-20020a056a001a9200b004f0edf683f5mr41896931pfv.31.1646371155050;
        Thu, 03 Mar 2022 21:19:15 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:14 -0800 (PST)
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
Subject: [PATCH v7 14/23] mm/hugetlb: Handle UFFDIO_WRITEPROTECT
Date:   Fri,  4 Mar 2022 13:16:59 +0800
Message-Id: <20220304051708.86193-15-peterx@redhat.com>
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

This starts from passing cp_flags into hugetlb_change_protection() so hugetlb
will be able to handle MM_CP_UFFD_WP[_RESOLVE] requests.

huge_pte_clear_uffd_wp() is introduced to handle the case where the
UFFDIO_WRITEPROTECT is requested upon migrating huge page entries.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 13 ++++++++++++-
 mm/mprotect.c           |  3 ++-
 mm/userfaultfd.c        |  8 ++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6347298778b6..38c5ac28b787 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -210,7 +210,8 @@ struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot);
+		unsigned long address, unsigned long end, pgprot_t newprot,
+		unsigned long cp_flags);
 
 bool is_hugetlb_entry_migration(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
@@ -391,7 +392,8 @@ static inline void move_hugetlb_state(struct page *oldpage,
 
 static inline unsigned long hugetlb_change_protection(
 			struct vm_area_struct *vma, unsigned long address,
-			unsigned long end, pgprot_t newprot)
+			unsigned long end, pgprot_t newprot,
+			unsigned long cp_flags)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b094359255f7..396d5a516d05 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6151,7 +6151,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -6161,6 +6162,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -6202,6 +6205,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				entry = make_readable_migration_entry(
 							swp_offset(entry));
 				newpte = swp_entry_to_pte(entry);
+				if (uffd_wp)
+					newpte = pte_swp_mkuffd_wp(newpte);
+				else if (uffd_wp_resolve)
+					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
 						     newpte, huge_page_size(h));
 				pages++;
@@ -6216,6 +6223,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
 			pte = huge_pte_modify(old_pte, newprot);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
+			if (uffd_wp)
+				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+			else if (uffd_wp_resolve)
+				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 95b307d4766d..1b98e29316b6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -451,7 +451,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot);
+		pages = hugetlb_change_protection(vma, start, end, newprot,
+						  cp_flags);
 	else
 		pages = change_protection_range(vma, start, end, newprot,
 						cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 54e58f0d93e4..441728732033 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -704,6 +704,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
+	unsigned long page_mask;
 	pgprot_t newprot;
 	int err;
 
@@ -740,6 +741,13 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	if (!vma_is_anonymous(dst_vma))
 		goto out_unlock;
 
+	if (is_vm_hugetlb_page(dst_vma)) {
+		err = -EINVAL;
+		page_mask = vma_kernel_pagesize(dst_vma) - 1;
+		if ((start & page_mask) || (len & page_mask))
+			goto out_unlock;
+	}
+
 	if (enable_wp)
 		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
 	else
-- 
2.32.0

