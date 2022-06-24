Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447E655A010
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiFXRiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiFXRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:39 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B069A9E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:35 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id bi53-20020a05612218b500b0036c4f0a665aso919415vkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PksJjdHLiQ+Ffd6zQef9Iz4jywxKAioMqz57hWInkDg=;
        b=CVSOUoyNCnP0rQqtT4BE26Dr49QTmhaHr+EPb5lqChGIPzWFaKi2n/SA62lBxC6G/B
         38JLajUBFsj5yNNTJYJpPlG3zt4pbxEEo2Rz5Lr/JGAlR2IwlDVrB8t1N7Y+51hiEkuD
         gcnSn3SJ6wF8gQl0GgUcoaWzUop7tCNZg00gOvNwMpyc7M5qd3SPq9S8bqdni3sMcV35
         kXFlC8wCSqKpXC2OZoAMiwb0Uh8BsCsg9QMBeTSA8RKx5u8y//crTwU2xRxSAPBpji+j
         8CrB/r/r4To8R+R8wlCzmWqlOMTd2sXPyHS+kZrv02x6KWrEb//6NFB/h8l/58GK1WFV
         fg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PksJjdHLiQ+Ffd6zQef9Iz4jywxKAioMqz57hWInkDg=;
        b=f48cD1RlcRsSzweARPv5M6TwdvUte9SbTDEYX3hC6A5WjAt9kl2Z/v/gvuWgckA0/w
         2wbedoWnjr9BI1Q+bpI4+S1tdF/u8G2bDH7zb1NO65tvb3spolNRbMlhAl0RGzY25KLO
         mtBATeOAZFdr93HPAGmFuOUAy6BSrqzHhlj9zO0T8FhgunwGfmsjuORW4Sm+H7ZhqXmu
         ZqQ0bPQTIsNDAdoNccs99eXb/r+E7jIrcUxDl6US/SYi7PvLp7cEjPqc6nl8QwD/Jovg
         nCETtR5KkI2fqjrxtcd3o2mNJwqoVtF0fE94YGgLnF9/cIWehrpp4b8LmhxPf6+bY+69
         fTRg==
X-Gm-Message-State: AJIora/XOLwCmMrmSTk4qOsZbqklQB7phba1N1BGIiOmGz1ymLLadVSH
        +F/ATAILHUzXVAQ5nqyojL92Dhqv7LHiUrRl
X-Google-Smtp-Source: AGRyM1uzsUo/NuKSmF0jRF4mJpyyTbf5p62c3XbnqsReOpJTYqhsntb/uUYVHZ67smUJaqTgbmvBTzx9NYHbRHzK
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6122:10c7:b0:36c:1d34:16bc with
 SMTP id l7-20020a05612210c700b0036c1d3416bcmr17244vko.22.1656092255089; Fri,
 24 Jun 2022 10:37:35 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:48 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-19-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 18/26] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
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

Although this change is large, it is somewhat straightforward. Before,
all users of walk_hugetlb_range could get the size of the PTE just be
checking the hmask or the mm_walk struct. With HGM, that information is
held in the hugetlb_pte struct, so we provide that instead of the raw
pte_t*.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/s390/mm/gmap.c      |  8 ++++++--
 fs/proc/task_mmu.c       | 35 +++++++++++++++++++----------------
 include/linux/pagewalk.h |  3 ++-
 mm/damon/vaddr.c         | 34 ++++++++++++++++++----------------
 mm/hmm.c                 |  7 ++++---
 mm/mempolicy.c           | 11 ++++++++---
 mm/mincore.c             |  4 ++--
 mm/mprotect.c            |  6 +++---
 mm/pagewalk.c            | 18 ++++++++++++++++--
 9 files changed, 78 insertions(+), 48 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b8ae4a4aa2ba..518cebfd72cd 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2620,10 +2620,14 @@ static int __s390_enable_skey_pmd(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
-				      unsigned long hmask, unsigned long next,
+static int __s390_enable_skey_hugetlb(struct hugetlb_pte *hpte,
+				      unsigned long addr, unsigned long next,
 				      struct mm_walk *walk)
 {
+	if (!hugetlb_pte_present_leaf(hpte) ||
+			hugetlb_pte_size(hpte) != PMD_SIZE)
+		return -EINVAL;
+
 	pmd_t *pmd = (pmd_t *)pte;
 	unsigned long start, end;
 	struct page *page = pmd_page(*pmd);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..b2d683f99fa9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -714,18 +714,19 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
+static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
 				 unsigned long addr, unsigned long end,
 				 struct mm_walk *walk)
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	struct page *page = NULL;
+	pte_t pte = hugetlb_ptep_get(hpte);
 
-	if (pte_present(*pte)) {
-		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
-		swp_entry_t swpent = pte_to_swp_entry(*pte);
+	if (hugetlb_pte_present_leaf(hpte)) {
+		page = vm_normal_page(vma, addr, pte);
+	} else if (is_swap_pte(pte)) {
+		swp_entry_t swpent = pte_to_swp_entry(pte);
 
 		if (is_pfn_swap_entry(swpent))
 			page = pfn_swap_entry_to_page(swpent);
@@ -734,9 +735,9 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 		int mapcount = page_mapcount(page);
 
 		if (mapcount >= 2)
-			mss->shared_hugetlb += huge_page_size(hstate_vma(vma));
+			mss->shared_hugetlb += hugetlb_pte_size(hpte);
 		else
-			mss->private_hugetlb += huge_page_size(hstate_vma(vma));
+			mss->private_hugetlb += hugetlb_pte_size(hpte);
 	}
 	return 0;
 }
@@ -1535,7 +1536,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 #ifdef CONFIG_HUGETLB_PAGE
 /* This function walks within one hugetlb entry in the single call */
-static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
+static int pagemap_hugetlb_range(struct hugetlb_pte *hpte,
 				 unsigned long addr, unsigned long end,
 				 struct mm_walk *walk)
 {
@@ -1543,13 +1544,13 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	struct vm_area_struct *vma = walk->vma;
 	u64 flags = 0, frame = 0;
 	int err = 0;
-	pte_t pte;
+	unsigned long hmask = hugetlb_pte_mask(hpte);
 
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
-	if (pte_present(pte)) {
+	if (hugetlb_pte_present_leaf(hpte)) {
+		pte_t pte = hugetlb_ptep_get(hpte);
 		struct page *page = pte_page(pte);
 
 		if (!PageAnon(page))
@@ -1565,7 +1566,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 		if (pm->show_pfn)
 			frame = pte_pfn(pte) +
 				((addr & ~hmask) >> PAGE_SHIFT);
-	} else if (pte_swp_uffd_wp_any(pte)) {
+	} else if (pte_swp_uffd_wp_any(hugetlb_ptep_get(hpte))) {
 		flags |= PM_UFFD_WP;
 	}
 
@@ -1869,17 +1870,19 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 #ifdef CONFIG_HUGETLB_PAGE
-static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
-		unsigned long addr, unsigned long end, struct mm_walk *walk)
+static int gather_hugetlb_stats(struct hugetlb_pte *hpte, unsigned long addr,
+		unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = hugetlb_ptep_get(hpte);
 	struct numa_maps *md;
 	struct page *page;
 
-	if (!pte_present(huge_pte))
+	if (!hugetlb_pte_present_leaf(hpte))
 		return 0;
 
 	page = pte_page(huge_pte);
+	if (page != compound_head(page))
+		return 0;
 
 	md = walk->private;
 	gather_stats(page, md, pte_dirty(huge_pte), 1);
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index ac7b38ad5903..0d21e25df37f 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -3,6 +3,7 @@
 #define _LINUX_PAGEWALK_H
 
 #include <linux/mm.h>
+#include <linux/hugetlb.h>
 
 struct mm_walk;
 
@@ -47,7 +48,7 @@ struct mm_walk_ops {
 			 unsigned long next, struct mm_walk *walk);
 	int (*pte_hole)(unsigned long addr, unsigned long next,
 			int depth, struct mm_walk *walk);
-	int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
+	int (*hugetlb_entry)(struct hugetlb_pte *hpte,
 			     unsigned long addr, unsigned long next,
 			     struct mm_walk *walk);
 	int (*test_walk)(unsigned long addr, unsigned long next,
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 59e1653799f8..ce50b937dcf2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -324,14 +324,15 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_hugetlb_mkold(struct hugetlb_pte *hpte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
 	pte_t entry = huge_ptep_get(pte);
 	struct page *page = pte_page(entry);
+	struct page *hpage = compound_head(page);
 
-	get_page(page);
+	get_page(hpage);
 
 	if (pte_young(entry)) {
 		referenced = true;
@@ -342,18 +343,18 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 
 #ifdef CONFIG_MMU_NOTIFIER
 	if (mmu_notifier_clear_young(mm, addr,
-				     addr + huge_page_size(hstate_vma(vma))))
+				     addr + hugetlb_pte_size(hpte));
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
-		set_page_young(page);
+		set_page_young(hpage);
 
-	set_page_idle(page);
-	put_page(page);
+	set_page_idle(hpage);
+	put_page(hpage);
 }
 
-static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int damon_mkold_hugetlb_entry(struct hugetlb_pte *hpte,
 				     unsigned long addr, unsigned long end,
 				     struct mm_walk *walk)
 {
@@ -361,12 +362,12 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	ptl = huge_pte_lock_shift(hpte->shift, walk->mm, hpte->ptep);
+	entry = huge_ptep_get(hpte->ptep);
 	if (!pte_present(entry))
 		goto out;
 
-	damon_hugetlb_mkold(pte, walk->mm, walk->vma, addr);
+	damon_hugetlb_mkold(hpte, walk->mm, walk->vma, addr);
 
 out:
 	spin_unlock(ptl);
@@ -474,31 +475,32 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int damon_young_hugetlb_entry(struct hugetlb_pte *hpte,
 				     unsigned long addr, unsigned long end,
 				     struct mm_walk *walk)
 {
 	struct damon_young_walk_private *priv = walk->private;
 	struct hstate *h = hstate_vma(walk->vma);
-	struct page *page;
+	struct page *page, *hpage;
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(h, walk->mm, pte);
+	ptl = huge_pte_lock_shift(hpte->shift, walk->mm, hpte->ptep);
 	entry = huge_ptep_get(pte);
 	if (!pte_present(entry))
 		goto out;
 
 	page = pte_page(entry);
-	get_page(page);
+	hpage = compound_head(page);
+	get_page(hpage);
 
-	if (pte_young(entry) || !page_is_idle(page) ||
+	if (pte_young(entry) || !page_is_idle(hpage) ||
 	    mmu_notifier_test_young(walk->mm, addr)) {
 		*priv->page_sz = huge_page_size(h);
 		priv->young = true;
 	}
 
-	put_page(page);
+	put_page(hpage);
 
 out:
 	spin_unlock(ptl);
diff --git a/mm/hmm.c b/mm/hmm.c
index 3fd3242c5e50..1ad5d76fa8be 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -472,7 +472,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 #endif
 
 #ifdef CONFIG_HUGETLB_PAGE
-static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int hmm_vma_walk_hugetlb_entry(struct hugetlb_pte *hpte,
 				      unsigned long start, unsigned long end,
 				      struct mm_walk *walk)
 {
@@ -483,11 +483,12 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	unsigned int required_fault;
 	unsigned long pfn_req_flags;
 	unsigned long cpu_flags;
+	unsigned long hmask = hugetlb_pte_mask(hpte);
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	ptl = huge_pte_lock_shift(hpte->shift, walk->mm, hpte->ptep);
+	entry = huge_ptep_get(hpte->ptep);
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags = range->hmm_pfns[i];
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..a1d82db7c19f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -559,7 +559,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	return addr != end ? -EIO : 0;
 }
 
-static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
+static int queue_pages_hugetlb(struct hugetlb_pte *hpte,
 			       unsigned long addr, unsigned long end,
 			       struct mm_walk *walk)
 {
@@ -571,8 +571,13 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	spinlock_t *ptl;
 	pte_t entry;
 
-	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	/* We don't migrate high-granularity HugeTLB mappings for now. */
+	if (hugetlb_pte_size(hpte) !=
+			huge_page_size(hstate_vma(walk->vma)))
+		return -EINVAL;
+
+	ptl = hugetlb_pte_lock(walk->mm, hpte);
+	entry = hugetlb_ptep_get(hpte);
 	if (!pte_present(entry))
 		goto unlock;
 	page = pte_page(entry);
diff --git a/mm/mincore.c b/mm/mincore.c
index fa200c14185f..dc1717dc6a2c 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -22,7 +22,7 @@
 #include <linux/uaccess.h>
 #include "swap.h"
 
-static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
+static int mincore_hugetlb(struct hugetlb_pte *hpte, unsigned long addr,
 			unsigned long end, struct mm_walk *walk)
 {
 #ifdef CONFIG_HUGETLB_PAGE
@@ -33,7 +33,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none(huge_ptep_get(pte));
+	present = hpte->ptep && !hugetlb_pte_none(hpte);
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..9c5a35a1c0eb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -476,12 +476,12 @@ static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
 		0 : -EACCES;
 }
 
-static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
+static int prot_none_hugetlb_entry(struct hugetlb_pte *hpte,
 				   unsigned long addr, unsigned long next,
 				   struct mm_walk *walk)
 {
-	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
-		0 : -EACCES;
+	return pfn_modify_allowed(pte_pfn(*hpte->ptep),
+			*(pgprot_t *)(walk->private)) ? 0 : -EACCES;
 }
 
 static int prot_none_test(unsigned long addr, unsigned long next,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..f8e24a0a0179 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/minmax.h>
 
 /*
  * We want to know the real level where a entry is located ignoring any
@@ -301,13 +302,26 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 	pte_t *pte;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
+	struct hugetlb_pte hpte;
 
 	do {
-		next = hugetlb_entry_end(h, addr, end);
 		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
+		if (!pte) {
+			next = hugetlb_entry_end(h, addr, end);
+		} else {
+			hugetlb_pte_populate(&hpte, pte, huge_page_shift(h));
+			if (hugetlb_hgm_enabled(vma)) {
+				err = hugetlb_walk_to(walk->mm, &hpte, addr,
+						      PAGE_SIZE,
+						      /*stop_at_none=*/true);
+				if (err)
+					break;
+			}
+			next = min(addr + hugetlb_pte_size(&hpte), end);
+		}
 
 		if (pte)
-			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
+			err = ops->hugetlb_entry(&hpte, addr, next, walk);
 		else if (ops->pte_hole)
 			err = ops->pte_hole(addr, next, -1, walk);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

