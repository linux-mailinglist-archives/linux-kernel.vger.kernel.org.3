Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8777483AC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiADC6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiADC6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:58:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519BC061761;
        Mon,  3 Jan 2022 18:58:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so34116116pjf.3;
        Mon, 03 Jan 2022 18:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=u2+qk+LTof8eFiWCqwHRIdt6jzQcO3a5gYO6e9VIiUg=;
        b=Yvy/0fdwmBU19dHcmYeDTUWWbiSwPFkqw4JsAGWvrfXqt3rb5FuNfNkIfoUwFOVG01
         gae3Zkfn9ZiNZ0whD1VLcN+EMa7W56sqc8zKp7xLVGOVJtQeAY/dcn6pctMIsAMcEdO1
         94ULDnGoygD+fCsWspCVTKOXWWHJ/sdfRg/+8rB9+j3CP8vwZoCwL32QmVP+gl36dnJh
         5Twp7Ld2wKNhOM0MftrP1xz4TsQvGBFq3skRCEZXSw4ALwfvYMiILCePE7CAqdEOmMXh
         fi3KGHPLmt4/HdiwnQOuJbPzLTFYTc2zFjeOve4RL5TDcPMccmgSMJTw+QDPyKyil/bO
         9TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=u2+qk+LTof8eFiWCqwHRIdt6jzQcO3a5gYO6e9VIiUg=;
        b=sxBIy06xuC5IsO8ePbrJZY9ONXho5X/+cF5fyAoQyLQ6MUqmCTUAL5eyA9W+TFeO+r
         WNk+AAz/fqnLzlE05tNJlIH/mOLEjqlTiqfXTjKub6R2t8GWU+JHonNqquHqzF5O2/1K
         XFURQbCNiUQcrK8+NnW9ns3fWqDm8AieSJgMdrNRQJ/MfjT0YxRmNaq7nf0GkzPi7HT9
         af90VSt4J2M6DAb1uGBJkVaJPigo1MsjrY56i4xVMrEmI9CDyDP9FwxzCVDFIj2tLg0L
         uvfSXNyKZRGSMVFYFyBKYRG9W4SGjlojVK+0fY9vVKpZ7eq4LcaR/rShuY+gfgaSD3xT
         2zig==
X-Gm-Message-State: AOAM5304XjTYi0nqxG3dgzkQ9+/AFlCfcf2dGcsX2XbrcakkihLM1Wc+
        fH8KJawgQc50769LMQ1CW1A=
X-Google-Smtp-Source: ABdhPJyLRH8/ZCyyKSqcXs0Q/+dmLmA3Vt/RpTKQIKTOwoQnC9qUb0R0NRKMwNubfscjYMmvqCJIBg==
X-Received: by 2002:a17:90b:517:: with SMTP id r23mr59019200pjz.152.1641265130771;
        Mon, 03 Jan 2022 18:58:50 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k23sm573142pji.3.2022.01.03.18.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jan 2022 18:58:50 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v3 1/2] THERMAL: Add THERMAL driver for Sunplus SP7021
Date:   Tue,  4 Jan 2022 10:58:56 +0800
Message-Id: <e43f9cedeab36c698d87d0b31f41b4e0ce5c80c0.1641264908.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641264908.git.lhjeff911@gmail.com>
References: <cover.1641264908.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1641264908.git.lhjeff911@gmail.com>
References: <cover.1641264908.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add THERMAL driver for Sunplus SP7021.

Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
---
Changes in v3:
 - Modify Theraml driver

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 161 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7..4b02628 100644
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
index d7f44de..6643a81 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -493,4 +493,14 @@ config KHADAS_MCU_FAN_THERMAL
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

