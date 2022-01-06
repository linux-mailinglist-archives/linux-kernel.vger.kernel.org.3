Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED543486287
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiAFJ5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbiAFJ5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:57:51 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D5C061245;
        Thu,  6 Jan 2022 01:57:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f8so2139344pgf.8;
        Thu, 06 Jan 2022 01:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gSmeKlQo9OX6Ql3tAsHGNIJdiuepeTrkyZG6gs4iBYk=;
        b=hiCLs8toJ9V+KeYbq1L81vMw/tsxvggQdtr0tOVzxTb59dglgc0G8WthCiqxISSVsl
         7U94hWna5sqYmPI11xgdVhVHykFcv8nlfhxqUL+T9+u/R2w0pg45SQKgo+8eLNQ8OSoV
         oG+ewi00lAIqocNwlsgFAH8O+968p3IXmJKcOf2Slok5Ja7gjaGD/klty4NOWsSoacBX
         th7G7nxnzdVwi13g3m/6wf5wYFRay8kayQSikdoaIt27bU0f6AaONgzHTTjc04fTLpFr
         N3yCsY47HNw27pQveupABUIr+jqhouwKg0LeMM7UsAwTUDCfbyO9InXBWg0G98NquvwQ
         zYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gSmeKlQo9OX6Ql3tAsHGNIJdiuepeTrkyZG6gs4iBYk=;
        b=e1zLFJQWYW8jCLLgL7PfZV8AJHa8Sl76UZahfkvW2gsbpxU5AwPtgZaDtaWUO4o6sI
         RRqbfFfx/Fcvgcp0g97lQqp5PiO+R6hAvqF2jzoPA09FoTUExlr8R9CrI8/YgNhT/Q9E
         wRsJteufJT3e6R9JNKhxSg6WogThNrJC+tYFPbWjBFH6+OPxtUqLM46tYcPkvxrhCVAV
         jUXAAgXGfZDK6vXyONs511pXSOdIUgtQuItLAa9mRtbC7Vc3iexlasqKOqkZcxlVliot
         hV6w0/5Gm53CPnyEvp7Q0O0iR4VxgPr/lvwBA/xV062Q47m+c3pj0JHVCb/t2oCSb0jv
         9Uvw==
X-Gm-Message-State: AOAM530mrOzCdu6WyNDxMHoNHQZhyza6hFyU/NbfGY3M6sksnX3f3oNd
        h7vRhxmLSOjWMtuAof1CTl811OrbPDjg
X-Google-Smtp-Source: ABdhPJyIQaYf54Hp5kBEW0mTMvlD0fX+iMTcn4tmhwv/54eiEDU249rZ8/4ykGK1RFgaV61x5H19qw==
X-Received: by 2002:a63:375e:: with SMTP id g30mr51468109pgn.174.1641463070316;
        Thu, 06 Jan 2022 01:57:50 -0800 (PST)
Received: from penmount-virtual-machine.localdomain ([61.219.219.230])
        by smtp.gmail.com with ESMTPSA id e15sm1914123pfv.23.2022.01.06.01.57.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 01:57:50 -0800 (PST)
From:   John Sung <penmount.touch@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Sung <penmount.touch@gmail.com>
Subject: [PATCH] Add serial device bus support to penmount serial driver.
Date:   Thu,  6 Jan 2022 17:57:40 +0800
Message-Id: <1641463060-6602-1-git-send-email-penmount.touch@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the penmount touchscreen driver registers as a serio driver, which seems not supporting device tree binding. This patch tries to support both serio and serdev in a single module.
For this purpose, the module implements module_init and module_exit instead of using module_serio_driver. The module is also modified to share input codes for both serio and serdev.

Signed-off-by: John Sung <penmount.touch@gmail.com>
---
 drivers/input/touchscreen/penmount.c | 307 ++++++++++++++++++++++++++++-------
 1 file changed, 250 insertions(+), 57 deletions(-)

diff --git a/drivers/input/touchscreen/penmount.c b/drivers/input/touchscreen/penmount.c
index 12abb3b..559eb87 100644
--- a/drivers/input/touchscreen/penmount.c
+++ b/drivers/input/touchscreen/penmount.c
@@ -1,9 +1,10 @@
+
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Penmount serial touchscreen driver
  *
  * Copyright (c) 2006 Rick Koch <n1gp@hotmail.com>
- * Copyright (c) 2011 John Sung <penmount.touch@gmail.com>
+ * Copyright (c) 2022 John Sung <penmount.touch@gmail.com>
  *
  * Based on ELO driver (drivers/input/touchscreen/elo.c)
  * Copyright (c) 2004 Vojtech Pavlik
@@ -16,7 +17,11 @@
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/serio.h>
+#include <linux/serdev.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #define DRIVER_DESC	"PenMount serial touchscreen driver"
 
@@ -31,9 +36,17 @@
 
 #define	PM_MAX_LENGTH	6
 #define	PM_MAX_MTSLOT	16
-#define	PM_3000_MTSLOT	2
+#define	PM_3000_MTSLOT	5
 #define	PM_6250_MTSLOT	12
 
+enum {
+	PMSERIAL_DEVICEID_9000 = 0,
+	PMSERIAL_DEVICEID_6000,
+	PMSERIAL_DEVICEID_P2,
+	PMSERIAL_DEVICEID_M1,
+	PMSERIAL_DEVICEID_6010,
+};
+
 /*
  * Multi-touch slot
  */
@@ -47,15 +60,24 @@ struct mt_slot {
  * Per-touchscreen data.
  */
 
+struct pm_device_conf;
+
 struct pm {
 	struct input_dev *dev;
 	struct serio *serio;
+	const struct pm_device_conf *conf;
 	int idx;
 	unsigned char data[PM_MAX_LENGTH];
 	char phys[32];
+	struct mt_slot slots[PM_MAX_MTSLOT];
+};
+
+struct pm_device_conf {
+	unsigned long baudrate;
+	unsigned short productid;
 	unsigned char packetsize;
 	unsigned char maxcontacts;
-	struct mt_slot slots[PM_MAX_MTSLOT];
+	int max;
 	void (*parse_packet)(struct pm *);
 };
 
@@ -67,7 +89,7 @@ static void pm_mtevent(struct pm *pm, struct input_dev *input)
 {
 	int i;
 
-	for (i = 0; i < pm->maxcontacts; ++i) {
+	for (i = 0; i < pm->conf->maxcontacts; ++i) {
 		input_mt_slot(input, i);
 		input_mt_report_slot_state(input, MT_TOOL_FINGER,
 				pm->slots[i].active);
@@ -100,7 +122,7 @@ static void pm_parse_9000(struct pm *pm)
 {
 	struct input_dev *dev = pm->dev;
 
-	if ((pm->data[0] & 0x80) && pm->packetsize == ++pm->idx) {
+	if ((pm->data[0] & 0x80) && pm->conf->packetsize == ++pm->idx) {
 		input_report_abs(dev, ABS_X, pm->data[1] * 128 + pm->data[2]);
 		input_report_abs(dev, ABS_Y, pm->data[3] * 128 + pm->data[4]);
 		input_report_key(dev, BTN_TOUCH, !!(pm->data[0] & 0x40));
@@ -113,7 +135,7 @@ static void pm_parse_6000(struct pm *pm)
 {
 	struct input_dev *dev = pm->dev;
 
-	if ((pm->data[0] & 0xbf) == 0x30 && pm->packetsize == ++pm->idx) {
+	if ((pm->data[0] & 0xbf) == 0x30 && pm->conf->packetsize == ++pm->idx) {
 		if (pm_checkpacket(pm->data)) {
 			input_report_abs(dev, ABS_X,
 					pm->data[2] * 256 + pm->data[1]);
@@ -130,7 +152,7 @@ static void pm_parse_3000(struct pm *pm)
 {
 	struct input_dev *dev = pm->dev;
 
-	if ((pm->data[0] & 0xce) == 0x40 && pm->packetsize == ++pm->idx) {
+	if ((pm->data[0] & 0xce) == 0x40 && pm->conf->packetsize == ++pm->idx) {
 		if (pm_checkpacket(pm->data)) {
 			int slotnum = pm->data[0] & 0x0f;
 			pm->slots[slotnum].active = pm->data[0] & 0x30;
@@ -146,7 +168,7 @@ static void pm_parse_6250(struct pm *pm)
 {
 	struct input_dev *dev = pm->dev;
 
-	if ((pm->data[0] & 0xb0) == 0x30 && pm->packetsize == ++pm->idx) {
+	if ((pm->data[0] & 0xb0) == 0x30 && pm->conf->packetsize == ++pm->idx) {
 		if (pm_checkpacket(pm->data)) {
 			int slotnum = pm->data[0] & 0x0f;
 			pm->slots[slotnum].active = pm->data[0] & 0x40;
@@ -158,6 +180,42 @@ static void pm_parse_6250(struct pm *pm)
 	}
 }
 
+static const struct pm_device_conf pm_device_9000 = {
+	.baudrate = 19200,
+	.max = 0x3FF,
+	.productid = 0x9000,
+	.packetsize = 5,
+	.maxcontacts = 1,
+	.parse_packet = pm_parse_9000,
+};
+
+static const struct pm_device_conf pm_device_6000 = {
+	.baudrate = 19200,	
+	.max = 0x3FF,
+	.productid = 0x6000,
+	.packetsize = 6,
+	.maxcontacts = 1,
+	.parse_packet = pm_parse_6000,
+};
+
+static const struct pm_device_conf pm_device_p2 = {
+	.baudrate = 38400,	
+	.max = 0x7FF,
+	.productid = 0x3000,
+	.packetsize = 6,
+	.maxcontacts = PM_3000_MTSLOT,
+	.parse_packet = pm_parse_3000,
+};
+
+static const struct pm_device_conf pm_device_m1 = {
+	.baudrate = 19200,	
+	.max = 0x3FF,
+	.productid = 0x6250,
+	.packetsize = 6,
+	.maxcontacts = PM_6250_MTSLOT,
+	.parse_packet = pm_parse_6250,
+};
+
 static irqreturn_t pm_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
@@ -165,7 +223,7 @@ static irqreturn_t pm_interrupt(struct serio *serio,
 
 	pm->data[pm->idx] = data;
 
-	pm->parse_packet(pm);
+	pm->conf->parse_packet(pm);
 
 	return IRQ_HANDLED;
 }
@@ -191,10 +249,9 @@ static void pm_disconnect(struct serio *serio)
  * new serio device that supports PenMount protocol and registers it as
  * an input device.
  */
-
-static int pm_connect(struct serio *serio, struct serio_driver *drv)
+static struct pm * pm_driver_init(struct device * dev, const struct pm_device_conf * conf, char *phys)
 {
-	struct pm *pm;
+	struct pm *pm = NULL;
 	struct input_dev *input_dev;
 	int max_x, max_y;
 	int err;
@@ -205,66 +262,68 @@ static int pm_connect(struct serio *serio, struct serio_driver *drv)
 		err = -ENOMEM;
 		goto fail1;
 	}
-
-	pm->serio = serio;
-	pm->dev = input_dev;
-	snprintf(pm->phys, sizeof(pm->phys), "%s/input0", serio->phys);
-	pm->maxcontacts = 1;
+	
+	pm->dev = input_dev;	
 
 	input_dev->name = "PenMount Serial TouchScreen";
-	input_dev->phys = pm->phys;
+	input_dev->phys = phys;
 	input_dev->id.bustype = BUS_RS232;
 	input_dev->id.vendor = SERIO_PENMOUNT;
 	input_dev->id.product = 0;
 	input_dev->id.version = 0x0100;
-	input_dev->dev.parent = &serio->dev;
+	input_dev->dev.parent = dev;
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	switch (serio->id.id) {
-	default:
-	case 0:
-		pm->packetsize = 5;
-		pm->parse_packet = pm_parse_9000;
-		input_dev->id.product = 0x9000;
-		max_x = max_y = 0x3ff;
-		break;
-
-	case 1:
-		pm->packetsize = 6;
-		pm->parse_packet = pm_parse_6000;
-		input_dev->id.product = 0x6000;
-		max_x = max_y = 0x3ff;
-		break;
-
-	case 2:
-		pm->packetsize = 6;
-		pm->parse_packet = pm_parse_3000;
-		input_dev->id.product = 0x3000;
-		max_x = max_y = 0x7ff;
-		pm->maxcontacts = PM_3000_MTSLOT;
-		break;
-
-	case 3:
-		pm->packetsize = 6;
-		pm->parse_packet = pm_parse_6250;
-		input_dev->id.product = 0x6250;
-		max_x = max_y = 0x3ff;
-		pm->maxcontacts = PM_6250_MTSLOT;
-		break;
-	}
+	pm->conf = conf;
+	input_dev->id.product = conf->productid;
+	max_x = max_y = conf->max;
 
 	input_set_abs_params(pm->dev, ABS_X, 0, max_x, 0, 0);
 	input_set_abs_params(pm->dev, ABS_Y, 0, max_y, 0, 0);
 
-	if (pm->maxcontacts > 1) {
-		input_mt_init_slots(pm->dev, pm->maxcontacts, 0);
+	if (pm->conf->maxcontacts > 1) {
+		input_mt_init_slots(pm->dev, pm->conf->maxcontacts, 0);
 		input_set_abs_params(pm->dev,
 				     ABS_MT_POSITION_X, 0, max_x, 0, 0);
 		input_set_abs_params(pm->dev,
 				     ABS_MT_POSITION_Y, 0, max_y, 0, 0);
 	}
+	return pm;
+	
+ fail1:	
+	if (input_dev) input_free_device(input_dev);
+	if (pm) kfree(pm);
+	return NULL;
+}
+
+static int pm_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct pm *pm = NULL;
+	int err = 0;
+	const struct pm_device_conf * device = NULL;
+	
+	switch (serio->id.id) {
+	case PMSERIAL_DEVICEID_9000:
+		device = &pm_device_9000;
+		break;
+	default:
+	case PMSERIAL_DEVICEID_6000:
+		device = &pm_device_6000;
+		break;
+	case PMSERIAL_DEVICEID_P2:
+		device = &pm_device_p2;
+		break;
+	case PMSERIAL_DEVICEID_M1:
+		device = &pm_device_m1;
+		break;
+	}
+	pm = pm_driver_init(&serio->dev, device, serio->phys);
+	if (!pm) return -ENOMEM;
+	
+	pm->serio = serio;
+	snprintf(pm->phys, sizeof(pm->phys), "%s/input0", serio->phys);
 
 	serio_set_drvdata(serio, pm);
 
@@ -280,7 +339,7 @@ static int pm_connect(struct serio *serio, struct serio_driver *drv)
 
  fail3:	serio_close(serio);
  fail2:	serio_set_drvdata(serio, NULL);
- fail1:	input_free_device(input_dev);
+	input_free_device(pm->dev);
 	kfree(pm);
 	return err;
 }
@@ -293,7 +352,7 @@ static int pm_connect(struct serio *serio, struct serio_driver *drv)
 	{
 		.type	= SERIO_RS232,
 		.proto	= SERIO_PENMOUNT,
-		.id	= SERIO_ANY,
+		.id	    = SERIO_ANY,
 		.extra	= SERIO_ANY,
 	},
 	{ 0 }
@@ -305,11 +364,145 @@ static int pm_connect(struct serio *serio, struct serio_driver *drv)
 	.driver		= {
 		.name	= "serio-penmount",
 	},
-	.description	= DRIVER_DESC,
+	.description= DRIVER_DESC,
 	.id_table	= pm_serio_ids,
 	.interrupt	= pm_interrupt,
 	.connect	= pm_connect,
 	.disconnect	= pm_disconnect,
 };
 
-module_serio_driver(pm_drv);
+static void pm_serdev_wakeup(struct serdev_device *serdev)
+{
+	return;
+}
+
+static int pm_serdev_receive(struct serdev_device *serdev, const unsigned char *data,
+		size_t count)
+{
+	struct pm *pm = NULL;	
+	size_t i = 0;
+	
+	pm = serdev_device_get_drvdata(serdev);	
+	if (pm == NULL) {
+		return 0;
+	}
+	
+	for (i = 0; i < count; i++) {
+		pm->data[pm->idx] = data[i];
+		pm->conf->parse_packet(pm);		
+	}
+
+	// Accept all data
+	return count;
+}
+
+static const
+struct serdev_device_ops pm_serdev_ops = {
+	.receive_buf = pm_serdev_receive,
+	.write_wakeup = pm_serdev_wakeup,
+};
+
+static int pm_serdev_enable(struct serdev_device *serdev)
+{
+	unsigned char cmd[6] = {0xF1, 0x00, 0x00, 0x00, 0x00, 0x0E};
+	
+	return serdev_device_write(serdev, cmd, sizeof(cmd), 0);
+}
+
+static int pm_serdev_probe(struct serdev_device *serdev)
+{
+	struct pm *pm = NULL;
+	uint32_t speed = 0;
+	const struct pm_device_conf * conf = &pm_device_6000;
+	int err = 0;
+
+	conf = (struct pm_device_conf *)of_device_get_match_data(&serdev->dev);
+	pm = pm_driver_init(&serdev->dev, conf, (char *)dev_name(&serdev->dev));
+	if (!pm) {
+		return -ENOMEM;
+	}	
+	touchscreen_parse_properties(pm->dev, (pm->conf->maxcontacts > 1), NULL);
+	
+	serdev_device_set_drvdata(serdev, pm);
+	serdev_device_set_client_ops(serdev, &pm_serdev_ops);
+
+	err = serdev_device_open(serdev);
+	if (err) {
+		kfree(pm);
+		return err;
+	}
+
+	of_property_read_u32(serdev->dev.of_node, "baudrate", &speed);
+	if (!speed) speed = pm->conf->baudrate;
+	speed = serdev_device_set_baudrate(serdev, speed);
+	dev_info(&serdev->dev, "Using baudrate: %u\n", speed);
+	
+	serdev_device_set_flow_control(serdev, false);
+	if (pm->conf->productid == 0x6000) {
+		pm_serdev_enable (serdev);
+	}
+	
+	err = input_register_device(pm->dev);
+	if (err) {		
+		serdev_device_close(serdev);
+		input_free_device(pm->dev);
+		kfree(pm);
+		return err;
+	}	
+
+	return 0;
+}
+
+static void pm_serdev_remove(struct serdev_device *serdev)
+{
+	serdev_device_close(serdev);
+
+	return;
+}
+
+static const struct of_device_id pm_serdev_of_match[] = {
+	{
+		.compatible = "penmount,pm9000",
+		.data = &pm_device_9000,
+	},
+	{
+		.compatible = "penmount,pm6000",
+		.data = &pm_device_6000,
+	},
+	{
+		.compatible = "penmount,p2",
+		.data = &pm_device_p2,
+	},
+	{
+		.compatible = "penmount,m1",
+		.data = &pm_device_m1,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, pm_serdev_of_match);
+
+static struct serdev_device_driver pm_serdev_drv = {
+	.probe = pm_serdev_probe,
+	.remove = pm_serdev_remove,
+	.driver = {
+		.name = "serdev-penmount",
+		.of_match_table = of_match_ptr(pm_serdev_of_match),
+	},
+};
+
+static int __init pm_init ( void )
+{
+	serdev_device_driver_register ( &pm_serdev_drv );
+	return serio_register_driver ( &pm_drv ) ;
+}
+
+static void __exit pm_exit ( void )
+{
+	serdev_device_driver_unregister ( &pm_serdev_drv );
+	serio_unregister_driver ( &pm_drv ) ;
+
+	return ;
+}
+
+module_init(pm_init);
+module_exit(pm_exit);
-- 
1.9.1

