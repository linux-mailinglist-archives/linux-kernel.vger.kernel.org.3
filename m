Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D045F4AB512
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354050AbiBGGh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiBGGdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:33:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743BC043185
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ztyo94wuVd0boUIbMNO8aobw9hUTFvBQz0hdN5C2IKM=; b=YXLD5Ed41GWE7WdR8pyA4prWso
        glPZpJ5lQXiRkGzlgErKgWT/lK92+98O3rhvFbEZJ97PljwBR+xNhxXEQJ306/dHidunJ0/Du7sx/
        EODsSnO0qkEcZWJQgCkvT7BDSvdab8jDGj9Xvfy8zd1Q4tLVOpivc4d6IYlcGaC/Mi0c8U8z0uYYo
        qFp91UtZYlADDNYEFDpnEsbkMR4UDrqSM4q3du+iSgahmCt8I4E17IShOugx3yIbgR55BLXjiX1Ta
        LWUEMJZOBVCU/fufJj7wwjQxA7VDnWTfLpQ1IQPo48aRSxj6ojs2gprPyBl3Fkw4nrZwWfzvktO1y
        FBgoXvAA==;
Received: from [2001:4bb8:188:3efc:2cbe:55d7:bb63:46d2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nGxaJ-0099NR-0q; Mon, 07 Feb 2022 06:33:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 7/8] mm: remove the extra ZONE_DEVICE struct page refcount
Date:   Mon,  7 Feb 2022 07:32:48 +0100
Message-Id: <20220207063249.1833066-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220207063249.1833066-1-hch@lst.de>
References: <20220207063249.1833066-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZONE_DEVICE struct pages have an extra reference count that complicates
the code for put_page() and several places in the kernel that need to
check the reference count to see that a page is not being used (gup,
compaction, migration, etc.). Clean up the code so the reference count
doesn't need to be treated specially for ZONE_DEVICE pages.

Note that this excludes the special idle page wakeup for fsdax pages,
which still happens at refcount 1.  This is a separate issue and will
be sorted out later.  Given that only fsdax pages require the
notifiacation when the refcount hits 1 now, the PAGEMAP_OPS Kconfig
symbol can go away and be replaced with a FS_DAX check for this hook
in the put_page fastpath.

Based on an earlier patch from Ralph Campbell <rcampbell@nvidia.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c       |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  1 -
 drivers/gpu/drm/nouveau/nouveau_dmem.c   |  1 -
 fs/Kconfig                               |  1 -
 include/linux/memremap.h                 | 12 +++--
 include/linux/mm.h                       |  6 +--
 lib/test_hmm.c                           |  1 -
 mm/Kconfig                               |  4 --
 mm/internal.h                            |  2 +
 mm/memcontrol.c                          | 11 ++---
 mm/memremap.c                            | 57 ++++++++----------------
 mm/migrate.c                             |  6 ---
 mm/swap.c                                | 16 ++-----
 13 files changed, 36 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index e414ca44839fd1..8b6438fa18fc2b 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -712,7 +712,6 @@ static struct page *kvmppc_uvmem_get_page(unsigned long gpa, struct kvm *kvm)
 
 	dpage = pfn_to_page(uvmem_pfn);
 	dpage->zone_device_data = pvt;
-	get_page(dpage);
 	lock_page(dpage);
 	return dpage;
 out_clear:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index cb835f95a76e66..e27ca375876230 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -225,7 +225,6 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
 	page = pfn_to_page(pfn);
 	svm_range_bo_ref(prange->svm_bo);
 	page->zone_device_data = prange->svm_bo;
-	get_page(page);
 	lock_page(page);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index a5cdfbe32b5e54..7ba66ad68a8a1e 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -326,7 +326,6 @@ nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm)
 			return NULL;
 	}
 
-	get_page(page);
 	lock_page(page);
 	return page;
 }
diff --git a/fs/Kconfig b/fs/Kconfig
index 7a2b11c0b8036d..05efea674bffa0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -48,7 +48,6 @@ config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
 	depends on !(ARM || MIPS || SPARC)
-	select DEV_PAGEMAP_OPS if (ZONE_DEVICE && !FS_DAX_LIMITED)
 	select FS_IOMAP
 	select DAX
 	help
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 514ab46f597e5c..d6a114dd5ea8b7 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -68,9 +68,9 @@ enum memory_type {
 
 struct dev_pagemap_ops {
 	/*
-	 * Called once the page refcount reaches 1.  (ZONE_DEVICE pages never
-	 * reach 0 refcount unless there is a refcount bug. This allows the
-	 * device driver to implement its own memory management.)
+	 * Called once the page refcount reaches 0.  The reference count will be
+	 * reset to one by the core code after the method is called to prepare
+	 * for handing out the page again.
 	 */
 	void (*page_free)(struct page *page);
 
@@ -133,16 +133,14 @@ static inline unsigned long pgmap_vmemmap_nr(struct dev_pagemap *pgmap)
 
 static inline bool is_device_private_page(const struct page *page)
 {
-	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
-		IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
+	return IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
 		is_zone_device_page(page) &&
 		page->pgmap->type == MEMORY_DEVICE_PRIVATE;
 }
 
 static inline bool is_pci_p2pdma_page(const struct page *page)
 {
-	return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
-		IS_ENABLED(CONFIG_PCI_P2PDMA) &&
+	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
 		is_zone_device_page(page) &&
 		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80fccfe31c3444..ff9f149ca2017e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1090,7 +1090,7 @@ static inline bool is_zone_movable_page(const struct page *page)
 	return page_zonenum(page) == ZONE_MOVABLE;
 }
 
-#ifdef CONFIG_DEV_PAGEMAP_OPS
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
 
 bool __put_devmap_managed_page(struct page *page);
@@ -1103,12 +1103,12 @@ static inline bool put_devmap_managed_page(struct page *page)
 	return __put_devmap_managed_page(page);
 }
 
-#else /* CONFIG_DEV_PAGEMAP_OPS */
+#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
 static inline bool put_devmap_managed_page(struct page *page)
 {
 	return false;
 }
-#endif /* CONFIG_DEV_PAGEMAP_OPS */
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
 
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index e5fc14ba71f33e..cfe63204783918 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -566,7 +566,6 @@ static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevice)
 	}
 
 	dpage->zone_device_data = rpage;
-	get_page(dpage);
 	lock_page(dpage);
 	return dpage;
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f330..a1901ae6d06293 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -776,9 +776,6 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
-config DEV_PAGEMAP_OPS
-	bool
-
 #
 # Helpers to mirror range of the CPU page tables of a process into device page
 # tables.
@@ -790,7 +787,6 @@ config HMM_MIRROR
 config DEVICE_PRIVATE
 	bool "Unaddressable device memory (GPU memory, ...)"
 	depends on ZONE_DEVICE
-	select DEV_PAGEMAP_OPS
 
 	help
 	  Allows creation of struct pages to represent unaddressable device
diff --git a/mm/internal.h b/mm/internal.h
index d80300392a194f..a67222d17e5987 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -718,4 +718,6 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
+void free_zone_device_page(struct page *page);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0d9..d1e97a54ae535e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5503,17 +5503,12 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 		return NULL;
 
 	/*
-	 * Handle MEMORY_DEVICE_PRIVATE which are ZONE_DEVICE page belonging to
-	 * a device and because they are not accessible by CPU they are store
-	 * as special swap entry in the CPU page table.
+	 * Handle device private pages that are not accessible by the CPU, but
+	 * stored as special swap entries in the page table.
 	 */
 	if (is_device_private_entry(ent)) {
 		page = pfn_swap_entry_to_page(ent);
-		/*
-		 * MEMORY_DEVICE_PRIVATE means ZONE_DEVICE page and which have
-		 * a refcount of 1 when free (unlike normal page)
-		 */
-		if (!page_ref_add_unless(page, 1, 1))
+		if (!get_page_unless_zero(page))
 			return NULL;
 		return page;
 	}
diff --git a/mm/memremap.c b/mm/memremap.c
index a0ece2344c2cab..fef5734d5e4933 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/wait_bit.h>
 #include <linux/xarray.h>
+#include "internal.h"
 
 static DEFINE_XARRAY(pgmap_array);
 
@@ -37,21 +38,19 @@ unsigned long memremap_compat_align(void)
 EXPORT_SYMBOL_GPL(memremap_compat_align);
 #endif
 
-#ifdef CONFIG_DEV_PAGEMAP_OPS
+#ifdef CONFIG_FS_DAX
 DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
 EXPORT_SYMBOL(devmap_managed_key);
 
 static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
 {
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
 		static_branch_dec(&devmap_managed_key);
 }
 
 static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
 {
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_FS_DAX)
+	if (pgmap->type == MEMORY_DEVICE_FS_DAX)
 		static_branch_inc(&devmap_managed_key);
 }
 #else
@@ -61,7 +60,7 @@ static void devmap_managed_enable_get(struct dev_pagemap *pgmap)
 static void devmap_managed_enable_put(struct dev_pagemap *pgmap)
 {
 }
-#endif /* CONFIG_DEV_PAGEMAP_OPS */
+#endif /* CONFIG_FS_DAX */
 
 static void pgmap_array_delete(struct range *range)
 {
@@ -102,23 +101,12 @@ static unsigned long pfn_end(struct dev_pagemap *pgmap, int range_id)
 	return (range->start + range_len(range)) >> PAGE_SHIFT;
 }
 
-static unsigned long pfn_next(struct dev_pagemap *pgmap, unsigned long pfn)
-{
-	if (pfn % (1024 << pgmap->vmemmap_shift))
-		cond_resched();
-	return pfn + pgmap_vmemmap_nr(pgmap);
-}
-
 static unsigned long pfn_len(struct dev_pagemap *pgmap, unsigned long range_id)
 {
 	return (pfn_end(pgmap, range_id) -
 		pfn_first(pgmap, range_id)) >> pgmap->vmemmap_shift;
 }
 
-#define for_each_device_pfn(pfn, map, i) \
-	for (pfn = pfn_first(map, i); pfn < pfn_end(map, i); \
-	     pfn = pfn_next(map, pfn))
-
 static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 {
 	struct range *range = &pgmap->ranges[range_id];
@@ -147,13 +135,11 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 
 void memunmap_pages(struct dev_pagemap *pgmap)
 {
-	unsigned long pfn;
 	int i;
 
 	percpu_ref_kill(&pgmap->ref);
 	for (i = 0; i < pgmap->nr_range; i++)
-		for_each_device_pfn(pfn, pgmap, i)
-			put_page(pfn_to_page(pfn));
+		percpu_ref_put_many(&pgmap->ref, pfn_len(pgmap, i));
 	wait_for_completion(&pgmap->done);
 	percpu_ref_exit(&pgmap->ref);
 
@@ -464,14 +450,10 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 }
 EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
-#ifdef CONFIG_DEV_PAGEMAP_OPS
-void free_devmap_managed_page(struct page *page)
+void free_zone_device_page(struct page *page)
 {
-	/* notify page idle for dax */
-	if (!is_device_private_page(page)) {
-		wake_up_var(&page->_refcount);
+	if (WARN_ON_ONCE(!is_device_private_page(page)))
 		return;
-	}
 
 	__ClearPageWaiters(page);
 
@@ -500,28 +482,27 @@ void free_devmap_managed_page(struct page *page)
 	 */
 	page->mapping = NULL;
 	page->pgmap->ops->page_free(page);
+
+	/*
+	 * Reset the page count to 1 to prepare for handing out the page again.
+	 */
+	set_page_count(page, 1);
 }
 
+#ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_page(struct page *page)
 {
-	if (page->pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    page->pgmap->type != MEMORY_DEVICE_FS_DAX)
+	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
 		return false;
 
 	/*
-	 * devmap page refcounts are 1-based, rather than 0-based: if
+	 * fsdax page refcounts are 1-based, rather than 0-based: if
 	 * refcount is 1, then the page is free and the refcount is
 	 * stable because nobody holds a reference on the page.
 	 */
-	switch (page_ref_dec_return(page)) {
-	case 1:
-		free_devmap_managed_page(page);
-		break;
-	case 0:
-		__put_page(page);
-		break;
-	}
+	if (page_ref_dec_return(page) == 1)
+		wake_up_var(&page->_refcount);
 	return true;
 }
 EXPORT_SYMBOL(__put_devmap_managed_page);
-#endif /* CONFIG_DEV_PAGEMAP_OPS */
+#endif /* CONFIG_FS_DAX */
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781b8..8e0370a73f8a43 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -341,14 +341,8 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
 {
 	int expected_count = 1;
 
-	/*
-	 * Device private pages have an extra refcount as they are
-	 * ZONE_DEVICE pages.
-	 */
-	expected_count += is_device_private_page(page);
 	if (mapping)
 		expected_count += compound_nr(page) + page_has_private(page);
-
 	return expected_count;
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index 25b55c56614311..c84d6817043257 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -114,17 +114,9 @@ static void __put_compound_page(struct page *page)
 
 void __put_page(struct page *page)
 {
-	if (is_zone_device_page(page)) {
-		put_dev_pagemap(page->pgmap);
-
-		/*
-		 * The page belongs to the device that created pgmap. Do
-		 * not return it to page allocator.
-		 */
-		return;
-	}
-
-	if (unlikely(PageCompound(page)))
+	if (unlikely(is_zone_device_page(page)))
+		free_zone_device_page(page);
+	else if (unlikely(PageCompound(page)))
 		__put_compound_page(page);
 	else
 		__put_single_page(page);
@@ -933,7 +925,7 @@ void release_pages(struct page **pages, int nr)
 			if (put_devmap_managed_page(page))
 				continue;
 			if (put_page_testzero(page))
-				put_dev_pagemap(page->pgmap);
+				free_zone_device_page(page);
 			continue;
 		}
 
-- 
2.30.2

