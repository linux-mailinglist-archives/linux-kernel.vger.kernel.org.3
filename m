Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE547DBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbhLWAWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbhLWAWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:22:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4DFC06173F;
        Wed, 22 Dec 2021 16:22:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j13so3045513plx.4;
        Wed, 22 Dec 2021 16:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyUAWvS1gGoBBI9YnGm7NS9rETUeD3abG1ViwzHmvu4=;
        b=VTCer4Mtp8RLzMSH8RC2nIFh/FXARGwSh+ydQ/Ax+I+fTFnqaP2yerzTydFctlr16O
         ypRLn6pM0sZW+eEs5j3m6uqIftECAtEBSyNnSxxMydBnh+puZuZ9f9GUPODlp96Y9Kp2
         3f+rs5DTXec0vcDs44+/1wz7NKLOecyqGUlXlGN0lv1UR2mudPzTDq432geawrgpMRVh
         gyLP/LrMqJ934tiegUuQRt6ZMnvdEd+TB11lpO53Sk9BPN2OmVR8AwxpCWjWuSLrhqmT
         NOwwZ4lTnDRBUge8dvQ4HJVWmj25Ej9AeTS2EE65OOAgPi3xauzZ3akmDVLB9olpWEQ7
         NNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyUAWvS1gGoBBI9YnGm7NS9rETUeD3abG1ViwzHmvu4=;
        b=mJxh8Li+rpnCXjjf/iwKb0kAPd43cZw0XxfboGgPrYLq+1Cye14A9CxM7OOKlQQLOH
         hYwjOLmotSCjZ+j4Un8XsrxNsXKuzxVzdVs/tnq8B383xi9pq8KOZtYn904hGOZigcN9
         8FTLR3nb4+t6ToZnX80BjRBJRHCSL57Dktf6kCcWducn8Hdoga8Bu+FfNSKuv3lGe/gH
         RMz5gcnKGE9v+R4BKxarYL1fTEvhiw8ZSfz5sqbCJwBD2OFWPe5HM2j0v37JEnInu5Bd
         thgW72dAdUaTWYBFe6z9ObUwW9nXAi5i3gfS8O8N3Fww5nmUM7gial4jXyyakOfbi5ap
         ZKWw==
X-Gm-Message-State: AOAM532dTuSLqhSiwWrxDsfP2sLmozWl0oqCSqc9NYDq/KX4cMz64ixI
        KHMZMMB5As93HrPjCC27jqQ=
X-Google-Smtp-Source: ABdhPJy8wqp8KEVSmde4I2+jqXBoLwY02wjsZ6DHtmHFxSVGRiOxohuSF6x6WR9Hnxh/kobAf+wCeA==
X-Received: by 2002:a17:902:d2c1:b0:148:f6af:f2c5 with SMTP id n1-20020a170902d2c100b00148f6aff2c5mr107318plc.7.1640218960290;
        Wed, 22 Dec 2021 16:22:40 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e24sm6720703pjt.45.2021.12.22.16.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:22:39 -0800 (PST)
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
Subject: [PATCH 5/9] mtd: rawnand: brcmnand: Allow working without interrupts
Date:   Wed, 22 Dec 2021 16:22:21 -0800
Message-Id: <20211223002225.3738385-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223002225.3738385-1-f.fainelli@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCMA devices include the brcmnand controller but they do not wire up
any interrupt line, allow the main interrupt to be optional and update
the completion path to also check for the lack of an interrupt line.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 52 +++++++++++-------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 60a7f375df83..e7947cff4dd1 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -213,7 +213,7 @@ struct brcmnand_controller {
 	void __iomem		*nand_base;
 	void __iomem		*nand_fc; /* flash cache */
 	void __iomem		*flash_dma_base;
-	unsigned int		irq;
+	int			irq;
 	unsigned int		dma_irq;
 	int			nand_version;
 
@@ -1602,7 +1602,7 @@ static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
 	bool err = false;
 	int sts;
 
-	if (mtd->oops_panic_write) {
+	if (mtd->oops_panic_write || ctrl->irq < 0) {
 		/* switch to interrupt polling and PIO mode */
 		disable_ctrl_irqs(ctrl);
 		sts = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY,
@@ -3130,33 +3130,29 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	}
 
 	/* IRQ */
-	ctrl->irq = platform_get_irq(pdev, 0);
-	if ((int)ctrl->irq < 0) {
-		dev_err(dev, "no IRQ defined\n");
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/*
-	 * Some SoCs integrate this controller (e.g., its interrupt bits) in
-	 * interesting ways
-	 */
-	if (soc) {
-		ret = devm_request_irq(dev, ctrl->irq, brcmnand_irq, 0,
-				       DRV_NAME, ctrl);
+	ctrl->irq = platform_get_irq_optional(pdev, 0);
+	if (ctrl->irq >= 0) {
+		/*
+		 * Some SoCs integrate this controller (e.g., its interrupt bits) in
+		 * interesting ways
+		 */
+		if (soc) {
+			ret = devm_request_irq(dev, ctrl->irq, brcmnand_irq, 0,
+					       DRV_NAME, ctrl);
 
-		/* Enable interrupt */
-		ctrl->soc->ctlrdy_ack(ctrl->soc);
-		ctrl->soc->ctlrdy_set_enabled(ctrl->soc, true);
-	} else {
-		/* Use standard interrupt infrastructure */
-		ret = devm_request_irq(dev, ctrl->irq, brcmnand_ctlrdy_irq, 0,
-				       DRV_NAME, ctrl);
-	}
-	if (ret < 0) {
-		dev_err(dev, "can't allocate IRQ %d: error %d\n",
-			ctrl->irq, ret);
-		goto err;
+			/* Enable interrupt */
+			ctrl->soc->ctlrdy_ack(ctrl->soc);
+			ctrl->soc->ctlrdy_set_enabled(ctrl->soc, true);
+		} else {
+			/* Use standard interrupt infrastructure */
+			ret = devm_request_irq(dev, ctrl->irq, brcmnand_ctlrdy_irq, 0,
+					       DRV_NAME, ctrl);
+		}
+		if (ret < 0) {
+			dev_err(dev, "can't allocate IRQ %d: error %d\n",
+				ctrl->irq, ret);
+			goto err;
+		}
 	}
 
 	for_each_available_child_of_node(dn, child) {
-- 
2.25.1

