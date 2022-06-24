Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF055A006
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiFXRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiFXRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483F69FB0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h82-20020a25d055000000b00668b6a4ee32so2795078ybg.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qZvlqd2OvHLqh9twYpoJb6ja2/RhkWxX/89zPHTcn/8=;
        b=HypVRxxS8PLtYfgYxeV9SmynEG7TPz9Ce9bLT5zNY+BqsBZ2dR4Yu4comEv+XUubMf
         Tmv+PSPoTEgf52wvkhnc+37jzKxSIz2QTdTgR7IQrEhC+hxTC0PzE5yPLYSLsF+ypT+o
         1OeHChfqJn7nF+ydLkcR+31+kCdErcxCg8RBgd1BXnunKktxWtdnnRX0+mbYnTgG3k0r
         JrUchYTC7GVTsL0xlXQAvH8al5VjVjNSgxGZ6hOsGdc8TeDaNczkB4rHzNv7Qy1NkMg2
         e5uS8qHvOfJ8S8UR/qFyiENp/V1amoyWL0FT1OODwP+y6Qxkpk2El/2APigbVyzdYVIR
         wp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZvlqd2OvHLqh9twYpoJb6ja2/RhkWxX/89zPHTcn/8=;
        b=CnHQHAY9mSfE+8MAkonYqLHNatYz+rBYnL9Dl/MbW4g3PEcnRkzY+7dUZx/dEJIivV
         vfJGHu4EAHNK5Zssr/i9mxcvLL6aiT56tjwFdA9Yg4/NVPjN95t14VjtYH0cGb5/m5DE
         OejC6roPlgE+SyS+WHwhQBtsCj5g9kyBfRqOX2TTLcj/qdL9Rd9WowuKnTJtoLFpHLAh
         /CR9PZyDh+t3f7T93fC0h3euk5YfSu/EBccQ6XYQDpKmIukpuJwKDCFpJ4vIoEgJdE5P
         wojKIrQWi+dgE1Nh4PVqTfl+58/IjBc8kSUvWbh/SMsud7bKT+TnVuhxkXfYsQeQElqo
         JGyQ==
X-Gm-Message-State: AJIora9CWvd/EHCwXEzCnI0V/4qPpIM/iyr2oBdXRJNnzpFlNHc6nAKr
        l/Rz4sROGXQW9xT2HCh8GBngkRihm0zIqvcp
X-Google-Smtp-Source: AGRyM1vcrrrISl0XVFny3ew+g+bNEBjQOnnF9F+zSGfcQuntVV3TKgvjvU6TjNDpiUuNx/38+gEcAslpNt52T6De
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:c7cb:0:b0:664:67aa:36a7 with SMTP
 id w194-20020a25c7cb000000b0066467aa36a7mr298952ybe.548.1656092259292; Fri,
 24 Jun 2022 10:37:39 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:51 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-22-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 21/26] hugetlb: add hugetlb_collapse
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

This is what implements MADV_COLLAPSE for HugeTLB pages. This is a
necessary extension to the UFFDIO_CONTINUE changes. When userspace
finishes mapping an entire hugepage with UFFDIO_CONTINUE, the kernel has
no mechanism to automatically collapse the page table to map the whole
hugepage normally. We require userspace to inform us that they would
like the hugepages to be collapsed; they do this with MADV_COLLAPSE.

If userspace has not mapped all of a hugepage with UFFDIO_CONTINUE, but
only some, hugetlb_collapse will cause the requested range to be mapped
as if it were UFFDIO_CONTINUE'd already.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  7 ++++
 mm/hugetlb.c            | 88 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c207b1ac6195..438057dc3b75 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1197,6 +1197,8 @@ int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
 				    unsigned int desired_sz,
 				    enum split_mode mode,
 				    bool write_locked);
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end);
 #else
 static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 {
@@ -1221,6 +1223,11 @@ static inline int huge_pte_alloc_high_granularity(struct hugetlb_pte *hpte,
 {
 	return -EINVAL;
 }
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+		     unsigned long start, unsigned long end)
+{
+	return -EINVAL;
+}
 #endif
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 09fa57599233..70bb3a1342d9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7280,6 +7280,94 @@ int hugetlb_alloc_largest_pte(struct hugetlb_pte *hpte, struct mm_struct *mm,
 	return -EINVAL;
 }
 
+/*
+ * Collapse the address range from @start to @end to be mapped optimally.
+ *
+ * This is only valid for shared mappings. The main use case for this function
+ * is following UFFDIO_CONTINUE. If a user UFFDIO_CONTINUEs an entire hugepage
+ * by calling UFFDIO_CONTINUE once for each 4K region, the kernel doesn't know
+ * to collapse the mapping after the final UFFDIO_CONTINUE. Instead, we leave
+ * it up to userspace to tell us to do so, via MADV_COLLAPSE.
+ *
+ * Any holes in the mapping will be filled. If there is no page in the
+ * pagecache for a region we're collapsing, the PTEs will be cleared.
+ */
+int hugetlb_collapse(struct mm_struct *mm, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct mmu_notifier_range range;
+	struct mmu_gather tlb;
+	struct hstate *tmp_h;
+	unsigned int shift;
+	unsigned long curr = start;
+	int ret = 0;
+	struct page *hpage, *subpage;
+	pgoff_t idx;
+	bool writable = vma->vm_flags & VM_WRITE;
+	bool shared = vma->vm_flags & VM_SHARED;
+	pte_t entry;
+
+	/*
+	 * This is only supported for shared VMAs, because we need to look up
+	 * the page to use for any PTEs we end up creating.
+	 */
+	if (!shared)
+		return -EINVAL;
+
+	i_mmap_assert_write_locked(mapping);
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	tlb_gather_mmu(&tlb, mm);
+
+	while (curr < end) {
+		for_each_hgm_shift(h, tmp_h, shift) {
+			unsigned long sz = 1UL << shift;
+			struct hugetlb_pte hpte;
+
+			if (!IS_ALIGNED(curr, sz) || curr + sz > end)
+				continue;
+
+			hugetlb_pte_init(&hpte);
+			ret = hugetlb_walk_to(mm, &hpte, curr, sz,
+					      /*stop_at_none=*/false);
+			if (ret)
+				goto out;
+			if (hugetlb_pte_size(&hpte) >= sz)
+				goto hpte_finished;
+
+			idx = vma_hugecache_offset(h, vma, curr);
+			hpage = find_lock_page(mapping, idx);
+			hugetlb_free_range(&tlb, &hpte, curr,
+					   curr + hugetlb_pte_size(&hpte));
+			if (!hpage) {
+				hugetlb_pte_clear(mm, &hpte, curr);
+				goto hpte_finished;
+			}
+
+			subpage = hugetlb_find_subpage(h, hpage, curr);
+			entry = make_huge_pte_with_shift(vma, subpage,
+							 writable, shift);
+			set_huge_pte_at(mm, curr, hpte.ptep, entry);
+			unlock_page(hpage);
+hpte_finished:
+			curr += hugetlb_pte_size(&hpte);
+			goto next;
+		}
+		ret = -EINVAL;
+		goto out;
+next:
+		continue;
+	}
+out:
+	tlb_finish_mmu(&tlb);
+	mmu_notifier_invalidate_range_end(&range);
+	return ret;
+}
+
 /*
  * Given a particular address, split the HugeTLB PTE that currently maps it
  * so that, for the given address, the PTE that maps it is `desired_shift`.
-- 
2.37.0.rc0.161.g10f37bed90-goog

