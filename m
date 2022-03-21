Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9634E22E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbiCUJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiCUJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:06:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EBF32995;
        Mon, 21 Mar 2022 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647853534; x=1679389534;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=SWm2rZMQQWr7/N6IuT3e00JWHrd5mZhind7/8gMs0ck=;
  b=goBg0urROb8Rxiw+X17RhYoC/q+3EUAXVz+FAd1EoKwBGmgQN80fv0zU
   T45kE9BOwuiWXxjXh2IrCoJqyzIrITb9KxB0sZsVfUeyiev7E1O3e03g5
   rXPtxNW/9RZlZsf+FjdbPIfSr9eXRmUE32G4pgJvQ+UjlOTzGqAkJV+Xj
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 02:05:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 02:05:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 02:05:33 -0700
Received: from jianbinz-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 02:05:30 -0700
From:   jianbinz <quic_jianbinz@quicinc.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>
CC:     jianbinz <quic_jianbinz@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_fenglinw@quicinc.com>
Subject: [PATCH] rtc: rtc-pm8xxx: Retrigger RTC alarm if it's fired before the driver probed
Date:   Mon, 21 Mar 2022 17:05:14 +0800
Message-ID: <20220321090514.4523-1-quic_jianbinz@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/rtc/rtc-pm8xxx.c | 148 ++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 35 deletions(-)
 mode change 100644 => 100755 drivers/rtc/rtc-pm8xxx.c

diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
old mode 100644
new mode 100755
index 29a1c65661e9..f213702a513c
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -64,6 +64,62 @@ struct pm8xxx_rtc {
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
@@ -175,40 +231,15 @@ static int pm8xxx_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
-		return rc;
-	}
-
-	/*
-	 * Read the LSB again and check if there has been a carry over.
-	 * If there is, redo the read operation.
-	 */
-	rc = regmap_read(rtc_dd->regmap, regs->read, &reg);
-	if (rc < 0) {
-		dev_err(dev, "RTC read data register failed\n");
+		dev_err(dev, "RTC read time failed\n");
 		return rc;
 	}
 
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
@@ -267,21 +298,16 @@ static int pm8xxx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
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
@@ -394,6 +420,52 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
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
@@ -527,7 +599,13 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
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

