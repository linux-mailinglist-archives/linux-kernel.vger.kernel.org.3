Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932FA5A1A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiHYUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiHYUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA7BFC43
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B79436143F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B944C433C1;
        Thu, 25 Aug 2022 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661458551;
        bh=/8sQaHG9G3ItLNCkXGNgZ4soESrqs9Ui7jD27ofAhyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCRYwcjwfTz9QQusWhQPBKuEUX/Q2I/E36anNYB52bD22RwnHAE6CAPb87CAhYakc
         YQ8eHJlNmBAcdmbvsf8+Z8emkb4K2GTZnKzZHPvmYHds9aOCQ4VJ8w2aAiZRsT5wi6
         4mLDCSX2EiwUiXe/ZOYJFcb+dp6RpAH8w5hg6HrDtc5+jlcZXwxY72nbZR9+8ILvbz
         jtFZyqSuFFKzMP9LYToMgoh12aRWYjlVZofS/F6T0vGA0PLq1N259c2HdIMyD4/U6v
         8KW+KX+Gy9tMDhV+aQ0EFlaE/esklo9fxDYfrM5VU5Grw9SvlDX3+DvzF0QDCbRBRN
         OwA/shFy7vYSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 5/4] ARM: footbridge: remove custom DMA address handling
Date:   Thu, 25 Aug 2022 22:15:44 +0200
Message-Id: <20220825201544.1931658-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220821055326.GA25950@lst.de>
References: <20220821055326.GA25950@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Footbridge is the last Arm platform that has its own
__virt_to_bus()/__bus_to_virt()/phys_to_dma()/dma_to_phys() abstraction,
but this is just a simple offset now.

For PCI devices, the offset that is programmed into the PCI bridge must
also be set in each device using dma_direct_set_offset().  As Arm does
not have a pcibios_bus_add_device() helper yet, just use a bus notifier
for this.

For the ISA DMA, drivers now pass a non-translated physical address into
set_dma_addr(), so they have to be converted back with the corresponding
isa_bus_to_virt() function and then into the correct bus address with
the offset using the isa_dma_dev.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix ISA DMA offset

 arch/arm/include/asm/dma-direct.h             |  1 -
 arch/arm/include/asm/dma.h                    |  2 +-
 arch/arm/include/asm/hardware/dec21285.h      |  7 +++++++
 arch/arm/include/asm/memory.h                 | 11 ----------
 arch/arm/mach-footbridge/Kconfig              |  1 -
 arch/arm/mach-footbridge/common.c             | 10 ---------
 arch/arm/mach-footbridge/dc21285.c            | 21 ++++++++++++++++++-
 arch/arm/mach-footbridge/dma-isa.c            |  4 ++++
 .../mach-footbridge/include/mach/dma-direct.h |  8 -------
 .../arm/mach-footbridge/include/mach/memory.h |  9 --------
 10 files changed, 32 insertions(+), 42 deletions(-)
 delete mode 100644 arch/arm/include/asm/dma-direct.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/dma-direct.h

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
deleted file mode 100644
index 4f7bcde03abb..000000000000
--- a/arch/arm/include/asm/dma-direct.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <mach/dma-direct.h>
diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index 05f29a72150b..c6aded1b069c 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -106,7 +106,7 @@ extern void set_dma_sg(unsigned int chan, struct scatterlist *sg, int nr_sg);
  */
 extern void __set_dma_addr(unsigned int chan, void *addr);
 #define set_dma_addr(chan, addr)				\
-	__set_dma_addr(chan, (void *)__bus_to_virt(addr))
+	__set_dma_addr(chan, (void *)isa_bus_to_virt(addr))
 
 /* Set the DMA byte count for this channel
  *
diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/include/asm/hardware/dec21285.h
index eee390e8d4dc..894f2a635cbb 100644
--- a/arch/arm/include/asm/hardware/dec21285.h
+++ b/arch/arm/include/asm/hardware/dec21285.h
@@ -22,6 +22,13 @@
 #define DC21285_IO(x)		(x)
 #endif
 
+/*
+ * The footbridge is programmed to expose the system RAM at 0xe0000000.
+ * The requirement is that the RAM isn't placed at bus address 0, which
+ * would clash with VGA cards.
+ */
+#define BUS_OFFSET 0xe0000000
+
 #define CSR_PCICMD		DC21285_IO(0x0004)
 #define CSR_CLASSREV		DC21285_IO(0x0008)
 #define CSR_PCICACHELINESIZE	DC21285_IO(0x000c)
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index a55a9038abc8..d8eef4bd8c71 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -369,17 +369,6 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
 
 #define virt_to_idmap(x)	__virt_to_idmap((unsigned long)(x))
 
-/*
- * Virtual <-> DMA view memory address translations
- * Again, these are *only* valid on the kernel direct mapped RAM
- * memory.  Use of these is *deprecated* (and that doesn't mean
- * use the __ prefixed forms instead.)  See dma-mapping.h.
- */
-#ifndef __virt_to_bus
-#define __virt_to_bus	__virt_to_phys
-#define __bus_to_virt	__phys_to_virt
-#endif
-
 /*
  * Conversion between a struct page and a physical address.
  *
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index cd18871fd03f..f452663576d1 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -44,7 +44,6 @@ endmenu
 # Footbridge support
 config FOOTBRIDGE
 	def_bool y
-	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ISA_DMA_API
 
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 9483eccea5ae..629e4676ed77 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -281,13 +281,3 @@ void footbridge_restart(enum reboot_mode mode, const char *cmd)
 		*CSR_SA110_CNTL |= (1 << 13);
 	}
 }
-
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	return paddr + (BUS_OFFSET - PHYS_OFFSET);
-}
-
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
-{
-	return dev_addr - (BUS_OFFSET - PHYS_OFFSET);
-}
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index 372600bc15c8..f8920d0010de 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1998-2001 Russell King
  *  Copyright (C) 1998-2000 Phil Blundell
  */
+#include <linux/dma-map-ops.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
@@ -241,6 +242,22 @@ static irqreturn_t dc21285_parity_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int dc21285_pci_bus_notifier(struct notifier_block *nb,
+				    unsigned long action,
+				    void *data)
+{
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	dma_direct_set_offset(data, PHYS_OFFSET, BUS_OFFSET, SZ_256M);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dc21285_pci_bus_nb = {
+	.notifier_call = dc21285_pci_bus_notifier,
+};
+
 int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 {
 	struct resource *res;
@@ -266,6 +283,8 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 	pci_add_resource_offset(&sys->resources, &res[0], sys->mem_offset);
 	pci_add_resource_offset(&sys->resources, &res[1], sys->mem_offset);
 
+	bus_register_notifier(&pci_bus_type, &dc21285_pci_bus_nb);
+
 	return 1;
 }
 
@@ -329,7 +348,7 @@ void __init dc21285_preinit(void)
 	 */
 	*CSR_PCICSRBASE       = 0xf4000000;
 	*CSR_PCICSRIOBASE     = 0;
-	*CSR_PCISDRAMBASE     = __virt_to_bus(PAGE_OFFSET);
+	*CSR_PCISDRAMBASE     = BUS_OFFSET;
 	*CSR_PCIROMBASE       = 0;
 	*CSR_PCICMD = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
 		      PCI_COMMAND_INVALIDATE | PCICMD_ERROR_BITS;
diff --git a/arch/arm/mach-footbridge/dma-isa.c b/arch/arm/mach-footbridge/dma-isa.c
index 0fc0705fd58b..937f5376d5e7 100644
--- a/arch/arm/mach-footbridge/dma-isa.c
+++ b/arch/arm/mach-footbridge/dma-isa.c
@@ -11,6 +11,7 @@
  *   arch/arm/kernel/dma-ebsa285.c
  *   Copyright (C) 1998 Phil Blundell
  */
+#include <linux/dma-map-ops.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
@@ -18,6 +19,7 @@
 
 #include <asm/dma.h>
 #include <asm/mach/dma.h>
+#include <asm/hardware/dec21285.h>
 
 #define ISA_DMA_MASK		0
 #define ISA_DMA_MODE		1
@@ -221,6 +223,8 @@ static int __init isa_dma_init(void)
 		request_dma(DMA_ISA_CASCADE, "cascade");
 	}
 
+	dma_direct_set_offset(&isa_dma_dev, PHYS_OFFSET, BUS_OFFSET, SZ_256M);
+
 	return 0;
 }
 core_initcall(isa_dma_init);
diff --git a/arch/arm/mach-footbridge/include/mach/dma-direct.h b/arch/arm/mach-footbridge/include/mach/dma-direct.h
deleted file mode 100644
index 01f9e8367c00..000000000000
--- a/arch/arm/mach-footbridge/include/mach/dma-direct.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef MACH_FOOTBRIDGE_DMA_DIRECT_H
-#define MACH_FOOTBRIDGE_DMA_DIRECT_H 1
-
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr);
-
-#endif /* MACH_FOOTBRIDGE_DMA_DIRECT_H */
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 8f0ca8e8b37e..9516877667d7 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -16,15 +16,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-/*
- * The footbridge is programmed to expose the system RAM at 0xe0000000.
- * The requirement is that the RAM isn't placed at bus address 0, which
- * would clash with VGA cards.
- */
-#define BUS_OFFSET		0xe0000000
-#define __virt_to_bus(x)	((x) + (BUS_OFFSET - PAGE_OFFSET))
-#define __bus_to_virt(x)	((x) - (BUS_OFFSET - PAGE_OFFSET))
-
 /*
  * Cache flushing area.
  */
-- 
2.29.2

