Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1D4D7E98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiCNJbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiCNJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D111E443F7;
        Mon, 14 Mar 2022 02:28:31 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250110;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a91RPRpGxTM4Zf2tQ5NkQiH14x/w08xbxIKPKxHkm5g=;
        b=G/1NAVz7VFNBQetfbC2Jg2zbnVrpkw4HfeuZ/FEk6sXKb+7ClDfLK2QtILKZtAkYu1TAQw
        KgTA/YCDWsS90EpSZ7o0Ba6HAL+HVdcqJYgFD9DoCmJyYRQrAWgXrCtN5skEDBuYyvpJBL
        rNtayzen+g20qW0O1a9VmANXgc7f30jjKa58cOMAGK8/Mf04XNLOmCXaOmC4EkP89y6KAF
        +N24ioOmQbiZ8lrLlo63P3c7mhP2BmILlF+fx9MwshqrQjAo4JWNhRJHHQlU4nLCvCmO+j
        0U5DlHStPKoGOQf4dPdDqEkz0gYazF14FOBg36mCdY6pMNzTDJ0JdXK2BKbt+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250110;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a91RPRpGxTM4Zf2tQ5NkQiH14x/w08xbxIKPKxHkm5g=;
        b=iA6Sl6R+AN2J34R4AgQ10aIzBTA1Xgxapt3doEw0PveTxFjvKYWBqvaXqYgZoVUO7/GMLN
        of7ozcFhPmW31gBQ==
From:   "tip-bot2 for Drew Fustini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Fix regression
 from errata i940 fix
Cc:     Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220204053503.1409162-1-dfustini@baylibre.com>
References: <20220204053503.1409162-1-dfustini@baylibre.com>
MIME-Version: 1.0
Message-ID: <164725010949.16921.6359659294622134420.tip-bot2@tip-bot2>
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

Commit-ID:     bceaae3bac0ce27c549bb050336d8d08abc2ee54
Gitweb:        https://git.kernel.org/tip/bceaae3bac0ce27c549bb050336d8d08abc2ee54
Author:        Drew Fustini <dfustini@baylibre.com>
AuthorDate:    Thu, 03 Feb 2022 21:35:05 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:16 +01:00

clocksource/drivers/timer-ti-dm: Fix regression from errata i940 fix

The existing fix for errata i940 causes a conflict for IPU2 which is
using timer 3 and 4. From arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi:

  &ipu2 {
          mboxes = <&mailbox6 &mbox_ipu2_ipc3x>;
          ti,timers = <&timer3>;
          ti,watchdog-timers = <&timer4>, <&timer9>;
  };

The conflict was noticed when booting mainline on the BeagleBoard X15
which has a TI AM5728 SoC:

  remoteproc remoteproc1: 55020000.ipu is available
  remoteproc remoteproc1: powering up 55020000.ipu
  remoteproc remoteproc1: Booting fw image dra7-ipu2-fw.xem4
  omap-rproc 55020000.ipu: could not get timer platform device
  omap-rproc 55020000.ipu: omap_rproc_enable_timers failed: -19
  remoteproc remoteproc1: can't start rproc 55020000.ipu: -19

This change modifies the errata fix to instead use timer 15 and 16 which
resolves the timer conflict.

It does not appear to introduce any latency regression. Results from
cyclictest with original errata fix using dmtimer 3 and 4:

  # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0
  policy: fifo: loadavg: 0.02 0.03 0.05

  T: 0 ( 1449) P:80 I:200 C: 800368 Min:   0 Act:   32 Avg:   22 Max:  128
  T: 1 ( 1450) P:80 I:200 C: 800301 Min:   0 Act:   12 Avg:   23 Max:   70

The results after the change to dmtimer 15 and 16:

  # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0
  policy: fifo: loadavg: 0.36 0.19 0.07

  T: 0 ( 1711) P:80 I:200 C: 759599 Min:   0 Act:    6 Avg:   22 Max:  108
  T: 1 ( 1712) P:80 I:200 C: 759539 Min:   0 Act:   19 Avg:   23 Max:   79

Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
Link: https://lore.kernel.org/linux-omap/YfWsG0p6to3IJuvE@x1/
Suggested-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Link: https://lore.kernel.org/r/20220204053503.1409162-1-dfustini@baylibre.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/dra7-l4.dtsi             | 5 ++---
 arch/arm/boot/dts/dra7.dtsi                | 8 ++++----
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 956a26d..0a11bac 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3482,8 +3482,7 @@
 				ti,timer-pwm;
 			};
 		};
-
-		target-module@2c000 {			/* 0x4882c000, ap 17 02.0 */
+		timer15_target: target-module@2c000 {	/* 0x4882c000, ap 17 02.0 */
 			compatible = "ti,sysc-omap4-timer", "ti,sysc";
 			reg = <0x2c000 0x4>,
 			      <0x2c010 0x4>;
@@ -3511,7 +3510,7 @@
 			};
 		};
 
-		target-module@2e000 {			/* 0x4882e000, ap 19 14.0 */
+		timer16_target: target-module@2e000 {	/* 0x4882e000, ap 19 14.0 */
 			compatible = "ti,sysc-omap4-timer", "ti,sysc";
 			reg = <0x2e000 0x4>,
 			      <0x2e010 0x4>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 6b485cb..8f7ffe2 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1339,20 +1339,20 @@
 };
 
 /* Local timers, see ARM architected timer wrap erratum i940 */
-&timer3_target {
+&timer15_target {
 	ti,no-reset-on-init;
 	ti,no-idle;
 	timer@0 {
-		assigned-clocks = <&l4per_clkctrl DRA7_L4PER_TIMER3_CLKCTRL 24>;
+		assigned-clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER15_CLKCTRL 24>;
 		assigned-clock-parents = <&timer_sys_clk_div>;
 	};
 };
 
-&timer4_target {
+&timer16_target {
 	ti,no-reset-on-init;
 	ti,no-idle;
 	timer@0 {
-		assigned-clocks = <&l4per_clkctrl DRA7_L4PER_TIMER4_CLKCTRL 24>;
+		assigned-clocks = <&l4per3_clkctrl DRA7_L4PER3_TIMER16_CLKCTRL 24>;
 		assigned-clock-parents = <&timer_sys_clk_div>;
 	};
 };
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index b6f9796..f52bf81 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -695,9 +695,9 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 		return 0;
 	}
 
-	if (pa == 0x48034000)		/* dra7 dmtimer3 */
+	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);
-	else if (pa == 0x48036000)	/* dra7 dmtimer4 */
+	else if (pa == 0x4882e000)      /* dra7 dmtimer16 */
 		return dmtimer_percpu_timer_init(np, 1);
 
 	return 0;
