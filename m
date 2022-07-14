Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E5574537
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiGNGm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbiGNGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:42:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D220192;
        Wed, 13 Jul 2022 23:42:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so7461746pjl.5;
        Wed, 13 Jul 2022 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQqVk/li2uOK4C//a5rwR6TqVXPgBjhZsLgz0JKgFDU=;
        b=AXZ9xZdpXEUtWip0sPDD/VsyxbdfHpX6risn1bku8ubHaF7a3IBDNkvE0JFKbGoqOR
         1SBDm4GZPlAP7j3cn/YRtdXSqOZ0RVPCz4yqo2o1UAcrZj37H546OO7ie47QFIyxGRKu
         pm0pzT2eZZoxuxa/kkHhLV4apxZfPuxj2uC8lFSqSOlTzNoOMqd42VbcVPQJqmw7LOnt
         R2Gq5qHDbkuQP8p4aeyo/bcjLf8zMPrdiu6G4VHN8C+3DOJWZufGakNB7aWT3vWXsKkz
         aFNp026wkYXOfa2cSw6BbvsDZYMoNpEfp/AMZglg817X4FQQBgdtPRyngTtnaAgLlUeU
         nEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQqVk/li2uOK4C//a5rwR6TqVXPgBjhZsLgz0JKgFDU=;
        b=72Zi2Ngo+wcj5HVswAlYyXwy6XQH8StfGjWRecd+lA3jDpjc+bolBXnhbSCsaWsoR1
         eYd6AxGXKLRfcl6llj40U8+z23/Ip0CxksuZ01Ev9P707eHmHZG4272K+xhzaLw1RM35
         nFibhzwm2AtuCh7E1t+hOIdemaPDiLR2gJBnQoD2I6s9R1hgw6RuUyeY8DuW+0meboZK
         9ubyXWCPK7GY6TeVWKLge3DvlLoMggXtG24ddvAa2e3I3W4IXcINtEtjvI9JyuSy5/4p
         FFZjenGzRyxoKDvsVdpXvEXTdW74afHYToxfZ8PU90NFxaeIgw5KCD8m77iU/Ae5/RAp
         oSkw==
X-Gm-Message-State: AJIora+hO4DnkKBjoP+zeBoHo3xfLtfuRSVe4LSdf55euB74clFl9piL
        AQ8dhz41PwdREuRzPIcF0kZTN2oFjjY=
X-Google-Smtp-Source: AGRyM1veZOyPzmOG8yG9Gv2+kYzBULMW5FwgCKBa5rIdnvPodMikl82BxoTfi6MEfBtDo8ueuAIACg==
X-Received: by 2002:a17:902:c944:b0:16c:5897:7ea0 with SMTP id i4-20020a170902c94400b0016c58977ea0mr7057264pla.127.1657780968618;
        Wed, 13 Jul 2022 23:42:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:486:199:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id nt14-20020a17090b248e00b001ef82e5f5aesm616291pjb.47.2022.07.13.23.42.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 23:42:48 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v3 3/3] input: misc: rt5120: Add power key support
Date:   Thu, 14 Jul 2022 14:42:17 +0800
Message-Id: <1657780937-20891-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
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
Since v3:
- Simplify the power key irq handler key report
- Since press and release irq not needed to keep in private data, change 'press',
  'release' irq as local variable only.
- Fix Kconfig typo for pwrkey.

---
 drivers/input/misc/Kconfig         |   9 ++++
 drivers/input/misc/Makefile        |   1 +
 drivers/input/misc/rt5120-pwrkey.c | 105 +++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
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
index 00000000..b6a5ac4
--- /dev/null
+++ b/drivers/input/misc/rt5120-pwrkey.c
@@ -0,0 +1,105 @@
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

