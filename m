Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E05A3776
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbiH0Lmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiH0Lmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:42:44 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27555D0E8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 04:42:43 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RuD2oYf3rUoLVRuD3oSO9F; Sat, 27 Aug 2022 13:42:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Aug 2022 13:42:42 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     broonie@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, neil@brown.name, blogic@openwrt.org
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] spi: mt7621: Remove 'clk' from 'struct mt7621_spi'
Date:   Sat, 27 Aug 2022 13:42:40 +0200
Message-Id: <76ed0ef91479498b9a2d5ef539f80851cffdb4ea.1661599671.git.christophe.jaillet@wanadoo.fr>
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

The 'clk' field in 'struct mt7621_spi' is useless, remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-mt7621.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mt7621.c b/drivers/spi/spi-mt7621.c
index 114f98dcae5e..c4cc8e2f85e2 100644
--- a/drivers/spi/spi-mt7621.c
+++ b/drivers/spi/spi-mt7621.c
@@ -55,7 +55,6 @@ struct mt7621_spi {
 	void __iomem		*base;
 	unsigned int		sys_freq;
 	unsigned int		speed;
-	struct clk		*clk;
 	int			pending_write;
 };
 
@@ -361,9 +360,8 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 
 	rs = spi_controller_get_devdata(master);
 	rs->base = base;
-	rs->clk = clk;
 	rs->master = master;
-	rs->sys_freq = clk_get_rate(rs->clk);
+	rs->sys_freq = clk_get_rate(clk);
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-- 
2.34.1

