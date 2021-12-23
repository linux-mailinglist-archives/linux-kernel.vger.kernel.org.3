Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC247DBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbhLWAW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345560AbhLWAWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:48 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA888C061748;
        Wed, 22 Dec 2021 16:22:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n16so3055195plc.2;
        Wed, 22 Dec 2021 16:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/4Rn7jIc8ftTpjbra5Wz6AYzDCXpGuGFG/j7apzAik=;
        b=k6QCX/Ymv3gTQg74d/r3VQ8KxAJut/r/mMAyglcbQoosZaQOtfDT6jibnZznuXisXx
         zjhLP4XTp7TkPoQhHJtwYy77zh23RYLDF47tTkwaOzxIl1D1iGvQO4ECpT92sMt46pNR
         DoZ2q6nZs00ALvhjrsCJewcG86zxAZx/lwXJZrnIjgJcGhi3rx+CS68tIi7ucDmIHBNd
         HM70noNpm5QVQQ9fv7YOPqQdQSPKgEmze6j44hRk4yfOsL2cbO5sCPA+6ltRPxdJEULT
         /mMAo+u1iDHTZzTOohV5p4vWg5j93ip36gIwOLTidJTzPOJymoQJz6R/sOO2LeWihtYx
         34Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/4Rn7jIc8ftTpjbra5Wz6AYzDCXpGuGFG/j7apzAik=;
        b=ElyuoyD6W1erk+kw/jgx9oN+Iy4ojcfplFE1jWVZuSfHVSXvksMmF66wF5QCenbUZJ
         RGrrK/b5H8WHN3xAkC4GCKE3kD+E7hmEZsmtNz3pRZVF9PN9TifPS5tMisAOXmkltVCd
         76Sc3Gq4gbFHvefY0OPXqdYXgFT2444DfCgpxD0iRZ09AnBCkbT2uNGeY8QIc2QO0afT
         vSc2ojNB8KAk9wAeISvhhV3ESgtnehZzDp7gA1XEARTotDT6AeGy2RBAAYBiynxXOmUt
         VjuvohhUMFwyh7iBpv3zDaoNLKTfjfYWMMExxpONc4q2oQP+AMAHH3CiKwf9f8rQ17Jj
         /1/g==
X-Gm-Message-State: AOAM533GHIxkmwhk+SXwneqxmdPzP9wRXlh2zjRzYBCvtnq//Y5gXT4d
        IrY580CnoNqjDDnMoguQYeo=
X-Google-Smtp-Source: ABdhPJyzDrnhUwQuP4xuG3Evu4ES9qduMUAMVa3xWuELq7+dUMTbs70knDE5wWTvDMQDdRDuUjq/aw==
X-Received: by 2002:a17:90b:314b:: with SMTP id ip11mr261023pjb.133.1640218967349;
        Wed, 22 Dec 2021 16:22:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:46 -0800 (PST)
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
Subject: [PATCH 9/9] mtd: rawnand: brcmnand: Add BCMA shim
Date:   Wed, 22 Dec 2021 16:22:25 -0800
Message-Id: <20211223002225.3738385-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
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
 drivers/mtd/nand/raw/Kconfig              |  11 ++
 drivers/mtd/nand/raw/brcmnand/Makefile    |   2 +
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c | 131 ++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/brcmnand/bcma_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 0a45d3c6c15b..f643e02e5559 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -208,6 +208,17 @@ config MTD_NAND_BRCMNAND
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
index 000000000000..e3be9ecf0761
--- /dev/null
+++ b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2021 Broadcom
+ */
+#include <linux/bcma/bcma.h>
+#include <linux/bcma/bcma_driver_chipcommon.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
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
+static u32 brcmnand_bcma_read_reg(struct brcmnand_soc *soc, u32 offset)
+{
+	struct brcmnand_bcma_soc *sc;
+	u32 val;
+
+	sc = container_of(soc, struct brcmnand_bcma_soc, soc);
+
+	/* Offset into the NAND block and deal with the flash cache separately */
+	if (offset == ~0)
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
+	struct brcmnand_bcma_soc *sc;
+
+	sc = container_of(soc, struct brcmnand_bcma_soc, soc);
+
+	/* Offset into the NAND block */
+	if (offset == ~0)
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
+	struct brcmnand_bcma_soc *sc;
+
+	sc = container_of(soc, struct brcmnand_bcma_soc, soc);
+
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
+MODULE_AUTHOR("Braodcom");
+MODULE_DESCRIPTION("NAND driver for BCMA chips");
-- 
2.25.1

