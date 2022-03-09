Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE294D35F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbiCIQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiCIQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:04 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF84B91DB;
        Wed,  9 Mar 2022 08:23:21 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 282D51BF20B;
        Wed,  9 Mar 2022 16:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646842998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNTN3+AUOo9YtakiJ/J0MXG50EA6MT75Ek8TEJT/H4o=;
        b=RpS581QOTL+Vr+9Cpoiu+rmR6ETfKQNe9bCcFNXUVtDuwikwuTIZPUVfU5sxgrgRvce1Wv
        2gZ86A7aYVg21GmLJxOPogOktWLz4F76Gi0RbfJ+tFK9pb53t9qmhkZ5WaV8CLNKkOBiyo
        4OPonysmIeDFoK1nWTHhRkxYTJhYA99/Ac3YOjqJ5AlX9wIJcxe2hHOdcZ+L5T2D9OiATB
        VsxIH1oY0mCYZMIwkd7rQfex0MPIClND7J3L2uUwmKckag/vHWzPO8ac9R5bb2Xm4IPNew
        ko3nAQBiTangUmGsyJkCg1ZVtLVfT+z7iuM51GQwdVslXJnQ7A+6R5GVrtFMbw==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/29] rtc: mpc5121: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:36 +0100
Message-Id: <20220309162301.61679-5-alexandre.belloni@bootlin.com>
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

Stop using uie_unsupported and clear RTC_FEATURE_UPDATE_INTERRUPT instead.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mpc5121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
index 6bd9779da3c6..6d7656a75cae 100644
--- a/drivers/rtc/rtc-mpc5121.c
+++ b/drivers/rtc/rtc-mpc5121.c
@@ -336,7 +336,7 @@ static int mpc5121_rtc_probe(struct platform_device *op)
 
 	rtc->rtc->ops = &mpc5200_rtc_ops;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtc->features);
-	rtc->rtc->uie_unsupported = 1;
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtc->features);
 	rtc->rtc->range_min = RTC_TIMESTAMP_BEGIN_0000;
 	rtc->rtc->range_max = 65733206399ULL; /* 4052-12-31 23:59:59 */
 
-- 
2.35.1

