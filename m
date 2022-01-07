Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2854F486E69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbiAGAOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbiAGAOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:03 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F52C061245;
        Thu,  6 Jan 2022 16:14:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f5so3968511pgk.12;
        Thu, 06 Jan 2022 16:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAeEFO2qvIKP8NId8vfdtckbt5Y7Yjs9xWcmvkhoZSI=;
        b=mdWAqTR9fyhSi8Df7gWYtdt7BHU2fsxRj+WXjvkMximiEO56VSnNXZa7g8cw7sTj8v
         6cArDCX5bwiLMqs9LzNjVITJyqHY+8LYvBdtnKQ5bSzHS9hI0/Gw9Tvga5smTjlJi8Ed
         f7r8lfJgtqBrr90aEeH7F3vhT/iFihgzY2X/0zzfWwexuKJwGCnbtKR1LnLuwP/gfw0g
         ZTyOvLaEXJxZPFgAh2b/iX0v769jenBmV+cpIjmDo1zWX31/E8CNoZMizEbghMXH5cp3
         L8mH7aiPI5Wc1qLDVqiYgaMLHo91C862JzSO3d3dy5IuYGc/YHbPpaEdLaeF96aEdYpG
         8CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAeEFO2qvIKP8NId8vfdtckbt5Y7Yjs9xWcmvkhoZSI=;
        b=GyxDo2UmhIi761unqONkC5bpHPZSXJ+wKi5YRUpb7zF7SyWHIQcC8nyDTEhY+NPxqI
         i/46VX6OQFXo+9IU7CXQwXSqeAuHyJABKbBUGw4G8DgzbDlmxumdbni5W859c7JJkIiQ
         hCGD9MDFb8FQRKFnxrPNh7Hkoo11e7Fra75LR+Ii//Av+pVW8w7QoQJRRfTYqeLmKzIu
         orxDGi/VQRxRhxGA+W2ySbOGtGzz5RvVqXvLz2gHVLBX+Hjkv08X1p2quIaT3Z1/HTAl
         kRuNAIG2XA7h6RTVVvAIZhJxVXQwq25Zuk/jlEAzLqNzf7aEObbySm7AAk4ETHK6owow
         R4rQ==
X-Gm-Message-State: AOAM532+RQIv57fSLpnI6RlByNju7Vqv31GJbdpBDHdlmtnzXaP3cPJx
        gCKfVWBjhEwIeIkBOEpZqSo=
X-Google-Smtp-Source: ABdhPJy5ireaJcIcq1W271fVNEhILDI0b0GWowJLlF8ZFeWfAlMMJ10PGn35Xapr3uV6erfEEaIAvA==
X-Received: by 2002:a05:6a00:130a:b0:4bd:118:8071 with SMTP id j10-20020a056a00130a00b004bd01188071mr1376710pfu.28.1641514443085;
        Thu, 06 Jan 2022 16:14:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:02 -0800 (PST)
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
Subject: [PATCH v2 1/9] mtd: rawnand: brcmnand: Assign soc as early as possible
Date:   Thu,  6 Jan 2022 16:13:20 -0800
Message-Id: <20220107001328.2233896-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to key off the brcmnand_probe() code in subsequent changes
depending upon ctlr->soc, assign that variable as early as possible,
instead of much later when we have checked that it is non-NULL.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index f75929783b94..63080ae3aef1 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2998,6 +2998,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 	dev_set_drvdata(dev, ctrl);
 	ctrl->dev = dev;
+	ctrl->soc = soc;
 
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
@@ -3138,8 +3139,6 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	 * interesting ways
 	 */
 	if (soc) {
-		ctrl->soc = soc;
-
 		ret = devm_request_irq(dev, ctrl->irq, brcmnand_irq, 0,
 				       DRV_NAME, ctrl);
 
-- 
2.25.1

