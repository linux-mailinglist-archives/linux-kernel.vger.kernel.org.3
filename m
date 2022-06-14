Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4754AD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356038AbiFNJVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355212AbiFNJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C9443D1;
        Tue, 14 Jun 2022 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xvhbBJhULwcSTCX2LQgOhY6hVQNYWx3xEqylfnNwsR8=; b=A7OlzOM9cbfkwjlmAAPe5Aa2M3
        oNQkIgk4pOc5VgoKvygadWlqgPPInU/T72IlnBjQ0YONSvVAlfXSbJk9Vk9PNwUisydNy7h2UwCcF
        nSIDEH8u+cPqEyjGijnfvrIoYeiOKc5syKzsF1lszUpDmdX3xw7GI8INLYpPpzncFuM2r4UtrIvO4
        76wCJKBFBWngPd303NHpYkUiOCttYpJdtc6rLV7h7rjHG1QbdSbNlokXb4hOhvN7LyppY4F3pykn+
        /+AQUFOSelHz/moEqeeN1P07KbymCDq9JvV5GOLbt0dOvf5zdFw6PFqiAZoMeArpXRy9UylYPkoJs
        HcM9GN/A==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12jZ-008fR7-SO; Tue, 14 Jun 2022 09:21:14 +0000
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
Subject: [PATCH 08/10] ARM/dma-mapping: drop .dma_supported for IOMMU ops
Date:   Tue, 14 Jun 2022 11:20:45 +0200
Message-Id: <20220614092047.572235-9-hch@lst.de>
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

When an IOMMU is present, we trust that it should be capable
of remapping any physical memory, and since the device masks
represent the input (virtual) addresses to the IOMMU it makes
no sense to validate them against physical PFNs anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ceb56928d01ec..4055f2dc2859e 100644
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

