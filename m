Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB14537020
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiE2HH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 03:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiE2HHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:07:51 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F688CB11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:07:48 -0700 (PDT)
Received: from pop-os.home ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id vD1cnY8S35ohRvD1cnA1jP; Sun, 29 May 2022 09:07:47 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 29 May 2022 09:07:47 +0200
X-ME-IP: 90.11.191.102
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        addy ke <addy.ke@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@linaro.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] spi: rockchip: Fix a resource that is put twice in rockchip_spi_remove()
Date:   Sun, 29 May 2022 09:07:43 +0200
Message-Id: <df2f4ae902474574ccdb0a8696ce51db39fbd239.1653808056.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
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

spi_controller_put() is already called as part of
spi_unregister_controller(). The latter is called automatically because
the controller has been registered with the devm_ function.

Remove the duplicate call.

Fixes: 64e36824b32b ("spi/rockchip: add driver for Rockchip RK3xxx SoCs integrated SPI")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a08215eb9e14..70777731b20e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -963,8 +963,6 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	if (ctlr->dma_rx)
 		dma_release_channel(ctlr->dma_rx);
 
-	spi_controller_put(ctlr);
-
 	return 0;
 }
 
-- 
2.34.1

