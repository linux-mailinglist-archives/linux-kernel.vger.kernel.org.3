Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E512531DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiEWVXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiEWVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:23:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9949968D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:23:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so14189500pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOOCRWVQuYLT3FPHZGft954GFHbqYk00WcogZz6fNSc=;
        b=DMh172YL0SWz0Py50NQZeLA0sEYKpK55bwc4q7lq9cmOEyKsj0IeAuPX555J3dSUnt
         zNqMBOs2aqG6l36kV77RKtEUqBPJGkGLWndj0J8qwLHonQIXgZ1omt0uQuv7hzJoPOAv
         dmIERaPWSV6NjGEh3TmVDBuwzCRhes5t9XX7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOOCRWVQuYLT3FPHZGft954GFHbqYk00WcogZz6fNSc=;
        b=AC3nCRxg/ntFllZzQsAlENYo6hbbeGI4dDnF71FEybAJ+c70Ih4skpOg/fceStkI6P
         LqfYYOLz4KFmt55yGxLIdQeQeOolIgokjA7sZKY/yKmhHBGaoNSYhqlbt/mHI7cHbPHy
         NkLPIzdvHjnrBbA3tINTN2Cf5LZ2uF7kH19gEpXAjAr8e2iUx+MJzW+UG+KCsCmxuk7A
         EQLMDewOtAq+xRp+UsjysD+f2NEV7z6M4devAKa3O8PWU3S2x5NXaEoGSfAXu/vNbArB
         /ahonLf/oYECS+QnWpPKBVikGDJtuGDNXxz4HkuEj7f3MyaJZ9nni85fLStWyuxTKVeN
         wwJQ==
X-Gm-Message-State: AOAM530VTpjk/pjf4gCUqeCZlYp8BwrANYXhjGaV0Mu46HeVedyLZ51I
        mBAxhHF1xWCEn16KU6Qk2vP1hw==
X-Google-Smtp-Source: ABdhPJwf7Nn4MG1Gs9/6Uf4iOuIkG1SRZfDvZje9RX2YSEEoa0x2v9W0UUyha5liZ667CvK0UX7nLg==
X-Received: by 2002:a17:90b:4a01:b0:1dc:67b8:983f with SMTP id kk1-20020a17090b4a0100b001dc67b8983fmr980579pjb.1.1653341011249;
        Mon, 23 May 2022 14:23:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:64b0:b6b9:c0f3:1cc8])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ec8200b0015e8d4eb234sm5545922plg.126.2022.05.23.14.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:23:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens
Date:   Mon, 23 May 2022 14:23:24 -0700
Message-Id: <20220523142257.v2.2.I2d3f735a485157eeaa24d60be8a327f98101789d@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
References: <20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Changes in v2:
- Add descriptor_address to data structure and rename.

 drivers/hid/i2c-hid/Kconfig           |  15 +++
 drivers/hid/i2c-hid/Makefile          |   1 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 130 ++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
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
index 000000000000..2d991325e734
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -0,0 +1,130 @@
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
+struct elan_i2c_hid_chip_data {
+	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_power_delay_ms;
+	u16 hid_descriptor_address;
+};
+
+struct i2c_hid_of_elan {
+	struct i2chid_ops ops;
+
+	struct regulator *vcc33;
+	struct regulator *vccio;
+	struct gpio_desc *reset_gpio;
+	const struct elan_i2c_hid_chip_data *chip_data;
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
+	if (ihid_elan->chip_data->post_power_delay_ms)
+		msleep(ihid_elan->chip_data->post_power_delay_ms);
+
+	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
+	if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
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
+				 const struct i2c_device_id *id)
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
+	ihid_elan->chip_data = device_get_match_data(&client->dev);
+
+	return i2c_hid_core_probe(client, &ihid_elan->ops,
+				  ihid_elan->chip_data->hid_descriptor_address, 0);
+}
+
+static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
+	.post_power_delay_ms = 1,
+	.post_gpio_reset_delay_ms = 300,
+	.hid_descriptor_address = 0x0001,
+};
+
+static const struct of_device_id elan_i2c_hid_of_match[] = {
+	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
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

