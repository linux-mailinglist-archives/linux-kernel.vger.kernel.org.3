Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D3486E77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbiAGAOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbiAGAOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735DC061212;
        Thu,  6 Jan 2022 16:14:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso8810704pjm.4;
        Thu, 06 Jan 2022 16:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JfEaUNg0Xt4oVlLObtxcOjbJGRKPvqxT7EiLG9OykY=;
        b=lR6tnw5zs/2ApxbtnTHbaOWvWG0yuYFbiR0iC6+8xo/HeIXnEROqYLmIxxBOXLlvG6
         WGuEF6QRb6GJVjUnyIdXVYgfbX5x5rrUB2qZje+jzY1/modKLbYwHLKdYN0H7ZI85zJ/
         NNhVVu7PAWbhdPQAwhw1V0VIYMGurfQ3aeYurYZZkcwjMKVpu2yFMyCmjTUy8smHyryO
         KdREHzxgtYmGxSazCZ0z1gPkKIoEcZO464X9wvF6Hb06az25d+uI7nZ9+AN1khL+tiDH
         lyZZKbrTpTw2zXrkXXOHV2INMJYQm4Ct0U4TuJycDYaIFw56dtoN3I8ve8X8iXiPjorD
         TdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JfEaUNg0Xt4oVlLObtxcOjbJGRKPvqxT7EiLG9OykY=;
        b=EuW8LK1TijFpl9kMFbD0PukdcNUsJHRRvDbt1DdczW9rA16Ue7zElcadZ+GRJCC0IP
         DWcj7h0cTg+zZpmtqJk2nHBEgoBP8UW7fNuYcgotNnvpf8xNzXYzJcSpv7BhQ9jZJ/IE
         nZYH8rF2V4qPmGvje4BmVpOGG6Hq2osfgoFBmSk7WhRkefRT0X3ZNsuSUF720W68nBA4
         oBix/LFlF8xV27rSt7DbL3dgzq5BZexykbYlxIvzbGD495e/dxm1EiEKrszmVSYYOIpp
         6aJU/Jzw6XlfS87c/pywg1oExyQkF64pW5472UrRlshc2rt3ujVNY1KOBSy9FJ9fPiU2
         2tlA==
X-Gm-Message-State: AOAM531lE58fGn4w+iWwAtfcQhOjSP8VJQbO73NSOMg1JGqFs793Yfhh
        +GRGbOiZaP55XZ8pJmjKPTY=
X-Google-Smtp-Source: ABdhPJxOhtba/MGe2W2rsdY2/aX2nqLFrXr9vWtfLZ8RKbOT8mCYdcfA9WnOng3cBfE+73KZBdv9vA==
X-Received: by 2002:a17:902:8693:b0:148:a2e7:fb5a with SMTP id g19-20020a170902869300b00148a2e7fb5amr61224878plo.155.1641514456544;
        Thu, 06 Jan 2022 16:14:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:BROADCOM SPECIFIC AMBA DRIVER
        (BCMA)),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER)
Subject: [PATCH v2 9/9] mtd: rawnand: brcmnand: Add BCMA shim
Date:   Thu,  6 Jan 2022 16:13:28 -0800
Message-Id: <20220107001328.2233896-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a BCMA shim to allow us to register the brcmnand driver using the
BCMA bus which provides indirect memory mapped access to SoC registers.

There are a number of registers that need to be byte swapped because
they are natively big endian, coming directly from the NAND chip, and
there is no bus interface unlike the iProc or STB platforms that
performs the byte swapping for us.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/Kconfig              |  13 +++
 drivers/mtd/nand/raw/brcmnand/Makefile    |   2 +
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c | 132 ++++++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c  |   4 +
 4 files changed, 151 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 0a45d3c6c15b..7f385ac6e443 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -208,6 +208,19 @@ config MTD_NAND_BRCMNAND
 	  originally designed for Set-Top Box but is used on various BCM7xxx,
 	  BCM3xxx, BCM63xxx, iProc/Cygnus and more.
 
+if MTD_NAND_BRCMNAND
+
+config MTD_NAND_BRCMNAND_BCMA
+	tristate "Broadcom BCMA NAND controller"
+	depends on BCMA_NFLASH
+	depends on BCMA
+	help
+	  Enables the BRCMNAND controller over BCMA on BCM47186/BCM5358 SoCs.
+	  The glue driver will take care of performing the low-level I/O
+	  operations to interface the BRCMNAND controller over the BCMA bus.
+
+endif # MTD_NAND_BRCMNAND
+
 config MTD_NAND_BCM47XXNFLASH
 	tristate "BCM4706 BCMA NAND controller"
 	depends on BCMA_NFLASH
diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/raw/brcmnand/Makefile
index 195b845e48b8..16dc7254200e 100644
--- a/drivers/mtd/nand/raw/brcmnand/Makefile
+++ b/drivers/mtd/nand/raw/brcmnand/Makefile
@@ -6,3 +6,5 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= bcm63138_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= bcm6368_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmstb_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand.o
+
+obj-$(CONFIG_MTD_NAND_BRCMNAND_BCMA)	+= bcma_nand.o
diff --git a/drivers/mtd/nand/raw/brcmnand/bcma_nand.c b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
new file mode 100644
index 000000000000..d7c62988c452
--- /dev/null
+++ b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2021 Broadcom
+ */
+#include <linux/bcma/bcma.h>
+#include <linux/bcma/bcma_driver_chipcommon.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "brcmnand.h"
+
+struct brcmnand_bcma_soc {
+	struct brcmnand_soc soc;
+	struct bcma_drv_cc *cc;
+};
+
+static inline bool brcmnand_bcma_needs_swapping(u32 offset)
+{
+	switch (offset) {
+	case BCMA_CC_NAND_SPARE_RD0:
+	case BCMA_CC_NAND_SPARE_RD4:
+	case BCMA_CC_NAND_SPARE_RD8:
+	case BCMA_CC_NAND_SPARE_RD12:
+	case BCMA_CC_NAND_SPARE_WR0:
+	case BCMA_CC_NAND_SPARE_WR4:
+	case BCMA_CC_NAND_SPARE_WR8:
+	case BCMA_CC_NAND_SPARE_WR12:
+	case BCMA_CC_NAND_DEVID:
+	case BCMA_CC_NAND_DEVID_X:
+	case BCMA_CC_NAND_SPARE_RD16:
+	case BCMA_CC_NAND_SPARE_RD20:
+	case BCMA_CC_NAND_SPARE_RD24:
+	case BCMA_CC_NAND_SPARE_RD28:
+		return true;
+	}
+
+	return false;
+}
+
+static inline struct brcmnand_bcma_soc *to_bcma_soc(struct brcmnand_soc *soc)
+{
+	return container_of(soc, struct brcmnand_bcma_soc, soc);
+}
+
+static u32 brcmnand_bcma_read_reg(struct brcmnand_soc *soc, u32 offset)
+{
+	struct brcmnand_bcma_soc *sc = to_bcma_soc(soc);
+	u32 val;
+
+	/* Offset into the NAND block and deal with the flash cache separately */
+	if (offset == BRCMNAND_NON_MMIO_FC_ADDR)
+		offset = BCMA_CC_NAND_CACHE_DATA;
+	else
+		offset += BCMA_CC_NAND_REVISION;
+
+	val = bcma_cc_read32(sc->cc, offset);
+
+	/* Swap if necessary */
+	if (brcmnand_bcma_needs_swapping(offset))
+		val = be32_to_cpu(val);
+	return val;
+}
+
+static void brcmnand_bcma_write_reg(struct brcmnand_soc *soc, u32 val,
+				    u32 offset)
+{
+	struct brcmnand_bcma_soc *sc = to_bcma_soc(soc);
+
+	/* Offset into the NAND block */
+	if (offset == BRCMNAND_NON_MMIO_FC_ADDR)
+		offset = BCMA_CC_NAND_CACHE_DATA;
+	else
+		offset += BCMA_CC_NAND_REVISION;
+
+	/* Swap if necessary */
+	if (brcmnand_bcma_needs_swapping(offset))
+		val = cpu_to_be32(val);
+
+	bcma_cc_write32(sc->cc, offset, val);
+}
+
+static struct brcmnand_io_ops brcmnand_bcma_io_ops = {
+	.read_reg	= brcmnand_bcma_read_reg,
+	.write_reg	= brcmnand_bcma_write_reg,
+};
+
+static void brcmnand_bcma_prepare_data_bus(struct brcmnand_soc *soc, bool prepare,
+					   bool is_param)
+{
+	struct brcmnand_bcma_soc *sc = to_bcma_soc(soc);
+
+	/* Reset the cache address to ensure we are already accessing the
+	 * beginning of a sub-page.
+	 */
+	bcma_cc_write32(sc->cc, BCMA_CC_NAND_CACHE_ADDR, 0);
+}
+
+static int brcmnand_bcma_nand_probe(struct platform_device *pdev)
+{
+	struct bcma_nflash *nflash = dev_get_platdata(&pdev->dev);
+	struct brcmnand_bcma_soc *soc;
+
+	soc = devm_kzalloc(&pdev->dev, sizeof(*soc), GFP_KERNEL);
+	if (!soc)
+		return -ENOMEM;
+
+	soc->cc = container_of(nflash, struct bcma_drv_cc, nflash);
+	soc->soc.prepare_data_bus = brcmnand_bcma_prepare_data_bus;
+	soc->soc.ops = &brcmnand_bcma_io_ops;
+
+	if (soc->cc->core->bus->chipinfo.id == BCMA_CHIP_ID_BCM4706) {
+		dev_err(&pdev->dev, "Use bcm47xxnflash for 4706!\n");
+		return -ENODEV;
+	}
+
+	return brcmnand_probe(pdev, &soc->soc);
+}
+
+static struct platform_driver brcmnand_bcma_nand_driver = {
+	.probe			= brcmnand_bcma_nand_probe,
+	.remove			= brcmnand_remove,
+	.driver = {
+		.name		= "bcma_brcmnand",
+		.pm		= &brcmnand_pm_ops,
+	}
+};
+module_platform_driver(brcmnand_bcma_nand_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("NAND controller driver glue for BCMA chips");
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 4759303ece7c..c412f79b81db 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -598,7 +598,11 @@ enum {
 
 static inline bool brcmnand_non_mmio_ops(struct brcmnand_controller *ctrl)
 {
+#if IS_ENABLED(CONFIG_MTD_NAND_BRCMNAND_BCMA)
 	return static_branch_unlikely(&brcmnand_soc_has_ops_key);
+#else
+	return false;
+#endif
 }
 
 static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)
-- 
2.25.1

