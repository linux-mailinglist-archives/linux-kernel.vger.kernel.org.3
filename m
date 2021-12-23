Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504F147DBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbhLWAWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbhLWAWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:42 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E74C061747;
        Wed, 22 Dec 2021 16:22:42 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b22so3720894pfb.5;
        Wed, 22 Dec 2021 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrwpWLxiWx6mZCJiyoZtcTWmNjs4loZOAYfkmQ38gh0=;
        b=B5ylfhV86Rh/vvH/mHcn/Ip2WU2wGp+wP2S70p2/h9wG9kF5AtkOfIc/o12mAJyBEa
         ditS8hsoUaFat25XFpsKemcKqZGs6ibOjam+Gi79vx9oec1ghP2AGwDIO8PUT5odGuo6
         Vw4M3zAySgvCIaqfvVQnp6qnhCi67jVY/vF61g8pScetURs0GF7OM8IAMPEQjzbfH3oc
         lRjYUMOwO1kEWp+roPQx2QdCSJBZKS/H7tf8Oh8x1SQQoArAU+SeoaBjhcQwhq5zz2KD
         Zq17T3kkoHy1Ww3H0kMLS1hKKPnubuuja3aKm5baG8hRxG1ri1MQNZxWuYMhGBLuWCOF
         JRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrwpWLxiWx6mZCJiyoZtcTWmNjs4loZOAYfkmQ38gh0=;
        b=uqFqEIF9Id//Y6BsThX7ZtmW6cA4Yy/+CrqQmWWlS4T4yzE/6Th3Dc9EQFAKbDVxES
         eGALG/3+fzdGg6EKAqjA2EWpcoOo8DhP3vPthdsor9yUHEgXxV2jJtuBi3IOkqj3x8sV
         6x60+fh616qBeqV/DHgHU8s+W6dXyy4akGfH2Gf8zdxMV1Uebcq3hBoQFOI/RoMAPKqL
         TPz/3FLhfQUzNa5vBtlBFcIXw7s0UK39KF4UoyvAuI74Q6+GXogpX6LxM2iU7+L/EVEy
         isx01Ezgst7egEGBhUn0eRACo/X84Bzaw+UL4aljEjTCIg5d39LGIdWIuUB6UwnjAM8q
         /4vQ==
X-Gm-Message-State: AOAM533ZtYUd9d8ybkTSu+RZXFvEm//9KUNxa0UtCoba0FouQblGf2hr
        eBhCDHqol9CDcmjF7R0FHb1upeF/5xQ=
X-Google-Smtp-Source: ABdhPJyOPmJ6pH73MHEOBhkp5drVGU20fMMShEKfzZx4cNcOOCFlptto5aYiO766wpa+qFlf4BkCDw==
X-Received: by 2002:a63:416:: with SMTP id 22mr89208pge.133.1640218962033;
        Wed, 22 Dec 2021 16:22:42 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:41 -0800 (PST)
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
Subject: [PATCH 6/9] mtd: rawnand: brcmnand: Add platform data structure for BCMA
Date:   Wed, 22 Dec 2021 16:22:22 -0800
Message-Id: <20211223002225.3738385-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
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
 drivers/bcma/driver_chipcommon_nflash.c     | 17 ++++++++++++++++-
 include/linux/bcma/bcma_driver_chipcommon.h |  5 +++++
 include/linux/platform_data/brcmnand.h      | 12 ++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/brcmnand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c1260c..37062172083c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3965,6 +3965,7 @@ L:	linux-mtd@lists.infradead.org
 L:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
 F:	drivers/mtd/nand/raw/brcmnand/
+F:	include/linux/platform_data/brcmnand.h
 
 BROADCOM STB PCIE DRIVER
 M:	Jim Quinlan <jim2101024@gmail.com>
diff --git a/drivers/bcma/driver_chipcommon_nflash.c b/drivers/bcma/driver_chipcommon_nflash.c
index d4f699aef8c4..9457f4b7ea9d 100644
--- a/drivers/bcma/driver_chipcommon_nflash.c
+++ b/drivers/bcma/driver_chipcommon_nflash.c
@@ -7,18 +7,25 @@
 
 #include "bcma_private.h"
 
+#include <linux/bitops.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/brcmnand.h>
 #include <linux/bcma/bcma.h>
 
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
@@ -33,8 +40,16 @@ int bcma_nflash_init(struct bcma_drv_cc *cc)
 
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

