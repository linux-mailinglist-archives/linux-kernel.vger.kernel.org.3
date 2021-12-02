Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5630E46665F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358928AbhLBP0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:26:21 -0500
Received: from smtp2.axis.com ([195.60.68.18]:29449 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358921AbhLBP0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638458578;
  x=1669994578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SCt8C0q+oYi8J/SOt7dYSP4jqOMkKUjKj7Bq9mvE+d0=;
  b=erK1YpgXoCaUAkoY6ejnq7tMKDR3yM4BaiDc7WQbon02r2++JRcMNOoa
   uKwn9mWN826XYX9uc9jC3pLjrrg4howHukq7EUVO88aZBM5tUqv92bduO
   H0y17PsqNPELisd/vBeCLkT53TeQKPM/oaAkwA63ntJFHh0hnID37rjKV
   MRAZtmVf/IgjIRTWTPkrgKCThzEovEg3OYLeVQvIcGO4PTJG3GoWRB58b
   BZ4iPfhpbE9Hiyq2dyxa8UbR5XPySWRwvpX5mexPEPhrbySlXCPe4nldm
   KjmzlUVHFc3zWnM22/iYnpbaCbubRVhrg2iVim5wWaULnlszqWHde/zns
   Q==;
From:   Camel Guo <camel.guo@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] rtc: rs5c372: add offset correction support
Date:   Thu, 2 Dec 2021 16:22:52 +0100
Message-ID: <20211202152252.31264-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

In order for linux userspace application to be able to adjust offset to
keep rtc precision as high as possible, this commit adds support of
offset correction by adjusting the time trimming register on
rs5c372[a|b] and oscilluation adjustment register on r2025x, r222[1|3]x,
rv5c38[6|7]a.

Signed-off-by: Camel Guo <camelg@axis.com>
---

Notes:
    v2: cover all supported rtc chips in rtc-rs5c372.c

 drivers/rtc/rtc-rs5c372.c | 120 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 955513514179..b3155fa914f1 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -30,6 +30,8 @@
 #define RS5C372_REG_TRIM	7
 #	define RS5C372_TRIM_XSL		0x80
 #	define RS5C372_TRIM_MASK	0x7F
+#	define R2221TL_TRIM_DEV		(1 << 7)	/* only if R2221TL */
+#	define RS5C372_TRIM_DECR	(1 << 6)
 
 #define RS5C_REG_ALARM_A_MIN	8			/* or ALARM_W */
 #define RS5C_REG_ALARM_A_HOURS	9
@@ -539,6 +541,122 @@ static int rs5c372_ioctl(struct device *dev, unsigned int cmd, unsigned long arg
 #define rs5c372_ioctl	NULL
 #endif
 
+static int rs5c372_read_offset(struct device *dev, long *offset)
+{
+	struct rs5c372 *rs5c = i2c_get_clientdata(to_i2c_client(dev));
+	u8 val = rs5c->regs[RS5C372_REG_TRIM];
+	long ppb_per_step = 0;
+	bool decr = val & RS5C372_TRIM_DECR;
+
+	switch (rs5c->type) {
+	case rtc_r2221tl:
+		ppb_per_step = val & R2221TL_TRIM_DEV ? 1017 : 3051;
+		break;
+	case rtc_rs5c372a:
+	case rtc_rs5c372b:
+		ppb_per_step = val & RS5C372_TRIM_XSL ? 3125 : 3051;
+		break;
+	default:
+		ppb_per_step = 3051;
+		break;
+	}
+
+	/* Only bits[0:5] repsents the time counts */
+	val &= 0x3F;
+
+	/* If bits[1:5] are all 0, it means no increment or decrement */
+	if (!(val & 0x3E)) {
+		*offset = 0;
+	} else {
+		if (decr)
+			*offset = -(((~val) & 0x3F) + 1) * ppb_per_step;
+		else
+			*offset = (val - 1) * ppb_per_step;
+	}
+
+	return 0;
+}
+
+static int rs5c372_set_offset(struct device *dev, long offset)
+{
+	struct rs5c372 *rs5c = i2c_get_clientdata(to_i2c_client(dev));
+	int addr = RS5C_ADDR(RS5C372_REG_TRIM);
+	u8 val = 0;
+	u8 tmp = 0;
+	long ppb_per_step = 3051;
+	long steps = LONG_MIN;
+
+	switch (rs5c->type) {
+	case rtc_rs5c372a:
+	case rtc_rs5c372b:
+		tmp = rs5c->regs[RS5C372_REG_TRIM];
+		if (tmp & RS5C372_TRIM_XSL) {
+			ppb_per_step = 3125;
+			val |= RS5C372_TRIM_XSL;
+		}
+		break;
+	case rtc_r2221tl:
+		/*
+		 * Check if it is possible to use high resolution mode (DEV=1).
+		 * In this mode, the minimum resolution is 2 / (32768 * 20 * 3),
+		 * which is about 1017 ppb.
+		 */
+		steps = DIV_ROUND_CLOSEST(offset, 1017);
+		if (steps >= -0x3E && steps <= 0x3E) {
+			ppb_per_step = 1017;
+			val |= R2221TL_TRIM_DEV;
+		} else {
+			/*
+			 * offset is out of the range of high resolution mode.
+			 * Try to use low resolution mode (DEV=0). In this mode,
+			 * the minimum resolution is 2 / (32768 * 20), which is
+			 * about 3051 ppb.
+			 */
+			steps = LONG_MIN;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (steps == LONG_MIN) {
+		steps = DIV_ROUND_CLOSEST(offset, ppb_per_step);
+		if (steps > 0x3E || steps < -0x3E)
+			return -ERANGE;
+	}
+
+	if (steps > 0) {
+		val |= steps + 1;
+	} else {
+		val |= RS5C372_TRIM_DECR;
+		val |= (~(-steps - 1)) & 0x3F;
+	}
+
+	if (!steps || !(val & 0x3E)) {
+		/*
+		 * if offset is too small, set oscillation adjustment register
+		 * or time trimming register with its default value whic means
+		 * no increment or decrement. But for rs5c372[a|b], the XSL bit
+		 * should be kept unchanged.
+		 */
+		if (rs5c->type == rtc_rs5c372a || rs5c->type == rtc_rs5c372b)
+			val &= RS5C372_TRIM_XSL;
+		else
+			val = 0;
+	}
+
+	dev_dbg(&rs5c->client->dev, "write 0x%x for offset %ld\n", val, offset);
+
+	if (i2c_smbus_write_byte_data(rs5c->client, addr, val) < 0) {
+		dev_err(&rs5c->client->dev, "failed to write 0x%x to reg %d\n", val, addr);
+		return -EIO;
+	}
+
+	rs5c->regs[RS5C372_REG_TRIM] = val;
+
+	return 0;
+}
+
 static const struct rtc_class_ops rs5c372_rtc_ops = {
 	.proc		= rs5c372_rtc_proc,
 	.read_time	= rs5c372_rtc_read_time,
@@ -547,6 +665,8 @@ static const struct rtc_class_ops rs5c372_rtc_ops = {
 	.set_alarm	= rs5c_set_alarm,
 	.alarm_irq_enable = rs5c_rtc_alarm_irq_enable,
 	.ioctl		= rs5c372_ioctl,
+	.read_offset    = rs5c372_read_offset,
+	.set_offset     = rs5c372_set_offset,
 };
 
 #if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
-- 
2.20.1

