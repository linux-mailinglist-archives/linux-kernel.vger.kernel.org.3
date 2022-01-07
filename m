Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F44486E75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343933AbiAGAO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbiAGAON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FAC061201;
        Thu,  6 Jan 2022 16:14:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id pj2so2581208pjb.2;
        Thu, 06 Jan 2022 16:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZ1NPwHOAF/AQNPHH9LVwlD3kjQZoYIgqFFS0X9ueYI=;
        b=d4w2xuMQxsimP6ZWfRwFADLchGLCil9m6/2y72n/6jwg/i93edfSAhLz/XOiGZ0ITT
         kUBT+wgtw/cgzbVLoJwT8i0z9/wfg4gEUmWkJ6xLG/qNmB+k69lKuShMrcAVJ70Ceena
         0+KF6p8+KOp2ms4ymvk6g4e03O29O9Y9jIEcDRc9l4LGO7i5gzebNgxH0hLmGnCWSBFO
         813va3sPHwS+AQZrmYli4MFV6mjYzyZnkYtIpMquwvNiYFCMcXjLky8cEfqDX3fuTPYI
         sZQLMqFiCVUJlTAJ5jNMI6ZwlLqSsatNnGdPx9Ml6A+K26OQiMdIgG4yFVkuoFS45M+4
         iOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZ1NPwHOAF/AQNPHH9LVwlD3kjQZoYIgqFFS0X9ueYI=;
        b=Thit+vflIln/MCBvihWUzzQtG0GZWR9Y30EY7p1mT7CxSjJmgP6ltCIW+u9AHkCRNs
         Jor7UYp9n3fciJiPh5PRn+ONGozIRMiXX1fQNhlcfWYbppBfRM71tyicwQnbsF1MLPey
         xWAZyfxwLhEGqcWVemqMNv2SlhvWkqaaq7fggNGz3cNlGX8SkVZ6xEuS5wDg4dnz2hKq
         gB39Ad40s+KBLrKcCg2e0/i30vxTUIPHubZTPOJ1fsMKVdRONkQqNzngD/sha7eNZa8d
         eiSE+MUZIHQbtaIBhqP6pqO+fY4hPgHyRJwQUxW4z7EkD9nSi4Wg4n7/RSUK8fCmsUn/
         F3Ag==
X-Gm-Message-State: AOAM531I6TRUtKRndsITccVtrpSwLtZ9y4n0YQw1HI/XRJEkvG8D9Uze
        kk0kQXGwBOf1aptvqbUn8ic=
X-Google-Smtp-Source: ABdhPJwue8v+LN+U8M9o8MkyhuYoXoEWQeOFfFI5VjZL96XjoT+E9wJ41U6LI3NSqXsIUreVbp4Txw==
X-Received: by 2002:a17:902:6bc1:b0:149:7c61:ad31 with SMTP id m1-20020a1709026bc100b001497c61ad31mr49812575plt.93.1641514451427;
        Thu, 06 Jan 2022 16:14:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:11 -0800 (PST)
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
Subject: [PATCH v2 6/9] mtd: rawnand: brcmnand: Add platform data structure for BCMA
Date:   Thu,  6 Jan 2022 16:13:25 -0800
Message-Id: <20220107001328.2233896-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the BCMA's chipcommon nand flash driver to detect which
chip-select is used and pass that information via platform data to the
brcmnand driver. Make sure that the brcmnand platform data structure is
always at the beginning of the platform data of the "nflash" device
created by BCMA to allow brcmnand to safely de-reference it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS                                 |  1 +
 drivers/bcma/driver_chipcommon_nflash.c     | 20 +++++++++++++++++++-
 include/linux/bcma/bcma_driver_chipcommon.h |  5 +++++
 include/linux/platform_data/brcmnand.h      | 12 ++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/brcmnand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dd36acc87ce6..404f3eb8ff18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3966,6 +3966,7 @@ L:	linux-mtd@lists.infradead.org
 L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	drivers/mtd/nand/raw/brcmnand/
+F:	include/linux/platform_data/brcmnand.h
 
 BROADCOM STB PCIE DRIVER
 M:	Jim Quinlan <jim2101024@gmail.com>
diff --git a/drivers/bcma/driver_chipcommon_nflash.c b/drivers/bcma/driver_chipcommon_nflash.c
index d4f699aef8c4..a1a814750b4a 100644
--- a/drivers/bcma/driver_chipcommon_nflash.c
+++ b/drivers/bcma/driver_chipcommon_nflash.c
@@ -7,18 +7,28 @@
 
 #include "bcma_private.h"
 
+#include <linux/bitops.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/brcmnand.h>
 #include <linux/bcma/bcma.h>
 
+/* Alternate NAND controller driver name in order to allow both bcm47xxnflash
+ * and bcma_brcmnand to be built into the same kernel image.
+ */
+static const char *bcma_nflash_alt_name = "bcma_brcmnand";
+
 struct platform_device bcma_nflash_dev = {
 	.name		= "bcma_nflash",
 	.num_resources	= 0,
 };
 
+static const char *probes[] = { "bcm47xxpart", NULL };
+
 /* Initialize NAND flash access */
 int bcma_nflash_init(struct bcma_drv_cc *cc)
 {
 	struct bcma_bus *bus = cc->core->bus;
+	u32 reg;
 
 	if (bus->chipinfo.id != BCMA_CHIP_ID_BCM4706 &&
 	    cc->core->id.rev != 38) {
@@ -33,8 +43,16 @@ int bcma_nflash_init(struct bcma_drv_cc *cc)
 
 	cc->nflash.present = true;
 	if (cc->core->id.rev == 38 &&
-	    (cc->status & BCMA_CC_CHIPST_5357_NAND_BOOT))
+	    (cc->status & BCMA_CC_CHIPST_5357_NAND_BOOT)) {
 		cc->nflash.boot = true;
+		/* Determine the chip select that is being used */
+		reg = bcma_cc_read32(cc, BCMA_CC_NAND_CS_NAND_SELECT) & 0xff;
+		cc->nflash.brcmnand_info.chip_select = ffs(reg) - 1;
+		cc->nflash.brcmnand_info.part_probe_types = probes;
+		cc->nflash.brcmnand_info.ecc_stepsize = 512;
+		cc->nflash.brcmnand_info.ecc_strength = 1;
+		bcma_nflash_dev.name = bcma_nflash_alt_name;
+	}
 
 	/* Prepare platform device, but don't register it yet. It's too early,
 	 * malloc (required by device_private_init) is not available yet. */
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index d35b9206096d..e3314f746bfa 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -3,6 +3,7 @@
 #define LINUX_BCMA_DRIVER_CC_H_
 
 #include <linux/platform_device.h>
+#include <linux/platform_data/brcmnand.h>
 #include <linux/gpio.h>
 
 /** ChipCommon core registers. **/
@@ -599,6 +600,10 @@ struct bcma_sflash {
 
 #ifdef CONFIG_BCMA_NFLASH
 struct bcma_nflash {
+	/* Must be the fist member for the brcmnand driver to
+	 * de-reference that structure.
+	 */
+	struct brcmnand_platform_data brcmnand_info;
 	bool present;
 	bool boot;		/* This is the flash the SoC boots from */
 };
diff --git a/include/linux/platform_data/brcmnand.h b/include/linux/platform_data/brcmnand.h
new file mode 100644
index 000000000000..8b8777985dce
--- /dev/null
+++ b/include/linux/platform_data/brcmnand.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef BRCMNAND_PLAT_DATA_H
+#define BRCMNAND_PLAT_DATA_H
+
+struct brcmnand_platform_data {
+	int	chip_select;
+	const char * const *part_probe_types;
+	unsigned int ecc_stepsize;
+	unsigned int ecc_strength;
+};
+
+#endif /* BRCMNAND_PLAT_DATA_H */
-- 
2.25.1

