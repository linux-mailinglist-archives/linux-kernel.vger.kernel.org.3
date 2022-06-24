Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E19559FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiFXRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiFXRhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:20 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE4609EF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:19 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id y75-20020a1f7d4e000000b0036cbc90a40dso920385vkc.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C3fH1oRby2iG8QHlX2xdR+iuje/PS4n79lvPkGthMbg=;
        b=ZvJyRZYi5Luh9HoaMNclQG/FEjMLfzSsnyQ/9mxS9ijpI3JJW36iQDpaHsY87LXRBZ
         MYe/3q2xvO35L2IDpu2v2DM/tTOw5jERdNYlWr+w9FKaAmGF7Qw169EIGH/QBP5/M5Hu
         EnvP0MM3PVu+Qq3VOyCfhXtU1PqbPDjXRp9bYa+nmG69Ejf6C4LVUubpOccWnz+8x8al
         Ud1kt4H0mzAyAWMnP0xMUwaKTGQ7OAkmev0EEidQ3pcSQbK/8Wk2CIruV0DC5jWgMmae
         phVsDW4MQ5+a3GUwp4m0a+E3VZr2h8GwiRLlTkbUBbEknSpuJ1gbOzRLqoe5ZpouQ3g/
         4rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C3fH1oRby2iG8QHlX2xdR+iuje/PS4n79lvPkGthMbg=;
        b=7D7bX+24TZPXw73Qtc0q6YuCj28VVvTnI3O02khLVrCmCWJpFHJ/1pKRxHMz+FgAcz
         CkX3LfuhBHLPgmDe/fCmotl44hUt6lKl4sxen6fSq43F4fYuTO1wi+Q3+xaOwcyed+XZ
         fQTrHywfIUhpWgu0LkwYS0pkDQI5Sb/RDrxcc0/CStwoDpov+e+R3coR7PT2WwxDEFD1
         z4/AQhORLAR/Cui6hqeqeE+6n9pZF1uV1GtwDAxBO3PHBlJCTBycdohUVFMGSW+aaAmT
         ePeg88Y+9NayEPddApcD3MOeKdFjX4qbZYCp0uiYPapOMpDJ/cvzp4akBeLG51WNpZLZ
         MN7A==
X-Gm-Message-State: AJIora+mBmtDEiCyiwYYiXK1gLG5OnJMSPThrkWU5LPGjaSkmuzC4/cJ
        GVGPDz4Y7omI32eWZBTlzr8+z5dYyO20TNDO
X-Google-Smtp-Source: AGRyM1sN569V6cAWRy0BJnUUQMejK8sKMmpW5w3o0qztJIemJ7kY/kSH0xH0s1Ckgj1aJGX5wLB5oOn168goMMsQ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6122:506:b0:36c:3d23:38e7 with SMTP
 id x6-20020a056122050600b0036c3d2338e7mr9197vko.26.1656092239059; Fri, 24 Jun
 2022 10:37:19 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:37 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-8-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
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

After high-granularity mapping, page table entries for HugeTLB pages can
be of any size/type. (For example, we can have a 1G page mapped with a
mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
PTE after we have done a page table walk.

Without this, we'd have to pass around the "size" of the PTE everywhere.
We effectively did this before; it could be fetched from the hstate,
which we pass around pretty much everywhere.

This commit includes definitions for some basic helper functions that
are used later. These helper functions wrap existing PTE
inspection/modification functions, where the correct version is picked
depending on if the HugeTLB PTE is actually "huge" or not. (Previously,
all HugeTLB PTEs were "huge").

For example, hugetlb_ptep_get wraps huge_ptep_get and ptep_get, where
ptep_get is used when the HugeTLB PTE is PAGE_SIZE, and huge_ptep_get is
used in all other cases.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 84 +++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            | 57 ++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5fe1db46d8c9..1d4ec9dfdebf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -46,6 +46,68 @@ enum {
 	__NR_USED_SUBPAGE,
 };
 
+struct hugetlb_pte {
+	pte_t *ptep;
+	unsigned int shift;
+};
+
+static inline
+void hugetlb_pte_init(struct hugetlb_pte *hpte)
+{
+	hpte->ptep = NULL;
+}
+
+static inline
+void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
+			  unsigned int shift)
+{
+	BUG_ON(!ptep);
+	hpte->ptep = ptep;
+	hpte->shift = shift;
+}
+
+static inline
+unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
+{
+	BUG_ON(!hpte->ptep);
+	return 1UL << hpte->shift;
+}
+
+static inline
+unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
+{
+	BUG_ON(!hpte->ptep);
+	return ~(hugetlb_pte_size(hpte) - 1);
+}
+
+static inline
+unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
+{
+	BUG_ON(!hpte->ptep);
+	return hpte->shift;
+}
+
+static inline
+bool hugetlb_pte_huge(const struct hugetlb_pte *hpte)
+{
+	return !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING) ||
+		hugetlb_pte_shift(hpte) > PAGE_SHIFT;
+}
+
+static inline
+void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
+{
+	dest->ptep = src->ptep;
+	dest->shift = src->shift;
+}
+
+bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte);
+bool hugetlb_pte_none(const struct hugetlb_pte *hpte);
+bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
+pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
+void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
+		       unsigned long address);
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
@@ -1130,6 +1192,28 @@ static inline spinlock_t *huge_pte_lock_shift(unsigned int shift,
 	return ptl;
 }
 
+static inline
+spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
+{
+
+	BUG_ON(!hpte->ptep);
+	// Only use huge_pte_lockptr if we are at leaf-level. Otherwise use
+	// the regular page table lock.
+	if (hugetlb_pte_none(hpte) || hugetlb_pte_present_leaf(hpte))
+		return huge_pte_lockptr(hugetlb_pte_shift(hpte),
+				mm, hpte->ptep);
+	return &mm->page_table_lock;
+}
+
+static inline
+spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
+{
+	spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
+
+	spin_lock(ptl);
+	return ptl;
+}
+
 #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
 extern void __init hugetlb_cma_reserve(int order);
 extern void __init hugetlb_cma_check(void);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6d0d4c03def..1a1434e29740 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1120,6 +1120,63 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
+{
+	pgd_t pgd;
+	p4d_t p4d;
+	pud_t pud;
+	pmd_t pmd;
+
+	BUG_ON(!hpte->ptep);
+	if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
+		pgd = *(pgd_t *)hpte->ptep;
+		return pgd_present(pgd) && pgd_leaf(pgd);
+	} else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
+		p4d = *(p4d_t *)hpte->ptep;
+		return p4d_present(p4d) && p4d_leaf(p4d);
+	} else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
+		pud = *(pud_t *)hpte->ptep;
+		return pud_present(pud) && pud_leaf(pud);
+	} else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
+		pmd = *(pmd_t *)hpte->ptep;
+		return pmd_present(pmd) && pmd_leaf(pmd);
+	} else if (hugetlb_pte_size(hpte) >= PAGE_SIZE)
+		return pte_present(*hpte->ptep);
+	BUG();
+}
+
+bool hugetlb_pte_none(const struct hugetlb_pte *hpte)
+{
+	if (hugetlb_pte_huge(hpte))
+		return huge_pte_none(huge_ptep_get(hpte->ptep));
+	return pte_none(ptep_get(hpte->ptep));
+}
+
+bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte)
+{
+	if (hugetlb_pte_huge(hpte))
+		return huge_pte_none_mostly(huge_ptep_get(hpte->ptep));
+	return pte_none_mostly(ptep_get(hpte->ptep));
+}
+
+pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte)
+{
+	if (hugetlb_pte_huge(hpte))
+		return huge_ptep_get(hpte->ptep);
+	return ptep_get(hpte->ptep);
+}
+
+void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
+		       unsigned long address)
+{
+	BUG_ON(!hpte->ptep);
+	unsigned long sz = hugetlb_pte_size(hpte);
+
+	if (sz > PAGE_SIZE)
+		return huge_pte_clear(mm, address, hpte->ptep, sz);
+	return pte_clear(mm, address, hpte->ptep);
+}
+
 static void enqueue_huge_page(struct hstate *h, struct page *page)
 {
 	int nid = page_to_nid(page);
-- 
2.37.0.rc0.161.g10f37bed90-goog

