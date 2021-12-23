Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E325347DBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbhLWAWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbhLWAWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB7C061748;
        Wed, 22 Dec 2021 16:22:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x15so3055106plg.1;
        Wed, 22 Dec 2021 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooOQpqGI8yqwBdhnAO1DTOd+XDWRopDBw4/NhIv0RTg=;
        b=Caau2MVJF8vOqLzcwoVJXvMhtrKVgzUKS7PfAM0T86L5n6vh3B5MtIy4/0vpJflYMk
         8o8O97LLzApN2bfBSOuJpaMQQxa1GFs31k74LvcYSDIkjAbezmh99XHexENvLCNprvrG
         qoo/VAhQuqVPEUfszUKj4xDs+Nk/cJ82RVgF20dS8FT5kSs/ayOMxIe2FDgK4ShFRzJ5
         QQ5YVpQmoMoZoQhiFYsRUpTvsVshweqH6AfWc64S4kEYgoriaWvJHsKqPoad/us8KpwT
         gGTpy8Musa+aPKHIeRnKTOeLEaVgYR0UYiN+Rsj1CTbWmsZqk+wE64BBS5Au920rBMyL
         a74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooOQpqGI8yqwBdhnAO1DTOd+XDWRopDBw4/NhIv0RTg=;
        b=462VMHyHrsXxJtjU4BLY5mjr7rRX8TnFvP2s4lDfkPJCNe1tHcpLgr60JM07mffnpT
         Lgy2ngHAtZpmFORa2pZeJqEW1Gth9r69Kgq/d9tELZoriCD+psnAO+M1EuYVSpQcMKqX
         iwiNJFKzEpyqj+mE9NdCc+8DmiD37BxH9zDHvWMjft7WlC63y+WVf/YmEzMWSfIKy1fK
         T5nzpTZ7XJYgL1sFM9sKHYbE/orE0ZW9GphgD+qoXFiol+kQu+x66bhnUjoAq+fxoz6Y
         dznF+ZFkUt1M96QApAWZF6GKUDRy1Okx9wByCBzjTN7pWs69daO1LTWBf69+UIF+mINT
         892w==
X-Gm-Message-State: AOAM530b/i1ESW5saPggs6/aPhlgrRm41e/Cmf6N8vutTNR4qEgePdGO
        0WpAA6Mu3NDGt2WCqx2YV9M=
X-Google-Smtp-Source: ABdhPJxa7BlJTDNL5Bl9zH3S6qNvt+nePjZ4VIg972BHLrDi/rIXlBQtfu1Tm6HFn1XrrNRYwtePuw==
X-Received: by 2002:a17:90a:6b44:: with SMTP id x4mr49967pjl.27.1640218963819;
        Wed, 22 Dec 2021 16:22:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:43 -0800 (PST)
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
Subject: [PATCH 7/9] mtd: rawnand: brcmnand: Allow platform data instantation
Date:   Wed, 22 Dec 2021 16:22:23 -0800
Message-Id: <20211223002225.3738385-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
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
index e7947cff4dd1..2f2aaa554282 100644
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
@@ -2760,7 +2761,8 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
 	.attach_chip = brcmnand_attach_chip,
 };
 
-static int brcmnand_init_cs(struct brcmnand_host *host)
+static int brcmnand_init_cs(struct brcmnand_host *host,
+			    const char * const *part_probe_types)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct device *dev = ctrl->dev;
@@ -2813,7 +2815,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host)
 	if (ret)
 		return ret;
 
-	ret = mtd_device_register(mtd, NULL, 0);
+	ret = mtd_device_parse_register(mtd, part_probe_types, NULL, NULL, 0);
 	if (ret)
 		nand_cleanup(chip);
 
@@ -2982,17 +2984,15 @@ static int brcmnand_edu_setup(struct platform_device *pdev)
 
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
@@ -3013,7 +3013,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	/* NAND register range */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctrl->nand_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ctrl->nand_base))
+	if (IS_ERR(ctrl->nand_base) && !brcmnand_soc_has_ops(soc))
 		return PTR_ERR(ctrl->nand_base);
 
 	/* Enable clock before using NAND registers */
@@ -3157,7 +3157,6 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 	for_each_available_child_of_node(dn, child) {
 		if (of_device_is_compatible(child, "brcm,nandcs")) {
-			struct brcmnand_host *host;
 
 			host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 			if (!host) {
@@ -3177,7 +3176,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 			nand_set_flash_node(&host->chip, dn);
 
-			ret = brcmnand_init_cs(host);
+			ret = brcmnand_init_cs(host, NULL);
 			if (ret) {
 				devm_kfree(dev, host);
 				continue; /* Try all chip-selects */
@@ -3187,6 +3186,32 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
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

