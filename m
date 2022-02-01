Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0649F4A542C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiBAAfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiBAAfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:35:40 -0500
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jan 2022 16:35:40 PST
Received: from mail.crtified.me (mail.crtified.me [IPv6:2a01:4f8:c0c:4b18::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91AC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:35:40 -0800 (PST)
From:   Carl Richard Theodor Schneider <dev.linux@crtified.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crtified.me; s=mail;
        t=1643675181; bh=JeNXq18UbQzuvreRzNfiLaQ6jV89JRgSNEv4N1KLBKQ=;
        h=From:To:Cc:Subject:Date;
        b=QTDjFfgZ1VB3Cwl9rvkzGrkr2/fh2ru+1oP6mEX6olQsfVSugY1H+TmfWO5mduBZj
         OJEG3T+k6FPLcOeTXcM4nxceJiwGoTsbtYi8RcVKXcxTVahUTH3ZASS4CG3rW2EuqW
         tVZe4RMAHz26HvGFp6rzRxQ2/JmZj6xDsr4LfuNk=
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     microcaicai@gmail.com,
        Carl Richard Theodor Schneider <dev.linux@crtified.me>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: Init xtx flash xt25f32b, xt25f128b
Date:   Tue,  1 Feb 2022 01:25:34 +0100
Message-Id: <20220201002535.2186484-1-dev.linux@crtified.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the JEDEC identifiers for xt25f32b and xt25f128b.
Based on the referenced previous patch from microcai.

Only xt25f32b was verified in hardware (On both Radxa RockPi 4A and 4C),
but the ID of the xt25f128b can also be found in u-boot patches from
Armbian.

Link: https://lore.kernel.org/lkml/CAMgqO2y9MYDj6antOaWLBRKU8vGEwqCB-Y1TkXTSWsmsed+W6A@mail.gmail.com/
Link: https://datasheet.lcsc.com/szlcsc/2005251035_XTX-XT25F32BSOIGU-S_C558851.pdf
Link: https://datasheet.lcsc.com/szlcsc/2005251034_XTX-XT25F128BSSIGT_C558844.pdf
Link: https://github.com/armbian/build/blob/master/patch/u-boot/u-boot-rockchip64/general-add-xtx-spi-nor-chips.patch

Signed-off-by: Carl Richard Theodor Schneider <dev.linux@crtified.me>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  1 +
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/xtx.c    | 25 +++++++++++++++++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/xtx.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 6b904e439372..e344077e3054 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -17,6 +17,7 @@ spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
 spi-nor-objs			+= xmc.o
+spi-nor-objs			+= xtx.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 04ea180118e3..44017ab54726 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1846,6 +1846,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_winbond,
 	&spi_nor_xilinx,
 	&spi_nor_xmc,
+	&spi_nor_xtx,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2afb610853a9..8adac5da6851 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -536,6 +536,7 @@ extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
 extern const struct spi_nor_manufacturer spi_nor_xmc;
+extern const struct spi_nor_manufacturer spi_nor_xtx;
 
 extern const struct attribute_group *spi_nor_sysfs_groups[];
 
diff --git a/drivers/mtd/spi-nor/xtx.c b/drivers/mtd/spi-nor/xtx.c
new file mode 100644
index 000000000000..2c9028e5d719
--- /dev/null
+++ b/drivers/mtd/spi-nor/xtx.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005, Intec Automation Inc.
+ * Copyright (C) 2014, Freescale Semiconductor, Inc.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info xtx_parts[] = {
+	/* XTX (Shenzhen Xin Tian Xia Tech) */
+	{ "xt25f32b", INFO(0x0b4016, 0, 64 * 1024, 64)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			SPI_NOR_QUAD_READ) },
+	{ "xt25f128b", INFO(0x0b4018, 0, 64 * 1024, 256)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			SPI_NOR_QUAD_READ) },
+};
+
+const struct spi_nor_manufacturer spi_nor_xtx = {
+	.name = "xtx",
+	.parts = xtx_parts,
+	.nparts = ARRAY_SIZE(xtx_parts),
+};
-- 
2.34.1

