Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD14D37AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiCIQh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiCIQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EF9DCE07;
        Wed,  9 Mar 2022 08:23:36 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3CD80240003;
        Wed,  9 Mar 2022 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1v8hoEMEPlpmNJSzmlXHIwdl3V5o7G8xMhECs9EIvM=;
        b=poGiOXCwGlvoMhV7VbU1v92bZuHnzzilvQU8JhLEAp8Bn9qMhrXWW9eA4E07HHNSvUaBh4
        9ASh8wTtWpcMl7ysUfDo6e7BEIGarzFkCwT2TnSu4YyVYRWIZrORHp7DzfnVQwmnJesu7v
        3CyyU3AheWaDOE7zjxPby7FzaOWGijK5Epz49sn4VhOV3vylCERf5h4xnoehlzKprDTWOY
        2bCiEV6/BuVS6Z8VC1ULlsk3yepSO9io8nC7A9XtBk1VPtVHhYLOgwQh//5tktGnHSm8IO
        Qztsg3533tg1Hm145/ubAHr/UOWAURqnJCuj8T4H0kaCI3p5HPJFuYwEcqt6Xw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/29] rtc: spear: switch to devm_rtc_allocate_device
Date:   Wed,  9 Mar 2022 17:22:49 +0100
Message-Id: <20220309162301.61679-18-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_rtc_allocate_device/devm_rtc_register_device, this allows
for further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-spear.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index b4a520056b1a..1b40380aaba2 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -352,6 +352,10 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	if (!config)
 		return -ENOMEM;
 
+	config->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(config->rtc))
+		return PTR_ERR(config->rtc);
+
 	/* alarm irqs */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -380,17 +384,13 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	spin_lock_init(&config->lock);
 	platform_set_drvdata(pdev, config);
 
-	config->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-					&spear_rtc_ops, THIS_MODULE);
-	if (IS_ERR(config->rtc)) {
-		dev_err(&pdev->dev, "can't register RTC device, err %ld\n",
-				PTR_ERR(config->rtc));
-		status = PTR_ERR(config->rtc);
-		goto err_disable_clock;
-	}
-
+	config->rtc->ops = &spear_rtc_ops;
 	config->rtc->uie_unsupported = 1;
 
+	status = devm_rtc_register_device(config->rtc);
+	if (status)
+		goto err_disable_clock;
+
 	if (!device_can_wakeup(&pdev->dev))
 		device_init_wakeup(&pdev->dev, 1);
 
-- 
2.35.1

