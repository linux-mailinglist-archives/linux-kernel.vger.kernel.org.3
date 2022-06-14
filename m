Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B154AD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355390AbiFNJVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbiFNJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:21:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAED443D1;
        Tue, 14 Jun 2022 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sdZSrQc3qFVObKDwsWQEvtuuR2xVVfzvHo6J3FD7MTU=; b=aB3QlumIKeGmrZq+YG3ka60yD3
        CR/oDnEarillGJvzAWd6Lh5Vqn36oQ/xhTOvb4PwQ4/RwSS1CScCbGXTo2ZmsPrQW/TRsBDYzx6zv
        WEZm3lcwKaRILrvV+ITS3p8GuaXCCDwR16htBHUFv3QCEoXFIRNToWbj4q9JjNR/8piPnVTnz42fD
        IfOf/Q5QtLPHXRKKvHf5cDhU/V+B81sr8NOk4VUiX8IbGjWmwDuL/0hbjhiKLgkscNaGi1c8QYIAA
        p9KTwADYrZmtiMPhZSMb/YvrZ36wmQfbf3cS6SN7bFgJEsTWwTscvtKOEs5bE9eZXFkztIbGMbARa
        R2cZZhDQ==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o12jE-008fH4-VX; Tue, 14 Jun 2022 09:20:53 +0000
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
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 01/10] ARM: sa1100/assabet: move dmabounce hack to ohci driver
Date:   Tue, 14 Jun 2022 11:20:38 +0200
Message-Id: <20220614092047.572235-2-hch@lst.de>
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

From: Arnd Bergmann <arnd@arndb.de>

The sa1111 platform is one of the two remaining users of the old Arm
specific "dmabounce" code, which is an earlier implementation of the
generic swiotlb.

Linus Walleij submitted a patch that removes dmabounce support from
the ixp4xx, and I had a look at the other user, which is the sa1111
companion chip.

Looking at how dmabounce is used, I could narrow it down to one driver
one three machines:

 - dmabounce is only initialized on assabet/neponset, jornada720 and
   badge4, which are the platforms that have an sa1111 and support
   DMA on it.

 - All three of these suffer from "erratum #7" that requires only
   doing DMA to half the memory sections based on one of the address
   lines, in addition, the neponset also can't DMA to the RAM that
   is connected to sa1111 itself.

 - the pxa lubbock machine also has sa1111, but does not support DMA
   on it and does not set dmabounce.

 - only the OHCI and audio devices on sa1111 support DMA, but as
   there is no audio driver for this hardware, only OHCI remains.

In the OHCI code, I noticed that two other platforms already have
a local bounce buffer support in the form of the "local_mem"
allocator. Specifically, TMIO and SM501 use this on a few other ARM
boards with 16KB or 128KB of local SRAM that can be accessed from the
OHCI and from the CPU.

While this is not the same problem as on sa1111, I could not find a
reason why we can't re-use the existing implementation but replace the
physical SRAM address mapping with a locally allocated DMA buffer.

There are two main downsides:

 - rather than using a dynamically sized pool, this buffer needs
   to be allocated at probe time using a fixed size. Without
   having any idea of what it should be, I picked a size of
   64KB, which is between what the other two OHCI front-ends use
   in their SRAM. If anyone has a better idea what that size
   is reasonable, this can be trivially changed.

 - Previously, only USB transfers to unaddressable memory needed
   to go through the bounce buffer, now all of them do, which may
   impact runtime performance for USB endpoints that do a lot of
   transfers.

On the upside, the local_mem support uses write-combining buffers,
which should be a bit faster for transfers to the device compared to
normal uncached coherent memory as used in dmabounce.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/common/Kconfig        |  2 +-
 arch/arm/common/sa1111.c       | 64 ----------------------------------
 drivers/usb/core/hcd.c         | 17 +++++++--
 drivers/usb/host/ohci-sa1111.c | 25 +++++++++++++
 4 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index c8e198631d418..bc158fd227e12 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config SA1111
 	bool
-	select DMABOUNCE if !ARCH_PXA
+	select ZONE_DMA if ARCH_SA1100
 
 config DMABOUNCE
 	bool
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 2343e2b6214d7..f5e6990b8856b 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1389,70 +1389,9 @@ void sa1111_driver_unregister(struct sa1111_driver *driver)
 }
 EXPORT_SYMBOL(sa1111_driver_unregister);
 
-#ifdef CONFIG_DMABOUNCE
-/*
- * According to the "Intel StrongARM SA-1111 Microprocessor Companion
- * Chip Specification Update" (June 2000), erratum #7, there is a
- * significant bug in the SA1111 SDRAM shared memory controller.  If
- * an access to a region of memory above 1MB relative to the bank base,
- * it is important that address bit 10 _NOT_ be asserted. Depending
- * on the configuration of the RAM, bit 10 may correspond to one
- * of several different (processor-relative) address bits.
- *
- * This routine only identifies whether or not a given DMA address
- * is susceptible to the bug.
- *
- * This should only get called for sa1111_device types due to the
- * way we configure our device dma_masks.
- */
-static int sa1111_needs_bounce(struct device *dev, dma_addr_t addr, size_t size)
-{
-	/*
-	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
-	 * User's Guide" mentions that jumpers R51 and R52 control the
-	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
-	 * SDRAM bank 1 on Neponset). The default configuration selects
-	 * Assabet, so any address in bank 1 is necessarily invalid.
-	 */
-	return (machine_is_assabet() || machine_is_pfs168()) &&
-		(addr >= 0xc8000000 || (addr + size) >= 0xc8000000);
-}
-
-static int sa1111_notifier_call(struct notifier_block *n, unsigned long action,
-	void *data)
-{
-	struct sa1111_dev *dev = to_sa1111_device(data);
-
-	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
-		if (dev->dev.dma_mask && dev->dma_mask < 0xffffffffUL) {
-			int ret = dmabounce_register_dev(&dev->dev, 1024, 4096,
-					sa1111_needs_bounce);
-			if (ret)
-				dev_err(&dev->dev, "failed to register with dmabounce: %d\n", ret);
-		}
-		break;
-
-	case BUS_NOTIFY_DEL_DEVICE:
-		if (dev->dev.dma_mask && dev->dma_mask < 0xffffffffUL)
-			dmabounce_unregister_dev(&dev->dev);
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block sa1111_bus_notifier = {
-	.notifier_call = sa1111_notifier_call,
-};
-#endif
-
 static int __init sa1111_init(void)
 {
 	int ret = bus_register(&sa1111_bus_type);
-#ifdef CONFIG_DMABOUNCE
-	if (ret == 0)
-		bus_register_notifier(&sa1111_bus_type, &sa1111_bus_notifier);
-#endif
 	if (ret == 0)
 		platform_driver_register(&sa1111_device_driver);
 	return ret;
@@ -1461,9 +1400,6 @@ static int __init sa1111_init(void)
 static void __exit sa1111_exit(void)
 {
 	platform_driver_unregister(&sa1111_device_driver);
-#ifdef CONFIG_DMABOUNCE
-	bus_unregister_notifier(&sa1111_bus_type, &sa1111_bus_notifier);
-#endif
 	bus_unregister(&sa1111_bus_type);
 }
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 06eea8848ccc2..4db3add28b445 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1251,7 +1251,8 @@ void usb_hcd_unlink_urb_from_ep(struct usb_hcd *hcd, struct urb *urb)
 EXPORT_SYMBOL_GPL(usb_hcd_unlink_urb_from_ep);
 
 /*
- * Some usb host controllers can only perform dma using a small SRAM area.
+ * Some usb host controllers can only perform dma using a small SRAM area,
+ * or have restrictions on addressable DRAM.
  * The usb core itself is however optimized for host controllers that can dma
  * using regular system memory - like pci devices doing bus mastering.
  *
@@ -3117,8 +3118,18 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 	if (IS_ERR(hcd->localmem_pool))
 		return PTR_ERR(hcd->localmem_pool);
 
-	local_mem = devm_memremap(hcd->self.sysdev, phys_addr,
-				  size, MEMREMAP_WC);
+	/*
+	 * if a physical SRAM address was passed, map it, otherwise
+	 * allocate system memory as a buffer.
+	 */
+	if (phys_addr)
+		local_mem = devm_memremap(hcd->self.sysdev, phys_addr,
+					  size, MEMREMAP_WC);
+	else
+		local_mem = dmam_alloc_attrs(hcd->self.sysdev, size, &dma,
+					     GFP_KERNEL,
+					     DMA_ATTR_WRITE_COMBINE);
+
 	if (IS_ERR(local_mem))
 		return PTR_ERR(local_mem);
 
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index feca826d3f6a8..75c2b28b33794 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -203,6 +203,31 @@ static int ohci_hcd_sa1111_probe(struct sa1111_dev *dev)
 		goto err1;
 	}
 
+	/*
+	 * According to the "Intel StrongARM SA-1111 Microprocessor Companion
+	 * Chip Specification Update" (June 2000), erratum #7, there is a
+	 * significant bug in the SA1111 SDRAM shared memory controller.  If
+	 * an access to a region of memory above 1MB relative to the bank base,
+	 * it is important that address bit 10 _NOT_ be asserted. Depending
+	 * on the configuration of the RAM, bit 10 may correspond to one
+	 * of several different (processor-relative) address bits.
+	 *
+	 * Section 4.6 of the "Intel StrongARM SA-1111 Development Module
+	 * User's Guide" mentions that jumpers R51 and R52 control the
+	 * target of SA-1111 DMA (either SDRAM bank 0 on Assabet, or
+	 * SDRAM bank 1 on Neponset). The default configuration selects
+	 * Assabet, so any address in bank 1 is necessarily invalid.
+	 *
+	 * As a workaround, use a bounce buffer in addressable memory
+	 * as local_mem, relying on ZONE_DMA to provide an area that
+	 * fits within the above constraints.
+	 *
+	 * SZ_64K is an estimate for what size this might need.
+	 */
+	ret = usb_hcd_setup_local_mem(hcd, 0, 0, SZ_64K);
+	if (ret)
+		goto err1;
+
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
 		dev_dbg(&dev->dev, "request_mem_region failed\n");
 		ret = -EBUSY;
-- 
2.30.2

