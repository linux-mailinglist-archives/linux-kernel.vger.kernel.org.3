Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C24F2196
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiDECoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiDECn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A30839E01A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYO5DrzO5I7Lh9p2TuEQvYaoFZvRSzMSA+DH3SoMHTo=;
        b=hfI+zQZ2Fpc5+9J7Z9vZA74QpYaddqdkrpG0LV/0PEgrHhP6VATbS1Xg5vZYGv75y9mJfG
        1h82ZTfy8LA9DWJj4FaqryB35ta28lemBLbtTQHYVhdSr/799A+gOlBAyIENs5VLW0YHh3
        QmPEAZODewV2ZH/JpJlu0X6k4ZJQ02U=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-Ox7s0Mu4OWaiIjGHp6_6HQ-1; Mon, 04 Apr 2022 21:49:11 -0400
X-MC-Unique: Ox7s0Mu4OWaiIjGHp6_6HQ-1
Received: by mail-io1-f69.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so7426698ioe.17
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYO5DrzO5I7Lh9p2TuEQvYaoFZvRSzMSA+DH3SoMHTo=;
        b=7SQvukmGTID62w810LkKX048UXSLayUiioMDDEENuzI8f+K1rYkBO/zMKIKJwHpde1
         OMoZoCzJd5L4aQ4oAuG0aFaUoggqH9BsOgwvfyiY/5m/zX15Qn9HUHQkRxkYrIhep/Ri
         xbLHGeCqVBvOED5N8kzZuPAH9dd6j1ceSQsl063dJMwhFYIBoxnlk8xQIKT4pUs8EOZn
         l9/uqcHO6kVSlWpHbklmI/GO1rGIsgpqtkwJdFyfA/5qK4QCfYDeVcprdjjuDbqdrv+h
         PV8NAEItWrrht+lKzNqdfvsCBXmBAdHWIz4CV+kJHjIS+w+p903A4DNhJn9FApmoWRuv
         Ak0Q==
X-Gm-Message-State: AOAM530ir97TpkFR/pdbMJvUnUB9yxK+fiZGKVeBeFmIdsas3pC7sZ+v
        2eq+sn17B7yymfWt5YOSH2qEZoHLVf5fKYmPBw1IGMWLRY2EyrF1azzhDMvW7bBc/b7f/F0VJam
        9lHcvj26D1vhZBMYOS+s5XIGYC2XyafHtecKaoZF7xNflaAtiBodgWgKFWpM5H8aXImRNT5Wn1A
        ==
X-Received: by 2002:a05:6e02:1aa8:b0:2c9:b67e:170a with SMTP id l8-20020a056e021aa800b002c9b67e170amr627234ilv.254.1649123349557;
        Mon, 04 Apr 2022 18:49:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIRnqjIx5iwXEGGjGc+n3hX5DRyLK+ATAlgFSZlW8F/klF7wxFnaQrfq2feLlPULuSJF4kVA==
X-Received: by 2002:a05:6e02:1aa8:b0:2c9:b67e:170a with SMTP id l8-20020a056e021aa800b002c9b67e170amr627210ilv.254.1649123349195;
        Mon, 04 Apr 2022 18:49:09 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id u15-20020a92d1cf000000b002ca56804ec4sm473939ilg.23.2022.04.04.18.49.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:08 -0700 (PDT)
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
Subject: [PATCH v8 14/23] mm/hugetlb: Handle UFFDIO_WRITEPROTECT
Date:   Mon,  4 Apr 2022 21:49:06 -0400
Message-Id: <20220405014906.14708-1-peterx@redhat.com>
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
index c94deead22b2..2401dd5997b7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6207,7 +6207,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
-		unsigned long address, unsigned long end, pgprot_t newprot)
+		unsigned long address, unsigned long end,
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long start = address;
@@ -6217,6 +6218,8 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * In the case of shared PMDs, the area to flush could be beyond
@@ -6263,6 +6266,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
@@ -6277,6 +6284,10 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
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
index e0a567b66d07..6b0e8c213508 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -455,7 +455,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
 
 	if (is_vm_hugetlb_page(vma))
-		pages = hugetlb_change_protection(vma, start, end, newprot);
+		pages = hugetlb_change_protection(vma, start, end, newprot,
+						  cp_flags);
 	else
 		pages = change_protection_range(vma, start, end, newprot,
 						cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index da0b3ed2a6b5..58d67f2bf980 100644
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

