Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20904F21DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiDECnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiDECnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2EB23178DC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xu2h9LPZD95UgWg3OX67cvf1aND/vrgeeBhE/APRTdQ=;
        b=KDjDbiebLj463dZtcD2oziRaTvUBtp2CZ4N9glLWvN1cfKgXiBYs0bBd3nBDWTtb2OV3BT
        5uRklzsc5uOqX7UQEzZNaMi+uMiDO3ad8V8ys8ZcAX8amLJNS/IFjcRnCe4eNvaZU/R1Cl
        D4j9PCWAGn+uJ2k7VOB6BdGGswcMkro=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-SX5xPaY2NFCZ0xzL6qfUfg-1; Mon, 04 Apr 2022 21:48:59 -0400
X-MC-Unique: SX5xPaY2NFCZ0xzL6qfUfg-1
Received: by mail-il1-f199.google.com with SMTP id h13-20020a056e021d8d00b002c7fb1ec601so7204222ila.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xu2h9LPZD95UgWg3OX67cvf1aND/vrgeeBhE/APRTdQ=;
        b=uMlauL5KV9l3yICX3creE+o992jTDKd2SpHcL5Y8IvU3bR4BUeeanIeNAm0XKRmAmi
         EyeY3HEpYrUmdj03SMvRoGYrW0RuiuQF3szOIwcLwZQNCLiKHxAws+xG4DmNxV3as2W/
         da1+He6mLUessB59Y1MIINsy2Ynij58tjKPaPu90bsBDadQKXAuY49o3J3VSOWqKdUhC
         pchHf3Waxu1YFPFJ71Ng7F56rCC0NsXlMYE643jk4XRyx7b2SigiF91poLN9O9an3eiD
         ngKwtPUWgKkggArnyZmXA6krH0tt644zE5n1VOLnbFhJ6wzclE5em8/659Qyz2RDgGjp
         yHug==
X-Gm-Message-State: AOAM531e5IjS2IbSZ/DxRya6OtEeHd/hPhfVRW3sF5DN1G9slLUciZY8
        ScHSG1HgKJ6LDodbsxsikH38c1u752LZbRtCFXwqnYakvWOb6hhWhdmPNbbl+16VJIORNtcwImn
        sG8AezBkTwrHZALEe2YvxN/pQHzHqBEnPN2gnGFXdGmqELnICS7dwtgoejq3g9M0jBr6wGFOimQ
        ==
X-Received: by 2002:a05:6638:d87:b0:323:c006:3650 with SMTP id l7-20020a0566380d8700b00323c0063650mr709891jaj.64.1649123338509;
        Mon, 04 Apr 2022 18:48:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMFmhYcxtKesF8e8jA4ez0VAvz2QlCxEYSpJ9E7Y0EzGtvgbMSWc0UDKb86qoEwbB54Mdr3g==
X-Received: by 2002:a05:6638:d87:b0:323:c006:3650 with SMTP id l7-20020a0566380d8700b00323c0063650mr709862jaj.64.1649123338140;
        Mon, 04 Apr 2022 18:48:58 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id u15-20020a92d1cf000000b002ca56804ec4sm473668ilg.23.2022.04.04.18.48.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:57 -0700 (PDT)
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
Subject: [PATCH v8 10/23] mm/shmem: Handle uffd-wp during fork()
Date:   Mon,  4 Apr 2022 21:48:55 -0400
Message-Id: <20220405014855.14468-1-peterx@redhat.com>
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
index 1144845ff734..8ba1bb196095 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -867,6 +867,14 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
@@ -1221,6 +1229,38 @@ copy_p4d_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
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
@@ -1234,14 +1274,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
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

