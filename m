Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66391596475
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiHPVPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiHPVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723D83BFA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n4so14017315wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HJHRtwvM9XKFKJZyiCAat71LR5qh4WybnuX4htGG8co=;
        b=aONfSRH9mk7Lcf234Z34egz6022TWDk9fVq7vrFyoi9eN4tr2FZ7mTW0QiG2NhLaMc
         m3hYVtWdO2IqkmBUMXZe2F2Z09yD8jpjqPIKGeJxfArjXPr9XzU0keCJBWAAhw0bypey
         H2xFZ3Rk58fJMfd0TrQGZmDUC+TALbkTe8YBNno6IC08sNX+WdDbNysmzFwDKN7c1M5H
         e0zZ2i41dyeGBkuZXeD1qsZtGRCn2E292hPiZ4UwfCSC8UBcC5EKYhathtpS0JOgiCNa
         qGTSF5tFcr+3XT1wW4DCSH3USPDSIyZb89tBjYHfvkagXpX0V5a5lRS69ArWyv4b6XfJ
         K4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HJHRtwvM9XKFKJZyiCAat71LR5qh4WybnuX4htGG8co=;
        b=WUsxPEEZrCpInf4HBNh4QCyYY1enoJ8oC4S9PwRRVfdi03r0RGY1rfF2L2/+nQ3kZW
         m7Kq8WWEE69YVzR5EmfodypHDXj7/Y0blO1mAAD5lHIdLFpbeKetX+S7xZL5ZnEscxO+
         o/Fw/5kr7BtxXEvowRkkC6AAM4C3zliuxbPsYOxqZI/yrD9QY9mb5KmApwKm/IcHBjvE
         Se1avzX9TlML3RSOsjYsiG9y+VQHdJKEEiYAavCUj1lhU+9T7OIlUU2MpXcKvTRK7O8M
         rDEg1CphFE74sBm55VfitxyvJPizWwlrKJwxFZGnRNIdrjML0kIeE48fihCq68m4Kr82
         eFzQ==
X-Gm-Message-State: ACgBeo1I8j6a6oEovVDt9jFlNl1SLlv/pin/+FBKuPN/ADoI0WEothvJ
        CJtzfyOkNtphuksd6+dQZCyzfw==
X-Google-Smtp-Source: AA6agR4PSu/FeqggYgzon5wVbBrXNRT04fTg3xrVMWNipvz5DeMvZ0VtVmr7OOfx6ZSUExxyviDsBA==
X-Received: by 2002:a05:6000:10d1:b0:220:5c89:50e5 with SMTP id b17-20020a05600010d100b002205c8950e5mr12981023wrx.335.1660684502898;
        Tue, 16 Aug 2022 14:15:02 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:15:02 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 08/10] pwm: dwc: add of/platform support
Date:   Tue, 16 Aug 2022 22:14:52 +0100
Message-Id: <20220816211454.237751-9-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - split the of code out of the core
 - moved the compile test code earlier
 - fixed review comments
  - used NS_PER_SEC
  - use devm_clk_get_enabled
v3:
 - changed compatible name
---
 drivers/pwm/Kconfig      |  9 +++++
 drivers/pwm/Makefile     |  1 +
 drivers/pwm/pwm-dwc-of.c | 78 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a9f1c554db2b..f1735653365f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -192,6 +192,15 @@ config PWM_DWC_PCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc-pci.
 
+config PWM_DWC_OF
+	tristate "DesignWare PWM Controller (OF bus)
+	depends on PWM_DWC && OF
+	help
+	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-of.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a70d36623129..d1fd1641f077 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_DWC_OF)	+= pwm-dwc-of.o
 obj-$(CONFIG_PWM_DWC_PCI)	+= pwm-dwc-pci.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
new file mode 100644
index 000000000000..d18fac287325
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver OF
+ *
+ * Copyright (C) 2022 SiFive, Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+
+#include "pwm-dwc.h"
+
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm *dwc;
+	int ret;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return dev_err_probe(dev, PTR_ERR(dwc->base),
+				     "failed to map IO\n");
+
+	dwc->clk = devm_clk_get_enabled(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	clk_prepare_enable(dwc->clk);
+	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
+
+	ret = devm_pwmchip_add(dev, &dwc->chip);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwc_pwm_plat_remove(struct platform_device *pdev)
+{
+	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(dwc->clk);
+	return 0;
+}
+
+static const struct of_device_id dwc_pwm_dt_ids[] = {
+	{ .compatible = "snps,dw-apb-timers-pwm2" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
+
+static struct platform_driver dwc_pwm_plat_driver = {
+	.driver = {
+		.name		= "dwc-pwm",
+		.of_match_table  = dwc_pwm_dt_ids,
+	},
+	.probe	= dwc_pwm_plat_probe,
+	.remove	= dwc_pwm_plat_remove,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm-of");
+MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
-- 
2.35.1

