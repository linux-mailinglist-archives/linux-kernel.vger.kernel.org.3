Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A9B4D5CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbiCKIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbiCKIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:03:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6381B84FA;
        Fri, 11 Mar 2022 00:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646985733; x=1678521733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhsW26KDVAuX2rqNqzl4LM5mRu0w+edNUhiiIx7cWkg=;
  b=nE+jafGcmHUcfkLsV87p5m7JW1s2ZdCXTT0+87NTlG0r6+ihH0qfImfA
   lz8GtEjcquE9PT4OUZ2Z1FObS3TExRaBrhK8mMn501k4HwUdHbdPE50gm
   zujnan+9nVp03jLGG2IzVXNoM+cgJ3SFuwBeyWUkq0kGEcyKnup9mWext
   GZl2GNr/zX2fyFOufD16qcvqHvYGrKcAKL7J8j8qZnRuCpVndIeYXDIHo
   hAri9ylU+7xe6NYHlE40IO+W8our8+LgA8qOWsYATImAakrIpxVynTCsB
   nzJzt8x2GebOEJ1osAKczNZ9078chl8Z/01ougP58st/cn9U0qNHKZR6D
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643698800"; 
   d="scan'208";a="148864968"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2022 01:02:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 01:02:11 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Mar 2022 01:02:09 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 6/6] mtd: spi-nor: macronix: Add support for mx66lm1g45g
Date:   Fri, 11 Mar 2022 10:01:47 +0200
Message-ID: <20220311080147.453483-7-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311080147.453483-1-tudor.ambarus@microchip.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mx66lm1g45g supports just 1-1-1, 8-8-8 and 8D-8D-8D modes. There are
versions of mx66lm1g45g which do not support SFDP, thus use
SPI_NOR_SKIP_SFDP. The RDID command issued through the octal peripheral
interface outputs data always in STR mode for whatever reason. Since
8D-8D-8S is not common, avoid reading the ID when enabling the octal dtr
mode. Instead, read back the CR2 to check if the switch was successful.
Tested in 1-1-1 and 8d-8d-8d modes using sama7g5 QSPI IP.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20220209133656.374903-8-tudor.ambarus@microchip.com
---
 drivers/mtd/spi-nor/macronix.c | 130 +++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index c267cbcc7f1d..c9b9536f93f2 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,128 @@
 
 #include "core.h"
 
+#define MACRONIX_NOR_OP_WRITE_CR2		0x72	/* Write Configuration Register 2 */
+#define MACRONIX_NOR_OP_DTR_RD			0xee	/* Octa DTR Read Opcode */
+
+#define MACRONIX_NOR_REG_CR2_MODE_ADDR		0	/* Address of Mode Enable in CR2 */
+#define MACRONIX_NOR_REG_CR2_DTR_OPI_ENABLE	BIT(1)	/* DTR OPI Enable */
+#define MACRONIX_NOR_REG_CR2_SPI		0	/* SPI Enable */
+
+/* Macronix SPI NOR flash operations. */
+#define MACRONIX_NOR_WRITE_CR2_OP(addr, buf, ndata)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(MACRONIX_NOR_OP_WRITE_CR2, 0),	\
+		   SPI_MEM_OP_ADDR(4, addr, 0),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
+
+static int macronix_nor_write_cr2(struct spi_nor *nor, u64 addr, u8 val)
+{
+	u8 *buf = nor->bouncebuf;
+	struct spi_mem_op op;
+	unsigned int nbytes;
+	int ret;
+
+	if (spi_nor_protocol_is_dtr(nor->reg_proto)) {
+		/*
+		 * When the flash is configured in 8D-8D-8D mode, halfwords are
+		 * send/received instead of bytes. One byte transactions are not
+		 * allowed in 8D-8D-8D mode, so we're going to send two bytes to
+		 * the flash to pass the 8D-8D-8D sanity checks. Macronix
+		 * ignores the second byte value in case of a one byte register
+		 * writes, we don't care of the value of the second byte.
+		 * When in 8D-8D-8D mode endianness must be configured according
+		 * to the flash requirements. Macronix swaps data bytes on a
+		 * 16-bit boundary, so the SPI NOR subsystem instructs the SPI
+		 * controllers to swap the bytes back to keep compatibility with
+		 * the STR modes. The swap back is always done regardless if
+		 * it's a register or data access. Since Macronix ignores the
+		 * second byte value on register writes and the SPI controllers
+		 * will swap the bytes, we actually have to set the value on the
+		 * second byte and ignore the first.
+		 */
+		buf[1] = val;
+		nbytes = 2;
+
+	} else {
+		buf[0] = val;
+		nbytes = 1;
+	}
+
+	op = (struct spi_mem_op)MACRONIX_NOR_WRITE_CR2_OP(addr, buf, nbytes);
+	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
+{
+	u8 *buf = nor->bouncebuf;
+	int i, ret;
+
+	ret = macronix_nor_write_cr2(nor, MACRONIX_NOR_REG_CR2_MODE_ADDR,
+				     MACRONIX_NOR_REG_CR2_DTR_OPI_ENABLE);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	ret = spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nor->info->id_len; i++)
+		if (buf[i * 2] != nor->info->id[i])
+			return -EINVAL;
+	return 0;
+}
+
+static int macronix_nor_octal_dtr_dis(struct spi_nor *nor)
+{
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	ret = macronix_nor_write_cr2(nor, MACRONIX_NOR_REG_CR2_MODE_ADDR,
+				     MACRONIX_NOR_REG_CR2_SPI);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
+	if (ret)
+		return ret;
+
+	if (memcmp(buf, nor->info->id, nor->info->id_len)) {
+		dev_dbg(nor->dev, "Failed to disable 8D-8D-8D mode.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int macronix_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	return enable ? macronix_nor_octal_dtr_en(nor) :
+			macronix_nor_octal_dtr_dis(nor);
+}
+
+static void mx66lm1g45g_late_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = macronix_nor_octal_dtr_enable;
+
+	/* Set the Fast Read settings. */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 20, MACRONIX_NOR_OP_DTR_RD,
+				  SNOR_PROTO_8_8_8_DTR);
+
+	nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
+	nor->params->rdsr_dummy = 4;
+	nor->params->rdsr_addr_nbytes = 4;
+}
+
+static struct spi_nor_fixups mx66lm1g45g_fixups = {
+	.late_init = mx66lm1g45g_late_init,
+};
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -100,6 +222,14 @@ static const struct flash_info macronix_nor_parts[] = {
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{ "mx66lm1g45g", INFO(0xc2853b, 0, 64 * 1024, 2048)
+		NO_SFDP_FLAGS(SPI_NOR_SKIP_SFDP | SECT_4K |
+			      SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP |
+			      SPI_NOR_DTR_SWAB16)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE |
+			    SPI_NOR_SOFT_RESET)
+		.fixups = &mx66lm1g45g_fixups,
+	},
 };
 
 static void macronix_nor_default_init(struct spi_nor *nor)
-- 
2.25.1

