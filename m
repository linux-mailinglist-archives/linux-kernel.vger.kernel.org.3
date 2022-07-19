Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E78579616
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiGSJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbiGSJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577B01FCD5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n185so8576264wmn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GlSp8iTeisTCimROv6Ht4fAgwdi/6OcwNMuuTk8KBSM=;
        b=iBI77o9V/gp6jM0yQj/0ktbtM00c3G3rxn1lFsDv6kqvc3t8WKiH1E8lmyIR/PTUcT
         HChE6b6DxOD/YtxzEAfh7DDFdhjm/cvENT8cygifON/WgVTAVH5rpsE6t8JkMIF5SCaK
         42DB4m7eXrTyBH5kJLqlH1G3miHA8sxBHODxhifUda52IYhPL2ndCAfSckJvuiXr//1N
         srmzhDGo9hlq0bzX+xxFRj7Z9dpG8qzmqc12S77v30ziXL0udDynaJLH1NNuaOMn570+
         dp2Ie6tMR0jOWQzgV9oDz4PK2KZUdu7mN7q72Fvz/ZwpFfcVTzrCo0S0jSM6OwZ1/Skz
         K7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GlSp8iTeisTCimROv6Ht4fAgwdi/6OcwNMuuTk8KBSM=;
        b=DK86Ik8ifpaP/b36gQSUQynXkRml43VEBjlnes8PMLplEh/KuKAfiOlE1cG+nokF0C
         DRBEOcpmAILRgyxrsHKIUKeuci7TDIww/bbVOWhWzQqpY25wkBphbiYylt+M1WSGl0Ak
         nSGgFo56tOGS+gQUxRsV4XcGZ93TyT4vKIMUegWBs/hWHPXIHKUvTm9RjMhtCAlrWjPp
         nQaAFuXFeO+FiQYFWtzrIvwlEwPocrlPmq88sH7i12YtvJcFajoCDAmKnBateUyBcWOz
         qRQ11hV59mokOBmVcDyq89KLugbCAFX3viinOPy2hiS/DW7Pic8syqCbNxuZ9WoFOCQi
         /Y9A==
X-Gm-Message-State: AJIora98BISw+CQN3FVw4BCmWFWoj4gPGQYwMxiFLjNEzmH8GT9EokaB
        E1xv9Z+p0miT0iQ0HBvQuMbpFA==
X-Google-Smtp-Source: AGRyM1s4xFOXLTEMI2UZFRXhoETTWkmxSy1/dl4LvSBkEtcvXZlZthnH9xNHVH8Pcxeyp8V7oc+e5w==
X-Received: by 2002:a05:600c:a02:b0:39d:bdf8:a4f4 with SMTP id z2-20020a05600c0a0200b0039dbdf8a4f4mr29762740wmp.201.1658222284897;
        Tue, 19 Jul 2022 02:18:04 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b0021d63fe0f03sm12944281wrb.12.2022.07.19.02.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:18:04 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org
Cc:     khilman@baylibre.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.c, lee.jones@linaro.org, jneanne@baylibre.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 09/14] Input: Add tps65219 interrupt driven powerbutton
Date:   Tue, 19 Jul 2022 11:17:37 +0200
Message-Id: <20220719091742.3221-10-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719091742.3221-1-jneanne@baylibre.com>
References: <20220719091742.3221-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

TPS65219 has different interrupts compared to other TPS6521* chips.
TPS65219 defines two interrupts for the powerbutton one for push and one
for release.

This driver is very simple in that it maps the push interrupt to a key
input and the release interrupt to a key release.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 MAINTAINERS                             |   1 +
 drivers/input/misc/Kconfig              |  10 ++
 drivers/input/misc/Makefile             |   1 +
 drivers/input/misc/tps65219-pwrbutton.c | 150 ++++++++++++++++++++++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e6ee583f3ff..fdd547ac8c6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14705,6 +14705,7 @@ F:	arch/arm/plat-omap/
 F:	drivers/bus/ti-sysc.c
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/input/misc/tps65218-pwrbutton.c
+F:	drivers/input/misc/tps65219-pwrbutton.c
 F:	drivers/irqchip/irq-omap-intc.c
 F:	drivers/mfd/*omap*.c
 F:	drivers/mfd/menelaus.c
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
index 000000000000..c3285424c0f7
--- /dev/null
+++ b/drivers/input/misc/tps65219-pwrbutton.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for TPS65219 Push Button
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ */
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
2.17.1

