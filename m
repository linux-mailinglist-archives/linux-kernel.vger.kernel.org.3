Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D2C4C8453
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiCAGsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiCAGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:48:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830B50E29
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646117285; x=1677653285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGq98DPhvXiYNuMD69nm/wiwfQmDcTai422+Q4afq7Q=;
  b=IVq3T/6mtDYJb3rJCR02yxO+C55NDRQO+lpYlAswzjKpN0ZMW6SauAau
   CrLNbYGXtP34WfmuVXtSYizI4TfKb3/B6DDpqhytFRoi1kTrwBFomfF/Z
   dYmUVXWd9gTogFDCGYwQ+IIUotPgAzkPWHtOmvf2G8RiZATaJjgfOvXrt
   yFSLAosJZLeBUHbudl32lDdmGLRj+dQXQTjJx8bDSDpgPnFmxax1evtYb
   Oq+jURY3FK+HYS3WylmdyexCVydY/vbGCGcQbd2RL2furdF8Kn9b3DQh0
   mzmGjBB1pNhrbPQdd79lS6blNMZ4kXAlCVPMiTCZqyYOohsIkG7mH6B/c
   g==;
X-IronPort-AV: E=Sophos;i="5.90,145,1643698800"; 
   d="scan'208";a="87343387"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 23:48:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 23:48:03 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 23:48:01 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2] mtd: spi-nor: Move XMC to manufacturer ID collisions driver
Date:   Tue, 1 Mar 2022 08:47:58 +0200
Message-ID: <20220301064758.294943-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <fead645197b0cb6534c04a665938a8d5@walle.cc>
References: <fead645197b0cb6534c04a665938a8d5@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XMC manufacturer ID is defined in bank 10 of JEP106 standard. The XMC
flashes that are currently supported do not define the continuation codes
and will collide with flashes using the same manufacturer IDs,
STMicroelectronics being an example (defined in bank one without
continuation codes). Move XMC to manufacturer ID collisions driver as it
doesn't respect the JEP106 standard and collides with other manufacturers.

Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2:
- drop xmc from makefile
- order flash_info entries in alphabetical order in manuf-id-collisions
driver

 drivers/mtd/spi-nor/Makefile              |  1 -
 drivers/mtd/spi-nor/core.c                |  1 -
 drivers/mtd/spi-nor/core.h                |  1 -
 drivers/mtd/spi-nor/manuf-id-collisions.c |  8 ++++++++
 drivers/mtd/spi-nor/xmc.c                 | 25 -----------------------
 5 files changed, 8 insertions(+), 28 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/xmc.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 48763d10daad..3f2b431f9851 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -17,7 +17,6 @@ spi-nor-objs			+= spansion.o
 spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
-spi-nor-objs			+= xmc.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 80d6ce41122a..e2b388d12c6c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1627,7 +1627,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_sst,
 	&spi_nor_winbond,
 	&spi_nor_xilinx,
-	&spi_nor_xmc,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index f727e632c0ee..db042c40853f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -517,7 +517,6 @@ extern const struct spi_nor_manufacturer spi_nor_spansion;
 extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
-extern const struct spi_nor_manufacturer spi_nor_xmc;
 
 extern const struct attribute_group *spi_nor_sysfs_groups[];
 
diff --git a/drivers/mtd/spi-nor/manuf-id-collisions.c b/drivers/mtd/spi-nor/manuf-id-collisions.c
index 0447e245f4b1..bcb80b779534 100644
--- a/drivers/mtd/spi-nor/manuf-id-collisions.c
+++ b/drivers/mtd/spi-nor/manuf-id-collisions.c
@@ -34,6 +34,14 @@ static const struct flash_info id_collision_parts[] = {
 			      SPI_NOR_QUAD_READ)
 		.fixups = &boya_nor_fixups },
 
+	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
+	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
+	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
+
 	/* XTX (XTX Technology Limited) */
 	{ "xt25f128b", INFO(0x0b4018, 0, 64 * 1024, 256)
 		PARSE_SFDP
diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
deleted file mode 100644
index 051411e86339..000000000000
--- a/drivers/mtd/spi-nor/xmc.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2005, Intec Automation Inc.
- * Copyright (C) 2014, Freescale Semiconductor, Inc.
- */
-
-#include <linux/mtd/spi-nor.h>
-
-#include "core.h"
-
-static const struct flash_info xmc_nor_parts[] = {
-	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
-			      SPI_NOR_QUAD_READ) },
-};
-
-const struct spi_nor_manufacturer spi_nor_xmc = {
-	.name = "xmc",
-	.parts = xmc_nor_parts,
-	.nparts = ARRAY_SIZE(xmc_nor_parts),
-};
-- 
2.25.1

