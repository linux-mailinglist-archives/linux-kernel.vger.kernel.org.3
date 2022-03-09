Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415A34D3731
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiCIQhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiCIQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F59DCE0A;
        Wed,  9 Mar 2022 08:23:36 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1638AE0003;
        Wed,  9 Mar 2022 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSmk4sUYJJ0tW7JycQ6lW6OYgIsK9QVxC2+po6YZlJY=;
        b=FfQS0qjf7yzl8hGEISX3HfTD2r9xr7ms9Uc6G5EKlNmPyFA0EF/qdInSaW5E990N7XLbWl
        x2IRKEoEjCyZZ+2pO4u8dIaovbDK0+hPZYrZALz1jHJQWvvxkhED3nsqQrCp+v5BsjP2cH
        TlbhekPHh8mfcO7Xb4jv2xz/ooQUB0/6DsziSpNCLcwVyuT0sJRQigGBPw5nfoMk9MGV/L
        j+HBT2+jBSffJkxIYQ0y++YAPhbw0ZWNrzngz8VitAATIFsn+kgIqsiw/gYtW9mJkc0Tvi
        0KnyM2BRr7KD4KGEZKJSCFxFyazjVpQKEIDrqih7bx85sHa1rIs1gM9LWGmvnw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/29] rtc: spear: set range
Date:   Wed,  9 Mar 2022 17:22:50 +0100
Message-Id: <20220309162301.61679-19-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the RTC can store dates from year 0000 to 9999, leap years where not
tested fro 2100. The driver currently stores tm_year directly which will
probably fail at that time or more probably in 2300.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-spear.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 1b40380aaba2..e386bd714b52 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -385,6 +385,8 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, config);
 
 	config->rtc->ops = &spear_rtc_ops;
+	config->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
+	config->rtc->range_min = RTC_TIMESTAMP_END_9999;
 	config->rtc->uie_unsupported = 1;
 
 	status = devm_rtc_register_device(config->rtc);
-- 
2.35.1

