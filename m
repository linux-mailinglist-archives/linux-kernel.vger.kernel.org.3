Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15B25099C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386144AbiDUHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386070AbiDUHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08001AF11;
        Thu, 21 Apr 2022 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HBK2GkKJE433clq8KTueiX3e05bghm5LaNwHrixluHQ=; b=ZFllNSopN4L2N75GWyR7OswG2y
        acicp6Ibv16KAWVvnY3nO5ukTWJ+8TBwQ1Z9dUGL7nbrPbc3OhRDOyNBfnpKNuBReSM1Pu1kQIFJw
        b19P2YK4nSYfve4BCRbndSdZsmZyKePdZqyY3HqQyb6Mj4C8Ksja5aOijNtNZ6VfCEwc5uxMw7OlL
        U8SLKuRsKIJQtfjd7rnw44EOrvzA/4unnPys0O0R1qQ6kYAuhZpdSepnRFfnAtO8pzXnPfWBpzuJb
        8nPYc+/Wem0KZigamt5sASxxsPFOVs/3ZIHdZ37hUOr42sXrjfa/jYq2E45pXZqgldn74VtJHAYpW
        yrfgZRlQ==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRSB-00C7Ve-CS; Thu, 21 Apr 2022 07:42:16 +0000
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
Subject: [PATCH 3/7] ARM: mark various dma-mapping routines static in dma-mapping.c
Date:   Thu, 21 Apr 2022 09:42:00 +0200
Message-Id: <20220421074204.1284072-4-hch@lst.de>
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

With the dmabounce removal these aren't used outside of dma-mapping.c,
so mark them static.  Move the dma_map_ops declarations down a bit
to avoid lots of forward declarations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h |  75 ----------------------
 arch/arm/mm/dma-mapping.c          | 100 +++++++++++++----------------
 2 files changed, 46 insertions(+), 129 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 1e015a7ad86aa..6427b934bd11c 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -20,80 +20,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-/**
- * arm_dma_alloc - allocate consistent memory for DMA
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @size: required memory size
- * @handle: bus-specific DMA address
- * @attrs: optinal attributes that specific mapping properties
- *
- * Allocate some memory for a device for performing DMA.  This function
- * allocates pages, and will return the CPU-viewed address, and sets @handle
- * to be the device-viewed address.
- */
-extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-			   gfp_t gfp, unsigned long attrs);
-
-/**
- * arm_dma_free - free memory allocated by arm_dma_alloc
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @size: size of memory originally requested in dma_alloc_coherent
- * @cpu_addr: CPU-view address returned from dma_alloc_coherent
- * @handle: device-view address returned from dma_alloc_coherent
- * @attrs: optinal attributes that specific mapping properties
- *
- * Free (and unmap) a DMA buffer previously allocated by
- * arm_dma_alloc().
- *
- * References to memory and mappings associated with cpu_addr/handle
- * during and after this call executing are illegal.
- */
-extern void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
-			 dma_addr_t handle, unsigned long attrs);
-
-/**
- * arm_dma_mmap - map a coherent DMA allocation into user space
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @vma: vm_area_struct describing requested user mapping
- * @cpu_addr: kernel CPU-view address returned from dma_alloc_coherent
- * @handle: device-view address returned from dma_alloc_coherent
- * @size: size of memory originally requested in dma_alloc_coherent
- * @attrs: optinal attributes that specific mapping properties
- *
- * Map a coherent DMA buffer previously allocated by dma_alloc_coherent
- * into user space.  The coherent DMA buffer must not be freed by the
- * driver until the user space mapping has been released.
- */
-extern int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			unsigned long attrs);
-
-/*
- * For SA-1111, IXP425, and ADI systems  the dma-mapping functions are "magic"
- * and utilize bounce buffers as needed to work around limited DMA windows.
- *
- * On the SA-1111, a bug limits DMA to only certain regions of RAM.
- * On the IXP425, the PCI inbound window is 64MB (256MB total RAM)
- * On some ADI engineering systems, PCI inbound window is 32MB (12MB total RAM)
- *
- * The following are helper functions used by the dmabounce subystem
- *
- */
-
-/*
- * The scatter list versions of the above methods.
- */
-extern int arm_dma_map_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, unsigned long attrs);
-extern void arm_dma_unmap_sg(struct device *, struct scatterlist *, int,
-		enum dma_data_direction, unsigned long attrs);
-extern void arm_dma_sync_sg_for_cpu(struct device *, struct scatterlist *, int,
-		enum dma_data_direction);
-extern void arm_dma_sync_sg_for_device(struct device *, struct scatterlist *, int,
-		enum dma_data_direction);
-extern int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs);
-
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82ffac621854f..0ee5adbdd3f1d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -193,50 +193,6 @@ static int arm_dma_supported(struct device *dev, u64 mask)
 	return dma_to_pfn(dev, mask) >= max_dma_pfn;
 }
 
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
-static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
-	dma_addr_t *handle, gfp_t gfp, unsigned long attrs);
-static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_addr,
-				  dma_addr_t handle, unsigned long attrs);
-static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		 unsigned long attrs);
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
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
 	/*
@@ -742,7 +698,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
  */
-void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+static void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		    gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
@@ -791,7 +747,7 @@ static int arm_coherent_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	return __arm_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
-int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+static int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
@@ -824,7 +780,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	kfree(buf);
 }
 
-void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
+static void arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		  dma_addr_t handle, unsigned long attrs)
 {
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, false);
@@ -836,7 +792,7 @@ static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_add
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
-int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
+static int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 unsigned long attrs)
 {
@@ -977,7 +933,7 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
  * Device ownership issues as mentioned for dma_map_single are the same
  * here.
  */
-int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+static int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -1013,8 +969,8 @@ int arm_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
  * Unmap a set of streaming mode DMA translations.  Again, CPU access
  * rules concerning calls here are the same as for dma_unmap_single().
  */
-void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, unsigned long attrs)
+static void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1032,7 +988,7 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+static void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -1051,8 +1007,8 @@ void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
  * @nents: number of buffers to map (returned from dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
-void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
+static void arm_dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sg, int nents, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct scatterlist *s;
@@ -1063,6 +1019,42 @@ void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 					    dir);
 }
 
+const struct dma_map_ops arm_dma_ops = {
+	.alloc			= arm_dma_alloc,
+	.free			= arm_dma_free,
+	.alloc_pages		= dma_direct_alloc_pages,
+	.free_pages		= dma_direct_free_pages,
+	.mmap			= arm_dma_mmap,
+	.get_sgtable		= arm_dma_get_sgtable,
+	.map_page		= arm_dma_map_page,
+	.unmap_page		= arm_dma_unmap_page,
+	.map_sg			= arm_dma_map_sg,
+	.unmap_sg		= arm_dma_unmap_sg,
+	.map_resource		= dma_direct_map_resource,
+	.sync_single_for_cpu	= arm_dma_sync_single_for_cpu,
+	.sync_single_for_device	= arm_dma_sync_single_for_device,
+	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
+	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
+	.dma_supported		= arm_dma_supported,
+	.get_required_mask	= dma_direct_get_required_mask,
+};
+EXPORT_SYMBOL(arm_dma_ops);
+
+const struct dma_map_ops arm_coherent_dma_ops = {
+	.alloc			= arm_coherent_dma_alloc,
+	.free			= arm_coherent_dma_free,
+	.alloc_pages		= dma_direct_alloc_pages,
+	.free_pages		= dma_direct_free_pages,
+	.mmap			= arm_coherent_dma_mmap,
+	.get_sgtable		= arm_dma_get_sgtable,
+	.map_page		= arm_coherent_dma_map_page,
+	.map_sg			= arm_dma_map_sg,
+	.map_resource		= dma_direct_map_resource,
+	.dma_supported		= arm_dma_supported,
+	.get_required_mask	= dma_direct_get_required_mask,
+};
+EXPORT_SYMBOL(arm_coherent_dma_ops);
+
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
 	/*
-- 
2.30.2

