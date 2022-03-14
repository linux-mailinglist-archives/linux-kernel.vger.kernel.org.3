Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F84D7E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiCNJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237997AbiCNJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D837841639;
        Mon, 14 Mar 2022 02:28:26 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LoGXifgXBugWKhZJEY5Vgd4JoXXcESKZroQeRhqACbE=;
        b=SSlqdCETTNWRBgVWIa46TPZaBPx7+zJLzq9iFJqOtkz4hEU/G340Szdlmu+c3erFxuHojj
        PQhwiEow1S/P92o82g6DcF4nxnhL9p3snI8gl6Q0+7YB5MpwZhm10mH2a1twYrGjQXMirS
        hAokUE75wddOlW0DRwgPQrh8N2VAU1ZNjh2Mq/MrT1HmSs2GgxOGe8MryEGEl99iJuxymo
        tSJr9oiAwxGYo3SoSEtgHN+5fW2cZegGuZwnycKDjx3BJPDg0jg6qHEqr2ZpAxXpQRn1dE
        Klb67Qq3kNRq8lZZfx7x0X7l2hHe+JEVDX3sYYLa/NfA84O2eIymyH4U69weuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LoGXifgXBugWKhZJEY5Vgd4JoXXcESKZroQeRhqACbE=;
        b=67b0qBbbGOa9Qxp4kThR0u9zCxyjlw+HRXbSwNDJlbKMYQYf8XMka6mfqnQBECxXXv8WdX
        bO0fo0RL15NjlHCA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Use event
 stream scaling when available
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220203170502.2694422-1-maz@kernel.org>
References: <20220203170502.2694422-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164725010442.16921.3179930344257099426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8c4b810a87005eb46564a48a69b5b255e515fa62
Gitweb:        https://git.kernel.org/tip/8c4b810a87005eb46564a48a69b5b255e515fa62
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 03 Feb 2022 17:05:02 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/arm_arch_timer: Use event stream scaling when available

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
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20220203170502.2694422-1-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 13 +++++++++++--
 include/clocksource/arm_arch_timer.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 1ecd52f..9ab8221 100644
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
index e715bdb..057c896 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -56,6 +56,7 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_EVT_TRIGGER_MASK	(0xF << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 #define ARCH_TIMER_USR_VT_ACCESS_EN	(1 << 8) /* virtual timer registers */
 #define ARCH_TIMER_USR_PT_ACCESS_EN	(1 << 9) /* physical timer registers */
+#define ARCH_TIMER_EVT_INTERVAL_SCALE	(1 << 17) /* EVNTIS in the ARMv8 ARM */
 
 #define ARCH_TIMER_EVT_STREAM_PERIOD_US	100
 #define ARCH_TIMER_EVT_STREAM_FREQ				\
