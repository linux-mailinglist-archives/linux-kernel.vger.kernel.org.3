Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5498B4CCD02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiCDFTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbiCDFTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C670AA9A47
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87YY6m3X7TCIFcgpIMmGMt9yOOTi6qvz7lf8TeZlPS8=;
        b=IzH7HX8J4Ck9fSNRZYTPEXjls22A9iNDvGqCbnHRCT7LplEpLH1PCqwyMFziKvl9170icN
        9w1slkYAZj5OBAgFDm4/ORB11vtATM1Ih2Eo0ErrbgKVL6q6el8rRXENvUGfs/V1z/rrej
        ekSy9mUvrJ+28LjJw9bxWNZcrmXoKAM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-b-8cTzfQN8OiiWfpt5QLsw-1; Fri, 04 Mar 2022 00:18:44 -0500
X-MC-Unique: b-8cTzfQN8OiiWfpt5QLsw-1
Received: by mail-pj1-f70.google.com with SMTP id p5-20020a17090a748500b001bee6752974so4166744pjk.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=87YY6m3X7TCIFcgpIMmGMt9yOOTi6qvz7lf8TeZlPS8=;
        b=T0oMHfwOIc/G7LxphcNNztQiCY+2YJHHfvuHB3RngZRVUpZA1dGWCXOOhRKHeYD72q
         TEDiRPalGY289LxTkoK0lT+e1B3dAXqCXxYfclR/oBKRWyOZbbMqxP/3k6xcxTPPIBYf
         PZnG36TZ8vxDD8ObLez5/kVj6n/52BYsXGjRD2FxRCEVcXJM7HMyRu0HNxVTUlFZd0GO
         bDModIYvRj43aj4h6OMGCFaM9Tx+5y4h7TFerUmboOoC1eGhjAUpOy2QPcmk1pFjdzHI
         k0CamFDjKRZ6tX/iMWrsnn9R8MLvF8rmDr9aRNegzkzLsQkeXjc98U0THk27cpADPELU
         DdEg==
X-Gm-Message-State: AOAM532t329zZDNQ2KoQ8VNCqmOG3jUefbPE9R2lBINvOly49kachqkz
        A4YFBMIVkqWdNiUzcg3Yr3lOaJ9q69mEX1O3hU9ZxL8MWJvYOGbcZBXG2CoUyjGezV+6SK7ab3j
        B5LM1sBBve0Ukf80Tw9jliRD5
X-Received: by 2002:a63:5525:0:b0:372:c376:74f1 with SMTP id j37-20020a635525000000b00372c37674f1mr32598160pgb.433.1646371123403;
        Thu, 03 Mar 2022 21:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvoeKLrN4o7hnThDJS0UIUxVik/k+WtOZ+b4Gnnk3c8Fk0c2piAJVffr6/tNq+9lzTQITaSA==
X-Received: by 2002:a63:5525:0:b0:372:c376:74f1 with SMTP id j37-20020a635525000000b00372c37674f1mr32598143pgb.433.1646371123117;
        Thu, 03 Mar 2022 21:18:43 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:42 -0800 (PST)
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
Subject: [PATCH v7 10/23] mm/shmem: Handle uffd-wp during fork()
Date:   Fri,  4 Mar 2022 13:16:55 +0800
Message-Id: <20220304051708.86193-11-peterx@redhat.com>
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

Normally we skip copy page when fork() for VM_SHARED shmem, but we can't skip
it anymore if uffd-wp is enabled on dst vma.  This should only happen when the
src uffd has UFFD_FEATURE_EVENT_FORK enabled on uffd-wp shmem vma, so that
VM_UFFD_WP will be propagated onto dst vma too, then we should copy the
pgtables with uffd-wp bit and pte markers, because these information will be
lost otherwise.

Since the condition checks will become even more complicated for deciding
"whether a vma needs to copy the pgtable during fork()", introduce a helper
vma_needs_copy() for it, so everything will be clearer.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e3e67e32eb8a..e9e335ecb5dc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -857,6 +857,14 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (try_restore_exclusive_pte(src_pte, src_vma, addr))
 			return -EBUSY;
 		return -ENOENT;
+	} else if (is_pte_marker_entry(entry)) {
+		/*
+		 * We're copying the pgtable should only because dst_vma has
+		 * uffd-wp enabled, do sanity check.
+		 */
+		WARN_ON_ONCE(!userfaultfd_wp(dst_vma));
+		set_pte_at(dst_mm, addr, dst_pte, pte);
+		return 0;
 	}
 	if (!userfaultfd_wp(dst_vma))
 		pte = pte_swp_clear_uffd_wp(pte);
@@ -1225,6 +1233,38 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	return 0;
 }
 
+/*
+ * Return true if the vma needs to copy the pgtable during this fork().  Return
+ * false when we can speed up fork() by allowing lazy page faults later until
+ * when the child accesses the memory range.
+ */
+bool
+vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
+{
+	/*
+	 * Always copy pgtables when dst_vma has uffd-wp enabled even if it's
+	 * file-backed (e.g. shmem). Because when uffd-wp is enabled, pgtable
+	 * contains uffd-wp protection information, that's something we can't
+	 * retrieve from page cache, and skip copying will lose those info.
+	 */
+	if (userfaultfd_wp(dst_vma))
+		return true;
+
+	if (src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP))
+		return true;
+
+	if (src_vma->anon_vma)
+		return true;
+
+	/*
+	 * Don't copy ptes where a page fault will fill them correctly.  Fork
+	 * becomes much lighter when there are big shared or private readonly
+	 * mappings. The tradeoff is that copy_page_range is more efficient
+	 * than faulting.
+	 */
+	return false;
+}
+
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 {
@@ -1238,14 +1278,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	bool is_cow;
 	int ret;
 
-	/*
-	 * Don't copy ptes where a page fault will fill them correctly.
-	 * Fork becomes much lighter when there are big shared or private
-	 * readonly mappings. The tradeoff is that copy_page_range is more
-	 * efficient than faulting.
-	 */
-	if (!(src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
-	    !src_vma->anon_vma)
+	if (!vma_needs_copy(dst_vma, src_vma))
 		return 0;
 
 	if (is_vm_hugetlb_page(src_vma))
-- 
2.32.0

