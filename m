Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D14F7E46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiDGLrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244882AbiDGLqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81C190B67;
        Thu,  7 Apr 2022 04:44:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5C32B1F43211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331884;
        bh=U0uqcJjpcnjh+B/OVJZDKx9YUcql4HHA5STN6Sy2OXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tn9FJwpOlEZlS3+SoBO2JOC4RAQ5NVFShxwhWCck32lO42i5RG6VDe+9YYlhvVd2y
         /dh8tTHFQr/Q0qYF00GsxltQjUL9Y8fbtB7hZS/Hs9CyIjPvHdAYzMfjbYEF7iUpzd
         I5yNME5VHUkMAscfktZeCnVgCxtpt8ziPdaT3FosesF+/KqU0qYYp1gEHjL3FkpbRO
         CvbWBusM0OzLwPEC6hgO75rsbjfNFJ5nM2+3na8UwwqinleqKza6NuDpgS8xPEdwnb
         Z9ek2Pslm6qGhuJZZxhAxempNO3Yrd0qkZKpt+FuaPajVuemr81TCoPPlvUPevs25C
         4A9ucu72st5YQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 5/8] spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
Date:   Thu,  7 Apr 2022 13:44:25 +0200
Message-Id: <20220407114428.167091-6-angelogioacchino.delregno@collabora.com>
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

The last goto in the probe function can be removed by calling
pm_runtime_enable() right before devm_spi_register_master(), as
only some init checks were being performed after enabling pm.
This is a cleanup and brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index a2daba3bba91..3f307b25433d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1224,22 +1224,18 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		clk_disable_unprepare(mdata->spi_hclk);
 	}
 
-	pm_runtime_enable(dev);
-
 	if (mdata->dev_comp->need_pad_sel) {
 		if (mdata->pad_num != master->num_chipselect) {
 			dev_err(dev,
 				"pad_num does not match num_chipselect(%d != %d)\n",
 				mdata->pad_num, master->num_chipselect);
-			ret = -EINVAL;
-			goto err_disable_runtime_pm;
+			return -EINVAL;
 		}
 
 		if (!master->cs_gpiods && master->num_chipselect > 1) {
 			dev_err(dev,
 				"cs_gpios not specified and num_chipselect > 1\n");
-			ret = -EINVAL;
-			goto err_disable_runtime_pm;
+			return -EINVAL;
 		}
 	}
 
@@ -1252,18 +1248,16 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		dev_notice(dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
 			   addr_bits, ret);
 
+	pm_runtime_enable(dev);
+
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
+		pm_runtime_disable(dev);
 		dev_err(dev, "failed to register master (%d)\n", ret);
-		goto err_disable_runtime_pm;
+		return ret;
 	}
 
 	return 0;
-
-err_disable_runtime_pm:
-	pm_runtime_disable(dev);
-
-	return ret;
 }
 
 static int mtk_spi_remove(struct platform_device *pdev)
-- 
2.35.1

