Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365224D365B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiCIQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCIQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:11 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC591D76EB;
        Wed,  9 Mar 2022 08:23:32 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5DBE2240005;
        Wed,  9 Mar 2022 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZ+FMrocTQNorBiqOaMXAhVj9/cA9JFFnHk0sZK2Ucc=;
        b=Qggx3jm/r4a9TDk+wGb6RuXrpDZcFwGk8J+XVbWvunruDlw9oSiGqYDKcus6ULEJzVd0s9
        HjzRpLx+oEbrnSG2XDG03Nkbgl0opapUpA9Gx7LQkY5PsuAk6pIKcnRlNKdyxjLOd85PPW
        jAxOVKDD/IbzaPNKmvtPo1NFln2R3152ZWkOu1t/BLYQocDH+h4iDvEP2du0RVtWQGlU5n
        seYoxKZkPxKomCECgH0oz09ux7HwF57E2ok+P9ijAZOcPK8fV9bmOQ8sLvh9BA46YS+Tsp
        0FPoAmcQTqnWA3X1r9TfM+Gkhay2gpM24fYAFtBSyMj6D51NtLuMoaul4I97JA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/29] rtc: pcf85063: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:43 +0100
Message-Id: <20220309162301.61679-12-alexandre.belloni@bootlin.com>
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

Stop using uie_unsupported and clear RTC_FEATURE_UPDATE_INTERRUPT instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index df2b072c394d..3c2477454063 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -616,7 +616,7 @@ static int pcf85063_probe(struct i2c_client *client)
 	pcf85063->rtc->ops = &pcf85063_rtc_ops;
 	pcf85063->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85063->rtc->range_max = RTC_TIMESTAMP_END_2099;
-	pcf85063->rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85063->rtc->features);
 	clear_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
 
 	if (config->has_alarms && client->irq > 0) {
-- 
2.35.1

