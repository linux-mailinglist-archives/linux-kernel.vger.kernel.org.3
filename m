Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50479487C60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiAGSqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiAGSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B399C06173F;
        Fri,  7 Jan 2022 10:46:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso12898780pje.0;
        Fri, 07 Jan 2022 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzfKG2mIRQGSvw1CkEuUtuMIqXtLzgCz1k6TZathavs=;
        b=CInyfj548yzLwHxEI83E7hFohiLMAPzKLWejyKPXDzSaD7tpYbc9PUXpig4sBdrQxO
         2sxyQ4gmcDpH1ENU5C5dnWGR7mf3DSQIrSDVZ4emKhwsaLspTV3toizlEivcZ2C9VoWh
         KjAIvBCGggAXhGAR3AYY4M9tVC72PaN0tg/ZqVgaT0HvXoBFsswa9LaM9D071xsbO5Ab
         3TuI/zMthgfEcJsgMM8mo2nfT4q5klGLZrqosewJlh9SKjOZQfBD6U2e02kMMa8wZlFJ
         fgj1FpFuA9yzStnreme6MuTPWAhIjH/ZelanavO716mv5e3lxRb7xQjVgrZ2otTeXS3B
         efww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzfKG2mIRQGSvw1CkEuUtuMIqXtLzgCz1k6TZathavs=;
        b=xuIhOlCKgAhVqO1+J7vDRKSHap6LRTTXUgFrS7MR91tOgqTLr3+q9CGSI4m3IlnQaq
         y8CLDKxR32waNs/ZQOvnxpmdFQmlggD5/uq60ti4PMnsZg+SoFLrq2dFm0ORFk7Qedq6
         OfXb3hGMBapWyboLMZYHEVRfSGjTAgpEW0lQJGWpq1urhiHmrfCUuvb8aTI4r6jehrC2
         +PvQioka4bq/s7+/w4rhl2O/DbOM84mSES4HIguF2K6PzGhicD1cvzyEykpYPiZNxP9O
         cqTWVstL0TIQgsgBKIYvdvZ58ZOGUQquYcg/1x2ME8nxxvZhNxiDpdX3QQgs+U8AY18K
         dGcg==
X-Gm-Message-State: AOAM533gQjNTjUSG7ARNSbB++j1Ja5hbajf6fU26Snkvz/PxPC9v/BO8
        G7oOfU21zXL7TX738RqMnnVNISpJ25I=
X-Google-Smtp-Source: ABdhPJzFd66kFUlYUPppIyIPnYlll0U9aC280oKZbQYgDzgsGghFduWTMEBghVVIdBu7Oe4TsT0TZQ==
X-Received: by 2002:a17:90b:4a11:: with SMTP id kk17mr17049568pjb.234.1641581192967;
        Fri, 07 Jan 2022 10:46:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:32 -0800 (PST)
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
Subject: [PATCH v3 4/9] mtd: rawnand: brcmnand: Move OF operations out of brcmnand_init_cs()
Date:   Fri,  7 Jan 2022 10:46:09 -0800
Message-Id: <20220107184614.2670254-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to initialize a given chip select object for use by the
brcmnand driver, move all of the Device Tree specific routines outside
of brcmnand_init_cs() in order to make it usable in a platform data
configuration which will be necessary for supporting BCMA chips.

No functional changes introduced.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index b7b15ddf326f..40818c881f08 100644
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
@@ -3193,7 +3186,16 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
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

