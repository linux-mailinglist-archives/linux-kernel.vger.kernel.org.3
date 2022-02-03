Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420724A8935
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiBCRFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:05:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57384 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBCRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:05:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76938615C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 17:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2D3C340E8;
        Thu,  3 Feb 2022 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643907908;
        bh=KAuyN28aHSSH4Wt23WCzBB6asTr7zUVNWJAlCLXhRrw=;
        h=From:To:Cc:Subject:Date:From;
        b=V2P/u9iN8VRZcYiM4QHl5VZsOa/q7K1IXmhiQK57+jlOXpSYMdQvBCLuiQ5pQeLi0
         kpukXkKTOgDSf0CVG2YFLFi28T5qY9wa6HA8ZlqdfJIOPF2fP7pEgOowFwTpDr0gXP
         iN8ovOV01u377c30OnocsSIjKfY5Wq3vlanW+WBfVl35gGMcFdqwGK5AXVnYYW4d79
         5BF//LEj1AXFLh0XtQ8uL9F15KXKhgA7g/f7un4J+EB0tSIEKpOlWLZvqUReqz1OZ3
         1txXidBzvYMSF4G3S3sUFcoP1dmy3LHXWdrTWAArRQor2aJ6O1IWaYqGE4s28BA4e5
         a5SmUwPNlIO2A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nFfXe-005CWE-Ko; Thu, 03 Feb 2022 17:05:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Use event stream scaling when available
Date:   Thu,  3 Feb 2022 17:05:02 +0000
Message-Id: <20220203170502.2694422-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, kernel-team@android.com, mark.rutland@arm.com, daniel.lezcano@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With FEAT_ECV and the 1GHz counter, it is pretty likely that the
event stream divider doesn't fit in the field that holds the
divider value (we only have 4 bits to describe counter bits [15:0]

Thankfully, FEAT_ECV also provides a scaling mechanism to switch
the field to cover counter bits [23:8] instead.

Enable this on arm64 when ECV is available (32bit doesn't have
any detection infrastructure and is unlikely to be run on an
ARMv8.6 system anyway).

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 13 +++++++++++--
 include/clocksource/arm_arch_timer.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 1ecd52f903b8..9ab8221ee3c6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -880,10 +880,19 @@ static void __arch_timer_setup(unsigned type,
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
 
-static void arch_timer_evtstrm_enable(int divider)
+static void arch_timer_evtstrm_enable(unsigned int divider)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
 
+#ifdef CONFIG_ARM64
+	/* ECV is likely to require a large divider. Use the EVNTIS flag. */
+	if (cpus_have_const_cap(ARM64_HAS_ECV) && divider > 15) {
+		cntkctl |= ARCH_TIMER_EVT_INTERVAL_SCALE;
+		divider -= 8;
+	}
+#endif
+
+	divider = min(divider, 15U);
 	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
 	/* Set the divider and enable virtual event stream */
 	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
@@ -912,7 +921,7 @@ static void arch_timer_configure_evtstream(void)
 		lsb++;
 
 	/* enable event stream */
-	arch_timer_evtstrm_enable(max(0, min(lsb, 15)));
+	arch_timer_evtstrm_enable(max(0, lsb));
 }
 
 static void arch_counter_set_user_access(void)
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index e715bdb720d5..057c8964aefb 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -56,6 +56,7 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_EVT_TRIGGER_MASK	(0xF << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 #define ARCH_TIMER_USR_VT_ACCESS_EN	(1 << 8) /* virtual timer registers */
 #define ARCH_TIMER_USR_PT_ACCESS_EN	(1 << 9) /* physical timer registers */
+#define ARCH_TIMER_EVT_INTERVAL_SCALE	(1 << 17) /* EVNTIS in the ARMv8 ARM */
 
 #define ARCH_TIMER_EVT_STREAM_PERIOD_US	100
 #define ARCH_TIMER_EVT_STREAM_FREQ				\
-- 
2.34.1

