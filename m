Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F431471534
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhLKSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:00:40 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59039 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231634AbhLKSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:00:39 -0500
Received: from [77.244.183.192] (port=64660 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mw6fl-0009HU-NC; Sat, 11 Dec 2021 19:00:37 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-kernel@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 3/9] rtc: max77686: remove unused code to read in 12-hour mode
Date:   Sat, 11 Dec 2021 18:59:45 +0100
Message-Id: <20211211175951.30763-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211211175951.30763-1-luca@lucaceresoli.net>
References: <20211211175951.30763-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX77714 RTC chip is explicitly set to 24-hour mode in
max77686_rtc_probe() -> max77686_rtc_init_reg() and never changed back to
12-hour mode. Accordingly info->rtc_24hr_mode is set to 1 in the same place
and never modified later, so it is de facto a constant. Yet there is code
to read 12-hour time, which is unreachable.

Remove the unused variable, the unreachable code to manage 12-hour mode and
the defines that become unused due to the above changes.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

---

Changes in v5: none

Changes in v4: none

Changes in v3: none

Changes in v2:
 - remove the now-unused defines too (Alexandre Belloni)
 - improve the commit message
---
 drivers/rtc/rtc-max77686.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7e765207f28e..5c64d08c0732 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -34,9 +34,6 @@
 #define RTC_UDR_MASK			BIT(RTC_UDR_SHIFT)
 #define RTC_RBUDR_SHIFT			4
 #define RTC_RBUDR_MASK			BIT(RTC_RBUDR_SHIFT)
-/* RTC Hour register */
-#define HOUR_PM_SHIFT			6
-#define HOUR_PM_MASK			BIT(HOUR_PM_SHIFT)
 /* RTC Alarm Enable */
 #define ALARM_ENABLE_SHIFT		7
 #define ALARM_ENABLE_MASK		BIT(ALARM_ENABLE_SHIFT)
@@ -99,7 +96,6 @@ struct max77686_rtc_info {
 
 	int rtc_irq;
 	int virq;
-	int rtc_24hr_mode;
 };
 
 enum MAX77686_RTC_OP {
@@ -278,13 +274,7 @@ static void max77686_rtc_data_to_tm(u8 *data, struct rtc_time *tm,
 
 	tm->tm_sec = data[RTC_SEC] & mask;
 	tm->tm_min = data[RTC_MIN] & mask;
-	if (info->rtc_24hr_mode) {
-		tm->tm_hour = data[RTC_HOUR] & 0x1f;
-	} else {
-		tm->tm_hour = data[RTC_HOUR] & 0x0f;
-		if (data[RTC_HOUR] & HOUR_PM_MASK)
-			tm->tm_hour += 12;
-	}
+	tm->tm_hour = data[RTC_HOUR] & 0x1f;
 
 	/* Only a single bit is set in data[], so fls() would be equivalent */
 	tm->tm_wday = ffs(data[RTC_WEEKDAY] & mask) - 1;
@@ -662,8 +652,6 @@ static int max77686_rtc_init_reg(struct max77686_rtc_info *info)
 	data[0] = (1 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
 	data[1] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
 
-	info->rtc_24hr_mode = 1;
-
 	ret = regmap_bulk_write(info->rtc_regmap,
 				info->drv_data->map[REG_RTC_CONTROLM],
 				data, ARRAY_SIZE(data));
-- 
2.25.1

