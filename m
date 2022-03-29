Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551714EB026
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiC2PYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbiC2PYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:24:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F64207A22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:22:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9688D1F426BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648567373;
        bh=6c/KgMvY7HJBn90Jzacn0twKyDB1AkNzgEYMPrA8qkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXof7AoaFQ2OsLo51YP+KlhHXCFSDhiQxNQJHu5KGLwJkEyvPOpLVhmcTvQX6ESWA
         zib2QHLwsqYM0PAiTfAuu7eVA7Dif0udcAw3UZBu1KOS/QCmAEyyHmFqz8lMfaxDC+
         kwrHkU4pg5o2BZtiOcwY/QCt0Pk+mQGv1FY5UBOkAQSwrvt7oHIMRtL7NhfZjb/uUb
         iGUbWQTaKyCJoicHj/JnS++f1s12wtkhC+jFbdtuQHwUqXwpghRfVkvYlD6MAUW7VX
         uiK/Sh8gZ5S/2eg8R7bOF7orvdoR4BlBA+yUNAaoQ2CglvufH6M3qDmeSTUGW0ZUej
         tLuC7u7Pw53vw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/3] soc: mediatek: pwrap: Switch to devm_platform_ioremap_resource_byname()
Date:   Tue, 29 Mar 2022 17:22:44 +0200
Message-Id: <20220329152245.124341-2-angelogioacchino.delregno@collabora.com>
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

In order to simplify ioremapping resources, instead of calling
platform_get_resource_byname() and then devm_ioremap_resource(),
simply call devm_platform_ioremap_resource_byname().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 8f34b0d6c34e..755b8d00faa9 100644
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

