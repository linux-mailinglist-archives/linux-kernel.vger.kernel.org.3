Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3D4E1F52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbiCUD1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiCUD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:27:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD85D396BC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:26:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t14so9408819pgr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tirotech-co-nz.20210112.gappssmtp.com; s=20210112;
        h=message-id:from:date:subject:to:cc;
        bh=+OtyrEHezIZaXYqEnaU5AZt/+fb+Nwxo8/bTSx/SosM=;
        b=1LyDLSPpj7R3w5DmDgYlRkb3Uy5UCRgguXSCD46PkZPB9Bttt3mcMDelH80p7zmaIh
         JtArg6MBDuG3u5eQsYOHZrQz1VdGZ6xvncRSx1itr3gfAX4Snc7Ethzu4l6m4irM5t5L
         /a4LFcVlZEyBu49pRnwoMe4KL814QnDXwP8EN7KmV8mFb55idiE51R/gIAY354dfAd4k
         Q9TPh0HuX4jGU4bpPL8EIzbCau6LQt0nb6k0UfzsagdUgr7I2sJlr3Rs/m3xnvwwOggy
         PrCT46VHuNjaIM8HKFfIxqUrYLIMsEXAd57QJm27GepRkfBzFMwMMQyeA72Ih4WRVYq0
         ax8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:to:cc;
        bh=+OtyrEHezIZaXYqEnaU5AZt/+fb+Nwxo8/bTSx/SosM=;
        b=udVMN/WVTmJwt3mJ2JP3viCbkpWVOiqz+6P1WfswKhwM1zWBCROOfc9HYf7o2Rcvs0
         Uen79iZwL07Hv6lDesUEn7R0CGO7CUdK+KFNLCYF5C/gm7jMYMdolmn8styoBp1072cC
         2ArDCO4iNItC0Qt1g5JInREg5XmC1jxqc1ElomfSMuCUrdBdAhT8tigHCMUfwOHAB589
         AdC4Vyfup9bhHdYztjx3M/APhth4QBSdK7evQ1+DmmprCUJd9MM8qtnAzyZnHVnJLaOa
         WsIac9qzqa3Hh3ia98zgpxCzBBFxAxkCjKqvZsu/qIvpVBHh7XvAj3glfwulERA2nMiC
         bFPA==
X-Gm-Message-State: AOAM532bZr3bxda6OD1VxCj3UjshI/cItBXX9D5QCaqVY01QZ30nhCYr
        7wWl5LJVm0duT1F6fhMUOu7m7w==
X-Google-Smtp-Source: ABdhPJyfYj3y+aITLPJMoFfkbKim6QuwDDCwSnjF2f6qJec1TqoxVfmWD7Dtdz8hfEEmF2y6ivn2lQ==
X-Received: by 2002:aa7:8889:0:b0:4f7:7283:e378 with SMTP id z9-20020aa78889000000b004f77283e378mr21762281pfe.36.1647833176381;
        Sun, 20 Mar 2022 20:26:16 -0700 (PDT)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id c3-20020a056a00248300b004f6f729e485sm17582022pfv.127.2022.03.20.20.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 20:26:15 -0700 (PDT)
Message-ID: <6237f057.1c69fb81.1689.fec7@mx.google.com>
From:   Daniel Beer <daniel.beer@tirotech.co.nz>
Date:   Mon, 21 Mar 2022 16:16:27 +1300
Subject: [PATCH] winmate-fm07-keys: Winmate FM07/FM07P buttons
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Beer <daniel.beer@tirotech.co.nz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/platform/x86/Kconfig             |   8 +
 drivers/platform/x86/Makefile            |   3 +
 drivers/platform/x86/winmate-fm07-keys.c | 184 +++++++++++++++++++++++
 3 files changed, 195 insertions(+)
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
index 000000000000..3e75adb15444
--- /dev/null
+++ b/drivers/platform/x86/winmate-fm07-keys.c
@@ -0,0 +1,184 @@
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
+timeout:
+	dev_err(&input->dev, "timeout polling IO memory\n");
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
+/************************************************************************
+ * Device instance for the FM07
+ */
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
+};
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
+	if (!dev) {
+		pr_err("fm07keys: failed to allocate device\n");
+		ret = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	return 0;
+fail_alloc:
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

