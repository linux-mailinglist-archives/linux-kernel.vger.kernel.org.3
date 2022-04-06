Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD024F5F50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiDFNVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiDFNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:21:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC80440681;
        Wed,  6 Apr 2022 03:05:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 81D921F43907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649239457;
        bh=XUxXaare05hfWrZ9x/t+yRjVsjX8d4GEmSTC5zA1iFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L2muotn5s9Yp9A9I2KoCPXK9oM1ZQs4U/ilbTjYmHFiPb08VTpMMYuBGP/z8HtSii
         VZ52j4N8BKPRa5pTyeFokGbo5QYKuS7tluGgM1kSR7eLuK5ujIIbcMHNIcLB+K6pIY
         mqC2ro5QSywgX7c0J/lL7vDb2Omb99NvKhkoGYtjezN5l85n8VmMc7/tTm8dQKERSt
         UFQuGo7hYSEP5TMJ5dZj7OucuyJFcHjrBBDJDCJ8dXJDeQYFVJ13XnNQUtrW08rZ43
         5UIeeCNUSoKEZoj6CUbyf19DBBTge2poGfmS4SmCDRli+rcQDZYVdcAnv1Dwiu6Beo
         6FffnJMr+4cHg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/7] spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
Date:   Wed,  6 Apr 2022 12:04:06 +0200
Message-Id: <20220406100409.93113-5-angelogioacchino.delregno@collabora.com>
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

The last goto in the probe function can be removed by calling
pm_runtime_enable() right before devm_spi_register_master(), as
only some init checks were being performed after enabling pm.
This is a cleanup and brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mt65xx.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 7f381d84a005..b8ec04795141 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -906,22 +906,18 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	else
 		clk_disable_unprepare(mdata->spi_clk);
 
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
 
@@ -934,18 +930,16 @@ static int mtk_spi_probe(struct platform_device *pdev)
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

