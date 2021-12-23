Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5547DE77
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhLWFGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhLWFGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:06:22 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA30BC061401;
        Wed, 22 Dec 2021 21:06:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v25so3931088pge.2;
        Wed, 22 Dec 2021 21:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rs8+NtHVHeaYW7hEVsp2d+01AFTPC1CQK7yX0xYeBOk=;
        b=kLtlug0aOEtRbEIN1I3bfKHKz267Tv4Sp3FBjBhPN4zIAAw+H7MyyfUBCFLnNYiQFs
         kOk+UCKRhHe/jH40njtE7WoBbBqCgPGZMplaoAoVmnTFQdZGQnF0UhQreuGkvhdXpNdK
         Ycpk6wqYq1WWxG+X2qCJz8wNBxPUX+HGGdBtOL+fB4fk+vLFe7Yk0mOzyIxRHR1oYuIb
         FZ5HMeju77v3Hs20nUVgsfSxfE9HVEMoj46yyLjo07hvkUok1wolE8u5NojIiRscopQy
         jw9DUS9WDgNHnkgQpOLWkdaerDrFCbgesNQ2VJKYqUT3xmI9bay9vn0WLNKdKU9dVDU/
         xZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rs8+NtHVHeaYW7hEVsp2d+01AFTPC1CQK7yX0xYeBOk=;
        b=SSIvYBPAY4AmhWJEFlHBbQof1JLO9ebXeKc5yb69AgpkYYEv4tDb89Gxf9F0CoQ9eI
         L77hQixRhug3GYXvub8aHeliJG7MHhLC9wklVGSj0HOiSxVoq1hSUdE7e19s+Vqe6KEj
         9ANwd++UkizsSwXg5cHj2CHanCG6/a4t9psD46lWahcnx+KTXIt/nInrTV8xC9+hle68
         AKFKtrFJqY9yzr8fbCUzgPRZRk1BhY2BDDvFl8KHYx8h+3zQHUcJjZ3kpcs3uQ8esIXt
         czH/cI+PuM8fE61VcMMlijW41qnxvklQ26mIAyuWtg2jnEhvp70CBJkoeQZpq1TSlmT4
         5Yrg==
X-Gm-Message-State: AOAM532kZM5i/4Si7UrslVFl2xl2tUgxMLGeR1WJB4sZCene5eRGJBmB
        JIhMbYIzKfGAvLC5VoWIWlM=
X-Google-Smtp-Source: ABdhPJw+i8emDaS4YD6OJzzF5HcUApl/OJGbyv+18hyK3hogIiu18ju7dJAqfevW2RZhF0vYwfHXVQ==
X-Received: by 2002:aa7:938d:0:b0:4ba:c445:8761 with SMTP id t13-20020aa7938d000000b004bac4458761mr924105pfe.12.1640235981104;
        Wed, 22 Dec 2021 21:06:21 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id oo13sm4170936pjb.25.2021.12.22.21.06.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 21:06:20 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v2 1/2] THERMAL: Add THERMAL driver for Sunplus SP7021
Date:   Thu, 23 Dec 2021 13:06:25 +0800
Message-Id: <a5b37169978e9b82c33718289066287dfd1b9c00.1640235724.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1640235724.git.lhjeff911@gmail.com>
References: <cover.1640235724.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1640235724.git.lhjeff911@gmail.com>
References: <cover.1640235724.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add THERMAL driver for Sunplus SP7021.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v2:
 - Addressed all comments from Mr. Rob Herring
 - Modify Theraml driver

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 161 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c..5f1fa6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18242,6 +18242,12 @@ L:	netdev@vger.kernel.org
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
index d7f44de..ddad391 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -493,4 +493,14 @@ config KHADAS_MCU_FAN_THERMAL
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
index 82fc3e6..23f8dce 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL)	+= sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL)	+= khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL)	+= sunplus_thermal.o
\ No newline at end of file
diff --git a/drivers/thermal/sunplus_thermal.c b/drivers/thermal/sunplus_thermal.c
new file mode 100644
index 0000000..35e68bc
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,161 @@
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
+char *sp7021_otp_coef_read(struct device *dev, ssize_t *len)
+{
+	char *ret = NULL;
+	struct nvmem_cell *c = nvmem_cell_get(dev, "therm_calib");
+
+	if (IS_ERR_OR_NULL(c)) {
+		dev_err(dev, "OTP read failure:%ld", PTR_ERR(c));
+		return NULL;
+	}
+	ret = nvmem_cell_read(c, len);
+	nvmem_cell_put(c);
+	dev_dbg(dev, "%d bytes read from OTP", *len);
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
+	dev_dbg(&(sp_data->pdev->dev), "tc:%d t:%d", t_code, *temp);
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
+	dev_err(&pdev->dev, "sensor#%d reg fail: %d\n", index, ret);
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
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

