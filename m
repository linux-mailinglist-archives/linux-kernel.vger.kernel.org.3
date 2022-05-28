Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75E5536AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355809AbiE1E5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355784AbiE1E4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:56:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F911907C;
        Fri, 27 May 2022 21:56:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e23-20020a17090ac21700b001e2a1990a0eso509716pjt.1;
        Fri, 27 May 2022 21:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vS4AVAykN00lSPb+kPZl7bVSk819yTBxiZyWxMDTC/Q=;
        b=JIOB/8vekBtJkwdEIkr0MuR0Usd4wFJ/oGfBiqggXT2S7u/qY/smDjkMgm7rDBZ0e+
         CnxVqOIZO41aBPcUMeO6QBPFHy5jIKCKzreUX+aCg3jRY9Erdnw00DsjM6bSUmCXxQZF
         Mp36QvfvhMlTRmAmMs85KWROu3pezIK8ElWYIZEb96IAtliFOsoTFB1bxZtrFTyIxYat
         l3mUk3xHLCVJplxgR1wuL0zcmioqGJ1pv/nMLIXhAS5lorwFHh21lppknWon7oPazj6Z
         xhG/OCleOf+NOTnKiyOYngdNqn7LuWrHeJQuEb7pJYjoaKK3ZKVQYjb59bwdOiW73CFj
         WNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vS4AVAykN00lSPb+kPZl7bVSk819yTBxiZyWxMDTC/Q=;
        b=AnshIs8bUK3lvMLQxQMTrhXDCtND26Hzp3zIwqeagUhTVc/mgyXvwVcwql5xIW+1a+
         iUTjJCkQrnfzEBf9Tt9kdTG3AiHoIYo8tE4CY2edawrGR6Hzaj9kPlzPLRzEDi7ApPI/
         BI997ph7qZNZAABj1veZR0+VvBFI44+Je5xNxmnmjQlCvm70ApL3KGxJ38NHTQEHu15b
         GrraNa3KXTdBawQoQuu4BJJcIUj+KCIxjmxhwm1R4TQotbosAs/woDtUCFNftkKbuVq6
         8uOCDF3NSqummFQrBANKs0MJi1w0tGZPGROGT7kT4JNRaMjKp5aaraszFT6gTp5hWCEn
         d7Qw==
X-Gm-Message-State: AOAM530yceG/MvjFf8qR5s92AknY4ecCBYh+OUWfA2HqeoJZOS4VAAUK
        H3eSvNOrAoD1qwrm+YR/kgediHzrDN8=
X-Google-Smtp-Source: ABdhPJzC4aSbOzCIv2MOu6SiOIicgihgve79RNrbzbPrIwD4eAmJRBVs2ylVbRMIBGr9qAOGv3GUrw==
X-Received: by 2002:a17:902:c612:b0:161:e095:8ff6 with SMTP id r18-20020a170902c61200b00161e0958ff6mr43403488plr.145.1653713799278;
        Fri, 27 May 2022 21:56:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:331d:9bef:6841:67a4])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001620960f1dfsm4594202plh.198.2022.05.27.21.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 21:56:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Hennerich <michael.hennerich@analog.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Input: adp5588-keys - switch to using managed resources
Date:   Fri, 27 May 2022 21:56:30 -0700
Message-Id: <20220528045631.289821-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies error handling in probe() and reduces amount of explicit
code in remove().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/adp5588-keys.c | 111 +++++++++++---------------
 1 file changed, 45 insertions(+), 66 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index ac21873ba1d7..df84a2998ed2 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -182,6 +182,21 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
 	return n_unused;
 }
 
+static void adp5588_gpio_do_teardown(void *_kpad)
+{
+	struct adp5588_kpad *kpad = _kpad;
+	struct device *dev = &kpad->client->dev;
+	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
+	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
+	int error;
+
+	error = gpio_data->teardown(kpad->client,
+				    kpad->gc.base, kpad->gc.ngpio,
+				    gpio_data->context);
+	if (error)
+		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
+}
+
 static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	struct device *dev = &kpad->client->dev;
@@ -198,8 +213,6 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 		return 0;
 	}
 
-	kpad->export_gpio = true;
-
 	kpad->gc.direction_input = adp5588_gpio_direction_input;
 	kpad->gc.direction_output = adp5588_gpio_direction_output;
 	kpad->gc.get = adp5588_gpio_get_value;
@@ -213,9 +226,9 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 
 	mutex_init(&kpad->gpio_lock);
 
-	error = gpiochip_add_data(&kpad->gc, kpad);
+	error = devm_gpiochip_add_data(dev, &kpad->gc, kpad);
 	if (error) {
-		dev_err(dev, "gpiochip_add failed, err: %d\n", error);
+		dev_err(dev, "gpiochip_add failed: %d\n", error);
 		return error;
 	}
 
@@ -230,41 +243,24 @@ static int adp5588_gpio_add(struct adp5588_kpad *kpad)
 					 kpad->gc.base, kpad->gc.ngpio,
 					 gpio_data->context);
 		if (error)
-			dev_warn(dev, "setup failed, %d\n", error);
+			dev_warn(dev, "setup failed: %d\n", error);
 	}
 
-	return 0;
-}
-
-static void adp5588_gpio_remove(struct adp5588_kpad *kpad)
-{
-	struct device *dev = &kpad->client->dev;
-	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
-	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
-	int error;
-
-	if (!kpad->export_gpio)
-		return;
-
 	if (gpio_data->teardown) {
-		error = gpio_data->teardown(kpad->client,
-					    kpad->gc.base, kpad->gc.ngpio,
-					    gpio_data->context);
+		error = devm_add_action(dev, adp5588_gpio_do_teardown, kpad);
 		if (error)
-			dev_warn(dev, "teardown failed %d\n", error);
+			dev_warn(dev, "failed to schedule teardown: %d\n",
+				 error);
 	}
 
-	gpiochip_remove(&kpad->gc);
+	return 0;
 }
+
 #else
 static inline int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	return 0;
 }
-
-static inline void adp5588_gpio_remove(struct adp5588_kpad *kpad)
-{
-}
 #endif
 
 static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
@@ -510,21 +506,20 @@ static int adp5588_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
-	input = input_allocate_device();
-	if (!kpad || !input) {
-		error = -ENOMEM;
-		goto err_free_mem;
-	}
+	kpad = devm_kzalloc(&client->dev, sizeof(*kpad), GFP_KERNEL);
+	if (!kpad)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!input)
+		return -ENOMEM;
 
 	kpad->client = client;
 	kpad->input = input;
 
 	ret = adp5588_read(client, DEV_ID);
-	if (ret < 0) {
-		error = ret;
-		goto err_free_mem;
-	}
+	if (ret < 0)
+		return ret;
 
 	revid = (u8) ret & ADP5588_DEVICE_ID_MASK;
 	if (WA_DELAYED_READOUT_REVID(revid))
@@ -532,7 +527,6 @@ static int adp5588_probe(struct i2c_client *client,
 
 	input->name = client->name;
 	input->phys = "adp5588-keys/input0";
-	input->dev.parent = &client->dev;
 
 	input_set_drvdata(input, kpad);
 
@@ -569,58 +563,43 @@ static int adp5588_probe(struct i2c_client *client,
 
 	error = input_register_device(input);
 	if (error) {
-		dev_err(&client->dev, "unable to register input device\n");
-		goto err_free_mem;
+		dev_err(&client->dev, "unable to register input device: %d\n",
+			error);
+		return error;
 	}
 
-	error = request_threaded_irq(client->irq,
-				     adp5588_hard_irq, adp5588_thread_irq,
-				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				     client->dev.driver->name, kpad);
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  adp5588_hard_irq, adp5588_thread_irq,
+					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					  client->dev.driver->name, kpad);
 	if (error) {
-		dev_err(&client->dev, "irq %d busy?\n", client->irq);
-		goto err_unreg_dev;
+		dev_err(&client->dev, "failed to request irq %d: %d\n",
+			client->irq, error);
+		return error;
 	}
 
 	error = adp5588_setup(client);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	if (kpad->gpimapsize)
 		adp5588_report_switch_state(kpad);
 
 	error = adp5588_gpio_add(kpad);
 	if (error)
-		goto err_free_irq;
+		return error;
 
 	device_init_wakeup(&client->dev, 1);
-	i2c_set_clientdata(client, kpad);
 
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
-
- err_free_irq:
-	free_irq(client->irq, kpad);
- err_unreg_dev:
-	input_unregister_device(input);
-	input = NULL;
- err_free_mem:
-	input_free_device(input);
-	kfree(kpad);
-
-	return error;
 }
 
 static int adp5588_remove(struct i2c_client *client)
 {
-	struct adp5588_kpad *kpad = i2c_get_clientdata(client);
-
 	adp5588_write(client, CFG, 0);
-	free_irq(client->irq, kpad);
-	input_unregister_device(kpad->input);
-	adp5588_gpio_remove(kpad);
-	kfree(kpad);
 
+	/* all resources will be freed by devm */
 	return 0;
 }
 
-- 
2.36.1.124.g0e6072fb45-goog

