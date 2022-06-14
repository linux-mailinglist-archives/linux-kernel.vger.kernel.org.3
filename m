Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85E54AD37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356004AbiFNJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355178AbiFNJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E665443D1;
        Tue, 14 Jun 2022 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IVezd8mDdYb1LuqmIhqtY0Z/b1tOvjwKWsbT4tZL/ho=; b=zONp1da9Pjb0Y4y8qkYC1Gua5c
        C072ikA9tOaoAJvwQtHvSqtWo+Y6RQ4xnTnANKyOcTSW1i/i9HSpuyOCx8109ex5W/ZKx5YFjqLa9
        n+YqkTv4ezYHsn6J2iuQF6OtjMM7Si9r/MGSibiJu8AqaR2hev8jVkfQpdk/8l644vPihLtbaKzBr
        gnDqHEaPJRfPvv3UGUZUGWA+qZ+iWle5mMwV1swnQJ1CRPU/TXoUflIw1WAWP7X2lWGAOZ4HcgyiG
        X28RfHWHCOmuAH7BlcEgQidT0Mvcak0X27etPKnovDl1lPGwwefh/8IbrZdrzAkM+bfmjIFNHOXFd
        W1xe454w==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12jT-008fNj-QL; Tue, 14 Jun 2022 09:21:08 +0000
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
        linux-usb@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 06/10] ARM/dma-mapping: use the generic versions of dma_to_phys/phys_to_dma by default
Date:   Tue, 14 Jun 2022 11:20:43 +0200
Message-Id: <20220614092047.572235-7-hch@lst.de>
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

Only the footbridge platforms provide their own DMA address translation
helpers, so switch to the generic version for all other platforms, and
consolidate the footbridge implementation to remove two levels of
indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig                              |  1 -
 arch/arm/include/asm/dma-direct.h             | 41 +------------------
 arch/arm/include/asm/memory.h                 |  2 -
 arch/arm/mach-footbridge/Kconfig              |  1 +
 arch/arm/mach-footbridge/common.c             | 19 +++++----
 .../mach-footbridge/include/mach/dma-direct.h |  8 ++++
 .../arm/mach-footbridge/include/mach/memory.h |  4 --
 7 files changed, 21 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-footbridge/include/mach/dma-direct.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6ccc..cd67e359958cb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,7 +15,6 @@ config ARM
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
-	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 6fd52713b5d12..4f7bcde03abb5 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -1,40 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASM_ARM_DMA_DIRECT_H
-#define ASM_ARM_DMA_DIRECT_H 1
-
-#include <asm/memory.h>
-
-/*
- * dma_to_pfn/pfn_to_dma are architecture private
- * functions used internally by the DMA-mapping API to provide DMA
- * addresses. They must not be used by drivers.
- */
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	if (dev && dev->dma_range_map)
-		pfn = PFN_DOWN(translate_phys_to_dma(dev, PFN_PHYS(pfn)));
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	unsigned long pfn = __bus_to_pfn(addr);
-
-	if (dev && dev->dma_range_map)
-		pfn = PFN_DOWN(translate_dma_to_phys(dev, PFN_PHYS(pfn)));
-	return pfn;
-}
-
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	unsigned int offset = paddr & ~PAGE_MASK;
-	return pfn_to_dma(dev, __phys_to_pfn(paddr)) + offset;
-}
-
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
-{
-	unsigned int offset = dev_addr & ~PAGE_MASK;
-	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
-}
-
-#endif /* ASM_ARM_DMA_DIRECT_H */
+#include <mach/dma-direct.h>
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index f673e13e0f942..a55a9038abc89 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -378,8 +378,6 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
 #ifndef __virt_to_bus
 #define __virt_to_bus	__virt_to_phys
 #define __bus_to_virt	__phys_to_virt
-#define __pfn_to_bus(x)	__pfn_to_phys(x)
-#define __bus_to_pfn(x)	__phys_to_pfn(x)
 #endif
 
 /*
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 728aff93fba9d..b5bbdcf2e4896 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -60,6 +60,7 @@ endmenu
 
 # Footbridge support
 config FOOTBRIDGE
+	select ARCH_HAS_PHYS_TO_DMA
 	bool
 
 # Footbridge in host mode
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 322495df271d5..5020eb96b025d 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <linux/dma-direct.h>
 #include <video/vga.h>
 
 #include <asm/page.h>
@@ -335,17 +336,19 @@ unsigned long __bus_to_virt(unsigned long res)
 	return res;
 }
 EXPORT_SYMBOL(__bus_to_virt);
-
-unsigned long __pfn_to_bus(unsigned long pfn)
+#else
+static inline unsigned long fb_bus_sdram_offset(void)
 {
-	return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET);
+	return BUS_OFFSET;
 }
-EXPORT_SYMBOL(__pfn_to_bus);
+#endif /* CONFIG_FOOTBRIDGE_ADDIN */
 
-unsigned long __bus_to_pfn(unsigned long bus)
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return __phys_to_pfn(bus - (fb_bus_sdram_offset() - PHYS_OFFSET));
+	return paddr + (fb_bus_sdram_offset() - PHYS_OFFSET);
 }
-EXPORT_SYMBOL(__bus_to_pfn);
 
-#endif
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	return dev_addr - (fb_bus_sdram_offset() - PHYS_OFFSET);
+}
diff --git a/arch/arm/mach-footbridge/include/mach/dma-direct.h b/arch/arm/mach-footbridge/include/mach/dma-direct.h
new file mode 100644
index 0000000000000..01f9e8367c009
--- /dev/null
+++ b/arch/arm/mach-footbridge/include/mach/dma-direct.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MACH_FOOTBRIDGE_DMA_DIRECT_H
+#define MACH_FOOTBRIDGE_DMA_DIRECT_H 1
+
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr);
+
+#endif /* MACH_FOOTBRIDGE_DMA_DIRECT_H */
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 46fd4a8872b9a..3a5d2638c18f8 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -26,8 +26,6 @@
 #ifndef __ASSEMBLY__
 extern unsigned long __virt_to_bus(unsigned long);
 extern unsigned long __bus_to_virt(unsigned long);
-extern unsigned long __pfn_to_bus(unsigned long);
-extern unsigned long __bus_to_pfn(unsigned long);
 #endif
 #define __virt_to_bus	__virt_to_bus
 #define __bus_to_virt	__bus_to_virt
@@ -42,8 +40,6 @@ extern unsigned long __bus_to_pfn(unsigned long);
 #define BUS_OFFSET		0xe0000000
 #define __virt_to_bus(x)	((x) + (BUS_OFFSET - PAGE_OFFSET))
 #define __bus_to_virt(x)	((x) - (BUS_OFFSET - PAGE_OFFSET))
-#define __pfn_to_bus(x)		(__pfn_to_phys(x) + (BUS_OFFSET - PHYS_OFFSET))
-#define __bus_to_pfn(x)		__phys_to_pfn((x) - (BUS_OFFSET - PHYS_OFFSET))
 
 #else
 
-- 
2.30.2

