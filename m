Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC15AC2CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIDErc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiIDErW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:47:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1E4DB04;
        Sat,  3 Sep 2022 21:47:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 72so5695759pfx.9;
        Sat, 03 Sep 2022 21:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=SZr3zQkZxgG8eZbdXTELu7ufIS55weDXgR5Sg73Uw/Y=;
        b=emNXLjw5WlueweVlmavsgw0hCJ3Jca9QBY42m9xeVkBTFeqSBiNEBbVIpGduwGn20o
         0S7dgdUZwg9Ud19Q1/yCS2qYFi03tiHFtmuF6GWl0uZjgx4Pi11RELtbIJOrwzX3sRmn
         1b8zW/GuCPPrbIzs/cgm6P5wjOC2+ecWE6csdjbLPvuplhq0BpMy8lUF6JIr99zPc4Xe
         62JyY9xk22l2M6ilnuhElruiK5BDMiQrcwU6HZqiFkumWmn+yX118a7eLRqWgy/Uxa8Q
         LPPbejYfDKPmQlh59pqem39NV2ZAif/QJfJLtt82JdsalKGyc5WsnKTBGSM3XT9c5qYX
         Palg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SZr3zQkZxgG8eZbdXTELu7ufIS55weDXgR5Sg73Uw/Y=;
        b=G70H+hQYjZKUjqnl09QdRyXdts4hdXjmkEDqnHoNWc0+5eqaGF5e20n2JYV0a9JfXF
         T14bYPWXEEjL6tIrQ5ZUf01W41ee+BySivLIL7MbsdOLsFduff3kvlIHSgllKOwJWCIY
         8Zt3rQ3ecCFZJE3TnVKnOqE73eLuTJoNLvnKLVnSyIZFfc/HY+vYeW0Q/edArkh0L+q2
         A3EMcThMGGx2Ds1m0X4kSXzzV996stU6nGHmtQv++gf3w2w9uBKla33Faezx/d3bGWDB
         92z/pvE3QulFj7Ztt3yXmOYLfyvFQR5RNtLObLlb933NLw++N2iQIQ8k5KQgzEkdLkYc
         jOSw==
X-Gm-Message-State: ACgBeo1ReDDXL67LIIGp/9CpVmBpK5u+XXZ5eUujL6Cyfl5VOmrH1dQI
        nU9UZzuFGx4RTHmFa7aOOQE=
X-Google-Smtp-Source: AA6agR5rhkFh3XhArRbUX5ZtdhF5RZME5jnk3sb2oa4xKHo/V+bLPsSzJMM1C86tPIIQlUDAa+RASQ==
X-Received: by 2002:a63:fe12:0:b0:42a:e57:7464 with SMTP id p18-20020a63fe12000000b0042a0e577464mr37217911pgh.552.1662266840478;
        Sat, 03 Sep 2022 21:47:20 -0700 (PDT)
Received: from localhost.localdomain ([115.99.107.255])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm4572617plf.30.2022.09.03.21.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:47:19 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v1 2/2] rtc: maxim: Add Maxim max31329 real time clock.
Date:   Sun,  4 Sep 2022 10:17:08 +0530
Message-Id: <20220904044708.7062-3-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220904044708.7062-1-jagathjog1996@gmail.com>
References: <20220904044708.7062-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add real time clock support for Maxim max31329 real time clock.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 MAINTAINERS                |   7 +
 drivers/rtc/Kconfig        |  10 +
 drivers/rtc/Makefile       |   1 +
 drivers/rtc/rtc-max31329.c | 536 +++++++++++++++++++++++++++++++++++++
 4 files changed, 554 insertions(+)
 create mode 100644 drivers/rtc/rtc-max31329.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7032fcb0fd0f..d92ddab0958d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12478,6 +12478,13 @@ F:	include/linux/mfd/max14577*.h
 F:	include/linux/mfd/max77686*.h
 F:	include/linux/mfd/max77693*.h
 
+MAXIM MAX31329 RTC DRIVER
+M:	Jagath Jog J <jagathjog1996@gmail.com>
+L:	linux-rtc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
+F:	drivers/rtc/max31329.c
+
 MAXIRADIO FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b8de25118ad0..d02cba94e121 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -393,6 +393,16 @@ config RTC_DRV_NCT3018Y
 	   This driver can also be built as a module, if so, the module will be
 	   called "rtc-nct3018y".
 
+config RTC_DRV_MAX31329
+	tristate "Maxim MAX31329"
+	select REGMAP_I2C
+	help
+	   If you say yes here you will get support for the
+	   RTC of Maxim MAX31329.
+
+	   This driver can also be build as a module. If so, the module
+	   will be called rtc-max31329.
+
 config RTC_DRV_RK808
 	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 RTC"
 	depends on MFD_RK808
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index aab22bc63432..741216d2f9ca 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_RTC_DRV_MAX8907)	+= rtc-max8907.o
 obj-$(CONFIG_RTC_DRV_MAX8925)	+= rtc-max8925.o
 obj-$(CONFIG_RTC_DRV_MAX8997)	+= rtc-max8997.o
 obj-$(CONFIG_RTC_DRV_MAX8998)	+= rtc-max8998.o
+obj-$(CONFIG_RTC_DRV_MAX31329)  += rtc-max31329.o
 obj-$(CONFIG_RTC_DRV_MESON_VRTC)+= rtc-meson-vrtc.o
 obj-$(CONFIG_RTC_DRV_MC13XXX)	+= rtc-mc13xxx.o
 obj-$(CONFIG_RTC_DRV_MCP795)	+= rtc-mcp795.o
diff --git a/drivers/rtc/rtc-max31329.c b/drivers/rtc/rtc-max31329.c
new file mode 100644
index 000000000000..7f10912c1c89
--- /dev/null
+++ b/drivers/rtc/rtc-max31329.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RTC driver for the Maxim MAX31329 Real-Time Clock
+ * Copyright (c) 2022 Jagath Jog J
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31329.pdf
+ *
+ */
+
+#include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+/* Register map */
+/* Config registers */
+#define MAX31329_STATUS_REG		0x00
+#define MAX31329_STATUS_A1F		BIT(0)
+#define MAX31329_STATUS_OSF		BIT(6)
+#define MAX31329_INT_EN_REG		0x01
+#define MAX31329_INT_EN_A1IE		BIT(0)
+#define MAX31329_RTC_RESET_REG		0x02
+#define MAX31329_RTC_CONFIG1_REG	0x03
+#define MAX31329_RTC_CONFIG2_REG	0x04
+#define MAX31329_RTC_CONFIG2_ENCLKIN	BIT(2)
+#define MAX31329_RTC_CONFIG2_ENCLKO	BIT(7)
+#define MAX31329_RTC_CFG2_CLKOHZ_MSK	GENMASK(6, 5)
+#define MAX31329_TIMER_CONFIG_REG	0x05
+
+/* Watch registers */
+#define MAX31329_SECONDS_REG		0x06
+#define MAX31329_MINUTES_REG		0x07
+#define MAX31329_HOURS_REG		0x08
+#define MAX31329_HOURS_F24_12		BIT(6)
+#define MAX31329_HOURS_AM_PM		BIT(5)
+#define MAX31329_DAY_REG		0x09
+#define MAX31329_DATE_REG		0x0A
+#define MAX31329_MONTH_REG		0x0B
+#define MAX31329_MONTH_CENTURY		BIT(7)
+#define MAX31329_YEAR_REG		0x0C
+#define MAX31329_WATCH_SEC_LEN		0x07
+#define REG_TO_OFFSET(_REG)		((_REG) - MAX31329_SECONDS_REG)
+
+/* Alarm registers */
+#define MAX31329_ALM1_SEC_REG		0x0D
+#define MAX31329_ALM1_MIN_REG		0x0E
+#define MAX31329_ALM1_HRS_REG		0x0F
+#define MAX31329_ALM1_DAY_DATE_REG	0x10
+#define MAX31329_ALM1_MON_REG		0x11
+#define MAX31329_ALM1_YEAR_REG		0x12
+#define MAX31329_ALM1_SEC_LEN		0x06
+
+#define MAX31329_PWR_MGMT_REG		0x18
+#define MAX31329_TRICKLE_REG		0x19
+#define MAX31329_TRICKLE_EN		BIT(7)
+#define MAX31329_TRICKLE_DIODE_EN	BIT(2)
+#define MAX31329_D_TRICKLE_OHMS	GENMASK(3, 0)
+
+/* Ram registers */
+#define MAX31329_RAM0_START_REG	0x22
+#define MAX31329_RAM0_END_REG		0x61
+
+struct max31329_data {
+	struct device *dev; /* TBD */
+	struct regmap *regmap;
+	struct rtc_device *rtc;
+	int irq;
+#ifdef CONFIG_COMMON_CLK
+	struct clk_hw clkout_hw;
+#endif
+};
+
+/* resistance in kohms */
+static u32 max31329_trickle_ohms[] = {
+	3000,
+	6000,
+	11000
+};
+
+static const struct regmap_config config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX31329_RAM0_END_REG,
+};
+
+static int max31329_get_osc_status(struct device *dev)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &status);
+	if (ret)
+		return ret;
+
+	if (status & MAX31329_STATUS_OSF) {
+		dev_err(dev, "Oscillator has stopped\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int max31329_alarm_irq_enable(struct device *dev, unsigned int enable)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+
+	return regmap_update_bits(max31329->regmap, MAX31329_INT_EN_REG,
+				  MAX31329_INT_EN_A1IE,
+				  enable ? MAX31329_INT_EN_A1IE : 0);
+}
+
+static int max31329_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	struct rtc_time *const tm = &alarm->time;
+	unsigned int aie_en, aie_flag;
+	int ret;
+	u8 regs[6];
+
+	ret = max31329_get_osc_status(dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(max31329->regmap, MAX31329_ALM1_SEC_REG, regs,
+			       MAX31329_ALM1_SEC_LEN);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(max31329->regmap, MAX31329_INT_EN_REG, &aie_en);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &aie_flag);
+	if (ret)
+		return ret;
+
+	tm->tm_sec = bcd2bin(regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] & 0x7f);
+	tm->tm_min = bcd2bin(regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] & 0x7f);
+	tm->tm_hour = bcd2bin(regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] & 0x3f);
+	tm->tm_mday = bcd2bin(regs[REG_TO_OFFSET(MAX31329_DATE_REG) - 1] & 0x3f);
+	tm->tm_mon = bcd2bin(regs[REG_TO_OFFSET(MAX31329_MONTH_REG) - 1] &
+			     0x1f) - 1;
+	tm->tm_year = bcd2bin(regs[REG_TO_OFFSET(MAX31329_YEAR_REG) - 1]) + 200;
+
+	alarm->enabled = FIELD_GET(MAX31329_INT_EN_A1IE, aie_en);
+	alarm->pending = FIELD_GET(MAX31329_STATUS_A1F, aie_flag) &&
+				   alarm->enabled;
+
+	return 0;
+}
+
+static int max31329_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	const struct rtc_time *tm = &alrm->time;
+	u8 regs[6], year;
+	int ret;
+
+	ret = max31329_get_osc_status(dev);
+	if (ret)
+		return ret;
+
+	regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] = bin2bcd(tm->tm_sec) & 0x7F;
+	regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] = bin2bcd(tm->tm_min) & 0x7f;
+	regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] = bin2bcd(tm->tm_hour) & 0x3f;
+	regs[REG_TO_OFFSET(MAX31329_DATE_REG) - 1] = bin2bcd(tm->tm_mday) & 0x3f;
+	regs[REG_TO_OFFSET(MAX31329_MONTH_REG) - 1] = bin2bcd(tm->tm_mon + 1) & 0x1f;
+
+	if (tm->tm_year >= 200)
+		year = bin2bcd(tm->tm_year - 200);
+	else
+		year = bin2bcd(tm->tm_year - 100);
+	regs[REG_TO_OFFSET(MAX31329_YEAR_REG) - 1] = year;
+
+	ret = regmap_bulk_write(max31329->regmap, MAX31329_ALM1_SEC_REG, regs,
+				MAX31329_ALM1_SEC_LEN);
+	if (ret)
+		return ret;
+
+	return max31329_alarm_irq_enable(dev, alrm->enabled);
+}
+
+static int max31329_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	u8 data[7], century = 0;
+	int ret;
+
+	ret = max31329_get_osc_status(dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(max31329->regmap, MAX31329_SECONDS_REG, data,
+			       sizeof(data));
+	if (ret)
+		return ret;
+
+	tm->tm_sec = bcd2bin(data[REG_TO_OFFSET(MAX31329_SECONDS_REG)] & 0x7f);
+	tm->tm_min = bcd2bin(data[REG_TO_OFFSET(MAX31329_MINUTES_REG)] & 0x7f);
+	tm->tm_hour = bcd2bin(data[REG_TO_OFFSET(MAX31329_HOURS_REG)] & 0x3f);
+	/* Day of the week in linux range is 0~6 while 1~7 in RTC chip */
+	tm->tm_wday = bcd2bin(data[REG_TO_OFFSET(MAX31329_DAY_REG)] & 0x07) - 1;
+	tm->tm_mday = bcd2bin(data[REG_TO_OFFSET(MAX31329_DATE_REG)] & 0x3f);
+	/* linux tm_mon range:0~11, while month range is 1~12 in RTC chip */
+	tm->tm_mon = bcd2bin(data[REG_TO_OFFSET(MAX31329_MONTH_REG)] & 0x1f) - 1;
+
+	century = data[REG_TO_OFFSET(MAX31329_MONTH_REG)] & MAX31329_MONTH_CENTURY;
+	tm->tm_year = bcd2bin(data[REG_TO_OFFSET(MAX31329_YEAR_REG)]) +
+			     (century ? 200 : 100);
+
+	return 0;
+}
+
+static int max31329_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	u8 regs[7];
+	int ret;
+
+	ret = max31329_get_osc_status(dev);
+	if (ret)
+		return ret;
+
+	regs[REG_TO_OFFSET(MAX31329_SECONDS_REG)] = bin2bcd(tm->tm_sec);
+	regs[REG_TO_OFFSET(MAX31329_MINUTES_REG)] = bin2bcd(tm->tm_min);
+	regs[REG_TO_OFFSET(MAX31329_HOURS_REG)] = bin2bcd(tm->tm_hour);
+	regs[REG_TO_OFFSET(MAX31329_DAY_REG)] = bin2bcd(tm->tm_wday + 1);
+	regs[REG_TO_OFFSET(MAX31329_DATE_REG)] = bin2bcd(tm->tm_mday);
+	regs[REG_TO_OFFSET(MAX31329_MONTH_REG)] = bin2bcd(tm->tm_mon + 1);
+
+	if (tm->tm_year >= 200)
+		regs[REG_TO_OFFSET(MAX31329_MONTH_REG)] |= MAX31329_MONTH_CENTURY;
+	regs[REG_TO_OFFSET(MAX31329_YEAR_REG)] = bin2bcd(tm->tm_year % 100);
+
+	return regmap_bulk_write(max31329->regmap, MAX31329_SECONDS_REG, regs,
+				 MAX31329_WATCH_SEC_LEN);
+}
+
+static const struct rtc_class_ops max31329_rtc_ops = {
+	.read_time = max31329_read_time,
+	.set_time = max31329_set_time,
+	.read_alarm = max31329_read_alarm,
+	.set_alarm = max31329_set_alarm,
+	.alarm_irq_enable = max31329_alarm_irq_enable,
+};
+
+static irqreturn_t max31329_irq_handler(int irq, void *dev_id)
+{
+	struct device *dev = dev_id;
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	unsigned int flags, controls;
+	unsigned long events;
+	int ret;
+
+	ret = regmap_read(max31329->regmap, MAX31329_INT_EN_REG, &controls);
+	if (ret) {
+		dev_warn(dev, "Read IRQ control register error %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &flags);
+	if (ret) {
+		dev_warn(dev, "Read IRQ flags register error %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (flags & MAX31329_STATUS_A1F) {
+		flags &= ~MAX31329_STATUS_A1F;
+		controls &= ~MAX31329_INT_EN_A1IE;
+		events = RTC_AF | RTC_IRQF;
+	}
+
+	if (events) {
+		rtc_update_irq(max31329->rtc, 1, events);
+		regmap_write(max31329->regmap, MAX31329_STATUS_REG, flags);
+		regmap_write(max31329->regmap, MAX31329_INT_EN_REG, controls);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static void max31329_trickle_config(struct device *dev)
+{
+	struct max31329_data *max31329 = dev_get_drvdata(dev);
+	u8 trickle_reg;
+	int ret, i;
+	u32 ohms;
+
+	/* Configure the trickle charger. */
+	ret = device_property_read_u32(dev, "trickle-resistor-ohms", &ohms);
+	if (ret)
+		return;
+
+	trickle_reg = MAX31329_TRICKLE_EN;
+	for (i = 1; i <= ARRAY_SIZE(max31329_trickle_ohms); i++) {
+		if (max31329_trickle_ohms[i - 1] == ohms) {
+			trickle_reg |= i;
+			regmap_write(max31329->regmap, MAX31329_TRICKLE_REG,
+				     trickle_reg);
+		}
+	}
+}
+
+static int max31329_nvram_write(void *priv, unsigned int offset, void *val,
+				size_t bytes)
+{
+	struct regmap *max31329_regmap = (struct regmap *)priv;
+
+	return regmap_bulk_write(max31329_regmap,
+				 MAX31329_RAM0_START_REG + offset,
+				 val, bytes);
+}
+
+static int max31329_nvram_read(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct regmap *max31329_regmap = (struct regmap *)priv;
+
+	return regmap_bulk_read(max31329_regmap,
+				MAX31329_RAM0_START_REG + offset,
+				val, bytes);
+}
+
+#ifdef CONFIG_COMMON_CLK
+#define clkout_hw_to_max31329(hw) container_of(hw, struct max31329_data, clkout_hw)
+
+static int clkout_rates[] = {
+	1,
+	4096,
+	8192,
+	32768
+};
+
+static unsigned long max31329_clkout_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
+	int clkout, ret;
+
+	ret = regmap_read(max31329->regmap, MAX31329_RTC_CONFIG2_REG, &clkout);
+	if (ret)
+		return 0;
+
+	return clkout_rates[FIELD_GET(MAX31329_RTC_CFG2_CLKOHZ_MSK, clkout)];
+}
+
+static long max31329_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
+		if (clkout_rates[i] >= rate)
+			return clkout_rates[i];
+
+	return 0;
+}
+
+static int max31329_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
+		if (rate == clkout_rates[i])
+			return regmap_update_bits(max31329->regmap,
+						  MAX31329_RTC_CONFIG2_REG,
+						  MAX31329_RTC_CFG2_CLKOHZ_MSK,
+						  FIELD_PREP(MAX31329_RTC_CFG2_CLKOHZ_MSK,
+							     i));
+	return -EINVAL;
+}
+
+static int max31329_clkout_prepare(struct clk_hw *hw)
+{
+	struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
+
+	return regmap_update_bits(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
+				  MAX31329_RTC_CONFIG2_ENCLKO,
+				  MAX31329_RTC_CONFIG2_ENCLKO);
+}
+
+static void max31329_clkout_unprepare(struct clk_hw *hw)
+{
+	struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
+
+	regmap_update_bits(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
+			   MAX31329_RTC_CONFIG2_ENCLKO,
+			   FIELD_PREP(MAX31329_RTC_CONFIG2_ENCLKO, 0));
+}
+
+static int max31329_clkout_is_prepared(struct clk_hw *hw)
+{
+	struct max31329_data *max31329 = clkout_hw_to_max31329(hw);
+	int clkout, ret;
+
+	ret = regmap_read(max31329->regmap, MAX31329_RTC_CONFIG2_REG, &clkout);
+	if (ret)
+		return ret;
+
+	return !!(clkout & MAX31329_RTC_CONFIG2_ENCLKO);
+}
+
+static const struct clk_ops max31329_clkout_ops = {
+	.prepare = max31329_clkout_prepare,
+	.unprepare = max31329_clkout_unprepare,
+	.is_prepared = max31329_clkout_is_prepared,
+	.recalc_rate = max31329_clkout_recalc_rate,
+	.round_rate = max31329_clkout_round_rate,
+	.set_rate = max31329_clkout_set_rate,
+};
+
+static int max31329_clkout_register_clk(struct max31329_data *max31329,
+					struct i2c_client *client)
+{
+	struct device_node *node = client->dev.of_node;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	init.name = "max31329-clkout";
+	init.ops = &max31329_clkout_ops;
+	init.flags = 0;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	max31329->clkout_hw.init = &init;
+
+	/* optional override of the clockname */
+	of_property_read_string(node, "clock-output-names", &init.name);
+
+	clk = devm_clk_register(&client->dev, &max31329->clkout_hw);
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	return PTR_ERR(clk);
+}
+#endif
+
+static int max31329_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct max31329_data *max31329;
+	int ret;
+	struct nvmem_config nvmem_cfg = {
+		.name = "max31329_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = 64,
+		.type = NVMEM_TYPE_BATTERY_BACKED,
+		.reg_read = max31329_nvram_read,
+		.reg_write = max31329_nvram_write,
+	};
+
+	max31329 = devm_kzalloc(&client->dev, sizeof(*max31329), GFP_KERNEL);
+	if (!max31329)
+		return -ENOMEM;
+
+	max31329->regmap = devm_regmap_init_i2c(client, &config);
+	if (IS_ERR(max31329->regmap)) {
+		dev_err(&client->dev, "regmap init failed\n");
+		return PTR_ERR(max31329->regmap);
+	}
+
+	dev_set_drvdata(&client->dev, max31329);
+
+	max31329->rtc = devm_rtc_allocate_device(&client->dev);
+	if (IS_ERR(max31329->rtc))
+		return PTR_ERR(max31329->rtc);
+
+	max31329->rtc->ops = &max31329_rtc_ops;
+	max31329->irq = client->irq;
+	max31329->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	max31329->rtc->range_max = RTC_TIMESTAMP_END_2199;
+	max31329->dev = &client->dev;
+
+	if (max31329->irq) {
+		ret = devm_request_threaded_irq(&client->dev, max31329->irq,
+						NULL, max31329_irq_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"max31329", &client->dev);
+		if (ret) {
+			dev_err(&client->dev, "unable to request IRQ\n");
+			max31329->irq = 0;
+			return ret;
+		}
+
+		ret = regmap_write(max31329->regmap, MAX31329_RTC_CONFIG2_REG,
+				   MAX31329_RTC_CONFIG2_ENCLKO);
+		if (ret) {
+			dev_err(&client->dev, "unable to configure INT pin");
+			max31329->irq = 0;
+			return ret;
+		}
+
+		device_set_wakeup_capable(&client->dev, true);
+		set_bit(RTC_FEATURE_ALARM, max31329->rtc->features);
+	}
+
+	ret = devm_rtc_register_device(max31329->rtc);
+	if (ret)
+		return ret;
+
+	max31329_trickle_config(&client->dev);
+
+	nvmem_cfg.priv = max31329->regmap;
+	devm_rtc_nvmem_register(max31329->rtc, &nvmem_cfg);
+
+#ifdef CONFIG_COMMON_CLK
+	max31329_clkout_register_clk(max31329, client);
+#endif
+
+	return 0;
+}
+
+static const struct of_device_id max31329_of_match[] = {
+	{ .compatible = "maxim,max31329", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max31329_of_match);
+
+static struct i2c_driver max31329_driver = {
+	.driver = {
+		.name = "rtc-max31329",
+		.of_match_table = of_match_ptr(max31329_of_match),
+	},
+	.probe = max31329_probe,
+};
+module_i2c_driver(max31329_driver);
+
+MODULE_AUTHOR("Jagath Jog J <jagathjog1996@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX31329 RTC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

