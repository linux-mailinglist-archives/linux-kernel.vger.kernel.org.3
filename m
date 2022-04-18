Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0982B505E21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346842AbiDRSy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347541AbiDRSxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:53:21 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6502409F;
        Mon, 18 Apr 2022 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650307798; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/CT07nqqL/kRUfaHG3whhK5ysTGqgD0sA53BitiVSo=;
        b=P/2SAq3V8XLIIw3N33ms4X7AHzfiKEDhTzzLbmZEhHIdJ5TuaQtBKB5nHUqwJ4DzEbNcuJ
        HPKn1kEAJ7i0umFwILtCLvi7LEi1dQfpguqWX680yq5mBPy11xljkr8+zlonLjRze+5l42
        mPQIc9Sh3Q5jiz7f4MM+HBUI9MHgWUU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     list@opendingux.net, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] rtc: jz4740: Support for fine-tuning the RTC clock
Date:   Mon, 18 Apr 2022 19:49:33 +0100
Message-Id: <20220418184933.13172-6-paul@crapouillou.net>
In-Reply-To: <20220418184933.13172-1-paul@crapouillou.net>
References: <20220418184933.13172-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write the NC1HZ and ADJC register fields, which allow to tweak the
frequency of the RTC clock, so that it can run as accurately as
possible.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index f4c9b6058f07..f275e58a9cea 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -5,6 +5,7 @@
  *	 JZ4740 SoC RTC driver
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
@@ -41,6 +42,9 @@
 #define JZ_RTC_CTRL_AE		BIT(2)
 #define JZ_RTC_CTRL_ENABLE	BIT(0)
 
+#define JZ_RTC_REGULATOR_NC1HZ_MASK	GENMASK(15, 0)
+#define JZ_RTC_REGULATOR_ADJC_MASK	GENMASK(25, 16)
+
 /* Magic value to enable writes on jz4780 */
 #define JZ_RTC_WENR_MAGIC	0xA55A
 
@@ -64,6 +68,7 @@ struct jz4740_rtc {
 	enum jz4740_rtc_type type;
 
 	struct rtc_device *rtc;
+	struct clk *clk;
 
 	struct clk_hw clk32k;
 
@@ -222,12 +227,51 @@ static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	return jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AF_IRQ, enable);
 }
 
+static int jz4740_rtc_read_offset(struct device *dev, long *offset)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	long rate = clk_get_rate(rtc->clk);
+	s32 nc1hz, adjc, offset1k;
+	u32 reg;
+
+	reg = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_REGULATOR);
+	nc1hz = FIELD_GET(JZ_RTC_REGULATOR_NC1HZ_MASK, reg);
+	adjc = FIELD_GET(JZ_RTC_REGULATOR_ADJC_MASK, reg);
+
+	offset1k = (nc1hz - rate + 1) * 1024L + adjc;
+	*offset = offset1k * 1000000L / (rate * 1024L);
+
+	return 0;
+}
+
+static int jz4740_rtc_set_offset(struct device *dev, long offset)
+{
+	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
+	long rate = clk_get_rate(rtc->clk);
+	s32 offset1k, adjc, nc1hz;
+
+	offset1k = div_s64_rem(offset * rate * 1024LL, 1000000LL, &adjc);
+	nc1hz = rate - 1 + offset1k / 1024L;
+
+	if (adjc < 0) {
+		nc1hz--;
+		adjc += 1024;
+	}
+
+	nc1hz = FIELD_PREP(JZ_RTC_REGULATOR_NC1HZ_MASK, nc1hz);
+	adjc = FIELD_PREP(JZ_RTC_REGULATOR_ADJC_MASK, adjc);
+
+	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_REGULATOR, nc1hz | adjc);
+}
+
 static const struct rtc_class_ops jz4740_rtc_ops = {
 	.read_time	= jz4740_rtc_read_time,
 	.set_time	= jz4740_rtc_set_time,
 	.read_alarm	= jz4740_rtc_read_alarm,
 	.set_alarm	= jz4740_rtc_set_alarm,
 	.alarm_irq_enable = jz4740_rtc_alarm_irq_enable,
+	.read_offset	= jz4740_rtc_read_offset,
+	.set_offset	= jz4740_rtc_set_offset,
 };
 
 static irqreturn_t jz4740_rtc_irq(int irq, void *data)
@@ -378,6 +422,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&rtc->lock);
 
+	rtc->clk = clk;
 	platform_set_drvdata(pdev, rtc);
 
 	device_init_wakeup(dev, 1);
-- 
2.35.1

