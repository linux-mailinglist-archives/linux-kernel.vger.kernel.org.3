Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EBC4E45BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiCVSLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiCVSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:11:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0B6973B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:10:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so16288729pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tirotech-co-nz.20210112.gappssmtp.com; s=20210112;
        h=message-id:from:date:subject:to:cc;
        bh=0ZmCf9inQQlaAMkLDfQi5G3GC7i0IucLx+YZMvY3eE0=;
        b=aUSwTLIu9jsDOiTZa1l/Ii2QSRdbo8n+xuROXD/MbxRhJY7LfsmrXiu+cDGCxuX9Dt
         YI75R0tqf8+NRTPvI0ZKTQebSijbz6YmBePdlNts3EQbLE23jHK7Gy9l5frV9KHrVMLn
         mjQU/pSkub5NlCE2dZOU7Y8EStoZC0bhjSCOf/Kx/fGsVKzEnDPuSw0CorIVU0ZfDJLo
         bU04EeYEezw68AJWIb/4vrhOb3E/GOqgM3GsqJ7Vy9o35i2gePeA5BRT7gduYB40vdfA
         mUUMO8aOSKahMqeOpikG8U7r/z+yYdF2b6kvrl8XeTS4mHv1CRmA6OupUCm5h0R3TJBM
         Ichw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:to:cc;
        bh=0ZmCf9inQQlaAMkLDfQi5G3GC7i0IucLx+YZMvY3eE0=;
        b=5lqqXu8Ogkk4B5nantVQftDbYGqWVZGXQdcHScBCtZSUlryW6Djg+MwFCev8GmgeIl
         h2WDhXjfibAQfH3TXREJQXohtx7mkxho1K/QKn6lLBR8vIYXpHkkqAr7SFkIl30f2g4n
         an8wFhndqF9wf79tHghIa5E1iy0iZB1n1auBz8MH710M1Yg6DFY1O378V+c3HnYwhAr9
         GeDf6dNugKtPNRNIcLRzexOCqofzTNp3a1LbNmkIfSfWyIiWrF1V34kIPzgdYfFYoGe8
         ZRa9Z4l+qBk2hu+D/K3kKOaT4YoGzHOXkEfy0o6IkvponDPEszFuYMty+id2peypONLD
         JUmw==
X-Gm-Message-State: AOAM530qo2WYtCz627rk5ZnesAOLvGy/qABgkDdugSvZ7/C/rCzgzH4U
        ksxK2hVie6OSIfLSZgHZr3p6qf7lzLqumQ==
X-Google-Smtp-Source: ABdhPJwHp2K6CIqYUctrguiVYcZGZ1hf6oOCnMQh2wFtI5A778h9IHpi94vYHaVJPYGjbmlWGEpowg==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr6566054pjb.35.1647972619868;
        Tue, 22 Mar 2022 11:10:19 -0700 (PDT)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b004f7d604f5ddsm23411878pfl.181.2022.03.22.11.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:10:18 -0700 (PDT)
Message-ID: <623a110a.1c69fb81.64f39.0118@mx.google.com>
From:   Daniel Beer <daniel.beer@tirotech.co.nz>
Date:   Mon, 21 Mar 2022 16:16:27 +1300
Subject: [PATCH v2] winmate-fm07-keys: Winmate FM07/FM07P buttons
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Beer <daniel.beer@tirotech.co.nz>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Winmate FM07 and FM07P in-vehicle computers have a row of five buttons
below the display. This module adds an input device that delivers key
events when these buttons are pressed.

Signed-off-by: Daniel Beer <daniel.beer@tirotech.co.nz>
---
Changes in v2:
  - Ratelimit message on poll timeout.
  - Explain polling rate.
  - Fix fm07keys_dmi_table and add missing macro.
  - Fix check of platform_device_register_simple return value.

 drivers/platform/x86/Kconfig             |   8 +
 drivers/platform/x86/Makefile            |   3 +
 drivers/platform/x86/winmate-fm07-keys.c | 189 +++++++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/platform/x86/winmate-fm07-keys.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 24deeeb29af2..62a5754d6ac9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1138,6 +1138,14 @@ config SIEMENS_SIMATIC_IPC
 	  To compile this driver as a module, choose M here: the module
 	  will be called simatic-ipc.
 
+config WINMATE_FM07_KEYS
+	tristate "Winmate FM07/FM07P front-panel keys driver"
+	depends on INPUT
+	help
+	  Winmate FM07 and FM07P in-vehicle computers have a row of five
+	  buttons below the display. This module adds an input device
+	  that delivers key events when these buttons are pressed.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c12a9b044fd8..04e7c995b838 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -129,3 +129,6 @@ obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
 
 # Siemens Simatic Industrial PCs
 obj-$(CONFIG_SIEMENS_SIMATIC_IPC)	+= simatic-ipc.o
+
+# Winmate
+obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
diff --git a/drivers/platform/x86/winmate-fm07-keys.c b/drivers/platform/x86/winmate-fm07-keys.c
new file mode 100644
index 000000000000..8c03a4d171b8
--- /dev/null
+++ b/drivers/platform/x86/winmate-fm07-keys.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the Winmate FM07 front-panel keys
+//
+// Author: Daniel Beer <daniel.beer@tirotech.co.nz>
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/dmi.h>
+#include <linux/io.h>
+
+#define DRV_NAME	"winmate-fm07keys"
+
+#define PORT_CMD	0x6c
+#define PORT_DATA	0x68
+
+#define EC_ADDR_KEYS	0x3b
+#define EC_CMD_READ	0x80
+
+#define BASE_KEY	KEY_F13
+#define NUM_KEYS	5
+
+/* Typically we're done in fewer than 10 iterations */
+#define LOOP_TIMEOUT	1000
+
+static void fm07keys_poll(struct input_dev *input)
+{
+	uint8_t k;
+	int i;
+
+	/* Flush output buffer */
+	i = 0;
+	while (inb(PORT_CMD) & 0x01) {
+		if (++i >= LOOP_TIMEOUT)
+			goto timeout;
+		inb(PORT_DATA);
+	}
+
+	/* Send request and wait for write completion */
+	outb(EC_CMD_READ, PORT_CMD);
+	i = 0;
+	while (inb(PORT_CMD) & 0x02)
+		if (++i >= LOOP_TIMEOUT)
+			goto timeout;
+
+	outb(EC_ADDR_KEYS, PORT_DATA);
+	i = 0;
+	while (inb(PORT_CMD) & 0x02)
+		if (++i >= LOOP_TIMEOUT)
+			goto timeout;
+
+	/* Wait for data ready */
+	i = 0;
+	while (!(inb(PORT_CMD) & 0x01))
+		if (++i >= LOOP_TIMEOUT)
+			goto timeout;
+	k = inb(PORT_DATA);
+
+	/* Notify of new key states */
+	for (i = 0; i < NUM_KEYS; i++) {
+		input_report_key(input, BASE_KEY + i, (~k) & 1);
+		k >>= 1;
+	}
+
+	input_sync(input);
+	return;
+
+timeout:
+	dev_warn_ratelimited(&input->dev, "timeout polling IO memory\n");
+}
+
+static int fm07keys_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct input_dev *input;
+	int ret;
+	int i;
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "no memory for input device\n");
+		return -ENOMEM;
+	}
+
+	if (!devm_request_region(dev, PORT_CMD, 1, "Winmate FM07 EC"))
+		return -EBUSY;
+	if (!devm_request_region(dev, PORT_DATA, 1, "Winmate FM07 EC"))
+		return -EBUSY;
+
+	input->name = "Winmate FM07 front-panel keys";
+	input->phys = DRV_NAME "/input0";
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	__set_bit(EV_KEY, input->evbit);
+
+	for (i = 0; i < NUM_KEYS; i++)
+		__set_bit(BASE_KEY + i, input->keybit);
+
+	ret = input_setup_polling(input, fm07keys_poll);
+	if (ret) {
+		dev_err(dev, "unable to set up polling, err=%d\n", ret);
+		return ret;
+	}
+
+	/* These are silicone buttons. They can't be pressed in rapid
+	 * succession too quickly, and 50 Hz seems to be an adequate
+	 * sampling rate without missing any events when tested.
+	 */
+	input_set_poll_interval(input, 20);
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(dev, "unable to register polled device, err=%d\n",
+			ret);
+		return ret;
+	}
+
+	input_sync(input);
+	return 0;
+}
+
+static struct platform_driver fm07keys_driver = {
+	.probe		= fm07keys_probe,
+	.driver		= {
+		.name	= DRV_NAME
+	},
+};
+
+static struct platform_device *dev;
+
+static const struct dmi_system_id fm07keys_dmi_table[] __initconst = {
+	{
+		/* FM07 and FM07P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Winmate Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "IP30"),
+		},
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(dmi, fm07keys_dmi_table);
+
+static int __init fm07keys_init(void)
+{
+	int ret;
+
+	if (!dmi_check_system(fm07keys_dmi_table))
+		return -ENODEV;
+
+	ret = platform_driver_register(&fm07keys_driver);
+	if (ret) {
+		pr_err("fm07keys: failed to register driver, err=%d\n", ret);
+		return ret;
+	}
+
+	dev = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		pr_err("fm07keys: failed to allocate device, err = %d\n", ret);
+		goto fail_register;
+	}
+
+	return 0;
+
+fail_register:
+	platform_driver_unregister(&fm07keys_driver);
+	return ret;
+}
+
+static void __exit fm07keys_exit(void)
+{
+	platform_driver_unregister(&fm07keys_driver);
+	platform_device_unregister(dev);
+}
+
+module_init(fm07keys_init);
+module_exit(fm07keys_exit);
+
+MODULE_AUTHOR("Daniel Beer <daniel.beer@tirotech.co.nz>");
+MODULE_DESCRIPTION("Winmate FM07 front-panel keys driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

