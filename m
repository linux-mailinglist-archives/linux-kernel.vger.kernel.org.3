Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BF4CC426
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiCCRkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiCCRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:40:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED91E1A06F4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646329199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izXQJyyJ1cl2s2LE1IV4GOK79BBe2TKczXsvjIKhk5g=;
        b=BYWQMbWYZPVCJCk531kXdVc5NWQhML4ZFzOc5hkgIRtuNvSMcTn++dkIDfyubT6HCFhpLF
        U73Tzlb2KewgYnKSOQyaI8SrxCfDdFJSZXKGTdqRz8aBzx7cpvMwvPVZqEb4ue/kEhwgcj
        TZZ8Jvek8wXaaaKGPnn0E5WCRaOtXqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-mvWeT6JdMCynYWatG-XVSw-1; Thu, 03 Mar 2022 12:39:55 -0500
X-MC-Unique: mvWeT6JdMCynYWatG-XVSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C64824FAB;
        Thu,  3 Mar 2022 17:39:54 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B46EC804EA;
        Thu,  3 Mar 2022 17:39:44 +0000 (UTC)
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
Subject: [PATCH v7 2/6] drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick driver
Date:   Thu,  3 Mar 2022 12:39:31 -0500
Message-Id: <20220303173935.100622-3-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-1-cmirabil@redhat.com>
References: <20220303173935.100622-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/input/joystick/sensehat-joystick.c | 128 +++++++++++++++++++++
 3 files changed, 140 insertions(+)
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
index 000000000000..0a99cf0f3ba0
--- /dev/null
+++ b/drivers/input/joystick/sensehat-joystick.c
@@ -0,0 +1,128 @@
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
+
+	sensehat_joystick->pdev = pdev;
+
+	sensehat_joystick->regmap = dev_get_regmap(sensehat_joystick->pdev->dev.parent, NULL);
+
+	sensehat_joystick->keys_dev = devm_input_allocate_device(&pdev->dev);
+	if (!sensehat_joystick->keys_dev) {
+		dev_err(&pdev->dev, "Could not allocate input device.\n");
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
+		dev_err(&pdev->dev, "Could not register input device.\n");
+		return error;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Could not retrieve interrupt request.\n");
+		return irq;
+	}
+
+	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					  sensehat_joystick_report,
+					  IRQF_ONESHOT, "keys",
+					  sensehat_joystick);
+
+	if (error) {
+		dev_err(&pdev->dev, "IRQ request failed.\n");
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
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
-- 
2.31.1

