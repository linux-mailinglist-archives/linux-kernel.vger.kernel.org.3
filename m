Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2744EB025
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiC2PYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiC2PYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:24:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF921C04D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:22:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1BDE81F426BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648567373;
        bh=1LY9QgdlXhZN0ZJtVH71yykyQQc/7fSR67bBdC4ee0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPLrlly/RZOVYUL7J2NURkqWyGjULbYbq3aDWnd/zGhoI8DhCs7KH50NE3jn/FGy5
         oGXEDgF9dWYCE8RXL3Ma0op0lw+FokADB/aokLce9LewUlsoYT1/qNmEbG9pnwMQxc
         7yP0G8kL3vP/rhYEFPD753GhWtASP4c31xgylS0hvfatUJs1HiUw2N2X1P1a+hl5Tu
         XoAOoVdAY9neSQxUNR+b4qfZmMYWV+Z2li45JEMNoTU1IU6HGlYwJBoo56/EETH2VB
         gFHS6rtTu3XE1RLMDCwLVPKtSZii4k+M8yxxU8wba6zDoMqXodTTHjO0m4EecSvHrH
         DKRT9Pw0Wg32A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/3] soc: mediatek: pwrap: Move and check return value of platform_get_irq()
Date:   Tue, 29 Mar 2022 17:22:45 +0200
Message-Id: <20220329152245.124341-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329152245.124341-1-angelogioacchino.delregno@collabora.com>
References: <20220329152245.124341-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the call to platform_get_irq() earlier in the probe function
and check for its return value: if no interrupt is specified, it
wouldn't make sense to try to call devm_request_irq() so, in that
case, we can simply return early.

Moving the platform_get_irq() call also makes it possible to use
one less goto, as clocks aren't required at that stage.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 755b8d00faa9..72d82fe2e230 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2204,6 +2204,10 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (!wrp)
 		return -ENOMEM;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
 	platform_set_drvdata(pdev, wrp);
 
 	wrp->master = of_device_get_match_data(&pdev->dev);
@@ -2316,7 +2320,6 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
 		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
 
-	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
 			       IRQF_TRIGGER_HIGH,
 			       "mt-pmic-pwrap", wrp);
-- 
2.35.1

