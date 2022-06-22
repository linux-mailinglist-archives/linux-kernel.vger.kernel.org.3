Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DD5548EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiFVKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiFVKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:02:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546C3A710;
        Wed, 22 Jun 2022 03:02:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so16255707pjl.5;
        Wed, 22 Jun 2022 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nSxpEZhvCFiheWcPpAzUjV5szaMFmSrVX/83LnEq3Y0=;
        b=Zddxt6XfQT2I87Y941KjE7UEtKeWzo9KXXE4Oc4ThTBGG6MIya3pIHFEep5v8AHWrA
         qoA8U3o19TNrAosbk6rQNcwQlVblYqaGLyjTezubQXT4x6SBwrETrlB/KtmTxfRnj1Ys
         jWg9z4ETeQPMhEuO9ytBzQoPSO6NXewl43HLOC8KHgHx5TVdz31x8OJQFK7t3RqZTr3K
         i2AC7JhOvLMw2K4MJCTnWVq8tNZXYc4Gqm3wHy2i3VsDfpJistygRIr5kgP/0cBLlSt3
         3raNY0j1bv0fahKCRqJbyVUjiVlUgPTItAKdhDM2TeJNpzbGt1J3O7gdN+bp5T5ejp+x
         emCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nSxpEZhvCFiheWcPpAzUjV5szaMFmSrVX/83LnEq3Y0=;
        b=znvpD2/csr9rb9B3pbKizA7LgTCw+1XOzyLCtqWswZMVaIBtxIzAn0b02GYDW9HWEV
         xvFpmjjXUFqGHhEE+0kltfzDF+LH1K0QRBVTnsHhs6pu3/0GCP0wDFVnUT4+RC4vWoF7
         0ti1KAoRSkSJSOyXWWB6BMgmZPwIkq3HaOVF92UlIuYBIH6cCzvlCt2LHf2bqGN9ZVC0
         rxCSf9tYzECBF09iUAwz8Gab6+LZDRL4zrjswlIVTvOghkTJSMd9kT/caykBgHLc9Nre
         UwgysHOWBcaF1085UGAD6rNG9ZnhvAhDT7cghVeIvpCGPUrdXu7xVXNPLE5E2hzhLSO3
         UDrA==
X-Gm-Message-State: AJIora8RimhxlFOWFGKJ78lYVBAtne/e3xDbX+eByukGxw9/ysHqfC/j
        RH+xMsHun6nJ1RnFoRvIY1w=
X-Google-Smtp-Source: AGRyM1sOuey7xzMdj3qefv+R64sZLBCmbt63gV8Ae3fQRErgnIlyWNytiUviqFOb2583TiAzYLjQng==
X-Received: by 2002:a17:902:dac7:b0:166:4ce4:7e32 with SMTP id q7-20020a170902dac700b001664ce47e32mr33400742plx.168.1655892126151;
        Wed, 22 Jun 2022 03:02:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:d40b:4089:31a8:340d:2f29])
        by smtp.gmail.com with ESMTPSA id w9-20020a639349000000b003fc5fd21752sm12790433pgm.50.2022.06.22.03.02.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:02:05 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 4/4] input: misc: rt5120: Add power key support
Date:   Wed, 22 Jun 2022 18:01:44 +0800
Message-Id: <1655892104-10874-5-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add RT5120 PMIC power key support.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/input/misc/Kconfig         |   9 +++
 drivers/input/misc/Makefile        |   1 +
 drivers/input/misc/rt5120-pwrkey.c | 115 +++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab73..0b976f8 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -891,6 +891,15 @@ config INPUT_SC27XX_VIBRA
 	  To compile this driver as a module, choose M here. The module will
 	  be called sc27xx_vibra.
 
+config INPUT_RT5120_PWRKEY
+	tristate "RT5120 PMIC power key support"
+	depends on MFD_RT5120
+	help
+	  This enables support for RT5120 PMIC power key driver.
+
+	  To compile this driver as a module, choose M here. the module will
+	  be called rt5120-pwerkey.
+
 config INPUT_STPMIC1_ONKEY
 	tristate "STPMIC1 PMIC Onkey support"
 	depends on MFD_STPMIC1
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 28dfc44..d1fb00e 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)	+= rave-sp-pwrbutton.o
 obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
 obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
 obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
+obj-$(CONFIG_INPUT_RT5120_PWRKEY)	+= rt5120-pwrkey.o
 obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
 obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
 obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
diff --git a/drivers/input/misc/rt5120-pwrkey.c b/drivers/input/misc/rt5120-pwrkey.c
new file mode 100644
index 00000000..42bd2f3
--- /dev/null
+++ b/drivers/input/misc/rt5120-pwrkey.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bits.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define RT5120_REG_INTSTAT	0x1E
+#define RT5120_PWRKEYSTAT_MASK	BIT(7)
+
+struct rt5120_priv {
+	struct regmap *regmap;
+	struct input_dev *input;
+	int press_irq;
+	int release_irq;
+};
+
+static irqreturn_t rt5120_pwrkey_handler(int irq, void *devid)
+{
+	struct rt5120_priv *priv = devid;
+	unsigned int stat;
+	bool is_pressed;
+	int ret;
+
+	ret = regmap_read(priv->regmap, RT5120_REG_INTSTAT, &stat);
+	if (ret)
+		return IRQ_NONE;
+
+	is_pressed = !(stat & RT5120_PWRKEYSTAT_MASK);
+
+	if ((is_pressed && irq == priv->press_irq) ||
+	    (!is_pressed  && irq == priv->release_irq)) {
+		input_report_key(priv->input, KEY_POWER, is_pressed);
+		input_sync(priv->input);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int rt5120_pwrkey_probe(struct platform_device *pdev)
+{
+	struct rt5120_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap) {
+		dev_err(&pdev->dev, "Failed to init regmap\n");
+		return -ENODEV;
+	}
+
+	priv->press_irq = platform_get_irq_byname(pdev, "pwrkey-press");
+	if (priv->press_irq < 0)
+		return priv->press_irq;
+
+	priv->release_irq = platform_get_irq_byname(pdev, "pwrkey-release");
+	if (priv->release_irq < 0)
+		return priv->release_irq;
+
+	/* Make input device be device resource managed */
+	priv->input = devm_input_allocate_device(&pdev->dev);
+	if (!priv->input) {
+		dev_err(&pdev->dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	priv->input->name = "rt5120_pwrkey";
+	priv->input->phys = "rt5120_pwrkey/input0";
+	priv->input->id.bustype = BUS_I2C;
+	input_set_capability(priv->input, EV_KEY, KEY_POWER);
+
+	ret = input_register_device(priv->input);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register input device\n");
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, priv->press_irq, NULL,
+					rt5120_pwrkey_handler, 0,
+					"pwrkey-press", priv);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register pwrkey press irq\n");
+		return ret;
+	}
+
+	return devm_request_threaded_irq(&pdev->dev, priv->release_irq, NULL,
+					 rt5120_pwrkey_handler, 0,
+					 "pwrkey-release", priv);
+}
+
+static const struct of_device_id r5120_pwrkey_match_table[] = {
+	{ .compatible = "richtek,rt5120-pwrkey", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, r5120_pwrkey_match_table);
+
+static struct platform_driver rt5120_pwrkey_driver = {
+	.driver = {
+		.name = "rt5120-pwrkey",
+		.of_match_table = r5120_pwrkey_match_table,
+	},
+	.probe = rt5120_pwrkey_probe,
+};
+module_platform_driver(rt5120_pwrkey_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RT5120 power key driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

