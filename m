Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CC853F5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiFGFxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiFGFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:53:07 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E2140C6;
        Mon,  6 Jun 2022 22:53:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so14506681pjs.1;
        Mon, 06 Jun 2022 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fgmmdez2YLBvzLz/N5O3pA9gc8sSQ4ag8UiBs6nCanY=;
        b=h9gXRUmlvZssxYebh60B7y+6eGju0Vjf1fIzk4JxB6xZawVmH6w/DS1UBJU0wNTnnQ
         9OMiHHyXDJmD7+w/0S3i01Q+SmtsSkctYXFLs0qmVMCtb2zycgf0HttkelMchWp6xS1b
         LOvPphyt3BOpbBymt969qOfu7xXay+dHJ7araycgDgMpnQEdvewFb5qc/ItgaVZFq/4t
         jwWNJImXrcZBL91jc74cYUjJd9Ip/JShpTc281/FsEpUET/RqTbxc1pOhXxBlGCB1CJs
         JTh6OReqgrX2ffARONz+NJX6Bs7PM72rLBui2GybUeF8EFs+9svcz01JN3Ds3AH55+qy
         Eayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fgmmdez2YLBvzLz/N5O3pA9gc8sSQ4ag8UiBs6nCanY=;
        b=o3MguGQXLcj74FQnAWODjtmJhqSXhBO/rozy84X7sPEM8cP6PHQSLSr1zJS/wiQbVa
         LQEqnKOzqTVWCgmhBr62C327vnqdETduHKfPeX0Ig7tQlw7+aHq1ItpO4WVNFDU3btAs
         61ed1fqvwdbEnM4R+TMs6x8nZsHT1v/jADW0sKSmsZRMk8aJktCfeUyVNdj2ge/oNn8q
         Q2FL42dmbcvwGKhiVqonl0ihyp/jHAXa6hh9bSHkFeLhsgg026afwTekcvZjOA1KdZdm
         eAddTYP9jU4lppJeUOu76IlI7ZqmMHDfNsBoH5xTYTu795NBOVUSzOQLUGwKL1hDRHQE
         yMcA==
X-Gm-Message-State: AOAM532a9rLOatsMyb35+DjcPaJTMMaSDFG9C8adXRVqvoKwNtUxH1ds
        pQtD/dfxk1LQ8S0XMnqLBNKorw5gKeE=
X-Google-Smtp-Source: ABdhPJyr8xr0wayTmQYYNh77h744b4u308+xWr/YYM3F87PpsJs/WVNCXJjl6oSUuqSmvB5+JqIYwA==
X-Received: by 2002:a17:90a:1f4c:b0:1e6:6f77:c573 with SMTP id y12-20020a17090a1f4c00b001e66f77c573mr32257267pjy.17.1654581185722;
        Mon, 06 Jun 2022 22:53:05 -0700 (PDT)
Received: from localhost.localdomain ([49.216.54.77])
        by smtp.gmail.com with ESMTPSA id z41-20020a056a001da900b0051b62689ec2sm9203520pfw.129.2022.06.06.22.53.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 22:53:05 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 4/4] input: misc: rt5120: Add power key support
Date:   Tue,  7 Jun 2022 13:52:41 +0800
Message-Id: <1654581161-12349-5-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
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
index dd5227c..9c0d814 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -881,6 +881,15 @@ config INPUT_SC27XX_VIBRA
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
index b92c53a..164ea20 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)	+= rave-sp-pwrbutton.o
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

