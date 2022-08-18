Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71C598F63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347094AbiHRVX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346801AbiHRVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:23:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332166123
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19BAAB82413
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248ACC433B5;
        Thu, 18 Aug 2022 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660857361;
        bh=1bSqISasPZGY6PvxNAo+nr0qFPcX9eKhG4TNgnhRS9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PW9vLXltNA8LV9fjGJLpxAfQNqkCvJOsyKIZLtF8p/pHS92NtJI21A/+rCX1G679v
         jqDWvhklqxfmr/rEpw2x1/ugJX2W3gaZkdQV+4xrg55tl79aweQ3BcPZ80NleG7BQl
         UAe51YCgtLYQOp+cTnR2KEnTWRkF+S/h6WNYAOBI4CaYUsIIIoDP1A/6PHCukgDh0P
         czBFKIjBIwi7Xd+w7a+quoN5hG9JyjfQSjRr+ycTNOlbzPVlv8AYcsVf6YKCJgXvfS
         ZJgkonO6CW7XRlY0oFRh6HYszzv8OXsLBMpbFDuzqypY/NhCO6K4o+sWy70e3TqOTL
         he/WY/hh07u4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 1/4] ARM: footbridge: remove addin mode
Date:   Thu, 18 Aug 2022 23:15:47 +0200
Message-Id: <20220818211550.3272321-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818211550.3272321-1-arnd@kernel.org>
References: <20220818211550.3272321-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This does not appear to have been used in many years, we can
kill off some of the uglier code.

Among other things, it avoids a randconfig issue when both modes
are disabled:

arch/arm/mach-footbridge/common.c:149:24: error: 'ebsa285_host_io_desc' defined but not used [-Werror=unused-variable]
  149 | static struct map_desc ebsa285_host_io_desc[] __initdata = {
      |                        ^~~~~~~~~~~~~~~~~~~~
arch/arm/mach-footbridge/common.c:136:24: error: 'fb_common_io_desc' defined but not used [-Werror=unused-variable]
  136 | static struct map_desc fb_common_io_desc[] __initdata = {
      |                        ^~~~~~~~~~~~~~~~~

The recently added phys_to_dma() functions are now trivial and
could probably be removed again as a follow-up, if anyone knows
how.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/hardware/dec21285.h      | 13 ----
 arch/arm/mach-footbridge/Kconfig              | 28 +------
 arch/arm/mach-footbridge/Makefile             |  2 +-
 arch/arm/mach-footbridge/common.c             | 73 ++-----------------
 arch/arm/mach-footbridge/dc21285.c            | 61 +++++-----------
 arch/arm/mach-footbridge/dma.c                |  3 +-
 .../arm/mach-footbridge/include/mach/memory.h | 22 ------
 arch/arm/mach-footbridge/isa.c                |  3 -
 8 files changed, 30 insertions(+), 175 deletions(-)

diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/include/asm/hardware/dec21285.h
index 3f18a56a025d..eee390e8d4dc 100644
--- a/arch/arm/include/asm/hardware/dec21285.h
+++ b/arch/arm/include/asm/hardware/dec21285.h
@@ -81,19 +81,6 @@
 #define SA110_CNTL_XCSDIR(x)		((x)<<28)
 #define SA110_CNTL_PCICFN		(1 << 31)
 
-/*
- * footbridge_cfn_mode() is used when we want
- * to check whether we are the central function
- */
-#define __footbridge_cfn_mode() (*CSR_SA110_CNTL & SA110_CNTL_PCICFN)
-#if defined(CONFIG_FOOTBRIDGE_HOST) && defined(CONFIG_FOOTBRIDGE_ADDIN)
-#define footbridge_cfn_mode() __footbridge_cfn_mode()
-#elif defined(CONFIG_FOOTBRIDGE_HOST)
-#define footbridge_cfn_mode() (1)
-#else
-#define footbridge_cfn_mode() (0)
-#endif
-
 #define CSR_PCIADDR_EXTN	DC21285_IO(0x0140)
 #define CSR_PREFETCHMEMRANGE	DC21285_IO(0x0144)
 #define CSR_XBUS_CYCLE		DC21285_IO(0x0148)
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index acc10b1caa69..3497ea8e91e3 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -8,31 +8,17 @@ config ARCH_CATS
 	depends on UNUSED_BOARD_FILES
 	select CLKEVT_I8253
 	select CLKSRC_I8253
-	select FOOTBRIDGE_HOST
 	select ISA
-	select ISA_DMA
 	select FORCE_PCI
 	help
 	  Say Y here if you intend to run this kernel on the CATS.
 
 	  Saying N will reduce the size of the Footbridge kernel.
 
-config ARCH_EBSA285_ADDIN
-	bool "EBSA285 (addin mode)"
-	select ARCH_EBSA285
-	select FOOTBRIDGE_ADDIN
-	help
-	  Say Y here if you intend to run this kernel on the EBSA285 card
-	  in addin mode.
-
-	  Saying N will reduce the size of the Footbridge kernel.
-
 config ARCH_EBSA285_HOST
 	bool "EBSA285 (host mode)"
 	select ARCH_EBSA285
-	select FOOTBRIDGE_HOST
 	select ISA
-	select ISA_DMA
 	select ARCH_MAY_HAVE_PC_FDC
 	select FORCE_PCI
 	help
@@ -45,9 +31,7 @@ config ARCH_NETWINDER
 	bool "NetWinder"
 	select CLKEVT_I8253
 	select CLKSRC_I8253
-	select FOOTBRIDGE_HOST
 	select ISA
-	select ISA_DMA
 	select FORCE_PCI
 	help
 	  Say Y here if you intend to run this kernel on the Rebel.COM
@@ -61,19 +45,11 @@ endmenu
 
 # Footbridge support
 config FOOTBRIDGE
+	def_bool y
 	select ARCH_HAS_PHYS_TO_DMA
-	bool
-
-# Footbridge in host mode
-config FOOTBRIDGE_HOST
-	bool
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ISA_DMA
 
-# Footbridge in addin mode
-config FOOTBRIDGE_ADDIN
-	bool
-
-# EBSA285 board in either host or addin mode
 config ARCH_EBSA285
 	bool
 
diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 6262993c0555..30bae6684dce 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -9,7 +9,7 @@ obj-y			:= common.o dma.o isa-irq.o
 
 pci-y			+= dc21285.o
 pci-$(CONFIG_ARCH_CATS) += cats-pci.o
-pci-$(CONFIG_ARCH_EBSA285_HOST) += ebsa285-pci.o
+pci-$(CONFIG_ARCH_EBSA285) += ebsa285-pci.o
 pci-$(CONFIG_ARCH_NETWINDER) += netwinder-pci.o
 
 obj-$(CONFIG_ARCH_CATS) += cats-hw.o isa-timer.o
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 5020eb96b025..9483eccea5ae 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -198,9 +198,6 @@ void __init footbridge_init_irq(void)
 
 	__fb_init_irq();
 
-	if (!footbridge_cfn_mode())
-		return;
-
 	if (machine_is_ebsa285())
 		/* The following is dependent on which slot
 		 * you plug the Southbridge card into.  We
@@ -221,21 +218,13 @@ void __init footbridge_init_irq(void)
  * commented out since there is a "No Fix" problem with it.  Not mapping
  * it means that we have extra bullet protection on our feet.
  */
-static struct map_desc fb_common_io_desc[] __initdata = {
+static struct map_desc ebsa285_host_io_desc[] __initdata = {
 	{
 		.virtual	= ARMCSR_BASE,
 		.pfn		= __phys_to_pfn(DC21285_ARMCSR_BASE),
 		.length		= ARMCSR_SIZE,
 		.type		= MT_DEVICE,
-	}
-};
-
-/*
- * The mapping when the footbridge is in host mode.  We don't map any of
- * this when we are in add-in mode.
- */
-static struct map_desc ebsa285_host_io_desc[] __initdata = {
-#if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_FOOTBRIDGE_HOST)
+	},
 	{
 		.virtual	= PCIMEM_BASE,
 		.pfn		= __phys_to_pfn(DC21285_PCI_MEM),
@@ -257,26 +246,12 @@ static struct map_desc ebsa285_host_io_desc[] __initdata = {
 		.length		= PCIIACK_SIZE,
 		.type		= MT_DEVICE,
 	},
-#endif
 };
 
 void __init footbridge_map_io(void)
 {
-	/*
-	 * Set up the common mapping first; we need this to
-	 * determine whether we're in host mode or not.
-	 */
-	iotable_init(fb_common_io_desc, ARRAY_SIZE(fb_common_io_desc));
-
-	/*
-	 * Now, work out what we've got to map in addition on this
-	 * platform.
-	 */
-	if (footbridge_cfn_mode()) {
-		iotable_init(ebsa285_host_io_desc, ARRAY_SIZE(ebsa285_host_io_desc));
-		pci_map_io_early(__phys_to_pfn(DC21285_PCI_IO));
-	}
-
+	iotable_init(ebsa285_host_io_desc, ARRAY_SIZE(ebsa285_host_io_desc));
+	pci_map_io_early(__phys_to_pfn(DC21285_PCI_IO));
 	vga_base = PCIMEM_BASE;
 }
 
@@ -307,48 +282,12 @@ void footbridge_restart(enum reboot_mode mode, const char *cmd)
 	}
 }
 
-#ifdef CONFIG_FOOTBRIDGE_ADDIN
-
-static inline unsigned long fb_bus_sdram_offset(void)
-{
-	return *CSR_PCISDRAMBASE & 0xfffffff0;
-}
-
-/*
- * These two functions convert virtual addresses to PCI addresses and PCI
- * addresses to virtual addresses.  Note that it is only legal to use these
- * on memory obtained via get_zeroed_page or kmalloc.
- */
-unsigned long __virt_to_bus(unsigned long res)
-{
-	WARN_ON(res < PAGE_OFFSET || res >= (unsigned long)high_memory);
-
-	return res + (fb_bus_sdram_offset() - PAGE_OFFSET);
-}
-EXPORT_SYMBOL(__virt_to_bus);
-
-unsigned long __bus_to_virt(unsigned long res)
-{
-	res = res - (fb_bus_sdram_offset() - PAGE_OFFSET);
-
-	WARN_ON(res < PAGE_OFFSET || res >= (unsigned long)high_memory);
-
-	return res;
-}
-EXPORT_SYMBOL(__bus_to_virt);
-#else
-static inline unsigned long fb_bus_sdram_offset(void)
-{
-	return BUS_OFFSET;
-}
-#endif /* CONFIG_FOOTBRIDGE_ADDIN */
-
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return paddr + (fb_bus_sdram_offset() - PHYS_OFFSET);
+	return paddr + (BUS_OFFSET - PHYS_OFFSET);
 }
 
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
-	return dev_addr - (fb_bus_sdram_offset() - PHYS_OFFSET);
+	return dev_addr - (BUS_OFFSET - PHYS_OFFSET);
 }
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index f9713dc561cf..372600bc15c8 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -245,9 +245,6 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 {
 	struct resource *res;
 
-	if (nr || !footbridge_cfn_mode())
-		return 0;
-
 	res = kcalloc(2, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		printk("out of memory for root bus resources");
@@ -278,7 +275,6 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 void __init dc21285_preinit(void)
 {
 	unsigned int mem_size, mem_mask;
-	int cfn_mode;
 
 	pcibios_min_mem = 0x81000000;
 
@@ -298,21 +294,15 @@ void __init dc21285_preinit(void)
 	*CSR_CSRBASEOFFSET    = 0;
 	*CSR_PCIADDR_EXTN     = 0;
 
-	cfn_mode = __footbridge_cfn_mode();
-
 	printk(KERN_INFO "PCI: DC21285 footbridge, revision %02lX, in "
-		"%s mode\n", *CSR_CLASSREV & 0xff, cfn_mode ?
-		"central function" : "addin");
-
-	if (footbridge_cfn_mode()) {
-		/*
-		 * Clear any existing errors - we aren't
-		 * interested in historical data...
-		 */
-		*CSR_SA110_CNTL	= (*CSR_SA110_CNTL & 0xffffde07) |
-				  SA110_CNTL_RXSERR;
-		*CSR_PCICMD = (*CSR_PCICMD & 0xffff) | PCICMD_ERROR_BITS;
-	}
+		"central function mode\n", *CSR_CLASSREV & 0xff);
+
+	/*
+	 * Clear any existing errors - we aren't
+	 * interested in historical data...
+	 */
+	*CSR_SA110_CNTL	= (*CSR_SA110_CNTL & 0xffffde07) | SA110_CNTL_RXSERR;
+	*CSR_PCICMD = (*CSR_PCICMD & 0xffff) | PCICMD_ERROR_BITS;
 
 	timer_setup(&serr_timer, dc21285_enable_error, 0);
 	timer_setup(&perr_timer, dc21285_enable_error, 0);
@@ -331,29 +321,18 @@ void __init dc21285_preinit(void)
 	dc21285_request_irq(IRQ_PCI_DPERR, dc21285_dparity_irq, 0,
 			    "PCI data parity", NULL);
 
-	if (cfn_mode) {
-		/*
-		 * Map our SDRAM at a known address in PCI space, just in case
-		 * the firmware had other ideas.  Using a nonzero base is
-		 * necessary, since some VGA cards forcefully use PCI addresses
-		 * in the range 0x000a0000 to 0x000c0000. (eg, S3 cards).
-		 */
-		*CSR_PCICSRBASE       = 0xf4000000;
-		*CSR_PCICSRIOBASE     = 0;
-		*CSR_PCISDRAMBASE     = __virt_to_bus(PAGE_OFFSET);
-		*CSR_PCIROMBASE       = 0;
-		*CSR_PCICMD = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-			      PCI_COMMAND_INVALIDATE | PCICMD_ERROR_BITS;
-	} else if (footbridge_cfn_mode() != 0) {
-		/*
-		 * If we are not compiled to accept "add-in" mode, then
-		 * we are using a constant virt_to_bus translation which
-		 * can not hope to cater for the way the host BIOS  has
-		 * set up the machine.
-		 */
-		panic("PCI: this kernel is compiled for central "
-			"function mode only");
-	}
+	/*
+	 * Map our SDRAM at a known address in PCI space, just in case
+	 * the firmware had other ideas.  Using a nonzero base is
+	 * necessary, since some VGA cards forcefully use PCI addresses
+	 * in the range 0x000a0000 to 0x000c0000. (eg, S3 cards).
+	 */
+	*CSR_PCICSRBASE       = 0xf4000000;
+	*CSR_PCICSRIOBASE     = 0;
+	*CSR_PCISDRAMBASE     = __virt_to_bus(PAGE_OFFSET);
+	*CSR_PCIROMBASE       = 0;
+	*CSR_PCICMD = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+		      PCI_COMMAND_INVALIDATE | PCICMD_ERROR_BITS;
 }
 
 void __init dc21285_postinit(void)
diff --git a/arch/arm/mach-footbridge/dma.c b/arch/arm/mach-footbridge/dma.c
index 86618074a7a5..228757c8e06f 100644
--- a/arch/arm/mach-footbridge/dma.c
+++ b/arch/arm/mach-footbridge/dma.c
@@ -50,8 +50,7 @@ static int __init fb_dma_init(void)
 	dma[_DC21285_DMA(1)].d_ops = &fb_dma_ops;
 #endif
 #ifdef CONFIG_ISA_DMA
-	if (footbridge_cfn_mode())
-		isa_init_dma();
+	isa_init_dma();
 #endif
 	return 0;
 }
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 3a5d2638c18f..8f0ca8e8b37e 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -16,22 +16,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-
-#if defined(CONFIG_FOOTBRIDGE_ADDIN)
-/*
- * If we may be using add-in footbridge mode, then we must
- * use the out-of-line translation that makes use of the
- * PCI BAR
- */
-#ifndef __ASSEMBLY__
-extern unsigned long __virt_to_bus(unsigned long);
-extern unsigned long __bus_to_virt(unsigned long);
-#endif
-#define __virt_to_bus	__virt_to_bus
-#define __bus_to_virt	__bus_to_virt
-
-#elif defined(CONFIG_FOOTBRIDGE_HOST)
-
 /*
  * The footbridge is programmed to expose the system RAM at 0xe0000000.
  * The requirement is that the RAM isn't placed at bus address 0, which
@@ -41,12 +25,6 @@ extern unsigned long __bus_to_virt(unsigned long);
 #define __virt_to_bus(x)	((x) + (BUS_OFFSET - PAGE_OFFSET))
 #define __bus_to_virt(x)	((x) - (BUS_OFFSET - PAGE_OFFSET))
 
-#else
-
-#error "Undefined footbridge mode"
-
-#endif
-
 /*
  * Cache flushing area.
  */
diff --git a/arch/arm/mach-footbridge/isa.c b/arch/arm/mach-footbridge/isa.c
index ec5af521cf95..3375ac23c046 100644
--- a/arch/arm/mach-footbridge/isa.c
+++ b/arch/arm/mach-footbridge/isa.c
@@ -79,9 +79,6 @@ static int __init footbridge_isa_init(void)
 {
 	int err = 0;
 
-	if (!footbridge_cfn_mode())
-		return 0;
-
 	/* Personal server doesn't have RTC */
 	if (!machine_is_personal_server()) {
 		isa_rtc_init();
-- 
2.29.2

