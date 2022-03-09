Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571D4D35D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiCIQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbiCIQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:03 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B438370F63;
        Wed,  9 Mar 2022 08:23:15 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2DFEB1BF206;
        Wed,  9 Mar 2022 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646842994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zsnk9RumeZUMQt5XburatyLQRbcfmf+82Q2TdpxHgv8=;
        b=gKdyPR9/1B9junfywrzMvExpiBJaO1TghiFfkECH052oxU95gKJj0AP6hKBOTKTEY63Pi4
        aPRHHOUc+7an71hXJYqoCI/Iu2JbSzOuTp/n7q5stFnSxTlgsvSVrdOfIfxeTGcRxXW0aw
        TbBJuvqaZ2UlHWW8pbLj/rcTSqDwYBIztDkzYOX3aqVv/P8owHIf2f/aG4EGon9il3P/Hk
        ifL4OUx5o3t0zZUnTTXWlo16e6CQppUn91lMb7+xClIW2L58q2Wll6AEowc1El51eoAw4N
        E9BUwZvPao5m6zvX4z1Liqxq6bNVA24n4+3pshqHedqBhnrmtVyIVWM/1aNe7Q==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Joshua Kinard <kumba@gentoo.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/29] rtc: ds1685: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:32 +0100
Message-Id: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
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
There is currently a missing information as to why this is not supported on
ioc3.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 75db7ab654a5..0ec1e44e3431 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1273,7 +1273,7 @@ ds1685_rtc_probe(struct platform_device *pdev)
 
 	/* See if the platform doesn't support UIE. */
 	if (pdata->uie_unsupported)
-		rtc_dev->uie_unsupported = 1;
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc_dev->features);
 
 	rtc->dev = rtc_dev;
 
-- 
2.35.1

