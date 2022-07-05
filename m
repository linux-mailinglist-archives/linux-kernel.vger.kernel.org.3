Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3256661E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiGEJ1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGEJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:27:06 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8957011C06;
        Tue,  5 Jul 2022 02:27:03 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44F6F200F0E;
        Tue,  5 Jul 2022 11:27:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17BF3200F0B;
        Tue,  5 Jul 2022 11:27:02 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AC5A3181D0CA;
        Tue,  5 Jul 2022 17:26:59 +0800 (+08)
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
Subject: [PATCH 09/11] mtd: spi-nor: macronix: add mx25uw51345g OPI mode support
Date:   Tue,  5 Jul 2022 17:11:41 +0800
Message-Id: <1657012303-6464-9-git-send-email-haibo.chen@nxp.com>
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

mx25uw51345g has a special OPI DTR read command id, so add this
special fixup.
For RDID under OPI DTR mode, the dummy need to enlarge to 20 cycles,
otherwise can't get correct ID value.

Acked-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/macronix.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index b4f4d8185cce..99140fc9305b 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -13,6 +13,7 @@
 #define SPINOR_REG_MXIC_CR2_MODE	0x00000000	/* For setting octal DTR mode */
 #define SPINOR_REG_MXIC_OPI_DTR_EN	0x2		/* Enable Octal DTR */
 #define SPINOR_REG_MXIC_SPI_EN		0x0		/* Enable SPI */
+#define SPINOR_OP_OPI_DTR_RD		0xEE		/* OPI DTR first read opcode */
 
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
@@ -117,6 +118,19 @@ static struct spi_nor_fixups octaflash_fixups = {
 	.default_init = octaflash_default_init,
 };
 
+static void mx25uw51345g_post_sfdp_fixup(struct spi_nor *nor)
+{
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 20, SPINOR_OP_OPI_DTR_RD,
+				  SNOR_PROTO_8_8_8_DTR);
+}
+
+static struct spi_nor_fixups mx25uw51345g_fixups = {
+	.default_init = octaflash_default_init,
+	.post_sfdp = mx25uw51345g_post_sfdp_fixup,
+};
+
 static const struct flash_info macronix_nor_parts[] = {
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
@@ -264,7 +278,7 @@ static const struct flash_info macronix_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
 			      SPI_NOR_OCTAL_DTR_PP)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
-		.fixups = &octaflash_fixups },
+		.fixups = &mx25uw51345g_fixups },
 	{ "mx25um25645g", INFO(0xc28039, 0, 8 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
 			      SPI_NOR_OCTAL_DTR_PP)
-- 
2.25.1

