Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7946ECBF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbhLIQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240974AbhLIQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:49 -0500
Date:   Thu, 09 Dec 2021 16:07:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIq0CoxNk2YLeOTywVz/OGWaKHUKzjDq7A+dO41TXos=;
        b=lWC2a27Tk0fJMLsLG5R2XOkxhlfYBIOME3K037GKSlxId/lNEl7S7PEt/M1TBzwKjiXa+m
        3Ej3shyJhP59l3DYEfGQBEcUz1UsD8ZZ8aw0nWzcXjSM7cL6t5leF8YuNy2qaSXFJHcNd/
        gvjdk04HDuFlFOQyBJ+btaQcXZtMG/AqXMLcUv8/XSkEWEqApdqzg+W/qmW6iWETmUXHvU
        yj/2LzIjwEfdjrZVoaPa4XXQdcda9pexah32bjpZ+OQVbQoLXFOzItsupKKiygbmKzbEFW
        XHWx3u8RQMJ/ouZ0TQuLTZPFiIc5MdXOQoWALu5FUmnwUsFjzysuBuxVUpYzyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIq0CoxNk2YLeOTywVz/OGWaKHUKzjDq7A+dO41TXos=;
        b=iJ40QHQ32HmS3e8MgxF0lq+JyAtsBi/8q+B7B2s5XpyNU+70jc82tS0SL5iikvvU7sNs5t
        GoM/c0a1KAGJYYCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/4xx: Remove MSI support which never worked
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210223.872249537@linutronix.de>
References: <20211206210223.872249537@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906603449.11128.6362874834669191695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     4f1d038b5ea1b45d8265a5407712f975b600bb94
Gitweb:        https://git.kernel.org/tip/4f1d038b5ea1b45d8265a5407712f975b600bb94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:20 +01:00

powerpc/4xx: Remove MSI support which never worked

This code is broken since day one. ppc4xx_setup_msi_irqs() has the
following gems:

 1) The handling of the result of msi_bitmap_alloc_hwirqs() is completely
    broken:
    
    When the result is greater than or equal 0 (bitmap allocation
    successful) then the loop terminates and the function returns 0
    (success) despite not having installed an interrupt.

    When the result is less than 0 (bitmap allocation fails), it prints an
    error message and continues to "work" with that error code which would
    eventually end up in the MSI message data.

 2) On every invocation the file global pp4xx_msi::msi_virqs bitmap is
    allocated thereby leaking the previous one.

IOW, this has never worked and for more than 10 years nobody cared. Remove
the gunk.

Fixes: 3fb7933850fa ("powerpc/4xx: Adding PCIe MSI support")
Fixes: 247540b03bfc ("powerpc/44x: Fix PCI MSI support for Maui APM821xx SoC and Bluestone board")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210223.872249537@linutronix.de

---
 arch/powerpc/platforms/4xx/Makefile |   1 +-
 arch/powerpc/platforms/4xx/msi.c    | 281 +---------------------------
 arch/powerpc/sysdev/Kconfig         |   6 +-
 3 files changed, 288 deletions(-)
 delete mode 100644 arch/powerpc/platforms/4xx/msi.c

diff --git a/arch/powerpc/platforms/4xx/Makefile b/arch/powerpc/platforms/4xx/Makefile
index d009d2e..2071a0a 100644
--- a/arch/powerpc/platforms/4xx/Makefile
+++ b/arch/powerpc/platforms/4xx/Makefile
@@ -3,6 +3,5 @@ obj-y				+= uic.o machine_check.o
 obj-$(CONFIG_4xx_SOC)		+= soc.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
-obj-$(CONFIG_PPC4xx_MSI)	+= msi.o
 obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
 obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/msi.c
deleted file mode 100644
index 1051564..0000000
--- a/arch/powerpc/platforms/4xx/msi.c
+++ /dev/null
@@ -1,281 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Adding PCI-E MSI support for PPC4XX SoCs.
- *
- * Copyright (c) 2010, Applied Micro Circuits Corporation
- * Authors:	Tirumala R Marri <tmarri@apm.com>
- *		Feng Kan <fkan@apm.com>
- */
-
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/msi.h>
-#include <linux/of_platform.h>
-#include <linux/interrupt.h>
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <asm/prom.h>
-#include <asm/hw_irq.h>
-#include <asm/ppc-pci.h>
-#include <asm/dcr.h>
-#include <asm/dcr-regs.h>
-#include <asm/msi_bitmap.h>
-
-#define PEIH_TERMADH	0x00
-#define PEIH_TERMADL	0x08
-#define PEIH_MSIED	0x10
-#define PEIH_MSIMK	0x18
-#define PEIH_MSIASS	0x20
-#define PEIH_FLUSH0	0x30
-#define PEIH_FLUSH1	0x38
-#define PEIH_CNTRST	0x48
-
-static int msi_irqs;
-
-struct ppc4xx_msi {
-	u32 msi_addr_lo;
-	u32 msi_addr_hi;
-	void __iomem *msi_regs;
-	int *msi_virqs;
-	struct msi_bitmap bitmap;
-	struct device_node *msi_dev;
-};
-
-static struct ppc4xx_msi ppc4xx_msi;
-
-static int ppc4xx_msi_init_allocator(struct platform_device *dev,
-		struct ppc4xx_msi *msi_data)
-{
-	int err;
-
-	err = msi_bitmap_alloc(&msi_data->bitmap, msi_irqs,
-			      dev->dev.of_node);
-	if (err)
-		return err;
-
-	err = msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
-	if (err < 0) {
-		msi_bitmap_free(&msi_data->bitmap);
-		return err;
-	}
-
-	return 0;
-}
-
-static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	int int_no = -ENOMEM;
-	unsigned int virq;
-	struct msi_msg msg;
-	struct msi_desc *entry;
-	struct ppc4xx_msi *msi_data = &ppc4xx_msi;
-
-	dev_dbg(&dev->dev, "PCIE-MSI:%s called. vec %x type %d\n",
-		__func__, nvec, type);
-	if (type == PCI_CAP_ID_MSIX)
-		pr_debug("ppc4xx msi: MSI-X untested, trying anyway.\n");
-
-	msi_data->msi_virqs = kmalloc_array(msi_irqs, sizeof(int), GFP_KERNEL);
-	if (!msi_data->msi_virqs)
-		return -ENOMEM;
-
-	for_each_pci_msi_entry(entry, dev) {
-		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
-		if (int_no >= 0)
-			break;
-		if (int_no < 0) {
-			pr_debug("%s: fail allocating msi interrupt\n",
-					__func__);
-		}
-		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
-		if (!virq) {
-			dev_err(&dev->dev, "%s: fail mapping irq\n", __func__);
-			msi_bitmap_free_hwirqs(&msi_data->bitmap, int_no, 1);
-			return -ENOSPC;
-		}
-		dev_dbg(&dev->dev, "%s: virq = %d\n", __func__, virq);
-
-		/* Setup msi address space */
-		msg.address_hi = msi_data->msi_addr_hi;
-		msg.address_lo = msi_data->msi_addr_lo;
-
-		irq_set_msi_desc(virq, entry);
-		msg.data = int_no;
-		pci_write_msi_msg(virq, &msg);
-	}
-	return 0;
-}
-
-void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
-{
-	struct msi_desc *entry;
-	struct ppc4xx_msi *msi_data = &ppc4xx_msi;
-	irq_hw_number_t hwirq;
-
-	dev_dbg(&dev->dev, "PCIE-MSI: tearing down msi irqs\n");
-
-	for_each_pci_msi_entry(entry, dev) {
-		if (!entry->irq)
-			continue;
-		hwirq = virq_to_hw(entry->irq);
-		irq_set_msi_desc(entry->irq, NULL);
-		irq_dispose_mapping(entry->irq);
-		msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
-	}
-}
-
-static int ppc4xx_setup_pcieh_hw(struct platform_device *dev,
-				 struct resource res, struct ppc4xx_msi *msi)
-{
-	const u32 *msi_data;
-	const u32 *msi_mask;
-	const u32 *sdr_addr;
-	dma_addr_t msi_phys;
-	void *msi_virt;
-	int err;
-
-	sdr_addr = of_get_property(dev->dev.of_node, "sdr-base", NULL);
-	if (!sdr_addr)
-		return -EINVAL;
-
-	msi_data = of_get_property(dev->dev.of_node, "msi-data", NULL);
-	if (!msi_data)
-		return -EINVAL;
-
-	msi_mask = of_get_property(dev->dev.of_node, "msi-mask", NULL);
-	if (!msi_mask)
-		return -EINVAL;
-
-	msi->msi_dev = of_find_node_by_name(NULL, "ppc4xx-msi");
-	if (!msi->msi_dev)
-		return -ENODEV;
-
-	msi->msi_regs = of_iomap(msi->msi_dev, 0);
-	if (!msi->msi_regs) {
-		dev_err(&dev->dev, "of_iomap failed\n");
-		err = -ENOMEM;
-		goto node_put;
-	}
-	dev_dbg(&dev->dev, "PCIE-MSI: msi register mapped 0x%x 0x%x\n",
-		(u32) (msi->msi_regs + PEIH_TERMADH), (u32) (msi->msi_regs));
-
-	msi_virt = dma_alloc_coherent(&dev->dev, 64, &msi_phys, GFP_KERNEL);
-	if (!msi_virt) {
-		err = -ENOMEM;
-		goto iounmap;
-	}
-	msi->msi_addr_hi = upper_32_bits(msi_phys);
-	msi->msi_addr_lo = lower_32_bits(msi_phys & 0xffffffff);
-	dev_dbg(&dev->dev, "PCIE-MSI: msi address high 0x%x, low 0x%x\n",
-		msi->msi_addr_hi, msi->msi_addr_lo);
-
-	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
-	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
-
-	/* Progam the Interrupt handler Termination addr registers */
-	out_be32(msi->msi_regs + PEIH_TERMADH, msi->msi_addr_hi);
-	out_be32(msi->msi_regs + PEIH_TERMADL, msi->msi_addr_lo);
-
-	/* Program MSI Expected data and Mask bits */
-	out_be32(msi->msi_regs + PEIH_MSIED, *msi_data);
-	out_be32(msi->msi_regs + PEIH_MSIMK, *msi_mask);
-
-	dma_free_coherent(&dev->dev, 64, msi_virt, msi_phys);
-
-	return 0;
-
-iounmap:
-	iounmap(msi->msi_regs);
-node_put:
-	of_node_put(msi->msi_dev);
-	return err;
-}
-
-static int ppc4xx_of_msi_remove(struct platform_device *dev)
-{
-	struct ppc4xx_msi *msi = dev->dev.platform_data;
-	int i;
-	int virq;
-
-	for (i = 0; i < msi_irqs; i++) {
-		virq = msi->msi_virqs[i];
-		if (virq)
-			irq_dispose_mapping(virq);
-	}
-
-	if (msi->bitmap.bitmap)
-		msi_bitmap_free(&msi->bitmap);
-	iounmap(msi->msi_regs);
-	of_node_put(msi->msi_dev);
-
-	return 0;
-}
-
-static int ppc4xx_msi_probe(struct platform_device *dev)
-{
-	struct ppc4xx_msi *msi;
-	struct resource res;
-	int err = 0;
-	struct pci_controller *phb;
-
-	dev_dbg(&dev->dev, "PCIE-MSI: Setting up MSI support...\n");
-
-	msi = devm_kzalloc(&dev->dev, sizeof(*msi), GFP_KERNEL);
-	if (!msi)
-		return -ENOMEM;
-	dev->dev.platform_data = msi;
-
-	/* Get MSI ranges */
-	err = of_address_to_resource(dev->dev.of_node, 0, &res);
-	if (err) {
-		dev_err(&dev->dev, "%pOF resource error!\n", dev->dev.of_node);
-		return err;
-	}
-
-	msi_irqs = of_irq_count(dev->dev.of_node);
-	if (!msi_irqs)
-		return -ENODEV;
-
-	err = ppc4xx_setup_pcieh_hw(dev, res, msi);
-	if (err)
-		return err;
-
-	err = ppc4xx_msi_init_allocator(dev, msi);
-	if (err) {
-		dev_err(&dev->dev, "Error allocating MSI bitmap\n");
-		goto error_out;
-	}
-	ppc4xx_msi = *msi;
-
-	list_for_each_entry(phb, &hose_list, list_node) {
-		phb->controller_ops.setup_msi_irqs = ppc4xx_setup_msi_irqs;
-		phb->controller_ops.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
-	}
-	return 0;
-
-error_out:
-	ppc4xx_of_msi_remove(dev);
-	return err;
-}
-static const struct of_device_id ppc4xx_msi_ids[] = {
-	{
-		.compatible = "amcc,ppc4xx-msi",
-	},
-	{}
-};
-static struct platform_driver ppc4xx_msi_driver = {
-	.probe = ppc4xx_msi_probe,
-	.remove = ppc4xx_of_msi_remove,
-	.driver = {
-		   .name = "ppc4xx-msi",
-		   .of_match_table = ppc4xx_msi_ids,
-		   },
-
-};
-
-static __init int ppc4xx_msi_init(void)
-{
-	return platform_driver_register(&ppc4xx_msi_driver);
-}
-
-subsys_initcall(ppc4xx_msi_init);
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 9ebcc13..5aa92ff 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -12,17 +12,11 @@ config PPC4xx_HSTA_MSI
 	depends on PCI_MSI
 	depends on PCI && 4xx
 
-config PPC4xx_MSI
-	bool
-	depends on PCI_MSI
-	depends on PCI && 4xx
-
 config PPC_MSI_BITMAP
 	bool
 	depends on PCI_MSI
 	default y if MPIC
 	default y if FSL_PCI
-	default y if PPC4xx_MSI
 	default y if PPC_POWERNV
 
 source "arch/powerpc/sysdev/xics/Kconfig"
