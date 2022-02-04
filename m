Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D654AA0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiBDUCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiBDT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:59:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E0C061756
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=22k0IdJjYTE/UU7PUDOmfiOcwA1GEqXd/oV6kr4iAuM=; b=vHKUWCxsQLLGxY9G4MDxHnbCRV
        bmSIjRwSUenh9qeHgCsTOHuHB5FZ5axHQFbXgwcpCWy5OXyLkwwQnyZFE/s2ngIlASrGHdcMXjdD+
        EmSGj75CzSs84Cuo/SwD0B/+x6bDX2ueMCgVQ8OpzsJXW8GdixZvnwPrTaCxD6Qf8Raak81VN7uV8
        2b3ByWjP2VIKydzoQAGNYbTK4CHSP5yyrox9s8reqrdy7Nqo3B1/tFjMFTZj102W5kKU0EfTAXuSq
        5dmQ9pK3bQENzwk/YmoNdBmaGVYRaCQmhWpL9PIh8pHYys2EsDumoQ36iEnF8CKsVl9XkNLVQ1zPm
        cANhkASA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG4jX-007Ln9-Ij; Fri, 04 Feb 2022 19:59:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 40/75] mm: Add pvmw_set_page() and pvmw_set_folio()
Date:   Fri,  4 Feb 2022 19:58:17 +0000
Message-Id: <20220204195852.1751729-41-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220204195852.1751729-1-willy@infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting the page directly in struct page_vma_mapped_walk,
use this helper to allow us to transition to a PFN approach in the
next patch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/rmap.h    | 12 ++++++++++++
 kernel/events/uprobes.c |  2 +-
 mm/damon/paddr.c        |  4 ++--
 mm/ksm.c                |  2 +-
 mm/migrate.c            |  2 +-
 mm/page_idle.c          |  2 +-
 mm/rmap.c               | 12 ++++++------
 7 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e704b1a4c06c..e076aca3a203 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -213,6 +213,18 @@ struct page_vma_mapped_walk {
 	unsigned int flags;
 };
 
+static inline void pvmw_set_page(struct page_vma_mapped_walk *pvmw,
+		struct page *page)
+{
+	pvmw->page = page;
+}
+
+static inline void pvmw_set_folio(struct page_vma_mapped_walk *pvmw,
+		struct folio *folio)
+{
+	pvmw->page = &folio->page;
+}
+
 static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 {
 	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..5f74671b0066 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -156,13 +156,13 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
-		.page = compound_head(old_page),
 		.vma = vma,
 		.address = addr,
 	};
 	int err;
 	struct mmu_notifier_range range;
 
+	pvmw_set_page(&pvmw, compound_head(old_page));
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5e8244f65a1a..4e27d64abbb7 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -20,11 +20,11 @@ static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
 		unsigned long addr, void *arg)
 {
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = addr,
 	};
 
+	pvmw_set_page(&pvmw, page);
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte)
@@ -94,11 +94,11 @@ static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
 {
 	struct damon_pa_access_chk_result *result = arg;
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = addr,
 	};
 
+	pvmw_set_page(&pvmw, page);
 	result->accessed = false;
 	result->page_sz = PAGE_SIZE;
 	while (page_vma_mapped_walk(&pvmw)) {
diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d9a0d9..1639160c9e9a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1035,13 +1035,13 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 	};
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
 
+	pvmw_set_page(&pvmw, page);
 	pvmw.address = page_address_in_vma(page, vma);
 	if (pvmw.address == -EFAULT)
 		goto out;
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..07464fd45925 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -177,7 +177,6 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				 unsigned long addr, void *old)
 {
 	struct page_vma_mapped_walk pvmw = {
-		.page = old,
 		.vma = vma,
 		.address = addr,
 		.flags = PVMW_SYNC | PVMW_MIGRATION,
@@ -187,6 +186,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 	swp_entry_t entry;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
+	pvmw_set_page(&pvmw, old);
 	while (page_vma_mapped_walk(&pvmw)) {
 		if (PageKsm(page))
 			new = page;
diff --git a/mm/page_idle.c b/mm/page_idle.c
index edead6a8a5f9..20d35d720872 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -49,12 +49,12 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
 					unsigned long addr, void *arg)
 {
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = addr,
 	};
 	bool referenced = false;
 
+	pvmw_set_page(&pvmw, page);
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
diff --git a/mm/rmap.c b/mm/rmap.c
index a531b64d53fa..fa8478372e94 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -803,12 +803,12 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 {
 	struct page_referenced_arg *pra = arg;
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = address,
 	};
 	int referenced = 0;
 
+	pvmw_set_page(&pvmw, page);
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
@@ -932,7 +932,6 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 			    unsigned long address, void *arg)
 {
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = address,
 		.flags = PVMW_SYNC,
@@ -940,6 +939,7 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	int *cleaned = arg;
 
+	pvmw_set_page(&pvmw, page);
 	/*
 	 * We have to assume the worse case ie pmd for invalidation. Note that
 	 * the page can not be free from this function.
@@ -1423,7 +1423,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = address,
 	};
@@ -1433,6 +1432,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
+	pvmw_set_page(&pvmw, page);
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
@@ -1723,7 +1723,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = address,
 	};
@@ -1733,6 +1732,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 
+	pvmw_set_page(&pvmw, page);
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
@@ -2003,11 +2003,11 @@ static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
 				 unsigned long address, void *unused)
 {
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = address,
 	};
 
+	pvmw_set_page(&pvmw, page);
 	/* An un-locked vma doesn't have any pages to lock, continue the scan */
 	if (!(vma->vm_flags & VM_LOCKED))
 		return true;
@@ -2078,7 +2078,6 @@ static bool page_make_device_exclusive_one(struct page *page,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct page_vma_mapped_walk pvmw = {
-		.page = page,
 		.vma = vma,
 		.address = address,
 	};
@@ -2090,6 +2089,7 @@ static bool page_make_device_exclusive_one(struct page *page,
 	swp_entry_t entry;
 	pte_t swp_pte;
 
+	pvmw_set_page(&pvmw, page);
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0, vma,
 				      vma->vm_mm, address, min(vma->vm_end,
 				      address + page_size(page)), args->owner);
-- 
2.34.1

