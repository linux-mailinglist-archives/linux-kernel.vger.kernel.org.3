Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66B24F21A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiDECpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiDECoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FCC3B039D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOyz+2xZD3mxaBpxdZs8qkqfXmUFPooQ6m/cX5syVEc=;
        b=AtbNT0JRwMl3vr7k+lXM0TF8tUwuDXxca0nGsi0ODSEiK2XD6ekXJsBK5HDaaqjYG6GR2k
        z8keovfBAdRYJrhJLWe5HDpaH/6rVIlOxBHMbW+56XYf19VEWXnW9a+c+p7R77RYha9bwO
        eNcj0CjeedRSdk78uBWQoYLiRNlukXk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-buIkkurMMPK7zb-o0uSR5g-1; Mon, 04 Apr 2022 21:49:30 -0400
X-MC-Unique: buIkkurMMPK7zb-o0uSR5g-1
Received: by mail-il1-f198.google.com with SMTP id y19-20020a056e02119300b002c2d3ef05bfso7173836ili.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOyz+2xZD3mxaBpxdZs8qkqfXmUFPooQ6m/cX5syVEc=;
        b=qba0npl3YQj/mtrxyT1YRO7lfTKpp5rS/dmROjrfRb1vNrzBjG/Q9Tue3F0SAGhKmU
         2oanFv3fyUuCydXMcPmfnUQIBT5xd72s21/9iwIx/iOZQDa8zvUVFSFWyXlI/y6qrPA5
         NEPv+Dd+R/M5Pzskyw8XE29F1aNx5OZ0b2pCD65c5FfDavCBnHhZ1V2jPtKt+/lRHYh5
         0qgAsJbC2WQX3vNyGF6YQROYTJAX6t0t86EeLjAnGl0NTb/U5Uwv9yi0GUk8bBaMquGX
         knYUucAGNdC7oth7auJd4MMI7efAa+DNKhwp2VGFcBgUqtPdtGtcKMR1eYyfpnYMMa/x
         o/5w==
X-Gm-Message-State: AOAM5339b1hTi3dzqvQT9SEdRyxmbuSAoBOyAJYTs6svcQTcQN/Al0+l
        5g9xwQxqwHptxk8x36rahqKCu/74w/Yx0DYlF24IhHGJn7K45tSAXylDJCTr1YBi3sz+8AvphmP
        7F7gi3Q+REMIoVVowDZJCHb/UUmJIYgpMGamBR+OaU0vfKqIbmRYk7vfBmwLTpLeTVeFm9I14zA
        ==
X-Received: by 2002:a05:6e02:156b:b0:2c7:bea3:4e3f with SMTP id k11-20020a056e02156b00b002c7bea34e3fmr552959ilu.297.1649123369556;
        Mon, 04 Apr 2022 18:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTG3iAZemJX0eJmfE0/JA/EKpfb5j6PGqOBIGRnudHQh5V4DM77svm07A1N03QJ/sTzCyG+Q==
X-Received: by 2002:a05:6e02:156b:b0:2c7:bea3:4e3f with SMTP id k11-20020a056e02156b00b002c7bea34e3fmr552932ilu.297.1649123369224;
        Mon, 04 Apr 2022 18:49:29 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s12-20020a92cbcc000000b002bd04428740sm6652376ilq.80.2022.04.04.18.49.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:29 -0700 (PDT)
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
Subject: [PATCH v8 21/23] mm/uffd: Enable write protection for shmem & hugetlbfs
Date:   Mon,  4 Apr 2022 21:49:26 -0400
Message-Id: <20220405014926.15101-1-peterx@redhat.com>
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

We've had all the necessary changes ready for both shmem and hugetlbfs.  Turn
on all the shmem/hugetlbfs switches for userfaultfd-wp.

We can expand UFFD_API_RANGE_IOCTLS_BASIC with _UFFDIO_WRITEPROTECT too because
all existing types now support write protection mode.

Since vma_can_userfault() will be used elsewhere, move into userfaultfd_k.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c                 | 21 +++------------------
 include/linux/userfaultfd_k.h    | 20 ++++++++++++++++++++
 include/uapi/linux/userfaultfd.h | 10 ++++++++--
 mm/userfaultfd.c                 |  9 +++------
 4 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8b4a94f5a238..fb45522a2b44 100644
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
@@ -1955,6 +1937,9 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+#endif
+#ifndef CONFIG_PTE_MARKER_UFFD_WP
+	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 827e38b7be65..ea11bed9bb7e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -18,6 +18,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <asm-generic/pgtable_uffd.h>
+#include <linux/hugetlb_inline.h>
 
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
@@ -140,6 +141,25 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
+static inline bool vma_can_userfault(struct vm_area_struct *vma,
+				     unsigned long vm_flags)
+{
+	if (vm_flags & VM_UFFD_MINOR)
+		return is_vm_hugetlb_page(vma) || vma_is_shmem(vma);
+
+#ifndef CONFIG_PTE_MARKER_UFFD_WP
+	/*
+	 * If user requested uffd-wp but not enabled pte markers for
+	 * uffd-wp, then shmem & hugetlbfs are not supported but only
+	 * anonymous.
+	 */
+	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
+		return false;
+#endif
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	    vma_is_shmem(vma);
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
index 58d67f2bf980..156e9bdf9f23 100644
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

