Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8203C471E42
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLLWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:34:44 -0500
Received: from mail.wizzup.org ([95.217.97.174]:43960 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229838AbhLLWen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QuWJwIwd0KlG4pulcoV1SiGQ3Y0Tb9RUFgGWxvcRnro=; b=pNoTurymbDGt9AYpl/90oc4qzL
        2nzL6d82I71nCqn0eO9z//D0uRPBb1/5Id8lv/YQdA2/VlPqt9Bc2neR/fXXe00Jx6/5iGp3paQIS
        ppDCXQjC3zB/DQpsY280Y/50F7HHDAT+szxzmphUUGhs0FkfEKzETkKB4Un+jC/vhjf69Up9sA6JO
        fBedF9UW4UW1ijuJZwl+ZN3FcFlmNKgLAEQXmIfYnxe4h0520JGAt1cSPwnOqjmOdNMmSSqw/uK3Z
        8yazm3KrqaXgKGycEiPI0KwVRmJlSd26skv2Ax/TR85b0lD0zIJGWpyuBW55beBjP8KVzgi7czfbR
        sg1/RlAw==;
Received: from [45.83.235.159] (helo=gentoo-x13.fritz.box)
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mwXQO-0001do-R5; Sun, 12 Dec 2021 22:34:33 +0000
From:   Merlijn Wajer <merlijn@wizzup.org>
To:     merlijn@wizzup.org
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: omap3-n900: Fix lp5523 for multi color
Date:   Sun, 12 Dec 2021 23:40:06 +0100
Message-Id: <20211212224007.10293-2-merlijn@wizzup.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212224007.10293-1-merlijn@wizzup.org>
References: <20211212224007.10293-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Sicelo A. Mhlongo" <absicsz@gmail.com>

Since the LED multicolor framework support was added in commit
92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
LEDs on this platform stopped working.

Fixes: 92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
Fixes: ac219bf3c9bd ("leds: lp55xx: Convert to use GPIO descriptors")
Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 50 +++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index c89b6c87271f..1746a44e96bc 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -8,6 +8,7 @@
 
 #include "omap34xx.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 /*
  * Default secure signed bootloader (Nokia X-Loader) does not enable L3 firewall
@@ -630,63 +631,92 @@ indicator {
 	};
 
 	lp5523: lp5523@32 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "national,lp5523";
 		reg = <0x32>;
 		clock-mode = /bits/ 8 <0>; /* LP55XX_CLOCK_AUTO */
-		enable-gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
+		enable-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
 
-		chan0 {
+		led@0 {
+			reg = <0>;
 			chan-name = "lp5523:kb1";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 		};
 
-		chan1 {
+		led@1 {
+			reg = <1>;
 			chan-name = "lp5523:kb2";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 		};
 
-		chan2 {
+		led@2 {
+			reg = <2>;
 			chan-name = "lp5523:kb3";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 		};
 
-		chan3 {
+		led@3 {
+			reg = <3>;
 			chan-name = "lp5523:kb4";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 		};
 
-		chan4 {
+		led@4 {
+			reg = <4>;
 			chan-name = "lp5523:b";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
 		};
 
-		chan5 {
+		led@5 {
+			reg = <5>;
 			chan-name = "lp5523:g";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
 		};
 
-		chan6 {
+		led@6 {
+			reg = <6>;
 			chan-name = "lp5523:r";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
 		};
 
-		chan7 {
+		led@7 {
+			reg = <7>;
 			chan-name = "lp5523:kb5";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 		};
 
-		chan8 {
+		led@8 {
+			reg = <8>;
 			chan-name = "lp5523:kb6";
 			led-cur = /bits/ 8 <50>;
 			max-cur = /bits/ 8 <100>;
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 		};
 	};
 
-- 
2.32.0

