Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C283A5203F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiEISAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiEISAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:00:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843D54697;
        Mon,  9 May 2022 10:56:51 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4KxplP6BMsz4xdK;
        Tue, 10 May 2022 03:56:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxplJ0G8vz4xVP;
        Tue, 10 May 2022 03:56:43 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: [PATCH v7 03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
Date:   Mon,  9 May 2022 19:56:08 +0200
Message-Id: <20220509175616.1089346-4-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SPI driver adds support for the Aspeed static memory controllers
of the AST2600, AST2500 and AST2400 SoCs using the spi-mem interface.

 * AST2600 Firmware SPI Memory Controller (FMC)
   . BMC firmware
   . 3 chip select pins (CE0 ~ CE2)
   . Only supports SPI type flash memory
   . different segment register interface
   . single, dual and quad mode.

 * AST2600 SPI Flash Controller (SPI1 and SPI2)
   . host firmware
   . 2 chip select pins (CE0 ~ CE1)
   . different segment register interface
   . single, dual and quad mode.

 * AST2500 Firmware SPI Memory Controller (FMC)
   . BMC firmware
   . 3 chip select pins (CE0 ~ CE2)
   . supports SPI type flash memory (CE0-CE1)
   . CE2 can be of NOR type flash but this is not supported by the driver
   . single, dual mode.

 * AST2500 SPI Flash Controller (SPI1 and SPI2)
   . host firmware
   . 2 chip select pins (CE0 ~ CE1)
   . single, dual mode.

 * AST2400 New Static Memory Controller (also referred as FMC)
   . BMC firmware
   . New register set
   . 5 chip select pins (CE0 ∼ CE4)
   . supports NOR flash, NAND flash and SPI flash memory.
   . single, dual and quad mode.

Each controller has a memory range on which flash devices contents are
mapped. Each device is assigned a window that can be changed at bootime
with the Segment Address Registers.

Each SPI flash device can then be accessed in two modes: Command and
User. When in User mode, SPI transfers are initiated with accesses to
the memory segment of a device. When in Command mode, memory
operations on the memory segment of a device generate SPI commands
automatically using a Control Register for the settings.

This initial patch adds support for User mode. Command mode needs a little
more work to check that the memory window on the AHB bus fits the device
size. It will come later when support for direct mapping is added.

Single and dual mode RX transfers are supported. Other types than SPI
are not supported.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/mtd/spi-nor/controllers/aspeed-smc.c | 921 -------------------
 drivers/spi/spi-aspeed-smc.c                 | 717 +++++++++++++++
 MAINTAINERS                                  |   1 +
 drivers/mtd/spi-nor/controllers/Kconfig      |  10 -
 drivers/mtd/spi-nor/controllers/Makefile     |   1 -
 drivers/spi/Kconfig                          |  11 +
 drivers/spi/Makefile                         |   1 +
 7 files changed, 730 insertions(+), 932 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
 create mode 100644 drivers/spi/spi-aspeed-smc.c

diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
deleted file mode 100644
index acfe010f9dd7..000000000000
--- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
+++ /dev/null
@@ -1,921 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * ASPEED Static Memory Controller driver
- *
- * Copyright (c) 2015-2016, IBM Corporation.
- */
-
-#include <linux/bug.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/spi-nor.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/sizes.h>
-#include <linux/sysfs.h>
-
-#define DEVICE_NAME	"aspeed-smc"
-
-/*
- * The driver only support SPI flash
- */
-enum aspeed_smc_flash_type {
-	smc_type_nor  = 0,
-	smc_type_nand = 1,
-	smc_type_spi  = 2,
-};
-
-struct aspeed_smc_chip;
-
-struct aspeed_smc_info {
-	u32 maxsize;		/* maximum size of chip window */
-	u8 nce;			/* number of chip enables */
-	bool hastype;		/* flash type field exists in config reg */
-	u8 we0;			/* shift for write enable bit for CE0 */
-	u8 ctl0;		/* offset in regs of ctl for CE0 */
-
-	void (*set_4b)(struct aspeed_smc_chip *chip);
-};
-
-static void aspeed_smc_chip_set_4b_spi_2400(struct aspeed_smc_chip *chip);
-static void aspeed_smc_chip_set_4b(struct aspeed_smc_chip *chip);
-
-static const struct aspeed_smc_info fmc_2400_info = {
-	.maxsize = 64 * 1024 * 1024,
-	.nce = 5,
-	.hastype = true,
-	.we0 = 16,
-	.ctl0 = 0x10,
-	.set_4b = aspeed_smc_chip_set_4b,
-};
-
-static const struct aspeed_smc_info spi_2400_info = {
-	.maxsize = 64 * 1024 * 1024,
-	.nce = 1,
-	.hastype = false,
-	.we0 = 0,
-	.ctl0 = 0x04,
-	.set_4b = aspeed_smc_chip_set_4b_spi_2400,
-};
-
-static const struct aspeed_smc_info fmc_2500_info = {
-	.maxsize = 256 * 1024 * 1024,
-	.nce = 3,
-	.hastype = true,
-	.we0 = 16,
-	.ctl0 = 0x10,
-	.set_4b = aspeed_smc_chip_set_4b,
-};
-
-static const struct aspeed_smc_info spi_2500_info = {
-	.maxsize = 128 * 1024 * 1024,
-	.nce = 2,
-	.hastype = false,
-	.we0 = 16,
-	.ctl0 = 0x10,
-	.set_4b = aspeed_smc_chip_set_4b,
-};
-
-enum aspeed_smc_ctl_reg_value {
-	smc_base,		/* base value without mode for other commands */
-	smc_read,		/* command reg for (maybe fast) reads */
-	smc_write,		/* command reg for writes */
-	smc_max,
-};
-
-struct aspeed_smc_controller;
-
-struct aspeed_smc_chip {
-	int cs;
-	struct aspeed_smc_controller *controller;
-	void __iomem *ctl;			/* control register */
-	void __iomem *ahb_base;			/* base of chip window */
-	u32 ahb_window_size;			/* chip mapping window size */
-	u32 ctl_val[smc_max];			/* control settings */
-	enum aspeed_smc_flash_type type;	/* what type of flash */
-	struct spi_nor nor;
-};
-
-struct aspeed_smc_controller {
-	struct device *dev;
-
-	struct mutex mutex;			/* controller access mutex */
-	const struct aspeed_smc_info *info;	/* type info of controller */
-	void __iomem *regs;			/* controller registers */
-	void __iomem *ahb_base;			/* per-chip windows resource */
-	u32 ahb_window_size;			/* full mapping window size */
-
-	struct aspeed_smc_chip *chips[];	/* pointers to attached chips */
-};
-
-/*
- * SPI Flash Configuration Register (AST2500 SPI)
- *     or
- * Type setting Register (AST2500 FMC).
- * CE0 and CE1 can only be of type SPI. CE2 can be of type NOR but the
- * driver does not support it.
- */
-#define CONFIG_REG			0x0
-#define CONFIG_DISABLE_LEGACY		BIT(31) /* 1 */
-
-#define CONFIG_CE2_WRITE		BIT(18)
-#define CONFIG_CE1_WRITE		BIT(17)
-#define CONFIG_CE0_WRITE		BIT(16)
-
-#define CONFIG_CE2_TYPE			BIT(4) /* AST2500 FMC only */
-#define CONFIG_CE1_TYPE			BIT(2) /* AST2500 FMC only */
-#define CONFIG_CE0_TYPE			BIT(0) /* AST2500 FMC only */
-
-/*
- * CE Control Register
- */
-#define CE_CONTROL_REG			0x4
-
-/*
- * CEx Control Register
- */
-#define CONTROL_AAF_MODE		BIT(31)
-#define CONTROL_IO_MODE_MASK		GENMASK(30, 28)
-#define CONTROL_IO_DUAL_DATA		BIT(29)
-#define CONTROL_IO_DUAL_ADDR_DATA	(BIT(29) | BIT(28))
-#define CONTROL_IO_QUAD_DATA		BIT(30)
-#define CONTROL_IO_QUAD_ADDR_DATA	(BIT(30) | BIT(28))
-#define CONTROL_CE_INACTIVE_SHIFT	24
-#define CONTROL_CE_INACTIVE_MASK	GENMASK(27, \
-					CONTROL_CE_INACTIVE_SHIFT)
-/* 0 = 16T ... 15 = 1T   T=HCLK */
-#define CONTROL_COMMAND_SHIFT		16
-#define CONTROL_DUMMY_COMMAND_OUT	BIT(15)
-#define CONTROL_IO_DUMMY_HI		BIT(14)
-#define CONTROL_IO_DUMMY_HI_SHIFT	14
-#define CONTROL_CLK_DIV4		BIT(13) /* others */
-#define CONTROL_IO_ADDRESS_4B		BIT(13) /* AST2400 SPI */
-#define CONTROL_RW_MERGE		BIT(12)
-#define CONTROL_IO_DUMMY_LO_SHIFT	6
-#define CONTROL_IO_DUMMY_LO		GENMASK(7, \
-						CONTROL_IO_DUMMY_LO_SHIFT)
-#define CONTROL_IO_DUMMY_MASK		(CONTROL_IO_DUMMY_HI | \
-					 CONTROL_IO_DUMMY_LO)
-#define CONTROL_IO_DUMMY_SET(dummy)				 \
-	(((((dummy) >> 2) & 0x1) << CONTROL_IO_DUMMY_HI_SHIFT) | \
-	 (((dummy) & 0x3) << CONTROL_IO_DUMMY_LO_SHIFT))
-
-#define CONTROL_CLOCK_FREQ_SEL_SHIFT	8
-#define CONTROL_CLOCK_FREQ_SEL_MASK	GENMASK(11, \
-						CONTROL_CLOCK_FREQ_SEL_SHIFT)
-#define CONTROL_LSB_FIRST		BIT(5)
-#define CONTROL_CLOCK_MODE_3		BIT(4)
-#define CONTROL_IN_DUAL_DATA		BIT(3)
-#define CONTROL_CE_STOP_ACTIVE_CONTROL	BIT(2)
-#define CONTROL_COMMAND_MODE_MASK	GENMASK(1, 0)
-#define CONTROL_COMMAND_MODE_NORMAL	0
-#define CONTROL_COMMAND_MODE_FREAD	1
-#define CONTROL_COMMAND_MODE_WRITE	2
-#define CONTROL_COMMAND_MODE_USER	3
-
-#define CONTROL_KEEP_MASK						\
-	(CONTROL_AAF_MODE | CONTROL_CE_INACTIVE_MASK | CONTROL_CLK_DIV4 | \
-	 CONTROL_CLOCK_FREQ_SEL_MASK | CONTROL_LSB_FIRST | CONTROL_CLOCK_MODE_3)
-
-/*
- * The Segment Register uses a 8MB unit to encode the start address
- * and the end address of the mapping window of a flash SPI slave :
- *
- *        | byte 1 | byte 2 | byte 3 | byte 4 |
- *        +--------+--------+--------+--------+
- *        |  end   |  start |   0    |   0    |
- */
-#define SEGMENT_ADDR_REG0		0x30
-#define SEGMENT_ADDR_START(_r)		((((_r) >> 16) & 0xFF) << 23)
-#define SEGMENT_ADDR_END(_r)		((((_r) >> 24) & 0xFF) << 23)
-#define SEGMENT_ADDR_VALUE(start, end)					\
-	(((((start) >> 23) & 0xFF) << 16) | ((((end) >> 23) & 0xFF) << 24))
-#define SEGMENT_ADDR_REG(controller, cs)	\
-	((controller)->regs + SEGMENT_ADDR_REG0 + (cs) * 4)
-
-/*
- * In user mode all data bytes read or written to the chip decode address
- * range are transferred to or from the SPI bus. The range is treated as a
- * fifo of arbitratry 1, 2, or 4 byte width but each write has to be aligned
- * to its size. The address within the multiple 8kB range is ignored when
- * sending bytes to the SPI bus.
- *
- * On the arm architecture, as of Linux version 4.3, memcpy_fromio and
- * memcpy_toio on little endian targets use the optimized memcpy routines
- * that were designed for well behavied memory storage. These routines
- * have a stutter if the source and destination are not both word aligned,
- * once with a duplicate access to the source after aligning to the
- * destination to a word boundary, and again with a duplicate access to
- * the source when the final byte count is not word aligned.
- *
- * When writing or reading the fifo this stutter discards data or sends
- * too much data to the fifo and can not be used by this driver.
- *
- * While the low level io string routines that implement the insl family do
- * the desired accesses and memory increments, the cross architecture io
- * macros make them essentially impossible to use on a memory mapped address
- * instead of a a token from the call to iomap of an io port.
- *
- * These fifo routines use readl and friends to a constant io port and update
- * the memory buffer pointer and count via explicit code. The final updates
- * to len are optimistically suppressed.
- */
-static int aspeed_smc_read_from_ahb(void *buf, void __iomem *src, size_t len)
-{
-	size_t offset = 0;
-
-	if (IS_ALIGNED((uintptr_t)src, sizeof(uintptr_t)) &&
-	    IS_ALIGNED((uintptr_t)buf, sizeof(uintptr_t))) {
-		ioread32_rep(src, buf, len >> 2);
-		offset = len & ~0x3;
-		len -= offset;
-	}
-	ioread8_rep(src, (u8 *)buf + offset, len);
-	return 0;
-}
-
-static int aspeed_smc_write_to_ahb(void __iomem *dst, const void *buf,
-				   size_t len)
-{
-	size_t offset = 0;
-
-	if (IS_ALIGNED((uintptr_t)dst, sizeof(uintptr_t)) &&
-	    IS_ALIGNED((uintptr_t)buf, sizeof(uintptr_t))) {
-		iowrite32_rep(dst, buf, len >> 2);
-		offset = len & ~0x3;
-		len -= offset;
-	}
-	iowrite8_rep(dst, (const u8 *)buf + offset, len);
-	return 0;
-}
-
-static inline u32 aspeed_smc_chip_write_bit(struct aspeed_smc_chip *chip)
-{
-	return BIT(chip->controller->info->we0 + chip->cs);
-}
-
-static void aspeed_smc_chip_check_config(struct aspeed_smc_chip *chip)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	u32 reg;
-
-	reg = readl(controller->regs + CONFIG_REG);
-
-	if (reg & aspeed_smc_chip_write_bit(chip))
-		return;
-
-	dev_dbg(controller->dev, "config write is not set ! @%p: 0x%08x\n",
-		controller->regs + CONFIG_REG, reg);
-	reg |= aspeed_smc_chip_write_bit(chip);
-	writel(reg, controller->regs + CONFIG_REG);
-}
-
-static void aspeed_smc_start_user(struct spi_nor *nor)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-	u32 ctl = chip->ctl_val[smc_base];
-
-	/*
-	 * When the chip is controlled in user mode, we need write
-	 * access to send the opcodes to it. So check the config.
-	 */
-	aspeed_smc_chip_check_config(chip);
-
-	ctl |= CONTROL_COMMAND_MODE_USER |
-		CONTROL_CE_STOP_ACTIVE_CONTROL;
-	writel(ctl, chip->ctl);
-
-	ctl &= ~CONTROL_CE_STOP_ACTIVE_CONTROL;
-	writel(ctl, chip->ctl);
-}
-
-static void aspeed_smc_stop_user(struct spi_nor *nor)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-
-	u32 ctl = chip->ctl_val[smc_read];
-	u32 ctl2 = ctl | CONTROL_COMMAND_MODE_USER |
-		CONTROL_CE_STOP_ACTIVE_CONTROL;
-
-	writel(ctl2, chip->ctl);	/* stop user CE control */
-	writel(ctl, chip->ctl);		/* default to fread or read mode */
-}
-
-static int aspeed_smc_prep(struct spi_nor *nor)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-
-	mutex_lock(&chip->controller->mutex);
-	return 0;
-}
-
-static void aspeed_smc_unprep(struct spi_nor *nor)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-
-	mutex_unlock(&chip->controller->mutex);
-}
-
-static int aspeed_smc_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
-			       size_t len)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-
-	aspeed_smc_start_user(nor);
-	aspeed_smc_write_to_ahb(chip->ahb_base, &opcode, 1);
-	aspeed_smc_read_from_ahb(buf, chip->ahb_base, len);
-	aspeed_smc_stop_user(nor);
-	return 0;
-}
-
-static int aspeed_smc_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
-				size_t len)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-
-	aspeed_smc_start_user(nor);
-	aspeed_smc_write_to_ahb(chip->ahb_base, &opcode, 1);
-	aspeed_smc_write_to_ahb(chip->ahb_base, buf, len);
-	aspeed_smc_stop_user(nor);
-	return 0;
-}
-
-static void aspeed_smc_send_cmd_addr(struct spi_nor *nor, u8 cmd, u32 addr)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-	__be32 temp;
-	u32 cmdaddr;
-
-	switch (nor->addr_width) {
-	default:
-		WARN_ONCE(1, "Unexpected address width %u, defaulting to 3\n",
-			  nor->addr_width);
-		fallthrough;
-	case 3:
-		cmdaddr = addr & 0xFFFFFF;
-		cmdaddr |= cmd << 24;
-
-		temp = cpu_to_be32(cmdaddr);
-		aspeed_smc_write_to_ahb(chip->ahb_base, &temp, 4);
-		break;
-	case 4:
-		temp = cpu_to_be32(addr);
-		aspeed_smc_write_to_ahb(chip->ahb_base, &cmd, 1);
-		aspeed_smc_write_to_ahb(chip->ahb_base, &temp, 4);
-		break;
-	}
-}
-
-static ssize_t aspeed_smc_read_user(struct spi_nor *nor, loff_t from,
-				    size_t len, u_char *read_buf)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-	int i;
-	u8 dummy = 0xFF;
-
-	aspeed_smc_start_user(nor);
-	aspeed_smc_send_cmd_addr(nor, nor->read_opcode, from);
-	for (i = 0; i < chip->nor.read_dummy / 8; i++)
-		aspeed_smc_write_to_ahb(chip->ahb_base, &dummy, sizeof(dummy));
-
-	aspeed_smc_read_from_ahb(read_buf, chip->ahb_base, len);
-	aspeed_smc_stop_user(nor);
-	return len;
-}
-
-static ssize_t aspeed_smc_write_user(struct spi_nor *nor, loff_t to,
-				     size_t len, const u_char *write_buf)
-{
-	struct aspeed_smc_chip *chip = nor->priv;
-
-	aspeed_smc_start_user(nor);
-	aspeed_smc_send_cmd_addr(nor, nor->program_opcode, to);
-	aspeed_smc_write_to_ahb(chip->ahb_base, write_buf, len);
-	aspeed_smc_stop_user(nor);
-	return len;
-}
-
-static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
-{
-	struct aspeed_smc_chip *chip;
-	int n;
-
-	for (n = 0; n < controller->info->nce; n++) {
-		chip = controller->chips[n];
-		if (chip)
-			mtd_device_unregister(&chip->nor.mtd);
-	}
-
-	return 0;
-}
-
-static int aspeed_smc_remove(struct platform_device *dev)
-{
-	return aspeed_smc_unregister(platform_get_drvdata(dev));
-}
-
-static const struct of_device_id aspeed_smc_matches[] = {
-	{ .compatible = "aspeed,ast2400-fmc", .data = &fmc_2400_info },
-	{ .compatible = "aspeed,ast2400-spi", .data = &spi_2400_info },
-	{ .compatible = "aspeed,ast2500-fmc", .data = &fmc_2500_info },
-	{ .compatible = "aspeed,ast2500-spi", .data = &spi_2500_info },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, aspeed_smc_matches);
-
-/*
- * Each chip has a mapping window defined by a segment address
- * register defining a start and an end address on the AHB bus. These
- * addresses can be configured to fit the chip size and offer a
- * contiguous memory region across chips. For the moment, we only
- * check that each chip segment is valid.
- */
-static void __iomem *aspeed_smc_chip_base(struct aspeed_smc_chip *chip,
-					  struct resource *res)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	u32 offset = 0;
-	u32 reg;
-
-	if (controller->info->nce > 1) {
-		reg = readl(SEGMENT_ADDR_REG(controller, chip->cs));
-
-		if (SEGMENT_ADDR_START(reg) >= SEGMENT_ADDR_END(reg))
-			return NULL;
-
-		offset = SEGMENT_ADDR_START(reg) - res->start;
-	}
-
-	return controller->ahb_base + offset;
-}
-
-static u32 aspeed_smc_ahb_base_phy(struct aspeed_smc_controller *controller)
-{
-	u32 seg0_val = readl(SEGMENT_ADDR_REG(controller, 0));
-
-	return SEGMENT_ADDR_START(seg0_val);
-}
-
-static u32 chip_set_segment(struct aspeed_smc_chip *chip, u32 cs, u32 start,
-			    u32 size)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	void __iomem *seg_reg;
-	u32 seg_oldval, seg_newval, ahb_base_phy, end;
-
-	ahb_base_phy = aspeed_smc_ahb_base_phy(controller);
-
-	seg_reg = SEGMENT_ADDR_REG(controller, cs);
-	seg_oldval = readl(seg_reg);
-
-	/*
-	 * If the chip size is not specified, use the default segment
-	 * size, but take into account the possible overlap with the
-	 * previous segment
-	 */
-	if (!size)
-		size = SEGMENT_ADDR_END(seg_oldval) - start;
-
-	/*
-	 * The segment cannot exceed the maximum window size of the
-	 * controller.
-	 */
-	if (start + size > ahb_base_phy + controller->ahb_window_size) {
-		size = ahb_base_phy + controller->ahb_window_size - start;
-		dev_warn(chip->nor.dev, "CE%d window resized to %dMB",
-			 cs, size >> 20);
-	}
-
-	end = start + size;
-	seg_newval = SEGMENT_ADDR_VALUE(start, end);
-	writel(seg_newval, seg_reg);
-
-	/*
-	 * Restore default value if something goes wrong. The chip
-	 * might have set some bogus value and we would loose access
-	 * to the chip.
-	 */
-	if (seg_newval != readl(seg_reg)) {
-		dev_err(chip->nor.dev, "CE%d window invalid", cs);
-		writel(seg_oldval, seg_reg);
-		start = SEGMENT_ADDR_START(seg_oldval);
-		end = SEGMENT_ADDR_END(seg_oldval);
-		size = end - start;
-	}
-
-	dev_info(chip->nor.dev, "CE%d window [ 0x%.8x - 0x%.8x ] %dMB",
-		 cs, start, end, size >> 20);
-
-	return size;
-}
-
-/*
- * The segment register defines the mapping window on the AHB bus and
- * it needs to be configured depending on the chip size. The segment
- * register of the following CE also needs to be tuned in order to
- * provide a contiguous window across multiple chips.
- *
- * This is expected to be called in increasing CE order
- */
-static u32 aspeed_smc_chip_set_segment(struct aspeed_smc_chip *chip)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	u32 ahb_base_phy, start;
-	u32 size = chip->nor.mtd.size;
-
-	/*
-	 * Each controller has a chip size limit for direct memory
-	 * access
-	 */
-	if (size > controller->info->maxsize)
-		size = controller->info->maxsize;
-
-	/*
-	 * The AST2400 SPI controller only handles one chip and does
-	 * not have segment registers. Let's use the chip size for the
-	 * AHB window.
-	 */
-	if (controller->info == &spi_2400_info)
-		goto out;
-
-	/*
-	 * The AST2500 SPI controller has a HW bug when the CE0 chip
-	 * size reaches 128MB. Enforce a size limit of 120MB to
-	 * prevent the controller from using bogus settings in the
-	 * segment register.
-	 */
-	if (chip->cs == 0 && controller->info == &spi_2500_info &&
-	    size == SZ_128M) {
-		size = 120 << 20;
-		dev_info(chip->nor.dev,
-			 "CE%d window resized to %dMB (AST2500 HW quirk)",
-			 chip->cs, size >> 20);
-	}
-
-	ahb_base_phy = aspeed_smc_ahb_base_phy(controller);
-
-	/*
-	 * As a start address for the current segment, use the default
-	 * start address if we are handling CE0 or use the previous
-	 * segment ending address
-	 */
-	if (chip->cs) {
-		u32 prev = readl(SEGMENT_ADDR_REG(controller, chip->cs - 1));
-
-		start = SEGMENT_ADDR_END(prev);
-	} else {
-		start = ahb_base_phy;
-	}
-
-	size = chip_set_segment(chip, chip->cs, start, size);
-
-	/* Update chip base address on the AHB bus */
-	chip->ahb_base = controller->ahb_base + (start - ahb_base_phy);
-
-	/*
-	 * Now, make sure the next segment does not overlap with the
-	 * current one we just configured, even if there is no
-	 * available chip. That could break access in Command Mode.
-	 */
-	if (chip->cs < controller->info->nce - 1)
-		chip_set_segment(chip, chip->cs + 1, start + size, 0);
-
-out:
-	if (size < chip->nor.mtd.size)
-		dev_warn(chip->nor.dev,
-			 "CE%d window too small for chip %dMB",
-			 chip->cs, (u32)chip->nor.mtd.size >> 20);
-
-	return size;
-}
-
-static void aspeed_smc_chip_enable_write(struct aspeed_smc_chip *chip)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	u32 reg;
-
-	reg = readl(controller->regs + CONFIG_REG);
-
-	reg |= aspeed_smc_chip_write_bit(chip);
-	writel(reg, controller->regs + CONFIG_REG);
-}
-
-static void aspeed_smc_chip_set_type(struct aspeed_smc_chip *chip, int type)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	u32 reg;
-
-	chip->type = type;
-
-	reg = readl(controller->regs + CONFIG_REG);
-	reg &= ~(3 << (chip->cs * 2));
-	reg |= chip->type << (chip->cs * 2);
-	writel(reg, controller->regs + CONFIG_REG);
-}
-
-/*
- * The first chip of the AST2500 FMC flash controller is strapped by
- * hardware, or autodetected, but other chips need to be set. Enforce
- * the 4B setting for all chips.
- */
-static void aspeed_smc_chip_set_4b(struct aspeed_smc_chip *chip)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	u32 reg;
-
-	reg = readl(controller->regs + CE_CONTROL_REG);
-	reg |= 1 << chip->cs;
-	writel(reg, controller->regs + CE_CONTROL_REG);
-}
-
-/*
- * The AST2400 SPI flash controller does not have a CE Control
- * register. It uses the CE0 control register to set 4Byte mode at the
- * controller level.
- */
-static void aspeed_smc_chip_set_4b_spi_2400(struct aspeed_smc_chip *chip)
-{
-	chip->ctl_val[smc_base] |= CONTROL_IO_ADDRESS_4B;
-	chip->ctl_val[smc_read] |= CONTROL_IO_ADDRESS_4B;
-}
-
-static int aspeed_smc_chip_setup_init(struct aspeed_smc_chip *chip,
-				      struct resource *res)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	const struct aspeed_smc_info *info = controller->info;
-	u32 reg, base_reg;
-
-	/*
-	 * Always turn on the write enable bit to allow opcodes to be
-	 * sent in user mode.
-	 */
-	aspeed_smc_chip_enable_write(chip);
-
-	/* The driver only supports SPI type flash */
-	if (info->hastype)
-		aspeed_smc_chip_set_type(chip, smc_type_spi);
-
-	/*
-	 * Configure chip base address in memory
-	 */
-	chip->ahb_base = aspeed_smc_chip_base(chip, res);
-	if (!chip->ahb_base) {
-		dev_warn(chip->nor.dev, "CE%d window closed", chip->cs);
-		return -EINVAL;
-	}
-
-	/*
-	 * Get value of the inherited control register. U-Boot usually
-	 * does some timing calibration on the FMC chip, so it's good
-	 * to keep them. In the future, we should handle calibration
-	 * from Linux.
-	 */
-	reg = readl(chip->ctl);
-	dev_dbg(controller->dev, "control register: %08x\n", reg);
-
-	base_reg = reg & CONTROL_KEEP_MASK;
-	if (base_reg != reg) {
-		dev_dbg(controller->dev,
-			"control register changed to: %08x\n",
-			base_reg);
-	}
-	chip->ctl_val[smc_base] = base_reg;
-
-	/*
-	 * Retain the prior value of the control register as the
-	 * default if it was normal access mode. Otherwise start with
-	 * the sanitized base value set to read mode.
-	 */
-	if ((reg & CONTROL_COMMAND_MODE_MASK) ==
-	    CONTROL_COMMAND_MODE_NORMAL)
-		chip->ctl_val[smc_read] = reg;
-	else
-		chip->ctl_val[smc_read] = chip->ctl_val[smc_base] |
-			CONTROL_COMMAND_MODE_NORMAL;
-
-	dev_dbg(controller->dev, "default control register: %08x\n",
-		chip->ctl_val[smc_read]);
-	return 0;
-}
-
-static int aspeed_smc_chip_setup_finish(struct aspeed_smc_chip *chip)
-{
-	struct aspeed_smc_controller *controller = chip->controller;
-	const struct aspeed_smc_info *info = controller->info;
-	u32 cmd;
-
-	if (chip->nor.addr_width == 4 && info->set_4b)
-		info->set_4b(chip);
-
-	/* This is for direct AHB access when using Command Mode. */
-	chip->ahb_window_size = aspeed_smc_chip_set_segment(chip);
-
-	/*
-	 * base mode has not been optimized yet. use it for writes.
-	 */
-	chip->ctl_val[smc_write] = chip->ctl_val[smc_base] |
-		chip->nor.program_opcode << CONTROL_COMMAND_SHIFT |
-		CONTROL_COMMAND_MODE_WRITE;
-
-	dev_dbg(controller->dev, "write control register: %08x\n",
-		chip->ctl_val[smc_write]);
-
-	/*
-	 * TODO: Adjust clocks if fast read is supported and interpret
-	 * SPI NOR flags to adjust controller settings.
-	 */
-	if (chip->nor.read_proto == SNOR_PROTO_1_1_1) {
-		if (chip->nor.read_dummy == 0)
-			cmd = CONTROL_COMMAND_MODE_NORMAL;
-		else
-			cmd = CONTROL_COMMAND_MODE_FREAD;
-	} else {
-		dev_err(chip->nor.dev, "unsupported SPI read mode\n");
-		return -EINVAL;
-	}
-
-	chip->ctl_val[smc_read] |= cmd |
-		CONTROL_IO_DUMMY_SET(chip->nor.read_dummy / 8);
-
-	dev_dbg(controller->dev, "base control register: %08x\n",
-		chip->ctl_val[smc_read]);
-	return 0;
-}
-
-static const struct spi_nor_controller_ops aspeed_smc_controller_ops = {
-	.prepare = aspeed_smc_prep,
-	.unprepare = aspeed_smc_unprep,
-	.read_reg = aspeed_smc_read_reg,
-	.write_reg = aspeed_smc_write_reg,
-	.read = aspeed_smc_read_user,
-	.write = aspeed_smc_write_user,
-};
-
-static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
-				  struct device_node *np, struct resource *r)
-{
-	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_PP,
-	};
-	const struct aspeed_smc_info *info = controller->info;
-	struct device *dev = controller->dev;
-	struct device_node *child;
-	unsigned int cs;
-	int ret = -ENODEV;
-	bool found_one = false;
-
-	for_each_available_child_of_node(np, child) {
-		struct aspeed_smc_chip *chip;
-		struct spi_nor *nor;
-		struct mtd_info *mtd;
-
-		/* This driver does not support NAND or NOR flash devices. */
-		if (!of_device_is_compatible(child, "jedec,spi-nor"))
-			continue;
-
-		ret = of_property_read_u32(child, "reg", &cs);
-		if (ret) {
-			dev_err(dev, "Couldn't not read chip select.\n");
-			break;
-		}
-
-		if (cs >= info->nce) {
-			dev_err(dev, "Chip select %d out of range.\n",
-				cs);
-			ret = -ERANGE;
-			break;
-		}
-
-		if (controller->chips[cs]) {
-			dev_err(dev, "Chip select %d already in use by %s\n",
-				cs, dev_name(controller->chips[cs]->nor.dev));
-			ret = -EBUSY;
-			break;
-		}
-
-		chip = devm_kzalloc(controller->dev, sizeof(*chip), GFP_KERNEL);
-		if (!chip) {
-			ret = -ENOMEM;
-			break;
-		}
-
-		chip->controller = controller;
-		chip->ctl = controller->regs + info->ctl0 + cs * 4;
-		chip->cs = cs;
-
-		nor = &chip->nor;
-		mtd = &nor->mtd;
-
-		nor->dev = dev;
-		nor->priv = chip;
-		spi_nor_set_flash_node(nor, child);
-		nor->controller_ops = &aspeed_smc_controller_ops;
-
-		ret = aspeed_smc_chip_setup_init(chip, r);
-		if (ret)
-			break;
-
-		/*
-		 * TODO: Add support for Dual and Quad SPI protocols
-		 * attach when board support is present as determined
-		 * by of property.
-		 */
-		ret = spi_nor_scan(nor, NULL, &hwcaps);
-		/*
-		 * If we fail to scan the device it might not be present or
-		 * broken.  Don't fail the whole controller if others work.
-		 */
-		if (ret) {
-			if (found_one)
-				ret = 0;
-
-			devm_kfree(controller->dev, chip);
-			continue;
-		}
-
-		ret = aspeed_smc_chip_setup_finish(chip);
-		if (ret)
-			break;
-
-		ret = mtd_device_register(mtd, NULL, 0);
-		if (ret)
-			break;
-
-		controller->chips[cs] = chip;
-		found_one = true;
-	}
-
-	if (ret) {
-		of_node_put(child);
-		aspeed_smc_unregister(controller);
-	}
-
-	return ret;
-}
-
-static int aspeed_smc_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	struct aspeed_smc_controller *controller;
-	const struct of_device_id *match;
-	const struct aspeed_smc_info *info;
-	struct resource *res;
-	int ret;
-
-	match = of_match_device(aspeed_smc_matches, &pdev->dev);
-	if (!match || !match->data)
-		return -ENODEV;
-	info = match->data;
-
-	controller = devm_kzalloc(&pdev->dev,
-				  struct_size(controller, chips, info->nce),
-				  GFP_KERNEL);
-	if (!controller)
-		return -ENOMEM;
-	controller->info = info;
-	controller->dev = dev;
-
-	mutex_init(&controller->mutex);
-	platform_set_drvdata(pdev, controller);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	controller->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(controller->regs))
-		return PTR_ERR(controller->regs);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	controller->ahb_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(controller->ahb_base))
-		return PTR_ERR(controller->ahb_base);
-
-	controller->ahb_window_size = resource_size(res);
-
-	ret = aspeed_smc_setup_flash(controller, np, res);
-	if (ret)
-		dev_err(dev, "Aspeed SMC probe failed %d\n", ret);
-
-	return ret;
-}
-
-static struct platform_driver aspeed_smc_driver = {
-	.probe = aspeed_smc_probe,
-	.remove = aspeed_smc_remove,
-	.driver = {
-		.name = DEVICE_NAME,
-		.of_match_table = aspeed_smc_matches,
-	}
-};
-
-module_platform_driver(aspeed_smc_driver);
-
-MODULE_DESCRIPTION("ASPEED Static Memory Controller Driver");
-MODULE_AUTHOR("Cedric Le Goater <clg@kaod.org>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
new file mode 100644
index 000000000000..cb5a0652e5a4
--- /dev/null
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASPEED FMC/SPI Memory Controller Driver
+ *
+ * Copyright (c) 2015-2022, IBM Corporation.
+ * Copyright (c) 2020, ASPEED Corporation.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#define DEVICE_NAME "spi-aspeed-smc"
+
+/* Type setting Register */
+#define CONFIG_REG			0x0
+#define   CONFIG_TYPE_SPI		0x2
+
+/* CE Control Register */
+#define CE_CTRL_REG			0x4
+
+/* CEx Control Register */
+#define CE0_CTRL_REG			0x10
+#define   CTRL_IO_MODE_MASK		GENMASK(30, 28)
+#define   CTRL_IO_SINGLE_DATA	        0x0
+#define   CTRL_IO_DUAL_DATA		BIT(29)
+#define   CTRL_IO_QUAD_DATA		BIT(30)
+#define   CTRL_COMMAND_SHIFT		16
+#define   CTRL_IO_DUMMY_SET(dummy)					\
+	(((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
+#define   CTRL_CE_STOP_ACTIVE		BIT(2)
+#define   CTRL_IO_MODE_CMD_MASK		GENMASK(1, 0)
+#define   CTRL_IO_MODE_NORMAL		0x0
+#define   CTRL_IO_MODE_READ		0x1
+#define   CTRL_IO_MODE_WRITE		0x2
+#define   CTRL_IO_MODE_USER		0x3
+
+#define   CTRL_IO_CMD_MASK		0xf0ff40c3
+
+/* CEx Address Decoding Range Register */
+#define CE0_SEGMENT_ADDR_REG		0x30
+
+enum aspeed_spi_ctl_reg_value {
+	ASPEED_SPI_BASE,
+	ASPEED_SPI_READ,
+	ASPEED_SPI_WRITE,
+	ASPEED_SPI_MAX,
+};
+
+struct aspeed_spi;
+
+struct aspeed_spi_chip {
+	struct aspeed_spi	*aspi;
+	u32			 cs;
+	void __iomem		*ctl;
+	void __iomem		*ahb_base;
+	u32			 ahb_window_size;
+	u32			 ctl_val[ASPEED_SPI_MAX];
+	u32			 clk_freq;
+};
+
+struct aspeed_spi_data {
+	u32	ctl0;
+	u32	max_cs;
+	bool	hastype;
+	u32	mode_bits;
+	u32	we0;
+
+	u32 (*segment_start)(struct aspeed_spi *aspi, u32 reg);
+	u32 (*segment_end)(struct aspeed_spi *aspi, u32 reg);
+	u32 (*segment_reg)(struct aspeed_spi *aspi, u32 start, u32 end);
+};
+
+#define ASPEED_SPI_MAX_NUM_CS	5
+
+struct aspeed_spi {
+	const struct aspeed_spi_data	*data;
+
+	void __iomem		*regs;
+	void __iomem		*ahb_base;
+	u32			 ahb_base_phy;
+	u32			 ahb_window_size;
+	struct device		*dev;
+
+	struct clk		*clk;
+	u32			 clk_freq;
+
+	struct aspeed_spi_chip	 chips[ASPEED_SPI_MAX_NUM_CS];
+};
+
+static u32 aspeed_spi_get_io_mode(const struct spi_mem_op *op)
+{
+	switch (op->data.buswidth) {
+	case 1:
+		return CTRL_IO_SINGLE_DATA;
+	case 2:
+		return CTRL_IO_DUAL_DATA;
+	case 4:
+		return CTRL_IO_QUAD_DATA;
+	default:
+		return CTRL_IO_SINGLE_DATA;
+	}
+}
+
+static void aspeed_spi_set_io_mode(struct aspeed_spi_chip *chip, u32 io_mode)
+{
+	u32 ctl;
+
+	if (io_mode > 0) {
+		ctl = readl(chip->ctl) & ~CTRL_IO_MODE_MASK;
+		ctl |= io_mode;
+		writel(ctl, chip->ctl);
+	}
+}
+
+static void aspeed_spi_start_user(struct aspeed_spi_chip *chip)
+{
+	u32 ctl = chip->ctl_val[ASPEED_SPI_BASE];
+
+	ctl |= CTRL_IO_MODE_USER | CTRL_CE_STOP_ACTIVE;
+	writel(ctl, chip->ctl);
+
+	ctl &= ~CTRL_CE_STOP_ACTIVE;
+	writel(ctl, chip->ctl);
+}
+
+static void aspeed_spi_stop_user(struct aspeed_spi_chip *chip)
+{
+	u32 ctl = chip->ctl_val[ASPEED_SPI_READ] |
+		CTRL_IO_MODE_USER | CTRL_CE_STOP_ACTIVE;
+
+	writel(ctl, chip->ctl);
+
+	/* Restore defaults */
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+}
+
+static int aspeed_spi_read_from_ahb(void *buf, void __iomem *src, size_t len)
+{
+	size_t offset = 0;
+
+	if (IS_ALIGNED((uintptr_t)src, sizeof(uintptr_t)) &&
+	    IS_ALIGNED((uintptr_t)buf, sizeof(uintptr_t))) {
+		ioread32_rep(src, buf, len >> 2);
+		offset = len & ~0x3;
+		len -= offset;
+	}
+	ioread8_rep(src, (u8 *)buf + offset, len);
+	return 0;
+}
+
+static int aspeed_spi_write_to_ahb(void __iomem *dst, const void *buf, size_t len)
+{
+	size_t offset = 0;
+
+	if (IS_ALIGNED((uintptr_t)dst, sizeof(uintptr_t)) &&
+	    IS_ALIGNED((uintptr_t)buf, sizeof(uintptr_t))) {
+		iowrite32_rep(dst, buf, len >> 2);
+		offset = len & ~0x3;
+		len -= offset;
+	}
+	iowrite8_rep(dst, (const u8 *)buf + offset, len);
+	return 0;
+}
+
+static int aspeed_spi_send_cmd_addr(struct aspeed_spi_chip *chip, u8 addr_nbytes,
+				    u64 offset, u32 opcode)
+{
+	__be32 temp;
+	u32 cmdaddr;
+
+	switch (addr_nbytes) {
+	case 3:
+		cmdaddr = offset & 0xFFFFFF;
+		cmdaddr |= opcode << 24;
+
+		temp = cpu_to_be32(cmdaddr);
+		aspeed_spi_write_to_ahb(chip->ahb_base, &temp, 4);
+		break;
+	case 4:
+		temp = cpu_to_be32(offset);
+		aspeed_spi_write_to_ahb(chip->ahb_base, &opcode, 1);
+		aspeed_spi_write_to_ahb(chip->ahb_base, &temp, 4);
+		break;
+	default:
+		WARN_ONCE(1, "Unexpected address width %u", addr_nbytes);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int aspeed_spi_read_reg(struct aspeed_spi_chip *chip,
+			       const struct spi_mem_op *op)
+{
+	aspeed_spi_start_user(chip);
+	aspeed_spi_write_to_ahb(chip->ahb_base, &op->cmd.opcode, 1);
+	aspeed_spi_read_from_ahb(op->data.buf.in,
+				 chip->ahb_base, op->data.nbytes);
+	aspeed_spi_stop_user(chip);
+	return 0;
+}
+
+static int aspeed_spi_write_reg(struct aspeed_spi_chip *chip,
+				const struct spi_mem_op *op)
+{
+	aspeed_spi_start_user(chip);
+	aspeed_spi_write_to_ahb(chip->ahb_base, &op->cmd.opcode, 1);
+	aspeed_spi_write_to_ahb(chip->ahb_base, op->data.buf.out,
+				op->data.nbytes);
+	aspeed_spi_stop_user(chip);
+	return 0;
+}
+
+static ssize_t aspeed_spi_read_user(struct aspeed_spi_chip *chip,
+				    const struct spi_mem_op *op,
+				    u64 offset, size_t len, void *buf)
+{
+	int io_mode = aspeed_spi_get_io_mode(op);
+	u8 dummy = 0xFF;
+	int i;
+	int ret;
+
+	aspeed_spi_start_user(chip);
+
+	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, offset, op->cmd.opcode);
+	if (ret < 0)
+		return ret;
+
+	if (op->dummy.buswidth && op->dummy.nbytes) {
+		for (i = 0; i < op->dummy.nbytes / op->dummy.buswidth; i++)
+			aspeed_spi_write_to_ahb(chip->ahb_base, &dummy,	sizeof(dummy));
+	}
+
+	aspeed_spi_set_io_mode(chip, io_mode);
+
+	aspeed_spi_read_from_ahb(buf, chip->ahb_base, len);
+	aspeed_spi_stop_user(chip);
+	return 0;
+}
+
+static ssize_t aspeed_spi_write_user(struct aspeed_spi_chip *chip,
+				     const struct spi_mem_op *op)
+{
+	int ret;
+
+	aspeed_spi_start_user(chip);
+	ret = aspeed_spi_send_cmd_addr(chip, op->addr.nbytes, op->addr.val, op->cmd.opcode);
+	if (ret < 0)
+		return ret;
+	aspeed_spi_write_to_ahb(chip->ahb_base, op->data.buf.out, op->data.nbytes);
+	aspeed_spi_stop_user(chip);
+	return 0;
+}
+
+/* support for 1-1-1, 1-1-2 or 1-1-4 */
+static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	if (op->cmd.buswidth > 1)
+		return false;
+
+	if (op->addr.nbytes != 0) {
+		if (op->addr.buswidth > 1)
+			return false;
+		if (op->addr.nbytes < 3 || op->addr.nbytes > 4)
+			return false;
+	}
+
+	if (op->dummy.nbytes != 0) {
+		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
+			return false;
+	}
+
+	if (op->data.nbytes != 0 && op->data.buswidth > 4)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
+	struct aspeed_spi_chip *chip = &aspi->chips[mem->spi->chip_select];
+	u32 addr_mode, addr_mode_backup;
+	u32 ctl_val;
+	int ret = 0;
+
+	dev_dbg(aspi->dev,
+		"CE%d %s OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x len:%#x",
+		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth,
+		op->addr.nbytes, op->dummy.nbytes, op->data.nbytes);
+
+	addr_mode = readl(aspi->regs + CE_CTRL_REG);
+	addr_mode_backup = addr_mode;
+
+	ctl_val = chip->ctl_val[ASPEED_SPI_BASE];
+	ctl_val &= ~CTRL_IO_CMD_MASK;
+
+	ctl_val |= op->cmd.opcode << CTRL_COMMAND_SHIFT;
+
+	/* 4BYTE address mode */
+	if (op->addr.nbytes) {
+		if (op->addr.nbytes == 4)
+			addr_mode |= (0x11 << chip->cs);
+		else
+			addr_mode &= ~(0x11 << chip->cs);
+	}
+
+	if (op->dummy.nbytes)
+		ctl_val |= CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ctl_val |= aspeed_spi_get_io_mode(op);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		ctl_val |= CTRL_IO_MODE_WRITE;
+	else
+		ctl_val |= CTRL_IO_MODE_READ;
+
+	if (addr_mode != addr_mode_backup)
+		writel(addr_mode, aspi->regs + CE_CTRL_REG);
+	writel(ctl_val, chip->ctl);
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (!op->addr.nbytes)
+			ret = aspeed_spi_read_reg(chip, op);
+		else
+			ret = aspeed_spi_read_user(chip, op, op->addr.val,
+						   op->data.nbytes, op->data.buf.in);
+	} else {
+		if (!op->addr.nbytes)
+			ret = aspeed_spi_write_reg(chip, op);
+		else
+			ret = aspeed_spi_write_user(chip, op);
+	}
+
+	/* Restore defaults */
+	if (addr_mode != addr_mode_backup)
+		writel(addr_mode_backup, aspi->regs + CE_CTRL_REG);
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+	return ret;
+}
+
+static int aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	int ret;
+
+	ret = do_aspeed_spi_exec_op(mem, op);
+	if (ret)
+		dev_err(&mem->spi->dev, "operation failed: %d\n", ret);
+	return ret;
+}
+
+static const char *aspeed_spi_get_name(struct spi_mem *mem)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
+	struct device *dev = aspi->dev;
+
+	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
+}
+
+struct aspeed_spi_window {
+	u32 cs;
+	u32 offset;
+	u32 size;
+};
+
+static void aspeed_spi_get_windows(struct aspeed_spi *aspi,
+				   struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS])
+{
+	const struct aspeed_spi_data *data = aspi->data;
+	u32 reg_val;
+	u32 cs;
+
+	for (cs = 0; cs < aspi->data->max_cs; cs++) {
+		reg_val = readl(aspi->regs + CE0_SEGMENT_ADDR_REG + cs * 4);
+		windows[cs].cs = cs;
+		windows[cs].size = data->segment_end(aspi, reg_val) -
+			data->segment_start(aspi, reg_val);
+		windows[cs].offset = cs ? windows[cs - 1].offset + windows[cs - 1].size : 0;
+		dev_vdbg(aspi->dev, "CE%d offset=0x%.8x size=0x%x\n", cs,
+			 windows[cs].offset, windows[cs].size);
+	}
+}
+
+/*
+ * On the AST2600, some CE windows are closed by default at reset but
+ * U-Boot should open all.
+ */
+static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] = { 0 };
+	struct aspeed_spi_window *win = &windows[chip->cs];
+
+	aspeed_spi_get_windows(aspi, windows);
+
+	chip->ahb_base = aspi->ahb_base + win->offset;
+	chip->ahb_window_size = win->size;
+
+	dev_dbg(aspi->dev, "CE%d default window [ 0x%.8x - 0x%.8x ] %dMB",
+		chip->cs, aspi->ahb_base_phy + win->offset,
+		aspi->ahb_base_phy + win->offset + win->size - 1,
+		win->size >> 20);
+
+	return chip->ahb_window_size ? 0 : -1;
+}
+
+static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
+	.supports_op = aspeed_spi_supports_op,
+	.exec_op = aspeed_spi_exec_op,
+	.get_name = aspeed_spi_get_name,
+};
+
+static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned int cs, int type)
+{
+	u32 reg;
+
+	reg = readl(aspi->regs + CONFIG_REG);
+	reg &= ~(0x3 << (cs * 2));
+	reg |= type << (cs * 2);
+	writel(reg, aspi->regs + CONFIG_REG);
+}
+
+static void aspeed_spi_chip_enable(struct aspeed_spi *aspi, unsigned int cs, bool enable)
+{
+	u32 we_bit = BIT(aspi->data->we0 + cs);
+	u32 reg = readl(aspi->regs + CONFIG_REG);
+
+	if (enable)
+		reg |= we_bit;
+	else
+		reg &= ~we_bit;
+	writel(reg, aspi->regs + CONFIG_REG);
+}
+
+static int aspeed_spi_setup(struct spi_device *spi)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->master);
+	const struct aspeed_spi_data *data = aspi->data;
+	unsigned int cs = spi->chip_select;
+	struct aspeed_spi_chip *chip = &aspi->chips[cs];
+
+	chip->aspi = aspi;
+	chip->cs = cs;
+	chip->ctl = aspi->regs + data->ctl0 + cs * 4;
+
+	/* The driver only supports SPI type flash */
+	if (data->hastype)
+		aspeed_spi_chip_set_type(aspi, cs, CONFIG_TYPE_SPI);
+
+	if (aspeed_spi_chip_set_default_window(chip) < 0) {
+		dev_warn(aspi->dev, "CE%d window invalid", cs);
+		return -EINVAL;
+	}
+
+	aspeed_spi_chip_enable(aspi, cs, true);
+
+	chip->ctl_val[ASPEED_SPI_BASE] = CTRL_CE_STOP_ACTIVE | CTRL_IO_MODE_USER;
+
+	dev_dbg(aspi->dev, "CE%d setup done\n", cs);
+	return 0;
+}
+
+static void aspeed_spi_cleanup(struct spi_device *spi)
+{
+	struct aspeed_spi *aspi = spi_controller_get_devdata(spi->master);
+	unsigned int cs = spi->chip_select;
+
+	aspeed_spi_chip_enable(aspi, cs, false);
+
+	dev_dbg(aspi->dev, "CE%d cleanup done\n", cs);
+}
+
+static void aspeed_spi_enable(struct aspeed_spi *aspi, bool enable)
+{
+	int cs;
+
+	for (cs = 0; cs < aspi->data->max_cs; cs++)
+		aspeed_spi_chip_enable(aspi, cs, enable);
+}
+
+static int aspeed_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct aspeed_spi_data *data;
+	struct spi_controller *ctlr;
+	struct aspeed_spi *aspi;
+	struct resource *res;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -ENODEV;
+
+	ctlr = devm_spi_alloc_master(dev, sizeof(*aspi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	aspi = spi_controller_get_devdata(ctlr);
+	platform_set_drvdata(pdev, aspi);
+	aspi->data = data;
+	aspi->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	aspi->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(aspi->regs)) {
+		dev_err(dev, "missing AHB register window\n");
+		return PTR_ERR(aspi->regs);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	aspi->ahb_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(aspi->ahb_base)) {
+		dev_err(dev, "missing AHB mapping window\n");
+		return PTR_ERR(aspi->ahb_base);
+	}
+
+	aspi->ahb_window_size = resource_size(res);
+	aspi->ahb_base_phy = res->start;
+
+	aspi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(aspi->clk)) {
+		dev_err(dev, "missing clock\n");
+		return PTR_ERR(aspi->clk);
+	}
+
+	aspi->clk_freq = clk_get_rate(aspi->clk);
+	if (!aspi->clk_freq) {
+		dev_err(dev, "invalid clock\n");
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(aspi->clk);
+	if (ret) {
+		dev_err(dev, "can not enable the clock\n");
+		return ret;
+	}
+
+	/* IRQ is for DMA, which the driver doesn't support yet */
+
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | data->mode_bits;
+	ctlr->bus_num = pdev->id;
+	ctlr->mem_ops = &aspeed_spi_mem_ops;
+	ctlr->setup = aspeed_spi_setup;
+	ctlr->cleanup = aspeed_spi_cleanup;
+	ctlr->num_chipselect = data->max_cs;
+	ctlr->dev.of_node = dev->of_node;
+
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto disable_clk;
+	}
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(aspi->clk);
+	return ret;
+}
+
+static int aspeed_spi_remove(struct platform_device *pdev)
+{
+	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
+
+	aspeed_spi_enable(aspi, false);
+	clk_disable_unprepare(aspi->clk);
+	return 0;
+}
+
+/*
+ * AHB mappings
+ */
+
+/*
+ * The Segment Registers of the AST2400 and AST2500 use a 8MB unit.
+ * The address range is encoded with absolute addresses in the overall
+ * mapping window.
+ */
+static u32 aspeed_spi_segment_start(struct aspeed_spi *aspi, u32 reg)
+{
+	return ((reg >> 16) & 0xFF) << 23;
+}
+
+static u32 aspeed_spi_segment_end(struct aspeed_spi *aspi, u32 reg)
+{
+	return ((reg >> 24) & 0xFF) << 23;
+}
+
+static u32 aspeed_spi_segment_reg(struct aspeed_spi *aspi, u32 start, u32 end)
+{
+	return (((start >> 23) & 0xFF) << 16) | (((end >> 23) & 0xFF) << 24);
+}
+
+/*
+ * The Segment Registers of the AST2600 use a 1MB unit. The address
+ * range is encoded with offsets in the overall mapping window.
+ */
+
+#define AST2600_SEG_ADDR_MASK 0x0ff00000
+
+static u32 aspeed_spi_segment_ast2600_start(struct aspeed_spi *aspi,
+					    u32 reg)
+{
+	u32 start_offset = (reg << 16) & AST2600_SEG_ADDR_MASK;
+
+	return aspi->ahb_base_phy + start_offset;
+}
+
+static u32 aspeed_spi_segment_ast2600_end(struct aspeed_spi *aspi,
+					  u32 reg)
+{
+	u32 end_offset = reg & AST2600_SEG_ADDR_MASK;
+
+	/* segment is disabled */
+	if (!end_offset)
+		return aspi->ahb_base_phy;
+
+	return aspi->ahb_base_phy + end_offset + 0x100000;
+}
+
+static u32 aspeed_spi_segment_ast2600_reg(struct aspeed_spi *aspi,
+					  u32 start, u32 end)
+{
+	/* disable zero size segments */
+	if (start == end)
+		return 0;
+
+	return ((start & AST2600_SEG_ADDR_MASK) >> 16) |
+		((end - 1) & AST2600_SEG_ADDR_MASK);
+}
+
+/*
+ * Platform definitions
+ */
+static const struct aspeed_spi_data ast2400_fmc_data = {
+	.max_cs	       = 5,
+	.hastype       = true,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.segment_start = aspeed_spi_segment_start,
+	.segment_end   = aspeed_spi_segment_end,
+	.segment_reg   = aspeed_spi_segment_reg,
+};
+
+static const struct aspeed_spi_data ast2500_fmc_data = {
+	.max_cs	       = 3,
+	.hastype       = true,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.segment_start = aspeed_spi_segment_start,
+	.segment_end   = aspeed_spi_segment_end,
+	.segment_reg   = aspeed_spi_segment_reg,
+};
+
+static const struct aspeed_spi_data ast2500_spi_data = {
+	.max_cs	       = 2,
+	.hastype       = false,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.segment_start = aspeed_spi_segment_start,
+	.segment_end   = aspeed_spi_segment_end,
+	.segment_reg   = aspeed_spi_segment_reg,
+};
+
+static const struct aspeed_spi_data ast2600_fmc_data = {
+	.max_cs	       = 3,
+	.hastype       = false,
+	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.segment_start = aspeed_spi_segment_ast2600_start,
+	.segment_end   = aspeed_spi_segment_ast2600_end,
+	.segment_reg   = aspeed_spi_segment_ast2600_reg,
+};
+
+static const struct aspeed_spi_data ast2600_spi_data = {
+	.max_cs	       = 2,
+	.hastype       = false,
+	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
+	.we0	       = 16,
+	.ctl0	       = CE0_CTRL_REG,
+	.segment_start = aspeed_spi_segment_ast2600_start,
+	.segment_end   = aspeed_spi_segment_ast2600_end,
+	.segment_reg   = aspeed_spi_segment_ast2600_reg,
+};
+
+static const struct of_device_id aspeed_spi_matches[] = {
+	{ .compatible = "aspeed,ast2400-fmc", .data = &ast2400_fmc_data },
+	{ .compatible = "aspeed,ast2500-fmc", .data = &ast2500_fmc_data },
+	{ .compatible = "aspeed,ast2500-spi", .data = &ast2500_spi_data },
+	{ .compatible = "aspeed,ast2600-fmc", .data = &ast2600_fmc_data },
+	{ .compatible = "aspeed,ast2600-spi", .data = &ast2600_spi_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aspeed_spi_matches);
+
+static struct platform_driver aspeed_spi_driver = {
+	.probe			= aspeed_spi_probe,
+	.remove			= aspeed_spi_remove,
+	.driver	= {
+		.name		= DEVICE_NAME,
+		.of_match_table = aspeed_spi_matches,
+	}
+};
+
+module_platform_driver(aspeed_spi_driver);
+
+MODULE_DESCRIPTION("ASPEED Static Memory Controller Driver");
+MODULE_AUTHOR("Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>");
+MODULE_AUTHOR("Cedric Le Goater <clg@kaod.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/MAINTAINERS b/MAINTAINERS
index 149e84d32293..fbad83094656 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3109,6 +3109,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+F:	drivers/spi/spi-aspeed-smc.c
 
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 50f4f3484d42..ca45dcd3ffe8 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -1,14 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config SPI_ASPEED_SMC
-	tristate "Aspeed flash controllers in SPI mode"
-	depends on ARCH_ASPEED || COMPILE_TEST
-	depends on HAS_IOMEM && OF
-	help
-	  This enables support for the Firmware Memory controller (FMC)
-	  in the Aspeed AST2500/AST2400 SoCs when attached to SPI NOR chips,
-	  and support for the SPI flash memory controller (SPI) for
-	  the host firmware. The implementation only supports SPI NOR.
-
 config SPI_HISI_SFC
 	tristate "Hisilicon FMC SPI NOR Flash Controller(SFC)"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
index 6e2a1dc68466..0b8e1d530913 100644
--- a/drivers/mtd/spi-nor/controllers/Makefile
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d2815eb361c0..4a3b02ec4ba9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -101,6 +101,17 @@ config SPI_ARMADA_3700
 	  This enables support for the SPI controller present on the
 	  Marvell Armada 3700 SoCs.
 
+config SPI_ASPEED_SMC
+	tristate "Aspeed flash controllers in SPI mode"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on OF
+	help
+	  This enables support for the Firmware Memory controller (FMC)
+	  in the Aspeed AST2600, AST2500 and AST2400 SoCs when attached
+	  to SPI NOR chips, and support for the SPI flash memory
+	  controller (SPI) for the host firmware. The implementation
+	  only supports SPI NOR.
+
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3aa28ed3f761..1566388b96ae 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
 obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
 obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
+obj-$(CONFIG_SPI_ASPEED_SMC)		+= spi-aspeed-smc.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
 obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
 obj-$(CONFIG_SPI_AT91_USART)		+= spi-at91-usart.o
-- 
2.35.1

