Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F44CCCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiCDFTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiCDFSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D70E654AD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J4WHOp4As9jU9WPKckCAt0i8DCpDD3uwt3O/JTJCiOk=;
        b=bPnHkyGIhVRo2+aQJkEvazF8fFnVP7JC8wJYnvvvAAaEE8hySlp63p4E9KJzYlitqI0Vw1
        7iaN15Vi66ZPtQGlQ626907sVushuvzeDBquz+gasHVeQRrZ1cIT4Wq4pQWnaHdcHPW/SP
        57e6cPuagf8cMEQx0eaaCJtgY42DskE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-1EMfd2r-OD-W0TMSzfOYfg-1; Fri, 04 Mar 2022 00:18:04 -0500
X-MC-Unique: 1EMfd2r-OD-W0TMSzfOYfg-1
Received: by mail-pf1-f197.google.com with SMTP id k130-20020a628488000000b004f362b45f28so4472517pfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4WHOp4As9jU9WPKckCAt0i8DCpDD3uwt3O/JTJCiOk=;
        b=hB+4ZRxhyfTZLxK0qFeLIh5IJXrIZ0tIa84a5gedsh5Ugy5W50EPcG2xFL5dCsMn/y
         cnwvW3vpjltS86x/fYAeTKGDBiX9fxsyGbVjeAq3PmCZnYtd4N3sdZC8eFgqN8zqyN2a
         NqiKiMuMIk0/JNP7yGap+M3hE/BXqyWaRJzMi5yOKcyqvpxfuI9B89A4wa8rv1DvFZas
         IRoKVvYcOONP8CuCJm7nIuvzXHL+vJKZjE7MCPO3/NHukubizqPIEWNtZOzYFvbiKITW
         eBqvjw+6EvCt+aoXawudWp6yGZA2s44AMnq1ZWdIHxf7m2s2mQP2YsNxVx1UYfv+0mqR
         hxFg==
X-Gm-Message-State: AOAM532fXnCGT66qGONqx0nA7a1HonYAd5Z4aQyKSNHBHOFFg+1m/ML6
        oroxV79tFbMJ9/W1TgBHT6gYODq4DxfZNo9ydVJLf7xZM7rBkpn36W3KjT5m04VGqUyvKeO6qPZ
        oqLSMamtYFUjuI8ua5CSoAR1U
X-Received: by 2002:a63:8648:0:b0:37c:8fc8:ae4 with SMTP id x69-20020a638648000000b0037c8fc80ae4mr2421605pgd.482.1646371082769;
        Thu, 03 Mar 2022 21:18:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznlFXBVvf7x27XrfMAEWi1fvHMcNPQxFuHlxUyI/+59HbIcVzbyw8INKOOkmh2hJfkrZdmyg==
X-Received: by 2002:a63:8648:0:b0:37c:8fc8:ae4 with SMTP id x69-20020a638648000000b0037c8fc80ae4mr2421585pgd.482.1646371082478;
        Thu, 03 Mar 2022 21:18:02 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.17.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:02 -0800 (PST)
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
Subject: [PATCH v7 05/23] mm/shmem: Take care of UFFDIO_COPY_MODE_WP
Date:   Fri,  4 Mar 2022 13:16:50 +0800
Message-Id: <20220304051708.86193-6-peterx@redhat.com>
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
index ab51d3cd39bd..02d23ce5f979 100644
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
index 81a69bd247b4..3f0332c1c1e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2317,7 +2317,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
 			   unsigned long src_addr,
-			   bool zeropage,
+			   bool zeropage, bool wp_copy,
 			   struct page **pagep)
 {
 	struct inode *inode = file_inode(dst_vma->vm_file);
@@ -2390,7 +2390,7 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       page, true, false);
+				       page, true, wp_copy);
 	if (ret)
 		goto out_delete_from_cache;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e9bb6db002aa..ef418a48b121 100644
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

