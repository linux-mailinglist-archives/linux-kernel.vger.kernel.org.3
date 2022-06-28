Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD555C33A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbiF1JZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344247AbiF1JYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740BBC97
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 23so11622730pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ev5x51IaUxcPyHkCSZ2L4XnT+k/5ncETxxmqnTjq8Q=;
        b=YxppcmGzi/NWs7RPlScthtEyAuya93w3YyGwHW9UbPAwrxyAwYAYeHoWmCH7o8ul4I
         bEUNyw3In5gDSm3r5Bshs4Uz9CKZrdq72sH2Swjp26CizWC08PqoQbxDvoszGXBCOZLC
         qGPZvMtsjKZ83S5Fnw0eThTofg7lXyHxnNga1udwdF6GwAY9PmaX1vACYPQQUQwZXRqW
         pe0e3foiZjS2JY7N8xxr8QX/WidLJq4RpgLYmXQOxDedT0rEUF3zcgmzCRm9MC7HjNeg
         wSB0xqYnBSvxZiDsBdkeATEVb9odD1wyvOLg7S6N1JRvEUpB5++IRTvdNSQrrG8NhIDj
         mDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ev5x51IaUxcPyHkCSZ2L4XnT+k/5ncETxxmqnTjq8Q=;
        b=HEzdoBNhVGpx0M/nCGVA4EJhlGnTZXbjfV8WAyxz2OCjP30SuLfC/dxX4fIbb9oOXf
         t1NoCpEOY8chDIym46CuxdAUrEO6IxvCLDYEvCVndmJjvBqXubPiKKBgmEWHwxzbwvto
         7NXZmOf+4vozGhDn+SojvumwYbUGt5kE64S8BeKq0B772uBj3uooVUcPQepjywJmMeWS
         XN+w/BqKKFL2QNSfLCrj6DFP8S/yE5y3CIPOHpx0g8pZZ54yhvTTQd5EQN1RhlbqXlTW
         tdCD3RUW4Z1R6r+pvyu1ndb/qzdvVId9OKDiqfL64i2dZ3LkZ0Lg3Vu/vylPE2um6gvo
         +Exg==
X-Gm-Message-State: AJIora8iJ4RgeuthPvu5lH8Ct0jLQf2S5FAydXZs7a/bKyTCn+bNWIMm
        lM9LE1Dc222p3garMB4NAyM08Q==
X-Google-Smtp-Source: AGRyM1vmH8vT2MBBhRYAggEjycBPEgjMZT4FkFBztcfwWg1liC/UWrLB2ZjswPFO5nhXoprZMbvq4Q==
X-Received: by 2002:a63:3409:0:b0:40c:9736:287 with SMTP id b9-20020a633409000000b0040c97360287mr16900834pga.14.1656408254792;
        Tue, 28 Jun 2022 02:24:14 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:24:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 6/8] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code readability
Date:   Tue, 28 Jun 2022 17:22:33 +0800
Message-Id: <20220628092235.91270-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220628092235.91270-1-songmuchun@bytedance.com>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
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
  2) The logic becomes less weird in hugetlb_vmemmap_optimize/restore().
  3) The hugetlb_vmemmap_init() does not need to be exported anymore.
  4) A ->optimize_vmemmap_pages field in struct hstate is killed.
  5) There is only one place where checks is_power_of_2(sizeof(struct
     page)) instead of two places.
  6) Add more comments for hugetlb_vmemmap_optimize/restore().
  7) For external users, hugetlb_optimize_vmemmap_pages() is used for
     detecting if the HugeTLB's vmemmap pages is optimizable originally.
     In this commit, it is killed and we introduce a new helper
     hugetlb_vmemmap_optimizable() to replace it.  The name is more
     expressive.

Link: https://lore.kernel.org/all/20220404074652.68024-2-songmuchun@bytedance.com/ [1]
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |   7 +--
 include/linux/sysctl.h  |   4 ++
 mm/hugetlb.c            |  15 ++---
 mm/hugetlb_vmemmap.c    | 143 ++++++++++++++++++++----------------------------
 mm/hugetlb_vmemmap.h    |  41 +++++++++-----
 5 files changed, 102 insertions(+), 108 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3bb98434550a..0d790fa3f297 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -641,9 +641,6 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
-#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	unsigned int optimize_vmemmap_pages;
-#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[8];
@@ -719,7 +716,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return hstate_file(vma->vm_file);
 }
 
-static inline unsigned long huge_page_size(struct hstate *h)
+static inline unsigned long huge_page_size(const struct hstate *h)
 {
 	return (unsigned long)PAGE_SIZE << h->order;
 }
@@ -748,7 +745,7 @@ static inline bool hstate_is_gigantic(struct hstate *h)
 	return huge_page_order(h) >= MAX_ORDER;
 }
 
-static inline unsigned int pages_per_huge_page(struct hstate *h)
+static inline unsigned int pages_per_huge_page(const struct hstate *h)
 {
 	return 1 << h->order;
 }
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 80263f7cdb77..5a227b9e3ad5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -266,6 +266,10 @@ static inline struct ctl_table_header *register_sysctl_table(struct ctl_table *
 	return NULL;
 }
 
+static inline void register_sysctl_init(const char *path, struct ctl_table *table)
+{
+}
+
 static inline struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 559084d96082..bd413466682b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1535,7 +1535,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
 
-	if (hugetlb_vmemmap_alloc(h, page)) {
+	if (hugetlb_vmemmap_restore(h, page)) {
 		spin_lock_irq(&hugetlb_lock);
 		/*
 		 * If we cannot allocate vmemmap pages, just refuse to free the
@@ -1621,7 +1621,7 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
 
 static inline void flush_free_hpage_work(struct hstate *h)
 {
-	if (hugetlb_optimize_vmemmap_pages(h))
+	if (hugetlb_vmemmap_optimizable(h))
 		flush_work(&free_hpage_work);
 }
 
@@ -1743,7 +1743,7 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void __prep_new_huge_page(struct hstate *h, struct page *page)
 {
-	hugetlb_vmemmap_free(h, page);
+	hugetlb_vmemmap_optimize(h, page);
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	hugetlb_set_page_subpool(page, NULL);
@@ -2116,7 +2116,7 @@ int dissolve_free_huge_page(struct page *page)
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
 		 */
-		rc = hugetlb_vmemmap_alloc(h, head);
+		rc = hugetlb_vmemmap_restore(h, head);
 		if (!rc) {
 			/*
 			 * Move PageHWPoison flag from head page to the raw
@@ -3191,8 +3191,10 @@ static void __init report_hugepages(void)
 		char buf[32];
 
 		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
-		pr_info("HugeTLB registered %s page size, pre-allocated %ld pages\n",
+		pr_info("HugeTLB: registered %s page size, pre-allocated %ld pages\n",
 			buf, h->free_huge_pages);
+		pr_info("HugeTLB: %d KiB vmemmap can be freed for a %s page\n",
+			hugetlb_vmemmap_optimizable_size(h) / SZ_1K, buf);
 	}
 }
 
@@ -3430,7 +3432,7 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
 	remove_hugetlb_page_for_demote(h, page, false);
 	spin_unlock_irq(&hugetlb_lock);
 
-	rc = hugetlb_vmemmap_alloc(h, page);
+	rc = hugetlb_vmemmap_restore(h, page);
 	if (rc) {
 		/* Allocation of vmemmmap failed, we can not demote page */
 		spin_lock_irq(&hugetlb_lock);
@@ -4120,7 +4122,6 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
-	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b55be6d93f92..6bbc445b1a66 100644
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
@@ -426,32 +416,37 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
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
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
 
 	if (!HPageVmemmapOptimized(head))
 		return 0;
 
-	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
-	vmemmap_pages	= hugetlb_optimize_vmemmap_pages(h);
-	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
-	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
 
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
@@ -461,11 +456,14 @@ int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
 	return ret;
 }
 
-static unsigned int vmemmap_optimizable_pages(struct hstate *h,
-					      struct page *head)
+/* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
+static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
 	if (!READ_ONCE(vmemmap_optimize_enabled))
-		return 0;
+		return false;
+
+	if (!hugetlb_vmemmap_optimizable(h))
+		return false;
 
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
 		pmd_t *pmdp, pmd;
@@ -508,73 +506,47 @@ static unsigned int vmemmap_optimizable_pages(struct hstate *h,
 		 *          +-------------------------------------------+
 		 */
 		if (PageVmemmapSelfHosted(vmemmap_page))
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
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
 
-	vmemmap_pages = vmemmap_optimizable_pages(h, head);
-	if (!vmemmap_pages)
+	if (!vmemmap_should_optimize(h, head))
 		return;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
-	vmemmap_addr	+= RESERVE_VMEMMAP_SIZE;
-	vmemmap_end	= vmemmap_addr + (vmemmap_pages << PAGE_SHIFT);
-	vmemmap_reuse	= vmemmap_addr - PAGE_SIZE;
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
 
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
@@ -586,16 +558,21 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{ }
 };
 
-static __init int hugetlb_vmemmap_sysctls_init(void)
+static int __init hugetlb_vmemmap_init(void)
 {
-	/*
-	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
-	 * be optimized.
-	 */
-	if (is_power_of_2(sizeof(struct page)))
-		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
-
+	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
+	BUILD_BUG_ON(__NR_USED_SUBPAGE * sizeof(struct page) > HUGETLB_VMEMMAP_RESERVE_SIZE);
+
+	if (IS_ENABLED(CONFIG_PROC_SYSCTL)) {
+		const struct hstate *h;
+
+		for_each_hstate(h) {
+			if (hugetlb_vmemmap_optimizable(h)) {
+				register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
+				break;
+			}
+		}
+	}
 	return 0;
 }
-late_initcall(hugetlb_vmemmap_sysctls_init);
-#endif /* CONFIG_PROC_SYSCTL */
+late_initcall(hugetlb_vmemmap_init);
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index ba66fadad9fc..25bd0e002431 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,35 +11,50 @@
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
+ * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
+ * Documentation/vm/vmemmap_dedup.rst.
  */
-static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
+#define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
+
+static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
-	return h->optimize_vmemmap_pages;
+	return pages_per_huge_page(h) * sizeof(struct page);
+}
+
+/*
+ * Return how many vmemmap size associated with a HugeTLB page that can be
+ * optimized and can be freed to the buddy allocator.
+ */
+static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
+{
+	int size = hugetlb_vmemmap_size(h) - HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	if (!is_power_of_2(sizeof(struct page)))
+		return 0;
+	return size > 0 ? size : 0;
 }
 #else
-static inline int hugetlb_vmemmap_alloc(struct hstate *h, struct page *head)
+static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 {
 	return 0;
 }
 
-static inline void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
+static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
 
-static inline void hugetlb_vmemmap_init(struct hstate *h)
+static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
+	return 0;
 }
+#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 
-static inline unsigned int hugetlb_optimize_vmemmap_pages(struct hstate *h)
+static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
 {
-	return 0;
+	return hugetlb_vmemmap_optimizable_size(h) != 0;
 }
-#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

