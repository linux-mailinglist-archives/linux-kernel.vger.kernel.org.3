Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FD5322E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiEXGJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiEXGJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:09:52 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A835D6A07A;
        Mon, 23 May 2022 23:09:49 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 May
 2022 14:09:49 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 24 May
 2022 14:09:47 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-rtc@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rtc: rzn1: Fix  inconsistent IS_ERR and PTR_ERR
Date:   Tue, 24 May 2022 14:09:45 +0800
Message-ID: <1653372586-24736-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proper pointer to be passed as argument is rtc->rtcdev.
Detected using Coccinelle.

Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index f92d1398b0f1..4cf54af8a8c3 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -348,7 +348,7 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 
 	rtc->rtcdev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtcdev))
-		return PTR_ERR(rtc);
+		return PTR_ERR(rtc->rtcdev);
 
 	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
-- 
2.7.4

