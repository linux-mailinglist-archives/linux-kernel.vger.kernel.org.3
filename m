Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2C478C89
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhLQNl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:41:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16965 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbhLQNl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639748517; x=1671284517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wFTnrCS5Gpgnv2BEzuIoBd8CNz4nnAe22//WKX5ujbE=;
  b=zgBpYOjPksO14nKBMOhhAIYcnsMR9nRhfxRUVetkirhsyZ6xhGriMrwE
   bUv1awF3Nhe2f0/CII2Ly6WWcQGg1RicKzXrCgkxb2PxAgXLNUy8wxUIM
   u/XkfHTY7sjxC/BuSz9lBA2jxhYhCjTnbFErw5DklpqEDAeKp2GoS7Him
   xn4iaZHY2FhCDwokd3mcvcUV4P7NPfqclaRGwEnYd4V/EaJvdNrIobRgS
   JkukVnLCFOcKAiZUWfI9IHphLnzVvTJD5ea20lu030FspT3XH/PzkbUR5
   UuCafo1HLc+FeC0l/7HxSyakyXHl2yXFdRbx1iaLLOFO8L68tpAZc7wQ8
   Q==;
IronPort-SDR: YhMiuIW+UmPOKBHzM77MKA28C21a4Q9SXu+9YljQDaexGV6V16+XhXP3HcJqs22sCOyFu/jZZ9
 y85bCFh4ScHKUUIBROkUlQ8sHbcckzlsYkhx9K5ncuOYQO+63XmiT1+KWO/Z3nRdOcCf37VrKS
 GX39w64Tjyp07tja7l7nA8ko6ZQh667gXPxYbdD6FpymaFKzZwMVR+nOppt6LwkDMvAvUzXCjb
 4puOwTYj0Y0VlmaZQBoMf4W99vt6SFQi1OHTCy73Mp9eQ0MHTJJBIJWhxk5W0BPj7Mqw06SAcm
 //V/bJqGCf7c5Qr2XOwYPUHZ
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="147590597"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 06:41:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 06:41:56 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Dec 2021 06:41:54 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: macronix: Add support for mx66lm1g45g
Date:   Fri, 17 Dec 2021 15:41:50 +0200
Message-ID: <20211217134150.497731-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217134150.497731-1-tudor.ambarus@microchip.com>
References: <20211217134150.497731-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mx66lm1g45g supports just 1-1-1, 8-8-8 and 8d-8d-8d modes. There are
versions of mx66lm1g45g which do not support SFDP, thus use
SPI_NOR_SKIP_SFDP. The RDID command issued through the octal peripheral
interface outputs data always in STR mode for whatever reason. Since
8d-8d-8s is not common, avoid reading the ID when enabling the octal dtr
mode. Instead, read back the CR2 to check if the switch was successful.
Tested in 1-1-1 and 8d-8d-8d modes using sama7g5 QSPI IP.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2:
- drop setting of dummy cycles, use the default value
- avoid odd lengths in octal dtr mode
- s/8d-8d-8d/8D-8D-8D

# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/jedec_id
c2853b
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/manufacturer
macronix
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/partname
mx66lm1g45g
# cat /sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/sfdp
cat: can't open '/sys/devices/platform/soc/e080c000.spi/spi_master/spi1/spi1.0/spi-nor/sfdp': No such file or directory

 drivers/mtd/spi-nor/macronix.c | 96 ++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 67aaa83038b6..4c672deb1d1c 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -32,6 +32,95 @@ static struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 };
 
+#define SPINOR_OP_READ_CR2		0x71
+#define SPINOR_OP_WRITE_CR2		0x72
+#define SPINOR_OP_MX_DTR_RD		0xee
+
+#define SPINOR_REG_CR2_MODE_ADDR	0
+#define SPINOR_REG_CR2_DTR_OPI_ENABLE	BIT(1)
+#define SPINOR_REG_CR2_SPI		0
+
+static int spi_nor_macronix_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	u8 *buf = nor->bouncebuf;
+	struct spi_mem_op op;
+	int ret;
+
+	/* Set/unset the octal and DTR enable bits. */
+	if (enable) {
+		buf[0] = SPINOR_REG_CR2_DTR_OPI_ENABLE;
+	} else {
+		/*
+		 * The register is one byte wide, but the one byte transactions
+		 * are not allowed in 8D-8D-8D mode. Since there is no register
+		 * at the next location, just initialize the value to zero and
+		 * let the transaction go on.
+		 */
+		buf[0] = SPINOR_REG_CR2_SPI;
+		buf[1] = 0;
+	}
+
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRITE_CR2, 1),
+			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(enable ? 1 : 2, buf, 1));
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	/* Read back CR2 to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_READ_CR2, 1),
+			   SPI_MEM_OP_ADDR(4, SPINOR_REG_CR2_MODE_ADDR, 1),
+			   SPI_MEM_OP_DUMMY(enable ? 4 : 0, 1),
+			   SPI_MEM_OP_DATA_IN(enable ? 2 : 1, buf, 1));
+	if (enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		if (buf[0] != SPINOR_REG_CR2_DTR_OPI_ENABLE) {
+			dev_dbg(nor->dev, "Failed to enable 8D-8D-8D mode.\n");
+			return -EINVAL;
+		}
+	} else if (buf[0] != SPINOR_REG_CR2_SPI) {
+		dev_dbg(nor->dev, "Failed to disable 8D-8D-8D mode.\n");
+		return -EINVAL;
+	}
+
+	return 0;
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
 static const struct flash_info macronix_parts[] = {
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1)
@@ -100,6 +189,13 @@ static const struct flash_info macronix_parts[] = {
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

