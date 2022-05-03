Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60463517BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiECCQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiECCQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:16:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175D71928F;
        Mon,  2 May 2022 19:13:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c11so3639767plg.13;
        Mon, 02 May 2022 19:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SxK07N+Dbm0t8LbaOmwnt40IHHv5G3r09QZDNhKgs0g=;
        b=ic1pFqSAFXcAnx7Z1UA5mC4E35SGrQle2gxD605SqgYehYKMMKFuhrBHlSAU+B8up0
         3JdT6ZIkPTNmFH+3z5sVFSBaLVSJlj+yssKgiRGppzEH1LLs3POw54G+L8frmdkgTc+7
         aUR4ca3NL8D3LgH8M59wlpFvvVs8mqT0z9h2OAbBeJuxZCY4Awh0I8Zg1M1VIZZGCT2W
         8LlCJaj1d/XSjJefcWB5nz2fInc3XYS0edYFJHciRSiUMb7nFIMu5Zch5p/cFNl3I//Z
         wbZtTuuSNb6MP5gIwbkN6du5nki5e9xo2cph5Bvk1jqivLMr98EvtbcNP0bCSb9+6iSS
         v8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SxK07N+Dbm0t8LbaOmwnt40IHHv5G3r09QZDNhKgs0g=;
        b=3xhz+C9n2PmG5vlk/jawOFRtp6MbBCp9Y4WtOu/c/PwcUks2rzTZT0jTnaZQxez5iu
         vZsF5dlZs2NUV1Oy68hyvefzR8k5mX0KNfYrdGHhnyfYe6OxIbeiD3UO/Pzf7M8V4Y7i
         ayZy4ufp3zddrgVxFy/6H933JMBBhQo61eFNMB6pPLTwEIYKJqFtxjrRKCt/BwNtjtnw
         xLX5aNPFreGTxordoxRBIiD9AeALmLn5fKMvjcie3BQ85SLVUCoVGJRE7Nc6AbEbd8vc
         lxhSjTLIfI2ZW8wCkUn6L3pwzJFRAmY7my6OR+kPGLULQfDvtMg7wN7DRqCXzaE8gbIQ
         79PQ==
X-Gm-Message-State: AOAM533cgDv37JoYXl+hjYHIDPh9uTFSpeCPqAdr8y7Td+TdFe6Stqg3
        xv9jbSwxHt+8REfizjvmksE=
X-Google-Smtp-Source: ABdhPJzYUPcPGTthTRvOMglU6yDHhuLtlG9rLKxoiZ+eKTkqB4tOtuq6biTj6eEubzKrQXQbxxol5w==
X-Received: by 2002:a17:90b:4c85:b0:1dc:5778:5344 with SMTP id my5-20020a17090b4c8500b001dc57785344mr2359453pjb.8.1651544002401;
        Mon, 02 May 2022 19:13:22 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id j22-20020a17090a7e9600b001d903861194sm365805pjl.30.2022.05.02.19.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 19:13:21 -0700 (PDT)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     krzk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v8 1/2] thermal: Add thermal driver for Sunplus
Date:   Tue,  3 May 2022 10:13:07 +0800
Message-Id: <febcaf8229a33217b4bfb3654d6f0bfe7f55a84d.1651543731.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1651543731.git.lhjeff911@gmail.com>
References: <cover.1651543731.git.lhjeff911@gmail.com>
In-Reply-To: <cover.1651543731.git.lhjeff911@gmail.com>
References: <cover.1651543731.git.lhjeff911@gmail.com>
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
Changes in v8:
 - Modify yaml file.
   modify the setting compatible
 - Change yaml file name.
 - Modify driver.
   mosdify and simply the nvmem setting and remove valiable

 MAINTAINERS                       |   6 ++
 drivers/thermal/Kconfig           |  10 +++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/sunplus_thermal.c | 135 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 drivers/thermal/sunplus_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edc96cd..82143ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18896,6 +18896,12 @@ S:	Maintained
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
index 0e5cc94..595f507 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
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
index 0000000..d4e22fc
--- /dev/null
+++ b/drivers/thermal/sunplus_thermal.c
@@ -0,0 +1,135 @@
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
+ * There is a thermal sensor instance for SUNPLUS Soc
+ * T_CODE is the ADC of the thermal sensor
+ * T_CODE : 11 digits in total
+ * When remanufacturing, the 35 degree T_CODE will be read and stored in nvcell.
+ * otp_temp0 is the 35 degree T_CODE obtained from nvcell
+ * The function will get 35 degree T_CODE for thermal calibration.
+ * TEMP_RATE is the SUNPLUS thermal temperature slope.
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
+	if (IS_ERR_OR_NULL(sp_data->pcb_tz))
+		return PTR_ERR(sp_data->pcb_tz);
+
+	return ret;
+}
+
+static int sunplus_thermal_remove(struct platform_device *pdev)
+{
+	struct sp_thermal_data *sp_data = platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(sp_data->pcb_tz);
+	return 0;
+}
+
+static const struct of_device_id of_sunplus_thermal_ids[] = {
+	{ .compatible = "sunplus,thermal" },
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
+MODULE_DESCRIPTION("Thermal driver for sunplus SoC");
+MODULE_LICENSE("GPL");
-- 
2.7.4

