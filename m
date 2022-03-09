Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0E4D30E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiCIOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiCIOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:18:27 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341B1637EE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646835442; x=1678371442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eA5JNvIl723INxo1Ek/ymL6Ifubo4QpgyLcZrgcY5wg=;
  b=VKvjCnOhIG8Lr9eqcQoNvrh0T8Me6sT4m8ulJuXF0nxJ/WA45dZi7cwA
   nu7flfHJcN2d603V0NgP2Dx3siPPvkTxM/+X7oQpPB9AXFpSlokeh0e/U
   oj1KO2q0S+lVW798U3YN5MzSHFRp58sJqrj2Qwc8Be9rBeHPmUPS3wIDd
   AHIPL5Cf1uymqhFAw5oJ+sWLywYE8pOBcmiFO7DKzHEJBqL7oX/nEi8aQ
   jzoA91pzZGWlMicGD8agfwDFuKN1ezOUBOrzJGAxX7ICDbMTqJUrGFHNY
   3GdxdVy++gQ0PksTfNtJ2OeUgt3SVJvBJhQBJKMfvvf9wDFHkHRQsT1EG
   A==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="148620137"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 07:17:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 07:17:20 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 07:17:18 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 5/5] mtd: spi-nor: sfdp: Keep SFDP definitions private
Date:   Wed, 9 Mar 2022 16:17:02 +0200
Message-ID: <20220309141702.173879-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309141702.173879-1-tudor.ambarus@microchip.com>
References: <20220309141702.173879-1-tudor.ambarus@microchip.com>
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

Keep the SFDP definitions private and expose just the definitions that are
required by the core and manufacturer drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/sfdp.c | 52 +++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h | 53 --------------------------------------
 2 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 01e35354db3e..f5432cbd3daf 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -494,6 +494,50 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
 	return spi_nor_write_disable(nor);
 }
 
+/* 11th DWORD. */
+#define BFPT_DWORD11_PAGE_SIZE_SHIFT		4
+#define BFPT_DWORD11_PAGE_SIZE_MASK		GENMASK(7, 4)
+
+/* 15th DWORD. */
+/*
+ * (from JESD216 rev B)
+ * Quad Enable Requirements (QER):
+ * - 000b: Device does not have a QE bit. Device detects 1-1-4 and 1-4-4
+ *         reads based on instruction. DQ3/HOLD# functions are hold during
+ *         instruction phase.
+ * - 001b: QE is bit 1 of status register 2. It is set via Write Status with
+ *         two data bytes where bit 1 of the second byte is one.
+ *         [...]
+ *         Writing only one byte to the status register has the side-effect of
+ *         clearing status register 2, including the QE bit. The 100b code is
+ *         used if writing one byte to the status register does not modify
+ *         status register 2.
+ * - 010b: QE is bit 6 of status register 1. It is set via Write Status with
+ *         one data byte where bit 6 is one.
+ *         [...]
+ * - 011b: QE is bit 7 of status register 2. It is set via Write status
+ *         register 2 instruction 3Eh with one data byte where bit 7 is one.
+ *         [...]
+ *         The status register 2 is read using instruction 3Fh.
+ * - 100b: QE is bit 1 of status register 2. It is set via Write Status with
+ *         two data bytes where bit 1 of the second byte is one.
+ *         [...]
+ *         In contrast to the 001b code, writing one byte to the status
+ *         register does not modify status register 2.
+ * - 101b: QE is bit 1 of status register 2. Status register 1 is read using
+ *         Read Status instruction 05h. Status register2 is read using
+ *         instruction 35h. QE is set via Write Status instruction 01h with
+ *         two data bytes where bit 1 of the second byte is one.
+ *         [...]
+ */
+#define BFPT_DWORD15_QER_MASK			GENMASK(22, 20)
+#define BFPT_DWORD15_QER_NONE			(0x0UL << 20) /* Micron */
+#define BFPT_DWORD15_QER_SR2_BIT1_BUGGY		(0x1UL << 20)
+#define BFPT_DWORD15_QER_SR1_BIT6		(0x2UL << 20) /* Macronix */
+#define BFPT_DWORD15_QER_SR2_BIT7		(0x3UL << 20)
+#define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
+#define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
+
 #define BFPT_DWORD16_EN4B_MASK			GENMASK(31, 24)
 #define BFPT_DWORD16_EN4B_ALWAYS_4B		BIT(30)
 #define BFPT_DWORD16_EN4B_4B_OPCODES		BIT(29)
@@ -528,6 +572,14 @@ int spi_nor_set_4byte_addr_mode_wren_en4b_ex4b(struct spi_nor *nor, bool enable)
 #define BFPT_DWORD16_4B_ADDR_MODE_EN4B_EX4B		\
 	(BFPT_DWORD16_EN4B_EN4B | BFPT_DWORD16_EX4B_EX4B)
 
+#define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
+
+#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
+#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
+#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
+#define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
+#define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
+
 /**
  * spi_nor_parse_bfpt() - read and parse the Basic Flash Parameter Table.
  * @nor:		pointer to a 'struct spi_nor'
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index da2d7ec2e0aa..fd7e3c935960 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -45,59 +45,6 @@ struct sfdp_bfpt {
 #define BFPT_DWORD5_FAST_READ_2_2_2		BIT(0)
 #define BFPT_DWORD5_FAST_READ_4_4_4		BIT(4)
 
-/* 11th DWORD. */
-#define BFPT_DWORD11_PAGE_SIZE_SHIFT		4
-#define BFPT_DWORD11_PAGE_SIZE_MASK		GENMASK(7, 4)
-
-/* 15th DWORD. */
-
-/*
- * (from JESD216 rev B)
- * Quad Enable Requirements (QER):
- * - 000b: Device does not have a QE bit. Device detects 1-1-4 and 1-4-4
- *         reads based on instruction. DQ3/HOLD# functions are hold during
- *         instruction phase.
- * - 001b: QE is bit 1 of status register 2. It is set via Write Status with
- *         two data bytes where bit 1 of the second byte is one.
- *         [...]
- *         Writing only one byte to the status register has the side-effect of
- *         clearing status register 2, including the QE bit. The 100b code is
- *         used if writing one byte to the status register does not modify
- *         status register 2.
- * - 010b: QE is bit 6 of status register 1. It is set via Write Status with
- *         one data byte where bit 6 is one.
- *         [...]
- * - 011b: QE is bit 7 of status register 2. It is set via Write status
- *         register 2 instruction 3Eh with one data byte where bit 7 is one.
- *         [...]
- *         The status register 2 is read using instruction 3Fh.
- * - 100b: QE is bit 1 of status register 2. It is set via Write Status with
- *         two data bytes where bit 1 of the second byte is one.
- *         [...]
- *         In contrast to the 001b code, writing one byte to the status
- *         register does not modify status register 2.
- * - 101b: QE is bit 1 of status register 2. Status register 1 is read using
- *         Read Status instruction 05h. Status register2 is read using
- *         instruction 35h. QE is set via Write Status instruction 01h with
- *         two data bytes where bit 1 of the second byte is one.
- *         [...]
- */
-#define BFPT_DWORD15_QER_MASK			GENMASK(22, 20)
-#define BFPT_DWORD15_QER_NONE			(0x0UL << 20) /* Micron */
-#define BFPT_DWORD15_QER_SR2_BIT1_BUGGY		(0x1UL << 20)
-#define BFPT_DWORD15_QER_SR1_BIT6		(0x2UL << 20) /* Macronix */
-#define BFPT_DWORD15_QER_SR2_BIT7		(0x3UL << 20)
-#define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
-#define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
-
-#define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
-
-#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
-#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
-#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
-#define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
-#define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
-
 struct sfdp_parameter_header {
 	u8		id_lsb;
 	u8		minor;
-- 
2.25.1

