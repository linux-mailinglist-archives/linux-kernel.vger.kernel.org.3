Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9024559FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiFXRhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiFXRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:28 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256A609CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:27 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id y8-20020a1f3208000000b0035e4cb54f24so908851vky.17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9NP33zy0A1MX3vEGrpVIKeFhmsIPx2kWV4buJ37voF4=;
        b=ZKOKH7vAAREURJ1l8IWF0iXVyZJmt/59w23N609lJlz66JMzYMime9PnmzUaf55ztT
         vzLMK8s9/fXSSxWnYgNDHKf7LqeMXxNL7KAl5SuDjU3NQJJ60yl5tOO73MRzJCUdunKz
         7Lgn3pxPgvpWylL4Lwm2BTczrJtzLYwEI/PWM2Cho00mXJipoxojyLs3eWxEQPPDnMB8
         Oxl49ZR9JG0HGfk3WVBD25dYMN0YwU/lye70tN93BwsbS6nd07nY55SUbsCU9gTsjkxw
         9k4o1zcXpunPWXdWooquHfqVjKqZmpuvtPY3r1RM36B/t5rz9uVN89mK3zfIIDtHV9hY
         WUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9NP33zy0A1MX3vEGrpVIKeFhmsIPx2kWV4buJ37voF4=;
        b=F8mnT85Rrefc5OkIBHJ8rVdSwjmj0w/w43Lui8wkrAdfKMWGMJ2ffxSo7IFCCIGESW
         l6bb90mAAl74KUCNi1q4DmwwUYgdTXBmXbZzht5nVLEeZKuWnviOvAGWGTFo4qt1twKl
         MlNGG5BK/CjhnayJeyAJy8123qywojhFbGiafPyZgBgPj3IkpqlTYwQj/NH8FMrIG4Nt
         0xEV6hYjwZp8iGOGHn2yxXLtD2eT2fyHykhKz+vclrJivSRBqSNWhovORK7QEzpOzat6
         sDepQq/+1Jp0WPs0YYoh2ueSbAmeLAQTL8BhAlqKcaa9MsX7p6vMxdIbMER9vNIlSRBD
         cv/g==
X-Gm-Message-State: AJIora8w08kgWFYdTVGD8gQdcPyMR4zJjwunYIRmsp4ZSKrlm6EUr+S0
        cAKTI9zachEUn5+kvxJNyRtC3xbyBfCycCoB
X-Google-Smtp-Source: AGRyM1ud2VpyFSoYe3jfqlLqsCZHAGiyta2WrrFtmqkuRYO0f2uYFJE5sTDJIrzr1fNDbhgGC1mFcexvMmBaf2W2
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:ef4a:0:b0:354:6546:8b97 with SMTP
 id k10-20020a67ef4a000000b0035465468b97mr8260702vsr.83.1656092246792; Fri, 24
 Jun 2022 10:37:26 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:42 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-13-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 12/26] hugetlb: add HugeTLB splitting functionality
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

The new function, hugetlb_split_to_shift, will optimally split the page
table to map a particular address at a particular granularity.

This is useful for punching a hole in the mapping and for mapping small
sections of a HugeTLB page (via UFFDIO_CONTINUE, for example).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3ec2a921ee6f..eaffe7b4f67c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -102,6 +102,18 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 
+/*
+ * Find the subpage that corresponds to `addr` in `hpage`.
+ */
+static struct page *hugetlb_find_subpage(struct hstate *h, struct page *hpage,
+				 unsigned long addr)
+{
+	size_t idx = (addr & ~huge_page_mask(h))/PAGE_SIZE;
+
+	BUG_ON(idx >= pages_per_huge_page(h));
+	return &hpage[idx];
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -7044,6 +7056,116 @@ static unsigned int __shift_for_hstate(struct hstate *h)
 	for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
 			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
 			       (tmp_h)++)
+
+/*
+ * Given a particular address, split the HugeTLB PTE that currently maps it
+ * so that, for the given address, the PTE that maps it is `desired_shift`.
+ * This function will always split the HugeTLB PTE optimally.
+ *
+ * For example, given a HugeTLB 1G page that is mapped from VA 0 to 1G. If we
+ * call this function with addr=0 and desired_shift=PAGE_SHIFT, will result in
+ * these changes to the page table:
+ * 1. The PUD will be split into 2M PMDs.
+ * 2. The first PMD will be split again into 4K PTEs.
+ */
+static int hugetlb_split_to_shift(struct mm_struct *mm, struct vm_area_struct *vma,
+			   const struct hugetlb_pte *hpte,
+			   unsigned long addr, unsigned long desired_shift)
+{
+	unsigned long start, end, curr;
+	unsigned long desired_sz = 1UL << desired_shift;
+	struct hstate *h = hstate_vma(vma);
+	int ret;
+	struct hugetlb_pte new_hpte;
+	struct mmu_notifier_range range;
+	struct page *hpage = NULL;
+	struct page *subpage;
+	pte_t old_entry;
+	struct mmu_gather tlb;
+
+	BUG_ON(!hpte->ptep);
+	BUG_ON(hugetlb_pte_size(hpte) == desired_sz);
+
+	start = addr & hugetlb_pte_mask(hpte);
+	end = start + hugetlb_pte_size(hpte);
+
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+
+	BUG_ON(!hpte->ptep);
+	/* This function only works if we are looking at a leaf-level PTE. */
+	BUG_ON(!hugetlb_pte_none(hpte) && !hugetlb_pte_present_leaf(hpte));
+
+	/*
+	 * Clear the PTE so that we will allocate the PT structures when
+	 * walking the page table.
+	 */
+	old_entry = huge_ptep_get_and_clear(mm, start, hpte->ptep);
+
+	if (!huge_pte_none(old_entry))
+		hpage = pte_page(old_entry);
+
+	BUG_ON(!IS_ALIGNED(start, desired_sz));
+	BUG_ON(!IS_ALIGNED(end, desired_sz));
+
+	for (curr = start; curr < end;) {
+		struct hstate *tmp_h;
+		unsigned int shift;
+
+		for_each_hgm_shift(h, tmp_h, shift) {
+			unsigned long sz = 1UL << shift;
+
+			if (!IS_ALIGNED(curr, sz) || curr + sz > end)
+				continue;
+			/*
+			 * If we are including `addr`, we need to make sure
+			 * splitting down to the correct size. Go to a smaller
+			 * size if we are not.
+			 */
+			if (curr <= addr && curr + sz > addr &&
+					shift > desired_shift)
+				continue;
+
+			/*
+			 * Continue the page table walk to the level we want,
+			 * allocate PT structures as we go.
+			 */
+			hugetlb_pte_copy(&new_hpte, hpte);
+			ret = hugetlb_walk_to(mm, &new_hpte, curr, sz,
+					      /*stop_at_none=*/false);
+			if (ret)
+				goto err;
+			BUG_ON(hugetlb_pte_size(&new_hpte) != sz);
+			if (hpage) {
+				pte_t new_entry;
+
+				subpage = hugetlb_find_subpage(h, hpage, curr);
+				new_entry = make_huge_pte_with_shift(vma, subpage,
+								     huge_pte_write(old_entry),
+								     shift);
+				set_huge_pte_at(mm, curr, new_hpte.ptep, new_entry);
+			}
+			curr += sz;
+			goto next;
+		}
+		/* We couldn't find a size that worked. */
+		BUG();
+next:
+		continue;
+	}
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
+				start, end);
+	mmu_notifier_invalidate_range_start(&range);
+	return 0;
+err:
+	tlb_gather_mmu(&tlb, mm);
+	/* Free any newly allocated page table entries. */
+	hugetlb_free_range(&tlb, hpte, start, curr);
+	/* Restore the old entry. */
+	set_huge_pte_at(mm, start, hpte->ptep, old_entry);
+	tlb_finish_mmu(&tlb);
+	return ret;
+}
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
-- 
2.37.0.rc0.161.g10f37bed90-goog

