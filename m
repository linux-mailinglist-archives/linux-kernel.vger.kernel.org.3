Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA4B4A93BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243545AbiBDFz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiBDFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:55:55 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DDC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:55:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i65so4200731pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HujJTKMlvKWrzO4MPNgYx8f/y8A8duNRewj59ue6fU0=;
        b=lM48WOgo2c4KlulO1a362hdCzW98v2Ij+T9S0rf4GLPg82kWiq7JIFJ0LScyBeX5nT
         Wmn8zLrsyyMS4E/NMoXa/VIrRtQrmPsdOiUEscbDSKrBQwWxo7QlF2WEfcwfoczyQK8I
         fg/mnViZYc7t7CAOVb0VHBe/jPkO2vpR9yQUAllRkKy/GeQlyShrvqvhgMrtQDIIcq7x
         e6US8mtYlVnvwOj+mzZP2pM77ODovW4mTCOYXnDLQ2Cn9QmpMryRbZURQFzL22UQQjOr
         Elb7+5SXdx+MssOmwbVZ+dtpPSYy86xo+Zx0COcU30Z1zIZj/95x3WMNgGVpyoQQ0YzW
         FlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HujJTKMlvKWrzO4MPNgYx8f/y8A8duNRewj59ue6fU0=;
        b=So/mIDlKdNQ7xKrjQC+mXeSlLY5oBW0NUbbCoeqjwBrdkEHWb2hPG/F/+c1mzNWX2q
         neo2oknCFIYLJP7ajMDcZJ1ldn2nVfn+jWV9LoSC6s0wANTM1Ua7guvghLTPZTEZMCNC
         P50g4hKh4RZ0b5iDBchDkDCPVSLIcsUjigjEHXMFJdjBhA+d9WrwxBT79+k4fqhuXikj
         DNFTCQ1fWxIKv1XU8MgFNCxTbzdNQ3ZyxJrCF8bGI6Lvs+XfbkaY7vTOqHOVEY0HW/pD
         32jFfvUd5jyIMWzHCR9MjlOvmT1uQ0+x0x8JQBpCoVp1is8hjili0FgiCXT7doF0k3vz
         4iJw==
X-Gm-Message-State: AOAM532SjmGqB8ZYq5MdHhd3DfZSFyPZWDyU8Ok60ewzbAP474tIznA2
        ujXwkdBlTwKaTS8PL4yhltHUFg==
X-Google-Smtp-Source: ABdhPJwDJMmzxyDKYKHhyjNyQOhWM1eESSAL1HuDHl1YWgqpcpIOLnSuKoy8pEdLSdmZ7E2q+Cmivw==
X-Received: by 2002:a63:735c:: with SMTP id d28mr1212676pgn.154.1643954154015;
        Thu, 03 Feb 2022 21:55:54 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:5d5d:8301:fb9f:4711])
        by smtp.gmail.com with ESMTPSA id y191sm916597pfb.114.2022.02.03.21.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 21:55:53 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, khilman@baylibre.com,
        s-anna@ti.com
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2] clocksource/drivers/timer-ti-dm: fix regression from errata i940 fix
Date:   Thu,  3 Feb 2022 21:35:05 -0800
Message-Id: <20220204053503.1409162-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v2 changes:
- add cyclictest results
- use lowercase letter in hex literals

 arch/arm/boot/dts/dra7-l4.dtsi             | 5 ++---
 arch/arm/boot/dts/dra7.dtsi                | 8 ++++----
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 956a26d52a4c..0a11bacffc1f 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3482,8 +3482,7 @@ timer14: timer@0 {
 				ti,timer-pwm;
 			};
 		};
-
-		target-module@2c000 {			/* 0x4882c000, ap 17 02.0 */
+		timer15_target: target-module@2c000 {	/* 0x4882c000, ap 17 02.0 */
 			compatible = "ti,sysc-omap4-timer", "ti,sysc";
 			reg = <0x2c000 0x4>,
 			      <0x2c010 0x4>;
@@ -3511,7 +3510,7 @@ timer15: timer@0 {
 			};
 		};
 
-		target-module@2e000 {			/* 0x4882e000, ap 19 14.0 */
+		timer16_target: target-module@2e000 {	/* 0x4882e000, ap 19 14.0 */
 			compatible = "ti,sysc-omap4-timer", "ti,sysc";
 			reg = <0x2e000 0x4>,
 			      <0x2e010 0x4>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 6b485cbed8d5..8f7ffe2f66e9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1339,20 +1339,20 @@ timer@0 {
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
index b6f97960d8ee..f52bf81dc1dd 100644
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
-- 
2.32.0

