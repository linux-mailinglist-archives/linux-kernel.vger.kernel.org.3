Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B614D367B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiCIQgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiCIQaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:05 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04094BBE14;
        Wed,  9 Mar 2022 08:23:21 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 07C4124000D;
        Wed,  9 Mar 2022 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646842999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8iZc0+O+5RKucT+sJ8OrJZ3CFFtISBfVbkUZPRuduU=;
        b=O1bHZQpQ6hO3oF9/61RSvsLe4NWiWFSKt4MrudAMdQI+FPAnbXWhzBIsvgnJCRd7ygJYPo
        DAe6JhR9sDUUuiksXxoTiIE9gzAwjqUI2/QeslxF6QZQmq2sx3SiONjBT7zjzjQ2qHN476
        zu4HJFVQir4v/ZFm/3cjT+/WvhtXdJpATI/Vic/6GBJ/AX21wfjOEEJe1H+Bx2oELdCrSH
        JJX1jRNftZcBb5VXy/gOZcpd6GokIvUoUduVp27KF4Onf+roGTyHrMcpaJlGbH7Y9/pnO6
        ZykBEP4TL5s2BXvdPWk+fdIikDQ7Q6ue02AM+WHRsHuiCBPsxEJ3Ae4bwMeVOA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/29] rtc: m41t80: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:37 +0100
Message-Id: <20220309162301.61679-6-alexandre.belloni@bootlin.com>
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

Stop using uie_unsupported and clear RTC_FEATURE_UPDATE_INTERRUPT instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-m41t80.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 6d383b629d20..d868458cd40e 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -932,10 +932,8 @@ static int m41t80_probe(struct i2c_client *client,
 	m41t80_data->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	m41t80_data->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
-	if (client->irq <= 0) {
-		/* We cannot support UIE mode if we do not have an IRQ line */
-		m41t80_data->rtc->uie_unsupported = 1;
-	}
+	if (client->irq <= 0)
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, m41t80_data->rtc->features);
 
 	/* Make sure HT (Halt Update) bit is cleared */
 	rc = i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_HOUR);
-- 
2.35.1

