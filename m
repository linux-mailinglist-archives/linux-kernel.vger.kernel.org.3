Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91673536ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355798AbiE1E4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355782AbiE1E4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:56:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F7119938;
        Fri, 27 May 2022 21:56:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h186so5572851pgc.3;
        Fri, 27 May 2022 21:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUH1+N4MNz3r+yWNDEP4UwHVdb0y0yxcscWXD8m5LCk=;
        b=GX/GIuIvbXKq92MEjY60vQ02XUf6RSRkJ8p0ta3K2ZDV/xEjuS0H6GuxG5Ua80uoOx
         z8PWedbKQxumWlEfPh4krG7MlOsWc/wOI2PQvzFDWCiMtaz4ZGqCmE16UPK0EJfMTxxS
         L5C5gomwYo4YYbVQpJWtGL0acSOVPA6VE8AZvtc8SMqaRiymC85LqmSXIuEi+fKTpkwP
         5YPfGZovW4O22yk1mRimX6YKF3geXf6SfuV4Dw9+LzWTllmhD6mKCCsVMqRRDlwdWSjI
         AFZ8d/1AQGlD0mBkGeXORiRyciahKslKHAMfdVIaGMLFvVPVAbMsAzGzGkpiZbkpd0Tw
         lC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUH1+N4MNz3r+yWNDEP4UwHVdb0y0yxcscWXD8m5LCk=;
        b=X/klVx1qbA3pO6Ck8ZRevXVwEPhX8xl5LDng2/vVPjCH+T1mt6yfMXtx3a+uBtR8WY
         KqVDnrFcPF4wO7VkcMran1oVzP0+9OkxS8JVA7K1rtEICVFsEc+U+wyAHL/CSnxUNucl
         7/PBs60kM9nlte2pIIO1LAO0XMk2qB+shDHQQ+d80cYjFpEl0MCztLAlqIoklfVtl1WQ
         UmeAtYTo4p+uP0K+c9DfA7UZ+ZSrauw0XMjDTQ0mJ9L0c/coVtJvEvSZCrMN7Ga21Brh
         1e49vQWD3Y+eW+qcj854tYrw7Xm3P7jbENjRjkS1OaPDjbfTtXvliKiYj0O1p+uNrNsn
         qNCA==
X-Gm-Message-State: AOAM532mF1t4iOy7ILw6EfG/EwA8E8c19cOSyq85iNStICW7oTX8VO+j
        lZhmNbOnYa2FgCaQVqChpU4=
X-Google-Smtp-Source: ABdhPJx8Q01eKIoMpeLgctAZ7Q1VrFugb/BSCvVW7aDulky0QmiPsua1wKLn//870I4wv1lN99ZzCQ==
X-Received: by 2002:aa7:939a:0:b0:518:9843:86cb with SMTP id t26-20020aa7939a000000b00518984386cbmr30101346pfe.37.1653713797639;
        Fri, 27 May 2022 21:56:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:331d:9bef:6841:67a4])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001620960f1dfsm4594202plh.198.2022.05.27.21.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 21:56:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Hennerich <michael.hennerich@analog.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Input: adp5588-keys - switch to using threaded interrupt
Date:   Fri, 27 May 2022 21:56:29 -0700
Message-Id: <20220528045631.289821-2-dmitry.torokhov@gmail.com>
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

Instead of using hard interrupt handler and manually scheduling work
item to handle I2C communications, let's switch to threaded interrupt
handling.

While at that enforce the readout delay required on pre- revision 4
silicon.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/adp5588-keys.c | 81 +++++++++++++++------------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index ea67d0834be1..ac21873ba1d7 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -8,17 +8,19 @@
  * Copyright (C) 2008-2010 Analog Devices Inc.
  */
 
-#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/errno.h>
-#include <linux/pm.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/i2c.h>
-#include <linux/gpio/driver.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 #include <linux/platform_data/adp5588.h>
 
@@ -36,11 +38,12 @@
  * asserted.
  */
 #define WA_DELAYED_READOUT_REVID(rev)		((rev) < 4)
+#define WA_DELAYED_READOUT_TIME			25
 
 struct adp5588_kpad {
 	struct i2c_client *client;
 	struct input_dev *input;
-	struct delayed_work work;
+	ktime_t irq_time;
 	unsigned long delay;
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
 	const struct adp5588_gpi_map *gpimap;
@@ -289,13 +292,36 @@ static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 	}
 }
 
-static void adp5588_work(struct work_struct *work)
+static irqreturn_t adp5588_hard_irq(int irq, void *handle)
+{
+	struct adp5588_kpad *kpad = handle;
+
+	kpad->irq_time = ktime_get();
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t adp5588_thread_irq(int irq, void *handle)
 {
-	struct adp5588_kpad *kpad = container_of(work,
-						struct adp5588_kpad, work.work);
+	struct adp5588_kpad *kpad = handle;
 	struct i2c_client *client = kpad->client;
+	ktime_t target_time, now;
+	unsigned long delay;
 	int status, ev_cnt;
 
+	/*
+	 * Readout needs to wait for at least 25ms after the notification
+	 * for REVID < 4.
+	 */
+	if (kpad->delay) {
+		target_time = ktime_add_ms(kpad->irq_time, kpad->delay);
+		now = ktime_get();
+		if (ktime_before(now, target_time)) {
+			delay = ktime_to_us(ktime_sub(target_time, now));
+			usleep_range(delay, delay + 1000);
+		}
+	}
+
 	status = adp5588_read(client, INT_STAT);
 
 	if (status & ADP5588_OVR_FLOW_INT)	/* Unlikely and should never happen */
@@ -308,20 +334,8 @@ static void adp5588_work(struct work_struct *work)
 			input_sync(kpad->input);
 		}
 	}
-	adp5588_write(client, INT_STAT, status); /* Status is W1C */
-}
 
-static irqreturn_t adp5588_irq(int irq, void *handle)
-{
-	struct adp5588_kpad *kpad = handle;
-
-	/*
-	 * use keventd context to read the event fifo registers
-	 * Schedule readout at least 25ms after notification for
-	 * REVID < 4
-	 */
-
-	schedule_delayed_work(&kpad->work, kpad->delay);
+	adp5588_write(client, INT_STAT, status); /* Status is W1C */
 
 	return IRQ_HANDLED;
 }
@@ -505,7 +519,6 @@ static int adp5588_probe(struct i2c_client *client,
 
 	kpad->client = client;
 	kpad->input = input;
-	INIT_DELAYED_WORK(&kpad->work, adp5588_work);
 
 	ret = adp5588_read(client, DEV_ID);
 	if (ret < 0) {
@@ -515,7 +528,7 @@ static int adp5588_probe(struct i2c_client *client,
 
 	revid = (u8) ret & ADP5588_DEVICE_ID_MASK;
 	if (WA_DELAYED_READOUT_REVID(revid))
-		kpad->delay = msecs_to_jiffies(30);
+		kpad->delay = msecs_to_jiffies(WA_DELAYED_READOUT_TIME);
 
 	input->name = client->name;
 	input->phys = "adp5588-keys/input0";
@@ -560,9 +573,10 @@ static int adp5588_probe(struct i2c_client *client,
 		goto err_free_mem;
 	}
 
-	error = request_irq(client->irq, adp5588_irq,
-			    IRQF_TRIGGER_FALLING,
-			    client->dev.driver->name, kpad);
+	error = request_threaded_irq(client->irq,
+				     adp5588_hard_irq, adp5588_thread_irq,
+				     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				     client->dev.driver->name, kpad);
 	if (error) {
 		dev_err(&client->dev, "irq %d busy?\n", client->irq);
 		goto err_unreg_dev;
@@ -587,7 +601,6 @@ static int adp5588_probe(struct i2c_client *client,
 
  err_free_irq:
 	free_irq(client->irq, kpad);
-	cancel_delayed_work_sync(&kpad->work);
  err_unreg_dev:
 	input_unregister_device(input);
 	input = NULL;
@@ -604,7 +617,6 @@ static int adp5588_remove(struct i2c_client *client)
 
 	adp5588_write(client, CFG, 0);
 	free_irq(client->irq, kpad);
-	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
 	adp5588_gpio_remove(kpad);
 	kfree(kpad);
@@ -614,11 +626,9 @@ static int adp5588_remove(struct i2c_client *client)
 
 static int __maybe_unused adp5588_suspend(struct device *dev)
 {
-	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
-	struct i2c_client *client = kpad->client;
+	struct i2c_client *client = to_i2c_client(dev);
 
 	disable_irq(client->irq);
-	cancel_delayed_work_sync(&kpad->work);
 
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(client->irq);
@@ -628,8 +638,7 @@ static int __maybe_unused adp5588_suspend(struct device *dev)
 
 static int __maybe_unused adp5588_resume(struct device *dev)
 {
-	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
-	struct i2c_client *client = kpad->client;
+	struct i2c_client *client = to_i2c_client(dev);
 
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(client->irq);
-- 
2.36.1.124.g0e6072fb45-goog

