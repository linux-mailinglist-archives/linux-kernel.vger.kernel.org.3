Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075D9590742
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiHKUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4075A9C213
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660248825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3daRoUaVJELNsu8uBo1J3dFADg4pP+Ys+hc/IWmrcSE=;
        b=X5LI+VIxOBiHi8L0c1+VkAZlcirLMyqbXLcn7Ao09u3qJMyLuhUqt5YOP5wLH/khQ3rMhE
        +yWGjdpUg+jn0w/FPwD0WCwk7GTmL7DP0h/fsolBxmh2Pvn8SjlPeGgNI144dq1eM+7dLt
        R8z3J5v6ifgLQVQggwqpDUbxzUaIkpA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-t4AGPIHIN9WLWlo0scqeFQ-1; Thu, 11 Aug 2022 16:13:44 -0400
X-MC-Unique: t4AGPIHIN9WLWlo0scqeFQ-1
Received: by mail-il1-f199.google.com with SMTP id z9-20020a056e02088900b002e35dba878cso403630ils.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 13:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3daRoUaVJELNsu8uBo1J3dFADg4pP+Ys+hc/IWmrcSE=;
        b=a66j+OYAnoq6PlPEuA8dcqwH6DIR4A5zenRM0MRUgpehpNbxR8Jz3DTXUs97tqPJP+
         jPg6WH0GxUYa9psBA3CNOLrTK6pFCFUfadbGylWbn71XHZlckcSYtG8c4a3Kki6PDtLv
         +454Y6aMWNjQD2M42nUsPZOKFsqVQmzTs3TEZL7N+VD9cNk+OwFrGCVRzUwxbUzEAm4N
         ehHHdBxR2IUDTl45PE+98yH0XlZRILR0mC1FOoLrZVFYOzSx3eshYYhUN1B598UOPMD/
         AtHysIu4YM6puZ5WVx8MkfTtuFeoI5StZyHifyU+iOQVE3SaystRPg2HOV+vAChob2HM
         vBcg==
X-Gm-Message-State: ACgBeo3WC+5+3CbcuGQjHC3f3X0DHAe/FW0yKJlrhJNsXbebUCb1l8qs
        8pNQRJEJqLUu3jkTliejzRPV2m+MgrB0ZJQAVrZQCBSXZNYkIrGNHYav0cn+tAUY/dUKceBdOq5
        PwdL1BDO7Z+/3WwMDO/Uzsy/A
X-Received: by 2002:a05:6e02:178d:b0:2de:a00d:d06c with SMTP id y13-20020a056e02178d00b002dea00dd06cmr407477ilu.142.1660248823247;
        Thu, 11 Aug 2022 13:13:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR43ZGi6SzGc03X+U1pOQVeLFQiFETGagQRjEv5jpmvnRQZRUNvxVJqd6svLCQzVYY5ZqE/BzA==
X-Received: by 2002:a05:6e02:178d:b0:2de:a00d:d06c with SMTP id y13-20020a056e02178d00b002dea00dd06cmr407463ilu.142.1660248822967;
        Thu, 11 Aug 2022 13:13:42 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id a90-20020a029463000000b003435ab6a6b9sm206845jai.0.2022.08.11.13.13.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Aug 2022 13:13:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH] mm/uffd: Reset write protection when unregister with wp-mode
Date:   Thu, 11 Aug 2022 16:13:40 -0400
Message-Id: <20220811201340.39342-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motivation of this patch comes from a recent report and patchfix from
David Hildenbrand on hugetlb shared handling of wr-protected page [1].

With the reproducer provided in commit message of [1], one can leverage the
uffd-wp lazy-reset of ptes to trigger a hugetlb issue which can affect not
only the attacker process, but also the whole system.

The lazy-reset mechanism of uffd-wp was used to make unregister faster,
meanwhile it has an assumption that any leftover pgtable entries should
only affect the process on its own, so not only the user should be aware of
anything it does, but also it should not affect outside of the process.

But it seems that this is not true, and it can also be utilized to make
some exploit easier.

So far there's no clue showing that the lazy-reset is important to any
userfaultfd users because normally the unregister will only happen once for
a specific range of memory of the lifecycle of the process.

Considering all above, what this patch proposes is to do explicit pte
resets when unregister an uffd region with wr-protect mode enabled.

It should be the same as calling ioctl(UFFDIO_WRITEPROTECT, wp=false) right
before ioctl(UFFDIO_UNREGISTER) for the user.  So potentially it'll make
the unregister slower.  From that pov it's a very slight abi change, but
hopefully nothing should break with this change either.

Regarding to the change itself - core of uffd write [un]protect operation
is moved into a separate function (uffd_wp_range()) and it is reused in the
unregister code path.

Note that the new function will not check for anything, e.g. ranges or
memory types, because they should have been checked during the previous
UFFDIO_REGISTER or it should have failed already.  It also doesn't check
mmap_changing because we're with mmap write lock held anyway.

I added a Fixes upon introducing of uffd-wp shmem+hugetlbfs because that's
the only issue reported so far and that's the commit David's reproducer
will start working (v5.19+).  But the whole idea actually applies to not
only file memories but also anonymous.  It's just that we don't need to fix
anonymous prior to v5.19- because there's no known way to exploit.

IOW, this patch can also fix the issue reported in [1] as the patch 2 does.

[1] https://lore.kernel.org/all/20220811103435.188481-3-david@redhat.com/

Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c              |  4 ++++
 include/linux/userfaultfd_k.h |  2 ++
 mm/userfaultfd.c              | 29 ++++++++++++++++++-----------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 698e768d5c3d..941ede31a9da 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1597,6 +1597,10 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
+		/* Reset ptes for the whole vma range if wr-protected */
+		if (userfaultfd_wp(vma))
+			uffd_wp_range(mm, vma, start, vma_end - start, false);
+
 		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
 		prev = vma_merge(mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 732b522bacb7..e1b8a915e9e9 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -73,6 +73,8 @@ extern ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long dst_start,
 extern int mwriteprotect_range(struct mm_struct *dst_mm,
 			       unsigned long start, unsigned long len,
 			       bool enable_wp, atomic_t *mmap_changing);
+extern void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *vma,
+			  unsigned long start, unsigned long len, bool enable_wp);
 
 /* mm helpers */
 static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 07d3befc80e4..7327b2573f7c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -703,14 +703,29 @@ ssize_t mcopy_continue(struct mm_struct *dst_mm, unsigned long start,
 			      mmap_changing, 0);
 }
 
+void uffd_wp_range(struct mm_struct *dst_mm, struct vm_area_struct *dst_vma,
+		   unsigned long start, unsigned long len, bool enable_wp)
+{
+	struct mmu_gather tlb;
+	pgprot_t newprot;
+
+	if (enable_wp)
+		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
+	else
+		newprot = vm_get_page_prot(dst_vma->vm_flags);
+
+	tlb_gather_mmu(&tlb, dst_mm);
+	change_protection(&tlb, dst_vma, start, start + len, newprot,
+			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
+	tlb_finish_mmu(&tlb);
+}
+
 int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			unsigned long len, bool enable_wp,
 			atomic_t *mmap_changing)
 {
 	struct vm_area_struct *dst_vma;
 	unsigned long page_mask;
-	struct mmu_gather tlb;
-	pgprot_t newprot;
 	int err;
 
 	/*
@@ -750,15 +765,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 			goto out_unlock;
 	}
 
-	if (enable_wp)
-		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
-	else
-		newprot = vm_get_page_prot(dst_vma->vm_flags);
-
-	tlb_gather_mmu(&tlb, dst_mm);
-	change_protection(&tlb, dst_vma, start, start + len, newprot,
-			  enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE);
-	tlb_finish_mmu(&tlb);
+	uffd_wp_range(dst_mm, dst_vma, start, len, enable_wp);
 
 	err = 0;
 out_unlock:
-- 
2.32.0

