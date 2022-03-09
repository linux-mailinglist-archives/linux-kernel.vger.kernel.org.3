Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4564D37D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiCIQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiCIQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:04 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A2B0EAF;
        Wed,  9 Mar 2022 08:23:19 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C349240018;
        Wed,  9 Mar 2022 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646842997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOlnjRHH1Pg0SxcAT/bRjwNg7mPNtt7xa8173YuzdBo=;
        b=eVchWAd/VoUMSm31LMHNxSpEy/d9UeDv2CRwtceSCxBocAI3kUmaua1HekR1zcpUOALaW/
        jt+uVpd8oNRb/8oyzQnZiyt/y4HaNAAJEvafm8m2wUmyw6Djig7xSm5u9QXR5jsuBmWwOF
        4I4qSZ8SggfC4CUVzFoEfDlvxeKF5sfMV2JhpmcODs0n0w9+c+B7JmIph3dcOOIfVdxwlB
        VlHQkdHpYRmUDjcg0AIbY5ee7hzTX+b0JAPBTNuQolxLmO0TPRlPlgXal/avikActk0EnI
        Dpi5u+2bIN9UInFJE0ssGl+m6Ko6yIlEOQRaibxDPrAdeQNGWZSMWd3TAf9a3g==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/29] rtc: mpc5121: let the core handle the alarm resolution
Date:   Wed,  9 Mar 2022 17:22:35 +0100
Message-Id: <20220309162301.61679-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/rtc/rtc-mpc5121.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index bb2ea9bc56f2..6bd9779da3c6 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -210,20 +210,6 @@ static int mpc5121_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	struct mpc5121_rtc_data *rtc = dev_get_drvdata(dev);
 	struct mpc5121_rtc_regs __iomem *regs = rtc->regs;
 
-	/*
-	 * the alarm has no seconds so deal with it
-	 */
-	if (alarm->time.tm_sec) {
-		alarm->time.tm_sec = 0;
-		alarm->time.tm_min++;
-		if (alarm->time.tm_min >= 60) {
-			alarm->time.tm_min = 0;
-			alarm->time.tm_hour++;
-			if (alarm->time.tm_hour >= 24)
-				alarm->time.tm_hour = 0;
-		}
-	}
-
 	alarm->time.tm_mday = -1;
 	alarm->time.tm_mon = -1;
 	alarm->time.tm_year = -1;
@@ -349,6 +335,7 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 	}
 
 	rtc->rtc->ops = &mpc5200_rtc_ops;
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtc->features);
 	rtc->rtc->uie_unsupported = 1;
 	rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
 	rtc->rtc->range_max = 65733206399ULL; /* 4052-12-31 23:59:59 */
-- 
2.35.1

