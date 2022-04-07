Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E24F7E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbiDGLqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiDGLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B018EE8B;
        Thu,  7 Apr 2022 04:44:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 408571F4613B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331882;
        bh=elCTgW/bDeAM8ZYb0VUA+4o6cBPZmbatIqqr/TpgbmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7XrNpG+TTDQByXjulDuy2gsiT8SkeY/hLf7kZu1skwHOTG29XRlaejUwLJYuJskC
         U7Ijk6pz9szAkcMT9sw5dppq+A8gdHffs3nqNfwvXhaqcFSYEjSjBzA0fe556fKje4
         Kww61B23oTMwRaDNUzu2/kTxmPvqylXmGyipKOxK9Wu6BW4V010QFDJebWK+f1mCMS
         r30mTK/aF2OCfgQ8Ce8+mbFv95dMIgeupAbkmM5GeMGQ/Msy+pMSlBU2m6lOJE/02b
         jZN8cYJcqlS0sXMRAZvK/o/moW4hxL/yLUE1Z2Akm/dJzvSPm07oQinewS8+zVYSdh
         8e+o5a/BA9qjg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/8] spi: mt65xx: Switch to device_get_match_data()
Date:   Thu,  7 Apr 2022 13:44:22 +0200
Message-Id: <20220407114428.167091-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
References: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
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
index 4c84b67ac85c..4e0b520f9abe 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1084,7 +1084,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mtk_spi *mdata;
-	const struct of_device_id *of_id;
 	int i, irq, ret, addr_bits;
 
 	master = devm_spi_alloc_master(&pdev->dev, sizeof(*mdata));
@@ -1105,14 +1104,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
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

