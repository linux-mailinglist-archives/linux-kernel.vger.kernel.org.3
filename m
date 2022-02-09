Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45574AF301
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiBINiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiBINhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:37:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E8C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644413859; x=1675949859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56Vhvf0u70vmnyIVAUMgLpS2q4yH2DW8nZy1d9h27Sc=;
  b=ZwxFsOnEhN0iZWMkutpnbFTEUtLCgqz1B86T+5J23OWZH6wJNvMd929R
   HYmqbXnuxHFIXte7VQdkViA5obVcEVOQHOs40pVhYAEEUNjO7ym6RrnLJ
   M+qVtSq85dJ/dj/qpmfZ9l3VvmuCOatW/zAQnRjut65vyV2wjwnrKgVE5
   dX8VdsCUR0CyceV3DEnLXhYUwKTpRAlCY3EcHxt3hG4boPRZjW0+Wm387
   z/OHTiYVlnVrnB57YD1hHzNxR0fDUvvgyGzt0VFfwV+98E/FPWrAxQ/Zz
   1EwYZ63IfTLcSfyxVV4DD/ZOnkILYSSpHLZ6MCUClQ8AxKdyIaGzImVWt
   A==;
IronPort-SDR: UCgVZp/JoAE9v0Fc/lS4g7H1hNUzrR6Hlpe+PJLISEW44LETtn8d01wcc2PbPzG9M6yxGm9Bx2
 Fm/Sq4heJaaqWvH43p4Ng5XC8OBUfqiaNrx6I9mi3Jg2LNhwUcjAjcc31p2Es1RpBwFYTE8oe2
 GeQ7H1Be1fyFpSn7KhoQuUKL4pjfYSJwfNIPmxXz95OP4Esiuq8kp7gIkvf2nj7aATLW1Snsus
 PpUQbDTVid/vX7WnzRkljuTcs8vawagym0qayFZFOQTrCAzxe13xjHjfYMUItiDARkl9utZZrO
 8xXas2UF0INI/EPUwl0pTPZ3
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152460213"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 06:37:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 06:37:35 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 06:37:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <zhengxunli@mxic.com.tw>,
        <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v6 7/7] mtd: spi-nor: macronix: Add support for mx66lm1g45g
Date:   Wed, 9 Feb 2022 15:36:56 +0200
Message-ID: <20220209133656.374903-8-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209133656.374903-1-tudor.ambarus@microchip.com>
References: <20220209133656.374903-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/jedec_id
c2853b
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/manufacturer
macronix
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/partname
mx66lm1g45g
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/sfdp
cat: can't open '/sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/sfdp': No such file or directory

 drivers/mtd/spi-nor/macronix.c | 131 +++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 97dba1ae7fb1..31b2a9f34e03 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,130 @@
 
 #include "core.h"
 
+#define SPINOR_OP_READ_CR2		0x71	/* Read Configuration Register 2 */
+#define SPINOR_OP_WRITE_CR2		0x72	/* Write Configuration Register 2 */
+#define SPINOR_OP_MX_DTR_RD		0xee	/* Octa DTR Read Opcode */
+
+#define SPINOR_REG_CR2_MODE_ADDR	0	/* Address of Mode Enable in CR2 */
+#define SPINOR_REG_CR2_DTR_OPI_ENABLE	BIT(1)	/* DTR OPI Enable */
+#define SPINOR_REG_CR2_SPI		0	/* SPI Enable */
+
+/**
+ * Macronix SPI NOR flash operations.
+ */
+#define SPI_NOR_MX_READ_CR2_OP(ndummy, buf, ndata)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_CR2, 0),		\
+		   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 0),	\
+		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
+		   SPI_MEM_OP_DATA_IN(ndata, buf, 0))
+
+#define SPI_NOR_MX_WRITE_CR2_OP(buf, ndata)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRITE_CR2, 0),		\
+		   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 0),	\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
+
+static int spi_nor_macronix_read_cr2(struct spi_nor *nor, u8 ndummy, void *sr,
+				     unsigned int nbytes)
+{
+	struct spi_mem_op op = SPI_NOR_MX_READ_CR2_OP(ndummy, sr, nbytes);
+
+	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+static int spi_nor_macronix_write_cr2(struct spi_nor *nor, const void *sr,
+				      unsigned int nbytes)
+{
+	struct spi_mem_op op = SPI_NOR_MX_WRITE_CR2_OP(sr, nbytes);
+	int ret;
+
+	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+static int spi_nor_macronix_octal_dtr_en(struct spi_nor *nor)
+{
+	u8 *buf = nor->bouncebuf;
+	int i, ret;
+
+	buf[0] = SPINOR_REG_CR2_DTR_OPI_ENABLE;
+	ret = spi_nor_macronix_write_cr2(nor, buf, 1);
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
+static int spi_nor_macronix_octal_dtr_dis(struct spi_nor *nor)
+{
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	/*
+	 * One byte transactions are not allowed in 8D-8D-8D mode. mx66lm1g45g
+	 * requires that undefined register addresses to keep their value
+	 * unchanged. Its second CR2 byte value is not defined. Read the second
+	 * byte value of CR2 so that we can write it back when disabling
+	 * Octal DTR mode.
+	 */
+	ret = spi_nor_macronix_read_cr2(nor, 4, buf, 2);
+	if (ret)
+		return ret;
+	/* Keep the value of buf[1] unchanged.*/
+	buf[0] = SPINOR_REG_CR2_SPI;
+
+	ret = spi_nor_macronix_write_cr2(nor, buf, 2);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_read_id(nor, 0, 0, buf, nor->reg_proto);
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
+static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	return enable ? spi_nor_macronix_octal_dtr_en(nor) :
+			spi_nor_macronix_octal_dtr_dis(nor);
+}
+
+static void mx66lm1g45g_late_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_macronix_octal_dtr_enable;
+
+	/* Set the Fast Read settings. */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 20, SPINOR_OP_MX_DTR_RD,
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
@@ -100,6 +224,13 @@ static const struct flash_info macronix_parts[] = {
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
+	{ "mx66lm1g45g", INFO(0xc2853b, 0, 64 * 1024, 2048)
+		NO_SFDP_FLAGS(SPI_NOR_SKIP_SFDP | SECT_4K |
+			      SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE |
+			    SPI_NOR_SOFT_RESET)
+		.fixups = &mx66lm1g45g_fixups,
+	},
 };
 
 static void macronix_default_init(struct spi_nor *nor)
-- 
2.25.1

