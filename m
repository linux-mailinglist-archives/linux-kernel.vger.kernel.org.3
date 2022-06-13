Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E919547FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiFMGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiFMGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:53 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B075BF66
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s135so4707370pgs.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwkuZE56aSA9/tatUtzCc+m4R0MzHGUai/Pf7RD5URU=;
        b=Kjz8rGkl7FUYvNUnypP5Qyyj+Q6Yamk+s0aKQd9kRPShoI7ZOlXd8aKUfnLlq9VRDB
         2IfUB/K+zfaqtPom55HNE6nY/05iePr6inRaRAesiMWdSIoAh1ye3EsBFXLtNMLr2tAR
         Fb/Hsv2nG/b2HGDs6VBfx0c9n0h/U8MnTniUCYUNU8LUi4I+p+AMkK5YytsFI58VYv5t
         1Jl91fMb+LgXqyUBvkiNO2PGH6dWAAXvpAtDzGS8jywgFBpsKNXleUSj+JD4WX5bfVPZ
         rZaLzWXTJfU0O6StEleg8g9iCZOzQsFeWDeSdE23GLC3Ca0j2sx41hCPzX3sfrqha1hw
         zjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwkuZE56aSA9/tatUtzCc+m4R0MzHGUai/Pf7RD5URU=;
        b=ctyKimp5sbyS5M8DQrpqf1bPgVQT3fD8433lrOZTiKhDrrAoPdHLe3TLNN81zndBLs
         oic0fU8CIBIt5KgzZxqusQtGJYHuZOK0+rCQ5rhGrpBU4DgLM5+LEkdYj7nvY0PMuoPF
         gy48J8C7bwVoLqo8l24SUvuwyQ2YVBCoYc+wmlly8wWUbqyZ6TP/Ed4vJHsNKqXP8CAQ
         Iw2vy7h76ZZcUDLuGlbqVcT1OKC9/9XO/7jbu6hqiEQ6U1Vn1cHQZUIecwj5aEG3x0sv
         8wo94Zh6zvZqan/1CwacSdFCRQmNRQbD+NP1WCrwBEjFGr/R/UWg14wXFnXFloLSQ2Xj
         3uTQ==
X-Gm-Message-State: AOAM532UEY+U8+Xldr4Ey38zJ1ci2oE7TwvFc2YuhzcdSxRUzi8AgOiu
        i/l5dMZi/InvG2Q/2mSPvco7dw==
X-Google-Smtp-Source: ABdhPJx2XekdnvADwYsXewHpUnTmAPdpTfW58vn7LUP2xBm6iJ9za0hOyv1YbpUo8oZuj7TQ2LmxOQ==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr58255506pfb.59.1655102150896;
        Sun, 12 Jun 2022 23:35:50 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code readability
Date:   Mon, 13 Jun 2022 14:35:12 +0800
Message-Id: <20220613063512.17540-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220613063512.17540-1-songmuchun@bytedance.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a discussion about the name of hugetlb_vmemmap_alloc/free in
thread [1].  The suggestion suggested by David is rename "alloc/free"
to "optimize/restore" to make functionalities clearer to users,
"optimize" means the function will optimize vmemmap pages, while
"restore" means restoring its vmemmap pages discared before. This
commit does this.

Another discussion is the confusion RESERVE_VMEMMAP_NR isn't used
explicitly for vmemmap_addr but implicitly for vmemmap_end in
hugetlb_vmemmap_alloc/free.  David suggested we can compute what
hugetlb_vmemmap_init() does now at runtime.  We do not need to worry
for the overhead of computing at runtime since the calculation is
simple enough and those functions are not in a hot path.  This commit
has the following improvements:

  1) The function suffixed name ("optimize/restore") is more expressive.
  2) The logic becomes less weird in hugetlb_vmemmap_optmize/restore().
  3) The hugetlb_vmemmap_init() does not need to be exported anymore.
  4) A ->optimize_vmemmap_pages field in struct hstate is killed.
  5) There is only one place where checks is_power_of_2(sizeof(struct
     page)) instead of two places.
  6) Add more comments for hugetlb_vmemmap_optmize/restore().
  7) For external users, hugetlb_optimize_vmemmap_pages() is used for
     detecting if the HugeTLB's vmemmap pages is optimizable originally.
     In this commit, it is killed and we introduce a new helper
     hugetlb_vmemmap_optimizable() to replace it.  The name is more
     expressive.

Link: https://lore.kernel.org/all/20220404074652.68024-2-songmuchun@bytedance.com/ [1]
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |   7 +--
 mm/hugetlb.c            |  11 ++--
 mm/hugetlb_vmemmap.c    | 154 +++++++++++++++++++++++-------------------------
 mm/hugetlb_vmemmap.h    |  39 +++++++-----
 4 files changed, 105 insertions(+), 106 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 642a39016f9a..0b475faf9bf4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -640,9 +640,6 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	unsigned int optimize_vmemmap_pages;
-#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[8];
@@ -718,7 +715,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return hstate_file(vma->vm_file);
 }
 
-static inline unsigned long huge_page_size(struct hstate *h)
+static inline unsigned long huge_page_size(const struct hstate *h)
 {
 	return (unsigned long)PAGE_SIZE << h->order;
 }
@@ -747,7 +744,7 @@ static inline bool hstate_is_gigantic(struct hstate *h)
 	return huge_page_order(h) >= MAX_ORDER;
 }
 
-static inline unsigned int pages_per_huge_page(struct hstate *h)
+static inline unsigned int pages_per_huge_page(const struct hstate *h)
 {
 	return 1 << h->order;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 259b9c41892f..26a5af7f0065 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1541,7 +1541,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	if (hugetlb_vmemmap_alloc(h, page)) {
+	if (hugetlb_vmemmap_restore(h, page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1627,7 +1627,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline void flush_free_hpage_work(struct hstate *h)
 {
-	if (hugetlb_optimize_vmemmap_pages(h))
+	if (hugetlb_vmemmap_optimizable(h))
 		flush_work(&free_hpage_work);
 }
 
@@ -1749,7 +1749,7 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void __prep_new_huge_page(struct hstate *h, struct page *page)
 {
-	hugetlb_vmemmap_free(h, page);
+	hugetlb_vmemmap_optimize(h, page);
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	hugetlb_set_page_subpool(page, NULL);
@@ -2122,7 +2122,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = hugetlb_vmemmap_alloc(h, head);
+		rc = hugetlb_vmemmap_restore(h, head);
 		if (!rc) {
 			/*
 			 * Move PageHWPoison flag from head page to the raw
@@ -3434,7 +3434,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	remove_hugetlb_page_for_demote(h, page, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_alloc(h, page);
+	rc = hugetlb_vmemmap_restore(h, page);
 	if (rc) {
 		/* Allocation of vmemmmap failed, we can not demote page */
 		spin_lock_irq(&hugetlb_lock);
@@ -4124,7 +4124,6 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
-	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9808d32cdb9e..595b0cee3109 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -35,16 +35,6 @@ struct vmemmap_remap_walk {
 	struct list_head	*vmemmap_pages;
 };
 
-/*
- * There are a lot of struct page structures associated with each HugeTLB page.
- * For tail pages, the value of compound_head is the same. So we can reuse first
- * page of head page structures. We map the virtual addresses of all the pages
- * of tail page structures to the head page struct, and then free these page
- * frames. Therefore, we need to reserve one pages as vmemmap areas.
- */
-#define RESERVE_VMEMMAP_NR		1U
-#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
-
 static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 {
 	pmd_t __pmd;
@@ -418,32 +408,38 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/*
- * Previously discarded vmemmap pages will be allocated and remapping
- * after this function returns zero.
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *			     hugetlb_vmemmap_optimize()) vmemmap pages which
+ *			     will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
  */
-int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 {
 	int ret;
-	unsigned long vmemmap_addr = (unsigned long)head;
-	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
+	unsigned long vmemmap_start = (unsigned long)head;
+	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_size;
 
 	if (!HPageVmemmapOptimized(head))
 		return 0;
 
-	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
-	vmemmap_pages	= hugetlb_optimize_vmemmap_pages(h);
-	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
-	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
+	vmemmap_size	= hugetlb_vmemmap_size(h);
+	vmemmap_end	= vmemmap_start + vmemmap_size;
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= RESERVE_VMEMMAP_SIZE;
 
 	/*
-	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
+	 * The pages which the vmemmap virtual address range [@vmemmap_start,
 	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
 	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse,
 				  GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
@@ -453,84 +449,62 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 	return ret;
 }
 
-static unsigned int optimizable_vmemmap_pages(struct hstate *h,
-					      struct page *head)
+/* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
+static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
 	unsigned long pfn = page_to_pfn(head);
 	unsigned long end = pfn + pages_per_huge_page(h);
 
 	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return 0;
+		return false;
+
+	if (!hugetlb_vmemmap_optimizable(h))
+		return false;
 
 	for (; pfn < end; pfn += PAGES_PER_SECTION) {
 		if (section_cannot_optimize_vmemmap(__pfn_to_section(pfn)))
-			return 0;
+			return false;
 	}
 
-	return hugetlb_optimize_vmemmap_pages(h);
+	return true;
 }
 
-void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
+/**
+ * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be optimized.
+ *
+ * This function only tries to optimize @head's vmemmap pages and does not
+ * guarantee that the optimization will succeed after it returns. The caller
+ * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
+ * have been optimized.
+ */
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
-	unsigned long vmemmap_addr = (unsigned long)head;
-	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
+	unsigned long vmemmap_start = (unsigned long)head;
+	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_size;
 
-	vmemmap_pages = optimizable_vmemmap_pages(h, head);
-	if (!vmemmap_pages)
+	if (!vmemmap_should_optimize(h, head))
 		return;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
-	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
-	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
-	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
+	vmemmap_size	= hugetlb_vmemmap_size(h);
+	vmemmap_end	= vmemmap_start + vmemmap_size;
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= RESERVE_VMEMMAP_SIZE;
 
 	/*
-	 * Remap the vmemmap virtual address range [@vmemmap_addr, @vmemmap_end)
+	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
-	 * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
+	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
 	 */
-	if (vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
+	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
 }
 
-void __init hugetlb_vmemmap_init(struct hstate *h)
-{
-	unsigned int nr_pages = pages_per_huge_page(h);
-	unsigned int vmemmap_pages;
-
-	/*
-	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
-	 * page structs that can be used when HVO is enabled, add a BUILD_BUG_ON
-	 * to catch invalid usage of the tail page structs.
-	 */
-	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
-		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
-
-	if (!is_power_of_2(sizeof(struct page))) {
-		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
-		return;
-	}
-
-	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
-	/*
-	 * The head page is not to be freed to buddy allocator, the other tail
-	 * pages will map to the head page, so they can be freed.
-	 *
-	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
-	 * on some architectures (e.g. aarch64). See Documentation/arm64/
-	 * hugetlbpage.rst for more details.
-	 */
-	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
-		h->optimize_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
-
-	pr_info("can optimize %d vmemmap pages for %s\n",
-		h->optimize_vmemmap_pages, h->name);
-}
-
-#ifdef CONFIG_PROC_SYSCTL
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
@@ -542,16 +516,36 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{ }
 };
 
-static __init int hugetlb_vmemmap_sysctls_init(void)
+static int __init hugetlb_vmemmap_init(void)
 {
+	const struct hstate *h;
+	bool optimizable = false;
+
 	/*
-	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
-	 * be optimized.
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when HVO is enabled.
 	 */
-	if (is_power_of_2(sizeof(struct page)))
-		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+	BUILD_BUG_ON(__NR_USED_SUBPAGE >= RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
+	for_each_hstate(h) {
+		char buf[16];
+		unsigned int size = 0;
+
+		if (hugetlb_vmemmap_optimizable(h))
+			size = hugetlb_vmemmap_size(h) - RESERVE_VMEMMAP_SIZE;
+		optimizable = size ? true : optimizable;
+		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf,
+				sizeof(buf));
+		pr_info("%d KiB vmemmap can be optimized for a %s page\n",
+			size / SZ_1K, buf);
+	}
 
+	if (optimizable) {
+		if (IS_ENABLED(CONFIG_PROC_SYSCTL))
+			register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+		pr_info("%d huge pages whose vmemmap are optimized at boot\n",
+			static_key_count(&hugetlb_optimize_vmemmap_key.key));
+	}
 	return 0;
 }
-late_initcall(hugetlb_vmemmap_sysctls_init);
-#endif /* CONFIG_PROC_SYSCTL */
+late_initcall(hugetlb_vmemmap_init);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index ba66fadad9fc..0af3f08cf63c 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,35 +11,44 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head);
-void hugetlb_vmemmap_free(struct hstate *h, struct page *head);
-void hugetlb_vmemmap_init(struct hstate *h);
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 
 /*
- * How many vmemmap pages associated with a HugeTLB page that can be
- * optimized and freed to the buddy allocator.
+ * There are a lot of struct page structures associated with each HugeTLB page.
+ * The only 'useful' information in the tail page structs is the compound_head
+ * field which is the same for all tail page structs. So we can reuse the first
+ * page frame of page structs. The virtual addresses of all the remaining pages
+ * of tail page structs will be mapped to the head page frame, and then these
+ * tail page frames are freed. Therefore, we need to reserve one page as
+ * vmemmap. See Documentation/vm/vmemmap_dedup.rst.
  */
-static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
+#define RESERVE_VMEMMAP_SIZE		PAGE_SIZE
+
+static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
-	return h->optimize_vmemmap_pages;
+	return pages_per_huge_page(h) * sizeof(struct page);
 }
-#else
-static inline int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
+
+static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
-	return 0;
+	if (!is_power_of_2(sizeof(struct page)))
+		return false;
+	return hugetlb_vmemmap_size(h) > RESERVE_VMEMMAP_SIZE;
 }
-
-static inline void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
+#else
+static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 {
+	return 0;
 }
 
-static inline void hugetlb_vmemmap_init(struct hstate *h)
+static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
 
-static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
+static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
-	return 0;
+	return false;
 }
 #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

