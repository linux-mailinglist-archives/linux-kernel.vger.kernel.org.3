Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6E4D36A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiCIQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiCIQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:23 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26962E0AD1;
        Wed,  9 Mar 2022 08:23:40 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 14F851BF20D;
        Wed,  9 Mar 2022 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TC37O2ric69U3FFRyq2ia8q71I6rWSh/IoFJaPBo2tc=;
        b=S1M86rLkfIKWGmyTYxs9hx081iIDlL5XVRsP4yRzkSWFXG5cEUfKh2o9QoGm2lMfg6Zz7h
        V553CB6j5u+uDuM7nbK2CgNB2XC2j6ai1dKdwyQfmpNaV7dT/1Q9pKCZi8D6DK8nkquw+2
        mxfs9WBrRIuTp8I4EDOrvy/9+bOWlT1HXTFQ4fBqFIyMCxdalt30VxjnQtNRpzAKWF/61n
        Z0huTXx5QqVWI+l2TjkRXrq8DcBJM9nfMRN0skUul73E1FQJuCxoXv61DzH/jg3o2YOGsm
        a10qURi0QPNjlfplNPK43Qwi9vrbqP36Ph4oah4j00H0oOzGY2vnQPd9tetozQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/29] rtc: hym8563: switch to devm_rtc_allocate_device
Date:   Wed,  9 Mar 2022 17:22:56 +0100
Message-Id: <20220309162301.61679-25-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-hym8563.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 0751cae27285..ce4cbf0f48e7 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -523,6 +523,10 @@ static int hym8563_probe(struct i2c_client *client,
 	if (!hym8563)
 		return -ENOMEM;
 
+	hym8563->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(hym8563->rtc))
+		return PTR_ERR(hym8563->rtc);
+
 	hym8563->client = client;
 	i2c_set_clientdata(client, hym8563);
 
@@ -557,11 +561,7 @@ static int hym8563_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "rtc information is %s\n",
 		(ret & HYM8563_SEC_VL) ? "invalid" : "valid");
 
-	hym8563->rtc = devm_rtc_device_register(&client->dev, client->name,
-						&hym8563_rtc_ops, THIS_MODULE);
-	if (IS_ERR(hym8563->rtc))
-		return PTR_ERR(hym8563->rtc);
-
+	hym8563->rtc->ops = &hym8563_rtc_ops;
 	/* the hym8563 alarm only supports a minute accuracy */
 	hym8563->rtc->uie_unsupported = 1;
 
@@ -569,7 +569,7 @@ static int hym8563_probe(struct i2c_client *client,
 	hym8563_clkout_register_clk(hym8563);
 #endif
 
-	return 0;
+	return devm_rtc_register_device(hym8563->rtc);
 }
 
 static const struct i2c_device_id hym8563_id[] = {
-- 
2.35.1

