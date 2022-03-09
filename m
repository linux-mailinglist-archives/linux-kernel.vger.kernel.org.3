Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2321C4D365E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiCIQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiCIQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:24 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26273E2363;
        Wed,  9 Mar 2022 08:23:41 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A393D240019;
        Wed,  9 Mar 2022 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUotff3zpT1sC8hzBqBp8VQHTf/m2FqGZrZW1U0mj9k=;
        b=G+ngI32dI1uVwTxIzHcDRECjcX8vfjipgxtV+AwdgRfVJ+CO125DPI2Wya4w3MWeOMtx4+
        nFgj8LyQRKD+oWDXKXPziTot9BtHnTg83+fZd3bfDxYGOsXANk5mX9gBr51VaPtSFjkwPw
        gWUlAVJv7ts01jh+StzHudPcKSVH6HnjuydXDriHJDPSK8ypJt5zB5M0GbNwrh+pIKVsWd
        28WRSquVGrlZsvwhlKVQ9lVipt2rvGd5m8he2TPOAOkQh+vg+NlG2yPgTK13+4t6xgwZlM
        c2uaT5yzE4f4rVdQMJ/sIENhjdHuNDV0gst7dDbP1xSnk0/KI1TQIPwY+R6cfQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/29] rtc: pcf8563: let the core handle the alarm resolution
Date:   Wed,  9 Mar 2022 17:22:47 +0100
Message-Id: <20220309162301.61679-16-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set RTC_FEATURE_ALARM_RES_MINUTE, so the core knows alarms have a
resolution of a minute. Also, the core will properly round down the alarm
instead of up.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8563.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index c8bddfb94129..530f06c810fa 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -330,19 +330,6 @@ static int pcf8563_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *tm)
 	unsigned char buf[4];
 	int err;
 
-	/* The alarm has no seconds, round up to nearest minute */
-	if (tm->time.tm_sec) {
-		time64_t alarm_time = rtc_tm_to_time64(&tm->time);
-
-		alarm_time += 60 - tm->time.tm_sec;
-		rtc_time64_to_tm(alarm_time, &tm->time);
-	}
-
-	dev_dbg(dev, "%s, min=%d hour=%d wday=%d mday=%d "
-		"enabled=%d pending=%d\n", __func__,
-		tm->time.tm_min, tm->time.tm_hour, tm->time.tm_wday,
-		tm->time.tm_mday, tm->enabled, tm->pending);
-
 	buf[0] = bin2bcd(tm->time.tm_min);
 	buf[1] = bin2bcd(tm->time.tm_hour);
 	buf[2] = bin2bcd(tm->time.tm_mday);
@@ -566,6 +553,7 @@ static int pcf8563_probe(struct i2c_client *client,
 	pcf8563->rtc->ops = &pcf8563_rtc_ops;
 	/* the pcf8563 alarm only supports a minute accuracy */
 	pcf8563->rtc->uie_unsupported = 1;
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, pcf8563->rtc->features);
 	pcf8563->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf8563->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	pcf8563->rtc->set_start_time = true;
-- 
2.35.1

