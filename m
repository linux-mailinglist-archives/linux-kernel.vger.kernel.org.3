Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1AD4F92C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiDHKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiDHKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:19:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE2EFCBE77;
        Fri,  8 Apr 2022 03:17:30 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5D4AF807E;
        Fri,  8 Apr 2022 10:15:04 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 3/3] clocksource/drivers/timer-ti-dm: Add compatible for am6 SoCs
Date:   Fri,  8 Apr 2022 13:17:15 +0300
Message-Id: <20220408101715.43697-4-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408101715.43697-1-tony@atomide.com>
References: <20220408101715.43697-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for ti,am654-timer to support the timers. For example, am654
has four timers in the MCU domain and 12 timers in the MAIN domain.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1037,6 +1037,10 @@ static const struct dmtimer_platform_data omap3plus_pdata = {
 	.timer_ops = &dmtimer_ops,
 };
 
+static const struct dmtimer_platform_data am6_pdata = {
+	.timer_ops = &dmtimer_ops,
+};
+
 static const struct of_device_id omap_timer_match[] = {
 	{
 		.compatible = "ti,omap2420-timer",
@@ -1065,6 +1069,10 @@ static const struct of_device_id omap_timer_match[] = {
 		.compatible = "ti,dm816-timer",
 		.data = &omap3plus_pdata,
 	},
+	{
+		.compatible = "ti,am654-timer",
+		.data = &am6_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
-- 
2.35.1
