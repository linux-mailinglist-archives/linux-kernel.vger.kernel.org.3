Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5A482261
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 07:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhLaGDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 01:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLaGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 01:03:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A050C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 22:03:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 200so23118769pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 22:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HZZLgE4W8fug2FCzGFVaCkPrWVmBPVIP5iwpvtWZJVg=;
        b=Cq8jM3Plos8Gav7O/Yczrs+aoQcTlmynuwKq4qtx4Y9ntm4IsOAJD8HXZcPMF9PXDA
         n7QtHmKLmBtZ9/TQ72dGwx/a88dAnpGeIzcUAN+0YRyGZQBOoTVRI1ORhQ6XRehm9agG
         Ps5AaMwkwr5+/dZZMIQ9VnTNPPSCS/VikQ8daK1SZyc4PfkUiOHK+mb5vbPFPAAVU58K
         zMJuMHRo7Rxj6tmdlhIdbA3V9YujrGD1pmT0ZQJH8mWqI0NefVrQRBOzJa4g+8VLi9oc
         ZFbo+s6dlppDueOKCuVVHsnuxUsii5RPx+nYB5G72XA9DDrRIFL91AbYlTqnsYcdktYy
         iN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HZZLgE4W8fug2FCzGFVaCkPrWVmBPVIP5iwpvtWZJVg=;
        b=Pjy8zEUanT8lm508iasBN3sgkWmIQS/5rRAD4Oup+tgFotn8GggjbP8tnecCwXXFWQ
         oU1P24+7hpzJI/WLnIVo5uviLIapb6q+Emhl7g79i5q6mUW3DdtF/NvRH/T0oLTQfPJj
         wEU1eQIRdeWc1m8BUNwVUbhUOFdqZXHop18ZgpqzX3GZ8/DliSctq5YWqzzatZzivXu7
         xtUZgkUqgJbGQ4lBDZCdWNTwmnZ5//XbSSy4daIuETsvSK5+W/KMfF7T7vHuvtesjyGY
         R3Ow2tB5T4Y2GfTo+ETjuzRoK+cm65m57wyccA3hICgsJxwMOjtCiDS16kY1JzcFolDP
         9Okg==
X-Gm-Message-State: AOAM5303Ms3snMhrups6zpjBgJeho4whtB4Tl8oaDy9BF8cFlN93J0lQ
        mbr5+2EHvcPOvfsfpOcH18E=
X-Google-Smtp-Source: ABdhPJxIjjJNL4mJcLi3Yh76Jm2d4gfvToDz3xQQw1CdxUczthnJiF5S5kKUNgio1tH2d7YOpZ8mTQ==
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr30287649pgs.251.1640930614972;
        Thu, 30 Dec 2021 22:03:34 -0800 (PST)
Received: from bj09640pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i4sm12832070pjj.30.2021.12.30.22.03.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Dec 2021 22:03:34 -0800 (PST)
From:   weidong guan <weidong.guanguan@gmail.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, orsonzhai@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        "weidong.guan" <weidong.guan@unisoc.com>
Subject: [PATCH] clocksource: fix counter with 32bit may wrap around
Date:   Fri, 31 Dec 2021 14:02:35 +0800
Message-Id: <1640930555-12220-1-git-send-email-weidong.guanguan@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "weidong.guan" <weidong.guan@unisoc.com>

When the system sleep time exceeds 30+ hours, counter with 32bit may wrap
around, resulting in insufficient sleep compensation time. So We should
enable 64bit counter mode of sprd timer and use the given mult/shift
to ensure that sufficient counts can be generated.

Signed-off-by: weidong.guan <weidong.guan@unisoc.com>
---
 drivers/clocksource/timer-sprd.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99..7eac059 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -30,6 +30,7 @@
 #define TIMER_VALUE_SHDW_HI	0x1c
 
 #define TIMER_VALUE_LO_MASK	GENMASK(31, 0)
+#define TIMER_VALUE_64BIT_MASK GENMASK_ULL(63, 0)
 
 static void sprd_timer_enable(void __iomem *base, u32 flag)
 {
@@ -57,10 +58,12 @@ static void sprd_timer_disable(void __iomem *base)
 	writel_relaxed(val, base + TIMER_CTL);
 }
 
-static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles)
+static void
+sprd_timer_update_counter(void __iomem *base, unsigned long long cycles)
 {
 	writel_relaxed(cycles & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
-	writel_relaxed(0, base + TIMER_LOAD_HI);
+	writel_relaxed((cycles >> 32) & TIMER_VALUE_LO_MASK,
+			base + TIMER_LOAD_HI);
 }
 
 static void sprd_timer_enable_interrupt(void __iomem *base)
@@ -82,7 +85,7 @@ static int sprd_timer_set_next_event(unsigned long cycles,
 	struct timer_of *to = to_timer_of(ce);
 
 	sprd_timer_disable(timer_of_base(to));
-	sprd_timer_update_counter(timer_of_base(to), cycles);
+	sprd_timer_update_counter(timer_of_base(to), (u64)cycles);
 	sprd_timer_enable(timer_of_base(to), 0);
 
 	return 0;
@@ -93,7 +96,8 @@ static int sprd_timer_set_periodic(struct clock_event_device *ce)
 	struct timer_of *to = to_timer_of(ce);
 
 	sprd_timer_disable(timer_of_base(to));
-	sprd_timer_update_counter(timer_of_base(to), timer_of_period(to));
+	sprd_timer_update_counter(timer_of_base(to),
+				  (u64)timer_of_period(to));
 	sprd_timer_enable(timer_of_base(to), TIMER_CTL_PERIOD_MODE);
 
 	return 0;
@@ -162,15 +166,19 @@ static int __init sprd_timer_init(struct device_node *np)
 
 static u64 sprd_suspend_timer_read(struct clocksource *cs)
 {
-	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
-				   TIMER_VALUE_SHDW_LO) & cs->mask;
+	u64 value_hi, value_lo;
+
+	value_hi = (u64)readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_HI);
+	value_lo = (u64)readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_LO);
+	return ~(u64)((value_hi << 32) + value_lo) & cs->mask;
 }
 
 static int sprd_suspend_timer_enable(struct clocksource *cs)
 {
 	sprd_timer_update_counter(timer_of_base(&suspend_to),
-				  TIMER_VALUE_LO_MASK);
-	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+				  TIMER_VALUE_64BIT_MASK);
+	sprd_timer_enable(timer_of_base(&suspend_to),
+			  TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);
 
 	return 0;
 }
@@ -183,10 +191,12 @@ static void sprd_suspend_timer_disable(struct clocksource *cs)
 static struct clocksource suspend_clocksource = {
 	.name	= "sprd_suspend_timer",
 	.rating	= 200,
+	.mult   = 0x1DCD650,
+	.shift  = 10,
 	.read	= sprd_suspend_timer_read,
 	.enable = sprd_suspend_timer_enable,
 	.disable = sprd_suspend_timer_disable,
-	.mask	= CLOCKSOURCE_MASK(32),
+	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
@@ -198,8 +208,7 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
 
-	clocksource_register_hz(&suspend_clocksource,
-				timer_of_rate(&suspend_to));
+	clocksource_register_hz(&suspend_clocksource, 0);
 
 	return 0;
 }
-- 
1.9.1

