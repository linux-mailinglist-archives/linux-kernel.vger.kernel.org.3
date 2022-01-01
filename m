Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CBD4826F4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiAAHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:44:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41958 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiAAHoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:44:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017iCO0103915;
        Sat, 1 Jan 2022 01:44:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641023052;
        bh=CV4asBuMEKSdViYhbYLTElCBaMnp4d5WepV25WG6Cqc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pMKpW+FFuxCYx2FgV/GRcKsLVADR3hJyjPCbyJMI8mazELtrLU9huVKoocNkWPqST
         Lmvf7dtyP/+Gy5vbvFKDBg+Lt4mybCWEgChmknUL0nT5JLn1K70ivMaUJPPEHnUvBK
         0x0GKe38xh7tAgzS+79ypDpMH6BssTaHAvWwbBB0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017iBWY090856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:44:12 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:44:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:44:11 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwi033162;
        Sat, 1 Jan 2022 01:44:06 -0600
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
Subject: [PATCH v3 13/17] mtd: spinand: winbond: Add support for write volatile configuration register op
Date:   Sat, 1 Jan 2022 13:12:46 +0530
Message-ID: <20220101074250.14443-14-a-nandan@ti.com>
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

Volatile configuration register are a different set of configuration
registers, i.e. they differ from the status registers. A different
SPI instruction is required to write to these registers. Any changes
to the Volatile Configuration Register get transferred directly to
the Internal Configuration Register and instantly reflect on the
device operation.

In Winbond W35N01JW, these volatile configuration register must be
configured in order to switch to Octal DTR SPI mode.

Add support for writing to volatile configuration registers using a
new WRITE_VCR_OP template.

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c    |  2 +-
 drivers/mtd/nand/spi/winbond.c | 43 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |  1 +
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9d1c72634e5a..21d3b4ebdeaa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -343,7 +343,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
 		engine_conf->status = status;
 }
 
-static int spinand_write_enable_op(struct spinand_device *spinand)
+int spinand_write_enable_op(struct spinand_device *spinand)
 {
 	struct spi_mem_op op = spinand->ctrl_ops->ops.write_enable;
 
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 76684428354e..3e0829f58350 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -7,6 +7,7 @@
  *	Boris Brezillon <boris.brezillon@bootlin.com>
  */
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
@@ -114,6 +115,48 @@ static int winbond_spinand_init(struct spinand_device *spinand)
 	return 0;
 }
 
+/**
+ * winbond_write_vcr_op() - write values onto the volatile configuration
+ *			    registers (VCR)
+ * @spinand: the spinand device
+ * @reg: the address of the particular reg in the VCR to be written on
+ * @val: the value to be written on the reg in the VCR
+ *
+ * Volatile configuration registers are a separate set of configuration
+ * registers, i.e. they differ from the status registers SR-1/2/3. A different
+ * SPI instruction is required to write to these registers. Any changes
+ * to the Volatile Configuration Register get transferred directly to
+ * the Internal Configuration Register and instantly reflect on the
+ * device operation.
+ */
+static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)
+{
+	int ret;
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
+			   SPI_MEM_OP_ADDR(3, reg, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
+
+	*spinand->scratchbuf = val;
+
+	ret = spinand_write_enable_op(spinand);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(spinand->spimem, &op);
+	if (ret)
+		return ret;
+
+	/*
+	 * Write VCR operation doesn't set the busy bit in SR, so can't perform
+	 * a status poll. Minimum time of 50ns is needed to complete the write.
+	 * So, give thrice the minimum required delay.
+	 */
+	ndelay(150);
+	return 0;
+}
+
 static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
 	.init = winbond_spinand_init,
 };
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index f12aa4516fab..4c1925ee327a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -638,5 +638,6 @@ int spinand_match_and_init(struct spinand_device *spinand,
 
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
+int spinand_write_enable_op(struct spinand_device *spinand);
 
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.25.1

