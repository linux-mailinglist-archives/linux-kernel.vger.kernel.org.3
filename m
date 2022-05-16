Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D052846B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbiEPMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiEPMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:47:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB6538BE3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:47:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6EB611F42F4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652705226;
        bh=5vOHDRqH1zBj4kXu3ekurCYU3ZRxfiqVzKY6haFAxx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDPjBUIrW/eTtO73MVMAKmCZme3fhzCFy/tiY4TYEk1GqoMrDq/mnprQPCN0Tb0kS
         GrdeoAh4lWKUMFnc2X99OS6J8Kk3Yn0I8mkcUe40/XlWDApBOgOnLORUB9ytAoY1wz
         ndLIeo4YbOY/nRE3sq729D0HPa7QHuSkV/ATXYg/3dkNoTTHgwMqgSNvYOt347qnMF
         JFn//ydkPXMn5jCI5JQ/L04GhDSx0GVp5HIAmXMHPS4DZMC/ltncJjRbfE7Z7iWTB4
         Nyk8+RdT7AXoaru6gCXFqUtjGeDTJeluGYVH+onJOe8F4Ch5alEpd+kO6CilECx/IS
         7Hr2xWQVeNnTQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 2/5] soc: mediatek: pwrap: Switch to devm_platform_ioremap_resource_byname()
Date:   Mon, 16 May 2022 14:46:56 +0200
Message-Id: <20220516124659.69484-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In order to simplify ioremapping resources, instead of calling
platform_get_resource_byname() and then devm_ioremap_resource(),
simply call devm_platform_ioremap_resource_byname().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 54a5300ab72b..852514366f1f 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -2191,7 +2191,6 @@ static int pwrap_probe(struct platform_device *pdev)
 	struct pmic_wrapper *wrp;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_slave_id = NULL;
-	struct resource *res;
 
 	if (np->child)
 		of_slave_id = of_match_node(of_slave_match_tbl, np->child);
@@ -2211,8 +2210,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	wrp->slave = of_slave_id->data;
 	wrp->dev = &pdev->dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwrap");
-	wrp->base = devm_ioremap_resource(wrp->dev, res);
+	wrp->base = devm_platform_ioremap_resource_byname(pdev, "pwrap");
 	if (IS_ERR(wrp->base))
 		return PTR_ERR(wrp->base);
 
@@ -2226,9 +2224,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	}
 
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-				"pwrap-bridge");
-		wrp->bridge_base = devm_ioremap_resource(wrp->dev, res);
+		wrp->bridge_base = devm_platform_ioremap_resource_byname(pdev, "pwrap-bridge");
 		if (IS_ERR(wrp->bridge_base))
 			return PTR_ERR(wrp->bridge_base);
 
-- 
2.35.1

