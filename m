Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74958E503
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiHJC4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiHJC4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:56:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529946E882;
        Tue,  9 Aug 2022 19:55:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h28so12471966pfq.11;
        Tue, 09 Aug 2022 19:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=l3n0xNkM7y1LjHD6LrFxe9l1XPdXW5jtjDOQp4rcO/k=;
        b=lo1BruH/vdXNwPVHbqSlKdobgAf6YmMjRBWtOLpQU9Je9K7s1b7Wsa2tK+2LtAm4Ki
         mDfMwxoG/dO9Mzj8UGstVIY/PKtpY4CaSGj6cINFlhqdzgdipYDI95GNTkklhxZZ5jzs
         JQ5cmoOpcaOloYtrjLWqs/mbhgbbbNgy86TM+ywcxvzc5UzLkTv+usNv8R89Wis87+Je
         qt6t63W8UMSEKX1Cr0PLfqs4w3zE3KrJdIKj5S+S49NcCxLlnbmE+S4UsIDIymjtKsGT
         PKtXO7hv6YbyJYTWnU2InIpt57HGslzItJDZtOFiddEOo7aorPhdLXpndX7qpVzSUry+
         pQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=l3n0xNkM7y1LjHD6LrFxe9l1XPdXW5jtjDOQp4rcO/k=;
        b=dL/LDM4Jjuc3alb4QgBMO1D1LcQ2eL462QEhZtCDpSupSREv19OUxLXprWdzn/RJMi
         on7JImwJf6TNk0XxKhLEgHvSupwP8aA5KrLfv3MdAfR2kfKEcKi6cZ7kxzAgPKBxfIZG
         8g9VbEbbjTywEbMJOj5IWtnSGtqvOVOLnc+QX0iOm/6anQ9Wo2W8raZeuMePWzz4B8kp
         zfmAqCHYHF/9F8NPYMqawL/qbah6gK13Pr7A89SrYS8lExiZVN1orZHtJlK4UIvSm1Kn
         yb1hs5W2vYRLYtaglv3v4YIKvXwYX9cCpgF2Uv6r0pjccoQ148vqFJpkEiuWNgYFCGTF
         I3Yg==
X-Gm-Message-State: ACgBeo2A93oeGyF4w1SOQaICx5b1p8b78Z6aXM3bVXplulGJdcyf5cHK
        Xoj+fH+I5rH8CDT4ZUP94Dw=
X-Google-Smtp-Source: AA6agR5Nsk8n2J7f6D5rnXastYfmjURoEK0IGsEPSab2NT41Qwb3scM9E6J0rmI44rT1FxMITyvIeQ==
X-Received: by 2002:a05:6a00:b82:b0:52f:518f:fe6c with SMTP id g2-20020a056a000b8200b0052f518ffe6cmr11690460pfj.80.1660100158724;
        Tue, 09 Aug 2022 19:55:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:d15f:416a:c0:aecd:5d6e])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c94500b0016d1f474653sm11785654pla.52.2022.08.09.19.55.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2022 19:55:58 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, dmitry.torokhov@gmail.com
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v4 3/3] input: misc: rt5120: Add power key support
Date:   Wed, 10 Aug 2022 10:55:42 +0800
Message-Id: <1660100142-32493-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
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
Since v4:
- Add "Copyright" string and refine for GPL version string.

Since v3:
- Simplify the power key irq handler key report
- Since press and release irq not needed to keep in private data, change 'press',
  'release' irq as local variable only.
- Fix Kconfig typo for pwrkey.

---
 drivers/input/misc/Kconfig         |   9 +++
 drivers/input/misc/Makefile        |   1 +
 drivers/input/misc/rt5120-pwrkey.c | 109 +++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab73..92daa4d 100644
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
+	  be called rt5120-pwrkey.
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
index 00000000..94d25ba
--- /dev/null
+++ b/drivers/input/misc/rt5120-pwrkey.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
+ */
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
+};
+
+static irqreturn_t rt5120_pwrkey_handler(int irq, void *devid)
+{
+	struct rt5120_priv *priv = devid;
+	unsigned int stat;
+	int ret;
+
+	ret = regmap_read(priv->regmap, RT5120_REG_INTSTAT, &stat);
+	if (ret)
+		return IRQ_NONE;
+
+	input_report_key(priv->input, KEY_POWER,
+			 !(stat & RT5120_PWRKEYSTAT_MASK));
+	input_sync(priv->input);
+
+	return IRQ_HANDLED;
+}
+
+static int rt5120_pwrkey_probe(struct platform_device *pdev)
+{
+	struct rt5120_priv *priv;
+	struct device *dev = &pdev->dev;
+	int press_irq, release_irq;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to init regmap\n");
+
+	press_irq = platform_get_irq_byname(pdev, "pwrkey-press");
+	if (press_irq < 0)
+		return press_irq;
+
+	release_irq = platform_get_irq_byname(pdev, "pwrkey-release");
+	if (release_irq < 0)
+		return release_irq;
+
+	/* Make input device be device resource managed */
+	priv->input = devm_input_allocate_device(dev);
+	if (!priv->input)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate input device\n");
+
+	priv->input->name = "rt5120_pwrkey";
+	priv->input->phys = "rt5120_pwrkey/input0";
+	priv->input->id.bustype = BUS_I2C;
+	input_set_capability(priv->input, EV_KEY, KEY_POWER);
+
+	ret = input_register_device(priv->input);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register input device\n");
+
+	ret = devm_request_threaded_irq(dev, press_irq, NULL,
+					rt5120_pwrkey_handler, 0,
+					"pwrkey-press", priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register pwrkey press irq\n");
+
+	return devm_request_threaded_irq(dev, release_irq, NULL,
+					 rt5120_pwrkey_handler, 0,
+					 "pwrkey-release", priv);
+}
+
+static const struct of_device_id r5120_pwrkey_match_table[] = {
+	{ .compatible = "richtek,rt5120-pwrkey" },
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

