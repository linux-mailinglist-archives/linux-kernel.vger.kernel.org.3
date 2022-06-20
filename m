Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FD8552187
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiFTPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiFTPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:49:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE031BEA3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j21so4812803lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uaCvxlWu7Mr7Lgwgym0opWD7n4MJzmZlV9ZV/7GQCmI=;
        b=KyTptLRvwAoJbveW/XylhauTOn/SLl30O/1KlcewfX0kqwQ81awXSdlGZEeRg2sRr8
         s2Em8EmWKPDJEMIBFjYTQlSweVqYitBd0lvuL/TFsRwzgGRXccVLgFV4gFjVO6LXwLMB
         sOfbyJ/hqQHfxfSUqTgGGraS1/3g21Ph0vx5qN33b19XIAN379ls2kz10/8cL498Qms5
         eUMwNqJfW9rpjl98XD00590Ii9aH+aMOV95DYqfFd0m2prePquvciW9Ttq32cQaUEqVx
         EScyO0IjgopxHBvszRG8BNPJlc5VrXrlJxRMPWNQf09ARrmkzp/qG9DokvWZVN/IeRci
         n1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uaCvxlWu7Mr7Lgwgym0opWD7n4MJzmZlV9ZV/7GQCmI=;
        b=SUwUaYN8xA74QAuejdhaLElqgAMhJnULzIMU4DLiicSIHUGqoWf1Q9MmMEdOezZMr+
         KMIPJfMZN3FWHIC7BLeGWYQGElEaRaXPYMVvg0zNDIdhcODTsVVUV3Lb0H+v68T+f3eN
         jvWVZAdq8t89ByPtY8BIItd18gtxBP8QgFs67U14kAqin1y9q5dj4bzMmdojikTap4Wg
         KAkOAmwCZk6RU5UhVK5rOdp7jf0OYYgpsoSwFjiDCl5S1rW0H3JvQSsefeutUd8/qfs3
         DGnUQQhTvNc98022FqUWy2cpyDBy5e+Yd+6ISU1gtt+guFxmNXO8JHw/cDoNIXY5Lcvt
         tgGw==
X-Gm-Message-State: AJIora80xZg7NBJDdj9psYJpMOdg53siTKqZ2iaDWp1njHhy09KmT9tM
        Gv/xf32TCQrkPbQbzRuFpTM=
X-Google-Smtp-Source: AGRyM1vlQXq99U+Nc6bBbpfMbNrm9kXtQw6Mp+ShvMUrY/uyqLzTHnA+d0hntvWHmaMy2ocBQR1jpw==
X-Received: by 2002:a19:f813:0:b0:479:3fd7:ce43 with SMTP id a19-20020a19f813000000b004793fd7ce43mr13897324lff.375.1655740142091;
        Mon, 20 Jun 2022 08:49:02 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id m9-20020a2e9349000000b0024f3d1dae94sm1690149ljh.28.2022.06.20.08.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 08:49:01 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>
Subject: [PATCH V1 1/2] xen/unpopulated-alloc: Introduce helpers for contiguous allocations
Date:   Mon, 20 Jun 2022 18:48:55 +0300
Message-Id: <1655740136-3974-2-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655740136-3974-1-git-send-email-olekstysh@gmail.com>
References: <1655740136-3974-1-git-send-email-olekstysh@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Add ability to allocate unpopulated contiguous pages suitable for
grant mapping into. This is going to be used by userspace PV backends
for grant mappings in gnttab code (see gnttab_dma_alloc_pages()).

Patch also changes the allocation mechanism for unpopulated pages.
Instead of using page_list and page->zone_device_data to manage
hot-plugged in fill_pool() (former fill_list()) pages, reuse genpool
subsystem to do the job for us.

Please note that even for non-contiguous allocations we always try
to allocate single contiguous chunk in alloc_unpopulated_pages()
instead of allocating memory page-by-page. Although it leads to less
efficient resource utilization, it is faster. Taking into the account
that on both x86 and Arm the unpopulated memory resource is arbitrarily
large (it is not backed by real memory) this is not going to be a problem.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
I am still thinking how we can optimize free_unpopulated_pages()
to avoid freeing memory page-by-page for non-contiguous allocations:
1. We could update users to allocate/free contiguous pages even when
   continuity is not strictly required. But besides a need to alter
   a few places, this also requires having a valid struct device
   pointer in hand (maybe instead of passing *dev we could pass
   max_addr? With that we could drop DMA_BIT_MASK).
2. Almost all users of unpopulated pages (except gnttab_page_cache_shrink()
   in grant-table.c) retain initially allocated pages[i] array, so it
   passed in free_unpopulated_pages() absolutely unmodified since
   being allocated.
   We could update free_unpopulated_pages() to always try to free memory
   by a single chuck (previously make sure that chunk is in a pool using
   gen_pool_has_addr()) and update gnttab_page_cache_shrink() to not pass
   pages[i] array with mixed pages in it when dealing with unpopulated
   pages. This doesn't require altering a few places.

Any thoughts?

Changes RFC -> V1:
   - update commit subject/description
   - rework to avoid code duplication (resolve initial TODO)
   - rename API according to new naming scheme (s/dma/contiguous),
     also rename some local stuff
   - drop the page_list & friends entirely and use unpopulated_pool for all
     (contiguous and non-contiguous) allocations
   - fix build on x86 by inclusion of <linux/dma-mapping.h>
   - introduce is_xen_unpopulated_page()
   - share the implementation for xen_alloc_unpopulated_contiguous_pages()
     and xen_alloc_unpopulated_pages()
---
 drivers/xen/unpopulated-alloc.c | 188 +++++++++++++++++++++++++++++-----------
 include/xen/xen.h               |  20 +++++
 2 files changed, 158 insertions(+), 50 deletions(-)

diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
index a39f2d3..3988480d 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
+#include <linux/genalloc.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
@@ -12,9 +14,8 @@
 #include <xen/page.h>
 #include <xen/xen.h>
 
-static DEFINE_MUTEX(list_lock);
-static struct page *page_list;
-static unsigned int list_count;
+static DEFINE_MUTEX(pool_lock);
+static struct gen_pool *unpopulated_pool;
 
 static struct resource *target_resource;
 
@@ -31,12 +32,12 @@ int __weak __init arch_xen_unpopulated_init(struct resource **res)
 	return 0;
 }
 
-static int fill_list(unsigned int nr_pages)
+static int fill_pool(unsigned int nr_pages)
 {
 	struct dev_pagemap *pgmap;
 	struct resource *res, *tmp_res = NULL;
 	void *vaddr;
-	unsigned int i, alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
+	unsigned int alloc_pages = round_up(nr_pages, PAGES_PER_SECTION);
 	struct range mhp_range;
 	int ret;
 
@@ -106,6 +107,7 @@ static int fill_list(unsigned int nr_pages)
          * conflict with any devices.
          */
 	if (!xen_feature(XENFEAT_auto_translated_physmap)) {
+		unsigned int i;
 		xen_pfn_t pfn = PFN_DOWN(res->start);
 
 		for (i = 0; i < alloc_pages; i++) {
@@ -125,16 +127,17 @@ static int fill_list(unsigned int nr_pages)
 		goto err_memremap;
 	}
 
-	for (i = 0; i < alloc_pages; i++) {
-		struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
-
-		pg->zone_device_data = page_list;
-		page_list = pg;
-		list_count++;
+	ret = gen_pool_add_virt(unpopulated_pool, (unsigned long)vaddr, res->start,
+			alloc_pages * PAGE_SIZE, NUMA_NO_NODE);
+	if (ret) {
+		pr_err("Cannot add memory range to the unpopulated pool\n");
+		goto err_pool;
 	}
 
 	return 0;
 
+err_pool:
+	memunmap_pages(pgmap);
 err_memremap:
 	kfree(pgmap);
 err_pgmap:
@@ -149,51 +152,49 @@ static int fill_list(unsigned int nr_pages)
 	return ret;
 }
 
-/**
- * xen_alloc_unpopulated_pages - alloc unpopulated pages
- * @nr_pages: Number of pages
- * @pages: pages returned
- * @return 0 on success, error otherwise
- */
-int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+static int alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages,
+		bool contiguous)
 {
 	unsigned int i;
 	int ret = 0;
+	void *vaddr;
+	bool filled = false;
 
 	/*
 	 * Fallback to default behavior if we do not have any suitable resource
 	 * to allocate required region from and as the result we won't be able to
 	 * construct pages.
 	 */
-	if (!target_resource)
+	if (!target_resource) {
+		if (contiguous && nr_pages > 1)
+			return -ENODEV;
+
 		return xen_alloc_ballooned_pages(nr_pages, pages);
+	}
+
+	mutex_lock(&pool_lock);
 
-	mutex_lock(&list_lock);
-	if (list_count < nr_pages) {
-		ret = fill_list(nr_pages - list_count);
+	while (!(vaddr = (void *)gen_pool_alloc(unpopulated_pool,
+			nr_pages * PAGE_SIZE))) {
+		if (filled)
+			ret = -ENOMEM;
+		else {
+			ret = fill_pool(nr_pages);
+			filled = true;
+		}
 		if (ret)
 			goto out;
 	}
 
 	for (i = 0; i < nr_pages; i++) {
-		struct page *pg = page_list;
-
-		BUG_ON(!pg);
-		page_list = pg->zone_device_data;
-		list_count--;
-		pages[i] = pg;
+		pages[i] = virt_to_page(vaddr + PAGE_SIZE * i);
 
 #ifdef CONFIG_XEN_HAVE_PVMMU
 		if (!xen_feature(XENFEAT_auto_translated_physmap)) {
-			ret = xen_alloc_p2m_entry(page_to_pfn(pg));
+			ret = xen_alloc_p2m_entry(page_to_pfn(pages[i]));
 			if (ret < 0) {
-				unsigned int j;
-
-				for (j = 0; j <= i; j++) {
-					pages[j]->zone_device_data = page_list;
-					page_list = pages[j];
-					list_count++;
-				}
+				gen_pool_free(unpopulated_pool, (unsigned long)vaddr,
+						nr_pages * PAGE_SIZE);
 				goto out;
 			}
 		}
@@ -201,9 +202,68 @@ int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 	}
 
 out:
-	mutex_unlock(&list_lock);
+	mutex_unlock(&pool_lock);
 	return ret;
 }
+
+static bool in_unpopulated_pool(unsigned int nr_pages, struct page *page)
+{
+	if (!target_resource)
+		return false;
+
+	return gen_pool_has_addr(unpopulated_pool,
+			(unsigned long)page_to_virt(page), nr_pages * PAGE_SIZE);
+}
+
+static void free_unpopulated_pages(unsigned int nr_pages, struct page **pages,
+		bool contiguous)
+{
+	if (!target_resource) {
+		if (contiguous && nr_pages > 1)
+			return;
+
+		xen_free_ballooned_pages(nr_pages, pages);
+		return;
+	}
+
+	mutex_lock(&pool_lock);
+
+	/* XXX Do we need to check the range (gen_pool_has_addr)? */
+	if (contiguous)
+		gen_pool_free(unpopulated_pool, (unsigned long)page_to_virt(pages[0]),
+				nr_pages * PAGE_SIZE);
+	else {
+		unsigned int i;
+
+		for (i = 0; i < nr_pages; i++)
+			gen_pool_free(unpopulated_pool,
+					(unsigned long)page_to_virt(pages[i]), PAGE_SIZE);
+	}
+
+	mutex_unlock(&pool_lock);
+}
+
+/**
+ * is_xen_unpopulated_page - check whether page is unpopulated
+ * @page: page to be checked
+ * @return true if page is unpopulated, else otherwise
+ */
+bool is_xen_unpopulated_page(struct page *page)
+{
+	return in_unpopulated_pool(1, page);
+}
+EXPORT_SYMBOL(is_xen_unpopulated_page);
+
+/**
+ * xen_alloc_unpopulated_pages - alloc unpopulated pages
+ * @nr_pages: Number of pages
+ * @pages: pages returned
+ * @return 0 on success, error otherwise
+ */
+int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages)
+{
+	return alloc_unpopulated_pages(nr_pages, pages, false);
+}
 EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
 
 /**
@@ -213,22 +273,40 @@ EXPORT_SYMBOL(xen_alloc_unpopulated_pages);
  */
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages)
 {
-	unsigned int i;
+	free_unpopulated_pages(nr_pages, pages, false);
+}
+EXPORT_SYMBOL(xen_free_unpopulated_pages);
 
-	if (!target_resource) {
-		xen_free_ballooned_pages(nr_pages, pages);
-		return;
-	}
+/**
+ * xen_alloc_unpopulated_contiguous_pages - alloc unpopulated contiguous pages
+ * @dev: valid struct device pointer
+ * @nr_pages: Number of pages
+ * @pages: pages returned
+ * @return 0 on success, error otherwise
+ */
+int xen_alloc_unpopulated_contiguous_pages(struct device *dev,
+		unsigned int nr_pages, struct page **pages)
+{
+	/* XXX Handle devices which support 64-bit DMA address only for now */
+	if (dma_get_mask(dev) != DMA_BIT_MASK(64))
+		return -EINVAL;
 
-	mutex_lock(&list_lock);
-	for (i = 0; i < nr_pages; i++) {
-		pages[i]->zone_device_data = page_list;
-		page_list = pages[i];
-		list_count++;
-	}
-	mutex_unlock(&list_lock);
+	return alloc_unpopulated_pages(nr_pages, pages, true);
 }
-EXPORT_SYMBOL(xen_free_unpopulated_pages);
+EXPORT_SYMBOL(xen_alloc_unpopulated_contiguous_pages);
+
+/**
+ * xen_free_unpopulated_contiguous_pages - return unpopulated contiguous pages
+ * @dev: valid struct device pointer
+ * @nr_pages: Number of pages
+ * @pages: pages to return
+ */
+void xen_free_unpopulated_contiguous_pages(struct device *dev,
+		unsigned int nr_pages, struct page **pages)
+{
+	free_unpopulated_pages(nr_pages, pages, true);
+}
+EXPORT_SYMBOL(xen_free_unpopulated_contiguous_pages);
 
 static int __init unpopulated_init(void)
 {
@@ -237,9 +315,19 @@ static int __init unpopulated_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
+	unpopulated_pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!unpopulated_pool) {
+		pr_err("xen:unpopulated: Cannot create unpopulated pool\n");
+		return -ENOMEM;
+	}
+
+	gen_pool_set_algo(unpopulated_pool, gen_pool_best_fit, NULL);
+
 	ret = arch_xen_unpopulated_init(&target_resource);
 	if (ret) {
 		pr_err("xen:unpopulated: Cannot initialize target resource\n");
+		gen_pool_destroy(unpopulated_pool);
+		unpopulated_pool = NULL;
 		target_resource = NULL;
 	}
 
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0780a81..7d396cc 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -60,9 +60,16 @@ static inline void xen_set_restricted_virtio_memory_access(void)
 		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
 }
 
+struct device;
+
 #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
+int xen_alloc_unpopulated_contiguous_pages(struct device *dev,
+		unsigned int nr_pages, struct page **pages);
+void xen_free_unpopulated_contiguous_pages(struct device *dev,
+		unsigned int nr_pages, struct page **pages);
+bool is_xen_unpopulated_page(struct page *page);
 #include <linux/ioport.h>
 int arch_xen_unpopulated_init(struct resource **res);
 #else
@@ -77,6 +84,19 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
 {
 	xen_free_ballooned_pages(nr_pages, pages);
 }
+static inline int xen_alloc_unpopulated_contiguous_pages(struct device *dev,
+		unsigned int nr_pages, struct page **pages)
+{
+	return -1;
+}
+static inline void xen_free_unpopulated_contiguous_pages(struct device *dev,
+		unsigned int nr_pages, struct page **pages)
+{
+}
+static inline bool is_xen_unpopulated_page(struct page *page)
+{
+	return false;
+}
 #endif
 
 #endif	/* _XEN_XEN_H */
-- 
2.7.4

