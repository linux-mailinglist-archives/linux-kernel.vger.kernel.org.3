Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C2486E72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbiAGAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbiAGAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:08 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88EC061245;
        Thu,  6 Jan 2022 16:14:08 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j16so3601887pll.10;
        Thu, 06 Jan 2022 16:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoY5n8/hOXcYzzCekmvhUPi61HYip2TvWuhybrzU3W0=;
        b=fHEPV0IbYaeoGAvRgyHjHhrb3ALA2rKz2ZwOsHdUqg0dVO3o66WNLPzuTuH/F59/y0
         wkjiLOYFk5d87glZGSB43JO5Eo8Z+NxFwbTiLo6RFuBtgR7O+4Ie84nPbCwTpTDkwHYj
         QFWiXCE3upESxoU+ILxtb3fexh/RGt5TWxEBEJCPeMGqnGfuuIxUH3qYF/e2VITDQvjK
         Yxzonyb+JkZKNcV+DTpRaLAY+Nx3bLgJZCfWXlqU2K5rtGs5/dMBvO+Ea/ogcF+rLpvU
         iceOM12AgRt3cx+JzyzOeWqh0t7Mfpnvx4K2K1BQi1s6jSD9OY6WuCShKQisaldi/nop
         dEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoY5n8/hOXcYzzCekmvhUPi61HYip2TvWuhybrzU3W0=;
        b=7EK89cFzXedUpQNEBpHcTAA1bdPMCPqJmhQ8XPQphNMZV3/iOLe52SdhEh8W7vBnT8
         5PmBhZ7ESgbVVIvMr8FFXRGwlBmIWrz0bVk+a384aPpL5ifzvKH3C9zY0WNRAH87ZmBX
         qlZhixcZe2xsLA96BIACzk18n0tXqaccSb7N7H3H/7FYR3Nq6IvpYzMWu0GQtb15+0ic
         jQ5XCTigroqmTTFSML919ZeHo74Mx4BnKAt7xNA4C++gVKjXjR5S5qPXwTCighNmQXWI
         Hmw9yjDP5GV5DunwYWLoEW/iYdczi7qG3HX9nsA5us9x4zTY8YptzsJ+ROqGSKpsDM60
         dm8g==
X-Gm-Message-State: AOAM532um86Z3uJD05+486NvhXfDH3SGARkUk2RHGcQveFiCekzrJnMs
        3DsLmv7A/BfhYP/KK8B1FpQ=
X-Google-Smtp-Source: ABdhPJytawMvWhdWce/qO7j0+OrT8e2Wdw3x91mbzd1pgM9mPVTH3uptZffWDJnhOIwhA52g1o4gQw==
X-Received: by 2002:a17:902:ce85:b0:148:d590:573e with SMTP id f5-20020a170902ce8500b00148d590573emr61616173plg.85.1641514448138;
        Thu, 06 Jan 2022 16:14:08 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:07 -0800 (PST)
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
Subject: [PATCH v2 4/9] mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
Date:   Thu,  6 Jan 2022 16:13:23 -0800
Message-Id: <20220107001328.2233896-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to initialize a given chip select object for use by the
brcmnand driver, move all of the Device Tree specific routines outside
of brcmnand_init_cs() in order to make it usable in a platform data
configuration which will be necessary for supporting BCMA chips.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index fc14765f7d23..eb3f96489f83 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2768,7 +2768,7 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
 	.attach_chip = brcmnand_attach_chip,
 };
 
-static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
+static int brcmnand_init_cs(struct brcmnand_host *host)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct device *dev = ctrl->dev;
@@ -2777,16 +2777,9 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	int ret;
 	u16 cfg_offs;
 
-	ret = of_property_read_u32(dn, "reg", &host->cs);
-	if (ret) {
-		dev_err(dev, "can't get chip-select\n");
-		return -ENXIO;
-	}
-
 	mtd = nand_to_mtd(&host->chip);
 	chip = &host->chip;
 
-	nand_set_flash_node(chip, dn);
 	nand_set_controller_data(chip, host);
 	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "brcmnand.%d",
 				   host->cs);
@@ -3195,7 +3188,16 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 			host->pdev = pdev;
 			host->ctrl = ctrl;
 
-			ret = brcmnand_init_cs(host, child);
+			ret = of_property_read_u32(child, "reg", &host->cs);
+			if (ret) {
+				dev_err(dev, "can't get chip-select\n");
+				devm_kfree(dev, host);
+				continue;
+			}
+
+			nand_set_flash_node(&host->chip, child);
+
+			ret = brcmnand_init_cs(host);
 			if (ret) {
 				devm_kfree(dev, host);
 				continue; /* Try all chip-selects */
-- 
2.25.1

