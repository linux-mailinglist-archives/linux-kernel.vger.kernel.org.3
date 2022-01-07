Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77096487C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiAGSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiAGSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00FC061574;
        Fri,  7 Jan 2022 10:46:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so12824290pjf.3;
        Fri, 07 Jan 2022 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VWMwTN09ik8fW8a8CY0ElUYPbbYaX58lNI28bcRHTR0=;
        b=FON8An2+hHEanHVgMPl2S3doJMeYEWzOlk7LB+S9YxVqFbXdHaH/ESv0Ay8R/EDhwF
         b6ishHB07KRQ+tudnpxperUePV/eUiXof83DNyrKNsUXmn3yBKKV97PYoViRvwS2oNfe
         LRAanmmef4dq0g5y4KauPc1vUEcBd8jzfRqC33ujGX9Ij9cDRcoJq7OvxOB5yjWrxyt6
         HViQjzUve70V+ToPd/aHH8H8tjeizrDaRBSvBBu/C/9eUXxPnkbvZGCSO5Pl5n4Ju/yi
         ICIxCLrxQjsXDcHyAO+oTJwcD+LfPT31qd9DS/OHkwT8YlGaf6cbjVHki21150hdtYZr
         LNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWMwTN09ik8fW8a8CY0ElUYPbbYaX58lNI28bcRHTR0=;
        b=IJeIPvBj6NvJlLZhlYO+6nMJ7N+7PuUocOyblpdQgr4Ox9jJUyNRGjH3DqvRF4shXh
         u10CTkVRolmXx+n21KW3lQvkas4l6uZlTMtvM+g/W/G4xe+DU04i4y1LZkhUTgTrNadw
         IGMhWExwrqTrwG1pdHWLVrrm3vyf8jA1ihDrpPbdXhkL+q74FAEc8oHABYnM3Lw5BPGZ
         pX+Bb2qFcnPQ9Lr7p8e1rw6Ji/4Ki/NsrDiWzkeX8YQzXZg0YhI+8zC7XSG+2g3cYFtF
         O1UMpJ3Nevb72F0DCiQPO6qLSL2ll57Nkd6P+Xa8oPeog+V1o3NhhiG3NCeWY5YglAys
         uoPg==
X-Gm-Message-State: AOAM530YcGfzCCSkhrVJIltDA6tzk53tSR8KuU5CvuallHWFDvJfFRiG
        8nga3EkJa/X4267VSaDPUJg=
X-Google-Smtp-Source: ABdhPJy97gYS+reSg3OC50pgLt4B/9MmZtVqehrLZ28AoIqa0x2vrm0SLfDY1NhBvKeAG7QW8wP3YQ==
X-Received: by 2002:a17:90a:14f:: with SMTP id z15mr7989126pje.162.1641581191073;
        Fri, 07 Jan 2022 10:46:31 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:30 -0800 (PST)
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
Subject: [PATCH v3 3/9] mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
Date:   Fri,  7 Jan 2022 10:46:08 -0800
Message-Id: <20220107184614.2670254-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for encapsulating more of what the loop calling
brcmnand_init_cs() does, avoid using platform_device when it is the
device behind platform_device that we are using for printing errors.

No functional changes introduced.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 48d57b19c293..b7b15ddf326f 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2771,7 +2771,7 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
 static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
-	struct platform_device *pdev = host->pdev;
+	struct device *dev = ctrl->dev;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
 	int ret;
@@ -2779,7 +2779,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 
 	ret = of_property_read_u32(dn, "reg", &host->cs);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get chip-select\n");
+		dev_err(dev, "can't get chip-select\n");
 		return -ENXIO;
 	}
 
@@ -2788,13 +2788,13 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 
 	nand_set_flash_node(chip, dn);
 	nand_set_controller_data(chip, host);
-	mtd->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "brcmnand.%d",
+	mtd->name = devm_kasprintf(dev, GFP_KERNEL, "brcmnand.%d",
 				   host->cs);
 	if (!mtd->name)
 		return -ENOMEM;
 
 	mtd->owner = THIS_MODULE;
-	mtd->dev.parent = &pdev->dev;
+	mtd->dev.parent = dev;
 
 	chip->legacy.cmd_ctrl = brcmnand_cmd_ctrl;
 	chip->legacy.cmdfunc = brcmnand_cmdfunc;
-- 
2.25.1

