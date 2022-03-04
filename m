Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500A4CCCFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbiCDFVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbiCDFVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:21:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECCCB18644A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffibrZjnGVszpXN3ddH8kcpciqEGO3vV2nAFK0S1oq0=;
        b=aiGa7zW99IewUe0q8nbC309+7s0v/wIMQc6DXtrI6vb56w73dgJAsVfcXlUkt5cgnYshhu
        G2vQ7QIfnQoMinQsCUVykbnMkxxIFww7Xt0/t3c1EroGQL6nPunN48QnnRgdWZQW6QSmWc
        qQYixIBjEtbuH7mP1nrjWtIIACccE1I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-xTnW3XduOSOfMN1rSPyI9g-1; Fri, 04 Mar 2022 00:20:13 -0500
X-MC-Unique: xTnW3XduOSOfMN1rSPyI9g-1
Received: by mail-pj1-f69.google.com with SMTP id ds4-20020a17090b08c400b001bc1dee733eso4470207pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ffibrZjnGVszpXN3ddH8kcpciqEGO3vV2nAFK0S1oq0=;
        b=XIGCqMF8zCL/gbEP9oFim3dvyi/v/dF/jA2b4WqufOfVU0OOSEbdyY4oz9qKY9dizX
         JAmld5g3zQwl7iDiGAQEBujZ5DumWkUCIIqs3XSuN6c944i6OZITYfhN5sWQuGJZUcq+
         MoALgkSkrp7zF5glFb/7o2DRRyqh/QimmvDjaITIsU9wMgtAd9Ozv6eD9VXPH5VJ+aJ0
         ReruRpoD3nNwGnwopqjMSYwGmsSBZguKpiieBPUcFijJPrl4DsDcB0efaHpIR9xTKIdX
         1M0gaeKVEuygBDZawUgxTwR62SwADBEKRVejhwnERK7Hl6JzB/4YSufyctwf3QQrNI94
         rSqg==
X-Gm-Message-State: AOAM533za9BbI6w2KpA7Ha/qYVnLEBvL+lZ4dym71KvLqjZw3FR1MXlr
        RFCGOx1zgvy423++SsdpTcCcxSNxgfTFpSnVaDCVRK4X7qTlM6pQDJObhdK4Z1PIoUDM9GRW1ZG
        OX8hriDoRvFg0QKyCQID4YDEH
X-Received: by 2002:a17:902:8f83:b0:151:5c71:a6e6 with SMTP id z3-20020a1709028f8300b001515c71a6e6mr27671444plo.126.1646371211271;
        Thu, 03 Mar 2022 21:20:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJfL2XlMGfvdIOmaVhgHly9k8v9pLNrjUxE51LcGrUcbGkXTtSAjOI3Or1kjLz33VXgzk0CA==
X-Received: by 2002:a17:902:8f83:b0:151:5c71:a6e6 with SMTP id z3-20020a1709028f8300b001515c71a6e6mr27671420plo.126.1646371210948;
        Thu, 03 Mar 2022 21:20:10 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.20.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:20:10 -0800 (PST)
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
Subject: [PATCH v7 21/23] mm/uffd: Enable write protection for shmem & hugetlbfs
Date:   Fri,  4 Mar 2022 13:17:06 +0800
Message-Id: <20220304051708.86193-22-peterx@redhat.com>
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

We've had all the necessary changes ready for both shmem and hugetlbfs.  Turn
on all the shmem/hugetlbfs switches for userfaultfd-wp.

We can expand UFFD_API_RANGE_IOCTLS_BASIC with _UFFDIO_WRITEPROTECT too because
all existing types now support write protection mode.

Since vma_can_userfault() will be used elsewhere, move into userfaultfd_k.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c                 | 21 ++-------------------
 include/linux/userfaultfd_k.h    | 11 +++++++++++
 include/uapi/linux/userfaultfd.h | 10 ++++++++--
 mm/userfaultfd.c                 |  9 +++------
 4 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8b4a94f5a238..cd19083123fe 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1257,24 +1257,6 @@ static __always_inline int validate_range(struct mm_struct *mm,
 	return 0;
 }
 
-static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
-{
-	/* FIXME: add WP support to hugetlbfs and shmem */
-	if (vm_flags & VM_UFFD_WP) {
-		if (is_vm_hugetlb_page(vma) || vma_is_shmem(vma))
-			return false;
-	}
-
-	if (vm_flags & VM_UFFD_MINOR) {
-		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
-			return false;
-	}
-
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	       vma_is_shmem(vma);
-}
-
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -1954,7 +1936,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	uffdio_api.features &=
+	    ~(UFFD_FEATURE_PAGEFAULT_FLAG_WP | UFFD_FEATURE_WP_HUGETLBFS_SHMEM);
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 827e38b7be65..69b174807d8f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -18,6 +18,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
@@ -140,6 +141,16 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+static inline bool vma_can_userfault(struct vm_area_struct *vma,
+				     unsigned long vm_flags)
+{
+	if (vm_flags & VM_UFFD_MINOR)
+		return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
+
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	       vma_is_shmem(vma);
+}
+
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
 
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index ef739054cb1c..7d32b1e797fb 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -33,7 +33,8 @@
 			   UFFD_FEATURE_THREAD_ID |		\
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
 			   UFFD_FEATURE_MINOR_SHMEM |		\
-			   UFFD_FEATURE_EXACT_ADDRESS)
+			   UFFD_FEATURE_EXACT_ADDRESS |		\
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -47,7 +48,8 @@
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
-	 (__u64)1 << _UFFDIO_CONTINUE)
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
@@ -194,6 +196,9 @@ struct uffdio_api {
 	 * UFFD_FEATURE_EXACT_ADDRESS indicates that the exact address of page
 	 * faults would be provided and the offset within the page would not be
 	 * masked.
+	 *
+	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
+	 * write-protection mode is supported on both shmem and hugetlbfs.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -207,6 +212,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
+#define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 441728732033..b70167a563f8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -730,15 +730,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
 	err = -ENOENT;
 	dst_vma = find_dst_vma(dst_mm, start, len);
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
+
+	if (!dst_vma)
 		goto out_unlock;
 	if (!userfaultfd_wp(dst_vma))
 		goto out_unlock;
-	if (!vma_is_anonymous(dst_vma))
+	if (!vma_can_userfault(dst_vma, dst_vma->vm_flags))
 		goto out_unlock;
 
 	if (is_vm_hugetlb_page(dst_vma)) {
-- 
2.32.0

