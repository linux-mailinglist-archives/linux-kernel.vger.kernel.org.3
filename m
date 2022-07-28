Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A31583C53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiG1Ko6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiG1Koa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408DF5C94D;
        Thu, 28 Jul 2022 03:44:14 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybF8URd1PmztB8kzuUvfuNf5s6jhru3hZaNie9RcgvI=;
        b=TmDrl5dLU9jNLHe0+MSox6Hxp33xostTtHzytehj/OyZ14RbgBwef9mzZ5rQcxT86Wzu5E
        JJaE431a4vgLTXAWxtT3dsG+oh031xHNT6rlMiAbS2HcR8zgl5TfpAtrxJqj0pd46r+wbt
        O0EtrFrLcvy2Oi5oj+luBKc8spqrn21+tslC7UoNCNt71H//y2WrO3b+wY/IofyQQQzLhW
        HKp9hInVPUXLo9KZlkreGBMXgrs8MY4FdDHLISUN1XBUsDDoViwtzc4Tgl7jDVj6YKuizB
        cY5FZZGRxHmtl1vDPrZqNBk6ZVd8J0Pid6VXMs3IkicVAFKGVE6rEafk17vXcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybF8URd1PmztB8kzuUvfuNf5s6jhru3hZaNie9RcgvI=;
        b=Ol41gqAigzowCmezzqe6Oqct3hVmpyxBcB9VoN0siyQ2gHkvj92j+I1x3IEvZs4jkPDXFg
        2317iepT//71BSDw==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-microchip-pit64b: Fix
 compilation warnings
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609094041.1796372-4-claudiu.beznea@microchip.com>
References: <20220609094041.1796372-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <165900505133.15455.9928775370704382250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     278150b2151ee77ab66204ae2e53a3f94cb4b015
Gitweb:        https://git.kernel.org/tip/278150b2151ee77ab66204ae2e53a3f94cb4b015
Author:        Claudiu Beznea <claudiu.beznea@microchip.com>
AuthorDate:    Thu, 09 Jun 2022 12:40:41 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:52:43 +02:00

clocksource/drivers/timer-microchip-pit64b: Fix compilation warnings

Fix the following compilation warnings:
timer-microchip-pit64b.c:68: warning: cannot understand function prototype: 'struct mchp_pit64b_clkevt '
timer-microchip-pit64b.c:82: warning: cannot understand function prototype: 'struct mchp_pit64b_clksrc '
timer-microchip-pit64b.c:283: warning: Function parameter or member 'timer' not described in 'mchp_pit64b_init_mode'
timer-microchip-pit64b.c:283: warning: Function parameter or member 'max_rate' not described in 'mchp_pit64b_init_mode'

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20220609094041.1796372-4-claudiu.beznea@microchip.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-microchip-pit64b.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index f507056..d5f1436 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -61,7 +61,7 @@ struct mchp_pit64b_timer {
 };
 
 /**
- * mchp_pit64b_clkevt - PIT64B clockevent data structure
+ * struct mchp_pit64b_clkevt - PIT64B clockevent data structure
  * @timer: PIT64B timer
  * @clkevt: clockevent
  */
@@ -75,7 +75,7 @@ struct mchp_pit64b_clkevt {
 		struct mchp_pit64b_clkevt, clkevt))
 
 /**
- * mchp_pit64b_clksrc - PIT64B clocksource data structure
+ * struct mchp_pit64b_clksrc - PIT64B clocksource data structure
  * @timer: PIT64B timer
  * @clksrc: clocksource
  */
@@ -245,8 +245,10 @@ static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
 }
 
 /**
- * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
- *			   runtime; this includes prescaler and SGCLK bit
+ * mchp_pit64b_init_mode() - prepare PIT64B mode register value to be used at
+ *			     runtime; this includes prescaler and SGCLK bit
+ * @timer: pointer to pit64b timer to init
+ * @max_rate: maximum rate that timer's clock could use
  *
  * PIT64B timer may be fed by gclk or pclk. When gclk is used its rate has to
  * be at least 3 times lower that pclk's rate. pclk rate is fixed, gclk rate
