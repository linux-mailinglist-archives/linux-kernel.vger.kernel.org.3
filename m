Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E614A54AD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355517AbiFNJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355514AbiFNJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DA8443EA;
        Tue, 14 Jun 2022 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+EyUK3dKswXrlm11sruY7rScrZafjFDT3g4fWhHAhqE=; b=WUzsoSQwT+/C2bBO10G0NZPwkY
        WwaxZvCCbEutMfgYrywJ3HTvHULmmPmYULh5dc9QIxhrRb5nBsJl0+SteM1DBHCt3H/2aiyxJBrlb
        h22n73BkU3hBeYiCWkstSTuOdXf+m1qL7mcv0RCjV2PQyzPNLUs/oGlXScmxpRixyxxGmGq/LDIBU
        Lk3NTeMSwkRz09h/57MsI/JSupKQzeIOclSox4vDgI5kR5dciHY620b3XeWdKWzhtDh/XfLZjJagf
        oF4Y7WSiToqBl2uu28sg/wNDSZYrOG/q4Yiz6TvrSerX/7gFcyZBQ4jkmk8QNDEXCIQ95Vfsp6zFC
        N6Tb0N3Q==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12jf-008fUj-QZ; Tue, 14 Jun 2022 09:21:20 +0000
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
Subject: [PATCH 10/10] ARM/dma-mapping: merge IOMMU ops
Date:   Tue, 14 Jun 2022 11:20:47 +0200
Message-Id: <20220614092047.572235-11-hch@lst.de>
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

The dma_sync_* operations are now the only difference between the
coherent and non-coherent IOMMU ops. Some minor tweaks to make those
safe for coherent devices with minimal overhead, and we can condense
down to a single set of DMA ops.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e7ccf7c82e025..e68d1d2ac4be0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1341,6 +1341,9 @@ static void arm_iommu_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
+	if (dev->dma_coherent)
+		return;
+
 	for_each_sg(sg, s, nents, i)
 		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
 
@@ -1360,6 +1363,9 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
+	if (dev->dma_coherent)
+		return;
+
 	for_each_sg(sg, s, nents, i)
 		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 }
@@ -1493,12 +1499,13 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
 
-	if (!iova)
+	if (dev->dma_coherent || !iova)
 		return;
 
+	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
@@ -1507,12 +1514,13 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
 
-	if (!iova)
+	if (dev->dma_coherent || !iova)
 		return;
 
+	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
@@ -1536,22 +1544,6 @@ static const struct dma_map_ops iommu_ops = {
 	.unmap_resource		= arm_iommu_unmap_resource,
 };
 
-static const struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
-	.free		= arm_iommu_free_attrs,
-	.mmap		= arm_iommu_mmap_attrs,
-	.get_sgtable	= arm_iommu_get_sgtable,
-
-	.map_page	= arm_iommu_map_page,
-	.unmap_page	= arm_iommu_unmap_page,
-
-	.map_sg		= arm_iommu_map_sg,
-	.unmap_sg	= arm_iommu_unmap_sg,
-
-	.map_resource	= arm_iommu_map_resource,
-	.unmap_resource	= arm_iommu_unmap_resource,
-};
-
 /**
  * arm_iommu_create_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
@@ -1750,10 +1742,7 @@ static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		return;
 	}
 
-	if (coherent)
-		set_dma_ops(dev, &iommu_coherent_ops);
-	else
-		set_dma_ops(dev, &iommu_ops);
+	set_dma_ops(dev, &iommu_ops);
 }
 
 static void arm_teardown_iommu_dma_ops(struct device *dev)
-- 
2.30.2

