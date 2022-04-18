Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B86505E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbiDRSxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347494AbiDRSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:52:58 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167E2409F;
        Mon, 18 Apr 2022 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650307796; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PoJz1zVmmGsJWV0gMARBBVsLegYd3/w6zzW9TULqzRM=;
        b=tFVojG5TYy5pIwBa9Ykk6LKaEOCGbPlWvBhnBoMlhTy/vyAF6qWDLIBhsrBXjwWfTD+Upf
        pWn5DNE0FfXlVuBORXtxE9X6+UeUiOTi/zbrVS0dDXfpDVLna+sD8wJbR+9lHnF2oDFcKH
        09031E8+v0AlwoDLaq5egDfCeG8Dqqw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     list@opendingux.net, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] rtc: jz4740: Use readl_poll_timeout
Date:   Mon, 18 Apr 2022 19:49:30 +0100
Message-Id: <20220418184933.13172-3-paul@crapouillou.net>
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

Use readl_poll_timeout() from <iopoll.h> instead of using custom poll
loops.

The timeout settings are different, but that shouldn't be much of a
problem. Instead of polling 10000 times in a close loop, it polls for
one millisecond.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/rtc/rtc-jz4740.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 6e51df72fd65..119baf168b32 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -69,19 +70,15 @@ static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
 static int jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
 {
 	uint32_t ctrl;
-	int timeout = 10000;
 
-	do {
-		ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
-	} while (!(ctrl & JZ_RTC_CTRL_WRDY) && --timeout);
-
-	return timeout ? 0 : -EIO;
+	return readl_poll_timeout(rtc->base + JZ_REG_RTC_CTRL, ctrl,
+				  ctrl & JZ_RTC_CTRL_WRDY, 0, 1000);
 }
 
 static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
 {
 	uint32_t ctrl;
-	int ret, timeout = 10000;
+	int ret;
 
 	ret = jz4740_rtc_wait_write_ready(rtc);
 	if (ret != 0)
@@ -89,11 +86,8 @@ static inline int jz4780_rtc_enable_write(struct jz4740_rtc *rtc)
 
 	writel(JZ_RTC_WENR_MAGIC, rtc->base + JZ_REG_RTC_WENR);
 
-	do {
-		ctrl = readl(rtc->base + JZ_REG_RTC_WENR);
-	} while (!(ctrl & JZ_RTC_WENR_WEN) && --timeout);
-
-	return timeout ? 0 : -EIO;
+	return readl_poll_timeout(rtc->base + JZ_REG_RTC_WENR, ctrl,
+				  ctrl & JZ_RTC_WENR_WEN, 0, 1000);
 }
 
 static inline int jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
-- 
2.35.1

