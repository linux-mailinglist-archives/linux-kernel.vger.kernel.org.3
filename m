Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD44CCD00
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiCDFUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiCDFUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:20:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBDF3182DBA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8Oi5M9aJF+Nhh3uBfIH6zUjZCwWQp8p9uYRbzwSERc=;
        b=LhZNmCUa1XWemfPZk44eMSeGCW7O+jDZTQdXJ5qRWS4A7BFLWt2WpaX9decsP1d4rp8HIG
        WQyabHGwdRj4S4rB3FQqjQi02fZ6GA1UPyXLV99NR/oeu3gfJYBCfGphKBWSeZccXtaV+7
        RtPNISc8W3lar1gF6w+SlNjYg5YjWqY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-fgRhX_qVMCOIYPTm4N3TNA-1; Fri, 04 Mar 2022 00:19:24 -0500
X-MC-Unique: fgRhX_qVMCOIYPTm4N3TNA-1
Received: by mail-pj1-f70.google.com with SMTP id ev5-20020a17090aeac500b001bc3cb23d4cso4314379pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8Oi5M9aJF+Nhh3uBfIH6zUjZCwWQp8p9uYRbzwSERc=;
        b=sQ9yYpTFToONYCzMPHJoAquA5mrPouz0kJCmDTqSaOS0ru+k7OFuj5KmZD9nI5dOV3
         KFEBVABg4yfpz+UXr6eV7wWUqp8xA4stzEl2CsEWkevhxwVP+xeEny5jA6SddrN2cCPJ
         vQIOzbQ8PZRQ/HPr3E04LEYHTmfybKw+7/2y65nyzr5Zj27O3lpB4AXlXQnKLsIDGZ72
         BGeg/HktADDdkSKFk82+pcZRew8BZ/Ap8wMWDUNouFoVjuB2K1FGCynjY/FR79boOuTj
         Amr48n4PPqnCVRfr6ghaJXx/+ysdVwlp2pYoTkXlO8hKaJ3kZkFH+KyhEDyWAuNMwmPQ
         110A==
X-Gm-Message-State: AOAM533GEWwU/ad1/I3Jp8pJePLlHYksiQ96po3VHtT6xuDXnOa6/Dy7
        s2ICdwckSe2Iw1TKuvhNlkt5Lm9vATTU+MdnhWL4EySCaddB2DJI0ENKX0DRT+a83eije3lzTCg
        NVGShhSH49jDSDHloyKppb7GA
X-Received: by 2002:a17:902:e80f:b0:151:bdd2:cabc with SMTP id u15-20020a170902e80f00b00151bdd2cabcmr970852plg.31.1646371163395;
        Thu, 03 Mar 2022 21:19:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx50hZU3JRaU/3TajwefuQOeadN49vMH2q5JxcC4kmufwLK+rjdl0sW8g3unVKCqbQjfQkoew==
X-Received: by 2002:a17:902:e80f:b0:151:bdd2:cabc with SMTP id u15-20020a170902e80f00b00151bdd2cabcmr970827plg.31.1646371163102;
        Thu, 03 Mar 2022 21:19:23 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.19.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:19:22 -0800 (PST)
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
Subject: [PATCH v7 15/23] mm/hugetlb: Handle pte markers in page faults
Date:   Fri,  4 Mar 2022 13:17:00 +0800
Message-Id: <20220304051708.86193-16-peterx@redhat.com>
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

Allow hugetlb code to handle pte markers just like none ptes.  It's mostly
there, we just need to make sure we don't assume hugetlb_no_page() only handles
none pte, so when detecting pte change we should use pte_same() rather than
pte_none().  We need to pass in the old_pte to do the comparison.

Check the original pte to see whether it's a pte marker, if it is, we should
recover uffd-wp bit on the new pte to be installed, so that the next write will
be trapped by uffd.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 396d5a516d05..afd3d93cfe9a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5383,7 +5383,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -5509,7 +5510,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	/* If pte changed from under us, retry */
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -5519,6 +5521,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_rmap(page, true);
 	new_pte = make_huge_pte(vma, page, ((vma->vm_flags & VM_WRITE)
 				&& (vma->vm_flags & VM_SHARED)));
+	/*
+	 * If this pte was previously wr-protected, keep it wr-protected even
+	 * if populated.
+	 */
+	if (unlikely(pte_marker_uffd_wp(old_pte)))
+		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -5636,8 +5644,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
-	if (huge_pte_none(entry)) {
-		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep, flags);
+	/* PTE markers should be handled the same way as none pte */
+	if (huge_pte_none_mostly(entry)) {
+		ret = hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
+				      entry, flags);
 		goto out_mutex;
 	}
 
-- 
2.32.0

