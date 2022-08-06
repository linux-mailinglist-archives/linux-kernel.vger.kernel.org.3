Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16EA58B3F1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 07:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiHFFij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiHFFig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 01:38:36 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6212140F1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 22:38:34 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KCW8oBsZYPMmaKCW8o8cFN; Sat, 06 Aug 2022 07:38:33 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 07:38:33 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org
Subject: [PATCH] leds: pwm-multicolor: Simplify some error message
Date:   Sat,  6 Aug 2022 07:38:30 +0200
Message-Id: <d6cdd8ce642be2a2737d6c1ac16653f2e79831d8.1659764274.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already prints the error code in a human readable way, so
there is no need to duplicate it as a numerical value at the end of the
message.

Fixes: 9fa2762110dd ("usb: common: usb-conn-gpio: use dev_err_probe() to print log")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is also likely that there should be "goto release_mcnode;" instead of a
direct return.
I've not been able to fully track it down, so I leave it as-is.
---
 drivers/leds/rgb/leds-pwm-multicolor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/rgb/leds-pwm-multicolor.c b/drivers/leds/rgb/leds-pwm-multicolor.c
index da9d2218ae18..454afa00735c 100644
--- a/drivers/leds/rgb/leds-pwm-multicolor.c
+++ b/drivers/leds/rgb/leds-pwm-multicolor.c
@@ -158,8 +158,8 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 	ret = led_pwm_mc_set(cdev, cdev->brightness);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-				     "failed to set led PWM value for %s: %d",
-				     cdev->name, ret);
+				     "failed to set led PWM value for %s",
+				     cdev->name);
 
 	platform_set_drvdata(pdev, priv);
 	return 0;
-- 
2.34.1

