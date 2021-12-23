Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B247DBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbhLWAWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345469AbhLWAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:37 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5EC061574;
        Wed, 22 Dec 2021 16:22:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v11so3742476pfu.2;
        Wed, 22 Dec 2021 16:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igV+0PYJ8LgFBo0u2TcB0EcsmeY4woP3bELald8J87k=;
        b=IkOkTM0nQMWsqsA8TsFwC1jyekX63htbHYb7OcaRLvWw9x3E9Am5hhV6hugOwjwgqu
         99lIUBcPvnecQcDFnGK9HlsGfOqy05UbgnM+I16eOeK7vo56xTFHoLnseFzU94sb3xtE
         Gi7vhRtNVHoRR9ROjMKdiIy9cc4y2lpmyo7csvM6VSJKpD3oj1lvw2VjNy6VUgK0R7QW
         sxGymUfy3b+CnGudIjMqE8tXBgUYfi79gohXtV9MJgrkIkeVodQPrjySpvu+WxJqdI90
         2bPFUVUsd22zpkg1RXfJ2vgZDNWbH6y9azv65UD2Vb89SeCrILkSL8wt26vNVTUqofaB
         7BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igV+0PYJ8LgFBo0u2TcB0EcsmeY4woP3bELald8J87k=;
        b=6HI6it2hOrvLdZp4Bx5fds06l31ZgHEzZmgnNckK4ufVvK5VhoTYRgSHqdyu5Mf9RT
         LAX5xv2PD2UGqW+fosW832C+Ki/9qveB33nBCPG46FlewSgS6/u9eTwFmQuNnsUs60mJ
         MdFTL5KT8iBAuMnFsfGPFvoBvdIS0r3YifRWutJQAUzonDQmhhQG/FUc17hnh9d12Tns
         4kOnh3aQ1DVay+TdychLevumbv/2WURGu1djeBX4TKKa8Zc6BUIxOmHzY4GN+48hhW0X
         IOHO0sN1L4z0QlVfqqLSJXYvMvOA3/Pty74LkbIKv3qijrsd8GaLjj1GaHeNoaVfLj9y
         aFrg==
X-Gm-Message-State: AOAM530UsB1W7shOxBIyMEAEy2xOEKqoFvVgaMsfEEAELpZ1eSyh/yvk
        mfYRnPrkxobch+7Jx5n0ayA=
X-Google-Smtp-Source: ABdhPJxSckAZe9DaFM1bKLCv01xSnOpLQbV9TIEX6AathClFk7dRqG6dOadtWskP52LFfxtnCFC1dA==
X-Received: by 2002:a05:6a00:1582:b0:4ba:e636:391 with SMTP id u2-20020a056a00158200b004bae6360391mr100399pfk.55.1640218956782;
        Wed, 22 Dec 2021 16:22:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:36 -0800 (PST)
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
Subject: [PATCH 3/9] mtd: rawnand: brcmnand: Avoid pdev in brcmnand_init_cs()
Date:   Wed, 22 Dec 2021 16:22:19 -0800
Message-Id: <20211223002225.3738385-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
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
index fcea5a7443e8..35f8d8e02d4a 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2763,7 +2763,7 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
 static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
-	struct platform_device *pdev = host->pdev;
+	struct device *dev = ctrl->dev;
 	struct mtd_info *mtd;
 	struct nand_chip *chip;
 	int ret;
@@ -2771,7 +2771,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 
 	ret = of_property_read_u32(dn, "reg", &host->cs);
 	if (ret) {
-		dev_err(&pdev->dev, "can't get chip-select\n");
+		dev_err(dev, "can't get chip-select\n");
 		return -ENXIO;
 	}
 
@@ -2780,13 +2780,13 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 
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

