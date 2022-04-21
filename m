Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A526509990
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386116AbiDUHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386100AbiDUHpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:45:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FE61ADA2;
        Thu, 21 Apr 2022 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eyerjtN4UYycmkKNAM3tdZGwf64zi+C+W9A6GWi36c4=; b=WbsNDy8w3wKZEEK7H26azyveqv
        SEcD2HUumBFczuN7YgKEbj0AxGHvyQnm+wHPkHWGmpUxM0KWz7x1wUGDhyG2NQGv9zSjqkgEawCas
        V1RI7StZhTiZ4jCHphXcHtCGcpD+eeMeZbmar0Zl8dndeCjRta2aITh5DzENrlomRkV+eAG6wNowj
        wCTLLE46diIlIUZJAsMr43zyPExZxSgoTzQKpdiovchPOZgb8F06lZcebOwugALz9zgNPkaa3llPZ
        A4WLuCxcpf7Ei0NrAbOHHSvnuZujnJrxy/WPe+Dx3F3eO3ymGLkBWkT22QzSOdqqvMdfYj7G90cvH
        WtOfn1ww==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhRSH-00C7Y6-A9; Thu, 21 Apr 2022 07:42:21 +0000
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
Subject: [PATCH 5/7] ARM: use dma_to_phys/phys_to_dma in the dma-mapping code
Date:   Thu, 21 Apr 2022 09:42:02 +0200
Message-Id: <20220421074204.1284072-6-hch@lst.de>
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

Use the helpers as expected by the dma-direct code in the old arm
dma-mapping code to ease a gradual switch to the common DMA code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0ee5adbdd3f1d..e09d79a328fa1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -128,14 +128,14 @@ static dma_addr_t arm_dma_map_page(struct device *dev, struct page *page,
 {
 	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_cpu_to_dev(page, offset, size, dir);
-	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
+	return phys_to_dma(dev, page_to_phys(page) + offset);
 }
 
 static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     unsigned long attrs)
 {
-	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
+	return phys_to_dma(dev, page_to_phys(page) + offset);
 }
 
 /**
@@ -156,7 +156,7 @@ static void arm_dma_unmap_page(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_page_dev_to_cpu(pfn_to_page(dma_to_pfn(dev, handle)),
+		__dma_page_dev_to_cpu(phys_to_page(dma_to_phys(dev, handle)),
 				      handle & ~PAGE_MASK, size, dir);
 }
 
@@ -164,7 +164,7 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	unsigned int offset = handle & (PAGE_SIZE - 1);
-	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
+	struct page *page = phys_to_page(dma_to_phys(dev, handle-offset));
 	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
@@ -172,7 +172,7 @@ static void arm_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
 	unsigned int offset = handle & (PAGE_SIZE - 1);
-	struct page *page = pfn_to_page(dma_to_pfn(dev, handle-offset));
+	struct page *page = phys_to_page(dma_to_phys(dev, handle-offset));
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
@@ -190,7 +190,7 @@ static int arm_dma_supported(struct device *dev, u64 mask)
 	 * Translate the device's DMA mask to a PFN limit.  This
 	 * PFN number includes the page which we can DMA to.
 	 */
-	return dma_to_pfn(dev, mask) >= max_dma_pfn;
+	return PHYS_PFN(dma_to_phys(dev, mask)) >= max_dma_pfn;
 }
 
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
@@ -681,7 +681,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (page) {
 		unsigned long flags;
 
-		*handle = pfn_to_dma(dev, page_to_pfn(page));
+		*handle = phys_to_dma(dev, page_to_phys(page));
 		buf->virt = args.want_vaddr ? addr : page;
 
 		spin_lock_irqsave(&arm_dma_bufs_lock, flags);
@@ -721,7 +721,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	int ret = -ENXIO;
 	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = dma_to_pfn(dev, dma_addr);
+	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	unsigned long off = vma->vm_pgoff;
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
@@ -762,7 +762,7 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 			   dma_addr_t handle, unsigned long attrs,
 			   bool is_coherent)
 {
-	struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
+	struct page *page = phys_to_page(dma_to_phys(dev, handle));
 	struct arm_dma_buffer *buf;
 	struct arm_dma_free_args args = {
 		.dev = dev,
@@ -796,15 +796,15 @@ static int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 unsigned long attrs)
 {
-	unsigned long pfn = dma_to_pfn(dev, handle);
+	phys_addr_t paddr = dma_to_phys(dev, handle);
 	struct page *page;
 	int ret;
 
 	/* If the PFN is not valid, we do not have a struct page */
-	if (!pfn_valid(pfn))
+	if (!pfn_valid(PHYS_PFN(paddr)))
 		return -ENXIO;
 
-	page = pfn_to_page(pfn);
+	page = phys_to_page(paddr);
 
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	if (unlikely(ret))
-- 
2.30.2

