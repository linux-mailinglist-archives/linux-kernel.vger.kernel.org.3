Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA994F2144
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiDECoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiDECnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F365CE41FB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYxpsQItjDK7cACelYDmbYGqmACKurZeMNuIXszIjeQ=;
        b=RzS1Edb6hqCIQnZRWCCG/TWCQUSKtE4qrHbtwXyEH9l6Z01tVFfa6Q4aeSs+nRspbZ6wF9
        itNxSG/LGld1pleaF1io6zx7aN7hkNjGjluWhFx8yN+nFEyv8vu+ev0PxnQPGxCwthGumx
        x4bvUtqMAN+Utpqz4CwEvoZJ+5IRQec=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-lcQlRgaiP2aCb_o9OH_MnA-1; Mon, 04 Apr 2022 21:49:16 -0400
X-MC-Unique: lcQlRgaiP2aCb_o9OH_MnA-1
Received: by mail-il1-f200.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso7182240ilu.19
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYxpsQItjDK7cACelYDmbYGqmACKurZeMNuIXszIjeQ=;
        b=0xy8rQb4mru1yGfTD7/vfuP0Uq1qARkOd12c5Kv+X2w74shoMs8S5RByv8w+mjDJ4o
         c0f95QjZycSp4XfXFhS0c8oCl2qhPsx57OztuofK7OwtVAaM1M86MiZ8V8VpwR3MMbbg
         C7U9kjPzM/LYJIzgB4g6u+KJ6z0ZoLvyUv3EC3AhfJGAYkOKt/RDbqEj+9KaMYV9ZW98
         7+EdmfRK0Sp1jGtCbM19XbiUDjuts0wEUKZEKEb6W0gp+cScPtbD2WzVPVyWrykToWkG
         PQfL0bPTNXpqdMgUWXmGc6oXH5nn/CoVF0OkOVBpj6E/3ODGvNfRk5JgZdzZLTEltcI/
         mjNA==
X-Gm-Message-State: AOAM533p59PZdkoZp8rGxKPwRThrjrmZeuqWact0i6FfkcRdGfrbCV09
        2ZVwBfsGO+3hL71v2ib7nYLa3D5bFaDqJa4uQdSXdiIYPejk09uBucmGk9OcYnK0B5uLFTdSF67
        y3JwFB6JG/n1/Eeg9KktVoSxXgnEKrxzTBze/MchErgtWsTqyWCB5Og7ZjX+mwfIwk1dDT2HF7A
        ==
X-Received: by 2002:a92:c545:0:b0:2ca:1066:3d6 with SMTP id a5-20020a92c545000000b002ca106603d6mr616140ilj.229.1649123355310;
        Mon, 04 Apr 2022 18:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDsITZBgZ19aGlVu4ZTn7lfD33BDzVrxkkBzyP8LrQwVfSiH2pEhd9gNDZ7UGnRWBIoTtlXw==
X-Received: by 2002:a92:c545:0:b0:2ca:1066:3d6 with SMTP id a5-20020a92c545000000b002ca106603d6mr616119ilj.229.1649123355058;
        Mon, 04 Apr 2022 18:49:15 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id m5-20020a92c525000000b002ca19cc6e43sm5578396ili.20.2022.04.04.18.49.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:14 -0700 (PDT)
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
Subject: [PATCH v8 16/23] mm/hugetlb: Allow uffd wr-protect none ptes
Date:   Mon,  4 Apr 2022 21:49:12 -0400
Message-Id: <20220405014912.14815-1-peterx@redhat.com>
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

Teach hugetlbfs code to wr-protect none ptes just in case the page cache
existed for that pte.  Meanwhile we also need to be able to recognize a uffd-wp
marker pte and remove it for uffd_wp_resolve.

Since at it, introduce a variable "psize" to replace all references to the huge
page size fetcher.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9317b790161d..578c48ef931a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6225,7 +6225,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	pte_t *ptep;
 	pte_t pte;
 	struct hstate *h = hstate_vma(vma);
-	unsigned long pages = 0;
+	unsigned long pages = 0, psize = huge_page_size(h);
 	bool shared_pmd = false;
 	struct mmu_notifier_range range;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
@@ -6245,13 +6245,19 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 
 	mmu_notifier_invalidate_range_start(&range);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
-	for (; address < end; address += huge_page_size(h)) {
+	for (; address < end; address += psize) {
 		spinlock_t *ptl;
-		ptep = huge_pte_offset(mm, address, huge_page_size(h));
+		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep)
 			continue;
 		ptl = huge_pte_lock(h, mm, ptep);
 		if (huge_pmd_unshare(mm, vma, &address, ptep)) {
+			/*
+			 * When uffd-wp is enabled on the vma, unshare
+			 * shouldn't happen at all.  Warn about it if it
+			 * happened due to some reason.
+			 */
+			WARN_ON_ONCE(uffd_wp || uffd_wp_resolve);
 			pages++;
 			spin_unlock(ptl);
 			shared_pmd = true;
@@ -6281,12 +6287,20 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				else if (uffd_wp_resolve)
 					newpte = pte_swp_clear_uffd_wp(newpte);
 				set_huge_swap_pte_at(mm, address, ptep,
-						     newpte, huge_page_size(h));
+						     newpte, psize);
 				pages++;
 			}
 			spin_unlock(ptl);
 			continue;
 		}
+		if (unlikely(pte_marker_uffd_wp(pte))) {
+			/*
+			 * This is changing a non-present pte into a none pte,
+			 * no need for huge_ptep_modify_prot_start/commit().
+			 */
+			if (uffd_wp_resolve)
+				huge_pte_clear(mm, address, ptep, psize);
+		}
 		if (!huge_pte_none(pte)) {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
@@ -6300,6 +6314,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
+		} else {
+			/* None pte */
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP));
 		}
 		spin_unlock(ptl);
 	}
-- 
2.32.0

