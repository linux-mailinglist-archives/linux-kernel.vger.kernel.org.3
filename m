Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA22487C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiAGSqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiAGSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:46:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B2C061574;
        Fri,  7 Jan 2022 10:46:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id n16so5547934plc.2;
        Fri, 07 Jan 2022 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VtXa0JLQVvOi+abLVd3TXrF3D9fiUE3Nqg2B33JgGDE=;
        b=CF8Nt9xqrZ8z196sYsHi9Cn5s+V2Z6Vg2+nrGzD1GDpNAldFZSGmioe66CgmzlavLl
         3J726lPy2s3fplaVUDfuy7CwLDcvW6faEvIAWZhcQz4ecVtayt8HAcyeBj/1BXeP8+LA
         IWxMgNBdjp20VXY51YnhT6Ove5OXv1Cgif0G6mR+sh1QDpgKotG5RizK2MiIAMLM+S0i
         IcGwENp3QQ3DqmurhqMqfOcF1DW3mLCni5xZvqCRhvSu9oUvqNa7aet6onHaaFXryce1
         ZHHFu9CH4T0LlVvy7ns3NufmiHkrfHYzacDn2rVVwgvgEgw5luVqFu1yaNTPNDt/tQBv
         tMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtXa0JLQVvOi+abLVd3TXrF3D9fiUE3Nqg2B33JgGDE=;
        b=rKHTmLjlwl9MmVj4Ef6A+ZxknqR3YzJ2yzqDQWajyAWt2ZU9oit0r0ZtoSrbCQPoh0
         gfzylC5ME6Xxmd6/4XmCSZUX25YfPrQHYMau4uvTDYDpqRSX3Cv8AgCMw5EoLb6pa44Q
         9BeVFJIXPLv/MraBy7sO9wf4DIxd5mgzSp7kOId14mpzDDp5xJ0P62cYjgC2PdbTpMtu
         itCBkrJBigvwhuv9BDhYTcNJZiVcKi5yyg73aMLh5WK7tgTWkWwTY12d0H+LDYZ0hCmA
         sPZhqW2nK/fpz+GKbhaMs2yXKXEPKToTDm/lQUZVGGUzvdiynQ1DLovRgyr303N+jefP
         x4Kw==
X-Gm-Message-State: AOAM532pnEeuj2ev0hskyWd5JVmkqaEeK5P0iqHnNWO9QdGXsbFmdFEj
        VRRW7IyoaWMLAg6X6fV0uJQ=
X-Google-Smtp-Source: ABdhPJzD2DUZByPCwa3IZAJVAvAj5ydfMJtnQXgy8olVj0AvXrolKfnLyRt8aLumzoHg4YE3lNfQQw==
X-Received: by 2002:a17:90b:1d07:: with SMTP id on7mr17132990pjb.206.1641581194689;
        Fri, 07 Jan 2022 10:46:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x33sm7219417pfh.212.2022.01.07.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:46:34 -0800 (PST)
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
Subject: [PATCH v3 5/9] mtd: rawnand: brcmnand: Allow working without interrupts
Date:   Fri,  7 Jan 2022 10:46:10 -0800
Message-Id: <20220107184614.2670254-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107184614.2670254-1-f.fainelli@gmail.com>
References: <20220107184614.2670254-1-f.fainelli@gmail.com>
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
index 40818c881f08..08e2acde5133 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -216,7 +216,7 @@ struct brcmnand_controller {
 	void __iomem		*nand_base;
 	void __iomem		*nand_fc; /* flash cache */
 	void __iomem		*flash_dma_base;
-	unsigned int		irq;
+	int			irq;
 	unsigned int		dma_irq;
 	int			nand_version;
 
@@ -1610,7 +1610,7 @@ static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
 	bool err = false;
 	int sts;
 
-	if (mtd->oops_panic_write) {
+	if (mtd->oops_panic_write || ctrl->irq < 0) {
 		/* switch to interrupt polling and PIO mode */
 		disable_ctrl_irqs(ctrl);
 		sts = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY,
@@ -3144,33 +3144,29 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
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
+	if (ctrl->irq > 0) {
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

