Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5955752D566
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiESN73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiESN5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:57:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA975F48;
        Thu, 19 May 2022 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652968625; x=1684504625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zdzrj6RYPH/TfNTElIW8pSK7IwqHnd878/9VPZGE9fA=;
  b=eOpGZKO93WVK+G0/T2yYup5AjGaMKpHb6Zrq5sbFN0GWO6Yv57/gUoo/
   FOXhJ+dQ44lxIYZLdmyxEhYQyKUiK5pMsCcT9HRu2BTTc/X+VU++eBgso
   oLQpO3RoRTnWm1R/pq1qPVRTVSZwjRAxMYdOLXdY2rnxAkKg4fgISrCU9
   bsECkzX+eEG75Q7Z3CEjN7NVoOEoV4mhjAxBbDCcQwqU4V1swtiGmKXaw
   +nFFD6gQE1pSH6W/9uzUg2NeNrf4TSikkWkxN6cqSTkBO2QU6VoExCgbW
   C9whi1FQo2vANtVVXv0/wuvo4iJpVItzTc/C7kQTlE2t2sKlYnR8MrEIl
   A==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="174147450"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2022 06:56:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 19 May 2022 06:56:59 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 19 May 2022 06:56:57 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <conor.dooley@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 1/2] rtc: Add driver for Microchip PolarFire SoC
Date:   Thu, 19 May 2022 14:55:22 +0100
Message-ID: <20220519135523.594347-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519135523.594347-1-conor.dooley@microchip.com>
References: <20220519135523.594347-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the built-in RTC on Microchip PolarFire SoC

Co-developed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/rtc/Kconfig    |  10 ++
 drivers/rtc/Makefile   |   1 +
 drivers/rtc/rtc-mpfs.c | 326 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/rtc/rtc-mpfs.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 41c65b4d2baf..a194422328da 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1966,4 +1966,14 @@ config RTC_DRV_MSC313
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-msc313".
 
+config RTC_DRV_POLARFIRE_SOC
+	tristate "Microchip PolarFire SoC built-in RTC"
+	depends on SOC_MICROCHIP_POLARFIRE
+	help
+	  If you say yes here you will get support for the
+	  built-in RTC on Polarfire SoC.
+
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-mpfs".
+
 endif # RTC_CLASS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 2d827d8261d5..25ee5ba870a9 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_RTC_DRV_PIC32)	+= rtc-pic32.o
 obj-$(CONFIG_RTC_DRV_PL030)	+= rtc-pl030.o
 obj-$(CONFIG_RTC_DRV_PL031)	+= rtc-pl031.o
 obj-$(CONFIG_RTC_DRV_PM8XXX)	+= rtc-pm8xxx.o
+obj-$(CONFIG_RTC_DRV_POLARFIRE_SOC)	+= rtc-mpfs.o
 obj-$(CONFIG_RTC_DRV_PS3)	+= rtc-ps3.o
 obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
 obj-$(CONFIG_RTC_DRV_R7301)	+= rtc-r7301.o
diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
new file mode 100644
index 000000000000..b3a1789d7c8e
--- /dev/null
+++ b/drivers/rtc/rtc-mpfs.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip MPFS RTC driver
+ *
+ * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ *         & Conor Dooley <conor.dooley@microchip.com>
+ */
+#include "linux/bits.h"
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/slab.h>
+#include <linux/rtc.h>
+
+#define CONTROL_REG		0x00
+#define MODE_REG		0x04
+#define PRESCALER_REG		0x08
+#define ALARM_LOWER_REG		0x0c
+#define ALARM_UPPER_REG		0x10
+#define COMPARE_LOWER_REG	0x14
+#define COMPARE_UPPER_REG	0x18
+#define DATETIME_LOWER_REG	0x20
+#define DATETIME_UPPER_REG	0x24
+
+#define CONTROL_RUNNING_BIT	BIT(0)
+#define CONTROL_START_BIT	BIT(0)
+#define CONTROL_STOP_BIT	BIT(1)
+#define CONTROL_ALARM_ON_BIT	BIT(2)
+#define CONTROL_ALARM_OFF_BIT	BIT(3)
+#define CONTROL_RESET_BIT	BIT(4)
+#define CONTROL_UPLOAD_BIT	BIT(5)
+#define CONTROL_DOWNLOAD_BIT	BIT(6)
+#define CONTROL_DOWNLOAD_BIT	BIT(6)
+#define CONTROL_WAKEUP_CLR_BIT	BIT(8)
+#define CONTROL_WAKEUP_SET_BIT	BIT(9)
+#define CONTROL_UPDATED_BIT	BIT(10)
+
+#define MODE_CLOCK_CALENDAR	BIT(0)
+#define MODE_WAKE_EN		BIT(1)
+#define MODE_WAKE_RESET		BIT(2)
+#define MODE_WAKE_CONTINUE	BIT(3)
+
+#define MAX_PRESCALER_COUNT	GENMASK(25, 0)
+#define DATETIME_UPPER_MASK	GENMASK(29, 0)
+#define ALARM_UPPER_MASK	GENMASK(10, 0)
+
+struct mpfs_rtc_dev {
+	struct rtc_device *rtc;
+	void __iomem *base;
+};
+
+static void mpfs_rtc_start(struct mpfs_rtc_dev *rtcdev)
+{
+	u32 ctrl;
+
+	ctrl = readl(rtcdev->base + CONTROL_REG);
+	ctrl &= ~(CONTROL_STOP_BIT | CONTROL_START_BIT);
+	ctrl |= CONTROL_START_BIT;
+	writel(ctrl, rtcdev->base + CONTROL_REG);
+}
+
+static void mpfs_rtc_clear_irq(struct mpfs_rtc_dev *rtcdev)
+{
+	u32 val = readl(rtcdev->base + CONTROL_REG);
+
+	val &= ~(CONTROL_ALARM_ON_BIT | CONTROL_STOP_BIT);
+	val |= CONTROL_ALARM_OFF_BIT;
+	writel(val, rtcdev->base + CONTROL_REG);
+	/*
+	 * Ensure that the posted write to the CONTROL_REG register completed before
+	 * returning from this function. Not doing this may result in the interrupt
+	 * only being cleared some time after this function returns.
+	 */
+	(void)readl(rtcdev->base + CONTROL_REG);
+}
+
+static int mpfs_rtc_readtime(struct device *dev, struct rtc_time *tm)
+{
+	struct mpfs_rtc_dev *rtcdev = dev_get_drvdata(dev);
+	u64 time;
+
+	time = readl(rtcdev->base + DATETIME_LOWER_REG);
+	time |= ((u64)readl(rtcdev->base + DATETIME_UPPER_REG) & DATETIME_UPPER_MASK) << 32;
+	rtc_time64_to_tm(time, tm);
+
+	return 0;
+}
+
+static int mpfs_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	struct mpfs_rtc_dev *rtcdev = dev_get_drvdata(dev);
+	u32 ctrl, prog;
+	u64 time;
+
+	time = rtc_tm_to_time64(tm);
+
+	writel((u32)time, rtcdev->base + DATETIME_LOWER_REG);
+	writel((u32)(time >> 32) & DATETIME_UPPER_MASK, rtcdev->base + DATETIME_UPPER_REG);
+
+	ctrl = readl(rtcdev->base + CONTROL_REG);
+	ctrl &= ~CONTROL_STOP_BIT;
+	ctrl |= CONTROL_UPLOAD_BIT;
+	writel(ctrl, rtcdev->base + CONTROL_REG);
+
+	do {
+		prog = readl(rtcdev->base + CONTROL_REG);
+		prog &= CONTROL_UPLOAD_BIT;
+	} while (prog);
+
+	mpfs_rtc_start(rtcdev);
+
+	return 0;
+}
+
+static int mpfs_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct mpfs_rtc_dev *rtcdev = dev_get_drvdata(dev);
+	u32 mode = readl(rtcdev->base + MODE_REG);
+	u64 time;
+
+	mode = readl(rtcdev->base + MODE_REG);
+
+	if (mode & MODE_WAKE_EN)
+		alrm->enabled = true;
+	else
+		alrm->enabled = false;
+
+	time = (u64)readl(rtcdev->base + ALARM_LOWER_REG) << 32;
+	time |= (readl(rtcdev->base + ALARM_UPPER_REG) & ALARM_UPPER_MASK);
+	rtc_time64_to_tm(time, &alrm->time);
+
+	return 0;
+}
+
+static int mpfs_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct mpfs_rtc_dev *rtcdev = dev_get_drvdata(dev);
+	u32 mode, ctrl;
+	u64 time;
+
+	/* Disable the alarm before updating */
+	ctrl = readl(rtcdev->base + CONTROL_REG);
+	ctrl |= CONTROL_ALARM_OFF_BIT;
+	writel(ctrl, rtcdev->base + CONTROL_REG);
+
+	time = rtc_tm_to_time64(&alrm->time);
+
+	writel((u32)time, rtcdev->base + ALARM_LOWER_REG);
+	writel((u32)(time >> 32) & ALARM_UPPER_MASK, rtcdev->base + ALARM_UPPER_REG);
+
+	/* Bypass compare register in alarm mode */
+	writel(GENMASK(31, 0), rtcdev->base + COMPARE_LOWER_REG);
+	writel(GENMASK(29, 0), rtcdev->base + COMPARE_UPPER_REG);
+
+	/* Configure the RTC to enable the alarm. */
+	ctrl = readl(rtcdev->base + CONTROL_REG);
+	mode = readl(rtcdev->base + MODE_REG);
+	if (alrm->enabled) {
+		mode = MODE_WAKE_EN | MODE_WAKE_CONTINUE;
+		/* Enable the alarm */
+		ctrl &= ~CONTROL_ALARM_OFF_BIT;
+		ctrl |= CONTROL_ALARM_ON_BIT;
+	}
+	ctrl &= ~CONTROL_STOP_BIT;
+	ctrl |= CONTROL_START_BIT;
+	writel(ctrl, rtcdev->base + CONTROL_REG);
+	writel(mode, rtcdev->base + MODE_REG);
+
+	return 0;
+}
+
+static int mpfs_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct mpfs_rtc_dev *rtcdev = dev_get_drvdata(dev);
+	u32 ctrl;
+
+	ctrl = readl(rtcdev->base + CONTROL_REG);
+	ctrl &= ~(CONTROL_ALARM_ON_BIT | CONTROL_ALARM_OFF_BIT | CONTROL_STOP_BIT);
+
+	if (enabled)
+		ctrl |= CONTROL_ALARM_ON_BIT;
+	else
+		ctrl |= CONTROL_ALARM_OFF_BIT;
+
+	writel(ctrl, rtcdev->base + CONTROL_REG);
+
+	return 0;
+}
+
+static inline struct clk *mpfs_rtc_init_clk(struct device *dev)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get(dev, "rtc");
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
+	return clk;
+}
+
+static irqreturn_t mpfs_rtc_wakeup_irq_handler(int irq, void *dev)
+{
+	struct mpfs_rtc_dev *rtcdev = dev;
+	unsigned long pending;
+
+	pending = readl(rtcdev->base + CONTROL_REG);
+	pending &= CONTROL_ALARM_ON_BIT;
+	mpfs_rtc_clear_irq(rtcdev);
+
+	rtc_update_irq(rtcdev->rtc, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops mpfs_rtc_ops = {
+	.read_time		= mpfs_rtc_readtime,
+	.set_time		= mpfs_rtc_settime,
+	.read_alarm		= mpfs_rtc_readalarm,
+	.set_alarm		= mpfs_rtc_setalarm,
+	.alarm_irq_enable	= mpfs_rtc_alarm_irq_enable,
+};
+
+static int mpfs_rtc_probe(struct platform_device *pdev)
+{
+	struct mpfs_rtc_dev *rtcdev;
+	struct clk *clk;
+	u32 prescaler;
+	int wakeup_irq, ret;
+
+	rtcdev = devm_kzalloc(&pdev->dev, sizeof(struct mpfs_rtc_dev), GFP_KERNEL);
+	if (!rtcdev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rtcdev);
+
+	rtcdev->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtcdev->rtc))
+		return PTR_ERR(rtcdev->rtc);
+
+	rtcdev->rtc->ops = &mpfs_rtc_ops;
+
+	/* range is capped by alarm max, lower reg is 31:0 & upper is 10:0 */
+	rtcdev->rtc->range_max = GENMASK_ULL(42, 0);
+
+	clk = mpfs_rtc_init_clk(&pdev->dev);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rtcdev->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rtcdev->base)) {
+		dev_dbg(&pdev->dev, "invalid ioremap resources\n");
+		return PTR_ERR(rtcdev->base);
+	}
+
+	wakeup_irq = platform_get_irq(pdev, 0);
+	if (wakeup_irq <= 0) {
+		dev_dbg(&pdev->dev, "could not get wakeup irq\n");
+		return wakeup_irq;
+	}
+	ret = devm_request_irq(&pdev->dev, wakeup_irq, mpfs_rtc_wakeup_irq_handler, 0,
+			       dev_name(&pdev->dev), rtcdev);
+	if (ret) {
+		dev_dbg(&pdev->dev, "could not request wakeup irq\n");
+		return ret;
+	}
+
+	/* prescaler hardware adds 1 to reg value */
+	prescaler = clk_get_rate(devm_clk_get(&pdev->dev, "rtcref")) - 1;
+
+	if (prescaler > MAX_PRESCALER_COUNT) {
+		dev_dbg(&pdev->dev, "invalid prescaler %d\n", prescaler);
+		return -EINVAL;
+	}
+
+	writel(prescaler, rtcdev->base + PRESCALER_REG);
+	dev_info(&pdev->dev, "prescaler set to: 0x%X \r\n", prescaler);
+
+	device_init_wakeup(&pdev->dev, true);
+	ret = dev_pm_set_wake_irq(&pdev->dev, wakeup_irq);
+	if (ret)
+		dev_err(&pdev->dev, "failed to enable irq wake\n");
+
+	return devm_rtc_register_device(rtcdev->rtc);
+}
+
+static int mpfs_rtc_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id mpfs_rtc_of_match[] = {
+	{ .compatible = "microchip,mpfs-rtc" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, mpfs_rtc_of_match);
+
+static struct platform_driver mpfs_rtc_driver = {
+	.probe = mpfs_rtc_probe,
+	.remove = mpfs_rtc_remove,
+	.driver	= {
+		.name = "mpfs_rtc",
+		.of_match_table = mpfs_rtc_of_match,
+	},
+};
+
+module_platform_driver(mpfs_rtc_driver);
+
+MODULE_DESCRIPTION("Real time clock for Microchip Polarfire SoC");
+MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.36.1

