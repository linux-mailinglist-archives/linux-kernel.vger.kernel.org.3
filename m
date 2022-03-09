Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D84D3638
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbiCIQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbiCIQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:09 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F80CEA08;
        Wed,  9 Mar 2022 08:23:29 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7FCBA2000E;
        Wed,  9 Mar 2022 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxH83HRU2oCPvc3N63YEePHrI/31u162zdeP+Y/mXUU=;
        b=GeH+kNQXrgv7Sl+nvacBpCbP7Fkw48EK1JQ8flH73MOshjP+rKXU6a3lTN7C87I7f07hJ6
        kq9QvjCV1+f9wLh4K39vIBNmKY7u5gsDXkC8G6YMsceSQoS9PrwkWpFJQ1APSS30ky9q0F
        z6roypWUrQvXgfC+s0lNkUWpAHyidbfJvqxBgEWud4rEWRxvvZs9tt67CZVIFn2Ow8bZ3t
        3xNm0MxnBQza+oYmKO1g5tYjwgZ8Fsfe1IcvpabmxxRIURyXHTPXcHe4L2v152s8BHbArb
        gWV72Ja73pps/cYmMdzOmZGidGWwsu++Q6V/E3gS3NPOjPfKElyPyffIZ7McKg==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] rtc: pcf2127: set RTC_FEATURE_ALARM_RES_2S
Date:   Wed,  9 Mar 2022 17:22:42 +0100
Message-Id: <20220309162301.61679-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCF2127 doesn't support UIE because setting an alarm to fire every
second confuses the chip and the fastest we can go is an alarm every 2
seconds.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2127.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index f8469b134411..63b275b014bd 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -656,6 +656,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	pcf2127->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf2127->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	pcf2127->rtc->set_start_time = true; /* Sets actual start to 1970 */
+	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf2127->rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf2127->rtc->features);
 	clear_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 
-- 
2.35.1

