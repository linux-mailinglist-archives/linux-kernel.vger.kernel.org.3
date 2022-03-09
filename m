Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58CD4D36A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiCIQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiCIQaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:12 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672BDDCE20;
        Wed,  9 Mar 2022 08:23:37 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CDC48E000F;
        Wed,  9 Mar 2022 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHZGIokNZTQCU6zOlzF1qzHt8v1GoKMVBKRTyQFOlUw=;
        b=mIrNODGT8AKgdYd6dH+SnBfomM4O2tlur71NTYRyIEMy/dv8mt7X9Lc+uQmrhBD190mzrS
        QFTXgDF6mvuhdMVahAwioadN2AV4yRZrs43yCRTvLfAs8egG8C8UDYgmoLNBgU5totjKF6
        YDrlozX7iLqNTRw3iS9a+76AEP65+G6DD/NK8Cl6o4nwhn5KuFw0ZeLDYcIhoP0e3pYm4H
        sOXD6BW7kYIGpxw5tu9PEwsgKJdh/2RSx33yKnvaMm4oE1az37UwIjrvaHb1M7EW4jvKbq
        x5Z68VlLi4AY36bgcO6r8ecNgc14vZ1tjT7MfbRP4tVAnIDk89YhVbDYzAE8jQ==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/29] rtc: spear: fix spear_rtc_read_time
Date:   Wed,  9 Mar 2022 17:22:52 +0100
Message-Id: <20220309162301.61679-21-alexandre.belloni@bootlin.com>
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

The reference manual doesn't specify whether the registers are latched and
they probably aren't, ensure the read time and date are consistent.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-spear.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index c395af3ebc91..d4777b01ab22 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -204,8 +204,10 @@ static int spear_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	/* we don't report wday/yday/isdst ... */
 	rtc_wait_not_busy(config);
 
-	time = readl(config->ioaddr + TIME_REG);
-	date = readl(config->ioaddr + DATE_REG);
+	do {
+		time = readl(config->ioaddr + TIME_REG);
+		date = readl(config->ioaddr + DATE_REG);
+	} while (time == readl(config->ioaddr + TIME_REG));
 	tm->tm_sec = (time >> SECOND_SHIFT) & SECOND_MASK;
 	tm->tm_min = (time >> MINUTE_SHIFT) & MIN_MASK;
 	tm->tm_hour = (time >> HOUR_SHIFT) & HOUR_MASK;
-- 
2.35.1

