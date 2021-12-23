Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0047DBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbhLWAWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbhLWAWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71595C061574;
        Wed, 22 Dec 2021 16:22:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gj24so3628375pjb.0;
        Wed, 22 Dec 2021 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2NATCUWUg4iwnRGoqM+mgzKzp/1tXDebp9cGfC5HfA=;
        b=OkvKBUsGESkn9oq3lyl1KbJ8FGgqluSGLkS7IDTN0WsZiBYkxuPVNKZbs1RYS5T6u4
         x0wbqRMPulF/zKWIdAba3clMX3vnNJrtwqGl3PAHPziIUbQVwUnrVR4WRXjkS7Q3s5eI
         3xAc+ImwQLgy/q6vQ7Dvuzt5w21haF7mia58Fl2M16RadovRJC4ozxvnD5lcy1aabKic
         uJJnDYOfCjlcfVUJQyLkVyGYEYDcFmmsfSBgoCHlVJ5C2EPg/hVscwHp7VQ96M+6sdEY
         sq9SFghUcWesgJ96cWs5VNx5ism+i64xPGERCJ2uZ1ZPYVTK+dACkvGodDyeqvRsf1sV
         4lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2NATCUWUg4iwnRGoqM+mgzKzp/1tXDebp9cGfC5HfA=;
        b=IX0Je3I3v8iPDMsKCMcU+VKYqETovfnm2yQRq5+yJz6x7DzTSMLC8WfwkWLgeIU2yY
         tojNTXRdztyOd5LyI19A9VbMfz5T/EWvBxbNPf5GMBVXC5PjbIQOdu/PU/dhJfDI5NVF
         umVl1j/abk2zCib2PICrTSCt2jZP0i5kFbonzP+YwOtTWbQwu7Yfjabgq5noQtg3ZrGj
         +Dy2E4R67N1UqChL4R36YbUu6SsYMTxGM7ENmljkHPIiSvd2LloV/4NZwUDZgF1jjAez
         UAo4OM+IdVJxirZrXpTjUXtorwiBe4pH8G16njzmKEh1KnX7848XfjYVG742dAqYhQZm
         jUkg==
X-Gm-Message-State: AOAM53178X3tgzbq3vR5xpZBbk/WFTRjNCoU6xQ0vl65N02y8c6pSfBI
        ZBNpXHRK+u9CylcXEJQ1SwY=
X-Google-Smtp-Source: ABdhPJwjNO0Ihj3L5T0ypAgnFYpoTOdk2YWaXKlYWeEVPK/HEnwmcop3KmKEUFbkY0u8nZRvReO5mw==
X-Received: by 2002:a17:90b:4a09:: with SMTP id kk9mr45266pjb.53.1640218958532;
        Wed, 22 Dec 2021 16:22:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:38 -0800 (PST)
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
Subject: [PATCH 4/9] mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
Date:   Wed, 22 Dec 2021 16:22:20 -0800
Message-Id: <20211223002225.3738385-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
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
index 35f8d8e02d4a..60a7f375df83 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2760,7 +2760,7 @@ static const struct nand_controller_ops brcmnand_controller_ops = {
 	.attach_chip = brcmnand_attach_chip,
 };
 
-static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
+static int brcmnand_init_cs(struct brcmnand_host *host)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct device *dev = ctrl->dev;
@@ -2769,16 +2769,9 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
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
@@ -3179,7 +3172,16 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 			host->pdev = pdev;
 			host->ctrl = ctrl;
 
-			ret = brcmnand_init_cs(host, child);
+			ret = of_property_read_u32(dn, "reg", &host->cs);
+			if (ret) {
+				dev_err(dev, "can't get chip-select\n");
+				devm_kfree(dev, host);
+				continue;
+			}
+
+			nand_set_flash_node(&host->chip, dn);
+
+			ret = brcmnand_init_cs(host);
 			if (ret) {
 				devm_kfree(dev, host);
 				continue; /* Try all chip-selects */
-- 
2.25.1

