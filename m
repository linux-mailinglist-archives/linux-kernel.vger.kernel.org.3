Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BF4F5FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiDFNVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiDFNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:21:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1362E2BB;
        Wed,  6 Apr 2022 03:04:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 33D671F4390A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649239455;
        bh=gM01YsWssret3DlcqnhTF/BtXnVC04+x5ElT1IRlgI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0Q2tgsEVRMehpz2ney99idFvFBsLsJ4hn/p10FpAd94AjaDo+5PgPuPM75nJB7yS
         rv9agYGWf73Gmh0/CL01QY5iisR2T8n/oT5dDSiU6FUYVo4MkFfNEXzPI15jlin6yy
         wg+vwxbesA4ZNzDB7rFfnyeI3umSWY48GBJC7V0DBaFg8YfzB4+54+CrOh9sAWzRhI
         nLhhfN8mVgTN40Ktfb3flGpMRn/mJ+tvt4iN9oCu7SadI6NodLUK7qf0+ZRuOZ5JnQ
         /c4SocUpWZuwq+zAFrN+Am0DfoPvf4VHFSpHs/AQtD16u1Ct1dbXXW/5tlaOZgBzLW
         lrX3oVREHgekw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/7] spi: mt65xx: Switch to device_get_match_data()
Date:   Wed,  6 Apr 2022 12:04:04 +0200
Message-Id: <20220406100409.93113-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
References: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
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

Instead of performing yet another match check in the probe function,
simply switch to device_get_match_data().
This is a cleanup and brings no functional change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4f53c3446bc0..e3f3b77960ae 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -791,7 +791,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mtk_spi *mdata;
-	const struct of_device_id *of_id;
 	int i, irq, ret, addr_bits;
 
 	master = devm_spi_alloc_master(&pdev->dev, sizeof(*mdata));
@@ -812,14 +811,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->set_cs_timing = mtk_spi_set_hw_cs_timing;
 	master->use_gpio_descriptors = true;
 
-	of_id = of_match_node(mtk_spi_of_match, pdev->dev.of_node);
-	if (!of_id) {
-		dev_err(&pdev->dev, "failed to probe of_node\n");
-		return -EINVAL;
-	}
-
 	mdata = spi_master_get_devdata(master);
-	mdata->dev_comp = of_id->data;
+	mdata->dev_comp = device_get_match_data(&pdev->dev);
 
 	if (mdata->dev_comp->enhance_timing)
 		master->mode_bits |= SPI_CS_HIGH;
-- 
2.35.1

