Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6F4D3774
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiCIQrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbiCIQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AFFDB879;
        Wed,  9 Mar 2022 08:23:35 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6AE8DE000D;
        Wed,  9 Mar 2022 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SS9cTXtdLiL9KpSWnPqyrZ4w2BtGkHDqzbn5AdkhuQw=;
        b=k7NyuzUWZMeuTDjBSqBiP4XqO9Iaj5wlS0KqadTAxvaLx1rAjBT8+IzY+hHLMobpcKtOt+
        6ux8AZA49sBm87cLzAiLtmQY27ifpU3SIdChv7E+yD3oV5mgD3WLzn+Axh5N59siOaUKwc
        7Z9UmjCHVDkiTyqv9nWsCIJnI5Z2i+9y1zvKgqHiQNcvIX0VvxenBd4vMqACZYVUPReXXd
        FZxPkXUM9w0QKq1QCF0kt6AJrsdvVfB2iRWk+GLrGqWZNn3ObvUaI8IWT766IbwhacFzBS
        vhPFVhrcqFbSVGF7O5jYNUFzjP6I/mLy10qQ5Qo6PjIm1zLsXHGm+a4k6qZohA==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] rtc: pcf8563: switch to RTC_FEATURE_UPDATE_INTERRUPT
Date:   Wed,  9 Mar 2022 17:22:48 +0100
Message-Id: <20220309162301.61679-17-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 530f06c810fa..9d06813e2e6d 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -552,8 +552,8 @@ static int pcf8563_probe(struct i2c_client *client,
 
 	pcf8563->rtc->ops = &pcf8563_rtc_ops;
 	/* the pcf8563 alarm only supports a minute accuracy */
-	pcf8563->rtc->uie_unsupported = 1;
 	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, pcf8563->rtc->features);
+	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf8563->rtc->features);
 	pcf8563->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf8563->rtc->range_max = RTC_TIMESTAMP_END_2099;
 	pcf8563->rtc->set_start_time = true;
-- 
2.35.1

