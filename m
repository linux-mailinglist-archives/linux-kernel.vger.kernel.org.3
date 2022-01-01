Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2BD4826E0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiAAHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:43:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41818 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiAAHnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:43:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2017hEsP103763;
        Sat, 1 Jan 2022 01:43:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641022994;
        bh=fGDfRVAjjhgDDv63T/ddhpIqXTX/Z73J6OSl6cnmvHk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k/tJp3wQVfePDxxGqEukGSu1w8S1CJdqKRbhLAeG/Qd5irWP6o03SDhsnvPNGAHIH
         fBIB+lkO4jTI1XfM6v38Qsfie59vQohQjeaWCBl/vj6OaETRQ6k/+7g8c12dcp7h8O
         ZODRyyJIo2dNkFRk+jh/MPwS8uyy788NPCWBkjgA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2017hE1Q089512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jan 2022 01:43:14 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 1
 Jan 2022 01:43:14 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 1 Jan 2022 01:43:14 -0600
Received: from LT5CD112GSQZ.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2017gpwY033162;
        Sat, 1 Jan 2022 01:43:08 -0600
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
Subject: [PATCH v3 03/17] mtd: spinand: Add enum spinand_protocol to indicate current SPI IO mode
Date:   Sat, 1 Jan 2022 13:12:36 +0530
Message-ID: <20220101074250.14443-4-a-nandan@ti.com>
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

Unlike Dual and Quad SPI modes flashes, Octal DTR SPI NAND flashes
require all instructions to be made in 8D-8D-8D protocol when the
flash is in Octal DTR mode. Hence, storing the current SPI IO mode
becomes necessary for operating the flash and switching between modes.

Store the current SPI IO mode in the spinand struct using a
spinand_protocol enum. This would act as a flag, denoting that the
core should use the given SPI protocol all types of flash operations.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c |  2 ++
 include/linux/mtd/spinand.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2c8685f1f2fa..7d8c2873ab29 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1155,6 +1155,7 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	int ret;
 
+	spinand->protocol = SPINAND_1S_1S_1S;
 	ret = spinand_reset_op(spinand);
 	if (ret)
 		return;
@@ -1181,6 +1182,7 @@ static int spinand_init(struct spinand_device *spinand)
 	if (!spinand->scratchbuf)
 		return -ENOMEM;
 
+	spinand->protocol = SPINAND_1S_1S_1S;
 	ret = spinand_detect(spinand);
 	if (ret)
 		goto err_free_bufs;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 69e06e741717..77927afcea0f 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -194,6 +194,18 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT_DTR(len, buf, 8))
 
+/**
+ * enum spinand_protocol - List of SPI protocols to denote the op protocol and
+ *			   SPI NAND flash IO modes.
+ */
+enum spinand_protocol {
+	SPINAND_1S_1S_1S,
+	SPINAND_2S_2S_2S,
+	SPINAND_4S_4S_4S,
+	SPINAND_8S_8S_8S,
+	SPINAND_8D_8D_8D,
+};
+
 /**
  * Standard SPI NAND flash commands
  */
@@ -461,6 +473,8 @@ struct spinand_dirmap {
  *		   this die. Only required if your chip exposes several dies
  * @cur_target: currently selected target/die
  * @eccinfo: on-die ECC information
+ * @protocol: SPI IO protocol in operation. Update on successful transition into
+ *	      a different SPI IO protocol.
  * @cfg_cache: config register cache. One entry per die
  * @databuf: bounce buffer for data
  * @oobbuf: bounce buffer for OOB data
@@ -492,6 +506,8 @@ struct spinand_device {
 
 	struct spinand_ecc_info eccinfo;
 
+	enum spinand_protocol protocol;
+
 	u8 *cfg_cache;
 	u8 *databuf;
 	u8 *oobbuf;
-- 
2.25.1

