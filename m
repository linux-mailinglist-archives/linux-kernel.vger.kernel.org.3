Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7854AD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356053AbiFNJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355216AbiFNJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C743AF7;
        Tue, 14 Jun 2022 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=cEeFGQ9z/Ud9HO9TJXgCCbaAjfFsnDnvD7TshNTksmQ=; b=mQcoxZfJLvzGhZnPehFupUwpCc
        ndqlmxHmBq84VlBaxXGdUjOhWNA2HREUFXpeOx/7fAhDLYKA7I5qnTkJlj/gAjehxW3zgYBkwdxLc
        0+ZsphCk2dNmR3iVIGYTqYuQ41096WF2x8yUojwbMbTassXwz/Zay64ZFdFV/1NepaRgdkaPDN+sT
        eSYSrmW/sJQrszw5daaK8tjEytasdidCezaQ+QqQO+8i+1bbmqmXpYqNjnRJyxv0lfOA+4R9fjr9/
        rNZV//GKX9z5reyydeQkw+M35y+JSRXhDrCECOkzSKDNp2JnX8LyPXqeXfRuHhfz4noCNzqsPl1NM
        nYpGJSvQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12jc-008fTN-TC; Tue, 14 Jun 2022 09:21:17 +0000
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
        linux-usb@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: [PATCH 09/10] ARM/dma-mapping: consolidate IOMMU ops callbacks
Date:   Tue, 14 Jun 2022 11:20:46 +0200
Message-Id: <20220614092047.572235-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614092047.572235-1-hch@lst.de>
References: <20220614092047.572235-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Merge the coherent and non-coherent callbacks down to a single
implementation each, relying on the generic dev->dma_coherent
flag at the points where the difference matters.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 238 +++++++++-----------------------------
 1 file changed, 55 insertions(+), 183 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4055f2dc2859e..e7ccf7c82e025 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1079,13 +1079,13 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 		__free_from_pool(cpu_addr, size);
 }
 
-static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs,
-	    int coherent_flag)
+static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
 	void *addr = NULL;
+	int coherent_flag = dev->dma_coherent ? COHERENT : NORMAL;
 
 	*handle = DMA_MAPPING_ERROR;
 	size = PAGE_ALIGN(size);
@@ -1128,19 +1128,7 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	return NULL;
 }
 
-static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
-{
-	return __arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, NORMAL);
-}
-
-static void *arm_coherent_iommu_alloc_attrs(struct device *dev, size_t size,
-		    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
-{
-	return __arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, COHERENT);
-}
-
-static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
@@ -1154,35 +1142,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
+	if (!dev->dma_coherent)
+		vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+
 	err = vm_map_pages(vma, pages, nr_pages);
 	if (err)
 		pr_err("Remapping memory failed: %d\n", err);
 
 	return err;
 }
-static int arm_iommu_mmap_attrs(struct device *dev,
-		struct vm_area_struct *vma, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs)
-{
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-
-	return __arm_iommu_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
-
-static int arm_coherent_iommu_mmap_attrs(struct device *dev,
-		struct vm_area_struct *vma, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs)
-{
-	return __arm_iommu_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
 
 /*
  * free a page as defined by the above mapping.
  * Must not be called with IRQs disabled.
  */
-static void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-	dma_addr_t handle, unsigned long attrs, int coherent_flag)
+static void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+	dma_addr_t handle, unsigned long attrs)
 {
+	int coherent_flag = dev->dma_coherent ? COHERENT : NORMAL;
 	struct page **pages;
 	size = PAGE_ALIGN(size);
 
@@ -1204,19 +1181,6 @@ static void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_ad
 	__iommu_free_buffer(dev, pages, size, attrs);
 }
 
-static void arm_iommu_free_attrs(struct device *dev, size_t size,
-				 void *cpu_addr, dma_addr_t handle,
-				 unsigned long attrs)
-{
-	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, NORMAL);
-}
-
-static void arm_coherent_iommu_free_attrs(struct device *dev, size_t size,
-		    void *cpu_addr, dma_addr_t handle, unsigned long attrs)
-{
-	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, COHERENT);
-}
-
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t dma_addr,
 				 size_t size, unsigned long attrs)
@@ -1236,8 +1200,7 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
  */
 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, unsigned long attrs,
-			  bool is_coherent)
+			  enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova, iova_base;
@@ -1257,7 +1220,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		phys_addr_t phys = page_to_phys(sg_page(s));
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
-		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 
 		prot = __dma_info_to_prot(dir, attrs);
@@ -1277,9 +1240,20 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 	return ret;
 }
 
-static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, unsigned long attrs,
-		     bool is_coherent)
+/**
+ * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
+ * @dev: valid struct device pointer
+ * @sg: list of buffers
+ * @nents: number of buffers to map
+ * @dir: DMA transfer direction
+ *
+ * Map a set of buffers described by scatterlist in streaming mode for DMA.
+ * The scatter gather list elements are merged together (if possible) and
+ * tagged with the appropriate dma address and length. They are obtained via
+ * sg_dma_{address,length}.
+ */
+static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
 	int i, count = 0, ret;
@@ -1294,8 +1268,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 		if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
 			ret = __map_sg_chunk(dev, start, size,
-					     &dma->dma_address, dir, attrs,
-					     is_coherent);
+					     &dma->dma_address, dir, attrs);
 			if (ret < 0)
 				goto bad_mapping;
 
@@ -1309,8 +1282,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		}
 		size += s->length;
 	}
-	ret = __map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs,
-			     is_coherent);
+	ret = __map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs);
 	if (ret < 0)
 		goto bad_mapping;
 
@@ -1328,44 +1300,19 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 }
 
 /**
- * arm_coherent_iommu_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of i/o coherent buffers described by scatterlist in streaming
- * mode for DMA. The scatter gather list elements are merged together (if
- * possible) and tagged with the appropriate dma address and length. They are
- * obtained via sg_dma_{address,length}.
- */
-static int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
-}
-
-/**
- * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
+ * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
  * @dev: valid struct device pointer
  * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
+ * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
+ * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  *
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * The scatter gather list elements are merged together (if possible) and
- * tagged with the appropriate dma address and length. They are obtained via
- * sg_dma_{address,length}.
+ * Unmap a set of streaming mode DMA translations.  Again, CPU access
+ * rules concerning calls here are the same as for dma_unmap_single().
  */
-static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
-}
-
-static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir,
-		unsigned long attrs, bool is_coherent)
+static void arm_iommu_unmap_sg(struct device *dev,
+			       struct scatterlist *sg, int nents,
+			       enum dma_data_direction dir,
+			       unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -1374,47 +1321,12 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
 		if (sg_dma_len(s))
 			__iommu_remove_mapping(dev, sg_dma_address(s),
 					       sg_dma_len(s));
-		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			__dma_page_dev_to_cpu(sg_page(s), s->offset,
 					      s->length, dir);
 	}
 }
 
-/**
- * arm_coherent_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-static void arm_coherent_iommu_unmap_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
-}
-
-/**
- * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-static void arm_iommu_unmap_sg(struct device *dev,
-			       struct scatterlist *sg, int nents,
-			       enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
-}
-
 /**
  * arm_iommu_sync_sg_for_cpu
  * @dev: valid struct device pointer
@@ -1452,18 +1364,17 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 }
 
-
 /**
- * arm_coherent_iommu_map_page
+ * arm_iommu_map_page
  * @dev: valid struct device pointer
  * @page: page that buffer resides in
  * @offset: offset into page for start of buffer
  * @size: size of buffer to map
  * @dir: DMA transfer direction
  *
- * Coherent IOMMU aware version of arm_dma_map_page()
+ * IOMMU aware version of arm_dma_map_page()
  */
-static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
+static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     unsigned long attrs)
 {
@@ -1471,6 +1382,9 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	dma_addr_t dma_addr;
 	int ret, prot, len = PAGE_ALIGN(size + offset);
 
+	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		__dma_page_cpu_to_dev(page, offset, size, dir);
+
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return dma_addr;
@@ -1487,50 +1401,6 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	return DMA_MAPPING_ERROR;
 }
 
-/**
- * arm_iommu_map_page
- * @dev: valid struct device pointer
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * IOMMU aware version of arm_dma_map_page()
- */
-static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     unsigned long attrs)
-{
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_page_cpu_to_dev(page, offset, size, dir);
-
-	return arm_coherent_iommu_map_page(dev, page, offset, size, dir, attrs);
-}
-
-/**
- * arm_coherent_iommu_unmap_page
- * @dev: valid struct device pointer
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_page)
- * @dir: DMA transfer direction (same as passed to dma_map_page)
- *
- * Coherent IOMMU aware version of arm_dma_unmap_page()
- */
-static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = handle & PAGE_MASK;
-	int offset = handle & ~PAGE_MASK;
-	int len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
-}
-
 /**
  * arm_iommu_unmap_page
  * @dev: valid struct device pointer
@@ -1545,15 +1415,17 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	int offset = handle & ~PAGE_MASK;
 	int len = PAGE_ALIGN(size + offset);
 
 	if (!iova)
 		return;
 
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+		page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 		__dma_page_dev_to_cpu(page, offset, size, dir);
+	}
 
 	iommu_unmap(mapping->domain, iova, len);
 	__free_iova(mapping, iova, len);
@@ -1665,16 +1537,16 @@ static const struct dma_map_ops iommu_ops = {
 };
 
 static const struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_coherent_iommu_alloc_attrs,
-	.free		= arm_coherent_iommu_free_attrs,
-	.mmap		= arm_coherent_iommu_mmap_attrs,
+	.alloc		= arm_iommu_alloc_attrs,
+	.free		= arm_iommu_free_attrs,
+	.mmap		= arm_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
 
-	.map_page	= arm_coherent_iommu_map_page,
-	.unmap_page	= arm_coherent_iommu_unmap_page,
+	.map_page	= arm_iommu_map_page,
+	.unmap_page	= arm_iommu_unmap_page,
 
-	.map_sg		= arm_coherent_iommu_map_sg,
-	.unmap_sg	= arm_coherent_iommu_unmap_sg,
+	.map_sg		= arm_iommu_map_sg,
+	.unmap_sg	= arm_iommu_unmap_sg,
 
 	.map_resource	= arm_iommu_map_resource,
 	.unmap_resource	= arm_iommu_unmap_resource,
-- 
2.30.2

