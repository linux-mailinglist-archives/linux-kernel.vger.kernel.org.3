Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B68B487C57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiAGSqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiAGSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DAC061574;
        Fri,  7 Jan 2022 10:46:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so12864400pjj.2;
        Fri, 07 Jan 2022 10:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ck82Zp1Tae8+QI2Zx2HgGoHvZl69KSCAcrb3o+V4rZ8=;
        b=hrtt98CloqhBmvDI3lhMHSzgXd565r7hVxigscmEZDKCrWo5Hpd6gukvw/+fYq7N8F
         k2ruKHDPz6HJw7Y0zsDxj+/77yAQOmGEwDGLh1/6b3GDFEiETfWNkujMZ7lkJe2VQgwt
         0e9Mc0GoATMYJFkVFt68Yb8IRdq+93G3i5cb1A3eKC725uRzfxVi701CP80p9uLx3u5a
         uFY6LF0I71VIkI8sOkZFHnStxconajl+lmTzO8HGSUJqlRLEfOTanxxr1jw7608m4GrR
         +9xOjOlbhQPI13KVRxvqFukDwOWR5D42B3Afh0GWD65r82J3TczEG6fSQNVo284rfskr
         4c2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ck82Zp1Tae8+QI2Zx2HgGoHvZl69KSCAcrb3o+V4rZ8=;
        b=djf4im2oDeSSL54b2xbah6vWKBFlYs38Xh6jVnq+qRT7gMO40TXCFUAraZNqexzCvW
         zdvN1TgYOaDtRzS38eMvO8A75TXQRqi4y8CZVgAdy9b/opeBPQlNzS8egxIkbxFrMep5
         Xdn7cnuCUsD7dKNJ9NU6yOk9eeL6uQdeaV3dJFBsx83xepuoEZd9OHdlPl/YmxrT0lg1
         TJiL2b0g8oyXbzWVsy63YXCto/Nu39oEP6CYDDdj6WT8EeF9iXx+GrDIQB54R0VvHmOR
         B9Xs6iQL/1oRGm9zho4jYuK8ff+/6kRSmLv0rOlY+SdkXUpPcX7Hlyg2banUG8quzqx6
         n6mQ==
X-Gm-Message-State: AOAM533ohcufmLxpF9KmQzvfZudukvffNrbg5iyEDmm/R6NwKa5lmqRP
        gPULpxxGZxjNAAh/a/ElicM=
X-Google-Smtp-Source: ABdhPJwP79G3S4N6iYbgoCr/2lc/KlhPdEp+uz96DS6vUDW2/zR3MV5P1IahI3JTHGYA0Vr0WHQNog==
X-Received: by 2002:a17:902:6908:b0:149:b26a:b9b5 with SMTP id j8-20020a170902690800b00149b26ab9b5mr29947655plk.169.1641581187752;
        Fri, 07 Jan 2022 10:46:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:27 -0800 (PST)
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
Subject: [PATCH v3 1/9] mtd: rawnand: brcmnand: Assign soc as early as possible
Date:   Fri,  7 Jan 2022 10:46:06 -0800
Message-Id: <20220107184614.2670254-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to key off the brcmnand_probe() code in subsequent changes
depending upon ctrl->soc, assign that variable as early as possible,
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

