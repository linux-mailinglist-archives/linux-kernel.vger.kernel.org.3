Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E93582245
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiG0IiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG0IiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:38:02 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE7C4459B0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:38:01 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 79F3C1E80D54;
        Wed, 27 Jul 2022 16:38:06 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N2UwmunMFWYb; Wed, 27 Jul 2022 16:38:03 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 62C1D1E80D05;
        Wed, 27 Jul 2022 16:38:03 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Li zeming <zeming@nfschina.com>
Subject: [PATCH] clocksource/drivers/sun5i: Remove unnecessary (void*) conversions
Date:   Wed, 27 Jul 2022 16:37:51 +0800
Message-Id: <20220727083751.5540-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary void* type castings.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/clocksource/timer-sun5i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index 85900f7fc69f..7d5fa9069906 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -142,7 +142,7 @@ static int sun5i_clkevt_next_event(unsigned long evt,
 
 static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
-	struct sun5i_timer_clkevt *ce = (struct sun5i_timer_clkevt *)dev_id;
+	struct sun5i_timer_clkevt *ce = dev_id;
 
 	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
-- 
2.18.2

