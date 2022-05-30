Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC615387B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiE3TZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiE3TZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:25:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726F62AF0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:25:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0h-0002B3-KC; Mon, 30 May 2022 21:25:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0h-005Vcg-R8; Mon, 30 May 2022 21:25:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0f-00D9rr-R5; Mon, 30 May 2022 21:25:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/4] mfd: asic3: Make asic3_gpio_remove() return void
Date:   Mon, 30 May 2022 21:24:27 +0200
Message-Id: <20220530192430.2108217-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; h=from:subject; bh=2vih2xfjYYCBqWvzNoDgwxq/6pFitQWwOd7o14Q+mkA=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSRNlTxn983uV3lqGHtgWaEn+9YV5amHHs8p11eZbrxQKerW geUdnYzGLAyMXAyyYoosdUVaYhMk1vy3K1nCDTOIlQlkCgMXpwBMJDuT/X9+2a6NmVee9ntee8Dxwe EItwavjp5uSttr8/n+ksLtOecdtJ24RbRkXWawh+6V//zleIBjZ0BghIXXc0kJCZstBkf1ZD/9tvgm E6+4J/2f74m8v6Itnz23sDPo+j/q2Z5blcr9NbS2Sf3hjR7tdoYrt28FsvGdlHaZ4aO3Webz7M1ltc unZ1blJoZKLdvHccZR0ien6nCfYhI753vHI2ZsB6adNmvYzM99bfHF5JlH02Q9V287Y6zC8kzbING7 445N3Kpb2lejIsyMUw/OeZ04UTm0XE8x8Ovzo+KJktqzH+67IPklhm1JcxP7Est1ff+PpBnPXXGX9W D5vR/qrlwVnZO1yoSd58ma3m0HAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up to now asic3_gpio_remove() returns zero unconditionally. This makes it
easier to see in the caller that there is no error to handle.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Side note: asic3_mfd_probe() which is called by asic3_probe() could
return an error, but this isn't handled.
---
 drivers/mfd/asic3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 56338f9dbd0b..4fb7e35eb5ed 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -596,12 +596,11 @@ static __init int asic3_gpio_probe(struct platform_device *pdev,
 	return gpiochip_add_data(&asic->gpio, asic);
 }
 
-static int asic3_gpio_remove(struct platform_device *pdev)
+static void asic3_gpio_remove(struct platform_device *pdev)
 {
 	struct asic3 *asic = platform_get_drvdata(pdev);
 
 	gpiochip_remove(&asic->gpio);
-	return 0;
 }
 
 static void asic3_clk_enable(struct asic3 *asic, struct asic3_clk *clk)
@@ -1030,7 +1029,6 @@ static int __init asic3_probe(struct platform_device *pdev)
 
 static int asic3_remove(struct platform_device *pdev)
 {
-	int ret;
 	struct asic3 *asic = platform_get_drvdata(pdev);
 
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
@@ -1038,9 +1036,8 @@ static int asic3_remove(struct platform_device *pdev)
 
 	asic3_mfd_remove(pdev);
 
-	ret = asic3_gpio_remove(pdev);
-	if (ret < 0)
-		return ret;
+	asic3_gpio_remove(pdev);
+
 	asic3_irq_remove(pdev);
 
 	asic3_write_register(asic, ASIC3_OFFSET(CLOCK, SEL), 0);
-- 
2.36.1

