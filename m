Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FF50C857
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiDWI5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiDWI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:57:07 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7146203F67;
        Sat, 23 Apr 2022 01:54:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w1so18086144lfa.4;
        Sat, 23 Apr 2022 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6qCuitPyLRFBnKkAymetwVz/Zn3TWaD12IaOdxnPYw=;
        b=HaODXceUTqfkGe8AMJhIrEafalet+iDr/umX5kLoYL/RuK/hUsoVUoMlY1VErul5OH
         LQP/hDC3OhCRigrFJLEYSqhy8YrL3WcfqcJv6dtbZyqHP4DtJ5GNufv+0aYn5oiGMYpN
         iErEjSX8rf2VO/LeFiqb1umxyGFmLHwKOMpl0NAWVn3nJnUJ1i0yrbTr/HZI695AnriH
         slSmxnwfhYQka03rh9kvDPoDfgsKCIoI1PZ1kW+APBobjBd4edDQTp3z2101/K+A4vZP
         3JoNUmAEgKeioEq/IkM/edY9LE2/ouARxS2n53QAWdbq470Uq3jqnF52PFfR7dvHuX3t
         IvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6qCuitPyLRFBnKkAymetwVz/Zn3TWaD12IaOdxnPYw=;
        b=kleLcWwGlfBh9m40THsdhS5DJpFjQTAmpgeH4NHTXJDQxKu7s2ZKKHI1jZflkGwt3m
         K8cLYdfG1XDS8Qm4eKeCYEf11K1pHMcVzXRR+BEHIhyfBvuGu2ubNEZPwfKh6XcVcFv7
         dXHKHQ0+4J0e+q+HrjDwWWl6qN1Nk1U+LPA2T5zc6x3QaSXfd2GTqO4GKZesuU81CA0o
         4COoQTFAcKp06RkLNUrKb3WVnX0K33+r8umRbW0gD8fJpOFdA/ZClsUBSZ1qv7vBRhV3
         nrJyWfe/vhMZdPLZA5bGS5sJfzAHpy+DkMvShWc5cdygVROxGvkDWl2i0mdzte93KlaM
         Kk0w==
X-Gm-Message-State: AOAM5303DZUqe6oHPgtTojA+UsM/0s+k2i4y3IgpArdoR1QkOH4R67oV
        i0H2pl8aAz02rCsh7pGl5Tg+VJoCvZI=
X-Google-Smtp-Source: ABdhPJxhfUvLh3ifqJqQFrXHCkmDsgHJD4DIe0WXzwTpSlD2MfhqLWfZv/yTA8tpHgt134BUHMjeTQ==
X-Received: by 2002:a05:6512:1104:b0:471:8a5e:9981 with SMTP id l4-20020a056512110400b004718a5e9981mr6158518lfg.314.1650704048786;
        Sat, 23 Apr 2022 01:54:08 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9a99000000b0024dc3ccff47sm493677lji.32.2022.04.23.01.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 01:54:08 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 4/5] mfd: sm5703: Add support for SM5703 MFD
Date:   Sat, 23 Apr 2022 11:53:17 +0300
Message-Id: <20220423085319.483524-5-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423085319.483524-1-markuss.broks@gmail.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silicon Mitus SM5703 is a multi-function device, meant to be
used in mobile devices. It has several modules: LDO, BUCK regulators,
charger circuit, flash LED driver, a fuel gauge for monitoring the battery
and a MUIC USB switcher. The MUIC and fuel gauge parts are separate in that
they use separate i2c lines to communicate with the device, while charger
circuit, LED driver and regulators are on the main i2c line the device is
controlled with.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 MAINTAINERS                |   8 +++
 drivers/mfd/Kconfig        |  13 +++++
 drivers/mfd/Makefile       |   1 +
 drivers/mfd/sm5703.c       |  78 +++++++++++++++++++++++++++
 include/linux/mfd/sm5703.h | 105 +++++++++++++++++++++++++++++++++++++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/mfd/sm5703.c
 create mode 100644 include/linux/mfd/sm5703.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6157e706ed02..6125ed1a3be4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18172,6 +18172,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
 
+SM5703 MFD DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
+F:	Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
+F:	drivers/mfd/sm5703.c
+F:	drivers/regulator/sm5703-regulator.c
+
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
 L:	linux-security-module@vger.kernel.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..c13a99ceae99 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1237,6 +1237,19 @@ config MFD_SM501
 	  interface. The device may be connected by PCI or local bus with
 	  varying functions enabled.
 
+config MFD_SM5703
+	tristate "Silicon Mitus SM5703 MFD"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This is the core driver for the Silicon Mitus SM5703 multi-function
+	  device. This device is meant to be used in phones and it has numerous
+	  modules, including LED controller, regulators, fuel gauge, MUIC and
+	  charger circuit. It also support muxing a serial interface over USB
+	  data lines.
+
 config MFD_SM501_GPIO
 	bool "Export GPIO via GPIO layer"
 	depends on MFD_SM501 && GPIOLIB
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 858cacf659d6..ca8b86736a36 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -275,3 +275,4 @@ rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
 rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
+obj-$(CONFIG_MFD_SM5703)	+= sm5703.o
diff --git a/drivers/mfd/sm5703.c b/drivers/mfd/sm5703.c
new file mode 100644
index 000000000000..7f9838149051
--- /dev/null
+++ b/drivers/mfd/sm5703.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/sm5703.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+static const struct mfd_cell sm5703_devs[] = {
+	{ .name = "sm5703-regulator", },
+};
+
+static const struct regmap_config sm5703_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+};
+
+static int sm5703_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct sm5703_dev *sm5703;
+	struct device *dev = &i2c->dev;
+	unsigned int dev_id;
+	int ret;
+
+	sm5703 = devm_kzalloc(dev, sizeof(*sm5703), GFP_KERNEL);
+	if (!sm5703)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, sm5703);
+	sm5703->dev = dev;
+
+	sm5703->regmap = devm_regmap_init_i2c(i2c, &sm5703_regmap_config);
+	if (IS_ERR(sm5703->regmap))
+		return dev_err_probe(dev, PTR_ERR(sm5703->regmap),
+				     "Failed to allocate the register map\n");
+
+	sm5703->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(sm5703->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(sm5703->reset_gpio), "Cannot get reset GPIO\n");
+
+	gpiod_set_value_cansleep(sm5703->reset_gpio, 1);
+	msleep(20);
+
+	ret = regmap_read(sm5703->regmap, SM5703_DEVICE_ID, &dev_id);
+	if (ret)
+		return dev_err_probe(dev, -ENODEV, "Device not found\n");
+
+	ret = devm_mfd_add_devices(sm5703->dev, -1, sm5703_devs,
+				   ARRAY_SIZE(sm5703_devs), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add child devices\n");
+
+	return 0;
+}
+
+static const struct of_device_id sm5703_of_match[] = {
+	{ .compatible = "siliconmitus,sm5703", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sm5703_of_match);
+
+static struct i2c_driver sm5703_driver = {
+	.driver = {
+		.name = "sm5703",
+		.of_match_table = sm5703_of_match,
+	},
+	.probe = sm5703_i2c_probe,
+};
+module_i2c_driver(sm5703_driver);
+
+MODULE_DESCRIPTION("Silicon Mitus SM5703 multi-function device driver");
+MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/sm5703.h b/include/linux/mfd/sm5703.h
new file mode 100644
index 000000000000..c62affa0d3f1
--- /dev/null
+++ b/include/linux/mfd/sm5703.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _SM5703_H
+#define _SM5703_H
+
+struct sm5703_dev {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+};
+
+// Regulator-related defines
+
+#define SM5703_REG_LDO1				0x1A
+#define SM5703_REG_LDO2				0x1B
+#define SM5703_REG_LDO3				0x1C
+#define SM5703_LDO_EN				BIT(3)
+#define SM5703_LDO_VOLT_MASK			0x7
+#define SM5703_BUCK_VOLT_MASK			0x1F
+#define SM5703_REG_USBLDO12			0x1C
+#define SM5703_REG_EN_USBLDO1			BIT(6)
+#define SM5703_REG_EN_USBLDO2			BIT(7)
+#define SM5703_REG_BUCK				0x1D
+#define SM5703_REG_EN_BUCK			BIT(6)
+#define SM5703_USBLDO_MICROVOLT			4800000
+#define SM5703_VBUS_MICROVOLT			5000000
+
+// Fuel-Gauge-related defines
+
+#define SM5703_FG_REG_DEVICE_ID			0x00
+#define SM5703_FG_REG_CNTL			0x01
+#define SM5703_FG_REG_INTFG			0x02
+#define SM5703_FG_REG_INTFG_MASK		0x03
+#define SM5703_FG_REG_STATUS			0x04
+#define SM5703_FG_REG_SOC			0x05
+#define SM5703_FG_REG_OCV			0x06
+#define SM5703_FG_REG_VOLTAGE			0x07
+#define SM5703_FG_REG_CURRENT			0x08
+#define SM5703_FG_REG_TEMPERATURE		0x09
+#define SM5703_FG_REG_CURRENT_EST		0x85
+#define SM5703_FG_REG_FG_OP_STATUS		0x10
+
+// Flash LED driver-related defines
+
+#define SM5703_FLEDCNTL1			0x14
+#define SM5703_FLEDCNTL2			0x15
+#define SM5703_FLEDCNTL3			0x16
+#define SM5703_FLEDCNTL4			0x17
+#define SM5703_FLEDCNTL5			0x18
+#define SM5703_FLEDCNTL6			0x19
+
+#define SM5703_FLEDEN_MASK			0x03
+#define SM5703_FLEDEN_DISABLE			0x00
+#define SM5703_FLEDEN_MOVIE_MODE		0x01
+#define SM5703_FLEDEN_FLASH_MODE		0x02
+#define SM5703_FLEDEN_EXTERNAL			0x03
+
+#define SM5703_IFLED_MASK			0x1F
+#define SM5703_IMLED_MASK			0x1F
+
+// Charger-related, IRQ and device ID defines
+
+#define SM5703_REG_CNTL				0x0C
+#define SM5703_VBUSCNTL				0x0D
+#define SM5703_CHGCNTL1				0x0E
+#define SM5703_CHGCNTL2				0x0F
+#define SM5703_CHGCNTL3				0x10
+#define SM5703_CHGCNTL4				0x11
+#define SM5703_CHGCNTL5				0x12
+#define SM5703_CHGCNTL6				0x13
+#define SM5703_OTGCURRENTCNTL			0x60
+#define SM5703_Q3LIMITCNTL			0x66
+#define SM5703_DEVICE_ID			0x1E
+#define SM5703_OPERATION_MODE			0x07
+#define SM5703_OPERATION_MODE_MASK		0x07
+
+#define SM5703_OPERATION_MODE_SUSPEND		0x00
+#define SM5703_OPERATION_MODE_CHARGING_OFF	0x04
+#define SM5703_OPERATION_MODE_CHARGING_ON	0x05
+#define SM5703_OPERATION_MODE_FLASH_BOOST_MODE	0x06
+#define SM5703_OPERATION_MODE_USB_OTG_MODE	0x07
+
+#define SM5703_BSTOUT				0x0F
+#define SM5703_BSTOUT_MASK			0x0F
+#define SM5703_BSTOUT_SHIFT			0
+
+#define SM5703_BSTOUT_4P5			0x05
+#define SM5703_BSTOUT_5P0			0x0A
+#define SM5703_BSTOUT_5P1			0x0B
+
+#define SM5703_IRQ_STATUS1			0x08
+#define SM5703_IRQ_STATUS2			0x09
+#define SM5703_IRQ_STATUS3			0x0A
+#define SM5703_IRQ_STATUS4			0x0B
+#define SM5703_IRQ_STATUS5			0x6B
+
+#define SM5703_STATUS1_OTGFAIL			0x80
+#define SM5703_STATUS3_DONE			0x08
+#define SM5703_STATUS3_TOPOFF			0x04
+#define SM5703_STATUS3_CHGON			0x01
+#define SM5703_STATUS5_VBUSOVP			0x80
+#define SM5703_STATUS5_VBUSUVLO			0x40
+#define SM5703_STATUS5_VBUSOK			0x20
+
+#endif
-- 
2.35.1

