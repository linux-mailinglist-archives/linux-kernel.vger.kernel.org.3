Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B12505E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347496AbiDRSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347492AbiDRSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:53:01 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A5F2F39B;
        Mon, 18 Apr 2022 11:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650307797; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTydCTe/7cAyLlIMweK5uFG1GYH9QzGk2uqsrqg28Oo=;
        b=HEvosaXqUAJaM43ThX9L/5w3WJ5BrXLFRg2EUIjxmL/MdlW+LOPXb1fnpElIc/Dgkc9Xng
        aeTnMj+yhDrIWcGaCC964jixem3O3aRwgx1mr8OTX9vqrAhNRorIHgk/BaM4exFfF3q13i
        23jRa11lv0AXN4W/s74zEnjewY7HOwI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     list@opendingux.net, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] rtc: jz4740: Reset scratchpad register on power loss
Date:   Mon, 18 Apr 2022 19:49:31 +0100
Message-Id: <20220418184933.13172-4-paul@crapouillou.net>
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

On power loss, reading the RTC value would fail as the scratchpad lost
its magic value, until the hardware clock was set once again.

To avoid that, reset the RTC value to Epoch in the probe if we detect
that the scratchpad lost its magic value.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 119baf168b32..aac5f68bf626 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -42,6 +42,9 @@
 /* Magic value to enable writes on jz4780 */
 #define JZ_RTC_WENR_MAGIC	0xA55A
 
+/* Value written to the scratchpad to detect power losses */
+#define JZ_RTC_SCRATCHPAD_MAGIC	0x12345678
+
 #define JZ_RTC_WAKEUP_FILTER_MASK	0x0000FFE0
 #define JZ_RTC_RESET_COUNTER_MASK	0x00000FE0
 
@@ -134,10 +137,11 @@ static int jz4740_rtc_ctrl_set_bits(struct jz4740_rtc *rtc, uint32_t mask,
 static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
 {
 	struct jz4740_rtc *rtc = dev_get_drvdata(dev);
-	uint32_t secs, secs2;
+	uint32_t secs, secs2, magic;
 	int timeout = 5;
 
-	if (jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD) != 0x12345678)
+	magic = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
+	if (magic != JZ_RTC_SCRATCHPAD_MAGIC)
 		return -EINVAL;
 
 	/* If the seconds register is read while it is updated, it can contain a
@@ -169,7 +173,8 @@ static int jz4740_rtc_set_time(struct device *dev, struct rtc_time *time)
 	if (ret)
 		return ret;
 
-	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD, 0x12345678);
+	return jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD,
+				    JZ_RTC_SCRATCHPAD_MAGIC);
 }
 
 static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -307,6 +312,7 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	struct jz4740_rtc *rtc;
 	unsigned long rate;
 	struct clk *clk;
+	uint32_t magic;
 	int ret, irq;
 
 	rtc = devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
@@ -369,6 +375,18 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 	/* Each 1 Hz pulse should happen after (rate) ticks */
 	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_REGULATOR, rate - 1);
 
+	magic = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
+	if (magic != JZ_RTC_SCRATCHPAD_MAGIC) {
+		/*
+		 * If the scratchpad doesn't hold our magic value, then a
+		 * power loss occurred. Reset to Epoch.
+		 */
+		struct rtc_time time;
+
+		rtc_time64_to_tm(0, &time);
+		jz4740_rtc_set_time(dev, &time);
+	}
+
 	ret = devm_rtc_register_device(rtc->rtc);
 	if (ret)
 		return ret;
-- 
2.35.1

