Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF15099F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386630AbiDUHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386141AbiDUHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:46:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AAA1CFEC;
        Thu, 21 Apr 2022 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nQ300dU+Ezn/PyIahw7vb/D3ShJjc+D3hqk9H1IGo5A=; b=bUkXEBSEOpDAcvAP9Ws9Uj5ufJ
        Vz9A48UhKNftZsmpn+SZDO6Zgb2VBvy9iqlN+qqiFnlu8XcmHODAjIVp9YjNX6YKhPVEAgBJPJNSV
        gZM/5xYWuvo28zFfdEf1SgMObWWJNZOENhF7Kb4JRsszZ/by2Cy4Rx6IrQ7qY/EuiyT9R6Suf7wXl
        5dwUl5/38Ta3X5bvQ1le9ZkoKDAZsIjo45WQuIjoDf/u3zFEcHkLu4QQN3J+OGdSaEt4S0OaeLgsd
        09100CM7LBwCqGl6QzVSm08lcm5HABvOCn22KL8j9HYqxy0hQKvDL+aRaiZJMuM2KfKbAfgIcQicb
        AdA5d/Tw==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRSN-00C7bh-5g; Thu, 21 Apr 2022 07:42:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 7/7] ARM: use dma-direct unconditionally
Date:   Thu, 21 Apr 2022 09:42:04 +0200
Message-Id: <20220421074204.1284072-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma-direct unconditionally on arm.  It has already been used for
some time for LPAE and nommu configurations.

This mostly changes the streaming mapping implementation and the (simple)
coherent allocator for device that are DMA coherent.  The existing
complex allocator for uncached mappings for non-coherent devices is still
used as is using the arch_dma_alloc/arch_dma_free hooks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig                   |   4 +-
 arch/arm/include/asm/dma-mapping.h |  24 --
 arch/arm/mach-highbank/highbank.c  |   2 +-
 arch/arm/mach-mvebu/coherency.c    |   2 +-
 arch/arm/mm/dma-mapping.c          | 365 ++---------------------------
 5 files changed, 19 insertions(+), 378 deletions(-)
 delete mode 100644 arch/arm/include/asm/dma-mapping.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ac2e3e4957d66..3258630beee6c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -19,8 +19,8 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB || !MMU
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB || !MMU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
deleted file mode 100644
index 6427b934bd11c..0000000000000
--- a/arch/arm/include/asm/dma-mapping.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASMARM_DMA_MAPPING_H
-#define ASMARM_DMA_MAPPING_H
-
-#ifdef __KERNEL__
-
-#include <linux/mm_types.h>
-#include <linux/scatterlist.h>
-
-#include <xen/xen.h>
-#include <asm/xen/hypervisor.h>
-
-extern const struct dma_map_ops arm_dma_ops;
-extern const struct dma_map_ops arm_coherent_dma_ops;
-
-static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
-{
-	if (IS_ENABLED(CONFIG_MMU) && !IS_ENABLED(CONFIG_ARM_LPAE))
-		return &arm_dma_ops;
-	return NULL;
-}
-
-#endif /* __KERNEL__ */
-#endif
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index db607955a7e45..5d4f977ac7d2a 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -98,7 +98,7 @@ static int highbank_platform_notifier(struct notifier_block *nb,
 	if (of_property_read_bool(dev->of_node, "dma-coherent")) {
 		val = readl(sregs_base + reg);
 		writel(val | 0xff01, sregs_base + reg);
-		set_dma_ops(dev, &arm_coherent_dma_ops);
+		dev->dma_coherent = true;
 	}
 
 	return NOTIFY_OK;
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 49e3c8d20c2fa..865ac4bc060df 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -98,7 +98,7 @@ static int mvebu_hwcc_notifier(struct notifier_block *nb,
 
 	if (event != BUS_NOTIFY_ADD_DEVICE)
 		return NOTIFY_DONE;
-	set_dma_ops(dev, &arm_coherent_dma_ops);
+	dev->dma_coherent = true;
 
 	return NOTIFY_OK;
 }
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e09d79a328fa1..0f76222cbcbb9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -103,79 +103,8 @@ static struct arm_dma_buffer *arm_dma_buffer_find(void *virt)
  * before transfers and delay cache invalidation until transfer completion.
  *
  */
-static void __dma_page_cpu_to_dev(struct page *, unsigned long,
-		size_t, enum dma_data_direction);
-static void __dma_page_dev_to_cpu(struct page *, unsigned long,
-		size_t, enum dma_data_direction);
-
-/**
- * arm_dma_map_page - map a portion of a page for streaming DMA
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * Ensure that any data held in the cache is appropriately discarded
- * or written back.
- *
- * The device owns this memory once this call has completed.  The CPU
- * can regain ownership by calling dma_unmap_page().
- */
-static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     unsigned long attrs)
-{
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_page_cpu_to_dev(page, offset, size, dir);
-	return phys_to_dma(dev, page_to_phys(page) + offset);
-}
-
-static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     unsigned long attrs)
-{
-	return phys_to_dma(dev, page_to_phys(page) + offset);
-}
-
-/**
- * arm_dma_unmap_page - unmap a buffer previously mapped through dma_map_page()
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_page)
- * @dir: DMA transfer direction (same as passed to dma_map_page)
- *
- * Unmap a page streaming mode DMA translation.  The handle and size
- * must match what was provided in the previous dma_map_page() call.
- * All other usages are undefined.
- *
- * After this call, reads by the CPU to the buffer are guaranteed to see
- * whatever the device wrote there.
- */
-static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_page_dev_to_cpu(phys_to_page(dma_to_phys(dev, handle)),
-				      handle & ~PAGE_MASK, size, dir);
-}
-
-static void arm_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	unsigned int offset = handle & (PAGE_SIZE - 1);
-	struct page *page = phys_to_page(dma_to_phys(dev, handle-offset));
-	__dma_page_dev_to_cpu(page, offset, size, dir);
-}
-
-static void arm_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	unsigned int offset = handle & (PAGE_SIZE - 1);
-	struct page *page = phys_to_page(dma_to_phys(dev, handle-offset));
-	__dma_page_cpu_to_dev(page, offset, size, dir);
-}
 
+#ifdef CONFIG_ARM_DMA_USE_IOMMU
 /*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
@@ -192,6 +121,7 @@ static int arm_dma_supported(struct device *dev, u64 mask)
 	 */
 	return PHYS_PFN(dma_to_phys(dev, mask)) >= max_dma_pfn;
 }
+#endif
 
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
@@ -694,67 +624,6 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	return args.want_vaddr ? addr : page;
 }
 
-/*
- * Allocate DMA-coherent memory space and return both the kernel remapped
- * virtual and bus address for that space.
- */
-static void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		    gfp_t gfp, unsigned long attrs)
-{
-	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
-
-	return __dma_alloc(dev, size, handle, gfp, prot, false,
-			   attrs, __builtin_return_address(0));
-}
-
-static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
-{
-	return __dma_alloc(dev, size, handle, gfp, PAGE_KERNEL, true,
-			   attrs, __builtin_return_address(0));
-}
-
-static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
-{
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
-	unsigned long off = vma->vm_pgoff;
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
-}
-
-/*
- * Create userspace mapping for the DMA-coherent memory.
- */
-static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
-{
-	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
-
-static int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs)
-{
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
-
 /*
  * Free a buffer as defined by the above mapping.
  */
@@ -780,40 +649,6 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	kfree(buf);
 }
 
-static void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		  dma_addr_t handle, unsigned long attrs)
-{
-	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
-}
-
-static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, unsigned long attrs)
-{
-	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
-}
-
-static int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
-		 void *cpu_addr, dma_addr_t handle, size_t size,
-		 unsigned long attrs)
-{
-	phys_addr_t paddr = dma_to_phys(dev, handle);
-	struct page *page;
-	int ret;
-
-	/* If the PFN is not valid, we do not have a struct page */
-	if (!pfn_valid(PHYS_PFN(paddr)))
-		return -ENXIO;
-
-	page = phys_to_page(paddr);
-
-	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
-	if (unlikely(ret))
-		return ret;
-
-	sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
-	return 0;
-}
-
 static void dma_cache_maint_page(struct page *page, unsigned long offset,
 	size_t size, enum dma_data_direction dir,
 	void (*op)(const void *, size_t, int))
@@ -917,158 +752,6 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	}
 }
 
-/**
- * arm_dma_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * This is the scatter-gather version of the dma_map_single interface.
- * Here the scatter gather list elements are each tagged with the
- * appropriate dma address and length.  They are obtained via
- * sg_dma_{address,length}.
- *
- * Device ownership issues as mentioned for dma_map_single are the same
- * here.
- */
-static int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct scatterlist *s;
-	int i, j, ret;
-
-	for_each_sg(sg, s, nents, i) {
-#ifdef CONFIG_NEED_SG_DMA_LENGTH
-		s->dma_length = s->length;
-#endif
-		s->dma_address = ops->map_page(dev, sg_page(s), s->offset,
-						s->length, dir, attrs);
-		if (dma_mapping_error(dev, s->dma_address)) {
-			ret = -EIO;
-			goto bad_mapping;
-		}
-	}
-	return nents;
-
- bad_mapping:
-	for_each_sg(sg, s, i, j)
-		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
-	return ret;
-}
-
-/**
- * arm_dma_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-static void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct scatterlist *s;
-
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		ops->unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
-}
-
-/**
- * arm_dma_sync_sg_for_cpu
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-static void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		ops->sync_single_for_cpu(dev, sg_dma_address(s), s->length,
-					 dir);
-}
-
-/**
- * arm_dma_sync_sg_for_device
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-static void arm_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		ops->sync_single_for_device(dev, sg_dma_address(s), s->length,
-					    dir);
-}
-
-const struct dma_map_ops arm_dma_ops = {
-	.alloc			= arm_dma_alloc,
-	.free			= arm_dma_free,
-	.alloc_pages		= dma_direct_alloc_pages,
-	.free_pages		= dma_direct_free_pages,
-	.mmap			= arm_dma_mmap,
-	.get_sgtable		= arm_dma_get_sgtable,
-	.map_page		= arm_dma_map_page,
-	.unmap_page		= arm_dma_unmap_page,
-	.map_sg			= arm_dma_map_sg,
-	.unmap_sg		= arm_dma_unmap_sg,
-	.map_resource		= dma_direct_map_resource,
-	.sync_single_for_cpu	= arm_dma_sync_single_for_cpu,
-	.sync_single_for_device	= arm_dma_sync_single_for_device,
-	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
-	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
-	.dma_supported		= arm_dma_supported,
-	.get_required_mask	= dma_direct_get_required_mask,
-};
-EXPORT_SYMBOL(arm_dma_ops);
-
-const struct dma_map_ops arm_coherent_dma_ops = {
-	.alloc			= arm_coherent_dma_alloc,
-	.free			= arm_coherent_dma_free,
-	.alloc_pages		= dma_direct_alloc_pages,
-	.free_pages		= dma_direct_free_pages,
-	.mmap			= arm_coherent_dma_mmap,
-	.get_sgtable		= arm_dma_get_sgtable,
-	.map_page		= arm_coherent_dma_map_page,
-	.map_sg			= arm_dma_map_sg,
-	.map_resource		= dma_direct_map_resource,
-	.dma_supported		= arm_dma_supported,
-	.get_required_mask	= dma_direct_get_required_mask,
-};
-EXPORT_SYMBOL(arm_coherent_dma_ops);
-
-static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
-{
-	/*
-	 * When CONFIG_ARM_LPAE is set, physical address can extend above
-	 * 32-bits, which then can't be addressed by devices that only support
-	 * 32-bit DMA.
-	 * Use the generic dma-direct / swiotlb ops code in that case, as that
-	 * handles bounce buffering for us.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_LPAE))
-		return NULL;
-	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
-}
-
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 
 static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
@@ -2193,40 +1876,35 @@ void arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
-	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
+	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
-static const struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
-{
-	return coherent ? &iommu_coherent_ops : &iommu_ops;
-}
-
-static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    const struct iommu_ops *iommu)
+static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				    const struct iommu_ops *iommu, bool coherent)
 {
 	struct dma_iommu_mapping *mapping;
 
-	if (!iommu)
-		return false;
-
 	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
 	if (IS_ERR(mapping)) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
 				size, dev_name(dev));
-		return false;
+		return;
 	}
 
 	if (__arm_iommu_attach_device(dev, mapping)) {
 		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
 				dev_name(dev));
 		arm_iommu_release_mapping(mapping);
-		return false;
+		return;
 	}
 
-	return true;
+	if (coherent)
+		set_dma_ops(dev, &iommu_coherent_ops);
+	else
+		set_dma_ops(dev, &iommu_ops);
 }
 
 static void arm_teardown_iommu_dma_ops(struct device *dev)
@@ -2242,27 +1920,20 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 
 #else
 
-static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    const struct iommu_ops *iommu)
+static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				    const struct iommu_ops *iommu, bool coherent)
 {
-	return false;
 }
 
 static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
-#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
-
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-	const struct dma_map_ops *dma_ops;
-
 	dev->archdata.dma_coherent = coherent;
-#ifdef CONFIG_SWIOTLB
 	dev->dma_coherent = coherent;
-#endif
 
 	/*
 	 * Don't override the dma_ops if they have already been set. Ideally
@@ -2272,12 +1943,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (dev->dma_ops)
 		return;
 
-	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
-		dma_ops = arm_get_iommu_dma_map_ops(coherent);
-	else
-		dma_ops = arm_get_dma_map_ops(coherent);
-
-	set_dma_ops(dev, dma_ops);
+	if (iommu)
+		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
 
 #ifdef CONFIG_XEN
 	if (xen_initial_domain())
@@ -2296,7 +1963,6 @@ void arch_teardown_dma_ops(struct device *dev)
 	set_dma_ops(dev, NULL);
 }
 
-#ifdef CONFIG_SWIOTLB
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
@@ -2324,4 +1990,3 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 {
 	__arm_dma_free(dev, size, cpu_addr, dma_handle, attrs, false);
 }
-#endif /* CONFIG_SWIOTLB */
-- 
2.30.2

