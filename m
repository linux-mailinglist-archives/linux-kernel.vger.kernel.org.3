Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824C2463C33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbhK3Qtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:49:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37120 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbhK3Qtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 13B2E1FD59;
        Tue, 30 Nov 2021 16:46:18 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id BB9ACA3B89;
        Tue, 30 Nov 2021 16:46:15 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-crypto@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     geert@linux-m68k.org
Subject: [PATCH 3/3] MIPS: TXX9: Remove TX4939 SoC support
Date:   Tue, 30 Nov 2021 17:45:56 +0100
Message-Id: <20211130164558.85584-3-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211130164558.85584-1-tsbogend@alpha.franken.de>
References: <20211130164558.85584-1-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of RBTX4939 board support remove code for the TX4939 SoC.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/pci/Makefile                |   1 -
 arch/mips/pci/pci-tx4939.c            | 107 -----
 arch/mips/txx9/Kconfig                |   8 -
 arch/mips/txx9/generic/Makefile       |   1 -
 arch/mips/txx9/generic/irq_tx4939.c   | 216 ----------
 arch/mips/txx9/generic/setup_tx4939.c | 568 --------------------------
 drivers/char/hw_random/Kconfig        |  13 -
 drivers/char/hw_random/Makefile       |   1 -
 drivers/char/hw_random/tx4939-rng.c   | 157 -------
 drivers/mtd/nand/raw/Kconfig          |   2 +-
 10 files changed, 1 insertion(+), 1073 deletions(-)
 delete mode 100644 arch/mips/pci/pci-tx4939.c
 delete mode 100644 arch/mips/txx9/generic/irq_tx4939.c
 delete mode 100644 arch/mips/txx9/generic/setup_tx4939.c
 delete mode 100644 drivers/char/hw_random/tx4939-rng.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index bf18db3026c0..9a6bc702608c 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -49,7 +49,6 @@ obj-$(CONFIG_TANBAC_TB0287)	+= fixup-tb0287.o
 obj-$(CONFIG_TOSHIBA_JMR3927)	+= fixup-jmr3927.o
 obj-$(CONFIG_SOC_TX4927)	+= pci-tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= pci-tx4938.o
-obj-$(CONFIG_SOC_TX4939)	+= pci-tx4939.o
 obj-$(CONFIG_TOSHIBA_RBTX4927)	+= fixup-rbtx4927.o
 obj-$(CONFIG_VICTOR_MPC30X)	+= fixup-mpc30x.o
 obj-$(CONFIG_ZAO_CAPCELLA)	+= fixup-capcella.o
diff --git a/arch/mips/pci/pci-tx4939.c b/arch/mips/pci/pci-tx4939.c
deleted file mode 100644
index 09a65f7dbe7c..000000000000
--- a/arch/mips/pci/pci-tx4939.c
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- * Based on linux/arch/mips/txx9/rbtx4939/setup.c,
- *	    and RBTX49xx patch from CELF patch archive.
- *
- * Copyright 2001, 2003-2005 MontaVista Software Inc.
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
- * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/tx4939.h>
-
-int __init tx4939_report_pciclk(void)
-{
-	int pciclk = 0;
-
-	pr_info("PCIC --%s PCICLK:",
-		(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCI66) ?
-		" PCI66" : "");
-	if (__raw_readq(&tx4939_ccfgptr->pcfg) & TX4939_PCFG_PCICLKEN_ALL) {
-		pciclk = txx9_master_clock * 20 / 6;
-		if (!(__raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCI66))
-			pciclk /= 2;
-		pr_cont("Internal(%u.%uMHz)",
-			(pciclk + 50000) / 1000000,
-			((pciclk + 50000) / 100000) % 10);
-	} else {
-		pr_cont("External");
-		pciclk = -1;
-	}
-	pr_cont("\n");
-	return pciclk;
-}
-
-void __init tx4939_report_pci1clk(void)
-{
-	unsigned int pciclk = txx9_master_clock * 20 / 6;
-
-	pr_info("PCIC1 -- PCICLK:%u.%uMHz\n",
-		(pciclk + 50000) / 1000000,
-		((pciclk + 50000) / 100000) % 10);
-}
-
-int tx4939_pcic1_map_irq(const struct pci_dev *dev, u8 slot)
-{
-	if (get_tx4927_pcicptr(dev->bus->sysdata) == tx4939_pcic1ptr) {
-		switch (slot) {
-		case TX4927_PCIC_IDSEL_AD_TO_SLOT(31):
-			if (__raw_readq(&tx4939_ccfgptr->pcfg) &
-			    TX4939_PCFG_ET0MODE)
-				return TXX9_IRQ_BASE + TX4939_IR_ETH(0);
-			break;
-		case TX4927_PCIC_IDSEL_AD_TO_SLOT(30):
-			if (__raw_readq(&tx4939_ccfgptr->pcfg) &
-			    TX4939_PCFG_ET1MODE)
-				return TXX9_IRQ_BASE + TX4939_IR_ETH(1);
-			break;
-		}
-		return 0;
-	}
-	return -1;
-}
-
-int tx4939_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	int irq = tx4939_pcic1_map_irq(dev, slot);
-
-	if (irq >= 0)
-		return irq;
-	irq = pin;
-	/* IRQ rotation */
-	irq--;	/* 0-3 */
-	irq = (irq + 33 - slot) % 4;
-	irq++;	/* 1-4 */
-
-	switch (irq) {
-	case 1:
-		irq = TXX9_IRQ_BASE + TX4939_IR_INTA;
-		break;
-	case 2:
-		irq = TXX9_IRQ_BASE + TX4939_IR_INTB;
-		break;
-	case 3:
-		irq = TXX9_IRQ_BASE + TX4939_IR_INTC;
-		break;
-	case 4:
-		irq = TXX9_IRQ_BASE + TX4939_IR_INTD;
-		break;
-	}
-	return irq;
-}
-
-void __init tx4939_setup_pcierr_irq(void)
-{
-	if (request_irq(TXX9_IRQ_BASE + TX4939_IR_PCIERR,
-			tx4927_pcierr_interrupt,
-			0, "PCI error",
-			(void *)TX4939_PCIC_REG))
-		pr_warn("Failed to request irq for PCIERR\n");
-}
diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 9e5e33a09cf9..54b4e43053d7 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -67,14 +67,6 @@ config SOC_TX4938
 	select GPIO_TXX9
 	imply HAS_TXX9_ACLC
 
-config SOC_TX4939
-	bool
-	select CEVT_TXX9
-	imply HAS_TXX9_SERIAL
-	select HAVE_PCI
-	select PCI_TX4927
-	imply HAS_TXX9_ACLC
-
 config TOSHIBA_FPCIB0
 	bool "FPCIB0 Backplane Support"
 	depends on PCI && MACH_TXX9
diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 62b6dc6915e3..be5af9fe7c11 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_SOC_TX3927)	+= setup_tx3927.o irq_tx3927.o
 obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
-obj-$(CONFIG_SOC_TX4939)	+= setup_tx4939.o irq_tx4939.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
diff --git a/arch/mips/txx9/generic/irq_tx4939.c b/arch/mips/txx9/generic/irq_tx4939.c
deleted file mode 100644
index 0d7267e81a8c..000000000000
--- a/arch/mips/txx9/generic/irq_tx4939.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * TX4939 irq routines
- * Based on linux/arch/mips/kernel/irq_txx9.c,
- *	    and RBTX49xx patch from CELF patch archive.
- *
- * Copyright 2001, 2003-2005 MontaVista Software Inc.
- * Author: MontaVista Software, Inc.
- *	   ahennessy@mvista.com
- *	   source@mvista.com
- * Copyright (C) 2000-2001,2005-2007 Toshiba Corporation
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-/*
- * TX4939 defines 64 IRQs.
- * Similer to irq_txx9.c but different register layouts.
- */
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/types.h>
-#include <asm/irq_cpu.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9/tx4939.h>
-
-/* IRCER : Int. Control Enable */
-#define TXx9_IRCER_ICE	0x00000001
-
-/* IRCR : Int. Control */
-#define TXx9_IRCR_LOW	0x00000000
-#define TXx9_IRCR_HIGH	0x00000001
-#define TXx9_IRCR_DOWN	0x00000002
-#define TXx9_IRCR_UP	0x00000003
-#define TXx9_IRCR_EDGE(cr)	((cr) & 0x00000002)
-
-/* IRSCR : Int. Status Control */
-#define TXx9_IRSCR_EIClrE	0x00000100
-#define TXx9_IRSCR_EIClr_MASK	0x0000000f
-
-/* IRCSR : Int. Current Status */
-#define TXx9_IRCSR_IF	0x00010000
-
-#define irc_dlevel	0
-#define irc_elevel	1
-
-static struct {
-	unsigned char level;
-	unsigned char mode;
-} tx4939irq[TX4939_NUM_IR] __read_mostly;
-
-static void tx4939_irq_unmask(struct irq_data *d)
-{
-	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
-	u32 __iomem *lvlp;
-	int ofs;
-	if (irq_nr < 32) {
-		irq_nr--;
-		lvlp = &tx4939_ircptr->lvl[(irq_nr % 16) / 2].r;
-	} else {
-		irq_nr -= 32;
-		lvlp = &tx4939_ircptr->lvl[8 + (irq_nr % 16) / 2].r;
-	}
-	ofs = (irq_nr & 16) + (irq_nr & 1) * 8;
-	__raw_writel((__raw_readl(lvlp) & ~(0xff << ofs))
-		     | (tx4939irq[irq_nr].level << ofs),
-		     lvlp);
-}
-
-static inline void tx4939_irq_mask(struct irq_data *d)
-{
-	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
-	u32 __iomem *lvlp;
-	int ofs;
-	if (irq_nr < 32) {
-		irq_nr--;
-		lvlp = &tx4939_ircptr->lvl[(irq_nr % 16) / 2].r;
-	} else {
-		irq_nr -= 32;
-		lvlp = &tx4939_ircptr->lvl[8 + (irq_nr % 16) / 2].r;
-	}
-	ofs = (irq_nr & 16) + (irq_nr & 1) * 8;
-	__raw_writel((__raw_readl(lvlp) & ~(0xff << ofs))
-		     | (irc_dlevel << ofs),
-		     lvlp);
-	mmiowb();
-}
-
-static void tx4939_irq_mask_ack(struct irq_data *d)
-{
-	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
-
-	tx4939_irq_mask(d);
-	if (TXx9_IRCR_EDGE(tx4939irq[irq_nr].mode)) {
-		irq_nr--;
-		/* clear edge detection */
-		__raw_writel((TXx9_IRSCR_EIClrE | (irq_nr & 0xf))
-			     << (irq_nr & 0x10),
-			     &tx4939_ircptr->edc.r);
-	}
-}
-
-static int tx4939_irq_set_type(struct irq_data *d, unsigned int flow_type)
-{
-	unsigned int irq_nr = d->irq - TXX9_IRQ_BASE;
-	u32 cr;
-	u32 __iomem *crp;
-	int ofs;
-	int mode;
-
-	if (flow_type & IRQF_TRIGGER_PROBE)
-		return 0;
-	switch (flow_type & IRQF_TRIGGER_MASK) {
-	case IRQF_TRIGGER_RISING:
-		mode = TXx9_IRCR_UP;
-		break;
-	case IRQF_TRIGGER_FALLING:
-		mode = TXx9_IRCR_DOWN;
-		break;
-	case IRQF_TRIGGER_HIGH:
-		mode = TXx9_IRCR_HIGH;
-		break;
-	case IRQF_TRIGGER_LOW:
-		mode = TXx9_IRCR_LOW;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (irq_nr < 32) {
-		irq_nr--;
-		crp = &tx4939_ircptr->dm[(irq_nr & 8) >> 3].r;
-	} else {
-		irq_nr -= 32;
-		crp = &tx4939_ircptr->dm2[((irq_nr & 8) >> 3)].r;
-	}
-	ofs = (((irq_nr & 16) >> 1) | (irq_nr & (8 - 1))) * 2;
-	cr = __raw_readl(crp);
-	cr &= ~(0x3 << ofs);
-	cr |= (mode & 0x3) << ofs;
-	__raw_writel(cr, crp);
-	tx4939irq[irq_nr].mode = mode;
-	return 0;
-}
-
-static struct irq_chip tx4939_irq_chip = {
-	.name		= "TX4939",
-	.irq_ack	= tx4939_irq_mask_ack,
-	.irq_mask	= tx4939_irq_mask,
-	.irq_mask_ack	= tx4939_irq_mask_ack,
-	.irq_unmask	= tx4939_irq_unmask,
-	.irq_set_type	= tx4939_irq_set_type,
-};
-
-static int tx4939_irq_set_pri(int irc_irq, int new_pri)
-{
-	int old_pri;
-
-	if ((unsigned int)irc_irq >= TX4939_NUM_IR)
-		return 0;
-	old_pri = tx4939irq[irc_irq].level;
-	tx4939irq[irc_irq].level = new_pri;
-	return old_pri;
-}
-
-void __init tx4939_irq_init(void)
-{
-	int i;
-
-	mips_cpu_irq_init();
-	/* disable interrupt control */
-	__raw_writel(0, &tx4939_ircptr->den.r);
-	__raw_writel(0, &tx4939_ircptr->maskint.r);
-	__raw_writel(0, &tx4939_ircptr->maskext.r);
-	/* irq_base + 0 is not used */
-	for (i = 1; i < TX4939_NUM_IR; i++) {
-		tx4939irq[i].level = 4; /* middle level */
-		tx4939irq[i].mode = TXx9_IRCR_LOW;
-		irq_set_chip_and_handler(TXX9_IRQ_BASE + i, &tx4939_irq_chip,
-					 handle_level_irq);
-	}
-
-	/* mask all IRC interrupts */
-	__raw_writel(0, &tx4939_ircptr->msk.r);
-	for (i = 0; i < 16; i++)
-		__raw_writel(0, &tx4939_ircptr->lvl[i].r);
-	/* setup IRC interrupt mode (Low Active) */
-	for (i = 0; i < 2; i++)
-		__raw_writel(0, &tx4939_ircptr->dm[i].r);
-	for (i = 0; i < 2; i++)
-		__raw_writel(0, &tx4939_ircptr->dm2[i].r);
-	/* enable interrupt control */
-	__raw_writel(TXx9_IRCER_ICE, &tx4939_ircptr->den.r);
-	__raw_writel(irc_elevel, &tx4939_ircptr->msk.r);
-
-	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + TX4939_IRC_INT,
-				handle_simple_irq);
-
-	/* raise priority for errors, timers, sio */
-	tx4939_irq_set_pri(TX4939_IR_WTOERR, 7);
-	tx4939_irq_set_pri(TX4939_IR_PCIERR, 7);
-	tx4939_irq_set_pri(TX4939_IR_PCIPME, 7);
-	for (i = 0; i < TX4939_NUM_IR_TMR; i++)
-		tx4939_irq_set_pri(TX4939_IR_TMR(i), 6);
-	for (i = 0; i < TX4939_NUM_IR_SIO; i++)
-		tx4939_irq_set_pri(TX4939_IR_SIO(i), 5);
-}
-
-int tx4939_irq(void)
-{
-	u32 csr = __raw_readl(&tx4939_ircptr->cs.r);
-
-	if (likely(!(csr & TXx9_IRCSR_IF)))
-		return TXX9_IRQ_BASE + (csr & (TX4939_NUM_IR - 1));
-	return -1;
-}
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
deleted file mode 100644
index f5f59b7401a3..000000000000
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ /dev/null
@@ -1,568 +0,0 @@
-/*
- * TX4939 setup routines
- * Based on linux/arch/mips/txx9/generic/setup_tx4938.c,
- *	    and RBTX49xx patch from CELF patch archive.
- *
- * 2003-2005 (c) MontaVista Software, Inc.
- * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/notifier.h>
-#include <linux/device.h>
-#include <linux/ethtool.h>
-#include <linux/param.h>
-#include <linux/ptrace.h>
-#include <linux/mtd/physmap.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/txx9/ndfmc.h>
-#include <asm/reboot.h>
-#include <asm/traps.h>
-#include <asm/txx9irq.h>
-#include <asm/txx9tmr.h>
-#include <asm/txx9/generic.h>
-#include <asm/txx9/dmac.h>
-#include <asm/txx9/tx4939.h>
-
-static void __init tx4939_wdr_init(void)
-{
-	/* report watchdog reset status */
-	if (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDRST)
-		pr_warn("Watchdog reset detected at 0x%lx\n",
-			read_c0_errorepc());
-	/* clear WatchDogReset (W1C) */
-	tx4939_ccfg_set(TX4939_CCFG_WDRST);
-	/* do reset on watchdog */
-	tx4939_ccfg_set(TX4939_CCFG_WR);
-}
-
-void __init tx4939_wdt_init(void)
-{
-	txx9_wdt_init(TX4939_TMR_REG(2) & 0xfffffffffULL);
-}
-
-static void tx4939_machine_restart(char *command)
-{
-	local_irq_disable();
-	pr_emerg("Rebooting (with %s watchdog reset)...\n",
-		 (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDREXEN) ?
-		 "external" : "internal");
-	/* clear watchdog status */
-	tx4939_ccfg_set(TX4939_CCFG_WDRST);	/* W1C */
-	txx9_wdt_now(TX4939_TMR_REG(2) & 0xfffffffffULL);
-	while (!(____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDRST))
-		;
-	mdelay(10);
-	if (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_WDREXEN) {
-		pr_emerg("Rebooting (with internal watchdog reset)...\n");
-		/* External WDRST failed.  Do internal watchdog reset */
-		tx4939_ccfg_clear(TX4939_CCFG_WDREXEN);
-	}
-	/* fallback */
-	(*_machine_halt)();
-}
-
-void show_registers(struct pt_regs *regs);
-static int tx4939_be_handler(struct pt_regs *regs, int is_fixup)
-{
-	int data = regs->cp0_cause & 4;
-	console_verbose();
-	pr_err("%cBE exception at %#lx\n",
-	       data ? 'D' : 'I', regs->cp0_epc);
-	pr_err("ccfg:%llx, toea:%llx\n",
-	       (unsigned long long)____raw_readq(&tx4939_ccfgptr->ccfg),
-	       (unsigned long long)____raw_readq(&tx4939_ccfgptr->toea));
-#ifdef CONFIG_PCI
-	tx4927_report_pcic_status();
-#endif
-	show_registers(regs);
-	panic("BusError!");
-}
-static void __init tx4939_be_init(void)
-{
-	mips_set_be_handler(tx4939_be_handler);
-}
-
-static struct resource tx4939_sdram_resource[4];
-static struct resource tx4939_sram_resource;
-#define TX4939_SRAM_SIZE 0x800
-
-void __init tx4939_setup(void)
-{
-	int i;
-	__u32 divmode;
-	__u64 pcfg;
-	unsigned int cpuclk = 0;
-
-	txx9_reg_res_init(TX4939_REV_PCODE(), TX4939_REG_BASE,
-			  TX4939_REG_SIZE);
-	set_c0_config(TX49_CONF_CWFON);
-
-	/* SDRAMC,EBUSC are configured by PROM */
-	for (i = 0; i < 4; i++) {
-		if (!(TX4939_EBUSC_CR(i) & 0x8))
-			continue;	/* disabled */
-		txx9_ce_res[i].start = (unsigned long)TX4939_EBUSC_BA(i);
-		txx9_ce_res[i].end =
-			txx9_ce_res[i].start + TX4939_EBUSC_SIZE(i) - 1;
-		request_resource(&iomem_resource, &txx9_ce_res[i]);
-	}
-
-	/* clocks */
-	if (txx9_master_clock) {
-		/* calculate cpu_clock from master_clock */
-		divmode = (__u32)____raw_readq(&tx4939_ccfgptr->ccfg) &
-			TX4939_CCFG_MULCLK_MASK;
-		cpuclk = txx9_master_clock * 20 / 2;
-		switch (divmode) {
-		case TX4939_CCFG_MULCLK_8:
-			cpuclk = cpuclk / 3 * 4 /* / 6 *  8 */; break;
-		case TX4939_CCFG_MULCLK_9:
-			cpuclk = cpuclk / 2 * 3 /* / 6 *  9 */; break;
-		case TX4939_CCFG_MULCLK_10:
-			cpuclk = cpuclk / 3 * 5 /* / 6 * 10 */; break;
-		case TX4939_CCFG_MULCLK_11:
-			cpuclk = cpuclk / 6 * 11; break;
-		case TX4939_CCFG_MULCLK_12:
-			cpuclk = cpuclk * 2 /* / 6 * 12 */; break;
-		case TX4939_CCFG_MULCLK_13:
-			cpuclk = cpuclk / 6 * 13; break;
-		case TX4939_CCFG_MULCLK_14:
-			cpuclk = cpuclk / 3 * 7 /* / 6 * 14 */; break;
-		case TX4939_CCFG_MULCLK_15:
-			cpuclk = cpuclk / 2 * 5 /* / 6 * 15 */; break;
-		}
-		txx9_cpu_clock = cpuclk;
-	} else {
-		if (txx9_cpu_clock == 0)
-			txx9_cpu_clock = 400000000;	/* 400MHz */
-		/* calculate master_clock from cpu_clock */
-		cpuclk = txx9_cpu_clock;
-		divmode = (__u32)____raw_readq(&tx4939_ccfgptr->ccfg) &
-			TX4939_CCFG_MULCLK_MASK;
-		switch (divmode) {
-		case TX4939_CCFG_MULCLK_8:
-			txx9_master_clock = cpuclk * 6 / 8; break;
-		case TX4939_CCFG_MULCLK_9:
-			txx9_master_clock = cpuclk * 6 / 9; break;
-		case TX4939_CCFG_MULCLK_10:
-			txx9_master_clock = cpuclk * 6 / 10; break;
-		case TX4939_CCFG_MULCLK_11:
-			txx9_master_clock = cpuclk * 6 / 11; break;
-		case TX4939_CCFG_MULCLK_12:
-			txx9_master_clock = cpuclk * 6 / 12; break;
-		case TX4939_CCFG_MULCLK_13:
-			txx9_master_clock = cpuclk * 6 / 13; break;
-		case TX4939_CCFG_MULCLK_14:
-			txx9_master_clock = cpuclk * 6 / 14; break;
-		case TX4939_CCFG_MULCLK_15:
-			txx9_master_clock = cpuclk * 6 / 15; break;
-		}
-		txx9_master_clock /= 10; /* * 2 / 20 */
-	}
-	/* calculate gbus_clock from cpu_clock */
-	divmode = (__u32)____raw_readq(&tx4939_ccfgptr->ccfg) &
-		TX4939_CCFG_YDIVMODE_MASK;
-	txx9_gbus_clock = txx9_cpu_clock;
-	switch (divmode) {
-	case TX4939_CCFG_YDIVMODE_2:
-		txx9_gbus_clock /= 2; break;
-	case TX4939_CCFG_YDIVMODE_3:
-		txx9_gbus_clock /= 3; break;
-	case TX4939_CCFG_YDIVMODE_5:
-		txx9_gbus_clock /= 5; break;
-	case TX4939_CCFG_YDIVMODE_6:
-		txx9_gbus_clock /= 6; break;
-	}
-	/* change default value to udelay/mdelay take reasonable time */
-	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
-
-	/* CCFG */
-	tx4939_wdr_init();
-	/* clear BusErrorOnWrite flag (W1C) */
-	tx4939_ccfg_set(TX4939_CCFG_WDRST | TX4939_CCFG_BEOW);
-	/* enable Timeout BusError */
-	if (txx9_ccfg_toeon)
-		tx4939_ccfg_set(TX4939_CCFG_TOE);
-
-	/* DMA selection */
-	txx9_clear64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_DMASEL_ALL);
-
-	/* Use external clock for external arbiter */
-	if (!(____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_PCIARB))
-		txx9_clear64(&tx4939_ccfgptr->pcfg, TX4939_PCFG_PCICLKEN_ALL);
-
-	pr_info("%s -- %dMHz(M%dMHz,G%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
-		txx9_pcode_str,
-		(cpuclk + 500000) / 1000000,
-		(txx9_master_clock + 500000) / 1000000,
-		(txx9_gbus_clock + 500000) / 1000000,
-		(__u32)____raw_readq(&tx4939_ccfgptr->crir),
-		____raw_readq(&tx4939_ccfgptr->ccfg),
-		____raw_readq(&tx4939_ccfgptr->pcfg));
-
-	pr_info("%s DDRC -- EN:%08x", txx9_pcode_str,
-		(__u32)____raw_readq(&tx4939_ddrcptr->winen));
-	for (i = 0; i < 4; i++) {
-		__u64 win = ____raw_readq(&tx4939_ddrcptr->win[i]);
-		if (!((__u32)____raw_readq(&tx4939_ddrcptr->winen) & (1 << i)))
-			continue;	/* disabled */
-		pr_cont(" #%d:%016llx", i, win);
-		tx4939_sdram_resource[i].name = "DDR SDRAM";
-		tx4939_sdram_resource[i].start =
-			(unsigned long)(win >> 48) << 20;
-		tx4939_sdram_resource[i].end =
-			((((unsigned long)(win >> 32) & 0xffff) + 1) <<
-			 20) - 1;
-		tx4939_sdram_resource[i].flags = IORESOURCE_MEM;
-		request_resource(&iomem_resource, &tx4939_sdram_resource[i]);
-	}
-	pr_cont("\n");
-
-	/* SRAM */
-	if (____raw_readq(&tx4939_sramcptr->cr) & 1) {
-		unsigned int size = TX4939_SRAM_SIZE;
-		tx4939_sram_resource.name = "SRAM";
-		tx4939_sram_resource.start =
-			(____raw_readq(&tx4939_sramcptr->cr) >> (39-11))
-			& ~(size - 1);
-		tx4939_sram_resource.end =
-			tx4939_sram_resource.start + TX4939_SRAM_SIZE - 1;
-		tx4939_sram_resource.flags = IORESOURCE_MEM;
-		request_resource(&iomem_resource, &tx4939_sram_resource);
-	}
-
-	/* TMR */
-	/* disable all timers */
-	for (i = 0; i < TX4939_NR_TMR; i++)
-		txx9_tmr_init(TX4939_TMR_REG(i) & 0xfffffffffULL);
-
-	/* set PCIC1 reset (required to prevent hangup on BIST) */
-	txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1RST);
-	pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
-	if (pcfg & (TX4939_PCFG_ET0MODE | TX4939_PCFG_ET1MODE)) {
-		mdelay(1);	/* at least 128 cpu clock */
-		/* clear PCIC1 reset */
-		txx9_clear64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1RST);
-	} else {
-		pr_info("%s: stop PCIC1\n", txx9_pcode_str);
-		/* stop PCIC1 */
-		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_PCI1CKD);
-	}
-	if (!(pcfg & TX4939_PCFG_ET0MODE)) {
-		pr_info("%s: stop ETH0\n", txx9_pcode_str);
-		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH0RST);
-		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH0CKD);
-	}
-	if (!(pcfg & TX4939_PCFG_ET1MODE)) {
-		pr_info("%s: stop ETH1\n", txx9_pcode_str);
-		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH1RST);
-		txx9_set64(&tx4939_ccfgptr->clkctr, TX4939_CLKCTR_ETH1CKD);
-	}
-
-	_machine_restart = tx4939_machine_restart;
-	board_be_init = tx4939_be_init;
-}
-
-void __init tx4939_time_init(unsigned int tmrnr)
-{
-	if (____raw_readq(&tx4939_ccfgptr->ccfg) & TX4939_CCFG_TINTDIS)
-		txx9_clockevent_init(TX4939_TMR_REG(tmrnr) & 0xfffffffffULL,
-				     TXX9_IRQ_BASE + TX4939_IR_TMR(tmrnr),
-				     TXX9_IMCLK);
-}
-
-void __init tx4939_sio_init(unsigned int sclk, unsigned int cts_mask)
-{
-	int i;
-	unsigned int ch_mask = 0;
-	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
-
-	cts_mask |= ~1; /* only SIO0 have RTS/CTS */
-	if ((pcfg & TX4939_PCFG_SIO2MODE_MASK) != TX4939_PCFG_SIO2MODE_SIO0)
-		cts_mask |= 1 << 0; /* disable SIO0 RTS/CTS by PCFG setting */
-	if ((pcfg & TX4939_PCFG_SIO2MODE_MASK) != TX4939_PCFG_SIO2MODE_SIO2)
-		ch_mask |= 1 << 2; /* disable SIO2 by PCFG setting */
-	if (pcfg & TX4939_PCFG_SIO3MODE)
-		ch_mask |= 1 << 3; /* disable SIO3 by PCFG setting */
-	for (i = 0; i < 4; i++) {
-		if ((1 << i) & ch_mask)
-			continue;
-		txx9_sio_init(TX4939_SIO_REG(i) & 0xfffffffffULL,
-			      TXX9_IRQ_BASE + TX4939_IR_SIO(i),
-			      i, sclk, (1 << i) & cts_mask);
-	}
-}
-
-#if IS_ENABLED(CONFIG_TC35815)
-static u32 tx4939_get_eth_speed(struct net_device *dev)
-{
-	struct ethtool_link_ksettings cmd;
-
-	if (__ethtool_get_link_ksettings(dev, &cmd))
-		return 100;	/* default 100Mbps */
-
-	return cmd.base.speed;
-}
-
-static int tx4939_netdev_event(struct notifier_block *this,
-			       unsigned long event,
-			       void *ptr)
-{
-	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-
-	if (event == NETDEV_CHANGE && netif_carrier_ok(dev)) {
-		__u64 bit = 0;
-		if (dev->irq == TXX9_IRQ_BASE + TX4939_IR_ETH(0))
-			bit = TX4939_PCFG_SPEED0;
-		else if (dev->irq == TXX9_IRQ_BASE + TX4939_IR_ETH(1))
-			bit = TX4939_PCFG_SPEED1;
-		if (bit) {
-			if (tx4939_get_eth_speed(dev) == 100)
-				txx9_set64(&tx4939_ccfgptr->pcfg, bit);
-			else
-				txx9_clear64(&tx4939_ccfgptr->pcfg, bit);
-		}
-	}
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block tx4939_netdev_notifier = {
-	.notifier_call = tx4939_netdev_event,
-	.priority = 1,
-};
-
-void __init tx4939_ethaddr_init(unsigned char *addr0, unsigned char *addr1)
-{
-	u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
-
-	if (addr0 && (pcfg & TX4939_PCFG_ET0MODE))
-		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4939_IR_ETH(0), addr0);
-	if (addr1 && (pcfg & TX4939_PCFG_ET1MODE))
-		txx9_ethaddr_init(TXX9_IRQ_BASE + TX4939_IR_ETH(1), addr1);
-	register_netdevice_notifier(&tx4939_netdev_notifier);
-}
-#else
-void __init tx4939_ethaddr_init(unsigned char *addr0, unsigned char *addr1)
-{
-}
-#endif
-
-void __init tx4939_mtd_init(int ch)
-{
-	struct physmap_flash_data pdata = {
-		.width = TX4939_EBUSC_WIDTH(ch) / 8,
-	};
-	unsigned long start = txx9_ce_res[ch].start;
-	unsigned long size = txx9_ce_res[ch].end - start + 1;
-
-	if (!(TX4939_EBUSC_CR(ch) & 0x8))
-		return; /* disabled */
-	txx9_physmap_flash_init(ch, start, size, &pdata);
-}
-
-#define TX4939_ATA_REG_PHYS(ch) (TX4939_ATA_REG(ch) & 0xfffffffffULL)
-void __init tx4939_ata_init(void)
-{
-	static struct resource ata0_res[] = {
-		{
-			.start = TX4939_ATA_REG_PHYS(0),
-			.end = TX4939_ATA_REG_PHYS(0) + 0x1000 - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = TXX9_IRQ_BASE + TX4939_IR_ATA(0),
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-	static struct resource ata1_res[] = {
-		{
-			.start = TX4939_ATA_REG_PHYS(1),
-			.end = TX4939_ATA_REG_PHYS(1) + 0x1000 - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = TXX9_IRQ_BASE + TX4939_IR_ATA(1),
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-	static struct platform_device ata0_dev = {
-		.name = "tx4939ide",
-		.id = 0,
-		.num_resources = ARRAY_SIZE(ata0_res),
-		.resource = ata0_res,
-	};
-	static struct platform_device ata1_dev = {
-		.name = "tx4939ide",
-		.id = 1,
-		.num_resources = ARRAY_SIZE(ata1_res),
-		.resource = ata1_res,
-	};
-	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
-
-	if (pcfg & TX4939_PCFG_ATA0MODE)
-		platform_device_register(&ata0_dev);
-	if ((pcfg & (TX4939_PCFG_ATA1MODE |
-		     TX4939_PCFG_ET1MODE |
-		     TX4939_PCFG_ET0MODE)) == TX4939_PCFG_ATA1MODE)
-		platform_device_register(&ata1_dev);
-}
-
-void __init tx4939_rtc_init(void)
-{
-	static struct resource res[] = {
-		{
-			.start = TX4939_RTC_REG & 0xfffffffffULL,
-			.end = (TX4939_RTC_REG & 0xfffffffffULL) + 0x100 - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = TXX9_IRQ_BASE + TX4939_IR_RTC,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-	static struct platform_device rtc_dev = {
-		.name = "tx4939rtc",
-		.id = -1,
-		.num_resources = ARRAY_SIZE(res),
-		.resource = res,
-	};
-
-	platform_device_register(&rtc_dev);
-}
-
-void __init tx4939_ndfmc_init(unsigned int hold, unsigned int spw,
-			      unsigned char ch_mask, unsigned char wide_mask)
-{
-	struct txx9ndfmc_platform_data plat_data = {
-		.shift = 1,
-		.gbus_clock = txx9_gbus_clock,
-		.hold = hold,
-		.spw = spw,
-		.flags = NDFMC_PLAT_FLAG_NO_RSTR | NDFMC_PLAT_FLAG_HOLDADD |
-			 NDFMC_PLAT_FLAG_DUMMYWRITE,
-		.ch_mask = ch_mask,
-		.wide_mask = wide_mask,
-	};
-	txx9_ndfmc_init(TX4939_NDFMC_REG & 0xfffffffffULL, &plat_data);
-}
-
-void __init tx4939_dmac_init(int memcpy_chan0, int memcpy_chan1)
-{
-	struct txx9dmac_platform_data plat_data = {
-		.have_64bit_regs = true,
-	};
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		plat_data.memcpy_chan = i ? memcpy_chan1 : memcpy_chan0;
-		txx9_dmac_init(i, TX4939_DMA_REG(i) & 0xfffffffffULL,
-			       TXX9_IRQ_BASE + TX4939_IR_DMA(i, 0),
-			       &plat_data);
-	}
-}
-
-void __init tx4939_aclc_init(void)
-{
-	u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
-
-	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) == TX4939_PCFG_I2SMODE_ACLC)
-		txx9_aclc_init(TX4939_ACLC_REG & 0xfffffffffULL,
-			       TXX9_IRQ_BASE + TX4939_IR_ACLC, 1, 0, 1);
-}
-
-void __init tx4939_sramc_init(void)
-{
-	if (tx4939_sram_resource.start)
-		txx9_sramc_init(&tx4939_sram_resource);
-}
-
-void __init tx4939_rng_init(void)
-{
-	static struct resource res = {
-		.start = TX4939_RNG_REG & 0xfffffffffULL,
-		.end = (TX4939_RNG_REG & 0xfffffffffULL) + 0x30 - 1,
-		.flags = IORESOURCE_MEM,
-	};
-	static struct platform_device pdev = {
-		.name = "tx4939-rng",
-		.id = -1,
-		.num_resources = 1,
-		.resource = &res,
-	};
-
-	platform_device_register(&pdev);
-}
-
-static void __init tx4939_stop_unused_modules(void)
-{
-	__u64 pcfg, rst = 0, ckd = 0;
-	char buf[128];
-
-	buf[0] = '\0';
-	local_irq_disable();
-	pcfg = ____raw_readq(&tx4939_ccfgptr->pcfg);
-	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) !=
-	    TX4939_PCFG_I2SMODE_ACLC) {
-		rst |= TX4939_CLKCTR_ACLRST;
-		ckd |= TX4939_CLKCTR_ACLCKD;
-		strcat(buf, " ACLC");
-	}
-	if ((pcfg & TX4939_PCFG_I2SMODE_MASK) !=
-	    TX4939_PCFG_I2SMODE_I2S &&
-	    (pcfg & TX4939_PCFG_I2SMODE_MASK) !=
-	    TX4939_PCFG_I2SMODE_I2S_ALT) {
-		rst |= TX4939_CLKCTR_I2SRST;
-		ckd |= TX4939_CLKCTR_I2SCKD;
-		strcat(buf, " I2S");
-	}
-	if (!(pcfg & TX4939_PCFG_ATA0MODE)) {
-		rst |= TX4939_CLKCTR_ATA0RST;
-		ckd |= TX4939_CLKCTR_ATA0CKD;
-		strcat(buf, " ATA0");
-	}
-	if (!(pcfg & TX4939_PCFG_ATA1MODE)) {
-		rst |= TX4939_CLKCTR_ATA1RST;
-		ckd |= TX4939_CLKCTR_ATA1CKD;
-		strcat(buf, " ATA1");
-	}
-	if (pcfg & TX4939_PCFG_SPIMODE) {
-		rst |= TX4939_CLKCTR_SPIRST;
-		ckd |= TX4939_CLKCTR_SPICKD;
-		strcat(buf, " SPI");
-	}
-	if (!(pcfg & (TX4939_PCFG_VSSMODE | TX4939_PCFG_VPSMODE))) {
-		rst |= TX4939_CLKCTR_VPCRST;
-		ckd |= TX4939_CLKCTR_VPCCKD;
-		strcat(buf, " VPC");
-	}
-	if ((pcfg & TX4939_PCFG_SIO2MODE_MASK) != TX4939_PCFG_SIO2MODE_SIO2) {
-		rst |= TX4939_CLKCTR_SIO2RST;
-		ckd |= TX4939_CLKCTR_SIO2CKD;
-		strcat(buf, " SIO2");
-	}
-	if (pcfg & TX4939_PCFG_SIO3MODE) {
-		rst |= TX4939_CLKCTR_SIO3RST;
-		ckd |= TX4939_CLKCTR_SIO3CKD;
-		strcat(buf, " SIO3");
-	}
-	if (rst | ckd) {
-		txx9_set64(&tx4939_ccfgptr->clkctr, rst);
-		txx9_set64(&tx4939_ccfgptr->clkctr, ckd);
-	}
-	local_irq_enable();
-	if (buf[0])
-		pr_info("%s: stop%s\n", txx9_pcode_str, buf);
-}
-
-static int __init tx4939_late_init(void)
-{
-	if (txx9_pcode != 0x4939)
-		return -ENODEV;
-	tx4939_stop_unused_modules();
-	return 0;
-}
-late_initcall(tx4939_late_init);
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 814b3d0ca7b7..a70d27e4ff7f 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -226,19 +226,6 @@ config HW_RANDOM_VIRTIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called virtio-rng.  If unsure, say N.
 
-config HW_RANDOM_TX4939
-	tristate "TX4939 Random Number Generator support"
-	depends on SOC_TX4939
-	default HW_RANDOM
-	help
-	  This driver provides kernel-side support for the Random Number
-	  Generator hardware found on TX4939 SoC.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called tx4939-rng.
-
-	  If unsure, say Y.
-
 config HW_RANDOM_MXC_RNGA
 	tristate "Freescale i.MX RNGA Random Number Generator"
 	depends on SOC_IMX31
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index a5a1c765a394..b4f9b621b447 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP3_ROM) += omap3-rom-rng.o
 obj-$(CONFIG_HW_RANDOM_PASEMI) += pasemi-rng.o
 obj-$(CONFIG_HW_RANDOM_VIRTIO) += virtio-rng.o
-obj-$(CONFIG_HW_RANDOM_TX4939) += tx4939-rng.o
 obj-$(CONFIG_HW_RANDOM_MXC_RNGA) += mxc-rnga.o
 obj-$(CONFIG_HW_RANDOM_IMX_RNGC) += imx-rngc.o
 obj-$(CONFIG_HW_RANDOM_INGENIC_RNG) += ingenic-rng.o
diff --git a/drivers/char/hw_random/tx4939-rng.c b/drivers/char/hw_random/tx4939-rng.c
deleted file mode 100644
index c8bd34e740fd..000000000000
--- a/drivers/char/hw_random/tx4939-rng.c
+++ /dev/null
@@ -1,157 +0,0 @@
-/*
- * RNG driver for TX4939 Random Number Generators (RNG)
- *
- * Copyright (C) 2009 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/hw_random.h>
-#include <linux/gfp.h>
-
-#define TX4939_RNG_RCSR		0x00000000
-#define TX4939_RNG_ROR(n)	(0x00000018 + (n) * 8)
-
-#define TX4939_RNG_RCSR_INTE	0x00000008
-#define TX4939_RNG_RCSR_RST	0x00000004
-#define TX4939_RNG_RCSR_FIN	0x00000002
-#define TX4939_RNG_RCSR_ST	0x00000001
-
-struct tx4939_rng {
-	struct hwrng rng;
-	void __iomem *base;
-	u64 databuf[3];
-	unsigned int data_avail;
-};
-
-static void rng_io_start(void)
-{
-#ifndef CONFIG_64BIT
-	/*
-	 * readq is reading a 64-bit register using a 64-bit load.  On
-	 * a 32-bit kernel however interrupts or any other processor
-	 * exception would clobber the upper 32-bit of the processor
-	 * register so interrupts need to be disabled.
-	 */
-	local_irq_disable();
-#endif
-}
-
-static void rng_io_end(void)
-{
-#ifndef CONFIG_64BIT
-	local_irq_enable();
-#endif
-}
-
-static u64 read_rng(void __iomem *base, unsigned int offset)
-{
-	return ____raw_readq(base + offset);
-}
-
-static void write_rng(u64 val, void __iomem *base, unsigned int offset)
-{
-	return ____raw_writeq(val, base + offset);
-}
-
-static int tx4939_rng_data_present(struct hwrng *rng, int wait)
-{
-	struct tx4939_rng *rngdev = container_of(rng, struct tx4939_rng, rng);
-	int i;
-
-	if (rngdev->data_avail)
-		return rngdev->data_avail;
-	for (i = 0; i < 20; i++) {
-		rng_io_start();
-		if (!(read_rng(rngdev->base, TX4939_RNG_RCSR)
-		      & TX4939_RNG_RCSR_ST)) {
-			rngdev->databuf[0] =
-				read_rng(rngdev->base, TX4939_RNG_ROR(0));
-			rngdev->databuf[1] =
-				read_rng(rngdev->base, TX4939_RNG_ROR(1));
-			rngdev->databuf[2] =
-				read_rng(rngdev->base, TX4939_RNG_ROR(2));
-			rngdev->data_avail =
-				sizeof(rngdev->databuf) / sizeof(u32);
-			/* Start RNG */
-			write_rng(TX4939_RNG_RCSR_ST,
-				  rngdev->base, TX4939_RNG_RCSR);
-			wait = 0;
-		}
-		rng_io_end();
-		if (!wait)
-			break;
-		/* 90 bus clock cycles by default for generation */
-		ndelay(90 * 5);
-	}
-	return rngdev->data_avail;
-}
-
-static int tx4939_rng_data_read(struct hwrng *rng, u32 *buffer)
-{
-	struct tx4939_rng *rngdev = container_of(rng, struct tx4939_rng, rng);
-
-	rngdev->data_avail--;
-	*buffer = *((u32 *)&rngdev->databuf + rngdev->data_avail);
-	return sizeof(u32);
-}
-
-static int __init tx4939_rng_probe(struct platform_device *dev)
-{
-	struct tx4939_rng *rngdev;
-	int i;
-
-	rngdev = devm_kzalloc(&dev->dev, sizeof(*rngdev), GFP_KERNEL);
-	if (!rngdev)
-		return -ENOMEM;
-	rngdev->base = devm_platform_ioremap_resource(dev, 0);
-	if (IS_ERR(rngdev->base))
-		return PTR_ERR(rngdev->base);
-
-	rngdev->rng.name = dev_name(&dev->dev);
-	rngdev->rng.data_present = tx4939_rng_data_present;
-	rngdev->rng.data_read = tx4939_rng_data_read;
-
-	rng_io_start();
-	/* Reset RNG */
-	write_rng(TX4939_RNG_RCSR_RST, rngdev->base, TX4939_RNG_RCSR);
-	write_rng(0, rngdev->base, TX4939_RNG_RCSR);
-	/* Start RNG */
-	write_rng(TX4939_RNG_RCSR_ST, rngdev->base, TX4939_RNG_RCSR);
-	rng_io_end();
-	/*
-	 * Drop first two results.  From the datasheet:
-	 * The quality of the random numbers generated immediately
-	 * after reset can be insufficient.  Therefore, do not use
-	 * random numbers obtained from the first and second
-	 * generations; use the ones from the third or subsequent
-	 * generation.
-	 */
-	for (i = 0; i < 2; i++) {
-		rngdev->data_avail = 0;
-		if (!tx4939_rng_data_present(&rngdev->rng, 1))
-			return -EIO;
-	}
-
-	platform_set_drvdata(dev, rngdev);
-	return devm_hwrng_register(&dev->dev, &rngdev->rng);
-}
-
-static struct platform_driver tx4939_rng_driver = {
-	.driver		= {
-		.name	= "tx4939-rng",
-	},
-};
-
-module_platform_driver_probe(tx4939_rng_driver, tx4939_rng_probe);
-
-MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver for TX4939");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 67b7cb67c030..8af11511ddb0 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -308,7 +308,7 @@ config MTD_NAND_DAVINCI
 
 config MTD_NAND_TXX9NDFMC
 	tristate "TXx9 NAND controller"
-	depends on SOC_TX4938 || SOC_TX4939 || COMPILE_TEST
+	depends on SOC_TX4938 || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This enables the NAND flash controller on the TXx9 SoCs.
-- 
2.29.2

