Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5664FB669
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbiDKIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245676AbiDKIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:55:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6B33EBBC;
        Mon, 11 Apr 2022 01:52:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 2so14646894pjw.2;
        Mon, 11 Apr 2022 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E0aRA1YJZ7Bz7oDpAjbz3WXZcJ6PEF9cn+ELszEuqZE=;
        b=hSuIVKnQbJa2i1UOwCpU+bB11kviW4vUZM1Pfiqsvte1o1tceKVLCxq4qd0bT0cHod
         nIqLRyPi2ep4VooTEMQYyzIc/SZwenF7w8Mw/VOtjxt/fU9+CWxvWlMXeyxmwZrt0g8i
         qLxfosgIoY91ItgK7mZj05hvhhX8ug0S0UeS03FJmNAh+aAqZnDvJtZa/XfdTGIFlB9b
         kKKzkOSOdyiys5I4pEjWeeAIu30vlTYutI35XnsiVTIsF5x2eVUs7Z5r55vjiMLTEiBn
         vYpo8+71iRSV2DUWXyASThowniCZUNK4ZV42SHx0/ELrE18EBpvZX7zhDIN8tkqTWcmg
         Yb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E0aRA1YJZ7Bz7oDpAjbz3WXZcJ6PEF9cn+ELszEuqZE=;
        b=gevFjw60KXTilSsL22TTveZA58M8OeEH/dm5ttnWLCN9SgTKhXyg/a+sOHA03KmMZT
         yz2yrCZqNGqe5XfbVUu0biAPUoZdNTinzJiD6472WlVIY3THNfeb5sXmu/Fl3k7ORvJb
         BOeEiiBlmHTxY0pYuzk/e3LZAhzMTpF1wUTgCP5TOwdP2KhlPnVXvWrL7W/egdNigB7d
         DiX4r//2da51Ubg0RPXS7IVA1uUHhxBmh+ivbEcFN4ktT7Hy6nnJAM44sSTMFM7LqQy/
         p1RCUslxVAhBjdCe6MFb9/qIG8ajtQgWKor50rfc8d1ykc57nYnGiTQLZWcWSFCfYV28
         Gazg==
X-Gm-Message-State: AOAM532kKdyt+GefrbQYh54rarvwxTvtgP2DIz4r7tAwYWoEPxBE2aC8
        0EYAe+RI58wE5RLT7J57Geo=
X-Google-Smtp-Source: ABdhPJwc5ahtXEbvpdwALM++vIkwmatXYdjVt6tjn7IuwfRKv0eQR9AnE8efoF8JCXFVgSWu5s531Q==
X-Received: by 2002:a17:902:6bc4:b0:154:6b3d:a720 with SMTP id m4-20020a1709026bc400b001546b3da720mr30862101plt.104.1649667173147;
        Mon, 11 Apr 2022 01:52:53 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b16-20020a17090a011000b001cb4815d135sm10054057pjb.9.2022.04.11.01.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2022 01:52:52 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v7 1/2] thermal: Add thermal driver for Sunplus SP7021
Date:   Mon, 11 Apr 2022 16:52:39 +0800
Message-Id: <c59e0a5c53f055b7159bc896083538d1f8ac9ad8.1649662002.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1649662002.git.lhjeff911@gmail.com>
References: <cover.1649662002.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1649662002.git.lhjeff911@gmail.com>
References: <cover.1649662002.git.lhjeff911@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal driver for Sunplus SP7021.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v7:
 - Modify yaml file.

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 139 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f11..307570c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18885,6 +18885,12 @@ S:	Maintained
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
index e37691e..66316c3 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -502,4 +502,14 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config SUNPLUS_THERMAL
+	tristate "Sunplus thermal drivers"
+	depends on SOC_SP7021 || COMPILE_TEST
+	help
+	  This the Sunplus SP7021 thermal driver, which supports the primitive
+	  temperature sensor embedded in Sunplus SP7021 SoC.
+
+	  If you have a Sunplus SP7021 platform say Y here and enable this option
+	  to have support for thermal management
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index f0c36a1..38a76f9 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
new file mode 100644
index 0000000..9a9b348
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
+#define DISABLE_THERMAL		(BIT(31) | BIT(15))
+#define ENABLE_THERMAL		BIT(31)
+#define SP_THERMAL_MASK		GENMASK(10, 0)
+#define SP_TCODE_HIGH_MASK	GENMASK(10, 8)
+#define SP_TCODE_LOW_MASK	GENMASK(7, 0)
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
+	struct platform_device *pdev;
+	enum thermal_device_mode mode;
+	void __iomem *regs;
+	int otp_temp0;
+	u32 id;
+};
+
+static int sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
+{
+	struct nvmem_cell *cell;
+	ssize_t otp_l;
+	char *otp_v;
+
+	cell = nvmem_cell_get(dev, "calib");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	otp_v = nvmem_cell_read(cell, &otp_l);
+	nvmem_cell_put(cell);
+
+	if (otp_l < 3)
+		return -EINVAL;
+	sp_data->otp_temp0 = FIELD_PREP(SP_TCODE_LOW_MASK, otp_v[0]) |
+			     FIELD_PREP(SP_TCODE_HIGH_MASK, otp_v[1]);
+	if (sp_data->otp_temp0 == 0)
+		sp_data->otp_temp0 = TEMP_OTP_BASE;
+	return 0;
+}
+
+/*
+ *When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
+ *TEMP_RATE is the SP7021 temperature slope.
+ *T_CODE : 11 digits in total
+ */
+
+static int sp_thermal_get_sensor_temp(void *data, int *temp)
+{
+	struct sp_thermal_data *sp_data = data;
+	int t_code;
+
+	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
+	t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
+	*temp = ((sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
+	*temp *= 10;
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
+	.get_temp = sp_thermal_get_sensor_temp,
+};
+
+static int sp_thermal_register_sensor(struct platform_device *pdev,
+				      struct sp_thermal_data *data, int index)
+{
+	data->id = index;
+	data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+							    data->id,
+							    data, &sp_of_thermal_ops);
+	if (IS_ERR_OR_NULL(data->pcb_tz))
+		return PTR_ERR(data->pcb_tz);
+	return 0;
+}
+
+static int sp7021_thermal_probe(struct platform_device *pdev)
+{
+	struct sp_thermal_data *sp_data;
+	struct resource *res;
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
+	ret = sp7021_get_otp_temp_coef(sp_data, &pdev->dev);
+	if (ret)
+		return ret;
+	ret = sp_thermal_register_sensor(pdev, sp_data, 0);
+	return ret;
+}
+
+static const struct of_device_id of_sp7021_thermal_ids[] = {
+	{ .compatible = "sunplus,sp7021-thermal" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_sp7021_thermal_ids);
+
+static struct platform_driver sp7021_thermal_driver = {
+	.probe	= sp7021_thermal_probe,
+	.driver	= {
+		.name	= "sp7021-thermal",
+		.of_match_table = of_sp7021_thermal_ids,
+		},
+};
+module_platform_driver(sp7021_thermal_driver);
+
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Thermal driver for SP7021 SoC");
+MODULE_LICENSE("GPL");
-- 
2.7.4

