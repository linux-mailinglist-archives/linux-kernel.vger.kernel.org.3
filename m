Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13404507B43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357773AbiDSUzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357757AbiDSUz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85FD43F8B1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650401561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JqL0X3/KT3zDD+acZ4FetaC4TRfVdG3OQ6t4Ea+PBQ=;
        b=ByCrj1Q19c9jpL+k+IvwkW0YDxS/8u88Jl1+vzSW7IKe6TSN9tK3itrZljIKQ2JVxIh+2p
        O1U1B/zE53OaolIAkl2nmLfNqch8DfTNhaMlJg7tRYdSkGEqVYbxKcu7A6W/WkV5W0FOQ9
        Ba7C5M/01PPbQfb1/xiFfHiW5Nmaaxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-7yJKaTtoMwS5kYjWBVO8oA-1; Tue, 19 Apr 2022 16:52:38 -0400
X-MC-Unique: 7yJKaTtoMwS5kYjWBVO8oA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62219901865;
        Tue, 19 Apr 2022 20:52:23 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D10D72166B4F;
        Tue, 19 Apr 2022 20:52:22 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH v9 2/6] drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick driver
Date:   Tue, 19 Apr 2022 16:51:54 -0400
Message-Id: <20220419205158.28088-3-cmirabil@redhat.com>
In-Reply-To: <20220419205158.28088-1-cmirabil@redhat.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver for the Sense HAT joystick. It outputs BTN_DPAD
key events when moved in any of the four directions and the BTN_SELECT
event when depressed.

Co-developed-by: Daniel Bauman <dbauman@redhat.com>
Signed-off-by: Daniel Bauman <dbauman@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/input/joystick/Kconfig             |  11 ++
 drivers/input/joystick/Makefile            |   1 +
 drivers/input/joystick/sensehat-joystick.c | 137 +++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/input/joystick/sensehat-joystick.c

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 3b23078bc7b5..505a032e2786 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -399,4 +399,15 @@ config JOYSTICK_N64
 	  Say Y here if you want enable support for the four
 	  built-in controller ports on the Nintendo 64 console.
 
+config JOYSTICK_SENSEHAT
+	tristate "Raspberry Pi Sense HAT joystick"
+	depends on INPUT && I2C
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Say Y here if you want to enable the driver for the
+	  the Raspberry Pi Sense HAT.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sensehat_joystick.
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
index 000000000000..6fed6004f464
--- /dev/null
+++ b/drivers/input/joystick/sensehat-joystick.c
@@ -0,0 +1,137 @@
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
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#define JOYSTICK_SMB_REG 0xf2
+
+struct sensehat_joystick {
+	struct platform_device *pdev;
+	struct input_dev *keys_dev;
+	unsigned long prev_states;
+	struct regmap *regmap;
+};
+
+static const unsigned int keymap[] = {
+	BTN_DPAD_DOWN, BTN_DPAD_RIGHT, BTN_DPAD_UP, BTN_SELECT, BTN_DPAD_LEFT,
+};
+
+static irqreturn_t sensehat_joystick_report(int n, void *cookie)
+{
+	int i, error, keys;
+	struct sensehat_joystick *sensehat_joystick = cookie;
+	unsigned long curr_states, changes;
+
+	error = regmap_read(sensehat_joystick->regmap, JOYSTICK_SMB_REG, &keys);
+	if (error < 0) {
+		dev_err(&sensehat_joystick->pdev->dev,
+			"Failed to read joystick state: %d", error);
+		return IRQ_NONE;
+	}
+	curr_states = keys;
+	bitmap_xor(&changes, &curr_states, &sensehat_joystick->prev_states,
+		   ARRAY_SIZE(keymap));
+
+	for_each_set_bit(i, &changes, ARRAY_SIZE(keymap)) {
+		input_report_key(sensehat_joystick->keys_dev, keymap[i],
+				 curr_states & BIT(i));
+	}
+
+	input_sync(sensehat_joystick->keys_dev);
+	sensehat_joystick->prev_states = keys;
+	return IRQ_HANDLED;
+}
+
+static int sensehat_joystick_probe(struct platform_device *pdev)
+{
+	int error, i, irq;
+	struct sensehat_joystick *sensehat_joystick = devm_kzalloc(
+		&pdev->dev, sizeof(*sensehat_joystick), GFP_KERNEL);
+	if (!sensehat_joystick)
+		return -ENOMEM;
+
+	sensehat_joystick->pdev = pdev;
+
+	sensehat_joystick->regmap = dev_get_regmap(sensehat_joystick->pdev->dev.parent, NULL);
+	if (!sensehat_joystick->regmap) {
+		dev_err(&pdev->dev,
+			"unable to get sensehat regmap");
+		return -ENODEV;
+	}
+
+
+	sensehat_joystick->keys_dev = devm_input_allocate_device(&pdev->dev);
+	if (!sensehat_joystick->keys_dev) {
+		dev_err(&pdev->dev, "Could not allocate input device.");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keymap); i++)
+		set_bit(keymap[i], sensehat_joystick->keys_dev->keybit);
+
+	sensehat_joystick->keys_dev->name = "Raspberry Pi Sense HAT Joystick";
+	sensehat_joystick->keys_dev->phys = "sensehat-joystick/input0";
+	sensehat_joystick->keys_dev->id.bustype = BUS_I2C;
+	sensehat_joystick->keys_dev->evbit[0] =
+		BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+
+	error = input_register_device(sensehat_joystick->keys_dev);
+	if (error) {
+		dev_err(&pdev->dev, "Could not register input device.");
+		return error;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Could not retrieve interrupt request.");
+		return irq;
+	}
+
+	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					  sensehat_joystick_report,
+					  IRQF_ONESHOT, "keys",
+					  sensehat_joystick);
+
+	if (error) {
+		dev_err(&pdev->dev, "IRQ request failed.");
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sensehat_joystick_device_id[] = {
+	{ .compatible = "raspberrypi,sensehat-joystick" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sensehat_joystick_device_id);
+
+static struct platform_driver sensehat_joystick_driver = {
+	.probe = sensehat_joystick_probe,
+	.driver = {
+		.name = "sensehat-joystick",
+		.of_match_table = sensehat_joystick_device_id,
+	},
+};
+
+module_platform_driver(sensehat_joystick_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT joystick driver");
+MODULE_AUTHOR("Charles Mirabile <cmirabil@redhat.com>");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

