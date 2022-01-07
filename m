Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D3486E6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343954AbiAGAOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbiAGAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71F4C061212;
        Thu,  6 Jan 2022 16:14:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t32so3987391pgm.7;
        Thu, 06 Jan 2022 16:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qnrm4M73pcXgG2prIGPXbohVD9PEy3lmOekq9Ie7yIc=;
        b=ObYPBPNQI76IvDAFqWLlVXbar5bUsxlHdNYmKMlhDj1JMnwjejflYfRT4SpcXGU5aI
         cj+ArGk2ej/+GfYyl2Y/LiBBLDXCoSE8iHQGjwEUcAlW5d3CYtT2BRPerazDhhQc6Ggm
         ++ZCAlyw0GHtPz2mQnPEWZv4Lw7gj8TeSUxs9yYKFz2Zy+ApBv9AonaWoVUCqNXtTgnQ
         aDaln5QjljfU3GXEkFtRzkUVVJYvFuKjR2DIXW3yUy/+bKW0yBNfF0hdObSOKzMHjLjs
         /29YrbAHUb+scwzv2SqNYrM9sgdFIKf3N1yOy8aUN2VIO72s9+N5iIIK+dFjJpw2hRIt
         nDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qnrm4M73pcXgG2prIGPXbohVD9PEy3lmOekq9Ie7yIc=;
        b=D4R3NA3mCUUvNkmRHA+Ig6wmenFsI0YTAEKKTAXtdn+YKMQqR7l6A6H0m1WFSC/mYB
         qiTAmvOcVjriyPzcH5J0f4uKk6YkMS7+uk6TBR78MV2L0onlufiLnCqg8yxvm9a61RqR
         VGyNS+ezq85kG2GKLBc5MaI0SGlMZ0vuBovMNtA6wyRD0GSYqWAJtGEx+gcZ7KR0TODD
         kL2SUbCVMtEnqii1v5H3zJxkShyYhC34RCCKSl+utiLwoM/++xMYfrNBGc7MMaUUEjB2
         a3uUdPDxEwXQ7nYPv3qxUiF5dxCRsneoqKjQKE3zlVqPlhwgv1YQYn9CsnYOAALgkUTJ
         Y2+Q==
X-Gm-Message-State: AOAM530WSIwidH9hMxJaSdHG+mGp0BB8mvrifx4gQKvV8DxXyU3i29nT
        ddcgdXJWCBbbmwyhFwyt3nM=
X-Google-Smtp-Source: ABdhPJy/ay5oezAqQtSDT5SKYRsd02isnhXaeOH806ZvUoIyPwUpjWfGtPyaoihnmnkCwwsjnzD5aQ==
X-Received: by 2002:a62:80d8:0:b0:4bb:a8c5:868 with SMTP id j207-20020a6280d8000000b004bba8c50868mr57972741pfd.25.1641514446464;
        Thu, 06 Jan 2022 16:14:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:06 -0800 (PST)
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
Subject: [PATCH v2 3/9] mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
Date:   Thu,  6 Jan 2022 16:13:22 -0800
Message-Id: <20220107001328.2233896-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for encapsulation more of what the loop calling
brcmnand_init_cs() does, avoid using platform_device when it is the
device behind platform_device that we are using for printing errors.

No functional change.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 9c3909c34dc2..fc14765f7d23 100644
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

