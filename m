Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68384F2102
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiDECoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiDECn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35D1239E01C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKVs/J2+ks2bdCQxZbqUvWZ98wqpvNaMBO4b+MQPP2E=;
        b=PNOkHJtDRhlumm2ZQ85wWVmopfW5xvoAB54M0ZqSpgsgmhb67hrDfl+waBcUUQMqmoq2NO
        P+C9iUWXZ29Yyl5BKleGGNnvKfSR7C7krin68PbCYxe9Lw0ULa7qp3BMQ2q8WHMcTDJtKs
        LrPfcvfR+g4Qe1qjO4Duji1inXpk9Z8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-PBEt8VDXMrKaTFFz6JI89g-1; Mon, 04 Apr 2022 21:49:13 -0400
X-MC-Unique: PBEt8VDXMrKaTFFz6JI89g-1
Received: by mail-il1-f197.google.com with SMTP id a6-20020a056e02120600b002ca412e65a7so2681440ilq.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKVs/J2+ks2bdCQxZbqUvWZ98wqpvNaMBO4b+MQPP2E=;
        b=OgI2lc3ErIfuMJQ7ld6SrJbL6KeZECW+LZrhPFiQ1AXFiiC/y8wG2+YaUv/XXMs+Zt
         b/9sAyvphREQ1bF+zFjVQAT8XOpETI2Rr/Gwq7sEc66zokYvczjo/LEEvr8P3P1p0o4+
         dPfR09BI5Y4Jm610nYxCAk7LW3Pt0Odx38JmVieFqoCaLXQtpTuspijZnkZAkbwytHgp
         so+lhoVdUK5nuuLrQUKo9kA7zsXFx8dnl+G0pdnd2bN6iVhq4zLWMpgTrI6aLiEyyHUE
         Mf2XNmhygKAB2BrawDgq5T/MGmns8Em4dXnRfq3oQh9LI1Z2/HjEIARY2aSKH/u1pae3
         KN5w==
X-Gm-Message-State: AOAM533XwFwIrQ0Q5le5g9KJLh07Ka565TuNvmE7l7DAArocR3Zxt3TM
        T9bn94Pc5Cf7LMeTz9oNS4O1R0hNY02Y4nOoNLwh72KDtiswEpOFHl5ZxaxWmAgbhGHLtofelfd
        YTdaAwWRkr9bXQiZxpSEuEDW9GeEhelGuxpUtZ3P0NvV+E0evzMKRO/bj8zA26NiQpVVgg1Po8w
        ==
X-Received: by 2002:a02:ce91:0:b0:323:6d4a:484a with SMTP id y17-20020a02ce91000000b003236d4a484amr707146jaq.311.1649123352484;
        Mon, 04 Apr 2022 18:49:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyupx1oRwn841EYWh23vc7XbLA4GVVEmXYgiyGK3QUl9XTVB2ugR3JABDvh7vEjtnRLX6P2Ww==
X-Received: by 2002:a02:ce91:0:b0:323:6d4a:484a with SMTP id y17-20020a02ce91000000b003236d4a484amr707114jaq.311.1649123352138;
        Mon, 04 Apr 2022 18:49:12 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm7344446iog.24.2022.04.04.18.49.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:11 -0700 (PDT)
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
Subject: [PATCH v8 15/23] mm/hugetlb: Handle pte markers in page faults
Date:   Mon,  4 Apr 2022 21:49:09 -0400
Message-Id: <20220405014909.14761-1-peterx@redhat.com>
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
index 2401dd5997b7..9317b790161d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5412,7 +5412,8 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
 static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
-			unsigned long address, pte_t *ptep, unsigned int flags)
+			unsigned long address, pte_t *ptep,
+			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -5539,7 +5540,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
-	if (!huge_pte_none(huge_ptep_get(ptep)))
+	/* If pte changed from under us, retry */
+	if (!pte_same(huge_ptep_get(ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -5549,6 +5551,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		page_dup_file_rmap(page, true);
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
@@ -5666,8 +5674,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
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

