Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526852E033
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiESXBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbiESXBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:01:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138111446
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:00:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ev18so6515487pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVmXcvX5RI0eUQU+0pWHTtIEk1TgLh8qYyVgwB1l/Yc=;
        b=aeASWatYdgTkxr8Y7aeWjlioyeD1lkR3R12ZCkEl+hiIR9iPjgJc7ji64JOHhA4HF6
         g2bHtRU2s2hXUvykYPXiVuAlTCIT8Rh5E2E/xkgQaJEY+wrajnYoLx3NcSOmGvR0s6h9
         BKTiq3j1qWxH0O1kMFLHjg4Mzhp7BN10Q0X4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVmXcvX5RI0eUQU+0pWHTtIEk1TgLh8qYyVgwB1l/Yc=;
        b=4RBfKZSG+6cAWPt+gyjWU9tAqXgULJCha+lPJAvZ8Q7/0yClK5lJLqqjkrmQ5L7S27
         3tCp6jCOLUfQlhxAXc1yR+l+B2vkcT2Vh7/emPJeAIl2+iYLw6bFypRjg8qdmjJs2ASR
         N2zANoWjyzQFKK6p4uiH+uP39jMHO0DvSVeX+60mm9ZwidpmDnRIog59zYz3tdrDkhgq
         3eg7o2kJkq8Cd+escwV5baifPqx8qlvf9n9J/XW630RQgyj4Tejv0OHtj5bRb6N7vulk
         ZiS6vk7bJQH5kvahr6anAVQ7Unle/6m/7i6NWRVtVWVtQ3Cj9F1v5mfLxwU1n3HwbJ0/
         JUow==
X-Gm-Message-State: AOAM530OscB2Oyb1mQxqHSRhFwAz2VGU6j0ar4iH37UHPVNmhuooZdpt
        VqjRpnMr+AswtyUwozS7QV4Pdw==
X-Google-Smtp-Source: ABdhPJxEXU5RdehzZShhtByJsSe7J+5AZQfabkXzbPtvHpx41zBvrdYzh50n2lawqtkILJKCRo8OZQ==
X-Received: by 2002:a17:90a:4fe1:b0:1de:fc11:331e with SMTP id q88-20020a17090a4fe100b001defc11331emr7477326pjh.145.1653001256167;
        Thu, 19 May 2022 16:00:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:e45f:1f3c:299b:4d86])
        by smtp.gmail.com with ESMTPSA id m10-20020a056a00080a00b0050dc762819csm202411pfk.118.2022.05.19.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 16:00:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     swboyd@chromium.org, linux-input@vger.kernel.org, mka@chromium.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens
Date:   Thu, 19 May 2022 16:00:03 -0700
Message-Id: <20220519155925.2.I2d3f735a485157eeaa24d60be8a327f98101789d@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220519155925.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
References: <20220519155925.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like many i2c-hid touchscreen controllers, the Elan eKTH6915 has a
reset GPIO hooked up to it. According to the datasheet, the way we're
supposed to turn the touchscreen on is:

1. Turn on the 3.3V supply.
2. Turn on the IO supply. It's OK if this is hardwired to the 3.3V
   supply, but if it's not then it must be turned on _after_ the 3.3V
   supply.
3. Wait >= 1 ms.
4. Deassert the reset GPIO (reset GPIO is active low, so there would
   be a leakage path if this was deasserted _before_ the IO supply).
5. Wait 300 ms.

Much of the above can be handled by the generic i2c-hid-of driver, but
the "reset" GPIO is not supported by that driver. Thus we'll do the
same as we did for Goodix and add a new tiny driver that uses the
i2c-hid core.

NOTE: support for this new touchscreen could theorically fit into the
Goodix driver. I've made it a separate driver because the Elan driver
supports _two_ regulators and it's unclear exactly how that would fit
in with commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line
to true state of the regulator").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/hid/i2c-hid/Kconfig           |  15 +++
 drivers/hid/i2c-hid/Makefile          |   1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 127 ++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-of-elan.c

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index a16c6a69680b..5273ee2bb134 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -32,6 +32,21 @@ config I2C_HID_OF
 	  will be called i2c-hid-of.  It will also build/depend on the
 	  module i2c-hid.
 
+config I2C_HID_OF_ELAN
+	tristate "Driver for Elan hid-i2c based devices on OF systems"
+	default n
+	depends on I2C && INPUT && OF
+	help
+	  Say Y here if you want support for Elan i2c devices that use
+	  the i2c-hid protocol on Open Firmware (Device Tree)-based
+	  systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-hid-of-elan.  It will also build/depend on
+	  the module i2c-hid.
+
 config I2C_HID_OF_GOODIX
 	tristate "Driver for Goodix hid-i2c based devices on OF systems"
 	default n
diff --git a/drivers/hid/i2c-hid/Makefile b/drivers/hid/i2c-hid/Makefile
index 302545a771f3..55bd5e0f35af 100644
--- a/drivers/hid/i2c-hid/Makefile
+++ b/drivers/hid/i2c-hid/Makefile
@@ -10,4 +10,5 @@ i2c-hid-$(CONFIG_DMI)				+= i2c-hid-dmi-quirks.o
 
 obj-$(CONFIG_I2C_HID_ACPI)			+= i2c-hid-acpi.o
 obj-$(CONFIG_I2C_HID_OF)			+= i2c-hid-of.o
+obj-$(CONFIG_I2C_HID_OF_ELAN)			+= i2c-hid-of-elan.o
 obj-$(CONFIG_I2C_HID_OF_GOODIX)			+= i2c-hid-of-goodix.o
diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
new file mode 100644
index 000000000000..e2b3456e97b5
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Elan touchscreens that use the i2c-hid protocol.
+ *
+ * Copyright 2020 Google LLC
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
+
+#include "i2c-hid.h"
+
+struct elan_i2c_hid_timing_data {
+	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_power_delay_ms;
+};
+
+struct i2c_hid_of_elan {
+	struct i2chid_ops ops;
+
+	struct regulator *vcc33;
+	struct regulator *vccio;
+	struct gpio_desc *reset_gpio;
+	const struct elan_i2c_hid_timing_data *timings;
+};
+
+static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
+{
+	struct i2c_hid_of_elan *ihid_elan =
+		container_of(ops, struct i2c_hid_of_elan, ops);
+	int ret;
+
+	ret = regulator_enable(ihid_elan->vcc33);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(ihid_elan->vccio);
+	if (ret) {
+		regulator_disable(ihid_elan->vcc33);
+		return ret;
+	}
+
+	if (ihid_elan->timings->post_power_delay_ms)
+		msleep(ihid_elan->timings->post_power_delay_ms);
+
+	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
+	if (ihid_elan->timings->post_gpio_reset_delay_ms)
+		msleep(ihid_elan->timings->post_gpio_reset_delay_ms);
+
+	return 0;
+}
+
+static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
+{
+	struct i2c_hid_of_elan *ihid_elan =
+		container_of(ops, struct i2c_hid_of_elan, ops);
+
+	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	regulator_disable(ihid_elan->vccio);
+	regulator_disable(ihid_elan->vcc33);
+}
+
+static int i2c_hid_of_elan_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	struct i2c_hid_of_elan *ihid_elan;
+
+	ihid_elan = devm_kzalloc(&client->dev, sizeof(*ihid_elan), GFP_KERNEL);
+	if (!ihid_elan)
+		return -ENOMEM;
+
+	ihid_elan->ops.power_up = elan_i2c_hid_power_up;
+	ihid_elan->ops.power_down = elan_i2c_hid_power_down;
+
+	/* Start out with reset asserted */
+	ihid_elan->reset_gpio =
+		devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ihid_elan->reset_gpio))
+		return PTR_ERR(ihid_elan->reset_gpio);
+
+	ihid_elan->vccio = devm_regulator_get(&client->dev, "vccio");
+	if (IS_ERR(ihid_elan->vccio))
+		return PTR_ERR(ihid_elan->vccio);
+
+	ihid_elan->vcc33 = devm_regulator_get(&client->dev, "vcc33");
+	if (IS_ERR(ihid_elan->vcc33))
+		return PTR_ERR(ihid_elan->vcc33);
+
+	ihid_elan->timings = device_get_match_data(&client->dev);
+
+	return i2c_hid_core_probe(client, &ihid_elan->ops, 0x0001, 0);
+}
+
+static const struct elan_i2c_hid_timing_data elan_ekth6915_timing_data = {
+	.post_power_delay_ms = 1,
+	.post_gpio_reset_delay_ms = 300,
+};
+
+static const struct of_device_id elan_i2c_hid_of_match[] = {
+	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_timing_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
+
+static struct i2c_driver elan_i2c_hid_ts_driver = {
+	.driver = {
+		.name	= "i2c_hid_of_elan",
+		.pm	= &i2c_hid_core_pm,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = of_match_ptr(elan_i2c_hid_of_match),
+	},
+	.probe		= i2c_hid_of_elan_probe,
+	.remove		= i2c_hid_core_remove,
+	.shutdown	= i2c_hid_core_shutdown,
+};
+module_i2c_driver(elan_i2c_hid_ts_driver);
+
+MODULE_AUTHOR("Douglas Anderson <dianders@chromium.org>");
+MODULE_DESCRIPTION("Elan i2c-hid touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.36.1.124.g0e6072fb45-goog

