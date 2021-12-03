Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB33D4672E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351023AbhLCHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350252AbhLCHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:49:43 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F66EC06173E;
        Thu,  2 Dec 2021 23:46:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so4498722pju.3;
        Thu, 02 Dec 2021 23:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbIdxkUemURtQ0FJJXow4C00OcHdkbJB5Yjom4PkUwQ=;
        b=O1Tr+CH6azuuydPJpVqPb1Fc05ELi6KIn+uNp+sQ/XgAZmln5dMeYYVIzlaxicvluC
         DS7k3ItZGjVDUymHPWx4Miv8VpUKkwC1vG3PBgK3g+xFVkIjmJ3M8g6pxtPiqu7XjNkW
         rt6BIL6rNM/XldPpSMqDEVdxKYLGYbwArQTpLHPRCrSYD5SyjEbdaqQ3v/fKKRz2IQGT
         GZh0Lo8JVNCS1KJEUVsh/UUTUpKn14HPGWV+ot1ZZqbyxElGYOYhqRs8wCWzJs4yOR85
         gABjmZCYXwsoG7NjKsj+55H8ZnkNcQqgyzMrEz7PlqDOZrG1/Mp6wY3CEHfZP2HmQHhH
         kkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QbIdxkUemURtQ0FJJXow4C00OcHdkbJB5Yjom4PkUwQ=;
        b=sUpiCN++sGz+Be7L8WOCr/pwuzSgou1gy4RN3fQqe58p5RlFxBs+tjC65WTOYZhadi
         qbakb7CXhNWMjkqPgQiiwDYFZWLFEoN3gft642bXjGqD6CdkFeyQnO41t84eJyU13MCn
         qFETWiIW755u44bXVXS9lQOX5qez3rzMbQk25S8TGZ0W3MCKcl4kAv27wj+hi4C5g5zz
         B7OcOk4vrIXZNWJ5qtruwYaADqRyabn5yXGsfhAx/okX2twbWrxTzJAQD9lef+lYo6Iy
         b4ZRp72BuMcNoCe9kbGB5tf8Fwhvdq27JbmL819va9GWJxip4AN5eZvhde3FApQ2Y0HA
         S2LA==
X-Gm-Message-State: AOAM5300VumD5f/BOWP5fvzROKLoQ6ZAQhwg4fsAF8SHwUjjrxcMZhyv
        0/HODvdLe3gAyfdBtpY3qto=
X-Google-Smtp-Source: ABdhPJxpFtFCQDw0eHvHTi+0HSXjzWvRLpxQqYJGD6ZrvvxYHmNHtSSsfhXh3vO9PckHtJjf+zr2wQ==
X-Received: by 2002:a17:903:24d:b0:143:beb5:b6b1 with SMTP id j13-20020a170903024d00b00143beb5b6b1mr21164499plh.54.1638517579578;
        Thu, 02 Dec 2021 23:46:19 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d19sm2162364pfv.199.2021.12.02.23.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 23:46:19 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
X-Google-Original-From: Vincent Shih <vincent.sunplus@gamil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gamil.com>
Subject: [PATCH v3 1/2] rtc: Add driver for RTC in Sunplus SP7021
Date:   Fri,  3 Dec 2021 15:46:18 +0800
Message-Id: <1638517579-10316-2-git-send-email-vincent.sunplus@gamil.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
References: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for RTC in Sunplus SP7021

Signed-off-by: Vincent Shih <vincent.sunplus@gamil.com>
---
Changes in v3:
 - Addressed the comments from Mr. Mateusz Jonczyk
 - Addressed the comments from Mr. Philipp Zabel
 - Addressed the comments from Mr. Alexandre Belloni

 MAINTAINERS               |   6 +
 drivers/rtc/Kconfig       |  13 ++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-sunplus.c | 362 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 drivers/rtc/rtc-sunplus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..8c86f28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,6 +17945,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS RTC DRIVER
+M:	Vincent Shih <vincent.sunplus@gmail.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	drivers/rtc/rtc-sunplus.c
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e1bc521..f2acc0e 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1457,6 +1457,19 @@ config RTC_DRV_SH
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc-sh.
 
+config RTC_DRV_SUNPLUS
+	tristate "Sunplus SP7021 RTC"
+	depends on SOC_SP7021
+	help
+	  Say 'yes' to get support for the real-time clock present in
+	  Sunplus SP7021 - a SoC for industrial applications. It provides
+	  RTC status check, timer/alarm functionalities, user data
+	  reservation with the battery over 2.5V, RTC power status check
+	  and battery charge.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-sunplus.
+
 config RTC_DRV_VR41XX
 	tristate "NEC VR41XX"
 	depends on CPU_VR41XX || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 5ceeafe..93cb4b2 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_RTC_DRV_STM32) 	+= rtc-stm32.o
 obj-$(CONFIG_RTC_DRV_STMP)	+= rtc-stmp3xxx.o
 obj-$(CONFIG_RTC_DRV_SUN4V)	+= rtc-sun4v.o
 obj-$(CONFIG_RTC_DRV_SUN6I)	+= rtc-sun6i.o
+obj-$(CONFIG_RTC_DRV_SUNPLUS)	+= rtc-sunplus.o
 obj-$(CONFIG_RTC_DRV_SUNXI)	+= rtc-sunxi.o
 obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
diff --git a/drivers/rtc/rtc-sunplus.c b/drivers/rtc/rtc-sunplus.c
new file mode 100644
index 0000000..0b38732
--- /dev/null
+++ b/drivers/rtc/rtc-sunplus.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * The RTC driver for Sunplus	SP7021
+ *
+ * Copyright (C) 2019 Sunplus Technology Inc., All rights reseerved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/rtc.h>
+
+#define RTC_REG_NAME			"rtc"
+
+#define RTC_CTRL			0x40
+#define TIMER_FREEZE_MASK_BIT		BIT(5 + 16)
+#define TIMER_FREEZE			BIT(5)
+#define DIS_SYS_RST_RTC_MASK_BIT	BIT(4 + 16)
+#define DIS_SYS_RST_RTC			BIT(4)
+#define RTC32K_MODE_RESET_MASK_BIT	BIT(3 + 16)
+#define RTC32K_MODE_RESET		BIT(3)
+#define ALARM_EN_OVERDUE_MASK_BIT	BIT(2 + 16)
+#define ALARM_EN_OVERDUE		BIT(2)
+#define ALARM_EN_PMC_MASK_BIT		BIT(1 + 16)
+#define ALARM_EN_PMC			BIT(1)
+#define ALARM_EN_MASK_BIT		BIT(0 + 16)
+#define ALARM_EN			BIT(0)
+#define RTC_TIMER_OUT			0x44
+#define RTC_DIVIDER			0x48
+#define RTC_TIMER_SET			0x4c
+#define RTC_ALARM_SET			0x50
+#define RTC_USER_DATA			0x54
+#define RTC_RESET_RECORD		0x58
+#define RTC_BATT_CHARGE_CTRL		0x5c
+#define BAT_CHARGE_RSEL_MASK_BIT	GENMASK(3 + 16, 2 + 16)
+#define BAT_CHARGE_RSEL_MASK		GENMASK(3, 2)
+#define BAT_CHARGE_RSEL_2K_OHM		FIELD_PREP(BAT_CHARGE_RSEL_MASK, 0)
+#define BAT_CHARGE_RSEL_250_OHM		FIELD_PREP(BAT_CHARGE_RSEL_MASK, 1)
+#define BAT_CHARGE_RSEL_50_OHM		FIELD_PREP(BAT_CHARGE_RSEL_MASK, 2)
+#define BAT_CHARGE_RSEL_0_OHM		FIELD_PREP(BAT_CHARGE_RSEL_MASK, 3)
+#define BAT_CHARGE_DSEL_MASK_BIT	BIT(1 + 16)
+#define BAT_CHARGE_DSEL_MASK		GENMASK(1, 1)
+#define BAT_CHARGE_DSEL_ON		FIELD_PREP(BAT_CHARGE_DSEL_MASK, 0)
+#define BAT_CHARGE_DSEL_OFF		FIELD_PREP(BAT_CHARGE_DSEL_MASK, 1)
+#define BAT_CHARGE_EN_MASK_BIT		BIT(0 + 16)
+#define BAT_CHARGE_EN			BIT(0)
+#define RTC_TRIM_CTRL			0x60
+
+struct sunplus_rtc {
+	struct rtc_device *rtc;
+	struct resource *res;
+	struct clk *rtcclk;
+	struct reset_control *rstc;
+	void __iomem *reg_base;
+	int irq;
+};
+
+static void sp_get_seconds(struct device *dev, unsigned long *secs)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+
+	*secs = (unsigned long)readl(sp_rtc->reg_base + RTC_TIMER_OUT);
+}
+
+static void sp_set_seconds(struct device *dev, unsigned long secs)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+
+	writel((u32)secs, sp_rtc->reg_base + RTC_TIMER_SET);
+}
+
+static int sp_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned long secs;
+
+	sp_get_seconds(dev, &secs);
+	rtc_time64_to_tm(secs, tm);
+
+	return 0;
+}
+
+static int sp_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned long secs;
+
+	secs = rtc_tm_to_time64(tm);
+	dev_dbg(dev, "%s, secs = %lu\n", __func__, secs);
+	sp_set_seconds(dev, secs);
+
+	return 0;
+}
+
+static int sp_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+	unsigned long alarm_time;
+
+	alarm_time = rtc_tm_to_time64(&alrm->time);
+	dev_dbg(dev, "%s, alarm_time: %u\n", __func__, (u32)(alarm_time));
+	writel((u32)alarm_time, sp_rtc->reg_base + RTC_ALARM_SET);
+
+	return 0;
+}
+
+static int sp_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+	unsigned int alarm_time;
+
+	alarm_time = readl(sp_rtc->reg_base + RTC_ALARM_SET);
+	dev_dbg(dev, "%s, alarm_time: %u\n", __func__, alarm_time);
+
+	if (alarm_time == 0)
+		alrm->enabled = 0;
+	else
+		alrm->enabled = 1;
+
+	rtc_time64_to_tm((unsigned long)(alarm_time), &alrm->time);
+
+	return 0;
+}
+
+static int sp_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+
+	if (enabled)
+		writel((TIMER_FREEZE_MASK_BIT | DIS_SYS_RST_RTC_MASK_BIT |
+			RTC32K_MODE_RESET_MASK_BIT | ALARM_EN_OVERDUE_MASK_BIT |
+			ALARM_EN_PMC_MASK_BIT | ALARM_EN_MASK_BIT) |
+			(DIS_SYS_RST_RTC | ALARM_EN_OVERDUE | ALARM_EN_PMC | ALARM_EN),
+			sp_rtc->reg_base + RTC_CTRL);
+	else
+		writel((ALARM_EN_OVERDUE_MASK_BIT | ALARM_EN_PMC_MASK_BIT | ALARM_EN_MASK_BIT) |
+			0x0, sp_rtc->reg_base + RTC_CTRL);
+
+	return 0;
+}
+
+static const struct rtc_class_ops sp_rtc_ops = {
+	.read_time =		sp_rtc_read_time,
+	.set_time =		sp_rtc_set_time,
+	.set_alarm =		sp_rtc_set_alarm,
+	.read_alarm =		sp_rtc_read_alarm,
+	.alarm_irq_enable =	sp_rtc_alarm_irq_enable,
+};
+
+static irqreturn_t sp_rtc_irq_handler(int irq, void *dev_id)
+{
+	struct platform_device *plat_dev = dev_id;
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(&plat_dev->dev);
+
+	rtc_update_irq(sp_rtc->rtc, 1, RTC_IRQF | RTC_AF);
+	dev_dbg(&plat_dev->dev, "[RTC] ALARM INT\n");
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * -------------------------------------------------------------------------------------
+ * bat_charge_rsel   bat_charge_dsel   bat_charge_en     Remarks
+ *         x              x                 0            Disable
+ *         0              0                 1            0.86mA (2K Ohm with diode)
+ *         1              0                 1            1.81mA (250 Ohm with diode)
+ *         2              0                 1            2.07mA (50 Ohm with diode)
+ *         3              0                 1            16.0mA (0 Ohm with diode)
+ *         0              1                 1            1.36mA (2K Ohm without diode)
+ *         1              1                 1            3.99mA (250 Ohm without diode)
+ *         2              1                 1            4.41mA (50 Ohm without diode)
+ *         3              1                 1            16.0mA (0 Ohm without diode)
+ * -------------------------------------------------------------------------------------
+ */
+static void sp_rtc_set_trickle_charger(struct device dev)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(&dev);
+	u32 ohms, rsel;
+	u32 chargeable;
+
+	if (of_property_read_u32(dev.of_node, "trickle-resistor-ohms", &ohms) ||
+	    of_property_read_u32(dev.of_node, "aux-voltage-chargeable", &chargeable)) {
+		dev_warn(&dev, "battery charger disabled\n");
+		return;
+	}
+
+	switch (ohms) {
+	case 2000:
+		rsel = BAT_CHARGE_RSEL_2K_OHM;
+		break;
+	case 250:
+		rsel = BAT_CHARGE_RSEL_250_OHM;
+		break;
+	case 50:
+		rsel = BAT_CHARGE_RSEL_50_OHM;
+		break;
+	case 0:
+		rsel = BAT_CHARGE_RSEL_0_OHM;
+		break;
+	default:
+		dev_err(&dev, "invalid charger resistor value (%d)\n", ohms);
+		return;
+	}
+
+	writel(BAT_CHARGE_RSEL_MASK_BIT | rsel, sp_rtc->reg_base + RTC_BATT_CHARGE_CTRL);
+
+	switch (chargeable) {
+	case 0:
+		writel(BAT_CHARGE_DSEL_MASK_BIT | BAT_CHARGE_DSEL_OFF,
+		       sp_rtc->reg_base + RTC_BATT_CHARGE_CTRL);
+		break;
+	case 1:
+		writel(BAT_CHARGE_DSEL_MASK_BIT | BAT_CHARGE_DSEL_ON,
+		       sp_rtc->reg_base + RTC_BATT_CHARGE_CTRL);
+		break;
+	default:
+		dev_err(&dev, "invalid aux-voltage-chargeable value (%d)\n", chargeable);
+		return;
+	}
+
+	writel(BAT_CHARGE_EN_MASK_BIT | BAT_CHARGE_EN, sp_rtc->reg_base + RTC_BATT_CHARGE_CTRL);
+}
+
+static int sp_rtc_probe(struct platform_device *plat_dev)
+{
+	struct sunplus_rtc *sp_rtc;
+	int ret;
+
+	sp_rtc = devm_kzalloc(&plat_dev->dev, sizeof(*sp_rtc), GFP_KERNEL);
+	if (!sp_rtc)
+		return -ENOMEM;
+
+	sp_rtc->res = platform_get_resource_byname(plat_dev, IORESOURCE_MEM, RTC_REG_NAME);
+	sp_rtc->reg_base = devm_ioremap_resource(&plat_dev->dev, sp_rtc->res);
+	if (IS_ERR(sp_rtc->reg_base))
+		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->res),
+					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
+	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
+		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
+
+	sp_rtc->irq = platform_get_irq(plat_dev, 0);
+	if (sp_rtc->irq < 0)
+		return dev_err_probe(&plat_dev->dev, sp_rtc->irq, "platform_get_irq failed\n");
+
+	ret = devm_request_irq(&plat_dev->dev, sp_rtc->irq, sp_rtc_irq_handler,
+			       IRQF_TRIGGER_RISING, "rtc irq", plat_dev);
+	if (ret)
+		return dev_err_probe(&plat_dev->dev, ret, "devm_request_irq failed:\n");
+
+	sp_rtc->rtcclk = devm_clk_get(&plat_dev->dev, NULL);
+	if (IS_ERR(sp_rtc->rtcclk))
+		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->rtcclk),
+					    "devm_clk_get fail\n");
+
+	sp_rtc->rstc = devm_reset_control_get_exclusive(&plat_dev->dev, NULL);
+	if (IS_ERR(sp_rtc->rstc))
+		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->rstc),
+					    "failed to retrieve reset controller\n");
+
+	ret = clk_prepare_enable(sp_rtc->rtcclk);
+	if (ret)
+		goto free_clk;
+
+	ret = reset_control_deassert(sp_rtc->rstc);
+	if (ret)
+		goto free_reset_assert;
+
+	device_init_wakeup(&plat_dev->dev, 1);
+	dev_set_drvdata(&plat_dev->dev, sp_rtc);
+
+	sp_rtc->rtc = devm_rtc_allocate_device(&plat_dev->dev);
+	if (IS_ERR(sp_rtc->rtc)) {
+		ret = PTR_ERR(sp_rtc->rtc);
+		goto free_reset_assert;
+	}
+
+	sp_rtc->rtc->range_max = U32_MAX;
+	sp_rtc->rtc->range_min = 0;
+	sp_rtc->rtc->ops = &sp_rtc_ops;
+
+	ret = devm_rtc_register_device(sp_rtc->rtc);
+	if (ret)
+		goto free_reset_assert;
+
+	/* Setup trickle charger */
+	if (plat_dev->dev.of_node)
+		sp_rtc_set_trickle_charger(plat_dev->dev);
+
+	/* Keep RTC from system reset */
+	writel(DIS_SYS_RST_RTC_MASK_BIT | DIS_SYS_RST_RTC, sp_rtc->reg_base + RTC_CTRL);
+
+	return 0;
+
+free_reset_assert:
+	reset_control_assert(sp_rtc->rstc);
+free_clk:
+	clk_disable_unprepare(sp_rtc->rtcclk);
+
+	return ret;
+}
+
+static int sp_rtc_remove(struct platform_device *plat_dev)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(&plat_dev->dev);
+
+	device_init_wakeup(&plat_dev->dev, 0);
+	reset_control_assert(sp_rtc->rstc);
+	clk_disable_unprepare(sp_rtc->rtcclk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sp_rtc_suspend(struct device *dev)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(sp_rtc->irq);
+
+	return 0;
+}
+
+static int sp_rtc_resume(struct device *dev)
+{
+	struct sunplus_rtc *sp_rtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(sp_rtc->irq);
+
+	return 0;
+}
+#endif
+
+static const struct of_device_id sp_rtc_of_match[] = {
+	{ .compatible = "sunplus,sp7021-rtc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sp_rtc_of_match);
+
+static SIMPLE_DEV_PM_OPS(sp_rtc_pm_ops, sp_rtc_suspend, sp_rtc_resume);
+
+static struct platform_driver sp_rtc_driver = {
+	.probe   = sp_rtc_probe,
+	.remove  = sp_rtc_remove,
+	.driver  = {
+		.name	= "sp7021-rtc",
+		.of_match_table = sp_rtc_of_match,
+		.pm	= &sp_rtc_pm_ops,
+	},
+};
+module_platform_driver(sp_rtc_driver);
+
+MODULE_AUTHOR("Vincent Shih <vincent.sunplus@gmail.com>");
+MODULE_DESCRIPTION("Sunplus RTC driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.7.4

