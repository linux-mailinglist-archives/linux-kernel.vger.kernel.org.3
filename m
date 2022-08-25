Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493745A1520
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiHYPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242643AbiHYPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:02:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FEB69D4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:02:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so40058030ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JDSsnMBb5bGyEIsqOFE4oogNFTJPK6bYb53NB3jHEAk=;
        b=Be2BaRurQZvcr8gg5hG1lcFg1H3YnBNusHA/x/vbqUI7kZqP4fpq3AGooHrdULWgQo
         JzCEsl3P/1a2sU9LFPxFMRkjLUIlbbrAXJ+lzL6xlUz4bIJ+28zGWXGnHLcKav+kTO+U
         eV6X9YmpUBEjswhLT4C4qM7FOWnM8ACCa2ZeZX4cBXEXfzeJWEwjCwr69OoqcGMbdd9P
         pM6p0WaoSTpoqSuzipckFHDXD2Lx1p1pkcVH1qFtqjw1d0cs0zcqD2GvndO8SdIfB3L1
         fdws4x0yohO1EuY3TyKmD99A5NPtkbhAvsSWNzYFdIKwf6qxRTXAVnlD8X5+YovPoeN8
         kdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JDSsnMBb5bGyEIsqOFE4oogNFTJPK6bYb53NB3jHEAk=;
        b=g5wlU6BqRdHIOVHiIMaM/uMvlMPOwjnwodcTHjb17N9y+UFC1mNVwJEE1gcVAfPrJr
         X+zxvMC+9jqFpJlvkpjLbzHo6hAYC2QsdmeEXYiBZpbv6iK5NISSBrHibvlWJZTEUKYp
         osqGB4u2+252MnL2k8yeXwnXEPDUt+iA2JNFgsp/hCoGZqt3dDOXWocaty30agU1BlGr
         N2JJinq9e5VNhYPtieiC9EXooLLWIcI+PAf92Twx6zDtwg29hr+mAqBP5APb2l5iqzgd
         n7P05113adWgVe4skuHOdTxyVoYljlLwHtsIKKuy+TKie3Vl9rvF5Ue2S0LFkcZ2U0su
         0X9A==
X-Gm-Message-State: ACgBeo3Ly0cnKIQ/WTqYmZBtFnfNMOCmyLKmPl4hkiE0DxI6Lgv7dUc2
        dbvug7q0MhxtuuXgJ208BAGZMw==
X-Google-Smtp-Source: AA6agR5w8EYyZM+LT9oNmJZ9c3AZmHgf221DS7nuO8bFYNFll050twW2UHRsMe/GbysTYYIFar4uEA==
X-Received: by 2002:a17:907:75c9:b0:73d:c6b2:538c with SMTP id jl9-20020a17090775c900b0073dc6b2538cmr2750586ejc.432.1661439756325;
        Thu, 25 Aug 2022 08:02:36 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b00732e3d94f4fsm2548771eje.124.2022.08.25.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:02:35 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>,
        nm@ti.com, kristo@kernel.org
Cc:     Jerome Neanne <jneanne@baylibre.com>, khilman@baylibre.com,
        narmstrong@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 5/6] Input: Add tps65219 interrupt driven powerbutton
Date:   Thu, 25 Aug 2022 17:02:23 +0200
Message-Id: <20220825150224.826258-6-msp@baylibre.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825150224.826258-1-msp@baylibre.com>
References: <20220825150224.826258-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS65219 has different interrupts compared to other TPS6521* chips.
TPS65219 defines two interrupts for the powerbutton one for push and one
for release.

This driver is very simple in that it maps the push interrupt to a key
input and the release interrupt to a key release.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/input/misc/Kconfig              |  10 ++
 drivers/input/misc/Makefile             |   1 +
 drivers/input/misc/tps65219-pwrbutton.c | 149 ++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab7358d8f..18d4a321e7ff 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -468,6 +468,16 @@ config INPUT_TPS65218_PWRBUTTON
 	  To compile this driver as a module, choose M here. The module will
 	  be called tps65218-pwrbutton.
 
+config INPUT_TPS65219_PWRBUTTON
+	tristate "TPS65219 Power button driver"
+	depends on MFD_TPS65219
+	help
+	  Say Y here if you want to enable power button reporting for
+	  TPS65219 Power Management IC devices.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called tps65219-pwrbutton.
+
 config INPUT_AXP20X_PEK
 	tristate "X-Powers AXP20X power button driver"
 	depends on MFD_AXP20X
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 28dfc444f0a9..fe8f47402d12 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
+obj-$(CONFIG_INPUT_TPS65219_PWRBUTTON)	+= tps65219-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
 obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+= twl6040-vibra.o
diff --git a/drivers/input/misc/tps65219-pwrbutton.c b/drivers/input/misc/tps65219-pwrbutton.c
new file mode 100644
index 000000000000..163b545d5a54
--- /dev/null
+++ b/drivers/input/misc/tps65219-pwrbutton.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for TPS65219 Push Button
+//
+// Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/tps65219.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+struct tps65219_pwrbutton {
+	struct device *dev;
+	struct input_dev *idev;
+	char phys[32];
+};
+
+static irqreturn_t tps65219_pb_push_irq(int irq, void *_pwr)
+{
+	struct tps65219_pwrbutton *pwr = _pwr;
+
+	input_report_key(pwr->idev, KEY_POWER, 1);
+	pm_wakeup_event(pwr->dev, 0);
+	input_sync(pwr->idev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tps65219_pb_release_irq(int irq, void *_pwr)
+{
+	struct tps65219_pwrbutton *pwr = _pwr;
+
+	input_report_key(pwr->idev, KEY_POWER, 0);
+	input_sync(pwr->idev);
+
+	return IRQ_HANDLED;
+}
+
+static int tps65219_pb_probe(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct tps65219_pwrbutton *pwr;
+	struct input_dev *idev;
+	int error;
+	int push_irq;
+	int release_irq;
+
+	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
+	if (!pwr)
+		return -ENOMEM;
+
+	idev = devm_input_allocate_device(dev);
+	if (!idev)
+		return -ENOMEM;
+
+	idev->name = pdev->name;
+	snprintf(pwr->phys, sizeof(pwr->phys), "%s/input0",
+		 pdev->name);
+	idev->phys = pwr->phys;
+	idev->dev.parent = dev;
+	idev->id.bustype = BUS_I2C;
+
+	input_set_capability(idev, EV_KEY, KEY_POWER);
+
+	pwr->dev = dev;
+	pwr->idev = idev;
+	device_init_wakeup(dev, true);
+
+	push_irq = platform_get_irq(pdev, 0);
+	if (push_irq < 0)
+		return -EINVAL;
+
+	release_irq = platform_get_irq(pdev, 1);
+	if (release_irq < 0)
+		return -EINVAL;
+
+	error = devm_request_threaded_irq(dev, push_irq, NULL,
+					  tps65219_pb_push_irq,
+					  IRQF_ONESHOT,
+					  dev->init_name, pwr);
+	if (error) {
+		dev_err(dev, "failed to request push IRQ #%d: %d\n", push_irq,
+			error);
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, release_irq, NULL,
+					  tps65219_pb_release_irq,
+					  IRQF_ONESHOT,
+					  dev->init_name, pwr);
+	if (error) {
+		dev_err(dev, "failed to request release IRQ #%d: %d\n",
+			release_irq, error);
+		return error;
+	}
+
+	error = input_register_device(idev);
+	if (error) {
+		dev_err(dev, "Can't register power button: %d\n", error);
+		return error;
+	}
+
+	/* Enable interrupts for the pushbutton */
+	regmap_clear_bits(tps->regmap, TPS65219_REG_MASK_CONFIG,
+			  TPS65219_REG_MASK_INT_FOR_PB_MASK);
+
+	/* Set PB/EN/VSENSE pin to be a pushbutton */
+	regmap_update_bits(tps->regmap, TPS65219_REG_MFP_2_CONFIG,
+			   TPS65219_MFP_2_EN_PB_VSENSE_MASK, TPS65219_MFP_2_PB);
+
+	return 0;
+}
+
+static int tps65219_pb_remove(struct platform_device *pdev)
+{
+	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
+
+	/* Disable interrupt for the pushbutton */
+	return regmap_update_bits(tps->regmap, TPS65219_REG_MASK_CONFIG,
+				  TPS65219_REG_MASK_INT_FOR_PB_MASK,
+				  TPS65219_REG_MASK_INT_FOR_PB_MASK);
+}
+
+static const struct platform_device_id tps65219_pwrbtn_id_table[] = {
+	{ "tps65219-pwrbutton", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65219_pwrbtn_id_table);
+
+static struct platform_driver tps65219_pb_driver = {
+	.probe = tps65219_pb_probe,
+	.remove = tps65219_pb_remove,
+	.driver = {
+		.name = "tps65219_pwrbutton",
+	},
+	.id_table = tps65219_pwrbtn_id_table,
+};
+module_platform_driver(tps65219_pb_driver);
+
+MODULE_DESCRIPTION("TPS65219 Power Button");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Markus Schneider-Pargmann <msp@baylibre.com");
-- 
2.37.2

