Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1757E911
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiGVVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiGVVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:48:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B257B5CB0;
        Fri, 22 Jul 2022 14:48:25 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MKYHHt031010;
        Fri, 22 Jul 2022 21:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=ZOfuC5nkEvuwO6khkyhnPfVHmCN4ctH5+vRjE6ry8gw=;
 b=Ibc5IlXB5QPSYwr9FPIH8T2a7NCZQsJBzFRo71p46XlD8zasS8zQZhz1TIFle800BVG7
 3W2FUmAnI5dNfQYk2ne6KDXVj2kwAYJENfIW6xeRxbt3hTGneEJFbuWELJgmgKR+YZWL
 7JghK+27Zpjy8uKVSVQrGaJfWgWoY6TW0XsvYmL+8/VndNBXMkWbD98d6Uy87IogsK93
 dX9J2rcg8wuR/9mPjv5ovap2C6IIOoR1OZgCUwqMMKLBx9zLUMr9JNuArd2JNNBMKcF+
 5vjgWn6xTpvXXgg0FO+8qrwKkaGXky+etjI5C3qJYJpkjhd7ZPtETwcR9Bp9Esa1KwqM fw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hfsy3cs1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 21:48:08 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id DFAA714796;
        Fri, 22 Jul 2022 21:48:06 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 62B91809402;
        Fri, 22 Jul 2022 21:48:06 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v3 1/5] spi: spi-gxp: Add support for HPE GXP SoCs
Date:   Fri, 22 Jul 2022 16:49:16 -0500
Message-Id: <20220722214920.40485-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722214920.40485-1-nick.hawkins@hpe.com>
References: <20220722214920.40485-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: yDquuiq5sf-h-61dhEw3gnwDHqSPQRpQ
X-Proofpoint-ORIG-GUID: yDquuiq5sf-h-61dhEw3gnwDHqSPQRpQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220089
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP supports 3 separate SPI interfaces to accommodate the system
flash, core flash, and other functions. The SPI engine supports variable
clock frequency, selectable 3-byte or 4-byte addressing and a
configurable x1, x2, and x4 command/address/data modes. The memory
buffer for reading and writing ranges between 256 bytes and 8KB. This
driver supports access to the core flash and bios part.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v3:
 *No change
v2:
 *Removed repeated include file
 *Removed unnecessary initialization of ret variable
 *Removed conditional variable checks where failure is impossible
 *Removed unecessary variable cs and instead used in the initialization
 *Removed blank gxp_spifi_remove function
 *Fixed error messages so they are not repetitive
---
 drivers/spi/Kconfig   |   7 +
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-gxp.c | 325 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+)
 create mode 100644 drivers/spi/spi-gxp.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1044ebc400..543e4a5b5ffa 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -371,6 +371,13 @@ config SPI_FSL_QUADSPI
 	  This controller does not support generic SPI messages. It only
 	  supports the high-level SPI memory interface.
 
+config SPI_GXP
+	tristate "GXP SPI driver"
+	depends on ARCH_HPE || COMPILE_TEST
+	help
+	 This enables support for the driver for GXP bus attached SPI
+	 controllers.
+
 config SPI_HISI_KUNPENG
 	tristate "HiSilicon SPI Controller for Kunpeng SoCs"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 0f44eb6083a5..ca5f204017ee 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_SPI_FSL_LPSPI)		+= spi-fsl-lpspi.o
 obj-$(CONFIG_SPI_FSL_QUADSPI)		+= spi-fsl-qspi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
+obj-$(CONFIG_SPI_GXP)			+= spi-gxp.o
 obj-$(CONFIG_SPI_HISI_KUNPENG)		+= spi-hisi-kunpeng.o
 obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
diff --git a/drivers/spi/spi-gxp.c b/drivers/spi/spi-gxp.c
new file mode 100644
index 000000000000..9ea355f7d64f
--- /dev/null
+++ b/drivers/spi/spi-gxp.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0=or-later
+/* Copyright (C) 2022 Hewlett-Packard Development Company, L.P. */
+
+#include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#define GXP_SPI0_MAX_CHIPSELECT	2
+#define GXP_SPI_SLEEP_TIME	1
+#define GXP_SPI_TIMEOUT (130 * 1000000 / GXP_SPI_SLEEP_TIME)
+
+#define MANUAL_MODE		0
+#define DIRECT_MODE		1
+#define SPILDAT_LEN		256
+
+#define OFFSET_SPIMCFG		0x0
+#define OFFSET_SPIMCTRL		0x4
+#define OFFSET_SPICMD		0x5
+#define OFFSET_SPIDCNT		0x6
+#define OFFSET_SPIADDR		0x8
+#define OFFSET_SPIINTSTS	0xc
+
+#define SPIMCTRL_START		0x01
+#define SPIMCTRL_BUSY		0x02
+#define SPIMCTRL_DIR		0x08
+
+struct gxp_spi;
+
+struct gxp_spi_chip {
+	struct gxp_spi *spifi;
+	u32 cs;
+};
+
+struct gxp_spi_data {
+	u32 max_cs;
+	u32 mode_bits;
+};
+
+struct gxp_spi {
+	const struct gxp_spi_data *data;
+	void __iomem *reg_base;
+	void __iomem *dat_base;
+	void __iomem *dir_base;
+	struct device *dev;
+	struct gxp_spi_chip chips[GXP_SPI0_MAX_CHIPSELECT];
+};
+
+static void gxp_spi_set_mode(struct gxp_spi *spifi, int mode)
+{
+	u8 value;
+	void __iomem *reg_base = spifi->reg_base;
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+
+	if (mode == MANUAL_MODE) {
+		writeb(0x55, reg_base + OFFSET_SPICMD);
+		writeb(0xaa, reg_base + OFFSET_SPICMD);
+		value &= ~0x30;
+	} else {
+		value |= 0x30;
+	}
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+}
+
+static int gxp_spi_read_reg(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	int ret;
+	struct gxp_spi *spifi = chip->spifi;
+	void __iomem *reg_base = spifi->reg_base;
+	u32 value;
+
+	value = readl(reg_base + OFFSET_SPIMCFG);
+	value &= ~(1 << 24);
+	value |= (chip->cs << 24);
+	value &= ~(0x07 << 16);
+	value &= ~(0x1f << 19);
+	writel(value, reg_base + OFFSET_SPIMCFG);
+
+	writel(0, reg_base + OFFSET_SPIADDR);
+
+	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
+
+	writew(op->data.nbytes, reg_base + OFFSET_SPIDCNT);
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+	value &= ~SPIMCTRL_DIR;
+	value |= SPIMCTRL_START;
+
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+
+	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
+				 !(value & SPIMCTRL_BUSY),
+				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
+	if (ret) {
+		dev_warn(spifi->dev, "read reg busy time out\n");
+		return ret;
+	}
+
+	memcpy_fromio(op->data.buf.in, spifi->dat_base, op->data.nbytes);
+	return ret;
+}
+
+static int gxp_spi_write_reg(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	int ret;
+	struct gxp_spi *spifi = chip->spifi;
+	void __iomem *reg_base = spifi->reg_base;
+	u32 value;
+
+	value = readl(reg_base + OFFSET_SPIMCFG);
+	value &= ~(1 << 24);
+	value |= (chip->cs << 24);
+	value &= ~(0x07 << 16);
+	value &= ~(0x1f << 19);
+	writel(value, reg_base + OFFSET_SPIMCFG);
+
+	writel(0, reg_base + OFFSET_SPIADDR);
+
+	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
+
+	memcpy_toio(spifi->dat_base, op->data.buf.in, op->data.nbytes);
+
+	writew(op->data.nbytes, reg_base + OFFSET_SPIDCNT);
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+	value |= SPIMCTRL_DIR;
+	value |= SPIMCTRL_START;
+
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+
+	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
+				 !(value & SPIMCTRL_BUSY),
+				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
+	if (ret)
+		dev_warn(spifi->dev, "write reg busy time out\n");
+
+	return ret;
+}
+
+static ssize_t gxp_spi_read(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	struct gxp_spi *spifi = chip->spifi;
+	u32 offset = op->addr.val;
+
+	if (chip->cs == 0)
+		offset += 0x4000000;
+
+	memcpy_fromio(op->data.buf.in, spifi->dir_base + offset, op->data.nbytes);
+
+	return 0;
+}
+
+static ssize_t gxp_spi_write(struct gxp_spi_chip *chip, const struct spi_mem_op *op)
+{
+	struct gxp_spi *spifi = chip->spifi;
+	void __iomem *reg_base = spifi->reg_base;
+	u32 write_len;
+	u32 value;
+	int ret;
+
+	write_len = op->data.nbytes;
+	if (write_len > SPILDAT_LEN)
+		write_len = SPILDAT_LEN;
+
+	value = readl(reg_base + OFFSET_SPIMCFG);
+	value &= ~(1 << 24);
+	value |= (chip->cs << 24);
+	value &= ~(0x07 << 16);
+	value |= (op->addr.nbytes << 16);
+	value &= ~(0x1f << 19);
+	writel(value, reg_base + OFFSET_SPIMCFG);
+
+	writel(op->addr.val, reg_base + OFFSET_SPIADDR);
+
+	writeb(op->cmd.opcode, reg_base + OFFSET_SPICMD);
+
+	writew(write_len, reg_base + OFFSET_SPIDCNT);
+
+	memcpy_toio(spifi->dat_base, op->data.buf.in, write_len);
+
+	value = readb(reg_base + OFFSET_SPIMCTRL);
+	value |= SPIMCTRL_DIR;
+	value |= SPIMCTRL_START;
+
+	writeb(value, reg_base + OFFSET_SPIMCTRL);
+
+	ret = readb_poll_timeout(reg_base + OFFSET_SPIMCTRL, value,
+				 !(value & SPIMCTRL_BUSY),
+				 GXP_SPI_SLEEP_TIME, GXP_SPI_TIMEOUT);
+	if (ret) {
+		dev_warn(spifi->dev, "write busy time out\n");
+		return ret;
+	}
+
+	return write_len;
+}
+
+static int do_gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct gxp_spi *spifi = spi_controller_get_devdata(mem->spi->master);
+	struct gxp_spi_chip *chip = &spifi->chips[mem->spi->chip_select];
+	int ret;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (!op->addr.nbytes)
+			ret = gxp_spi_read_reg(chip, op);
+		else
+			ret = gxp_spi_read(chip, op);
+	} else {
+		if (!op->addr.nbytes)
+			ret = gxp_spi_write_reg(chip, op);
+		else
+			ret = gxp_spi_write(chip, op);
+	}
+
+	return ret;
+}
+
+static int gxp_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	int ret;
+
+	ret = do_gxp_exec_mem_op(mem, op);
+	if (ret)
+		dev_err(&mem->spi->dev, "operation failed: %d", ret);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops gxp_spi_mem_ops = {
+	.exec_op = gxp_exec_mem_op,
+};
+
+static int gxp_spi_setup(struct spi_device *spi)
+{
+	struct gxp_spi *spifi = spi_controller_get_devdata(spi->master);
+	unsigned int cs = spi->chip_select;
+	struct gxp_spi_chip *chip = &spifi->chips[cs];
+
+	chip->spifi = spifi;
+	chip->cs = cs;
+
+	gxp_spi_set_mode(spifi, MANUAL_MODE);
+
+	return 0;
+}
+
+static int gxp_spifi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct gxp_spi_data *data;
+	struct spi_controller *ctlr;
+	struct gxp_spi *spifi;
+	struct resource *res;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+
+	ctlr = devm_spi_alloc_master(dev, sizeof(*spifi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	spifi = spi_controller_get_devdata(ctlr);
+
+	platform_set_drvdata(pdev, spifi);
+	spifi->data = data;
+	spifi->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	spifi->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spifi->reg_base))
+		return PTR_ERR(spifi->reg_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	spifi->dat_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spifi->dat_base))
+		return PTR_ERR(spifi->dat_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	spifi->dir_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spifi->dir_base))
+		return PTR_ERR(spifi->dir_base);
+
+	ctlr->mode_bits = data->mode_bits;
+	ctlr->bus_num = pdev->id;
+	ctlr->mem_ops = &gxp_spi_mem_ops;
+	ctlr->setup = gxp_spi_setup;
+	ctlr->num_chipselect = data->max_cs;
+	ctlr->dev.of_node = dev->of_node;
+
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register spi controller\n");
+	}
+
+	return 0;
+}
+
+static const struct gxp_spi_data gxp_spifi_data = {
+	.max_cs	= 2,
+	.mode_bits = 0,
+};
+
+static const struct of_device_id gxp_spifi_match[] = {
+	{.compatible = "hpe,gxp-spifi", .data = &gxp_spifi_data },
+	{ /* null */ }
+};
+MODULE_DEVICE_TABLE(of, gxp_spifi_match);
+
+static struct platform_driver gxp_spifi_driver = {
+	.probe = gxp_spifi_probe,
+	.driver = {
+		.name = "gxp-spifi",
+		.of_match_table = gxp_spifi_match,
+	},
+};
+module_platform_driver(gxp_spifi_driver);
+
+MODULE_DESCRIPTION("HPE GXP SPI Flash Interface driver");
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

