Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E534CCCEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiCDFTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238073AbiCDFTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B48D7B572
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4ZxUpUrUaV8nyMPDE8x8P31UP3HUv0lUXU89pH2T9E=;
        b=CPw1GPYEmsnwU9//m5WqsPkWze4ZJGUCm+AZg70kGDE6n20QoRR3iSTCizfat9LIr3qw/S
        qEUauH+UtL8SoJU98L01FDPZkN5JawG1vyJzbw5nQ1AtNC67PsXPsIVzsn+lsY4+l62lJ8
        T34UbSXQnkL2FerA7m87DNhpCeiGnRE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-bPCDomFMOMm--0LmnngjDg-1; Fri, 04 Mar 2022 00:18:12 -0500
X-MC-Unique: bPCDomFMOMm--0LmnngjDg-1
Received: by mail-pg1-f198.google.com with SMTP id g31-20020a63521f000000b003783582a261so3921414pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4ZxUpUrUaV8nyMPDE8x8P31UP3HUv0lUXU89pH2T9E=;
        b=u+KkciP+2XQMX/fGvVn/jkknTBNQ8N2+lYEYy4Pl/HxBTUpKZCm5CUuy9bZno/gLuO
         ADCV38Hsqs3aYJuSDR/8VllfTCL238Vd5+4oZFxrNEkdyzEMYoniDBX1AJG0XVXoIs49
         oEGN1hg663QrwI+vkl1Q2WEzXrbt1Fu42n/bqzqhjovElFT0WHyBrILbaaaRH/5IxoAB
         u5+WW1cPlM+SZhPDZMcwNh74xAXZdKBVojQ15cETsIRXQmfj78PXhwJxr0PDnSFwdjgl
         bE1pKICZV62dWN8PFqIK/7r6DttCQiMA3oI8M0b+PuL4jSSj2DKsTSA3XV/qn6gT/bTI
         B9nw==
X-Gm-Message-State: AOAM533yRag318zGmwLsCSd09LNH/BoH4/3jNb+18E9+bzIK/S8ca4KM
        FKgx08C72/lJfgzADG7i6Oy1FINR5VPlgMsiIhjdpi+yBlLgwKGraLApPhVKqOr70YXVRrjTGr/
        8aTuK5pdA440RoawhG2GORanj
X-Received: by 2002:a05:6a00:b96:b0:4f3:c0f6:5c47 with SMTP id g22-20020a056a000b9600b004f3c0f65c47mr517330pfj.69.1646371091189;
        Thu, 03 Mar 2022 21:18:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn5dg8SYjJevnXT+y2Ca46TGDW60Atz3RHVXa5U9+Jx4K7xiL9CysJtRs0lRcaiYEnHEu04Q==
X-Received: by 2002:a05:6a00:b96:b0:4f3:c0f6:5c47 with SMTP id g22-20020a056a000b9600b004f3c0f65c47mr517282pfj.69.1646371090410;
        Thu, 03 Mar 2022 21:18:10 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.18.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:18:10 -0800 (PST)
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
Subject: [PATCH v7 06/23] mm/shmem: Handle uffd-wp special pte in page fault handler
Date:   Fri,  4 Mar 2022 13:16:51 +0800
Message-Id: <20220304051708.86193-7-peterx@redhat.com>
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

File-backed memories are prone to unmap/swap so the ptes are always unstable,
because they can be easily faulted back later using the page cache.  This could
lead to uffd-wp getting lost when unmapping or swapping out such memory.  One
example is shmem.  PTE markers are needed to store those information.

This patch prepares it by handling uffd-wp pte markers first it is applied
elsewhere, so that the page fault handler can recognize uffd-wp pte markers.

The handling of uffd-wp pte markers is similar to missing fault, it's just that
we'll handle this "missing fault" when we see the pte markers, meanwhile we
need to make sure the marker information is kept during processing the fault.

This is a slow path of uffd-wp handling, because zapping of wr-protected shmem
ptes should be rare.  So far it should only trigger in two conditions:

  (1) When trying to punch holes in shmem_fallocate(), there is an optimization
      to zap the pgtables before evicting the page.

  (2) When swapping out shmem pages.

Because of this, the page fault handling is simplifed too by not sending the
wr-protect message in the 1st page fault, instead the page will be installed
read-only, so the uffd-wp message will be generated in the next fault, which
will trigger the do_wp_page() path of general uffd-wp handling.

Disable fault-around for all uffd-wp registered ranges for extra safety just
like uffd-minor fault, and clean the code up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 17 +++++++++
 mm/memory.c                   | 67 ++++++++++++++++++++++++++++++-----
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index bd09c3c89b59..827e38b7be65 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -96,6 +96,18 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
+/*
+ * Don't do fault around for either WP or MINOR registered uffd range.  For
+ * MINOR registered range, fault around will be a total disaster and ptes can
+ * be installed without notifications; for WP it should mostly be fine as long
+ * as the fault around checks for pte_none() before the installation, however
+ * to be super safe we just forbid it.
+ */
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
@@ -236,6 +248,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/mm/memory.c b/mm/memory.c
index cdd0d108d3ee..f509ddf2ad39 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3512,6 +3512,39 @@ static inline bool should_try_to_free_swap(struct page *page,
 		page_count(page) == 2;
 }
 
+static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	/*
+	 * Be careful so that we will only recover a special uffd-wp pte into a
+	 * none pte.  Otherwise it means the pte could have changed, so retry.
+	 */
+	if (is_pte_marker(*vmf->pte))
+		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
+}
+
+/*
+ * This is actually a page-missing access, but with uffd-wp special pte
+ * installed.  It means this pte was wr-protected before being unmapped.
+ */
+static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
+{
+	/*
+	 * Just in case there're leftover special ptes even after the region
+	 * got unregistered - we can simply clear them.  We can also do that
+	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
+	 * ranges, but it should be more efficient to be done lazily here.
+	 */
+	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+		return pte_marker_clear(vmf);
+
+	/* do_fault() can handle pte markers too like none pte */
+	return do_fault(vmf);
+}
+
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 {
 	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
@@ -3525,8 +3558,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
 		return VM_FAULT_SIGBUS;
 
-	/* TODO: handle pte markers */
-	return 0;
+	if (pte_marker_entry_uffd_wp(entry))
+		return pte_marker_handle_uffd_wp(vmf);
+
+	/* This is an unknown pte marker */
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -4051,6 +4087,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = pte_marker_uffd_wp(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -4065,6 +4102,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (unlikely(uffd_wp))
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -4238,9 +4277,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 }
 
+/* Return true if we should do read fault-around, false otherwise */
+static inline bool should_fault_around(struct vm_fault *vmf)
+{
+	/* No ->map_pages?  No way to fault around... */
+	if (!vmf->vma->vm_ops->map_pages)
+		return false;
+
+	if (uffd_disable_fault_around(vmf->vma))
+		return false;
+
+	return fault_around_bytes >> PAGE_SHIFT > 1;
+}
+
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
 	/*
@@ -4248,12 +4299,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		if (likely(!userfaultfd_minor(vmf->vma))) {
-			ret = do_fault_around(vmf);
-			if (ret)
-				return ret;
-		}
+	if (should_fault_around(vmf)) {
+		ret = do_fault_around(vmf);
+		if (ret)
+			return ret;
 	}
 
 	ret = __do_fault(vmf);
-- 
2.32.0

