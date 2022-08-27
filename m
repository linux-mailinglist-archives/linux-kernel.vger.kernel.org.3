Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1B5A3771
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiH0Lmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbiH0Lmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:42:35 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23045E315
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:42:34 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RuCroZ8bM5V1hRuCsopt76; Sat, 27 Aug 2022 13:42:33 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Aug 2022 13:42:33 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, neil@brown.name, blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] spi: mt7621: Use devm_spi_register_controller()
Date:   Sat, 27 Aug 2022 13:42:29 +0200
Message-Id: <b7698e198acc998d99e7e7c895a2910f14f89443.1661599671.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_disable_unprepare(clk) is handled with a managed resource,
we can use devm_spi_register_controller() and axe the .remove function.

The order between spi_unregister_controller() and clk_disable_unprepare()
is still the same.
(see commit 46b5c4fb87ce ("spi: mt7621: Don't leak SPI master in probe
error path") to see why it matters)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I guess that the dev_set_drvdata() in the probe can be removed as-well.
But it is also harmless to leave it as-is.
---
 drivers/spi/spi-mt7621.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 2580b28042be..114f98dcae5e 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -373,20 +373,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = spi_register_controller(master);
-
-	return ret;
-}
-
-static int mt7621_spi_remove(struct platform_device *pdev)
-{
-	struct spi_controller *master;
-
-	master = dev_get_drvdata(&pdev->dev);
-
-	spi_unregister_controller(master);
-
-	return 0;
+	return devm_spi_register_controller(&pdev->dev, master);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
@@ -397,7 +384,6 @@ static struct platform_driver mt7621_spi_driver = {
 		.of_match_table = mt7621_spi_match,
 	},
 	.probe = mt7621_spi_probe,
-	.remove = mt7621_spi_remove,
 };
 
 module_platform_driver(mt7621_spi_driver);
-- 
2.34.1

