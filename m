Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92EF4B1304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiBJQiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:38:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244358AbiBJQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:37:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D1E9E;
        Thu, 10 Feb 2022 08:37:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d27so6819859wrb.5;
        Thu, 10 Feb 2022 08:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKzVtAvCwdEpHMxCrDR9AUzhEZaHIpgwBEB3o5kBWNY=;
        b=LWKzm8KxQYJegGNtE9GlWVJ9tT0pS9v88zmASBYxx3U5u1JzGDu2UM6GYujX11NvFU
         H1XBTD6rdYCZ+EyT5u5b1lSllIR3f2Bv6OocHccSKXL4ZmJ8t8bpw7dvJyNphA38XZSn
         O6ckTZ2Des3F7CposhgY8hmcegNPrmZ9wgTLoTtoQ56wAj+zTGuGGg34zxuPGVaKKYPy
         /tPILriS/zIxyM1pjMs4srN3apLCVS5WVIFxuc3dpEFig3s7v5AX4di/4JbqAcmizU4r
         AY0fZ9ly1G5EZ7uiLg6HuKU1fttpxsMFbdSHiBa0LzrPkz4J0aOHWcQE+6JsJ3+ciazV
         Zm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKzVtAvCwdEpHMxCrDR9AUzhEZaHIpgwBEB3o5kBWNY=;
        b=7Xb843WVmRT5uyDdhkH7aD19qm4PlicONiVemLcJDHsr8VGJNUUs7xPMKKIQvDwuzw
         +oSOWrchwpI6TVPCuza7cgyVTNwfebR32yZ4lXmKxDyU4xJ4sTVdEIz2GquDdYij3zNu
         Zgopp/9+sdU1EADLxRAeioqlKnJB6r4/z67PGZQ469HXEl7RD4Mth8glRlO1o76KfzBZ
         rL+0Oz50kMpJljvLYp8t1GC45W2enL7g5ICJA0tvSjzI/nMZdpyQdLJ75ypE8wxP2zYX
         9sXjRQSoIT7yguhJSgmKq5ARgLrELJ+N2NLSlixopuL8NdDCbbF32AyPRQZ4XjSF9TeJ
         XTyg==
X-Gm-Message-State: AOAM532vJEAdI+ZBaDpeu/xmFN9jAAv2WhuC6VIe2lU3Wl/2HM392ovQ
        y+GwDSHevq3KeaR+WUqYSCU79SLDd2NeGg==
X-Google-Smtp-Source: ABdhPJwrbm00BB15TQ5s9ECqqQ0PxNqD2Ore4tMBI51yODK/zDcsU/HUAnpgoDo5wJDwHdDOCvkXNA==
X-Received: by 2002:a5d:4e4f:: with SMTP id r15mr2567868wrt.505.1644511063595;
        Thu, 10 Feb 2022 08:37:43 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id k5sm5871795wrw.117.2022.02.10.08.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 08:37:43 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] Input: add Imagis touchscreen driver
Date:   Thu, 10 Feb 2022 18:37:07 +0200
Message-Id: <20220210163708.162866-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220210163708.162866-1-markuss.broks@gmail.com>
References: <20220210163708.162866-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IST3038C touchscreen IC from Imagis, based on
downstream driver. The driver supports multi-touch (10 touch points)
The IST3038C IC supports touch keys, but the support isn't added
because the touch screen used for testing doesn't utilize touch keys.
Looking at the downstream driver, it is possible to add support
for other Imagis ICs of IST30**C series.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 MAINTAINERS                        |   6 +
 drivers/input/touchscreen/Kconfig  |  10 +
 drivers/input/touchscreen/Makefile |   1 +
 drivers/input/touchscreen/imagis.c | 329 +++++++++++++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 drivers/input/touchscreen/imagis.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a899828a8d4e..f7f717ae926a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9405,6 +9405,12 @@ F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
 F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
+IMAGIS TOUCHSCREEN DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
+F:	drivers/input/touchscreen/imagis.c
+
 IKANOS/ADI EAGLE ADSL USB DRIVER
 M:	Matthieu Castet <castet.matthieu@free.fr>
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2f6adfb7b938..6810b4b094e8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1367,4 +1367,14 @@ config TOUCHSCREEN_ZINITIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called zinitix.
 
+config TOUCHSCREEN_IMAGIS
+	tristate "Imagis touchscreen support"
+	depends on I2C
+	help
+		Say Y here if you have an Imagis IST30xxC touchscreen.
+		If unsure, say N.
+
+		To compile this driver as a module, choose M here: the
+		module will be called imagis.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 39a8127cf6a5..989bb1d563d3 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -115,3 +115,4 @@ obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
 obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
 obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
+obj-$(CONFIG_TOUCHSCREEN_IMAGIS)	+= imagis.o
diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
new file mode 100644
index 000000000000..308f097a95c1
--- /dev/null
+++ b/drivers/input/touchscreen/imagis.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+
+#define IST3038_ADDR_LEN		4
+#define IST3038_DATA_LEN		4
+#define IST3038_HIB_ACCESS		(0x800B << 16)
+#define IST3038_DIRECT_ACCESS   BIT(31)
+#define IST3038_REG_CHIPID      0x40001000
+
+#define IST3038_REG_HIB_BASE		(0x30000100)
+#define IST3038_REG_TOUCH_STATUS        (IST3038_REG_HIB_BASE | IST3038_HIB_ACCESS)
+#define IST3038_REG_TOUCH_COORD        (IST3038_REG_HIB_BASE | IST3038_HIB_ACCESS | 0x8)
+#define IST3038_REG_INTR_MESSAGE        (IST3038_REG_HIB_BASE | IST3038_HIB_ACCESS | 0x4)
+
+#define IST3038C_WHOAMI			0x38c
+#define CHIP_ON_DELAY				60 // ms
+
+#define I2C_RETRY_COUNT			3
+
+#define MAX_SUPPORTED_FINGER_NUM		10
+
+struct imagis_ts {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct touchscreen_properties prop;
+	struct regulator_bulk_data supplies[2];
+};
+
+static int imagis_i2c_read_reg(struct imagis_ts *ts,
+			       unsigned int reg, unsigned int *buffer)
+{
+	unsigned int reg_be = __cpu_to_be32(reg);
+	struct i2c_msg msg[] = {
+		{
+			.addr = ts->client->addr,
+			.flags = 0,
+			.buf = (unsigned char *)&reg_be,
+			.len = IST3038_ADDR_LEN,
+		}, {
+			.addr = ts->client->addr,
+			.flags = I2C_M_RD,
+			.buf = (unsigned char *)buffer,
+			.len = IST3038_DATA_LEN,
+		},
+	};
+	int res;
+	int error;
+	int retry = I2C_RETRY_COUNT;
+
+	do {
+		res = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
+		if (res == ARRAY_SIZE(msg)) {
+			*buffer = __be32_to_cpu(*buffer);
+			return 0;
+		}
+
+		error = res < 0 ? res : -EIO;
+		dev_err(&ts->client->dev,
+			"%s - i2c_transfer failed: %d (%d)\n",
+			__func__, error, res);
+	} while (--retry);
+
+	return error;
+}
+
+static irqreturn_t imagis_interrupt(int irq, void *dev_id)
+{
+	struct imagis_ts *ts = dev_id;
+	unsigned int finger_status, intr_message;
+	int ret, i, finger_count, finger_pressed;
+
+	ret = imagis_i2c_read_reg(ts, IST3038_REG_INTR_MESSAGE, &intr_message);
+	if (ret) {
+		dev_err(&ts->client->dev, "failed to read the interrupt message\n");
+		return IRQ_HANDLED;
+	}
+
+	finger_count = (intr_message >> 12) & 0xF;
+	finger_pressed = intr_message & 0x3FF;
+	if (finger_count > 10) {
+		dev_err(&ts->client->dev, "finger count is more than maximum supported\n");
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < finger_count; i++) {
+		ret = imagis_i2c_read_reg(ts, IST3038_REG_TOUCH_COORD + (i * 4), &finger_status);
+		if (ret) {
+			dev_err(&ts->client->dev, "failed to read coordinates for finger %d\n", i);
+			return IRQ_HANDLED;
+		}
+		input_mt_slot(ts->input_dev, i);
+		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
+					   (finger_pressed & BIT(i)) ? 1 : 0);
+		touchscreen_report_pos(ts->input_dev, &ts->prop,
+				       (finger_status >> 12) & 0xFFF, finger_status & 0xFFF, 1);
+		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, (finger_status >> 24) & 0xFFF);
+	}
+	input_mt_sync_frame(ts->input_dev);
+	input_sync(ts->input_dev);
+
+	return IRQ_HANDLED;
+}
+
+static int imagis_start(struct imagis_ts *ts)
+{
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies),
+				      ts->supplies);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to enable regulators: %d\n", error);
+		return error;
+	}
+
+	msleep(CHIP_ON_DELAY);
+
+	enable_irq(ts->client->irq);
+	return 0;
+}
+
+static int imagis_stop(struct imagis_ts *ts)
+{
+	int error;
+
+	disable_irq(ts->client->irq);
+
+	error = regulator_bulk_disable(ARRAY_SIZE(ts->supplies),
+				       ts->supplies);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to disable regulators: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int imagis_input_open(struct input_dev *dev)
+{
+	struct imagis_ts *ts = input_get_drvdata(dev);
+
+	return imagis_start(ts);
+}
+
+static void imagis_input_close(struct input_dev *dev)
+{
+	struct imagis_ts *ts = input_get_drvdata(dev);
+
+	imagis_stop(ts);
+}
+
+static int imagis_init_input_dev(struct imagis_ts *ts)
+{
+	struct input_dev *input_dev;
+	int error;
+
+	input_dev = devm_input_allocate_device(&ts->client->dev);
+	if (!input_dev) {
+		dev_err(&ts->client->dev,
+			"Failed to allocate input device.");
+		return -ENOMEM;
+	}
+
+	ts->input_dev = input_dev;
+
+	input_dev->name = "Imagis capacitive touchscreen";
+	input_dev->phys = "input/ts";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->open = imagis_input_open;
+	input_dev->close = imagis_input_close;
+
+	input_set_drvdata(input_dev, ts);
+
+	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
+	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
+	input_set_abs_params(input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(input_dev, true, &ts->prop);
+	if (!ts->prop.max_x || !ts->prop.max_y) {
+		dev_err(&ts->client->dev,
+			"Touchscreen-size-x and/or touchscreen-size-y not set in dts\n");
+		return -EINVAL;
+	}
+
+	error = input_mt_init_slots(input_dev, MAX_SUPPORTED_FINGER_NUM,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to initialize MT slots: %d", error);
+		return error;
+	}
+
+	error = input_register_device(input_dev);
+	if (error) {
+		dev_err(&ts->client->dev,
+			"Failed to register input device: %d", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int imagis_init_regulators(struct imagis_ts *ts)
+{
+	struct i2c_client *client = ts->client;
+	int error;
+
+	ts->supplies[0].supply = "vdd";
+	ts->supplies[1].supply = "vddio";
+	error = devm_regulator_bulk_get(&client->dev,
+					ARRAY_SIZE(ts->supplies),
+					ts->supplies);
+	if (error < 0) {
+		dev_err(&client->dev, "Failed to get regulators: %d\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int imagis_probe(struct i2c_client *i2c)
+{
+	struct device *dev;
+	struct imagis_ts *ts;
+	int chip_id, ret;
+
+	dev = &i2c->dev;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client = i2c;
+
+	ret = devm_request_threaded_irq(dev, i2c->irq,
+					NULL, imagis_interrupt,
+					IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+					"imagis-touchscreen", ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "IRQ allocation failure: %d\n", ret);
+
+	ret = imagis_init_regulators(ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "regulator init error: %d\n", ret);
+
+	ret = imagis_start(ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "regulator enable error: %d\n", ret);
+
+	ret = imagis_i2c_read_reg(ts, IST3038_REG_CHIPID | IST3038_DIRECT_ACCESS, &chip_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "chip ID read failure: %d\n", ret);
+
+	if (chip_id == IST3038C_WHOAMI)
+		dev_info(dev, "Detected IST3038C chip\n");
+	else
+		return dev_err_probe(dev, -EINVAL, "unknown chip ID: 0x%x\n", chip_id);
+
+	ret = imagis_init_input_dev(ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "input subsystem init error: %d\n", ret);
+
+	return 0;
+}
+
+static int __maybe_unused imagis_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct imagis_ts *ts = i2c_get_clientdata(client);
+
+	mutex_lock(&ts->input_dev->mutex);
+
+	if (input_device_enabled(ts->input_dev))
+		imagis_stop(ts);
+
+	mutex_unlock(&ts->input_dev->mutex);
+
+	return 0;
+}
+
+static int __maybe_unused imagis_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct imagis_ts *ts = i2c_get_clientdata(client);
+
+	mutex_lock(&ts->input_dev->mutex);
+
+	if (input_device_enabled(ts->input_dev))
+		imagis_start(ts);
+
+	mutex_unlock(&ts->input_dev->mutex);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id imagis_of_match[] = {
+	{ .compatible = "imagis,ist3038c", },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, imagis_of_match);
+#endif
+
+static struct i2c_driver imagis_ts_driver = {
+	.driver = {
+		   .name = "imagis-touchscreen",
+		   .pm = &imagis_pm_ops,
+		   .of_match_table = of_match_ptr(imagis_of_match),
+	},
+	.probe_new	= imagis_probe,
+};
+
+module_i2c_driver(imagis_ts_driver);
+
+MODULE_DESCRIPTION("Imagis IST3038C Touchscreen Driver");
+MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.0

