Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED134D3620
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiCIQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiCIQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:10 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF4D2248;
        Wed,  9 Mar 2022 08:23:30 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A9E540004;
        Wed,  9 Mar 2022 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytygVa3qkTtXwTlH3LvvKqalT9tgD2Iy4CHoUD5lQvA=;
        b=E0cnyiwuGl0cSFbtbbhDtAGpo/9vEBj2+7o9qELZ8yCn8HenhzbFXVY2xwFQGonZ9ck7pw
        StssGfzlLbdec9sXs+xoMR/7pKS8qRvQegz0XiWVOvFDct/e10tC7KO+LtpjuCBvGkO/xV
        YENDgIHLJUbaLgpGzoLTKiuCOLjqjteL6doSqKL/+gRd/qb/zGHRNHrD1xkkX0syrCsLOm
        JI6IHavcoGMwvyQAhzoO/jh6x/dcjVwgL0Wga3HW4dHm3nL3oO35AmGZlzgC/Ly0hy4mPo
        UKrly/v7HnIYoUxb5xvCL2uBQH1Lj2YIA+TgvgwLqo4o8fdkRqI1HxQUzGaN+Q==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/29] rtc: pcf85063: set RTC_FEATURE_ALARM_RES_2S
Date:   Wed,  9 Mar 2022 17:22:44 +0100
Message-Id: <20220309162301.61679-13-alexandre.belloni@bootlin.com>
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

The PCF85063 doesn't support UIE because setting an alarm to fire every
second confuses the chip and the fastest we can go is an alarm every 2
seconds.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 3c2477454063..9760824ec199 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -616,6 +616,7 @@ static int pcf85063_probe(struct i2c_client *client)
 	pcf85063->rtc->ops = &pcf85063_rtc_ops;
 	pcf85063->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	pcf85063->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	set_bit(RTC_FEATURE_ALARM_RES_2S, pcf85063->rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, pcf85063->rtc->features);
 	clear_bit(RTC_FEATURE_ALARM, pcf85063->rtc->features);
 
-- 
2.35.1

