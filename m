Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8F463C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbhK3Qtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:49:35 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37076 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbhK3Qta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 188441FD59;
        Tue, 30 Nov 2021 16:46:08 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 03F47A3B89;
        Tue, 30 Nov 2021 16:46:08 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     geert@linux-m68k.org
Subject: [PATCH 1/3] MIPS: TXX9: Remove rbtx4938 board support
Date:   Tue, 30 Nov 2021 17:45:54 +0100
Message-Id: <20211130164558.85584-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No active MIPS user own this board, so let's remove it.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/configs/rbtx49xx_defconfig  |   2 -
 arch/mips/include/asm/txx9/boards.h   |   3 -
 arch/mips/include/asm/txx9/rbtx4938.h | 145 ----------
 arch/mips/include/asm/txx9/spi.h      |  34 ---
 arch/mips/pci/Makefile                |   1 -
 arch/mips/pci/fixup-rbtx4938.c        |  53 ----
 arch/mips/txx9/Kconfig                |  28 --
 arch/mips/txx9/Makefile               |   1 -
 arch/mips/txx9/generic/Makefile       |   1 -
 arch/mips/txx9/generic/setup.c        |   5 -
 arch/mips/txx9/generic/spi_eeprom.c   | 104 -------
 arch/mips/txx9/rbtx4938/Makefile      |   2 -
 arch/mips/txx9/rbtx4938/irq.c         | 157 -----------
 arch/mips/txx9/rbtx4938/prom.c        |  22 --
 arch/mips/txx9/rbtx4938/setup.c       | 372 --------------------------
 15 files changed, 930 deletions(-)
 delete mode 100644 arch/mips/include/asm/txx9/rbtx4938.h
 delete mode 100644 arch/mips/include/asm/txx9/spi.h
 delete mode 100644 arch/mips/pci/fixup-rbtx4938.c
 delete mode 100644 arch/mips/txx9/generic/spi_eeprom.c
 delete mode 100644 arch/mips/txx9/rbtx4938/Makefile
 delete mode 100644 arch/mips/txx9/rbtx4938/irq.c
 delete mode 100644 arch/mips/txx9/rbtx4938/prom.c
 delete mode 100644 arch/mips/txx9/rbtx4938/setup.c

diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index 69f2300107f9..5e62923c6774 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -10,9 +10,7 @@ CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_MACH_TX49XX=y
 CONFIG_TOSHIBA_RBTX4927=y
-CONFIG_TOSHIBA_RBTX4938=y
 CONFIG_TOSHIBA_RBTX4939=y
-CONFIG_TOSHIBA_RBTX4938_MPLEX_KEEP=y
 # CONFIG_SECCOMP is not set
 CONFIG_PCI=y
 CONFIG_MODULES=y
diff --git a/arch/mips/include/asm/txx9/boards.h b/arch/mips/include/asm/txx9/boards.h
index d45237befd3e..0f6ae53a3a1b 100644
--- a/arch/mips/include/asm/txx9/boards.h
+++ b/arch/mips/include/asm/txx9/boards.h
@@ -6,9 +6,6 @@ BOARD_VEC(jmr3927_vec)
 BOARD_VEC(rbtx4927_vec)
 BOARD_VEC(rbtx4937_vec)
 #endif
-#ifdef CONFIG_TOSHIBA_RBTX4938
-BOARD_VEC(rbtx4938_vec)
-#endif
 #ifdef CONFIG_TOSHIBA_RBTX4939
 BOARD_VEC(rbtx4939_vec)
 #endif
diff --git a/arch/mips/include/asm/txx9/rbtx4938.h b/arch/mips/include/asm/txx9/rbtx4938.h
deleted file mode 100644
index 9c969dd3c6eb..000000000000
--- a/arch/mips/include/asm/txx9/rbtx4938.h
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- * Definitions for TX4937/TX4938
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#ifndef __ASM_TXX9_RBTX4938_H
-#define __ASM_TXX9_RBTX4938_H
-
-#include <asm/addrspace.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9/tx4938.h>
-
-/* Address map */
-#define RBTX4938_FPGA_REG_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000000)
-#define RBTX4938_FPGA_REV_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000002)
-#define RBTX4938_CONFIG1_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000004)
-#define RBTX4938_CONFIG2_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000006)
-#define RBTX4938_CONFIG3_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000008)
-#define RBTX4938_LED_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001000)
-#define RBTX4938_DIPSW_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001002)
-#define RBTX4938_BDIPSW_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001004)
-#define RBTX4938_IMASK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002000)
-#define RBTX4938_IMASK2_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002002)
-#define RBTX4938_INTPOL_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002004)
-#define RBTX4938_ISTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002006)
-#define RBTX4938_ISTAT2_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002008)
-#define RBTX4938_IMSTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000200a)
-#define RBTX4938_IMSTAT2_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000200c)
-#define RBTX4938_SOFTINT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00003000)
-#define RBTX4938_PIOSEL_ADDR	(IO_BASE + TXX9_CE(2) + 0x00005000)
-#define RBTX4938_SPICS_ADDR	(IO_BASE + TXX9_CE(2) + 0x00005002)
-#define RBTX4938_SFPWR_ADDR	(IO_BASE + TXX9_CE(2) + 0x00005008)
-#define RBTX4938_SFVOL_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000500a)
-#define RBTX4938_SOFTRESET_ADDR (IO_BASE + TXX9_CE(2) + 0x00007000)
-#define RBTX4938_SOFTRESETLOCK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00007002)
-#define RBTX4938_PCIRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x00007004)
-#define RBTX4938_ETHER_BASE	(IO_BASE + TXX9_CE(2) + 0x00020000)
-
-/* Ethernet port address (Jumperless Mode (W12:Open)) */
-#define RBTX4938_ETHER_ADDR	(RBTX4938_ETHER_BASE + 0x280)
-
-/* bits for ISTAT/IMASK/IMSTAT */
-#define RBTX4938_INTB_PCID	0
-#define RBTX4938_INTB_PCIC	1
-#define RBTX4938_INTB_PCIB	2
-#define RBTX4938_INTB_PCIA	3
-#define RBTX4938_INTB_RTC	4
-#define RBTX4938_INTB_ATA	5
-#define RBTX4938_INTB_MODEM	6
-#define RBTX4938_INTB_SWINT	7
-#define RBTX4938_INTF_PCID	(1 << RBTX4938_INTB_PCID)
-#define RBTX4938_INTF_PCIC	(1 << RBTX4938_INTB_PCIC)
-#define RBTX4938_INTF_PCIB	(1 << RBTX4938_INTB_PCIB)
-#define RBTX4938_INTF_PCIA	(1 << RBTX4938_INTB_PCIA)
-#define RBTX4938_INTF_RTC	(1 << RBTX4938_INTB_RTC)
-#define RBTX4938_INTF_ATA	(1 << RBTX4938_INTB_ATA)
-#define RBTX4938_INTF_MODEM	(1 << RBTX4938_INTB_MODEM)
-#define RBTX4938_INTF_SWINT	(1 << RBTX4938_INTB_SWINT)
-
-#define rbtx4938_fpga_rev_addr	((__u8 __iomem *)RBTX4938_FPGA_REV_ADDR)
-#define rbtx4938_led_addr	((__u8 __iomem *)RBTX4938_LED_ADDR)
-#define rbtx4938_dipsw_addr	((__u8 __iomem *)RBTX4938_DIPSW_ADDR)
-#define rbtx4938_bdipsw_addr	((__u8 __iomem *)RBTX4938_BDIPSW_ADDR)
-#define rbtx4938_imask_addr	((__u8 __iomem *)RBTX4938_IMASK_ADDR)
-#define rbtx4938_imask2_addr	((__u8 __iomem *)RBTX4938_IMASK2_ADDR)
-#define rbtx4938_intpol_addr	((__u8 __iomem *)RBTX4938_INTPOL_ADDR)
-#define rbtx4938_istat_addr	((__u8 __iomem *)RBTX4938_ISTAT_ADDR)
-#define rbtx4938_istat2_addr	((__u8 __iomem *)RBTX4938_ISTAT2_ADDR)
-#define rbtx4938_imstat_addr	((__u8 __iomem *)RBTX4938_IMSTAT_ADDR)
-#define rbtx4938_imstat2_addr	((__u8 __iomem *)RBTX4938_IMSTAT2_ADDR)
-#define rbtx4938_softint_addr	((__u8 __iomem *)RBTX4938_SOFTINT_ADDR)
-#define rbtx4938_piosel_addr	((__u8 __iomem *)RBTX4938_PIOSEL_ADDR)
-#define rbtx4938_spics_addr	((__u8 __iomem *)RBTX4938_SPICS_ADDR)
-#define rbtx4938_sfpwr_addr	((__u8 __iomem *)RBTX4938_SFPWR_ADDR)
-#define rbtx4938_sfvol_addr	((__u8 __iomem *)RBTX4938_SFVOL_ADDR)
-#define rbtx4938_softreset_addr ((__u8 __iomem *)RBTX4938_SOFTRESET_ADDR)
-#define rbtx4938_softresetlock_addr	\
-				((__u8 __iomem *)RBTX4938_SOFTRESETLOCK_ADDR)
-#define rbtx4938_pcireset_addr	((__u8 __iomem *)RBTX4938_PCIRESET_ADDR)
-
-/*
- * IRQ mappings
- */
-
-#define RBTX4938_SOFT_INT0	0	/* not used */
-#define RBTX4938_SOFT_INT1	1	/* not used */
-#define RBTX4938_IRC_INT	2
-#define RBTX4938_TIMER_INT	7
-
-/* These are the virtual IRQ numbers, we divide all IRQ's into
- * 'spaces', the 'space' determines where and how to enable/disable
- * that particular IRQ on an RBTX4938 machine.	Add new 'spaces' as new
- * IRQ hardware is supported.
- */
-#define RBTX4938_NR_IRQ_IOC	8
-
-#define RBTX4938_IRQ_IRC	TXX9_IRQ_BASE
-#define RBTX4938_IRQ_IOC	(TXX9_IRQ_BASE + TX4938_NUM_IR)
-#define RBTX4938_IRQ_END	(RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC)
-
-#define RBTX4938_IRQ_IRC_ECCERR (RBTX4938_IRQ_IRC + TX4938_IR_ECCERR)
-#define RBTX4938_IRQ_IRC_WTOERR (RBTX4938_IRQ_IRC + TX4938_IR_WTOERR)
-#define RBTX4938_IRQ_IRC_INT(n) (RBTX4938_IRQ_IRC + TX4938_IR_INT(n))
-#define RBTX4938_IRQ_IRC_SIO(n) (RBTX4938_IRQ_IRC + TX4938_IR_SIO(n))
-#define RBTX4938_IRQ_IRC_DMA(ch, n)	(RBTX4938_IRQ_IRC + TX4938_IR_DMA(ch, n))
-#define RBTX4938_IRQ_IRC_PIO	(RBTX4938_IRQ_IRC + TX4938_IR_PIO)
-#define RBTX4938_IRQ_IRC_PDMAC	(RBTX4938_IRQ_IRC + TX4938_IR_PDMAC)
-#define RBTX4938_IRQ_IRC_PCIC	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC)
-#define RBTX4938_IRQ_IRC_TMR(n) (RBTX4938_IRQ_IRC + TX4938_IR_TMR(n))
-#define RBTX4938_IRQ_IRC_NDFMC	(RBTX4938_IRQ_IRC + TX4938_IR_NDFMC)
-#define RBTX4938_IRQ_IRC_PCIERR (RBTX4938_IRQ_IRC + TX4938_IR_PCIERR)
-#define RBTX4938_IRQ_IRC_PCIPME (RBTX4938_IRQ_IRC + TX4938_IR_PCIPME)
-#define RBTX4938_IRQ_IRC_ACLC	(RBTX4938_IRQ_IRC + TX4938_IR_ACLC)
-#define RBTX4938_IRQ_IRC_ACLCPME	(RBTX4938_IRQ_IRC + TX4938_IR_ACLCPME)
-#define RBTX4938_IRQ_IRC_PCIC1	(RBTX4938_IRQ_IRC + TX4938_IR_PCIC1)
-#define RBTX4938_IRQ_IRC_SPI	(RBTX4938_IRQ_IRC + TX4938_IR_SPI)
-#define RBTX4938_IRQ_IOC_PCID	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCID)
-#define RBTX4938_IRQ_IOC_PCIC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIC)
-#define RBTX4938_IRQ_IOC_PCIB	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIB)
-#define RBTX4938_IRQ_IOC_PCIA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_PCIA)
-#define RBTX4938_IRQ_IOC_RTC	(RBTX4938_IRQ_IOC + RBTX4938_INTB_RTC)
-#define RBTX4938_IRQ_IOC_ATA	(RBTX4938_IRQ_IOC + RBTX4938_INTB_ATA)
-#define RBTX4938_IRQ_IOC_MODEM	(RBTX4938_IRQ_IOC + RBTX4938_INTB_MODEM)
-#define RBTX4938_IRQ_IOC_SWINT	(RBTX4938_IRQ_IOC + RBTX4938_INTB_SWINT)
-
-
-/* IOC (PCI, etc) */
-#define RBTX4938_IRQ_IOCINT	(TXX9_IRQ_BASE + TX4938_IR_INT(0))
-/* Onboard 10M Ether */
-#define RBTX4938_IRQ_ETHER	(TXX9_IRQ_BASE + TX4938_IR_INT(1))
-
-#define RBTX4938_RTL_8019_BASE (RBTX4938_ETHER_ADDR - mips_io_port_base)
-#define RBTX4938_RTL_8019_IRQ  (RBTX4938_IRQ_ETHER)
-
-void rbtx4938_prom_init(void);
-void rbtx4938_irq_setup(void);
-struct pci_dev;
-int rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
-
-#endif /* __ASM_TXX9_RBTX4938_H */
diff --git a/arch/mips/include/asm/txx9/spi.h b/arch/mips/include/asm/txx9/spi.h
deleted file mode 100644
index 0d727f354557..000000000000
--- a/arch/mips/include/asm/txx9/spi.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Definitions for TX4937/TX4938 SPI
- *
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#ifndef __ASM_TXX9_SPI_H
-#define __ASM_TXX9_SPI_H
-
-#include <linux/errno.h>
-
-#ifdef CONFIG_SPI
-int spi_eeprom_register(int busid, int chipid, int size);
-int spi_eeprom_read(int busid, int chipid,
-		    int address, unsigned char *buf, int len);
-#else
-static inline int spi_eeprom_register(int busid, int chipid, int size)
-{
-	return -ENODEV;
-}
-static inline int spi_eeprom_read(int busid, int chipid,
-				  int address, unsigned char *buf, int len)
-{
-	return -ENODEV;
-}
-#endif
-
-#endif /* __ASM_TXX9_SPI_H */
diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 6ddefafd00cb..bf18db3026c0 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -51,7 +51,6 @@ obj-$(CONFIG_SOC_TX4927)	+= pci-tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= pci-tx4938.o
 obj-$(CONFIG_SOC_TX4939)	+= pci-tx4939.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
-obj-$(CONFIG_TOSHIBA_RBTX4938)	+= fixup-rbtx4938.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
 obj-$(CONFIG_MIKROTIK_RB532)	+= pci-rc32434.o ops-rc32434.o fixup-rc32434.o
diff --git a/arch/mips/pci/fixup-rbtx4938.c b/arch/mips/pci/fixup-rbtx4938.c
deleted file mode 100644
index ff22a22db73e..000000000000
--- a/arch/mips/pci/fixup-rbtx4938.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Toshiba rbtx4938 pci routines
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/types.h>
-#include <asm/txx9/pci.h>
-#include <asm/txx9/rbtx4938.h>
-
-int rbtx4938_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq = tx4938_pcic1_map_irq(dev, slot);
-
-	if (irq >= 0)
-		return irq;
-	irq = pin;
-	/* IRQ rotation */
-	irq--;	/* 0-3 */
-	if (slot == TX4927_PCIC_IDSEL_AD_TO_SLOT(23)) {
-		/* PCI CardSlot (IDSEL=A23) */
-		/* PCIA => PCIA (IDSEL=A23) */
-		irq = (irq + 0 + slot) % 4;
-	} else {
-		/* PCI Backplane */
-		if (txx9_pci_option & TXX9_PCI_OPT_PICMG)
-			irq = (irq + 33 - slot) % 4;
-		else
-			irq = (irq + 3 + slot) % 4;
-	}
-	irq++;	/* 1-4 */
-
-	switch (irq) {
-	case 1:
-		irq = RBTX4938_IRQ_IOC_PCIA;
-		break;
-	case 2:
-		irq = RBTX4938_IRQ_IOC_PCIB;
-		break;
-	case 3:
-		irq = RBTX4938_IRQ_IOC_PCIC;
-		break;
-	case 4:
-		irq = RBTX4938_IRQ_IOC_PCID;
-		break;
-	}
-	return irq;
-}
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 00f6fc446abe..a5484c284353 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -39,14 +39,6 @@ config TOSHIBA_RBTX4927
 	  This Toshiba board is based on the TX4927 processor. Say Y here to
 	  support this machine type
 
-config TOSHIBA_RBTX4938
-	bool "Toshiba RBTX4938 board"
-	depends on MACH_TX49XX
-	select SOC_TX4938
-	help
-	  This Toshiba board is based on the TX4938 processor. Say Y here to
-	  support this machine type
-
 config TOSHIBA_RBTX4939
 	bool "Toshiba RBTX4939 board"
 	depends on MACH_TX49XX
@@ -105,25 +97,5 @@ config PICMG_PCI_BACKPLANE_DEFAULT
 	depends on PCI && MACH_TXX9
 	default y if !TOSHIBA_FPCIB0
 
-if TOSHIBA_RBTX4938
-
-comment "Multiplex Pin Select"
-choice
-	prompt "PIO[58:61]"
-	default TOSHIBA_RBTX4938_MPLEX_PIO58_61
-
-config TOSHIBA_RBTX4938_MPLEX_PIO58_61
-	bool "PIO"
-config TOSHIBA_RBTX4938_MPLEX_NAND
-	bool "NAND"
-config TOSHIBA_RBTX4938_MPLEX_ATA
-	bool "ATA"
-config TOSHIBA_RBTX4938_MPLEX_KEEP
-	bool "Keep firmware settings"
-
-endchoice
-
-endif
-
 config PCI_TX4927
 	bool
diff --git a/arch/mips/txx9/Makefile b/arch/mips/txx9/Makefile
index 195295937282..c8eeca8fa3d5 100644
--- a/arch/mips/txx9/Makefile
+++ b/arch/mips/txx9/Makefile
@@ -14,5 +14,4 @@ obj-$(CONFIG_TOSHIBA_JMR3927)  += jmr3927/
 # Toshiba RBTX49XX boards
 #
 obj-$(CONFIG_TOSHIBA_RBTX4927) += rbtx4927/
-obj-$(CONFIG_TOSHIBA_RBTX4938) += rbtx4938/
 obj-$(CONFIG_TOSHIBA_RBTX4939) += rbtx4939/
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 6d00580fc81d..76caa756ec2b 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -10,5 +10,4 @@ obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_SOC_TX4939)	+= setup_tx4939.o irq_tx4939.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
-obj-$(CONFIG_SPI)		+= spi_eeprom.o
 obj-$(CONFIG_TXX9_7SEGLED)	+= 7segled.o
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 42ba1e97dff0..5c42da622b8b 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -315,11 +315,6 @@ static void __init select_board(void)
 		txx9_board_vec = &rbtx4937_vec;
 		break;
 #endif
-#ifdef CONFIG_TOSHIBA_RBTX4938
-	case 0x4938:
-		txx9_board_vec = &rbtx4938_vec;
-		break;
-#endif
 #ifdef CONFIG_TOSHIBA_RBTX4939
 	case 0x4939:
 		txx9_board_vec = &rbtx4939_vec;
diff --git a/arch/mips/txx9/generic/spi_eeprom.c b/arch/mips/txx9/generic/spi_eeprom.c
deleted file mode 100644
index d833dd2c9b55..000000000000
--- a/arch/mips/txx9/generic/spi_eeprom.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * spi_eeprom.c
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/export.h>
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/eeprom.h>
-#include <asm/txx9/spi.h>
-
-#define AT250X0_PAGE_SIZE	8
-
-/* register board information for at25 driver */
-int __init spi_eeprom_register(int busid, int chipid, int size)
-{
-	struct spi_board_info info = {
-		.modalias = "at25",
-		.max_speed_hz = 1500000,	/* 1.5Mbps */
-		.bus_num = busid,
-		.chip_select = chipid,
-		/* Mode 0: High-Active, Sample-Then-Shift */
-	};
-	struct spi_eeprom *eeprom;
-	eeprom = kzalloc(sizeof(*eeprom), GFP_KERNEL);
-	if (!eeprom)
-		return -ENOMEM;
-	strcpy(eeprom->name, "at250x0");
-	eeprom->byte_len = size;
-	eeprom->page_size = AT250X0_PAGE_SIZE;
-	eeprom->flags = EE_ADDR1;
-	info.platform_data = eeprom;
-	return spi_register_board_info(&info, 1);
-}
-
-/* simple temporary spi driver to provide early access to seeprom. */
-
-static struct read_param {
-	int busid;
-	int chipid;
-	int address;
-	unsigned char *buf;
-	int len;
-} *read_param;
-
-static int __init early_seeprom_probe(struct spi_device *spi)
-{
-	int stat = 0;
-	u8 cmd[2];
-	int len = read_param->len;
-	char *buf = read_param->buf;
-	int address = read_param->address;
-
-	dev_info(&spi->dev, "spiclk %u KHz.\n",
-		 (spi->max_speed_hz + 500) / 1000);
-	if (read_param->busid != spi->master->bus_num ||
-	    read_param->chipid != spi->chip_select)
-		return -ENODEV;
-	while (len > 0) {
-		/* spi_write_then_read can only work with small chunk */
-		int c = len < AT250X0_PAGE_SIZE ? len : AT250X0_PAGE_SIZE;
-		cmd[0] = 0x03;	/* AT25_READ */
-		cmd[1] = address;
-		stat = spi_write_then_read(spi, cmd, sizeof(cmd), buf, c);
-		buf += c;
-		len -= c;
-		address += c;
-	}
-	return stat;
-}
-
-static struct spi_driver early_seeprom_driver __initdata = {
-	.driver = {
-		.name	= "at25",
-	},
-	.probe	= early_seeprom_probe,
-};
-
-int __init spi_eeprom_read(int busid, int chipid, int address,
-			   unsigned char *buf, int len)
-{
-	int ret;
-	struct read_param param = {
-		.busid = busid,
-		.chipid = chipid,
-		.address = address,
-		.buf = buf,
-		.len = len
-	};
-
-	read_param = &param;
-	ret = spi_register_driver(&early_seeprom_driver);
-	if (!ret)
-		spi_unregister_driver(&early_seeprom_driver);
-	return ret;
-}
diff --git a/arch/mips/txx9/rbtx4938/Makefile b/arch/mips/txx9/rbtx4938/Makefile
deleted file mode 100644
index 08a02aebda5a..000000000000
--- a/arch/mips/txx9/rbtx4938/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y	+= prom.o setup.o irq.o
diff --git a/arch/mips/txx9/rbtx4938/irq.c b/arch/mips/txx9/rbtx4938/irq.c
deleted file mode 100644
index 58cd7a9272cc..000000000000
--- a/arch/mips/txx9/rbtx4938/irq.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * Toshiba RBTX4938 specific interrupt handlers
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-/*
- * MIPS_CPU_IRQ_BASE+00 Software 0
- * MIPS_CPU_IRQ_BASE+01 Software 1
- * MIPS_CPU_IRQ_BASE+02 Cascade TX4938-CP0
- * MIPS_CPU_IRQ_BASE+03 Multiplexed -- do not use
- * MIPS_CPU_IRQ_BASE+04 Multiplexed -- do not use
- * MIPS_CPU_IRQ_BASE+05 Multiplexed -- do not use
- * MIPS_CPU_IRQ_BASE+06 Multiplexed -- do not use
- * MIPS_CPU_IRQ_BASE+07 CPU TIMER
- *
- * TXX9_IRQ_BASE+00
- * TXX9_IRQ_BASE+01
- * TXX9_IRQ_BASE+02 Cascade RBTX4938-IOC
- * TXX9_IRQ_BASE+03 RBTX4938 RTL-8019AS Ethernet
- * TXX9_IRQ_BASE+04
- * TXX9_IRQ_BASE+05 TX4938 ETH1
- * TXX9_IRQ_BASE+06 TX4938 ETH0
- * TXX9_IRQ_BASE+07
- * TXX9_IRQ_BASE+08 TX4938 SIO 0
- * TXX9_IRQ_BASE+09 TX4938 SIO 1
- * TXX9_IRQ_BASE+10 TX4938 DMA0
- * TXX9_IRQ_BASE+11 TX4938 DMA1
- * TXX9_IRQ_BASE+12 TX4938 DMA2
- * TXX9_IRQ_BASE+13 TX4938 DMA3
- * TXX9_IRQ_BASE+14
- * TXX9_IRQ_BASE+15
- * TXX9_IRQ_BASE+16 TX4938 PCIC
- * TXX9_IRQ_BASE+17 TX4938 TMR0
- * TXX9_IRQ_BASE+18 TX4938 TMR1
- * TXX9_IRQ_BASE+19 TX4938 TMR2
- * TXX9_IRQ_BASE+20
- * TXX9_IRQ_BASE+21
- * TXX9_IRQ_BASE+22 TX4938 PCIERR
- * TXX9_IRQ_BASE+23
- * TXX9_IRQ_BASE+24
- * TXX9_IRQ_BASE+25
- * TXX9_IRQ_BASE+26
- * TXX9_IRQ_BASE+27
- * TXX9_IRQ_BASE+28
- * TXX9_IRQ_BASE+29
- * TXX9_IRQ_BASE+30
- * TXX9_IRQ_BASE+31 TX4938 SPI
- *
- * RBTX4938_IRQ_IOC+00 PCI-D
- * RBTX4938_IRQ_IOC+01 PCI-C
- * RBTX4938_IRQ_IOC+02 PCI-B
- * RBTX4938_IRQ_IOC+03 PCI-A
- * RBTX4938_IRQ_IOC+04 RTC
- * RBTX4938_IRQ_IOC+05 ATA
- * RBTX4938_IRQ_IOC+06 MODEM
- * RBTX4938_IRQ_IOC+07 SWINT
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <asm/mipsregs.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/rbtx4938.h>
-
-static int toshiba_rbtx4938_irq_nested(int sw_irq)
-{
-	u8 level3;
-
-	level3 = readb(rbtx4938_imstat_addr);
-	if (unlikely(!level3))
-		return -1;
-	/* must use fls so onboard ATA has priority */
-	return RBTX4938_IRQ_IOC + __fls8(level3);
-}
-
-static void toshiba_rbtx4938_irq_ioc_enable(struct irq_data *d)
-{
-	unsigned char v;
-
-	v = readb(rbtx4938_imask_addr);
-	v |= (1 << (d->irq - RBTX4938_IRQ_IOC));
-	writeb(v, rbtx4938_imask_addr);
-	mmiowb();
-}
-
-static void toshiba_rbtx4938_irq_ioc_disable(struct irq_data *d)
-{
-	unsigned char v;
-
-	v = readb(rbtx4938_imask_addr);
-	v &= ~(1 << (d->irq - RBTX4938_IRQ_IOC));
-	writeb(v, rbtx4938_imask_addr);
-	mmiowb();
-}
-
-#define TOSHIBA_RBTX4938_IOC_NAME "RBTX4938-IOC"
-static struct irq_chip toshiba_rbtx4938_irq_ioc_type = {
-	.name = TOSHIBA_RBTX4938_IOC_NAME,
-	.irq_mask = toshiba_rbtx4938_irq_ioc_disable,
-	.irq_unmask = toshiba_rbtx4938_irq_ioc_enable,
-};
-
-static int rbtx4938_irq_dispatch(int pending)
-{
-	int irq;
-
-	if (pending & STATUSF_IP7)
-		irq = MIPS_CPU_IRQ_BASE + 7;
-	else if (pending & STATUSF_IP2) {
-		irq = txx9_irq();
-		if (irq == RBTX4938_IRQ_IOCINT)
-			irq = toshiba_rbtx4938_irq_nested(irq);
-	} else if (pending & STATUSF_IP1)
-		irq = MIPS_CPU_IRQ_BASE + 0;
-	else if (pending & STATUSF_IP0)
-		irq = MIPS_CPU_IRQ_BASE + 1;
-	else
-		irq = -1;
-	return irq;
-}
-
-static void __init toshiba_rbtx4938_irq_ioc_init(void)
-{
-	int i;
-
-	for (i = RBTX4938_IRQ_IOC;
-	     i < RBTX4938_IRQ_IOC + RBTX4938_NR_IRQ_IOC; i++)
-		irq_set_chip_and_handler(i, &toshiba_rbtx4938_irq_ioc_type,
-					 handle_level_irq);
-
-	irq_set_chained_handler(RBTX4938_IRQ_IOCINT, handle_simple_irq);
-}
-
-void __init rbtx4938_irq_setup(void)
-{
-	txx9_irq_dispatch = rbtx4938_irq_dispatch;
-	/* Now, interrupt control disabled, */
-	/* all IRC interrupts are masked, */
-	/* all IRC interrupt mode are Low Active. */
-
-	/* mask all IOC interrupts */
-	writeb(0, rbtx4938_imask_addr);
-
-	/* clear SoftInt interrupts */
-	writeb(0, rbtx4938_softint_addr);
-	tx4938_irq_init();
-	toshiba_rbtx4938_irq_ioc_init();
-	/* Onboard 10M Ether: High Active */
-	irq_set_irq_type(RBTX4938_IRQ_ETHER, IRQF_TRIGGER_HIGH);
-}
diff --git a/arch/mips/txx9/rbtx4938/prom.c b/arch/mips/txx9/rbtx4938/prom.c
deleted file mode 100644
index 0de84716a428..000000000000
--- a/arch/mips/txx9/rbtx4938/prom.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * rbtx4938 specific prom routines
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/rbtx4938.h>
-
-void __init rbtx4938_prom_init(void)
-{
-	memblock_add(0, tx4938_get_mem_size());
-	txx9_sio_putchar_init(TX4938_SIO_REG(0) & 0xfffffffffULL);
-}
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
deleted file mode 100644
index e68eb2e7ce0c..000000000000
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ /dev/null
@@ -1,372 +0,0 @@
-/*
- * Setup pointers to hardware-dependent routines.
- * Copyright (C) 2000-2001 Toshiba Corporation
- *
- * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
- */
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/gpio/driver.h>
-#include <linux/gpio.h>
-#include <linux/mtd/physmap.h>
-
-#include <asm/reboot.h>
-#include <asm/io.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/pci.h>
-#include <asm/txx9/rbtx4938.h>
-#include <linux/spi/spi.h>
-#include <asm/txx9/spi.h>
-#include <asm/txx9pio.h>
-
-static void rbtx4938_machine_restart(char *command)
-{
-	local_irq_disable();
-	writeb(1, rbtx4938_softresetlock_addr);
-	writeb(1, rbtx4938_sfvol_addr);
-	writeb(1, rbtx4938_softreset_addr);
-	/* fallback */
-	(*_machine_halt)();
-}
-
-static void __init rbtx4938_pci_setup(void)
-{
-#ifdef CONFIG_PCI
-	int extarb = !(__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB);
-	struct pci_controller *c = &txx9_primary_pcic;
-
-	register_pci_controller(c);
-
-	if (__raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCI66)
-		txx9_pci_option =
-			(txx9_pci_option & ~TXX9_PCI_OPT_CLK_MASK) |
-			TXX9_PCI_OPT_CLK_66; /* already configured */
-
-	/* Reset PCI Bus */
-	writeb(0, rbtx4938_pcireset_addr);
-	/* Reset PCIC */
-	txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
-	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
-	    TXX9_PCI_OPT_CLK_66)
-		tx4938_pciclk66_setup();
-	mdelay(10);
-	/* clear PCIC reset */
-	txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
-	writeb(1, rbtx4938_pcireset_addr);
-	iob();
-
-	tx4938_report_pciclk();
-	tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
-	if ((txx9_pci_option & TXX9_PCI_OPT_CLK_MASK) ==
-	    TXX9_PCI_OPT_CLK_AUTO &&
-	    txx9_pci66_check(c, 0, 0)) {
-		/* Reset PCI Bus */
-		writeb(0, rbtx4938_pcireset_addr);
-		/* Reset PCIC */
-		txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
-		tx4938_pciclk66_setup();
-		mdelay(10);
-		/* clear PCIC reset */
-		txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIRST);
-		writeb(1, rbtx4938_pcireset_addr);
-		iob();
-		/* Reinitialize PCIC */
-		tx4938_report_pciclk();
-		tx4927_pcic_setup(tx4938_pcicptr, c, extarb);
-	}
-
-	if (__raw_readq(&tx4938_ccfgptr->pcfg) &
-	    (TX4938_PCFG_ETH0_SEL|TX4938_PCFG_ETH1_SEL)) {
-		/* Reset PCIC1 */
-		txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
-		/* PCI1DMD==0 => PCI1CLK==GBUSCLK/2 => PCI66 */
-		if (!(__raw_readq(&tx4938_ccfgptr->ccfg)
-		      & TX4938_CCFG_PCI1DMD))
-			tx4938_ccfg_set(TX4938_CCFG_PCI1_66);
-		mdelay(10);
-		/* clear PCIC1 reset */
-		txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
-		tx4938_report_pci1clk();
-
-		/* mem:64K(max), io:64K(max) (enough for ETH0,ETH1) */
-		c = txx9_alloc_pci_controller(NULL, 0, 0x10000, 0, 0x10000);
-		register_pci_controller(c);
-		tx4927_pcic_setup(tx4938_pcic1ptr, c, 0);
-	}
-	tx4938_setup_pcierr_irq();
-#endif /* CONFIG_PCI */
-}
-
-/* SPI support */
-
-/* chip select for SPI devices */
-#define SEEPROM1_CS	7	/* PIO7 */
-#define SEEPROM2_CS	0	/* IOC */
-#define SEEPROM3_CS	1	/* IOC */
-#define SRTC_CS 2	/* IOC */
-#define SPI_BUSNO	0
-
-static int __init rbtx4938_ethaddr_init(void)
-{
-#ifdef CONFIG_PCI
-	unsigned char dat[17];
-	unsigned char sum;
-	int i;
-
-	/* 0-3: "MAC\0", 4-9:eth0, 10-15:eth1, 16:sum */
-	if (spi_eeprom_read(SPI_BUSNO, SEEPROM1_CS, 0, dat, sizeof(dat))) {
-		pr_err("seeprom: read error.\n");
-		return -ENODEV;
-	} else {
-		if (strcmp(dat, "MAC") != 0)
-			pr_warn("seeprom: bad signature.\n");
-		for (i = 0, sum = 0; i < sizeof(dat); i++)
-			sum += dat[i];
-		if (sum)
-			pr_warn("seeprom: bad checksum.\n");
-	}
-	tx4938_ethaddr_init(&dat[4], &dat[4 + 6]);
-#endif /* CONFIG_PCI */
-	return 0;
-}
-
-static void __init rbtx4938_spi_setup(void)
-{
-	/* set SPI_SEL */
-	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_SPI_SEL);
-}
-
-static struct resource rbtx4938_fpga_resource;
-
-static void __init rbtx4938_time_init(void)
-{
-	tx4938_time_init(0);
-}
-
-static void __init rbtx4938_mem_setup(void)
-{
-	unsigned long long pcfg;
-
-	if (txx9_master_clock == 0)
-		txx9_master_clock = 25000000; /* 25MHz */
-
-	tx4938_setup();
-
-#ifdef CONFIG_PCI
-	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
-	txx9_board_pcibios_setup = tx4927_pcibios_setup;
-#else
-	set_io_port_base(RBTX4938_ETHER_BASE);
-#endif
-
-	tx4938_sio_init(7372800, 0);
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
-	pr_info("PIOSEL: disabling both ATA and NAND selection\n");
-	txx9_clear64(&tx4938_ccfgptr->pcfg,
-		     TX4938_PCFG_NDF_SEL | TX4938_PCFG_ATA_SEL);
-#endif
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_NAND
-	pr_info("PIOSEL: enabling NAND selection\n");
-	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
-	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
-#endif
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_ATA
-	pr_info("PIOSEL: enabling ATA selection\n");
-	txx9_set64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_ATA_SEL);
-	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_NDF_SEL);
-#endif
-
-#ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_KEEP
-	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);
-	pr_info("PIOSEL: NAND %s, ATA %s\n",
-		(pcfg & TX4938_PCFG_NDF_SEL) ? "enabled" : "disabled",
-		(pcfg & TX4938_PCFG_ATA_SEL) ? "enabled" : "disabled");
-#endif
-
-	rbtx4938_spi_setup();
-	pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);	/* updated */
-	/* fixup piosel */
-	if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-	    TX4938_PCFG_ATA_SEL)
-		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x04,
-		       rbtx4938_piosel_addr);
-	else if ((pcfg & (TX4938_PCFG_ATA_SEL | TX4938_PCFG_NDF_SEL)) ==
-		 TX4938_PCFG_NDF_SEL)
-		writeb((readb(rbtx4938_piosel_addr) & 0x03) | 0x08,
-		       rbtx4938_piosel_addr);
-	else
-		writeb(readb(rbtx4938_piosel_addr) & ~(0x08 | 0x04),
-		       rbtx4938_piosel_addr);
-
-	rbtx4938_fpga_resource.name = "FPGA Registers";
-	rbtx4938_fpga_resource.start = CPHYSADDR(RBTX4938_FPGA_REG_ADDR);
-	rbtx4938_fpga_resource.end = CPHYSADDR(RBTX4938_FPGA_REG_ADDR) + 0xffff;
-	rbtx4938_fpga_resource.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	if (request_resource(&txx9_ce_res[2], &rbtx4938_fpga_resource))
-		pr_err("request resource for fpga failed\n");
-
-	_machine_restart = rbtx4938_machine_restart;
-
-	writeb(0xff, rbtx4938_led_addr);
-	pr_info("RBTX4938 --- FPGA(Rev %02x) DIPSW:%02x,%02x\n",
-		readb(rbtx4938_fpga_rev_addr),
-		readb(rbtx4938_dipsw_addr), readb(rbtx4938_bdipsw_addr));
-}
-
-static void __init rbtx4938_ne_init(void)
-{
-	struct resource res[] = {
-		{
-			.start	= RBTX4938_RTL_8019_BASE,
-			.end	= RBTX4938_RTL_8019_BASE + 0x20 - 1,
-			.flags	= IORESOURCE_IO,
-		}, {
-			.start	= RBTX4938_RTL_8019_IRQ,
-			.flags	= IORESOURCE_IRQ,
-		}
-	};
-	platform_device_register_simple("ne", -1, res, ARRAY_SIZE(res));
-}
-
-static DEFINE_SPINLOCK(rbtx4938_spi_gpio_lock);
-
-static void rbtx4938_spi_gpio_set(struct gpio_chip *chip, unsigned int offset,
-				  int value)
-{
-	u8 val;
-	unsigned long flags;
-	spin_lock_irqsave(&rbtx4938_spi_gpio_lock, flags);
-	val = readb(rbtx4938_spics_addr);
-	if (value)
-		val |= 1 << offset;
-	else
-		val &= ~(1 << offset);
-	writeb(val, rbtx4938_spics_addr);
-	mmiowb();
-	spin_unlock_irqrestore(&rbtx4938_spi_gpio_lock, flags);
-}
-
-static int rbtx4938_spi_gpio_dir_out(struct gpio_chip *chip,
-				     unsigned int offset, int value)
-{
-	rbtx4938_spi_gpio_set(chip, offset, value);
-	return 0;
-}
-
-static struct gpio_chip rbtx4938_spi_gpio_chip = {
-	.set = rbtx4938_spi_gpio_set,
-	.direction_output = rbtx4938_spi_gpio_dir_out,
-	.label = "RBTX4938-SPICS",
-	.base = 16,
-	.ngpio = 3,
-};
-
-static int __init rbtx4938_spi_init(void)
-{
-	struct spi_board_info srtc_info = {
-		.modalias = "rtc-rs5c348",
-		.max_speed_hz = 1000000, /* 1.0Mbps @ Vdd 2.0V */
-		.bus_num = 0,
-		.chip_select = 16 + SRTC_CS,
-		/* Mode 1 (High-Active, Shift-Then-Sample), High Avtive CS  */
-		.mode = SPI_MODE_1 | SPI_CS_HIGH,
-	};
-	spi_register_board_info(&srtc_info, 1);
-	spi_eeprom_register(SPI_BUSNO, SEEPROM1_CS, 128);
-	spi_eeprom_register(SPI_BUSNO, 16 + SEEPROM2_CS, 128);
-	spi_eeprom_register(SPI_BUSNO, 16 + SEEPROM3_CS, 128);
-	gpio_request(16 + SRTC_CS, "rtc-rs5c348");
-	gpio_direction_output(16 + SRTC_CS, 0);
-	gpio_request(SEEPROM1_CS, "seeprom1");
-	gpio_direction_output(SEEPROM1_CS, 1);
-	gpio_request(16 + SEEPROM2_CS, "seeprom2");
-	gpio_direction_output(16 + SEEPROM2_CS, 1);
-	gpio_request(16 + SEEPROM3_CS, "seeprom3");
-	gpio_direction_output(16 + SEEPROM3_CS, 1);
-	tx4938_spi_init(SPI_BUSNO);
-	return 0;
-}
-
-static void __init rbtx4938_mtd_init(void)
-{
-	struct physmap_flash_data pdata = {
-		.width = 4,
-	};
-
-	switch (readb(rbtx4938_bdipsw_addr) & 7) {
-	case 0:
-		/* Boot */
-		txx9_physmap_flash_init(0, 0x1fc00000, 0x400000, &pdata);
-		/* System */
-		txx9_physmap_flash_init(1, 0x1e000000, 0x1000000, &pdata);
-		break;
-	case 1:
-		/* System */
-		txx9_physmap_flash_init(0, 0x1f000000, 0x1000000, &pdata);
-		/* Boot */
-		txx9_physmap_flash_init(1, 0x1ec00000, 0x400000, &pdata);
-		break;
-	case 2:
-		/* Ext */
-		txx9_physmap_flash_init(0, 0x1f000000, 0x1000000, &pdata);
-		/* System */
-		txx9_physmap_flash_init(1, 0x1e000000, 0x1000000, &pdata);
-		/* Boot */
-		txx9_physmap_flash_init(2, 0x1dc00000, 0x400000, &pdata);
-		break;
-	case 3:
-		/* Boot */
-		txx9_physmap_flash_init(1, 0x1bc00000, 0x400000, &pdata);
-		/* System */
-		txx9_physmap_flash_init(2, 0x1a000000, 0x1000000, &pdata);
-		break;
-	}
-}
-
-static void __init rbtx4938_arch_init(void)
-{
-	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, TX4938_NUM_PIO);
-	gpiochip_add_data(&rbtx4938_spi_gpio_chip, NULL);
-	rbtx4938_pci_setup();
-	rbtx4938_spi_init();
-}
-
-static void __init rbtx4938_device_init(void)
-{
-	rbtx4938_ethaddr_init();
-	rbtx4938_ne_init();
-	tx4938_wdt_init();
-	rbtx4938_mtd_init();
-	/* TC58DVM82A1FT: tDH=10ns, tWP=tRP=tREADID=35ns */
-	tx4938_ndfmc_init(10, 35);
-	tx4938_ata_init(RBTX4938_IRQ_IOC_ATA, 0, 1);
-	tx4938_dmac_init(0, 2);
-	tx4938_aclc_init();
-	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
-	tx4938_sramc_init();
-	txx9_iocled_init(RBTX4938_LED_ADDR - IO_BASE, -1, 8, 1, "green", NULL);
-}
-
-struct txx9_board_vec rbtx4938_vec __initdata = {
-	.system = "Toshiba RBTX4938",
-	.prom_init = rbtx4938_prom_init,
-	.mem_setup = rbtx4938_mem_setup,
-	.irq_setup = rbtx4938_irq_setup,
-	.time_init = rbtx4938_time_init,
-	.device_init = rbtx4938_device_init,
-	.arch_init = rbtx4938_arch_init,
-#ifdef CONFIG_PCI
-	.pci_map_irq = rbtx4938_pci_map_irq,
-#endif
-};
-- 
2.29.2

