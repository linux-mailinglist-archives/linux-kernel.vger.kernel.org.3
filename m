Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF05A4C98
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiH2M4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiH2M4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:13 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992258E0FC;
        Mon, 29 Aug 2022 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661777227;
  x=1693313227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ameRcfksl/UtQ/tKeS4HaC8JfLhSGibsBb/mNnlw9sc=;
  b=pew8cYchBGfiLavTobxtNBZfYjuo9lsFm/MFELnycNJ+Q8T3vFrtz5FA
   v6xyQgitpcQMA0Dif4wHOQU4+PofB90wrqIwvhMCGGeVqU09pvMe612vd
   g3c8NpigFENWRagurUqbepMC9zWPCCscw9tEy7Vb+HDj6fdivVqDqPCej
   aW67jcbs/0+MMNjWV4ITX65oHKlxmzV8d2gctZx2mGNEQe+Ywy0SFmEdK
   yU3xyXYtX3U94KxA4w5pfCPAOuddCODqZif3RGJTPvVysvJ/JIZmwrWZ6
   xqPu7IAszGauLNUqaauLChz40hz/mNHxmBmRopiRqWV9wkVBObY2fCbGj
   w==;
From:   paulmn <paulmn@axis.com>
To:     <alexandre.belloni@bootlin.com>
CC:     paulmn <paulmn@axis.com>, Alessandro Zummo <a.zummo@towertech.it>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: pcf8523: fix for stop bit
Date:   Mon, 29 Aug 2022 14:46:39 +0200
Message-ID: <20220829124639.10906-1-paulmn@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail03w.axis.com (10.20.40.9) To se-mail02w.axis.com
 (10.20.40.8)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bugfix for an issue detected when a goldcap capacitor gets
fully discharged due to a long absence of the power supply,
and then recharges again. The RTC failed to continue to keep
the real-time clock.

This was caused by the incorrect handling of the STOP bit in
the RTC internal register.  This fix solves the problem.

Signed-off-by: paulmn <paulmn@axis.com>
---
 drivers/rtc/rtc-pcf8523.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 6174b3fd4b98..92de99f11a7a 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -99,24 +99,24 @@ static irqreturn_t pcf8523_irq(int irq, void *dev_id)
 static int pcf8523_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf8523 *pcf8523 = dev_get_drvdata(dev);
-	u8 regs[7];
+	u8 regs[10];
 	int err;
 
-	err = regmap_bulk_read(pcf8523->regmap, PCF8523_REG_SECONDS, regs,
+	err = regmap_bulk_read(pcf8523->regmap, PCF8523_REG_CONTROL1, regs,
 			       sizeof(regs));
 	if (err < 0)
 		return err;
 
-	if (regs[0] & PCF8523_SECONDS_OS)
+	if ((regs[0] & PCF8523_CONTROL1_STOP) || (regs[3] & PCF8523_SECONDS_OS))
 		return -EINVAL;
 
-	tm->tm_sec = bcd2bin(regs[0] & 0x7f);
-	tm->tm_min = bcd2bin(regs[1] & 0x7f);
-	tm->tm_hour = bcd2bin(regs[2] & 0x3f);
-	tm->tm_mday = bcd2bin(regs[3] & 0x3f);
-	tm->tm_wday = regs[4] & 0x7;
-	tm->tm_mon = bcd2bin(regs[5] & 0x1f) - 1;
-	tm->tm_year = bcd2bin(regs[6]) + 100;
+	tm->tm_sec = bcd2bin(regs[3] & 0x7f);
+	tm->tm_min = bcd2bin(regs[4] & 0x7f);
+	tm->tm_hour = bcd2bin(regs[5] & 0x3f);
+	tm->tm_mday = bcd2bin(regs[6] & 0x3f);
+	tm->tm_wday = regs[7] & 0x7;
+	tm->tm_mon = bcd2bin(regs[8] & 0x1f) - 1;
+	tm->tm_year = bcd2bin(regs[9]) + 100;
 
 	return 0;
 }
-- 
2.30.2

