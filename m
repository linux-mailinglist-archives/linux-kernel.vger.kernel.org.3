Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7B56661A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiGEJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGEJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:27:06 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BA4CEA;
        Tue,  5 Jul 2022 02:27:01 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 903FF200ED8;
        Tue,  5 Jul 2022 11:27:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 27A7A200EC7;
        Tue,  5 Jul 2022 11:27:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BE072180222D;
        Tue,  5 Jul 2022 17:26:57 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com,
        zhengxunli@mxic.com.tw
Subject: [PATCH 08/11] mtd: spi-nor: macronix: add support for Macronix octaflash
Date:   Tue,  5 Jul 2022 17:11:40 +0800
Message-Id: <1657012303-6464-8-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The octaflash is an xSPI compliant octal DTR flash. Add support
for using it in octal DTR mode.

Try to verify the flash ID to check whether the flash memory in octal
DTR mode and SPI mode are correct. When reading ID in OCTAL DTR mode,
ID will appear in a repeated manner. ex: ID[0] = 0xc2, ID[1] = 0xc2,
ID[2] = 0x94, ID[3] = 0x94... Rearrange the order so that the ID can pass.

The octaflash series can be divided into the following types:

MX25 series : Serial NOR Flash.
MX66 series : Serial NOR Flash with stacked die.(Size larger than 1Gb)
LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
LW/UW series : Support simultaneous Read-while-Write operation in multiple
	       bank architecture. Read-while-write feature which means read
	       data one bank while another bank is programing or erasing.

MX25LM : 3.0V Octal I/O
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7841/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf

MX25UM : 1.8V Octal I/O
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7525/MX25UM51245G%20Extreme%20Speed,%201.8V,%20512Mb,%20v1.0.pdf

MX66LM : 3.0V Octal I/O with stacked die
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7929/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf

MX66UM : 1.8V Octal I/O with stacked die
 -https://www.mxic.com.tw/Lists/Datasheet/Attachments/7721/MX66UM1G45G,%201.8V,%201Gb,%20v1.1.pdf

MX25LW : 3.0V Octal I/O with Read-while-Write
MX25UW : 1.8V Octal I/O with Read-while-Write
MX66LW : 3.0V Octal I/O with Read-while-Write and stack die
MX66UW : 1.8V Octal I/O with Read-while-Write and stack die

About LW/UW series, please contact us freely if you have any
questions. For adding Octal NOR Flash IDs, we have validated
each Flash on plateform zynq-picozed.

Get this patch from
https://patchwork.ozlabs.org/project/linux-mtd/patch/1621232088-12567-2-git-send-email-zhengxunli@mxic.com.tw/
And add some simple change to match current kernel version.

Signed-off-by: Zhengxun Li <zhengxunli@mxic.com.tw>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/macronix.c | 210 +++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index d81a4cb2812b..b4f4d8185cce 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,12 @@
 
 #include "core.h"
 
+#define SPINOR_OP_RD_CR2		0x71		/* Read configuration register 2 */
+#define SPINOR_OP_WR_CR2		0x72		/* Write configuration register 2 */
+#define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* For setting octal DTR mode */
+#define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
+#define SPINOR_REG_MXIC_SPI_EN		0x0		/* Enable SPI */
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -32,6 +38,85 @@ static const struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 };
 
+/**
+ * spi_nor_macronix_octal_dtr_enable() - Enable octal DTR on Macronix flashes.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @enable:		whether to enable Octal DTR or switch back to SPI
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf, i;
+	int ret;
+
+	/* Set/unset the octal and DTR enable bits. */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		buf[0] = SPINOR_REG_MXIC_OPI_DTR_EN;
+	} else {
+		/*
+		 * The register is 1-byte wide, but 1-byte transactions are not
+		 * allowed in 8D-8D-8D mode. Since there is no register at the
+		 * next location, just initialize the value to 0 and let the
+		 * transaction go on.
+		 */
+		buf[0] = SPINOR_REG_MXIC_SPI_EN;
+		buf[1] = 0x0;
+	}
+
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_CR2, 1),
+			   SPI_MEM_OP_ADDR(4, SPINOR_REG_MXIC_CR2_MODE, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
+			   SPI_MEM_OP_ADDR(enable ? 4 : 0, 0, 1),
+			   SPI_MEM_OP_DUMMY(enable ? 4 : 0, 1),
+			   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, buf, 1));
+
+	if (enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		for (i = 0; i < nor->info->id_len; i++)
+			if (buf[i * 2] != nor->info->id[i])
+				return -EINVAL;
+	} else {
+		if (memcmp(buf, nor->info->id, nor->info->id_len))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void octaflash_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
+}
+
+static struct spi_nor_fixups octaflash_fixups = {
+	.default_init = octaflash_default_init,
+};
+
 static const struct flash_info macronix_nor_parts[] = {
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
@@ -100,6 +185,131 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{ "mx66lm2g45g", INFO(0xc2853c, 0, 64 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66lm1g45g", INFO(0xc2853b, 0, 32 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66lw1g45g", INFO(0xc2863b, 0, 32 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lm51245g", INFO(0xc2853a, 0, 16 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lw51245g", INFO(0xc2863a, 0, 16 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lm25645g", INFO(0xc28539, 0, 8 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25lw25645g", INFO(0xc28639, 0, 8 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66um2g45g", INFO(0xc2803c, 0, 64 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66uw2g345g", INFO(0xc2843c, 0, 64 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66uw2g345gx0", INFO(0xc2943c, 0, 64 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66um1g45g", INFO(0xc2803b, 0, 32 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66um1g45g40", INFO(0xc2808b, 0, 32 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx66uw1g45g", INFO(0xc2813b, 0, 32 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25um51245g", INFO(0xc2803a, 0, 16 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw51245g", INFO(0xc2813a, 0, 16 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw51345g", INFO(0xc2843a, 0, 16 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25um25645g", INFO(0xc28039, 0, 8 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw25645g", INFO(0xc28139, 0, 8 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25um25345g", INFO(0xc28339, 0, 8 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw25345g", INFO(0xc28439, 0, 8 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw12845g", INFO(0xc28138, 0, 4 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw12a45g", INFO(0xc28938, 0, 4 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw12345g", INFO(0xc28438, 0, 4 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw6445g", INFO(0xc28137, 0, 2 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
+	{ "mx25uw6345g", INFO(0xc28437, 0, 2 * 1024, 4096)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
+			      SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		.fixups = &octaflash_fixups },
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)
-- 
2.25.1

