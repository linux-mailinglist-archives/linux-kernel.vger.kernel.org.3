Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483358D585
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiHIIlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiHIIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:41:11 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BA30C0A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:41:11 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C4FF01E80CD2;
        Tue,  9 Aug 2022 16:39:25 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WOF1J5ecP-AZ; Tue,  9 Aug 2022 16:39:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: lvqian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 425EB1E80CC5;
        Tue,  9 Aug 2022 16:39:23 +0800 (CST)
From:   Lv qian <lvqian@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, Lv qian <lvqian@nfschina.com>
Subject: [PATCH] clocksource/timer-stm32: Remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 16:41:05 +0800
Message-Id: <20220809084105.3891-1-lvqian@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Remove unnecessary (void*) conversions

Signed-off-by: Lv qian <lvqian@nfschina.com>
---
 drivers/clocksource/timer-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index c9a753f96ba1..3a8bb07469a8 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -161,7 +161,7 @@ static int stm32_clock_event_set_oneshot(struct clock_event_device *clkevt)
 
 static irqreturn_t stm32_clock_event_handler(int irq, void *dev_id)
 {
-	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *clkevt = dev_id;
 	struct timer_of *to = to_timer_of(clkevt);
 
 	writel_relaxed(0, timer_of_base(to) + TIM_SR);
-- 
2.18.2

