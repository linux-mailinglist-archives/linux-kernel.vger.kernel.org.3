Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E14486E79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbiAGAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344155AbiAGAOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C249C0611FF;
        Thu,  6 Jan 2022 16:14:13 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oa15so2933369pjb.4;
        Thu, 06 Jan 2022 16:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNka3+IguUGdp1cydE8WGaLefB09Fww/UbWD2IYWkK4=;
        b=Seu9740tYZq1PJrqVoNChbyIC7rBtoexwJv6/iqahiJKdpsyV8jT8kZZ6VSLnLse9j
         mSxXfnoinDaoV6Bok1X4aL+RUAKE4n1cmtua3jTx0qHOJ34ye+rxXKwJugDt18q9FRsx
         KFNo/DBLZCAG6+Pk8ZQNYCnOAXYFvfDG2bFpN6RpS9DFG9A2MlYd2/YiE5CmF1bwmqKa
         /1OnD+ZaK4v8pPQVqrDavvDVPCd3nAAI7f2sDqomljjYuNEdzWZafoccWXRy8flxsAgK
         GdChk2RU4Eg1jjAKo8AE/WWGqfTW/2OVpp6EOJzzjE79wxLTrlPuAzqo02bszpeBGVpL
         qZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNka3+IguUGdp1cydE8WGaLefB09Fww/UbWD2IYWkK4=;
        b=F+V3nHLwYt7OQErD+VcsuSWIRBAoB4VDcuhqc3RYos6ikEeEi40GFaNO59ajbMJs0V
         imGpMM+HvbEgQp5Cst6YXtHb2gZ54yDiUEbvIPc3/6EZyGCBLNMl8UrtmhOr5QVm9SVZ
         6R1sIJgVNIqQRpJujJTc3ClTvOZek1FApWGwAx7TXyNIz1livDG0IfRLATo86bCitPbJ
         LnSH56G8NepTf5YdkIBA4xlamzkLc5wdYqBanSH53LW1S7hwWXsy2G7geMlwzQdiWWzY
         /sSFh7eE4cKU+ShF2y7iluVDvFPKuFX6lwChaWJZJYbtcx3maKPMcfHrfIAEaqqM8ntD
         Ptlw==
X-Gm-Message-State: AOAM531GGpv5/eNgFI+hbb8sPOpjky1BOAwbxApAUP1qitiHrXku3nE9
        8sMziAo23qlVXeqgPHOaE/w=
X-Google-Smtp-Source: ABdhPJxDAkhDdXYXT1X4dUFMKNxw4D+kgqAalhQrQCn4Tq5TbxqNmikwCs4vhUp8N3IYbf9BHQcEEA==
X-Received: by 2002:a17:902:8498:b0:149:f459:adfb with SMTP id c24-20020a170902849800b00149f459adfbmr4522715plo.85.1641514453069;
        Thu, 06 Jan 2022 16:14:13 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:12 -0800 (PST)
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
Subject: [PATCH v2 7/9] mtd: rawnand: brcmnand: Allow platform data instantation
Date:   Thu,  6 Jan 2022 16:13:26 -0800
Message-Id: <20220107001328.2233896-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the recently refactored code in brcmnand_init_cs() and
derive the chip-select from the platform data that is supplied. Update
the various code paths to avoid relying on possibly non-existent
resources, too.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 45 ++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 08e2acde5133..eab19df152f3 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/brcmnand.h>
 #include <linux/err.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
@@ -2768,7 +2769,8 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
 	.attach_chip = brcmnand_attach_chip,
 };
 
-static int brcmnand_init_cs(struct brcmnand_host *host)
+static int brcmnand_init_cs(struct brcmnand_host *host,
+			    const char * const *part_probe_types)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct device *dev = ctrl->dev;
@@ -2821,7 +2823,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 	if (ret)
 		return ret;
 
-	ret = mtd_device_register(mtd, NULL, 0);
+	ret = mtd_device_parse_register(mtd, part_probe_types, NULL, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
 
@@ -2990,17 +2992,15 @@ static int brcmnand_edu_setup(struct platform_device *pdev)
 
 int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 {
+	struct brcmnand_platform_data *pd = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node, *child;
 	struct brcmnand_controller *ctrl;
+	struct brcmnand_host *host;
 	struct resource *res;
 	int ret;
 
-	/* We only support device-tree instantiation */
-	if (!dn)
-		return -ENODEV;
-
-	if (!of_match_node(brcmnand_of_match, dn))
+	if (dn && !of_match_node(brcmnand_of_match, dn))
 		return -ENODEV;
 
 	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
@@ -3027,7 +3027,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	/* NAND register range */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctrl->nand_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ctrl->nand_base))
+	if (IS_ERR(ctrl->nand_base) && !brcmnand_soc_has_ops(soc))
 		return PTR_ERR(ctrl->nand_base);
 
 	/* Enable clock before using NAND registers */
@@ -3171,7 +3171,6 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 	for_each_available_child_of_node(dn, child) {
 		if (of_device_is_compatible(child, "brcm,nandcs")) {
-			struct brcmnand_host *host;
 
 			host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 			if (!host) {
@@ -3191,7 +3190,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 			nand_set_flash_node(&host->chip, child);
 
-			ret = brcmnand_init_cs(host);
+			ret = brcmnand_init_cs(host, NULL);
 			if (ret) {
 				devm_kfree(dev, host);
 				continue; /* Try all chip-selects */
@@ -3201,6 +3200,32 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 		}
 	}
 
+	if (!list_empty(&ctrl->host_list))
+		return 0;
+
+	if (!pd) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* If we got there we must have been probing via platform data */
+	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
+	if (!host) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	host->pdev = pdev;
+	host->ctrl = ctrl;
+	host->cs = pd->chip_select;
+	host->chip.ecc.size = pd->ecc_stepsize;
+	host->chip.ecc.strength = pd->ecc_strength;
+
+	ret = brcmnand_init_cs(host, pd->part_probe_types);
+	if (ret)
+		goto err;
+
+	list_add_tail(&host->node, &ctrl->host_list);
+
 	/* No chip-selects could initialize properly */
 	if (list_empty(&ctrl->host_list)) {
 		ret = -ENODEV;
-- 
2.25.1

