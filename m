Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37051470CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbhLJWPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239720AbhLJWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639174303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5UmVaeJrzn3My0B5tFTl1sy/eIwtDufvqirRLuy1LQ=;
        b=ZmkZL5zWJrFEeAcraQ0lIWizIW84xyGlRuPavYAvH6nyCSBQTrmjWdlh9/pZGEyT5qZPsI
        YmudfMtol7PPATw4kMHPRDZcRxYiO31hCRN5ps2cofah0XH5NmSApoTjouZGuImJV6y7VD
        h1heG2bsLvfIqpmcjolmiQwAifVp4ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-yLn7TFRwN5WN6D32BzAqpA-1; Fri, 10 Dec 2021 17:11:40 -0500
X-MC-Unique: yLn7TFRwN5WN6D32BzAqpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61CDF18C8C04;
        Fri, 10 Dec 2021 22:11:38 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDFAF694DE;
        Fri, 10 Dec 2021 22:11:36 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH V5 2/6] drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick driver
Date:   Fri, 10 Dec 2021 17:10:29 -0500
Message-Id: <20211210221033.912430-3-cmirabil@redhat.com>
In-Reply-To: <20211210221033.912430-1-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements support for the joystick.
It supports left/right/up/down/enter and is
attached via i2c and a gpio pin for irq.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/input/joystick/Kconfig             |   8 ++
 drivers/input/joystick/Makefile            |   1 +
 drivers/input/joystick/sensehat-joystick.c | 119 +++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/input/joystick/sensehat-joystick.c

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 3b23078bc7b5..d5c5ffe13903 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -399,4 +399,12 @@ config JOYSTICK_N64
 	  Say Y here if you want enable support for the four
 	  built-in controller ports on the Nintendo 64 console.
 
+config JOYSTICK_SENSEHAT
+	tristate "Raspberry Pi Sense HAT joystick"
+	depends on GPIOLIB && INPUT && I2C
+	select MFD_SENSEHAT_CORE
+
+	help
+	  This is the joystick driver for the Raspberry Pi Sense HAT
+
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 5174b8aba2dd..39c8b5c6e5ae 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_JOYSTICK_N64)		+= n64joy.o
 obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
 obj-$(CONFIG_JOYSTICK_PXRC)		+= pxrc.o
 obj-$(CONFIG_JOYSTICK_QWIIC)		+= qwiic-joystick.o
+obj-$(CONFIG_JOYSTICK_SENSEHAT)         += sensehat-joystick.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
 obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
diff --git a/drivers/input/joystick/sensehat-joystick.c b/drivers/input/joystick/sensehat-joystick.c
new file mode 100644
index 000000000000..1f6bb09b4d1f
--- /dev/null
+++ b/drivers/input/joystick/sensehat-joystick.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Raspberry Pi Sense HAT joystick driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/sensehat.h>
+
+#define SENSEHAT_KEYS 0xF2
+
+static int sensehat_get_joystick_state(struct sensehat *sensehat);
+
+static unsigned char keymap[] = {
+	KEY_DOWN, KEY_RIGHT, KEY_UP, KEY_ENTER, KEY_LEFT,
+};
+
+static irqreturn_t sensehat_joystick_report(int n, void *cookie)
+{
+	int i;
+	static s32 prev_keys;
+	struct sensehat *sensehat = cookie;
+	struct sensehat_joystick *sensehat_joystick = &sensehat->joystick;
+	s32 keys = sensehat_get_joystick_state(sensehat);
+	s32 changes = keys ^ prev_keys;
+
+	prev_keys = keys;
+	for (i = 0; i < ARRAY_SIZE(keymap); ++i) {
+		if (changes & (1 << i)) {
+			input_report_key(sensehat_joystick->keys_dev, keymap[i],
+					 keys & (1 << i));
+		}
+	}
+	input_sync(sensehat_joystick->keys_dev);
+	return IRQ_HANDLED;
+}
+
+static int sensehat_joystick_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct sensehat *sensehat = dev_get_drvdata(&pdev->dev);
+	struct sensehat_joystick *sensehat_joystick = &sensehat->joystick;
+
+	sensehat_joystick->keys_dev = devm_input_allocate_device(&pdev->dev);
+	if (!sensehat_joystick->keys_dev) {
+		dev_err(&pdev->dev, "Could not allocate input device.\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keymap); i++) {
+		set_bit(keymap[i], sensehat_joystick->keys_dev->keybit);
+	}
+
+	sensehat_joystick->keys_dev->name = "Raspberry Pi Sense HAT Joystick";
+	sensehat_joystick->keys_dev->phys = "rpi-sense-joy/input0";
+	sensehat_joystick->keys_dev->id.bustype = BUS_I2C;
+	sensehat_joystick->keys_dev->evbit[0] =
+		BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+	sensehat_joystick->keys_dev->keycode = keymap;
+	sensehat_joystick->keys_dev->keycodesize = sizeof(unsigned char);
+	sensehat_joystick->keys_dev->keycodemax = ARRAY_SIZE(keymap);
+
+	ret = input_register_device(sensehat_joystick->keys_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register input device.\n");
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, sensehat->i2c_client->irq,
+					NULL, sensehat_joystick_report,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					"keys", sensehat);
+
+	if (ret) {
+		dev_err(&pdev->dev, "IRQ request failed.\n");
+		return ret;
+	}
+	return 0;
+}
+
+int sensehat_get_joystick_state(struct sensehat *sensehat)
+{
+	unsigned int reg;
+	int ret = regmap_read(sensehat->regmap, SENSEHAT_KEYS, &reg);
+
+	return ret < 0 ? ret : reg;
+}
+
+static struct platform_device_id sensehat_joystick_device_id[] = {
+	{ .name = "sensehat-joystick" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, sensehat_joystick_device_id);
+
+static struct platform_driver sensehat_joystick_driver = {
+	.probe = sensehat_joystick_probe,
+	.driver = {
+		.name = "sensehat-joystick",
+	},
+};
+
+module_platform_driver(sensehat_joystick_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT joystick driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

