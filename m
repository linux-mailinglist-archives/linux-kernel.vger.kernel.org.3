Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098074CCD01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiCDFUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238126AbiCDFUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C8A9107D3B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RL3s2QRFkPddYKwSOJ6UpdW5WS1d6dwfLlTkzvd/MfY=;
        b=OMR3/FhwmI2Aw17NnjajbIUW4LVRM9lZqaW+PpF3UMA+c4No35aZnd1vKTiqm9jr7Aip97
        S9mmZ2WL73pM2nhdUCSyubpVkTdzmmmYTlEXfXCrUMJzsakCdGvevQ92qWWOIcATW20Woh
        oS6sOxgmfPWb4XAqrJNIpV4fWGaHFJE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-_Joiw8MbP6aI4RAdXKzltQ-1; Fri, 04 Mar 2022 00:19:09 -0500
X-MC-Unique: _Joiw8MbP6aI4RAdXKzltQ-1
Received: by mail-pl1-f199.google.com with SMTP id x6-20020a1709029a4600b0014efe26b04fso4075364plv.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RL3s2QRFkPddYKwSOJ6UpdW5WS1d6dwfLlTkzvd/MfY=;
        b=bSBvrmsYxstf/Wq0T3zsX7cEbYc+R8/1SSXtmcFtIr0rfLXk4c1SXCOYjUZh1dGPGw
         40vAUImgF4SwmDPaJDZfFj0gNXoDt2lHGUR87Fb+tO4yBTPNBcTm9RpAMx6PTDiKRaN8
         NY2bXhfwKiAocjfwhrvKc+UpgdXeth5DFjqlyvsWd65B4p+602DMDG3QW6nOFe75kYyw
         F69o5Rb9DgRIVSbYWi5WT05uPI+rGLO4FhAVg7xTEfWMa+z+cAAfo6pW+vyrCxNHn4hl
         sQvpxPwTIJSGO1iCXcq6ltqNOTIvY0bIqZP18bmacX8re4RUby+MfAbv6lyWyYLTiJ9B
         bMNA==
X-Gm-Message-State: AOAM5337c6YkwqJisXbq0avBZoi+2LPqZT9ZnLyiOttfQHtu07BY/1au
        KMTq9ya7KfMJQ1eCxPl8BY+RO5js9ulzyn0ANfuN4DLhYAEsigBiuNy+gePTQBVe4IGLDq9Rxh3
        xefv3sGktky49R7LBWaxtkzG8
X-Received: by 2002:a17:90a:6542:b0:1bd:149f:1c29 with SMTP id f2-20020a17090a654200b001bd149f1c29mr8883037pjs.240.1646371147291;
        Thu, 03 Mar 2022 21:19:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw98NhiPLfQ+4A3W3/3rIHdWYk9obskF5GhOKrRBQEImBHdUerNxlQUCrFQ/jhk98NTLdWLrQ==
X-Received: by 2002:a17:90a:6542:b0:1bd:149f:1c29 with SMTP id f2-20020a17090a654200b001bd149f1c29mr8883022pjs.240.1646371147002;
        Thu, 03 Mar 2022 21:19:07 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:06 -0800 (PST)
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
Subject: [PATCH v7 13/23] mm/hugetlb: Take care of UFFDIO_COPY_MODE_WP
Date:   Fri,  4 Mar 2022 13:16:58 +0800
Message-Id: <20220304051708.86193-14-peterx@redhat.com>
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

Pass the wp_copy variable into hugetlb_mcopy_atomic_pte() thoughout the stack.
Apply the UFFD_WP bit if UFFDIO_COPY_MODE_WP is with UFFDIO_COPY.

Hugetlb pages are only managed by hugetlbfs, so we're safe even without setting
dirty bit in the huge pte if the page is installed as read-only.  However we'd
better still keep the dirty bit set for a read-only UFFDIO_COPY pte (when
UFFDIO_COPY_MODE_WP bit is set), not only to match what we do with shmem, but
also because the page does contain dirty data that the kernel just copied from
the userspace.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 29 +++++++++++++++++++++++------
 mm/userfaultfd.c        | 14 +++++++++-----
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53c1b6082a4c..6347298778b6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -160,7 +160,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				enum mcopy_atomic_mode mode,
-				struct page **pagep);
+				struct page **pagep,
+				bool wp_copy);
 #endif /* CONFIG_USERFAULTFD */
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
@@ -355,7 +356,8 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						enum mcopy_atomic_mode mode,
-						struct page **pagep)
+						struct page **pagep,
+						bool wp_copy)
 {
 	BUG();
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d2539e2fe066..b094359255f7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5763,7 +5763,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 			    unsigned long dst_addr,
 			    unsigned long src_addr,
 			    enum mcopy_atomic_mode mode,
-			    struct page **pagep)
+			    struct page **pagep,
+			    bool wp_copy)
 {
 	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct hstate *h = hstate_vma(dst_vma);
@@ -5893,7 +5894,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release_unlock;
 
 	ret = -EEXIST;
-	if (!huge_pte_none(huge_ptep_get(dst_pte)))
+	/*
+	 * We allow to overwrite a pte marker: consider when both MISSING|WP
+	 * registered, we firstly wr-protect a none pte which has no page cache
+	 * page backing it, then access the page.
+	 */
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
 	if (vm_shared) {
@@ -5903,17 +5909,28 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
 	}
 
-	/* For CONTINUE on a non-shared VMA, don't set VM_WRITE for CoW. */
-	if (is_continue && !vm_shared)
+	/*
+	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
+	 * with wp flag set, don't set pte write bit.
+	 */
+	if (wp_copy || (is_continue && !vm_shared))
 		writable = 0;
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
 
 	_dst_pte = make_huge_pte(dst_vma, page, writable);
-	if (writable)
-		_dst_pte = huge_pte_mkdirty(_dst_pte);
+	/*
+	 * Always mark UFFDIO_COPY page dirty; note that this may not be
+	 * extremely important for hugetlbfs for now since swapping is not
+	 * supported, but we should still be clear in that this page cannot be
+	 * thrown away at will, even if write bit not set.
+	 */
+	_dst_pte = huge_pte_mkdirty(_dst_pte);
 	_dst_pte = pte_mkyoung(_dst_pte);
 
+	if (wp_copy)
+		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
+
 	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
 	(void)huge_ptep_set_access_flags(dst_vma, dst_addr, dst_pte, _dst_pte,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ef418a48b121..54e58f0d93e4 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -304,7 +304,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
-					      enum mcopy_atomic_mode mode)
+					      enum mcopy_atomic_mode mode,
+					      bool wp_copy)
 {
 	int vm_shared = dst_vma->vm_flags & VM_SHARED;
 	ssize_t err;
@@ -392,7 +393,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
 			err = -EEXIST;
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			i_mmap_unlock_read(mapping);
@@ -400,7 +401,8 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		err = hugetlb_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma,
-					       dst_addr, src_addr, mode, &page);
+					       dst_addr, src_addr, mode, &page,
+					       wp_copy);
 
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		i_mmap_unlock_read(mapping);
@@ -455,7 +457,8 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 				      unsigned long dst_start,
 				      unsigned long src_start,
 				      unsigned long len,
-				      enum mcopy_atomic_mode mode);
+				      enum mcopy_atomic_mode mode,
+				      bool wp_copy);
 #endif /* CONFIG_HUGETLB_PAGE */
 
 static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
@@ -575,7 +578,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
 		return  __mcopy_atomic_hugetlb(dst_mm, dst_vma, dst_start,
-						src_start, len, mcopy_mode);
+					       src_start, len, mcopy_mode,
+					       wp_copy);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.32.0

