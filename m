Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33C55A055
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiFXRi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiFXRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:39 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBA7609EF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:37 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id p185-20020a1fd8c2000000b0036c453f2ea4so918259vkg.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BEnHzeA8IqLcgv72Sg9jh80/umPdhd6MjUiQ8hqfSFI=;
        b=GdzVxrX7wkYjgErfDdqCIkYSvWPbbIDKSxW5Wzna9kLimEZLIF7v/kjfzJ0/MJJI8C
         Nan7vqP8mjs7qbiftpzOotx0G0VhhFdl+a3xoAwOSm1ekZLV4zffUeKakFvQsIpRI1Zt
         tqdgg1fUIcbUxn4sKjY6xnWu7yiFtN8U8XUowuMeteG3pczq9XwOEfTu1w4q9aFihIch
         Gea+lKdHnWOnA7lB1uuW7+Uv8ZFug+g0pv2kbNnErXzZs6E84L9Efj3yIVwEZKkFg8tY
         dzRXPhe7pxjxGRQKU8w+ukahEWnGGDq1tUSkIQMfu89Z2YI4CkLnSQBu54xqTuD+UzJw
         axPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BEnHzeA8IqLcgv72Sg9jh80/umPdhd6MjUiQ8hqfSFI=;
        b=zswNRVVii+Ivh856yVvn3FXk7aHAeHn+zRNgwzIfxc2WH7pxKDZ90DnbPJG6X87rZ7
         QMAresIAVgX8mPFyqnBm+ImGk9qN4oMhilEdxlH1ZGqsxHHcgI4uPK6brTccivBkHXrF
         pX0/FgHUNTwapYGytYkZp2S2r3f8IJY+5PdqwqsdI2PGm+vxp1zO23qrqEuIz6WQsull
         +RZgddL2Nz95IUqIW5/XNzmB9f8SghQBkPhNlRvxw9JsfWmM3KhwFgmkElce0mJnm5E6
         TqAkN7RmhbjB6MwEMe/JSXnbhIxs6N5F/5IILkbTo/v9A5YR6DjbByKVyf7QwS6Q7l6Q
         OZUA==
X-Gm-Message-State: AJIora/aWDEezu47cZCrRm8ulVED4msV3qdiyVkzD24BxOaklZNRppr3
        K6wL36J+WRKpdJVPhi2KU9KGLSz5MM3H2wfk
X-Google-Smtp-Source: AGRyM1uf1g766JLfRQ4yT/c5CHXe9SFwBo1833UUdGMaiNufztGVkND1yyG58uFyUB+Rm94Hkh8sbhU0SS7vep8r
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a1f:3456:0:b0:368:ca4e:1bd1 with SMTP
 id b83-20020a1f3456000000b00368ca4e1bd1mr4581vka.36.1656092256495; Fri, 24
 Jun 2022 10:37:36 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:49 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-20-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 19/26] hugetlb: add HGM support for copy_hugetlb_page_range
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

This allows fork() to work with high-granularity mappings. The page
table structure is copied such that partially mapped regions will remain
partially mapped in the same way for the new process.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 74 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aadfcee947cf..0ec2f231524e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4851,7 +4851,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			    struct vm_area_struct *src_vma)
 {
 	pte_t *src_pte, *dst_pte, entry, dst_entry;
-	struct page *ptepage;
+	struct hugetlb_pte src_hpte, dst_hpte;
+	struct page *ptepage, *hpage;
 	unsigned long addr;
 	bool cow = is_cow_mapping(src_vma->vm_flags);
 	struct hstate *h = hstate_vma(src_vma);
@@ -4878,17 +4879,44 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		i_mmap_lock_read(mapping);
 	}
 
-	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
+	addr = src_vma->vm_start;
+	while (addr < src_vma->vm_end) {
 		spinlock_t *src_ptl, *dst_ptl;
+		unsigned long hpte_sz;
 		src_pte = huge_pte_offset(src, addr, sz);
-		if (!src_pte)
+		if (!src_pte) {
+			addr += sz;
 			continue;
+		}
 		dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);
 		if (!dst_pte) {
 			ret = -ENOMEM;
 			break;
 		}
 
+		hugetlb_pte_populate(&src_hpte, src_pte, huge_page_shift(h));
+		hugetlb_pte_populate(&dst_hpte, dst_pte, huge_page_shift(h));
+
+		if (hugetlb_hgm_enabled(src_vma)) {
+			BUG_ON(!hugetlb_hgm_enabled(dst_vma));
+			ret = hugetlb_walk_to(src, &src_hpte, addr,
+					      PAGE_SIZE, /*stop_at_none=*/true);
+			if (ret)
+				break;
+			ret = huge_pte_alloc_high_granularity(
+					&dst_hpte, dst, dst_vma, addr,
+					hugetlb_pte_shift(&src_hpte),
+					HUGETLB_SPLIT_NONE,
+					/*write_locked=*/false);
+			if (ret)
+				break;
+
+			src_pte = src_hpte.ptep;
+			dst_pte = dst_hpte.ptep;
+		}
+
+		hpte_sz = hugetlb_pte_size(&src_hpte);
+
 		/*
 		 * If the pagetables are shared don't copy or take references.
 		 * dst_pte == src_pte is the common case of src/dest sharing.
@@ -4899,16 +4927,19 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		 * after taking the lock below.
 		 */
 		dst_entry = huge_ptep_get(dst_pte);
-		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
+		if ((dst_pte == src_pte) || !hugetlb_pte_none(&dst_hpte)) {
+			addr += hugetlb_pte_size(&src_hpte);
 			continue;
+		}
 
-		dst_ptl = huge_pte_lock(h, dst, dst_pte);
-		src_ptl = huge_pte_lockptr(huge_page_shift(h), src, src_pte);
+		dst_ptl = hugetlb_pte_lock(dst, &dst_hpte);
+		src_ptl = hugetlb_pte_lockptr(src, &src_hpte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		entry = huge_ptep_get(src_pte);
 		dst_entry = huge_ptep_get(dst_pte);
 again:
-		if (huge_pte_none(entry) || !huge_pte_none(dst_entry)) {
+		if (hugetlb_pte_none(&src_hpte) ||
+		    !hugetlb_pte_none(&dst_hpte)) {
 			/*
 			 * Skip if src entry none.  Also, skip in the
 			 * unlikely case dst entry !none as this implies
@@ -4931,11 +4962,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				if (userfaultfd_wp(src_vma) && uffd_wp)
 					entry = huge_pte_mkuffd_wp(entry);
 				set_huge_swap_pte_at(src, addr, src_pte,
-						     entry, sz);
+						     entry, hpte_sz);
 			}
 			if (!userfaultfd_wp(dst_vma) && uffd_wp)
 				entry = huge_pte_clear_uffd_wp(entry);
-			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
+			set_huge_swap_pte_at(dst, addr, dst_pte, entry,
+					     hpte_sz);
 		} else if (unlikely(is_pte_marker(entry))) {
 			/*
 			 * We copy the pte marker only if the dst vma has
@@ -4946,7 +4978,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else {
 			entry = huge_ptep_get(src_pte);
 			ptepage = pte_page(entry);
-			get_page(ptepage);
+			hpage = compound_head(ptepage);
+			get_page(hpage);
 
 			/*
 			 * Failing to duplicate the anon rmap is a rare case
@@ -4959,9 +4992,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sleep during the process.
 			 */
 			if (!PageAnon(ptepage)) {
-				page_dup_file_rmap(ptepage, true);
+				/* Only dup_rmap once for a page */
+				if (IS_ALIGNED(addr, sz))
+					page_dup_file_rmap(hpage, true);
 			} else if (page_try_dup_anon_rmap(ptepage, true,
 							  src_vma)) {
+				if (hugetlb_hgm_enabled(src_vma)) {
+					ret = -EINVAL;
+					break;
+				}
+				BUG_ON(!IS_ALIGNED(addr, hugetlb_pte_size(&src_hpte)));
 				pte_t src_pte_old = entry;
 				struct page *new;
 
@@ -4970,13 +5010,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				/* Do not use reserve as it's private owned */
 				new = alloc_huge_page(dst_vma, addr, 1);
 				if (IS_ERR(new)) {
-					put_page(ptepage);
+					put_page(hpage);
 					ret = PTR_ERR(new);
 					break;
 				}
-				copy_user_huge_page(new, ptepage, addr, dst_vma,
+				copy_user_huge_page(new, hpage, addr, dst_vma,
 						    npages);
-				put_page(ptepage);
+				put_page(hpage);
 
 				/* Install the new huge page if src pte stable */
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
@@ -4994,6 +5034,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				hugetlb_install_page(dst_vma, dst_pte, addr, new);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
+				addr += hugetlb_pte_size(&src_hpte);
 				continue;
 			}
 
@@ -5010,10 +5051,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			}
 
 			set_huge_pte_at(dst, addr, dst_pte, entry);
-			hugetlb_count_add(npages, dst);
+			hugetlb_count_add(
+					hugetlb_pte_size(&dst_hpte) / PAGE_SIZE,
+					dst);
 		}
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
+		addr += hugetlb_pte_size(&src_hpte);
 	}
 
 	if (cow) {
-- 
2.37.0.rc0.161.g10f37bed90-goog

