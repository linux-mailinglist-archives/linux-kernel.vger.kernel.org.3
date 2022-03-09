Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915A4D35AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiCIQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiCIQaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:07 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948EC12F0;
        Wed,  9 Mar 2022 08:23:26 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED3CA20008;
        Wed,  9 Mar 2022 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q6+mVQDp96Q+sU1LASE6V01IcuUw+y3QODc3UaLejY=;
        b=GLO7DLWz6VrmfRr4rebVIQLSHULndEaghcLtFDMeR53F2tmcx+/OmcHTLMfulrDcLWCTXA
        4VOasWQTi5e/NsnLYzPVjehvLwnV/42x5NDF8M98EAtIZXNz/EwalHiFQht5YpOrCz3/eG
        ovfu4UYB2sJ12rc1DDM+9hgj80XxSE+PM6CGNvo0bOAeUfNF7AYmqFLEiqSqbbtpz9Mkzy
        WU2qLB5MQFnqgIx3M15DhPIq6GFBR4pG8uuUlAUXPxF6ps5NaVg+3PPtbOkPoHZbYxsOyZ
        A3PiEs3F0T7iqqJwp+/H91V1C+ykpL7P1FuaVt3Y+OLsFK5wOq/GCqyy2dQZjQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/29] rtc: pcf2123: set RTC_FEATURE_ALARM_RES_MINUTE
Date:   Wed,  9 Mar 2022 17:22:40 +0100
Message-Id: <20220309162301.61679-9-alexandre.belloni@bootlin.com>
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

Alarms have a resolution of a minute.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf2123.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index da0e4066ef45..e13b5e695d06 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -427,6 +427,7 @@ static int pcf2123_probe(struct spi_device *spi)
 	 * support to this driver to generate interrupts more than once
 	 * per minute.
 	 */
+	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features);
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 	rtc->ops = &pcf2123_rtc_ops;
 	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
-- 
2.35.1

