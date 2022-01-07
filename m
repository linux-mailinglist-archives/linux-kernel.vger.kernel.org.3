Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A251487C65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiAGSqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiAGSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BFC061574;
        Fri,  7 Jan 2022 10:46:38 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id oa15so5020985pjb.4;
        Fri, 07 Jan 2022 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNka3+IguUGdp1cydE8WGaLefB09Fww/UbWD2IYWkK4=;
        b=WAkxn7Y7e3feZMxkZBuLX0utJF6hnnGKmtV7D0OLC6/dWO49EanzJ3VJqZPLVk+PmU
         j/GDi7X3Ovplwwzx1TuoStfnSUo7d6lDxa6U56TV02DYb64iwzZaWFhgSVlS6X4qXvzt
         ssmFNkCv0CwLqar64zshgpESUf9paX5Xy+41o1uHVRzm1k5wnyol3EaNN+xsN28jGpIX
         SZ7EZVMei62+4CDRs0Xxl+eS0za5OT1ML7KPKnSBEA2zpCzdydZxdCnnBXlpz8RVtQKK
         bRGYJRhYkv3+9p99fX9oory3dpubeSBF3X6ZvNyX0C8YWweaZtsl7LebwtKD/hlPI5sV
         nLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNka3+IguUGdp1cydE8WGaLefB09Fww/UbWD2IYWkK4=;
        b=1q/dyBzZl4njyHmbctawEM6l9apLzaCMH8W/4wNF/NRYPgMeIV4N2J8Iul7p6WW1Sf
         3OXMnKsmCKQ4MZ/PTwteNCIZWMP5i+sa0/2xnGHqH3zohwI4TUUV2wWKkA/oRR3dDZKg
         7tV7R0e7FjY4vEaN6qa+/PmCtCS/US0Ar0lFi09iGiqgRKizeHRTUn5vtY/VHGHnRST2
         vWGlo3qFTFQJNbuvEOZA3uQeHXWGST2PQmi8+TzJjyUyjoWnz+cnTdmBXcpcwHwPPER8
         1XDcrYPsIlw6IymdxbZhz0DTYRPA9Pj4h5HrCnQoPZiAFV5kT48AMR5wnQx7MH+2bivW
         uCKg==
X-Gm-Message-State: AOAM532IXWPTKzbcxUy437thFtRjO8xXtI/5T59bjoMisuOuL7siNZC/
        /qvCNzYrDu6sbwTI45WT26HY7vcrhcg=
X-Google-Smtp-Source: ABdhPJyZ82rYYZRX4Fu9ASYFftR+uO8fuahLulDL47+/+0R2YmEnNsFcfopUSf17JYLMIVMT5atioA==
X-Received: by 2002:a17:902:7b96:b0:149:49fc:7de0 with SMTP id w22-20020a1709027b9600b0014949fc7de0mr64010431pll.25.1641581198020;
        Fri, 07 Jan 2022 10:46:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:37 -0800 (PST)
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
Subject: [PATCH v3 7/9] mtd: rawnand: brcmnand: Allow platform data instantation
Date:   Fri,  7 Jan 2022 10:46:12 -0800
Message-Id: <20220107184614.2670254-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
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

