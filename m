Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255D54599A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbiFJBb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbiFJBbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:31:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1642DD2F7;
        Thu,  9 Jun 2022 18:31:20 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3137c877092so58525737b3.13;
        Thu, 09 Jun 2022 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HWvVQh5kVq3Tzv+knJyrp33L0772CHDDuvD3or3h+LY=;
        b=RmoVA7VKI0Vqts1YNiNLaS/oHACxerh4NKbncWclahykA6R5Eh0zSyRD/n/guMs4NY
         MZsjb15ih7O6n1jfBaCVw+/Jn/P1bpubbPReV8PvH+kyDhfbO3yqz3TaqJc/4JjOBmpf
         jf3UrXxuar+z8NAcOp5mJc9qXoq9St3cYCGgWq1iscljlq5iPJnRycGNE6/dbs3tsr8z
         UfSqnO1Y5vAhvf8K3Oz+4sffrC4oRSY5J7B+SwZDqrTvRv7W6i1Qdx7PRhHVy1RkB7YS
         uG9NFt3Z/CbbChOyZ96h2gJ5kdq4/i0bD0W7mPhu6S5vo5fu1cEXdAaUofoZ8GNC75D0
         XS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HWvVQh5kVq3Tzv+knJyrp33L0772CHDDuvD3or3h+LY=;
        b=UwqykVHqj+tnOY7+trK5o7ink2yvENye0LP45fYF4jkS36K/p7Of9pcQXWxKylCYNs
         5SuMlu07n5Hs7imyRXYueFz+nXWHuVoeEfcJTcam/7sDTHCCNNoeWdnsW3uhHtfsDSMH
         M4XJDePeRpNWw669SCfCAwATJV2oh6qiF42Cgk6S24g13geG5qPFQBeAeT7UCN4+B7si
         Na1DeDWVBKYTfe2MC0KyuV05DQ6Z7wd4010P5QHAMB+lNlVt0wI6cjFNDoTXXP8nNXcn
         xNv2m9PIyio8OBM4vefvBGr73HooHJRDLW8AZERszJUKbz4UBv97qRtBACzA3EnbL5qX
         AnRQ==
X-Gm-Message-State: AOAM530bSnFwLnUpZtLubsq/0iE8WrUgMz9MYNjs1zVPFldvlW5a5RUH
        uAeq01H58vPJ4lXmf2dbUydHRr/X9ucauVX8oiE=
X-Google-Smtp-Source: ABdhPJy4zrQ6/2Yec9FBU+k8T3ReOM2EsFkigKMnw9jHCiFB6jQGOZ5bEUDOOt5VLepRzZ7AxnijZrDXkeolnmB+bl0=
X-Received: by 2002:a81:9bd8:0:b0:30c:86d3:d121 with SMTP id
 s207-20020a819bd8000000b0030c86d3d121mr45985459ywg.482.1654824679710; Thu, 09
 Jun 2022 18:31:19 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Fri, 10 Jun 2022 09:32:16 +0800
Message-ID: <CAGcXWkzJwOPXfE6ESAtwBbe7W-UkApKosKUy=UBRh0kmi-Bc2Q@mail.gmail.com>
Subject: [PATCH v9 1/2] thermal: Add thermal driver for Sunplus
To:     krzk@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "lh.kuo" <lh.kuo@sunplus.com>,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
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
Changes in v9:
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
@@ -19103,6 +19103,12 @@ S: Maintained
 F: Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
 F: drivers/spi/spi-sunplus-sp7021.c

+SUNPLUS THERMAL DRIVER
+M: Li-hao Kuo <lhjeff911@gmail.com>
+L: linux-pm@vger.kernel.org
+S: Maintained
+F: drivers/thermal/sunplus_thermal.c
+
 SUNPLUS UART DRIVER
 M: Hammer Hsieh <hammerh0314@gmail.com>
 S: Maintained
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 0e5cc94..c85e668 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -504,4 +504,14 @@ config KHADAS_MCU_FAN_THERMAL
    If you say yes here you get support for the FAN controlled
    by the Microcontroller found on the Khadas VIM boards.

+config SUNPLUS_THERMAL
+ tristate "Sunplus thermal drivers"
+ depends on SOC_SP7021 || COMPILE_TEST
+ help
+   This enable the Sunplus SP7021 thermal driver, which supports the primitive
+   temperature sensor embedded in Sunplus SP7021 SoC.
+
+   If you have a Sunplus SP7021 platform say Y here and enable this option
+   to have support for thermal management
+
 endif
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index def8e1a..b603730 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_UNIPHIER_THERMAL) += uniphier_thermal.o
 obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
 obj-$(CONFIG_SPRD_THERMAL) += sprd_thermal.o
 obj-$(CONFIG_KHADAS_MCU_FAN_THERMAL) += khadas_mcu_fan.o
+obj-$(CONFIG_SUNPLUS_THERMAL) += sunplus_thermal.o
diff --git a/drivers/thermal/sunplus_thermal.c
b/drivers/thermal/sunplus_thermal.c
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
+#define ENABLE_THERMAL BIT(31)
+#define SP_THERMAL_MASK GENMASK(10, 0)
+
+#define TEMP_RATE 608
+#define TEMP_BASE 3500
+#define TEMP_OTP_BASE 1518
+
+#define SP_THERMAL_CTL0_REG 0x0000
+#define SP_THERMAL_STS0_REG 0x0030
+
+/* common data structures */
+struct sp_thermal_data {
+ struct thermal_zone_device *pcb_tz;
+ void __iomem *regs;
+ int *otp_temp0;
+};
+
+static int sunplus_get_otp_temp_coef(struct sp_thermal_data *sp_data,
struct device *dev)
+{
+ struct nvmem_cell *cell;
+ ssize_t otp_l;
+
+ cell = nvmem_cell_get(dev, "calib");
+ if (IS_ERR(cell))
+ return PTR_ERR(cell);
+
+ sp_data->otp_temp0 = nvmem_cell_read(cell, &otp_l);
+ nvmem_cell_put(cell);
+
+ if (*sp_data->otp_temp0 == 0)
+ *sp_data->otp_temp0 = TEMP_OTP_BASE;
+
+ return 0;
+}
+
+/*
+ * There is a thermal sensor instance for Sunplus Soc
+ * T_CODE is the ADC of the thermal sensor
+ * T_CODE : 11 digits in total
+ * When remanufacturing, the 35 degree T_CODE will be read and stored
in nvcell.
+ * otp_temp0 is the 35 degree T_CODE obtained from nvcell
+ * The function will get 35 degree T_CODE for thermal calibration.
+ * TEMP_RATE is the Sunplus thermal temperature slope.
+ */
+
+static int sp_thermal_get_sensor_temp(void *data, int *temp)
+{
+ struct sp_thermal_data *sp_data = data;
+ int t_code;
+
+ t_code = readl(sp_data->regs + SP_THERMAL_STS0_REG);
+ t_code = FIELD_GET(SP_THERMAL_MASK, t_code);
+ *temp = ((*sp_data->otp_temp0 - t_code) * 10000 / TEMP_RATE) + TEMP_BASE;
+ *temp *= 10;
+ return 0;
+}
+
+static const struct thermal_zone_of_device_ops sp_of_thermal_ops = {
+ .get_temp = sp_thermal_get_sensor_temp,
+};
+
+static int sunplus_thermal_probe(struct platform_device *pdev)
+{
+ struct sp_thermal_data *sp_data;
+ int ret;
+
+ sp_data = devm_kzalloc(&pdev->dev, sizeof(*sp_data), GFP_KERNEL);
+ if (!sp_data)
+ return -ENOMEM;
+
+ sp_data->regs = devm_platform_ioremap_resource(pdev, 0);
+ if (IS_ERR(sp_data->regs)) {
+ dev_err(&pdev->dev, "resource get fail\n");
+ return PTR_ERR(sp_data->regs);
+ }
+
+ writel(ENABLE_THERMAL, sp_data->regs + SP_THERMAL_CTL0_REG);
+
+ platform_set_drvdata(pdev, sp_data);
+ ret = sunplus_get_otp_temp_coef(sp_data, &pdev->dev);
+ if (ret)
+ return ret;
+
+ sp_data->pcb_tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+     0,
+     sp_data, &sp_of_thermal_ops);
+
+ if (IS_ERR(sp_data->pcb_tz)) {
+ ret = PTR_ERR(sp_data->pcb_tz);
+ dev_err(dev, "Failed to register tsensor: %d\n", ret);
+ return ret;
+ }
+
+ return ret;
+}
+
+static int sunplus_thermal_remove(struct platform_device *pdev)
+{
+ struct sp_thermal_data *sp_data = platform_get_drvdata(pdev);
+
+ thermal_zone_of_sensor_unregister(&pdev->dev, sp_data->pcb_tz);
+ return 0;
+}
+
+static const struct of_device_id of_sunplus_thermal_ids[] = {
+ { .compatible = "sunplus,sp7021-thermal" },
+ { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_sunplus_thermal_ids);
+
+static struct platform_driver sunplus_thermal_driver = {
+ .probe = sunplus_thermal_probe,
+ .remove = sunplus_thermal_remove,
+ .driver = {
+ .name = "sunplus-thermal",
+ .of_match_table = of_sunplus_thermal_ids,
+ },
+};
+module_platform_driver(sunplus_thermal_driver);
+
+MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
+MODULE_DESCRIPTION("Thermal driver for Sunplus SoC");
+MODULE_LICENSE("GPL");
-- 
2.7.4
