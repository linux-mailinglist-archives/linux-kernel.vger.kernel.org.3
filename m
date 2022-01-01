Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326104826F6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiAAHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41988 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiAAHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017iIV3103928;
        Sat, 1 Jan 2022 01:44:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023058;
        bh=NEE63Yz1+RVME4bJsFJMNHoNb1X4pjUIAuUmBQ1dia4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qs3cagCWVDWKKISQOJxSp4QHnheZFd7/q4nVVt3vKtxDSA+lbsk2QMSOIlNemqe6n
         dmU8fiaA8qsZ5u3X4cy3ro1fyzJpx25n2Tw4PkHaX2Go+HGVYGbJY/Xr0RyQP35IwT
         mU2cXtDvhv1cHB2FmlDil9ItKoi8jfuQbY7ZhT/o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017iIqV090994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:44:18 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:44:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:44:17 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwj033162;
        Sat, 1 Jan 2022 01:44:12 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>
Subject: [PATCH v3 14/17] mtd: spinand: winbond: Add octal_dtr_enable/disable() in manufacturer_ops
Date:   Sat, 1 Jan 2022 13:12:47 +0530
Message-ID: <20220101074250.14443-15-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220101074250.14443-1-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add implementation of octal_dtr_enable() and octal_dtr_disable()
manufacturer_ops for Winbond. To switch to Ocatl DTR mode, setting
programmable dummy cycles and SPI IO mode using the volatile
configuration register is required. To function at max 120MHz SPI clock
in Octal DTR mode, 12 programmable dummy clock cycle setting is
required. (Default number of dummy cycle are 8 clocks)

Set the programmable dummy cycle to 12 clocks, and SPI IO mode to
Octal DTR with Data Strobe in the VCR. Also, perform a READ ID
operation in Octal DTR SPI mode to ensure the switch was successful.
To disable Octal DTR mode, restore the VCR registers to their default
values and verify it using READ ID operation.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/winbond.c | 85 ++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 3e0829f58350..c7478faf6cee 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -16,6 +16,16 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+/* Octal DTR SPI mode (8D-8D-8D) with Data Strobe output*/
+#define WINBOND_VCR_IO_MODE_OCTAL_DTR	0xE7
+#define WINBOND_VCR_IO_MODE_SINGLE_STR	0xFF
+#define WINBOND_VCR_IO_MODE_ADDR	0x00
+
+/* Use 12 dummy clk cycles for using Octal DTR SPI at max 120MHZ */
+#define WINBOND_VCR_DUMMY_CLK_COUNT	12
+#define WINBOND_VCR_DUMMY_CLK_DEFAULT	0xFF
+#define WINBOND_VCR_DUMMY_CLK_ADDR	0x01
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -157,6 +167,81 @@ static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)
 	return 0;
 }
 
+static int winbond_spinand_octal_dtr_enable(struct spinand_device *spinand)
+{
+	int ret;
+	struct spi_mem_op op;
+
+	ret = winbond_write_vcr_op(spinand, WINBOND_VCR_DUMMY_CLK_ADDR,
+				   WINBOND_VCR_DUMMY_CLK_COUNT);
+	if (ret)
+		return ret;
+
+	ret = winbond_write_vcr_op(spinand, WINBOND_VCR_IO_MODE_ADDR,
+				   WINBOND_VCR_IO_MODE_OCTAL_DTR);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9f9f, 8),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY_DTR(16, 8),
+			   SPI_MEM_OP_DATA_IN_DTR(SPINAND_MAX_ID_LEN,
+						  spinand->scratchbuf, 8));
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (memcmp(spinand->scratchbuf, spinand->id.data, SPINAND_MAX_ID_LEN))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int winbond_spinand_octal_dtr_disable(struct spinand_device *spinand)
+{
+	int ret;
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x8181, 8),
+			   SPI_MEM_OP_ADDR_DTR(4, WINBOND_VCR_IO_MODE_ADDR, 8),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT_DTR(2, spinand->scratchbuf, 8));
+
+	*spinand->scratchbuf = WINBOND_VCR_IO_MODE_SINGLE_STR;
+
+	ret = spinand_write_enable_op(spinand);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	ret = winbond_write_vcr_op(spinand, WINBOND_VCR_DUMMY_CLK_ADDR,
+				   WINBOND_VCR_DUMMY_CLK_DEFAULT);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY(1, 1),
+			   SPI_MEM_OP_DATA_IN(SPINAND_MAX_ID_LEN,
+					      spinand->scratchbuf, 1));
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (memcmp(spinand->scratchbuf, spinand->id.data, SPINAND_MAX_ID_LEN))
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
 	.init = winbond_spinand_init,
 };
-- 
2.25.1

