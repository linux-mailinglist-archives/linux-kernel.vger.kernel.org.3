Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748594DA8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353433AbiCPDCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353420AbiCPDCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:02:02 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93275DE6A;
        Tue, 15 Mar 2022 20:00:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso3560842pjb.0;
        Tue, 15 Mar 2022 20:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PqHy1PwaZNjNRGByNj9ihuLwsqt4YhXkhniLCUZpke4=;
        b=BoOIsnsDpc+A9MoPYHqZ2OSL434ZTI+2EVccGh3GvLEaO6CoDVaqzRXyqxJPe4pVxr
         F7BePshWssmoUfhbC8ZWaxN2S06xy2tTiTpbpershJrrtUusaRqEpkVEM8MHCXUAC3x+
         qSNe2bcl4pusX8ZoUvyW4o8SqUUmPFT0ny1QYVrdcnf27CMhHxolHp+OIY/g0LmNYjFO
         8VXAYJuJT369qGQmgE5VQUdtKmqByx4BZw7QKb56OTrT+nW4+/WjKCMOetzwDXUtHwpA
         3uyZR647qS9Hg0dkXarqvPiJHwMYPSjvgJOZTRsZ14EGjp9bkEnkd9PYNcqDbkRryCyc
         aOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PqHy1PwaZNjNRGByNj9ihuLwsqt4YhXkhniLCUZpke4=;
        b=r3WEdgdQ30UW/hVHP2Qe5WJlSEOzw5vO14U9V+tfHKre/JRfnA1vgm0P6r0+dqbkAW
         BegtHCagTdS1q9M7ZjGPSWThsRiEb8nHNy7kyfXlpEc5V3SGxLvCCofuIZLrwBAO2t7T
         RLhrfB1eoEMplQASHCdZSCf4/2ZlGXyoGwdOZN0/p4XhZEN+hZo0rMMEF3fDuLlxeF+Z
         pDK0QIGCdMv9xN+M+VI6q5X7cuP00stOMY7HkqC+Nw29ZzXiXk0G7+5YHs9B/0JrgfBL
         SmLKj7wOviq1A0vuTs/+IybJCzGNklrw4U8E8O9ATLSPPX1Lx+bQWEVeZEM2xoDdUsP+
         soAw==
X-Gm-Message-State: AOAM531OeM5R6zKKyZwPaO2aVlZZ5Tgo+KJ0EOotz4ZlvppTms3SCenb
        YIZ5IESRfl1bN1SmaOw0fUI=
X-Google-Smtp-Source: ABdhPJw3LOVwLAujKGODan9MeDUCaCidp9/UWSwZ0aPZKgQdItNbEAcv670tBFDweAWx7OjKo0fDJw==
X-Received: by 2002:a17:90b:4c84:b0:1c6:573f:145d with SMTP id my4-20020a17090b4c8400b001c6573f145dmr2545305pjb.154.1647399649164;
        Tue, 15 Mar 2022 20:00:49 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm582329pjv.57.2022.03.15.20.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 20:00:48 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v5 1/2] thermal: Add thermal driver for Sunplus SP7021
Date:   Wed, 16 Mar 2022 11:01:05 +0800
Message-Id: <a658d7513a62e067086d8e2a73920bb892293569.1647399369.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1647399369.git.lhjeff911@gmail.com>
References: <cover.1647399369.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1647399369.git.lhjeff911@gmail.com>
References: <cover.1647399369.git.lhjeff911@gmail.com>
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
Changes in v5:
 - Modify yaml file remove reg name and change nvmem name
 - Addressed comments from Mr. Daniel Lezcano

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 140 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2f..96d5218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18542,6 +18542,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
 F:	drivers/rtc/rtc-sunplus.c
 
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
index 0000000..e2e955e
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,140 @@
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
+static char sp7021_get_otp_temp_coef(struct sp_thermal_data *sp_data, struct device *dev)
+{
+	struct nvmem_cell *cell;
+	ssize_t otp_l;
+	char *otp_v;
+
+	cell = nvmem_cell_get(dev, "calib");
+	if (IS_ERR(cell))
+		return ERR_CAST(cell);
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
+static struct thermal_zone_of_device_ops sp_of_thermal_ops = {
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (IS_ERR(res))
+		return dev_err_probe(&pdev->dev, PTR_ERR(res), "resource get fail\n");
+
+	sp_data->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(sp_data->regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sp_data->regs), "mas_base get fail\n");
+
+	writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
+
+	platform_set_drvdata(pdev, sp_data);
+	ret = sp7021_get_otp_temp_coef(sp_data, &pdev->dev);
+	ret = sp_thermal_register_sensor(pdev, sp_data, 0);
+
+	return ret;
+}
+
+static int sp7021_thermal_remove(struct platform_device *pdev)
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

