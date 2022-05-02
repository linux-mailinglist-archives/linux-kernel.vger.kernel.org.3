Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9287A5174D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355456AbiEBQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386348AbiEBQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:47:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E642AE6A;
        Mon,  2 May 2022 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N3YfqcrpWPA/aWWGMBjrHMs86p3ogBc5EBElI++AnZM=; b=AQR6spDhSgDXPKM7l/7irqdi4Y
        DgkvkXxoW16ZGYTmpEdYY6RmtgTVx6A9UlA2H/5UQpZdRCFEeE3oHmj9a9JUq11zfnivLSYkwa2/O
        l/IDe+85ty2XwazkPA6sgQl6lpUiJ15dAxgLgN0pF0fPbZ8ULJpmnARpMMYdbyMlL3AeCbCkBBeir
        52EejCvhe+59kfqAjCuNOquFV2L6udqs1LRLWVV+D8m0dIjKwpC6xYxkOpHnxtH4bO2KoGNpFVsVd
        /cAORKoL9nXEWy3itxyT2+ExVAlPw6DKjjeZdUiaLzEXCJ6cqAGNklzIRUW+vFTNopAOl9F8ToBxS
        M1UYb2dw==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlZ97-001kfv-WA; Mon, 02 May 2022 16:43:38 +0000
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
Subject: [PATCH 08/10] ARM/dma-mapping: drop .dma_supported for IOMMU ops
Date:   Mon,  2 May 2022 09:43:28 -0700
Message-Id: <20220502164330.229685-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502164330.229685-1-hch@lst.de>
References: <20220502164330.229685-1-hch@lst.de>
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

From: Robin Murphy <robin.murphy@arm.com>

When an IOMMU is present, we trust that it should be capable
of remapping any physical memory, and since the device masks
represent the input (virtual) addresses to the IOMMU it makes
no sense to validate them against physical PFNs anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0f76222cbcbb9..6b0095b84a581 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -104,25 +104,6 @@ static struct arm_dma_buffer *arm_dma_buffer_find(void *virt)
  *
  */
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask
- * to this function.
- */
-static int arm_dma_supported(struct device *dev, u64 mask)
-{
-	unsigned long max_dma_pfn = min(max_pfn - 1, arm_dma_pfn_limit);
-
-	/*
-	 * Translate the device's DMA mask to a PFN limit.  This
-	 * PFN number includes the page which we can DMA to.
-	 */
-	return PHYS_PFN(dma_to_phys(dev, mask)) >= max_dma_pfn;
-}
-#endif
-
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
 	/*
@@ -1681,8 +1662,6 @@ static const struct dma_map_ops iommu_ops = {
 
 	.map_resource		= arm_iommu_map_resource,
 	.unmap_resource		= arm_iommu_unmap_resource,
-
-	.dma_supported		= arm_dma_supported,
 };
 
 static const struct dma_map_ops iommu_coherent_ops = {
@@ -1699,8 +1678,6 @@ static const struct dma_map_ops iommu_coherent_ops = {
 
 	.map_resource	= arm_iommu_map_resource,
 	.unmap_resource	= arm_iommu_unmap_resource,
-
-	.dma_supported		= arm_dma_supported,
 };
 
 /**
-- 
2.30.2

