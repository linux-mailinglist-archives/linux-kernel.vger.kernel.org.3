Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D152C55A037
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiFXRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiFXRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86F68C41
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31814f7654dso26698277b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4vXUhYS1gVPcFf2LfwHq3p4PeYS4NxljSjceZ18tGG4=;
        b=SANzcf+LwCVGpRM55Cay++FK4cUCDPSiB1XYFVIRVPd8bp9OmeUxkkbKxAjSLEPaec
         rO0L74FDJGW8GBsbPMOk/D6MIlmhHhIDSjtWw7C+OlohYel2WaCeh5uufn8zu/z6hULm
         /YPEqs3V1KLPyQPBtO4T1n3x5IEA0mIDDhG4OM6wA+fQpkRtkK3I4ZlOCnhtXfYJJBvT
         zqcEyFkmPgpGY0oBWs35n3cyP752+a4rX4v1dipphzs54KYnjLeWO2uVKbQ1AeddxDAb
         M9UdJg2b1CXLL7GgWGFeWr1dEZLZQzO1Y1PjZaxJ6F/EO+UtB2CbCiS/IWX6f6NMt489
         ntQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4vXUhYS1gVPcFf2LfwHq3p4PeYS4NxljSjceZ18tGG4=;
        b=ki9vXsLPrCM1MgrI+KvqKUY9ZMw3kog5ktHMt+fzrDJ0FZgkv5SZ3FpQQpzrkvqjjT
         qIRbOImyJwD6noI4fYj3wfINTw5wS7oLL7/dxoC9nW3YhPzqrdIy9wcQBpIouyTZcQbe
         jZAFtF8nhExf6Np2iaTFGzz+H6rWgtnUe+qmaRu7OVYKH1/jqp2LSnqEZcKo5TM99tW+
         b2ge24O9w3+JiKXPApSSpMwwxWzKRbjfsYxT34htlrh6zcxCHlSPGNtK5t512pzNPrXZ
         9+PVWlqzSRjhZbskoiNwhqLoJUTvInzGwGTxj16pLSm+zvV+YFDhnrVkees9OkSLwA3O
         GJGQ==
X-Gm-Message-State: AJIora81xfY7OffOFH38JOhP22a7lTA/1me3+FJeZz6N6JxAx/op4wWB
        1AawGmieO3ICrqg/mzPnN5EHIfTkE//xD/TD
X-Google-Smtp-Source: AGRyM1ukQX4IYJ9JitkrwX+RpgB7i6QAoj2im0rwaYwc2vW9f/595sRIyJPCfzsFwuJfCBggqm9wh7FmHwoLS8un
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:b622:0:b0:317:af00:63c3 with SMTP
 id u34-20020a81b622000000b00317af0063c3mr24103ywh.298.1656092253828; Fri, 24
 Jun 2022 10:37:33 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:47 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-18-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 17/26] hugetlb: update follow_hugetlb_page to support HGM
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables support for GUP, and it is needed for the KVM demand paging
self-test to work.

One important change here is that, before, we never needed to grab the
i_mmap_sem, but now, to prevent someone from collapsing the page tables
out from under us, we grab it for reading when doing high-granularity PT
walks.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 70 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f9c7daa6c090..aadfcee947cf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6298,14 +6298,18 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long vaddr = *position;
 	unsigned long remainder = *nr_pages;
 	struct hstate *h = hstate_vma(vma);
+	struct address_space *mapping = vma->vm_file->f_mapping;
 	int err = -EFAULT, refs;
+	bool has_i_mmap_sem = false;
 
 	while (vaddr < vma->vm_end && remainder) {
 		pte_t *pte;
 		spinlock_t *ptl = NULL;
 		bool unshare = false;
 		int absent;
+		unsigned long pages_per_hpte;
 		struct page *page;
+		struct hugetlb_pte hpte;
 
 		/*
 		 * If we have a pending SIGKILL, don't keep faulting pages and
@@ -6325,9 +6329,23 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		pte = huge_pte_offset(mm, vaddr & huge_page_mask(h),
 				      huge_page_size(h));
-		if (pte)
-			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		if (pte) {
+			hugetlb_pte_populate(&hpte, pte, huge_page_shift(h));
+			if (hugetlb_hgm_enabled(vma)) {
+				BUG_ON(has_i_mmap_sem);
+				i_mmap_lock_read(mapping);
+				/*
+				 * Need to hold the mapping semaphore for
+				 * reading to do a HGM walk.
+				 */
+				has_i_mmap_sem = true;
+				hugetlb_walk_to(mm, &hpte, vaddr, PAGE_SIZE,
+						/*stop_at_none=*/true);
+			}
+			ptl = hugetlb_pte_lock(mm, &hpte);
+		}
+
+		absent = !pte || hugetlb_pte_none(&hpte);
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -6338,8 +6356,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		if (absent && (flags & FOLL_DUMP) &&
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
-			if (pte)
+			if (pte) {
+				if (has_i_mmap_sem) {
+					i_mmap_unlock_read(mapping);
+					has_i_mmap_sem = false;
+				}
 				spin_unlock(ptl);
+			}
 			remainder = 0;
 			break;
 		}
@@ -6359,8 +6382,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
-			if (pte)
+			if (pte) {
+				if (has_i_mmap_sem) {
+					i_mmap_unlock_read(mapping);
+					has_i_mmap_sem = false;
+				}
 				spin_unlock(ptl);
+			}
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6403,8 +6431,11 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			continue;
 		}
 
-		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		pfn_offset = (vaddr & ~hugetlb_pte_mask(&hpte)) >> PAGE_SHIFT;
+		page = pte_page(hugetlb_ptep_get(&hpte));
+		pages_per_hpte = hugetlb_pte_size(&hpte) / PAGE_SIZE;
+		if (hugetlb_hgm_enabled(vma))
+			page = compound_head(page);
 
 		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			       !PageAnonExclusive(page), page);
@@ -6414,17 +6445,21 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * and skip the same_page loop below.
 		 */
 		if (!pages && !vmas && !pfn_offset &&
-		    (vaddr + huge_page_size(h) < vma->vm_end) &&
-		    (remainder >= pages_per_huge_page(h))) {
-			vaddr += huge_page_size(h);
-			remainder -= pages_per_huge_page(h);
-			i += pages_per_huge_page(h);
+		    (vaddr + pages_per_hpte < vma->vm_end) &&
+		    (remainder >= pages_per_hpte)) {
+			vaddr += pages_per_hpte;
+			remainder -= pages_per_hpte;
+			i += pages_per_hpte;
 			spin_unlock(ptl);
+			if (has_i_mmap_sem) {
+				has_i_mmap_sem = false;
+				i_mmap_unlock_read(mapping);
+			}
 			continue;
 		}
 
 		/* vaddr may not be aligned to PAGE_SIZE */
-		refs = min3(pages_per_huge_page(h) - pfn_offset, remainder,
+		refs = min3(pages_per_hpte - pfn_offset, remainder,
 		    (vma->vm_end - ALIGN_DOWN(vaddr, PAGE_SIZE)) >> PAGE_SHIFT);
 
 		if (pages || vmas)
@@ -6447,6 +6482,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
 				spin_unlock(ptl);
+				if (has_i_mmap_sem) {
+					has_i_mmap_sem = false;
+					i_mmap_unlock_read(mapping);
+				}
 				remainder = 0;
 				err = -ENOMEM;
 				break;
@@ -6458,8 +6497,13 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		i += refs;
 
 		spin_unlock(ptl);
+		if (has_i_mmap_sem) {
+			has_i_mmap_sem = false;
+			i_mmap_unlock_read(mapping);
+		}
 	}
 	*nr_pages = remainder;
+	BUG_ON(has_i_mmap_sem);
 	/*
 	 * setting position is actually required only if remainder is
 	 * not zero but it's faster not to add a "if (remainder)"
-- 
2.37.0.rc0.161.g10f37bed90-goog

