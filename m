Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCF47BC03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhLUIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:43:44 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:24875 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhLUInn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640076223; x=1671612223;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FoteKoRJX78H5c16Zg+pD+tD6dRTUsTN1ii4EqBF/l8=;
  b=NmfqEQ168vy0RaxMh3UaJngwYAHqp+3BIJgNwoKqRj1G9qfTi2N0mH7N
   tvdsK11KRBICGGGFUc/BINsdLwGSKW8ORNCYUvCHAbMCWva43YLsR69U2
   Ux0h677nl/Z3QMzyAxtbpvvuUSDo6R30LWGyUoIecdVyFW4SM62T4dxEw
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2021 00:43:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 00:43:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 00:43:42 -0800
Received: from jianbinz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 00:43:39 -0800
From:   jianbinz <quic_jianbinz@quicinc.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>
CC:     jianbinz <quic_jianbinz@quicinc.com>, <quic_fenglinw@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_aghayal@quicinc.com>, <quic_maggarwa@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: [PATCH] rtc: rtc-pm8xxx: Retrigger RTC alarm if it's fired before the driver probed
Date:   Tue, 21 Dec 2021 16:43:18 +0800
Message-ID: <20211221084318.8125-1-quic_jianbinz@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the alarm is triggered before the driver gets probed, the alarm
interrupt will be missed and it won't be detected, and the stale
alarm settings will be still retained because of not being cleared.
Check this condition during driver probe, retrigger the alarm and
clear the settings manually if it's such case.

Signed-off-by: jianbinz <quic_jianbinz@quicinc.com>
---
 drivers/rtc/rtc-pm8xxx.c | 149 ++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 29a1c65661e9..adba2fdd6645 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
  */
+
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -64,6 +65,62 @@ struct pm8xxx_rtc {
 	spinlock_t ctrl_reg_lock;
 };
 
+static int pm8xxx_rtc_read_rtc_data(struct pm8xxx_rtc *rtc_dd, unsigned long *rtc_data)
+{
+	int rc;
+	u8 value[NUM_8_BIT_RTC_REGS];
+	unsigned int reg;
+	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+
+	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
+	if (rc) {
+		dev_err(rtc_dd->rtc_dev, "RTC read rtc data register failed\n");
+		return rc;
+	}
+
+	/*
+	 * Read the LSB again and check if there has been a carry over.
+	 * If there is, redo the read operation.
+	 */
+	rc = regmap_read(rtc_dd->regmap, regs->read, &reg);
+	if (rc < 0) {
+		dev_err(rtc_dd->rtc_dev, "RTC read rtc data register failed\n");
+		return rc;
+	}
+
+	if (unlikely(reg < value[0])) {
+		rc = regmap_bulk_read(rtc_dd->regmap, regs->read,
+				      value, sizeof(value));
+		if (rc) {
+			dev_err(rtc_dd->rtc_dev, "RTC read rtc data register failed\n");
+			return rc;
+		}
+	}
+
+	*rtc_data = value[0] | (value[1] << 8) | (value[2] << 16) |
+			((unsigned long)value[3] << 24);
+
+	return 0;
+}
+
+static int pm8xxx_rtc_read_alarm_data(struct pm8xxx_rtc *rtc_dd, unsigned long *alarm_data)
+{
+	int rc;
+	u8 value[NUM_8_BIT_RTC_REGS];
+
+	rc = regmap_bulk_read(rtc_dd->regmap, rtc_dd->regs->alarm_rw, value,
+			      sizeof(value));
+	if (rc) {
+		dev_err(rtc_dd->rtc_dev, "RTC read alarm data failed\n");
+		return rc;
+	}
+
+	*alarm_data = value[0] | (value[1] << 8) | (value[2] << 16) |
+			((unsigned long)value[3] << 24);
+
+	return 0;
+}
+
 /*
  * Steps to write the RTC registers.
  * 1. Disable alarm if enabled.
@@ -175,40 +232,15 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int pm8xxx_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	int rc;
-	u8 value[NUM_8_BIT_RTC_REGS];
 	unsigned long secs;
-	unsigned int reg;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
-	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 
-	rc = regmap_bulk_read(rtc_dd->regmap, regs->read, value, sizeof(value));
+	rc = pm8xxx_rtc_read_rtc_data(rtc_dd, &secs);
 	if (rc) {
-		dev_err(dev, "RTC read data register failed\n");
+		dev_err(dev, "RTC read time failed\n");
 		return rc;
 	}
 
-	/*
-	 * Read the LSB again and check if there has been a carry over.
-	 * If there is, redo the read operation.
-	 */
-	rc = regmap_read(rtc_dd->regmap, regs->read, &reg);
-	if (rc < 0) {
-		dev_err(dev, "RTC read data register failed\n");
-		return rc;
-	}
-
-	if (unlikely(reg < value[0])) {
-		rc = regmap_bulk_read(rtc_dd->regmap, regs->read,
-				      value, sizeof(value));
-		if (rc) {
-			dev_err(dev, "RTC read data register failed\n");
-			return rc;
-		}
-	}
-
-	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
-	       ((unsigned long)value[3] << 24);
-
 	rtc_time64_to_tm(secs, tm);
 
 	dev_dbg(dev, "secs = %lu, h:m:s == %ptRt, y-m-d = %ptRdr\n", secs, tm, tm);
@@ -267,21 +299,16 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 {
 	int rc;
 	unsigned int ctrl_reg;
-	u8 value[NUM_8_BIT_RTC_REGS];
 	unsigned long secs;
 	struct pm8xxx_rtc *rtc_dd = dev_get_drvdata(dev);
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
 
-	rc = regmap_bulk_read(rtc_dd->regmap, regs->alarm_rw, value,
-			      sizeof(value));
+	rc = pm8xxx_rtc_read_alarm_data(rtc_dd, &secs);
 	if (rc) {
-		dev_err(dev, "RTC alarm time read failed\n");
+		dev_err(dev, "RTC alarm data read failed\n");
 		return rc;
 	}
 
-	secs = value[0] | (value[1] << 8) | (value[2] << 16) |
-	       ((unsigned long)value[3] << 24);
-
 	rtc_time64_to_tm(secs, &alarm->time);
 
 	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
@@ -394,6 +421,52 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Trigger the alarm event and clear the alarm settings
+ * if the alarm data has been behind the RTC data which
+ * means the alarm has been triggered before the driver
+ * is probed.
+ */
+static int pm8xxx_rtc_init_alarm(struct pm8xxx_rtc *rtc_dd)
+{
+	int rc;
+	unsigned long rtc_data, alarm_data, irq_flags;
+	unsigned int ctrl_reg, alarm_en;
+	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
+
+	spin_lock_irqsave(&rtc_dd->ctrl_reg_lock, irq_flags);
+
+	rc = pm8xxx_rtc_read_rtc_data(rtc_dd, &rtc_data);
+	if (rc) {
+		spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
+		dev_err(rtc_dd->rtc_dev, "rtc read rtc data failed\n");
+		return rc;
+	}
+
+	rc = pm8xxx_rtc_read_alarm_data(rtc_dd, &alarm_data);
+	if (rc) {
+		spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
+		dev_err(rtc_dd->rtc_dev, "rtc read alarm data failed\n");
+		return rc;
+	}
+
+	rc = regmap_read(rtc_dd->regmap, regs->alarm_ctrl, &ctrl_reg);
+	if (rc) {
+		spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
+		dev_err(rtc_dd->rtc_dev, "Read from RTC alarm control register failed\n");
+		return rc;
+	}
+
+	spin_unlock_irqrestore(&rtc_dd->ctrl_reg_lock, irq_flags);
+
+	alarm_en = !!(ctrl_reg & PM8xxx_RTC_ALARM_ENABLE);
+
+	if (alarm_en && rtc_data >= alarm_data)
+		pm8xxx_alarm_trigger(0, rtc_dd);
+
+	return 0;
+}
+
 static int pm8xxx_rtc_enable(struct pm8xxx_rtc *rtc_dd)
 {
 	const struct pm8xxx_rtc_regs *regs = rtc_dd->regs;
@@ -527,7 +600,13 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	return devm_rtc_register_device(rtc_dd->rtc);
+	rc =  devm_rtc_register_device(rtc_dd->rtc);
+	if (rc < 0) {
+		dev_err(&pdev->dev, "Register RTC device failed\n");
+		return rc;
+	}
+
+	return pm8xxx_rtc_init_alarm(rtc_dd);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.1

