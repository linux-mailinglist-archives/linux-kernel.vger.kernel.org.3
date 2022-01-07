Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676CE486E73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbiAGAOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343760AbiAGAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:14:12 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCF4C061245;
        Thu,  6 Jan 2022 16:14:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q3so3797708pfs.7;
        Thu, 06 Jan 2022 16:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjymxtvSAHzuripXcrJD4sdFOCg6SKx5Og6RNHAAYLc=;
        b=MGpGfRuqt4Yuwkq9IYK8nB59rRTrQpGt0xdwWcBlnJ8jTI0FXTnXADT82QvjTxKT+n
         iNauB7iptLi9ftqc08f1l9CvH1ZKjhsFVaJ2bGxdf+O70xiFOB54ntHeAlcsqaYGnsC7
         qzM1wKD0AJPDtChFSnAAC+X4fznY1+07hYoKCWm14VU5YnWref9YGUio7qIHgdKBsfbg
         cgHDfENCvW8e51cLB1gu/3O0bz9IH1UMmvtRO8AHoYxJTyWFJwbJX3w6lXm50EcqP3nZ
         nJR9wmAqeP8weA4nXOXuWiLZ2jRmeBLnxDtKm9IHudwwfWDIsvcl77F92iNw/xataZIO
         7eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjymxtvSAHzuripXcrJD4sdFOCg6SKx5Og6RNHAAYLc=;
        b=aPteuVSvpjXeoEpF/cj8AkPSnxEX6ezXJ/DPTP1+06T7piN1zggde30+UgiIlJhM6a
         P7MEbTXdJ8SRbJsRL/XPYaXDnrzTSh+sl2rWmriLmlLPW11adbMf3azTuO64tRsDWbXK
         6uoVbhD3Q9axX5NRiQqQJ/Z4TXba9sPOu+jQlQj1dPBi3Ebt7RIwyPs8cIRGEGzyWWq9
         3k6AyPfmP+uqf17I22qNeY4qYv29NOax/mYbSbIHuXymwvSR08QYwvxRpbv/gfaCYuw/
         9kqj2mrEsNlruwWkNLP2OoUtTG8n4/NUAdcsaaidetWqN/QuTCCz3oNlsQ6K9A7YJ9eA
         foCw==
X-Gm-Message-State: AOAM532UV/jhh2u1uOvaYqcQwAT2coSpGemy94pWjnamRvCwfHjeVtpS
        IPxJDR6W4BXg1YetytRp2qOiRn5qC2U=
X-Google-Smtp-Source: ABdhPJzDNmh5EoWEtS9OXTcEzCJS222a/iK4JdH9QhwRgbZ29nKgAyj1CHQ/xSanc64V87hPFkyKNA==
X-Received: by 2002:a63:7116:: with SMTP id m22mr53796704pgc.348.1641514449788;
        Thu, 06 Jan 2022 16:14:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3sm3301906pju.37.2022.01.06.16.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 16:14:09 -0800 (PST)
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
Subject: [PATCH v2 5/9] mtd: rawnand: brcmnand: Allow working without interrupts
Date:   Thu,  6 Jan 2022 16:13:24 -0800
Message-Id: <20220107001328.2233896-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107001328.2233896-1-f.fainelli@gmail.com>
References: <20220107001328.2233896-1-f.fainelli@gmail.com>
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
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 54 +++++++++++-------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index eb3f96489f83..08e2acde5133 100644
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
@@ -3144,35 +3144,29 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
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
-		if (brcmnand_soc_has_ops(soc))
-			static_branch_enable(&brcmnand_soc_has_ops_key);
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

