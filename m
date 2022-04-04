Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A94F1043
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377800AbiDDHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357940AbiDDHtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:49:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972863B028
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:47:21 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y10so8198245pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lC2h3Z6cLQPfmZiyooW/1psSSkQBU7SQH9OssEYi9S4=;
        b=iYFAero0C1uGiy/RKm8ALKfdReKFAW/xq6ySV+p/WR9w+sSqKFiDxAMw2n8TW6FqTd
         Q/HncU1Mdyyfvx9jw4Xx0snP3Dfa8JL9v5AJXc9+v0vwdKdZMW9UZox8CDv5iq3Cwiz4
         QzSjZq7Id+HECBjJn8Muq67jep8q1Y+034IbMut0Lwuwrw5oPWCRH8IU9qhiamUgiXxu
         Ymnnrkx4pmVjHPC7DH2Bd9a2V541jSkaX1Vh/H48th0iDq0bDr/gdA7EA29egOKKJQ/N
         2rBdOWhXC00o772NqZSUSO3qLmEBx7HJZlMngmpn+hAXWwmU3sEZ57IWMDnAWh8vUudh
         7Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lC2h3Z6cLQPfmZiyooW/1psSSkQBU7SQH9OssEYi9S4=;
        b=uu096VDVmsu8ykxjZhpBq/hVvFadp+DEtdw9OF5Deu++ILLdVSemg00V/y4588Af1t
         2u3pVemqeZwlINNG5c25IT90tdH7FoQh2tvgaGrMT1X3Vi4s2wKBw3e1RY2wcOCvmFVR
         1IOhm6iLkVbIRTqauJT1HUjoo9OMiuDZ3GggbVvP0yr+3FhKh4sJeRTRbllUgK+Lrp/8
         5OUg1s3KkKb4+MTK3ug2oxD/8dUFqP4f01NonJJQe5rXaM/lH9x9yJ2HBMC0kgYpnQ2J
         dNObIpjDofMsYx4Rgu69rPTvdBJ2ryWpiOzXKaIcBTBDafZ4WO2jfJmzqT/xR/IOxw/A
         8Pxg==
X-Gm-Message-State: AOAM531J6Pqyopm+i1aLMuydHDgRXdLnvFz5hSoG4j+vseVJJEyZTYHh
        +1uUOh7rRtXkhkU8aXuGW16vlg==
X-Google-Smtp-Source: ABdhPJwIKLc+bbXglEKEk8PeuNGWL8h9SDP+7P/jztgJ3cd8Kd5/Bwx/Z/49/hAPtUzYDigduzUgTA==
X-Received: by 2002:a65:5acd:0:b0:399:24bc:bbfd with SMTP id d13-20020a655acd000000b0039924bcbbfdmr3428233pgt.323.1649058441043;
        Mon, 04 Apr 2022 00:47:21 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm9376579pgc.64.2022.04.04.00.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:47:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/3] mm: hugetlb_vmemmap: cleanup hugetlb_vmemmap related functions
Date:   Mon,  4 Apr 2022 15:46:50 +0800
Message-Id: <20220404074652.68024-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220404074652.68024-1-songmuchun@bytedance.com>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word of "free" is not expressive enough to express the feature of optimizing
vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
And some function names are prefixed with "huge_page" instead of "hugetlb", it is
easily to be confused with THP.  In this patch , cheanup related functions to make
code more clear and expressive.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 10 +++++-----
 mm/hugetlb_vmemmap.c    | 42 ++++++++++++++++++++----------------------
 mm/hugetlb_vmemmap.h    | 20 ++++++++++----------
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53c1b6082a4c..c16fbb1228a3 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -618,7 +618,7 @@ struct hstate {
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-	unsigned int nr_free_vmemmap_pages;
+	unsigned int optimize_vmemmap_pages;
 #endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd642cfc538b..1f9fbdddc86b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1540,7 +1540,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	if (alloc_huge_page_vmemmap(h, page)) {
+	if (hugetlb_vmemmap_alloc(h, page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1617,7 +1617,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline void flush_free_hpage_work(struct hstate *h)
 {
-	if (free_vmemmap_pages_per_hpage(h))
+	if (hugetlb_optimize_vmemmap_pages(h))
 		flush_work(&free_hpage_work);
 }
 
@@ -1739,7 +1739,7 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void __prep_new_huge_page(struct hstate *h, struct page *page)
 {
-	free_huge_page_vmemmap(h, page);
+	hugetlb_vmemmap_free(h, page);
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	hugetlb_set_page_subpool(page, NULL);
@@ -2112,7 +2112,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = alloc_huge_page_vmemmap(h, head);
+		rc = hugetlb_vmemmap_alloc(h, head);
 		if (!rc) {
 			/*
 			 * Move PageHWPoison flag from head page to the raw
@@ -3427,7 +3427,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	remove_hugetlb_page_for_demote(h, page, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = alloc_huge_page_vmemmap(h, page);
+	rc = hugetlb_vmemmap_alloc(h, page);
 	if (rc) {
 		/* Allocation of vmemmmap failed, we can not demote page */
 		spin_lock_irq(&hugetlb_lock);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 791626983c2e..91b79b9d9e25 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Free some vmemmap pages of HugeTLB
+ * Optimize vmemmap pages associated with HugeTLB
  *
  * Copyright (c) 2020, Bytedance. All rights reserved.
  *
@@ -192,7 +192,7 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
 			hugetlb_free_vmemmap_enabled_key);
 EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
 
-static int __init early_hugetlb_free_vmemmap_param(char *buf)
+static int __init hugetlb_vmemmap_early_param(char *buf)
 {
 	/* We cannot optimize if a "struct page" crosses page boundaries. */
 	if (!is_power_of_2(sizeof(struct page))) {
@@ -212,29 +212,26 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
 
 	return 0;
 }
-early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
-
-static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
-{
-	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
-}
+early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_early_param);
 
 /*
  * Previously discarded vmemmap pages will be allocated and remapping
  * after this function returns zero.
  */
-int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 {
 	int ret;
 	unsigned long vmemmap_addr = (unsigned long)head;
-	unsigned long vmemmap_end, vmemmap_reuse;
+	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
 
 	if (!HPageVmemmapOptimized(head))
 		return 0;
 
-	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
-	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
-	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
+	vmemmap_pages	= hugetlb_optimize_vmemmap_pages(h);
+	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
+	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
+
 	/*
 	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
 	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
@@ -250,17 +247,18 @@ int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 	return ret;
 }
 
-void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 {
 	unsigned long vmemmap_addr = (unsigned long)head;
-	unsigned long vmemmap_end, vmemmap_reuse;
+	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
 
-	if (!free_vmemmap_pages_per_hpage(h))
+	vmemmap_pages = hugetlb_optimize_vmemmap_pages(h);
+	if (!vmemmap_pages)
 		return;
 
-	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
-	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
-	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
+	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
+	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
+	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_addr, @vmemmap_end)
@@ -297,8 +295,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	 * hugetlbpage.rst for more details.
 	 */
 	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
-		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+		h->optimize_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
 
-	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
-		h->name);
+	pr_info("can optimize %d vmemmap pages for %s\n",
+		h->optimize_vmemmap_pages, h->name);
 }
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..9760537849b5 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Free some vmemmap pages of HugeTLB
+ * Optimize vmemmap pages associated with HugeTLB
  *
  * Copyright (c) 2020, Bytedance. All rights reserved.
  *
@@ -11,25 +11,25 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
-void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_free(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
- * How many vmemmap pages associated with a HugeTLB page that can be freed
- * to the buddy allocator.
+ * How many vmemmap pages associated with a HugeTLB page that can be
+ * optimized and freed to the buddy allocator.
  */
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
 {
-	return h->nr_free_vmemmap_pages;
+	return h->optimize_vmemmap_pages;
 }
 #else
-static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
+static inline int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 {
 	return 0;
 }
 
-static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+static inline void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
 {
 }
 
@@ -37,7 +37,7 @@ static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
 
-static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
 {
 	return 0;
 }
-- 
2.11.0

