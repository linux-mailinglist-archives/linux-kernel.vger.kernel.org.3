Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545D4F20E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiDECnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiDECnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F8B3178E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7N++YETabzz5IcvkFNQ6jfBTPxFyQ6g10gwAR5sfFo=;
        b=jJOquU4dRtsbORAtL0QtiVKZblAmB+azqwKy+Wi6C8pKqK2/blj/Ud9FYjSvkbJjVF4Xxs
        k7ER3530HGSQCKNEneQ9jyq561fAbeA0UmzWjaneMNrIqSGFCDZz2ALYXq5ybPRibRh9/e
        wH4EzCO84M/KOfVjFrCdeuqGyVFgKN4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-QnmOIHo7P5W0dkZTLwbn8A-1; Mon, 04 Apr 2022 21:48:45 -0400
X-MC-Unique: QnmOIHo7P5W0dkZTLwbn8A-1
Received: by mail-il1-f198.google.com with SMTP id s4-20020a92c5c4000000b002c7884b8608so7161856ilt.21
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7N++YETabzz5IcvkFNQ6jfBTPxFyQ6g10gwAR5sfFo=;
        b=g1JZ/mSYeWY2YSKTUKQ/3kleio3Ta+DPPsUNAA/yZZ+7xVxOUNcNJFVnX3lYSgtaYW
         ES1ZgS7n9XXh6I0hVDyzsNA7A1mY+PJ1TBq4B19+d6xdshWGbE9QEuBgjMBcXND0b1AF
         Js0gHgtsV6NoE9nR2e26Nl5QlicnUyPCsUZEK8bVkwzerUtn73C5Sml68uHiBO1lAF4+
         +BI+nrF0MBHyeDhp1uxnw4bDifc/z1hAKvRCu6lO2NG6bm6GZW3umsztMY8u2X8W52lM
         fqPho9UPcICQvtwVh7/n01bInKXzZlq21VeJCxnzy75pl2moP0EoBICaU/fc/tAbVlfL
         RydQ==
X-Gm-Message-State: AOAM531CIf4r1CRZdlfp3aCqD7kwn5BkFZ2Mi6vi1JOF+39zw5csuCGq
        mDXuJznxakgfC+SN7E4cPuQjv8FgkGsvxFkRB7KQqvz7WQ/ZWDQlxO29/Ws0wWWqhKpt8ypr8JL
        HLNJjt6XK6AkgB+6Veo9BEBvF74WqD/oOYzVZDQapWMXAEyA2ztBf7ZNsOdWKcGhtir4SFqYXQA
        ==
X-Received: by 2002:a02:ccdb:0:b0:321:2cf8:8c70 with SMTP id k27-20020a02ccdb000000b003212cf88c70mr736099jaq.32.1649123324395;
        Mon, 04 Apr 2022 18:48:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdVvGICqrYSIFeMsXS/EOPSh7BPG/ifQSrmjaNr8HpCpVJTxhXefsGedxvCcLNau5XeR/6Pg==
X-Received: by 2002:a02:ccdb:0:b0:321:2cf8:8c70 with SMTP id k27-20020a02ccdb000000b003212cf88c70mr736070jaq.32.1649123324113;
        Mon, 04 Apr 2022 18:48:44 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id ay18-20020a5d9d92000000b0064c77f6aaecsm7925169iob.3.2022.04.04.18.48.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:48:43 -0700 (PDT)
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
Subject: [PATCH v8 05/23] mm/shmem: Take care of UFFDIO_COPY_MODE_WP
Date:   Mon,  4 Apr 2022 21:48:41 -0400
Message-Id: <20220405014841.14185-1-peterx@redhat.com>
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

Pass wp_copy into shmem_mfill_atomic_pte() through the stack, then apply the
UFFD_WP bit properly when the UFFDIO_COPY on shmem is with UFFDIO_COPY_MODE_WP.
wp_copy lands mfill_atomic_install_pte() finally.

Note: we must do pte_wrprotect() if !writable in mfill_atomic_install_pte(), as
mk_pte() could return a writable pte (e.g., when VM_SHARED on a shmem file).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/shmem_fs.h |  4 ++--
 mm/shmem.c               |  4 ++--
 mm/userfaultfd.c         | 23 ++++++++++++++++++-----
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3e915cc550bc..a68f982f22d1 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -145,11 +145,11 @@ extern int shmem_mfill_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 				  struct vm_area_struct *dst_vma,
 				  unsigned long dst_addr,
 				  unsigned long src_addr,
-				  bool zeropage,
+				  bool zeropage, bool wp_copy,
 				  struct page **pagep);
 #else /* !CONFIG_SHMEM */
 #define shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
-			       src_addr, zeropage, pagep)       ({ BUG(); 0; })
+			       src_addr, zeropage, wp_copy, pagep) ({ BUG(); 0; })
 #endif /* CONFIG_SHMEM */
 #endif /* CONFIG_USERFAULTFD */
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 7004c7f55716..9efb8a96d75e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2319,7 +2319,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage,
+			   bool zeropage, bool wp_copy,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2392,7 +2392,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       page, true, false);
+				       page, true, wp_copy);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index dae25d985d15..b1c875b77fbb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -77,10 +77,19 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	 * Always mark a PTE as write-protected when needed, regardless of
 	 * VM_WRITE, which the user might change.
 	 */
-	if (wp_copy)
+	if (wp_copy) {
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
-	else if (writable)
+		writable = false;
+	}
+
+	if (writable)
 		_dst_pte = pte_mkwrite(_dst_pte);
+	else
+		/*
+		 * We need this to make sure write bit removed; as mk_pte()
+		 * could return a pte with write bit set.
+		 */
+		_dst_pte = pte_wrprotect(_dst_pte);
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 
@@ -95,7 +104,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	}
 
 	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
+	/*
+	 * We allow to overwrite a pte marker: consider when both MISSING|WP
+	 * registered, we firstly wr-protect a none pte which has no page cache
+	 * page backing it, then access the page.
+	 */
+	if (!pte_none_mostly(*dst_pte))
 		goto out_unlock;
 
 	if (page_in_cache) {
@@ -479,11 +493,10 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
 	} else {
-		VM_WARN_ON_ONCE(wp_copy);
 		err = shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					     dst_addr, src_addr,
 					     mode != MCOPY_ATOMIC_NORMAL,
-					     page);
+					     wp_copy, page);
 	}
 
 	return err;
-- 
2.32.0

