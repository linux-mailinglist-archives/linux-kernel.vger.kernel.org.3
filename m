Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24B95A3774
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiH0Lm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiH0LmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:42:24 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331F5D0F3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:42:23 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RuCioaXfqLFqbRuCioufxe; Sat, 27 Aug 2022 13:42:21 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Aug 2022 13:42:21 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, neil@brown.name, blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] spi: mt7621: Use the devm_clk_get_enabled() helper to simplify error handling
Date:   Sat, 27 Aug 2022 13:42:19 +0200
Message-Id: <05a7fd22719008c8a905d6328aa9548ce40f2a7a.1661599671.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This helper is well suited for cases where the clock would be kept
prepared or enabled for the whole lifetime of the driver.

This simplifies the error handling a lot.

The order between spi_unregister_controller() (in the remove function) and
the clk_disable_unprepare() (now handle by a  managed resource) is kept
the same.
(see commit 46b5c4fb87ce ("spi: mt7621: Don't leak SPI master in probe
error path") to see why it matters)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The order with  devm_spi_release_controller() (which undoes
devm_spi_alloc_master()) is reversed, but I don't think it is an issue.
---
 drivers/spi/spi-mt7621.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 351b0ef52bbc..2580b28042be 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -327,7 +327,6 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	struct spi_controller *master;
 	struct mt7621_spi *rs;
 	void __iomem *base;
-	int status = 0;
 	struct clk *clk;
 	int ret;
 
@@ -339,19 +338,14 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
 				     "unable to get SYS clock\n");
 
-	status = clk_prepare_enable(clk);
-	if (status)
-		return status;
-
 	master = devm_spi_alloc_master(&pdev->dev, sizeof(*rs));
 	if (!master) {
 		dev_info(&pdev->dev, "master allocation failed\n");
-		clk_disable_unprepare(clk);
 		return -ENOMEM;
 	}
 
@@ -376,13 +370,10 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	ret = device_reset(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "SPI reset failed!\n");
-		clk_disable_unprepare(clk);
 		return ret;
 	}
 
 	ret = spi_register_controller(master);
-	if (ret)
-		clk_disable_unprepare(clk);
 
 	return ret;
 }
@@ -390,13 +381,10 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 static int mt7621_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *master;
-	struct mt7621_spi *rs;
 
 	master = dev_get_drvdata(&pdev->dev);
-	rs = spi_controller_get_devdata(master);
 
 	spi_unregister_controller(master);
-	clk_disable_unprepare(rs->clk);
 
 	return 0;
 }
-- 
2.34.1

