Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B56F544A17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiFIL2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiFIL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:27:47 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98016A53E;
        Thu,  9 Jun 2022 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654774066;
  x=1686310066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+8MIR1OuQsaVNfsbihNB9tS+9/wynO4WohspQZNd1M=;
  b=TQv2zrl7+pSMh/Rq0arQ6pQbgTCWIgYIXG/RO8NVuPCq9WuCIIXYEuns
   sv9275G2um0dMO4febVH3LBbgF8RF04sZofN2dgWdfUi0uFAopgVm7MJC
   sLxLHEUYy7oU8FELxnFdO0lrd4oxQKk05vSGh8AFrtYeMYwN1lAKBKtpR
   HyaSERHvGBtQwyajTfKhD0GSJnIobOzPeZhywa3atfRrIVSa+eLfyxKnd
   9zar1OKhHjiKiKW4UDCa2cNOYQFKK5nXMxF8tQFXM26YWd2uXmnnoafXY
   Pk+hB82hLiGQ3evmRKDhxJXeksx9bDyZlC2wcy/mGkRVuz4cDPlHv2AO/
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@linaro.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v4 2/4] clocksource/drivers/exynos_mct: Support frc-shared property
Date:   Thu, 9 Jun 2022 13:27:36 +0200
Message-ID: <20220609112738.359385-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609112738.359385-1-vincent.whitchurch@axis.com>
References: <20220609112738.359385-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the FRC is shared with another main processor, the other processor
is assumed to have started it and this processor should not write to the
global registers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v4:
    - Add Krzysztof's Reviewed-by.
    
    v3:
    - Split FRC sharing handling from local timer indices handling
    - Remove addition of global variable.

 drivers/clocksource/exynos_mct.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index f29c812b70c9..12023831dedf 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -233,9 +233,16 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
 
-static int __init exynos4_clocksource_init(void)
+static int __init exynos4_clocksource_init(bool frc_shared)
 {
-	exynos4_mct_frc_start();
+	/*
+	 * When the frc is shared, the main processer should have already
+	 * turned it on and we shouldn't be writing to TCON.
+	 */
+	if (frc_shared)
+		mct_frc.resume = NULL;
+	else
+		exynos4_mct_frc_start();
 
 #if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
@@ -605,6 +612,7 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
+	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
 	int ret;
 
 	ret = exynos4_timer_resources(np);
@@ -615,10 +623,17 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
-	ret = exynos4_clocksource_init();
+	ret = exynos4_clocksource_init(frc_shared);
 	if (ret)
 		return ret;
 
+	/*
+	 * When the FRC is shared with a main processor, this secondary
+	 * processor cannot use the global comparator.
+	 */
+	if (frc_shared)
+		return ret;
+
 	return exynos4_clockevent_init();
 }
 
-- 
2.34.1

