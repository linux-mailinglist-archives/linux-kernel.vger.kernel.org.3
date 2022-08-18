Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02C5598165
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbiHRKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbiHRKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:18:59 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558473DF0A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:18:58 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 27I9xIau030186;
        Thu, 18 Aug 2022 17:59:19 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Aug
 2022 18:18:11 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <andrew@aj.id.au>, <linus.walleij@linaro.org>, <joel@jms.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
Date:   Thu, 18 Aug 2022 18:18:39 +0800
Message-ID: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 27I9xIau030186
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver want to disable the signal of the function, it doesn't
need to query the state of the mux function's signal on a pin. The
condition below will miss the disable of the signal:
Ball | Default | P0 Signal | P0 Expression               | Other
-----+---------+-----------+-----------------------------+----------
 E21   GPIOG0    SD2CLK      SCU4B4[16]=1 & SCU450[1]=1    GPIOG0
-----+---------+-----------+-----------------------------+----------
 B22   GPIOG1    SD2CMD      SCU4B4[17]=1 & SCU450[1]=1    GPIOG1
-----+---------+-----------+-----------------------------+----------
Assume the register status like below:
SCU4B4[16] == 1 & SCU4B4[17] == 1 & SCU450[1]==1
After the driver set the Ball E21 to the GPIOG0:
SCU4B4[16] == 0 & SCU4B4[17] == 1 & SCU450[1]==0
When the driver want to set the Ball B22 to the GPIOG1, the condition of
the SD2CMD will be false causing SCU4B4[17] not to be cleared.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 83d47ff1cea8..a30912a92f05 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -92,19 +92,10 @@ static int aspeed_sig_expr_enable(struct aspeed_pinmux_data *ctx,
 static int aspeed_sig_expr_disable(struct aspeed_pinmux_data *ctx,
 				   const struct aspeed_sig_expr *expr)
 {
-	int ret;
-
 	pr_debug("Disabling signal %s for %s\n", expr->signal,
 		 expr->function);
 
-	ret = aspeed_sig_expr_eval(ctx, expr, true);
-	if (ret < 0)
-		return ret;
-
-	if (ret)
-		return aspeed_sig_expr_set(ctx, expr, false);
-
-	return 0;
+	return aspeed_sig_expr_set(ctx, expr, false);
 }
 
 /**
-- 
2.25.1

