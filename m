Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847A651F0D3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiEHTsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiEHTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:48:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F8B7EF;
        Sun,  8 May 2022 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652039036;
        bh=ZMFFSXatdPBOGp95nTHs++I59HrGyDFQ5G/SIMPqqhM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RjEIdeqKWDmOJO5dgr+BdpN++zY6zcrKaVZ2pnkcdtLw5XNe3asI7lmlLvJNsJyXj
         PvVtQPC7xkGaziwR5ghao0q6zoDZWd0jjllui6MmaX0xEHS7IoWTcVCaCHLusQ+ID6
         jZsZM3gb3oez8m7qJInVhpAihqewZ06TnaZY6F+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1nZDoV2X3D-00GJDe; Sun, 08
 May 2022 21:43:56 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 7/7] ARM: dts: wpcm450: Switch clocks to clock controller
Date:   Sun,  8 May 2022 21:43:32 +0200
Message-Id: <20220508194333.2170161-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kkDcTVKHYxQWJty64O/zo4HzicYg5+GXVtXaJFZY35ZwbBQKgYd
 zvZ0lSKISIrw6iDMJ30CaX1EaqdEq5W5IO9XJUBy0Gh7/8kqKAEiVS3LhmC6TI7z9IQucXf
 JqKzmNiJsHin8PcaWclRQQ5oU0oXvgvqiaouMJH5V6j0w9Kk4bgsuy7UwJU5jOzpZ74yA9m
 +xh6sCA5teAj0W96PLtEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7PjhEGAGOY=:E9L81qjT7kzz0e1fwo1uT7
 hP7PDfwv9bFJoDbDNnAEoAeD6NEVYJPBRko2AGHhE2c4NefKXvFE+mKhavU6F132Pc0Ga84WC
 jG+5Oc5Hg0WtD7vI/Qx9dcU7qjLROxeUhOAQCNiNkhbKs2MoOwUver026OQbwrsPgPm4LBmOC
 TLdqKJ1RVwRv5ZSzuT7chMxc4qU+YdCrkHBF58CgwQDz9YZA9ZG20hcKyLodBiv5SIDQSDjrS
 mu+3ffQjErTwwkioRN/2l7Be4b8Kzi4BcXTyLyL+CyNQT+bqRhIn+gQy8+Ye+RwPXOU+xipyd
 6F1JK4aHJf6SzOJdNmWBUKNtkx8+p1SnJeVtjU6VpGuAIowdksfXwih+1vhYwFHR2benybRk3
 E8tSm+YyqXHbPjjDqSkxn/5wYNXHfU6Vz/euXhJEVHPru0tHID+wPfTsSEKXfNBSSnfiYsT0E
 bbnHBmOe9CRkNO1noDUUixS6PItcivvP2Xo33MeSXE0eXUewx3f7xZnJG8xJA+Ggc0QavlIfn
 Hp6K9ZScZ6kAEBkRwPJrJuHhHsYdxFtRfdSyhjVQsAcZcmZrXYZv0sh/LB+8zpTSRu/NLoOFM
 AKfvDfBq+UspetCK7m3vnW7RCbvg2nIL14mwfcp02+y+l+uoB7d+Sl5U8EbFRlD6huvwpexvv
 ghDkuJ2yrptKI1a49kcTtECiYe+KNtR1BO+zEgTeM+TG0FNH3fq6lLcivQ6Uk+YycR1BTFNfF
 3bU+WjihzPQF4h1OgOIHULAngsFKFw4FYFxDMXHp42pKDuJF7s+UhCKqZVDTpqRitgHEuG6JA
 BGtlo8BSF/TUlG4lwa7q+FcIwQEOLQQh1GalrIieqlKkeHNaeLuTGLlckdF0RetlbtheLLhqE
 Vp0SWHJDzskYAcEw6xGZdaLrBLQb9afN+UoydsSlz65hBfErrB/VC+v+HGnrxzsyn64s0Vlm4
 tq798DMw7fpFLru9XucyPLtcNsGmQbgr2KZIgHvrJ5xGnlX7X+s1dfhULtOO8gS5FUYmLHwKi
 7iibNhowRvgn9ewxJwU45M1lLex5AsQdEEFWnYMFkZ+9qi6BFFCHMCFTP1QmAgqwrQGhC2oME
 C30VTj5QQgijc0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is incompatible with older kernels because it requires the
clock controller driver, but I think that's acceptable because WPCM450
support is generally still in an early phase.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2, v3:
- no changes
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 515e943787416..d5ed95ef810e8 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -2,6 +2,7 @@
 // Copyright 2021 Jonathan Neusch=C3=A4fer

 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/nuvoton,wpcm450-clk.h>

 / {
 	compatible =3D "nuvoton,wpcm450";
@@ -32,13 +33,6 @@ cpu@0 {
 		};
 	};

-	clk24m: clock-24mhz {
-		/* 24 MHz dummy clock */
-		compatible =3D "fixed-clock";
-		clock-frequency =3D <24000000>;
-		#clock-cells =3D <0>;
-	};
-
 	refclk: clock-48mhz {
 		/* 48 MHz reference oscillator */
 		compatible =3D "fixed-clock";
@@ -73,7 +67,7 @@ serial0: serial@b8000000 {
 			reg =3D <0xb8000000 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART0>;
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&bsp_pins>;
 			status =3D "disabled";
@@ -84,7 +78,7 @@ serial1: serial@b8000100 {
 			reg =3D <0xb8000100 0x20>;
 			reg-shift =3D <2>;
 			interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_UART1>;
 			status =3D "disabled";
 		};

@@ -92,14 +86,18 @@ timer0: timer@b8001000 {
 			compatible =3D "nuvoton,wpcm450-timer";
 			interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb8001000 0x1c>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_TIMER0>,
+				 <&clk WPCM450_CLK_TIMER1>,
+				 <&clk WPCM450_CLK_TIMER2>,
+				 <&clk WPCM450_CLK_TIMER3>,
+				 <&clk WPCM450_CLK_TIMER4>;
 		};

 		watchdog0: watchdog@b800101c {
 			compatible =3D "nuvoton,wpcm450-wdt";
 			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb800101c 0x4>;
-			clocks =3D <&clk24m>;
+			clocks =3D <&clk WPCM450_CLK_WDT>;
 		};

 		aic: interrupt-controller@b8002000 {
=2D-
2.35.1

