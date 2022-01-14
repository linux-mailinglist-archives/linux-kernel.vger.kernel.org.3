Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39548E2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiANCqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiANCqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:46:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECB4C061574;
        Thu, 13 Jan 2022 18:46:20 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so6926021plh.13;
        Thu, 13 Jan 2022 18:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ERDwxR+GYpEIn7C1CTz+wbYbSA8qCbgtaBVGgaM0WTc=;
        b=CT+75u18KR34sRsrDunrMFMUuMc1WUWEt6TZ4OdVX/WdLDQ+kjE+OuZKMKUMYrSxYJ
         uvgf0Boxc5F5GFyySEHAzChUB/uJrw87rQiUWlBFcLzB+gRRQnviIaRpu3htVDPqQIWr
         /rgFGkjsKWj3jUJkTcwGFJkZRuWu71T7+hRz+9WFJKMbW3OzGBgXmjbKhVL51VqlKtjp
         TvQL5/Vx8Txlp3ymbRXcxa6apbEIAHTMAaDezwRC016v57wjE4vnQPuyGVxG8kVlM7Rb
         9CHNvwulf/IzzQyUST5kP/yzIQaPh/a99GW3Xc6nNxhjYtJYCfJRS0iGsQLvo6wuY0xU
         xbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ERDwxR+GYpEIn7C1CTz+wbYbSA8qCbgtaBVGgaM0WTc=;
        b=gS8gq+lQuhzgefvlX4gvtoYDCYbfsXxejvfhdm2KngcKGZBwIrC+zkTXK3xsLWhpC6
         aVrbN3W3i24QpYp21u848e3Jpu6yMe1NxcO1eib4PaNN1ECIibWo3Ym7WxdenGBhPW3/
         iS/fIRRhFPbUXSOcHs1W7CuWcqC17rL2FJAIGcop8WeXCoHJVKPu9xA2ElkUcpq1rUOW
         u6VEim/9Dmyfn8o/7r04Hjxl6MaCrW7gr38dkn9MJxoKiBBEQQSV+npLB9+MLtTu9w4S
         NiuAKT3/8R45yz7ac0w+q10nr2Scm8HhsZjhb+KXhc0BJKXIIS5QMBMxlSWBlHRgrpI3
         TGNA==
X-Gm-Message-State: AOAM532uCGu6+3FzxXPCckrp9QRZNg8C9qE8Nv0XY3R5MnpZt4lJqOBC
        M1WsyiSYmjNFi+wq4OWl1+o=
X-Google-Smtp-Source: ABdhPJyu414X89MWUjXhlc80yk/Hz9NNrh8i2/nx+K+4RZhLDIDpXe9ekqZrVpTDnZj17lJ573JXMg==
X-Received: by 2002:a17:902:7149:b0:149:c123:a983 with SMTP id u9-20020a170902714900b00149c123a983mr7230294plm.79.1642128379565;
        Thu, 13 Jan 2022 18:46:19 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id u11sm3939149pfi.10.2022.01.13.18.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 18:46:19 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v4 1/2] thermal: Add thermal driver for Sunplus SP7021
Date:   Fri, 14 Jan 2022 10:46:26 +0800
Message-Id: <2847f96335da1c74dfbee7ba67939bdc474ba2a4.1642127137.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1642127137.git.lhjeff911@gmail.com>
References: <cover.1642127137.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1642127137.git.lhjeff911@gmail.com>
References: <cover.1642127137.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal driver for Sunplus SP7021.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v4:
 - Modify yaml file remove reg name and change nvmem name

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 157 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dc4a137..e41b265 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18423,6 +18423,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS THERMAL DRIVER
+M:	Li-hao Kuo <lhjeff911@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/sunplus_thermal.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e37691e..98647c7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -502,4 +502,14 @@ config KHADAS_MCU_FAN_THERMAL
 	  If you say yes here you get support for the FAN controlled
 	  by the Microcontroller found on the Khadas VIM boards.
 
+config SUNPLUS_THERMAL
+	tristate "Sunplus thermal drivers"
+	depends on SOC_SP7021
+	help
+	  This the Sunplus SP7021 thermal driver, which supports the primitive
+	  temperature sensor embedded in Sunplus SP7021 SoC.
+
+	  If you have a Sunplus SP7021 platform say Y here and enable this option
+	  to have support for thermal management
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index f0c36a1..2f7417a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
\ No newline at end of file
diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
new file mode 100644
index 0000000..460c41d
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Sunplus Inc.
+ * Author: Li-hao Kuo <lhjeff911@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/rtc.h>
+#include <linux/thermal.h>
+
+#define DISABLE_THREMAL		(BIT(31) | BIT(15))
+#define ENABLE_THREMAL		BIT(31)
+#define SP_THREMAL_MASK		GENMASK(10, 0)
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
+	long sensor_temp;
+	void __iomem *regs;
+	int otp_temp0;
+	int otp_temp1;
+	u32 id;
+};
+
+static char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
+{
+	char *ret = NULL;
+	struct nvmem_cell *c = nvmem_cell_get(dev, "calib");
+
+	if (IS_ERR_OR_NULL(c))
+		return NULL;
+
+	ret = nvmem_cell_read(c, len);
+	nvmem_cell_put(c);
+	return ret;
+}
+
+static void sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *_d)
+{
+	ssize_t otp_l = 0;
+	char *otp_v;
+
+	otp_v = sp7021_otp_coef_read(_d, &otp_l);
+	if (otp_l < 3)
+		return;
+	if (IS_ERR_OR_NULL(otp_v))
+		return;
+	sp_data->otp_temp0 = otp_v[0] | (otp_v[1] << 8);
+	sp_data->otp_temp0 = otp_v[0] | (otp_v[1] << 8);
+	sp_data->otp_temp0 = FIELD_GET(SP_THREMAL_MASK, sp_data->otp_temp0);
+	sp_data->otp_temp1 = (otp_v[1] >> 3) | (otp_v[2] << 5);
+	sp_data->otp_temp1 = FIELD_GET(SP_THREMAL_MASK, sp_data->otp_temp1);
+	if (sp_data->otp_temp0 == 0)
+		sp_data->otp_temp0 = TEMP_OTP_BASE;
+}
+
+static int sp_thermal_get_sensor_temp(void *data, int *temp)
+{
+	struct sp_thermal_data *sp_data = data;
+	int t_code;
+
+	t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
+	t_code = FIELD_GET(SP_THREMAL_MASK, t_code);
+	*temp = ((sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
+	*temp *= 10;
+	return 0;
+}
+
+static struct thermal_zone_of_device_ops sp_of_thermal_ops = {
+	.get_temp = sp_thermal_get_sensor_temp,
+};
+
+static int sp_thermal_register_sensor(struct platform_device *pdev, struct sp_thermal_data *data,
+				       int index)
+{
+	int ret;
+
+	data->id = index;
+	data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+					data->id, data, &sp_of_thermal_ops);
+	if (!IS_ERR_OR_NULL(data->pcb_tz))
+		return 0;
+	ret = PTR_ERR(data->pcb_tz);
+	data->pcb_tz = NULL;
+	return ret;
+}
+
+static int sp7021_thermal_probe(struct platform_device *pdev)
+{
+	struct sp_thermal_data *sp_data;
+	struct resource *res;
+	int ret;
+
+	sp_data = devm_kzalloc(&(pdev->dev), sizeof(*sp_data), GFP_KERNEL);
+	if (!sp_data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(res))
+		return dev_err_probe(&(pdev->dev), PTR_ERR(res), "resource get fail\n");
+
+	sp_data->regs = devm_ioremap(&(pdev->dev), res->start, resource_size(res));
+	if (IS_ERR(sp_data->regs))
+		return dev_err_probe(&(pdev->dev), PTR_ERR(sp_data->regs), "mas_base get fail\n");
+
+	writel(ENABLE_THREMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
+
+	platform_set_drvdata(pdev, sp_data);
+	sp7021_get_otp_temp_coef(sp_data, &pdev->dev);
+	ret = sp_thermal_register_sensor(pdev, sp_data, 0);
+
+	return ret;
+}
+
+static int sp7021_thermal_remove(struct platform_device *_pd)
+{
+	return 0;
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
+	.remove	= sp7021_thermal_remove,
+	.driver	= {
+		.name	= "sp7021-thermal",
+		.of_match_table = of_match_ptr(of_sp7021_thermal_ids),
+		},
+};
+module_platform_driver(sp7021_thermal_driver);
+
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Thermal driver for SP7021 SoC");
+MODULE_LICENSE("GPL");
-- 
2.7.4

