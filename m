Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30CA557A21
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiFWMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiFWMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:17:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229B48E53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:17:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22D4C6601796;
        Thu, 23 Jun 2022 13:17:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655986627;
        bh=IFxufIm2FN/Q4bUBSE7JH5HyUplkq4cWqYjYWUmz20M=;
        h=From:To:Cc:Subject:Date:From;
        b=ROs6d7MIaj5c/U6ziom9OyNz9w3oikPjy1ayTFI6lXxRWmI8671R+xv4V+GoGzGcL
         r8CuiCx9aFTf9IBTy0B/WRYm2c2JN+sM/7gA9xfXbEv3fpkvHtAjP6F/7rMYalNVYT
         VFz9pmSyNg8JsDXsGt6EqQgygBKDdiUIVyMR/rVp23lo58DVG3yhzj4SBl7N2GiEA8
         JLM25ZrH3UJcx0EDgXx1XIsIGzyjwgjomA4AyGrm4eP0amXSNDvE8TJnDfga4P63Dn
         Shmvn47gjUDD7Ei1ReFjP0o95eDYzP7hyQmJpILTsXgHQhnCq/1URBu9IMZlM07S0d
         8jOXdt3mP//8A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] soc: mediatek: mutex: Simplify with devm_platform_get_and_ioremap_resource()
Date:   Thu, 23 Jun 2022 14:17:01 +0200
Message-Id: <20220623121701.107512-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

While at it, also remove a redundant call to of_address_to_resource(),
as this was getting the address of the same resource index 0: we can
as well get the iostart from the 'regs' pointer.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 60cbafea577e..ca8440fb48cd 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -787,7 +787,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_mutex_ctx *mtx;
-	struct resource *regs, addr;
+	struct resource *regs;
 	int i;
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	int ret;
@@ -811,11 +811,12 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (of_address_to_resource(dev->of_node, 0, &addr) < 0) {
-		dev_err(dev, "Failed to get addr\n");
-		return -EINVAL;
+	mtx->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mtx->regs)) {
+		dev_err(dev, "Failed to map mutex registers\n");
+		return PTR_ERR(mtx->regs);
 	}
-	mtx->addr = addr.start;
+	mtx->addr = regs->start;
 
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	ret = cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0);
@@ -823,13 +824,6 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
 #endif
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mtx->regs = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(mtx->regs)) {
-		dev_err(dev, "Failed to map mutex registers\n");
-		return PTR_ERR(mtx->regs);
-	}
-
 	platform_set_drvdata(pdev, mtx);
 
 	return 0;
-- 
2.35.1

