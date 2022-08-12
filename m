Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B779A590AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiHLDX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiHLDX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:23:29 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C63FA3D44;
        Thu, 11 Aug 2022 20:23:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27C3NL8k076848;
        Thu, 11 Aug 2022 22:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660274601;
        bh=tMIgJSV7Y1RQfwAdmqGWZgkhahQLp4IB2kJp6Rhgy/o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qT5UFu75rw/EZsAZMlh5kjQZECZuyG7j1h1TXSJlu5a3kzEwT9BgyPoKxe9ms6JoP
         YA+5wV7jdih31OqBZ/aft83sskvpjICxDzEP2ep71O0Lq+dtxkK5zZ/uhqXG0gL4/e
         rQuM1tUsLUpjoCLdCVe42grEkCWKQW+t5knP1zP8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27C3NLPY125075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Aug 2022 22:23:21 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 11
 Aug 2022 22:23:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 11 Aug 2022 22:23:21 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27C3MkOt096105;
        Thu, 11 Aug 2022 22:23:13 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <nm@ti.com>, <j-keerthy@ti.com>, <lee@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 3/6] rtc: rtc-tps6594x: Add support for TPS6594X PMIC RTC
Date:   Thu, 11 Aug 2022 20:22:39 -0700
Message-ID: <20220812032242.564026-4-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220812032242.564026-1-mranostay@ti.com>
References: <20220812032242.564026-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add support for TPS6594X PMIC RTC. However, currently only get/set of
time + date functionality is supported..

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/rtc/Kconfig        |  10 ++
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-tps6594x.c | 181 +++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)
 create mode 100644 drivers/rtc/rtc-tps6594x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b8de25118ad0..df8e78eed5fb 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -593,6 +593,16 @@ config RTC_DRV_TPS65910
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-tps65910.
 
+config RTC_DRV_TPS6594X
+	tristate "TI TPS6594X RTC driver"
+	depends on MFD_TPS6594X
+	help
+	  If you say yes here you get support for the RTC of TI TPS6594X series PMIC
+	  chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-tps6594x.
+
 config RTC_DRV_RC5T583
 	tristate "RICOH 5T583 RTC driver"
 	depends on MFD_RC5T583
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index aab22bc63432..d854e162275a 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -177,6 +177,7 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_TI_K3)	+= rtc-ti-k3.o
 obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
 obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
+obj-$(CONFIG_RTC_DRV_TPS6594X)	+= rtc-tps6594x.o
 obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl.o
 obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
 obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
diff --git a/drivers/rtc/rtc-tps6594x.c b/drivers/rtc/rtc-tps6594x.c
new file mode 100644
index 000000000000..e9f904d0a769
--- /dev/null
+++ b/drivers/rtc/rtc-tps6594x.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtc-tps6594x.c -- TPS6594x Real Time Clock driver.
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * TODO: alarm support
+ */
+
+#include <linux/bcd.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/tps6594x.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct tps6594x_rtc {
+	struct rtc_device	*rtc;
+	struct device		*dev;
+};
+
+#define TPS6594X_NUM_TIME_REGS	(TPS6594X_RTC_YEARS - TPS6594X_RTC_SECONDS + 1)
+
+static int tps6594x_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[TPS6594X_NUM_TIME_REGS];
+	struct tps6594x *tps6594x = dev_get_drvdata(dev->parent);
+	int ret;
+
+	/* Reset TPS6594X_RTC_CTRL_REG_GET_TIME bit to zero, required for latch */
+	ret = regmap_update_bits(tps6594x->regmap, TPS6594X_RTC_CTRL_1,
+		TPS6594X_RTC_CTRL_REG_GET_TIME, 0);
+	if (ret < 0) {
+		dev_err(dev, "RTC CTRL reg update failed, err: %d\n", ret);
+		return ret;
+	}
+
+	/* Copy RTC counting registers to static registers or latches */
+	ret = regmap_update_bits(tps6594x->regmap, TPS6594X_RTC_CTRL_1,
+		TPS6594X_RTC_CTRL_REG_GET_TIME, TPS6594X_RTC_CTRL_REG_GET_TIME);
+	if (ret < 0) {
+		dev_err(dev, "RTC CTRL reg update failed, err: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_read(tps6594x->regmap, TPS6594X_RTC_SECONDS,
+			rtc_data, TPS6594X_NUM_TIME_REGS);
+	if (ret < 0) {
+		dev_err(dev, "RTC_SECONDS reg read failed, err = %d\n", ret);
+		return ret;
+	}
+
+	tm->tm_sec = bcd2bin(rtc_data[0]);
+	tm->tm_min = bcd2bin(rtc_data[1]);
+	tm->tm_hour = bcd2bin(rtc_data[2]);
+	tm->tm_mday = bcd2bin(rtc_data[3]);
+	tm->tm_mon = bcd2bin(rtc_data[4]) - 1;
+	tm->tm_year = bcd2bin(rtc_data[5]) + 100;
+
+	return ret;
+}
+
+static int tps6594x_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char rtc_data[TPS6594X_NUM_TIME_REGS];
+	struct tps6594x *tps6594x = dev_get_drvdata(dev->parent);
+	int ret, retries = 5;
+	unsigned int val;
+
+	rtc_data[0] = bin2bcd(tm->tm_sec);
+	rtc_data[1] = bin2bcd(tm->tm_min);
+	rtc_data[2] = bin2bcd(tm->tm_hour);
+	rtc_data[3] = bin2bcd(tm->tm_mday);
+	rtc_data[4] = bin2bcd(tm->tm_mon + 1);
+	rtc_data[5] = bin2bcd(tm->tm_year - 100);
+
+	/* Stop RTC while updating the RTC time registers */
+	ret = regmap_update_bits(tps6594x->regmap, TPS6594X_RTC_CTRL_1,
+				 TPS6594X_RTC_CTRL_REG_STOP_RTC, 0);
+	if (ret < 0) {
+		dev_err(dev, "RTC stop failed, err = %d\n", ret);
+		return ret;
+	}
+
+	/* Waiting till RTC isn't running */
+	do {
+		ret = regmap_read(tps6594x->regmap, TPS6594X_RTC_STATUS, &val);
+		if (ret < 0) {
+			dev_err(dev, "RTC_STATUS reg read failed, err = %d\n", ret);
+			return ret;
+		}
+		msleep(20);
+	} while (--retries && (val & TPS6594X_RTC_STATUS_RUN));
+
+	if (!retries) {
+		dev_err(dev, "RTC_STATUS is still RUNNING\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = regmap_bulk_write(tps6594x->regmap, TPS6594X_RTC_SECONDS,
+		rtc_data, TPS6594X_NUM_TIME_REGS);
+	if (ret < 0) {
+		dev_err(dev, "RTC_SECONDS reg write failed, err = %d\n", ret);
+		return ret;
+	}
+
+	/* Start back RTC */
+	ret = regmap_update_bits(tps6594x->regmap, TPS6594X_RTC_CTRL_1,
+				 TPS6594X_RTC_CTRL_REG_STOP_RTC,
+				 TPS6594X_RTC_CTRL_REG_STOP_RTC);
+	if (ret < 0)
+		dev_err(dev, "RTC start failed, err = %d\n", ret);
+
+	return ret;
+}
+
+static const struct rtc_class_ops tps6594x_rtc_ops = {
+	.read_time	= tps6594x_rtc_read_time,
+	.set_time	= tps6594x_rtc_set_time,
+};
+
+static int tps6594x_rtc_probe(struct platform_device *pdev)
+{
+	struct tps6594x *tps6594x = dev_get_drvdata(pdev->dev.parent);
+	struct tps6594x_rtc *tps6594x_rtc = NULL;
+	int ret;
+
+	tps6594x_rtc = devm_kzalloc(&pdev->dev, sizeof(struct tps6594x_rtc), GFP_KERNEL);
+	if (!tps6594x_rtc)
+		return -ENOMEM;
+
+	tps6594x_rtc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, tps6594x_rtc);
+
+	/* Start RTC */
+	ret = regmap_update_bits(tps6594x->regmap, TPS6594X_RTC_CTRL_1,
+				 TPS6594X_RTC_CTRL_REG_STOP_RTC,
+				 TPS6594X_RTC_CTRL_REG_STOP_RTC);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "RTC_CTRL write failed, err = %d\n", ret);
+		return ret;
+	}
+
+	tps6594x_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
+				&tps6594x_rtc_ops, THIS_MODULE);
+	if (IS_ERR(tps6594x_rtc->rtc)) {
+		ret = PTR_ERR(tps6594x_rtc->rtc);
+		dev_err(&pdev->dev, "RTC register failed, err = %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_tps6594x_rtc_match[] = {
+	{ .compatible = "ti,tps6594x-rtc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_tps6594x_rtc_match);
+#endif
+
+static struct platform_driver tps6594x_rtc_driver = {
+	.probe		= tps6594x_rtc_probe,
+	.driver		= {
+		.name	= "tps6594x-rtc",
+		.of_match_table = of_match_ptr(of_tps6594x_rtc_match),
+	},
+};
+
+module_platform_driver(tps6594x_rtc_driver);
+
+MODULE_ALIAS("platform:tps6594x_rtc");
+MODULE_DESCRIPTION("TI TPS6594x series RTC driver");
+MODULE_AUTHOR("Keerthy J <j-keerthy@ti.com>");
+MODULE_LICENSE("GPL");
-- 
2.36.1

