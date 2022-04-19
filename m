Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE583507270
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354263AbiDSQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354239AbiDSQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:04:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061C2ED59;
        Tue, 19 Apr 2022 09:01:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w1so6821724lfa.4;
        Tue, 19 Apr 2022 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/y6S893+XO+0gZ9aLfl1F/TXOKs2SRk/NNOfS2VZWA=;
        b=L6Xrcws7mv5iWGzTcwQt1oy4YLbU8Nz20TyX/ZAUlrbWOVriHNvSMp0U3uCsEWCgGI
         oljWmVv5a7O2HWKzQO7sUAHre0yA4xsoZNPJqAn5kd3BwgRwF54EjQiW2DOR+hDxYrXu
         S+rysK5UYrig2DcGdhxIvnAGmj6Kx2i1jsmInJgtgPWSZ1E6fv9oOICvcchUAnycwA5v
         PS0zoFlzIgQdENDMcIxIzyxPLKovYRc9+UR6sdbV+8+uOAjoNoJdDAUPyVSgUBfbP50O
         bvGpJPovzHSzqrcgS7XyX10rtmLD4TMO2HDBdT4RaOai6ICWsMgCzcdr0+3vLYutu7lW
         n7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/y6S893+XO+0gZ9aLfl1F/TXOKs2SRk/NNOfS2VZWA=;
        b=S7TVTHXN4rDAQfY2G8DkmOBOPZYzJcKev0bfLn5nuSw70HGh47hxx8/Xghk75yDrk9
         z3ZtIe8HtwvyD/BDONeyDYR5wAYHwa7fl2reQeqBrQk72VOMwnbUKtQKhzbqnPThAU7G
         XNtczKnHHK3B7Q5/oQZpDxHpPkcGn0UNEgCw5M6fFFoRYaDgT9U3aXcCV7nNkGytVojn
         w1iCM9AlX3xJsOMcGGdXn7SS0VgHrYOtKdJxF0T0rnSCMVBs/EinSVcl66xnD44x3A0o
         y6RmZp2M0ileTZSqW/otDJbJNwfakGTrZi2zEm8uvURDjANB11F15eCVsfrIx57QdsEz
         HYmA==
X-Gm-Message-State: AOAM530Nu4Zdy9sd2TDBgrAJbcZDipHe+i7zWc7ATpgE4rzsfzxmSEBV
        OXe6u4aGf2j4lCOg11Zero1MWrN2+wQ=
X-Google-Smtp-Source: ABdhPJzvpqny8HulxrTSWCGLhi86vsmekYQaRbaz9XUtUO4ADQsdDbofYZBGxVy6mZHzrqsH7+9TgQ==
X-Received: by 2002:a05:6512:1290:b0:471:90ee:b265 with SMTP id u16-20020a056512129000b0047190eeb265mr7391662lfs.668.1650384081544;
        Tue, 19 Apr 2022 09:01:21 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id m5-20020a194345000000b0046e951e34b3sm1506663lfj.24.2022.04.19.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:01:21 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 4/4] regulator: sm5703-regulator: Add regulators support for SM5703 MFD
Date:   Tue, 19 Apr 2022 19:00:57 +0300
Message-Id: <20220419160058.9998-5-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419160058.9998-1-markuss.broks@gmail.com>
References: <20220419160058.9998-1-markuss.broks@gmail.com>
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

Regulators block of SM5703 controls several voltage regulators which
are used to power various components. There are 3 LDO outputs ranging
from 1.5 to 3.3V, a buck regulator ranging from 1V to 3V, two fixed
voltage LDO regulators for powering the USB devices and one high-power
fixed voltage LDO line (actually two lines) meant to power high-power
USB devices.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/regulator/Kconfig            |   7 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/sm5703-regulator.c | 162 +++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/regulator/sm5703-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5d0a360d7244..318bbdc27ae4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1147,6 +1147,13 @@ config REGULATOR_SLG51000
 	  The SLG51000 is seven compact and customizable low dropout
 	  regulators.
 
+config REGULATOR_SM5703
+	tristate "Silicon Mitus SM5703 regulators"
+	depends on SM5703_MFD
+	help
+	  This driver provides support for voltage regulators of SM5703
+	  multi-function device.
+
 config REGULATOR_STM32_BOOSTER
 	tristate "STMicroelectronics STM32 BOOSTER"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 4b8794a73e17..c491fe528ba4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
 obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
 obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
 obj-$(CONFIG_REGULATOR_SLG51000) += slg51000-regulator.o
+obj-$(CONFIG_REGULATOR_SM5703) += sm5703-regulator.o
 obj-$(CONFIG_REGULATOR_STM32_BOOSTER) += stm32-booster.o
 obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
 obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
diff --git a/drivers/regulator/sm5703-regulator.c b/drivers/regulator/sm5703-regulator.c
new file mode 100644
index 000000000000..41004de69887
--- /dev/null
+++ b/drivers/regulator/sm5703-regulator.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mfd/sm5703.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+enum sm5703_regulators {
+	SM5703_BUCK,
+	SM5703_LDO1,
+	SM5703_LDO2,
+	SM5703_LDO3,
+	SM5703_USBLDO1,
+	SM5703_USBLDO2,
+	SM5703_VBUS,
+	SM5703_MAX_REGULATORS,
+};
+
+static const int sm5703_ldo_voltagemap[] = {
+	1500000, 1800000, 2600000, 2800000, 3000000, 3300000,
+};
+
+static const int sm5703_buck_voltagemap[] = {
+	1000000, 1000000, 1000000, 1000000,
+	1000000, 1000000, 1000000, 1000000,
+	1000000, 1000000, 1000000, 1100000,
+	1200000, 1300000, 1400000, 1500000,
+	1600000, 1700000, 1800000, 1900000,
+	2000000, 2100000, 2200000, 2300000,
+	2400000, 2500000, 2600000, 2700000,
+	2800000, 2900000, 3000000, 3000000,
+};
+
+#define SM5703USBLDO(_name, _id)					\
+	[SM5703_USBLDO ## _id] = {					\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_USBLDO ## _id,				\
+		.ops = &sm5703_regulator_ops,				\
+		.fixed_uV = SM5703_USBLDO_MICROVOLT,			\
+		.enable_reg = SM5703_REG_USBLDO12,			\
+		.enable_mask = SM5703_REG_EN_USBLDO ##_id,		\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define SM5703VBUS(_name)						\
+	[SM5703_VBUS] = {						\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_VBUS,					\
+		.ops = &sm5703_regulator_ops,				\
+		.fixed_uV = SM5703_VBUS_MICROVOLT,			\
+		.enable_reg = SM5703_REG_CNTL,				\
+		.enable_mask = SM5703_OPERATION_MODE_MASK,		\
+		.enable_val = SM5703_OPERATION_MODE_USB_OTG_MODE,	\
+		.disable_val = SM5703_OPERATION_MODE_CHARGING_ON,	\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define SM5703BUCK(_name)						\
+	[SM5703_BUCK] = {						\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_BUCK,					\
+		.ops = &sm5703_regulator_ops,				\
+		.n_voltages = ARRAY_SIZE(sm5703_buck_voltagemap),	\
+		.volt_table = sm5703_buck_voltagemap,			\
+		.vsel_reg = SM5703_REG_BUCK,				\
+		.vsel_mask = SM5703_BUCK_VOLT_MASK,			\
+		.enable_reg = SM5703_REG_BUCK,				\
+		.enable_mask = SM5703_REG_EN_BUCK,			\
+		.owner			= THIS_MODULE,			\
+	}
+
+#define SM5703LDO(_name, _id)						\
+	[SM5703_LDO ## _id] = {						\
+		.name = _name,						\
+		.of_match = _name,					\
+		.regulators_node = "regulators",			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = SM5703_LDO ## _id,				\
+		.ops = &sm5703_regulator_ops,				\
+		.n_voltages = ARRAY_SIZE(sm5703_ldo_voltagemap),	\
+		.volt_table = sm5703_ldo_voltagemap,			\
+		.vsel_reg = SM5703_REG_LDO ##_id,			\
+		.vsel_mask = SM5703_LDO_VOLT_MASK,			\
+		.enable_reg = SM5703_REG_LDO ##_id,			\
+		.enable_mask = SM5703_LDO_EN,				\
+		.owner			= THIS_MODULE,			\
+	}
+
+static const struct regulator_ops sm5703_regulator_ops = {
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.is_enabled		= regulator_is_enabled_regmap,
+	.list_voltage		= regulator_list_voltage_table,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+};
+
+static struct regulator_desc sm5703_regulators_desc[SM5703_MAX_REGULATORS] = {
+	SM5703BUCK("buck"),
+	SM5703LDO("ldo1", 1),
+	SM5703LDO("ldo2", 2),
+	SM5703LDO("ldo3", 3),
+	SM5703USBLDO("usbldo1", 1),
+	SM5703USBLDO("usbldo2", 2),
+	SM5703VBUS("vbus"),
+};
+
+static int sm5703_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regulator_config config = { NULL, };
+	struct regulator_dev *rdev;
+	struct sm5703_dev *sm5703 = dev_get_drvdata(pdev->dev.parent);
+	int i;
+
+	config.dev = dev;
+	config.of_node = dev->of_node;
+	config.regmap = sm5703->regmap;
+
+	for (i = 0; i < SM5703_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev,
+					       &sm5703_regulators_desc[i],
+					       &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					     "Failed to register a regulator\n");
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id sm5703_regulator_id[] = {
+	{ "sm5703-regulator", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, sm5703_regulator_id);
+
+static struct platform_driver sm5703_regulator_driver = {
+	.driver = {
+		.name = "sm5703-regulator",
+	},
+	.probe	= sm5703_regulator_probe,
+	.id_table	= sm5703_regulator_id,
+};
+
+module_platform_driver(sm5703_regulator_driver);
+
+MODULE_DESCRIPTION("Silicon Mitus SM5703 LDO/Buck/USB regulator driver");
+MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.1

