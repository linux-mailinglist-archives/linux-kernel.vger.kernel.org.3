Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BEE571328
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiGLHbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiGLHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:31:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A939A99661;
        Tue, 12 Jul 2022 00:31:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fz10so6888392pjb.2;
        Tue, 12 Jul 2022 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=m2QT0zAuCqwcPmvaYj5/N1FN8bWkD80+OKsR0WiVxc8=;
        b=jRtWuduZ2CwXXaf71nnLZO9NnzlJoFo1o/0E8hLsZZfYQ0AQLD8Y7Xk3rKSzRS1xrE
         XtmLupbqOGFvMFD7tBNcobyGksHoXknAoao4QXC/z7J3k/uVwblqi/Plg2SQWrd4C4pc
         Abhu5m7hfnixQPWQk9liNDfAHoO5p0NY9SUXJWMiqEAMNuInm0zFU6qjn//s/uuSuNQU
         4GvVPfJ+TDApXQpXLJIOHlODCWmwulIWLCqUy4F3TNCmYTw1zG5YGk7RZaDNxmVk3YyQ
         ScLMtdteK3klei8eCv6ysFOmwNEnQflESk+3bnVzK1odhlbtbUid2q+ydOJ1l/eorPMp
         rAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=m2QT0zAuCqwcPmvaYj5/N1FN8bWkD80+OKsR0WiVxc8=;
        b=yZwYWD/TBrM1kUsb9I3QH30eAzdLEnB/swhWPHGLF/HKqtindQfJTeDmC3bKfjKK4T
         yvwZz70I/tl/LQopDB+byzwNFojJWJEdWIVtKto/3SW54VaGSAPYPsLNp4FXT86sXOPq
         fODGoh2I+kvhoW5XqFOjQK9gabDQ1q64Lb9WT3tm0EeEm3n6Qp8gueS/4aUW6Znia6zG
         0t+Qdz6KwQEUGBydwLdiFk9sRHteqF0rYPEFfyDWmk4vAqouDO4QYzevnHBQKFGYKQFo
         hgJd2sFG6F3vuGO1skUGdpuuJgdSgBn232bCU++/CjGsI3Y7KVud/oERy4VMq2ihUihn
         x+sw==
X-Gm-Message-State: AJIora88vsy5rRht7tC/KEnNCRDrq9i4+UIkJN4SObSW7GWHyyk73RAd
        sh9hEt6BV0k1SuYuYfsSW9Tbs7PMiR4h/A==
X-Google-Smtp-Source: AGRyM1s9rHIQF6lInCgW6yG5sosK3a5vbo22XEHRg4cwJ25n5DjPYVWEXFHN/iQneTTo/J4ZwPRNTg==
X-Received: by 2002:a17:903:189:b0:16c:39b2:c217 with SMTP id z9-20020a170903018900b0016c39b2c217mr14862275plg.113.1657611096092;
        Tue, 12 Jul 2022 00:31:36 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id t18-20020a170902d29200b0016c09a0ef87sm5994557plc.255.2022.07.12.00.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:31:34 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v10 1/2] thermal: Add thermal driver for Sunplus
Date:   Tue, 12 Jul 2022 15:30:44 +0800
Message-Id: <b114b6f8ea51054561a61dc4982715bb73633ec5.1654660009.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1654660009.git.lhjeff911@gmail.com>
References: <cover.1654660009.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1654660009.git.lhjeff911@gmail.com>
References: <cover.1654660009.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal driver for Sunplus.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v10:
 - Change the setting of compatible
 - Mosdify the setting of remove funciton.

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 139 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9..23bde07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19103,6 +19103,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F:	drivers/spi/spi-sunplus-sp7021.c
 
+SUNPLUS THERMAL DRIVER
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/sunplus_thermal.c
+
 SUNPLUS UART DRIVER
 M:	Hammer Hsieh <hammerh0314@gmail.com>
 S:	Maintained
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e5cc94..c85e668 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config SUNPLUS_THERMAL
+	tristate "Sunplus thermal drivers"
+	depends on SOC_SP7021 || COMPILE_TEST
+	help
+	  This enable the Sunplus SP7021 thermal driver, which supports the primitive
+	  temperature sensor embedded in Sunplus SP7021 SoC.
+
+	  If you have a Sunplus SP7021 platform say Y here and enable this option
+	  to have support for thermal management.
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a..b603730 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
new file mode 100644
index 0000000..ed73a15
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Sunplus Inc.
+ * Author: Li-hao Kuo <lhjeff911@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+
+#define ENABLE_THERMAL		BIT(31)
+#define SP_THERMAL_MASK		GENMASK(10, 0)
+
+#define TEMP_RATE		608
+#define TEMP_BASE		3500
+#define TEMP_OTP_BASE		1518
+
+#define SP_THERMAL_CTL0_REG	0x0000
+#define SP_THERMAL_STS0_REG	0x0030
+
+/* common data structures */
+struct sp_thermal_data {
+	struct thermal_zone_device *pcb_tz;
+	void __iomem *regs;
+	int *otp_temp0;
+};
+
+static int sunplus_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
+{
+	struct nvmem_cell *cell;
+	ssize_t otp_l;
+
+	cell = nvmem_cell_get(dev, "calib");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	sp_data->otp_temp0 = nvmem_cell_read(cell, &otp_l);
+	nvmem_cell_put(cell);
+
+	if (*sp_data->otp_temp0 == 0)
+		*sp_data->otp_temp0 = TEMP_OTP_BASE;
+
+	return 0;
+}
+
+/*
+ * There is a thermal sensor instance for Sunplus Soc
+ * T_CODE is the ADC of the thermal sensor
+ * T_CODE : 11 digits in total
+ * When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
+ * otp_temp0 is the 35 degree T_CODE obtained from nvcell
+ * The function will get 35 degree T_CODE for thermal calibration.
+ * TEMP_RATE is the Sunplus thermal temperature slope.
+ */
+
+static int sp_thermal_get_sensor_temp(void *data, int *temp)
+{
+	struct sp_thermal_data *sp_data = data;
+	int t_code;
+
+	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
+	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
+	*temp = ((*sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
+	*temp *= 10;
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
+	.get_temp = sp_thermal_get_sensor_temp,
+};
+
+static int sunplus_thermal_probe(struct platform_device *pdev)
+{
+	struct sp_thermal_data *sp_data;
+	int ret;
+
+	sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
+	if (!sp_data)
+		return -ENOMEM;
+
+	sp_data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sp_data->regs)) {
+		dev_err(&pdev->dev, "resource get fail\n");
+		return PTR_ERR(sp_data->regs);
+	}
+
+	writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
+
+	platform_set_drvdata(pdev, sp_data);
+	ret = sunplus_get_otp_temp_coef(sp_data, &pdev->dev);
+	if (ret)
+		return ret;
+
+	sp_data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							    0,
+							    sp_data, &sp_of_thermal_ops);
+
+	if (IS_ERR(sp_data->pcb_tz)) {
+		ret = PTR_ERR(sp_data->pcb_tz);
+		dev_err(dev, "Failed to register tsensor: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int sunplus_thermal_remove(struct platform_device *pdev)
+{
+	struct sp_thermal_data *sp_data = platform_get_drvdata(pdev);
+
+	thermal_zone_of_sensor_unregister(&pdev->dev, sp_data->pcb_tz);
+	return 0;
+}
+
+static const struct of_device_id of_sunplus_thermal_ids[] = {
+	{ .compatible = "sunplus,sp7021-thermal" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_sunplus_thermal_ids);
+
+static struct platform_driver sunplus_thermal_driver = {
+	.probe	= sunplus_thermal_probe,
+	.remove = sunplus_thermal_remove,
+	.driver	= {
+		.name	= "sunplus-thermal",
+		.of_match_table = of_sunplus_thermal_ids,
+		},
+};
+module_platform_driver(sunplus_thermal_driver);
+
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Thermal driver for Sunplus SoC");
+MODULE_LICENSE("GPL");
-- 
2.7.4

