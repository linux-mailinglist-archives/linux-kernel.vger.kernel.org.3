Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0655059B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiFROwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 10:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiFROwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 10:52:18 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EE217E23
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 07:52:16 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 2Zo6oiD0NYaC72Zo6oysXB; Sat, 18 Jun 2022 16:52:15 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 18 Jun 2022 16:52:15 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: cp2112: Remove some dead code
Date:   Sat, 18 Jun 2022 16:52:12 +0200
Message-Id: <6ee2132c415db2fc90e7fa2106db427a914cc566.1655563907.git.christophe.jaillet@wanadoo.fr>
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

Commit 13de9cca514e ("HID: cp2112: add IRQ chip handling") has introduced
cp2112_allocate_irq() that seems to be unused since 2016.

Remove it, remove the associated resources and part of the remove()
function that frees the resources allocated in cp2112_allocate_irq().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

Maybe the issue is completely elsewhere and the probe() should call
cp2112_allocate_irq() in some cases.
---
 drivers/hid/hid-cp2112.c | 52 ----------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 1e16b0fa310d..67a5ac6be922 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -167,7 +167,6 @@ struct cp2112_device {
 	u8 *in_out_buffer;
 	struct mutex lock;
 
-	struct gpio_desc *desc[8];
 	bool gpio_poll;
 	struct delayed_work gpio_poll_worker;
 	unsigned long irq_mask;
@@ -1183,51 +1182,6 @@ static int cp2112_gpio_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
-static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
-					      int pin)
-{
-	int ret;
-
-	if (dev->desc[pin])
-		return -EINVAL;
-
-	dev->desc[pin] = gpiochip_request_own_desc(&dev->gc, pin,
-						   "HID/I2C:Event",
-						   GPIO_ACTIVE_HIGH,
-						   GPIOD_IN);
-	if (IS_ERR(dev->desc[pin])) {
-		dev_err(dev->gc.parent, "Failed to request GPIO\n");
-		return PTR_ERR(dev->desc[pin]);
-	}
-
-	ret = cp2112_gpio_direction_input(&dev->gc, pin);
-	if (ret < 0) {
-		dev_err(dev->gc.parent, "Failed to set GPIO to input dir\n");
-		goto err_desc;
-	}
-
-	ret = gpiochip_lock_as_irq(&dev->gc, pin);
-	if (ret) {
-		dev_err(dev->gc.parent, "Failed to lock GPIO as interrupt\n");
-		goto err_desc;
-	}
-
-	ret = gpiod_to_irq(dev->desc[pin]);
-	if (ret < 0) {
-		dev_err(dev->gc.parent, "Failed to translate GPIO to IRQ\n");
-		goto err_lock;
-	}
-
-	return ret;
-
-err_lock:
-	gpiochip_unlock_as_irq(&dev->gc, pin);
-err_desc:
-	gpiochip_free_own_desc(dev->desc[pin]);
-	dev->desc[pin] = NULL;
-	return ret;
-}
-
 static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct cp2112_device *dev;
@@ -1388,7 +1342,6 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void cp2112_remove(struct hid_device *hdev)
 {
 	struct cp2112_device *dev = hid_get_drvdata(hdev);
-	int i;
 
 	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
 	i2c_del_adapter(&dev->adap);
@@ -1398,11 +1351,6 @@ static void cp2112_remove(struct hid_device *hdev)
 		cancel_delayed_work_sync(&dev->gpio_poll_worker);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(dev->desc); i++) {
-		gpiochip_unlock_as_irq(&dev->gc, i);
-		gpiochip_free_own_desc(dev->desc[i]);
-	}
-
 	gpiochip_remove(&dev->gc);
 	/* i2c_del_adapter has finished removing all i2c devices from our
 	 * adapter. Well behaved devices should no longer call our cp2112_xfer
-- 
2.34.1

