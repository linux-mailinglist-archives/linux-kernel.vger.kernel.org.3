Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE749633E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380014AbiAUQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379976AbiAUQzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:55:17 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06AC06174E;
        Fri, 21 Jan 2022 08:54:57 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id v10-20020a4a860a000000b002ddc59f8900so3495545ooh.7;
        Fri, 21 Jan 2022 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axyN3Dmc+7i+0pzDHxCOIZN0RRBTRZkn0CanzB+myz0=;
        b=H/B2qyOFALvP9VFgovDj7du1b8svC8K7k2YjHRIPfkpAurE74+rahvqGO2yfytLNFB
         ki1YIOOlpG9npQJ3Bj1vwyvUY+e1Pz8YnU5DmPlcyLtM9JO2BxJ4KS0qHLpAzpmKdePl
         0G9I3pplsNbfyBN2yNVnnIma3FpJzkJ0PSjdC7g7DjPogdR+dwWYGg7tFvzYl9LTlBTO
         czKoTDx2QeMutjcfGzCUjKdodosIF9Xe80Y66dT/OZ+coUmyi1wVX8hKn52k4I7EEVUl
         cre6LJDg9R+6+DTQ33HuezIQTOOo3BDszs2kmfZfzV0Raul4oIb6fTokXJPt/J3HzhqJ
         EHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axyN3Dmc+7i+0pzDHxCOIZN0RRBTRZkn0CanzB+myz0=;
        b=gFQFU6ifX65jI6BsgPEncz/j40rDnnfwgF+8+CzAMV3aLnsw91EZahDrdoYihLqAGV
         GiE5mTOpC3GAPUp5RlWgoyKbQdo9zzC16y/524aWAMHSl3ZT3dHQOml9QUKn8k2yoySZ
         KMUtSHcVd+1dEZEsxcYSjToU2fD4CPzfb+KM2lcX+kDBVCkJLKswxjq4Ww126/OlaplJ
         H68wJnUTyO8zS6U5OumZ8fdsSQfRhFZAAlZyGyk5tiSAzz5cwlAy6ueLCgmypB64qXR5
         kjmOUVtyc5tKPsYd1/cPBACSEN0NLQZUMtYSiX7xR6c5iatUqIe3mGy76T++jNfZWedx
         BG6Q==
X-Gm-Message-State: AOAM531aq7VWaWNUuTEajCuaaTjxJRDd2CXIZMO4mc9MLCQinx7jkEcc
        oKeE1yGwrLmJEoMkte1QIfQxzjq/KuE=
X-Google-Smtp-Source: ABdhPJyB7LicWmiaKhTj/MOAxL2NyKsn2SS+i0ZOfk+4vgm1FtLkR75CZD27pOXEHGvewZ/KzNUBRg==
X-Received: by 2002:a4a:e8c9:: with SMTP id h9mr3121251ooe.12.1642784096951;
        Fri, 21 Jan 2022 08:54:56 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:56 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 11/31] media: rc: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:16 -0300
Message-Id: <20220121165436.30956-12-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/media/rc/rc-main.c     | 4 ++--
 drivers/media/rc/redrat3.c     | 4 ++--
 drivers/media/rc/ttusbir.c     | 4 ++--
 drivers/media/rc/winbond-cir.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index b90438a71c80..76580f1920e2 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -641,7 +641,7 @@ static void ir_do_keyup(struct rc_dev *dev, bool sync)
 	dev_dbg(&dev->dev, "keyup key 0x%04x\n", dev->last_keycode);
 	del_timer(&dev->timer_repeat);
 	input_report_key(dev->input_dev, dev->last_keycode, 0);
-	led_trigger_event(led_feedback, LED_OFF);
+	led_trigger_event(led_feedback, 0);
 	if (sync)
 		input_sync(dev->input_dev);
 	dev->keypressed = false;
@@ -812,7 +812,7 @@ static void ir_do_keydown(struct rc_dev *dev, enum rc_proto protocol,
 			dev->device_name, keycode, protocol, scancode);
 		input_report_key(dev->input_dev, keycode, 1);
 
-		led_trigger_event(led_feedback, LED_FULL);
+		led_trigger_event(led_feedback, 255);
 	}
 
 	/*
diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index cb22316b3f00..7c255f7d790c 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -855,7 +855,7 @@ static void redrat3_brightness_set(struct led_classdev *led_dev, enum
 	struct redrat3_dev *rr3 = container_of(led_dev, struct redrat3_dev,
 									led);
 
-	if (brightness != LED_OFF && atomic_cmpxchg(&rr3->flash, 0, 1) == 0) {
+	if (brightness != 0 && atomic_cmpxchg(&rr3->flash, 0, 1) == 0) {
 		int ret = usb_submit_urb(rr3->flash_urb, GFP_ATOMIC);
 		if (ret != 0) {
 			dev_dbg(rr3->dev, "%s: unexpected ret of %d\n",
@@ -919,7 +919,7 @@ static void redrat3_led_complete(struct urb *urb)
 		break;
 	}
 
-	rr3->led.brightness = LED_OFF;
+	rr3->led.brightness = 0;
 	atomic_dec(&rr3->flash);
 }
 
diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 629787d53ee1..a295112644c3 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -44,7 +44,7 @@ static enum led_brightness ttusbir_brightness_get(struct led_classdev *led_dev)
 {
 	struct ttusbir *tt = container_of(led_dev, struct ttusbir, led);
 
-	return tt->led_on ? LED_FULL : LED_OFF;
+	return tt->led_on ? 255 : 0;
 }
 
 static void ttusbir_set_led(struct ttusbir *tt)
@@ -70,7 +70,7 @@ static void ttusbir_brightness_set(struct led_classdev *led_dev, enum
 {
 	struct ttusbir *tt = container_of(led_dev, struct ttusbir, led);
 
-	tt->led_on = brightness != LED_OFF;
+	tt->led_on = brightness != 0;
 
 	ttusbir_set_led(tt);
 }
diff --git a/drivers/media/rc/winbond-cir.c b/drivers/media/rc/winbond-cir.c
index 94efb035d21b..d14e495a8641 100644
--- a/drivers/media/rc/winbond-cir.c
+++ b/drivers/media/rc/winbond-cir.c
@@ -265,7 +265,7 @@ wbcir_led_brightness_get(struct led_classdev *led_cdev)
 	if (inb(data->ebase + WBCIR_REG_ECEIR_CTS) & WBCIR_LED_ENABLE)
 		return LED_FULL;
 	else
-		return LED_OFF;
+		return 0;
 }
 
 static void
@@ -277,7 +277,7 @@ wbcir_led_brightness_set(struct led_classdev *led_cdev,
 					       led);
 
 	wbcir_set_bits(data->ebase + WBCIR_REG_ECEIR_CTS,
-		       brightness == LED_OFF ? 0x00 : WBCIR_LED_ENABLE,
+		       brightness == 0 ? 0x00 : WBCIR_LED_ENABLE,
 		       WBCIR_LED_ENABLE);
 }
 
@@ -1167,7 +1167,7 @@ wbcir_remove(struct pnp_dev *device)
 	led_classdev_unregister(&data->led);
 
 	/* This is ok since &data->led isn't actually used */
-	wbcir_led_brightness_set(&data->led, LED_OFF);
+	wbcir_led_brightness_set(&data->led, 0);
 
 	release_region(data->wbase, WAKEUP_IOMEM_LEN);
 	release_region(data->ebase, EHFUNC_IOMEM_LEN);
-- 
2.34.1

