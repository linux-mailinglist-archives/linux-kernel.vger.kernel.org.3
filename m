Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6F4F76EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiDGHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiDGHMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:12:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B75471116C;
        Thu,  7 Apr 2022 00:10:18 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id E72A2813C;
        Thu,  7 Apr 2022 07:07:53 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/4] clocksource/drivers/timer-ti-dm: Update defines for am6 for inline functions
Date:   Thu,  7 Apr 2022 10:10:04 +0300
Message-Id: <20220407071006.37031-2-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407071006.37031-1-tony@atomide.com>
References: <20220407071006.37031-1-tony@atomide.com>
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

We have pwm-omap-dmtimer tagged with COMPILE_TEST, so we need to use the
ifdefs around the inline functions. Let's add ARCH_K3 to the list of SoCs
to allow using timer-ti-dm on these SoCs.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 include/clocksource/timer-ti-dm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -251,7 +251,8 @@ int omap_dm_timers_active(void);
  * The below are inlined to optimize code size for system timers. Other code
  * should not need these at all.
  */
-#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
+#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS) || \
+	defined(CONFIG_ARCH_K3)
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
 						int posted)
 {
@@ -390,5 +391,5 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
 {
 	writel_relaxed(value, timer->irq_stat);
 }
-#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
+#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS || CONFIG_ARCH_K3 */
 #endif /* __CLOCKSOURCE_DMTIMER_H */
-- 
2.35.1
