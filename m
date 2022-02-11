Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252824B259E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbiBKM1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:27:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349995AbiBKM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:27:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64AAFF65;
        Fri, 11 Feb 2022 04:26:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33B1711D4;
        Fri, 11 Feb 2022 04:26:59 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C5C93F70D;
        Fri, 11 Feb 2022 04:26:57 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: [PATCH v10 05/18] rtc: sun6i: Add support for broken-down alarm registers
Date:   Fri, 11 Feb 2022 12:26:30 +0000
Message-Id: <20220211122643.1343315-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211122643.1343315-1-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of the Allwinner RTC, for instance as found in the H616
SoC, not only store the current day as a linear number, but also change
the way the alarm is handled: There are now two registers, that
explicitly store the wakeup time, in the same format as the current
time.

Add support for that variant by writing the requested wakeup time
directly into the registers, instead of programming the seconds left, as
the old SoCs required.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/rtc/rtc-sun6i.c | 57 +++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 996d05938839..799d98ee6df6 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -49,7 +49,8 @@
 
 /* Alarm 0 (counter) */
 #define SUN6I_ALRM_COUNTER			0x0020
-#define SUN6I_ALRM_CUR_VAL			0x0024
+/* This holds the remaining alarm seconds on older SoCs (current value) */
+#define SUN6I_ALRM_COUNTER_HMS			0x0024
 #define SUN6I_ALRM_EN				0x0028
 #define SUN6I_ALRM_EN_CNT_EN			BIT(0)
 #define SUN6I_ALRM_IRQ_EN			0x002c
@@ -524,32 +525,54 @@ static int sun6i_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 	struct sun6i_rtc_dev *chip = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &wkalrm->time;
 	struct rtc_time tm_now;
-	time64_t time_now, time_set;
+	time64_t time_set;
+	u32 counter_val, counter_val_hms;
 	int ret;
 
-	ret = sun6i_rtc_gettime(dev, &tm_now);
-	if (ret < 0) {
-		dev_err(dev, "Error in getting time\n");
-		return -EINVAL;
-	}
-
 	time_set = rtc_tm_to_time64(alrm_tm);
-	time_now = rtc_tm_to_time64(&tm_now);
-	if (time_set <= time_now) {
-		dev_err(dev, "Date to set in the past\n");
-		return -EINVAL;
-	}
 
-	if ((time_set - time_now) > U32_MAX) {
-		dev_err(dev, "Date too far in the future\n");
-		return -EINVAL;
+	if (chip->flags & RTC_LINEAR_DAY) {
+		/*
+		 * The alarm registers hold the actual alarm time, encoded
+		 * in the same way (linear day + HMS) as the current time.
+		 */
+		counter_val_hms = SUN6I_TIME_SET_SEC_VALUE(alrm_tm->tm_sec)  |
+				  SUN6I_TIME_SET_MIN_VALUE(alrm_tm->tm_min)  |
+				  SUN6I_TIME_SET_HOUR_VALUE(alrm_tm->tm_hour);
+		/* The division will cut off the H:M:S part of alrm_tm. */
+		counter_val = div_u64(rtc_tm_to_time64(alrm_tm), SECS_PER_DAY);
+	} else {
+		/* The alarm register holds the number of seconds left. */
+		time64_t time_now;
+
+		ret = sun6i_rtc_gettime(dev, &tm_now);
+		if (ret < 0) {
+			dev_err(dev, "Error in getting time\n");
+			return -EINVAL;
+		}
+
+		time_now = rtc_tm_to_time64(&tm_now);
+		if (time_set <= time_now) {
+			dev_err(dev, "Date to set in the past\n");
+			return -EINVAL;
+		}
+		if ((time_set - time_now) > U32_MAX) {
+			dev_err(dev, "Date too far in the future\n");
+			return -EINVAL;
+		}
+
+		counter_val = time_set - time_now;
 	}
 
 	sun6i_rtc_setaie(0, chip);
 	writel(0, chip->base + SUN6I_ALRM_COUNTER);
+	if (chip->flags & RTC_LINEAR_DAY)
+		writel(0, chip->base + SUN6I_ALRM_COUNTER_HMS);
 	usleep_range(100, 300);
 
-	writel(time_set - time_now, chip->base + SUN6I_ALRM_COUNTER);
+	writel(counter_val, chip->base + SUN6I_ALRM_COUNTER);
+	if (chip->flags & RTC_LINEAR_DAY)
+		writel(counter_val_hms, chip->base + SUN6I_ALRM_COUNTER_HMS);
 	chip->alarm = time_set;
 
 	sun6i_rtc_setaie(wkalrm->enabled, chip);
-- 
2.25.1

