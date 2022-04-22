Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACA50C191
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiDVWHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiDVWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:06:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A3291D43;
        Fri, 22 Apr 2022 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650660666;
        bh=6YuxGgl4dOw9oAtmXhuC816ahBzK2oYrigEc+RKljBI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XxhBYpwAnx3F5Ph7nOBaJLmzsaLZSn+4zGEk6qhibQNcRk6iUdL274+4s46A+aa5Y
         FcslNcjFsN1f+l2DFOOE2vyzsbqVjHBHBBVWrV0BClGmAgUDAHFakIh36pg9/pzF7B
         9m+nYfQmn4LS/NGC6VbtvJZTIqVpgRlegxW9OiO4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1nuMSS1S6M-014olk; Fri, 22
 Apr 2022 20:31:58 +0200
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
Subject: [PATCH 7/7] ARM: dts: wpcm450: Switch clocks to clock controller
Date:   Fri, 22 Apr 2022 20:30:12 +0200
Message-Id: <20220422183012.444674-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422183012.444674-1-j.neuschaefer@gmx.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I67tF9Nlj04Phq6/V+ryuFf0Cliytuu3Zmf4FI2sPERSmiXM3XH
 R2sSgG7ktBlSjy9OdFQrd6Ec/8zwv1ZLrWy6vGPGRzJYTJArz+9bFEhqtpLtcF+CTwEUHq6
 BpWfwBxU2AxUAF5JBamEAauV775wUODEbE6nCW1yOWZPbsvznU4uZmjcPzjJRpLIujUNFFB
 ooGmDpfMZ9LxJkCORbk5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/wYOIf+TCA=:O9jlzwuzaT5O84sv+JhEb3
 n7UoJQmivTypW6lqZMUajZkMH5cIpkYh2X7I1jFEMRyeOwGVt9LvAB75zDMXe4VZthpsLKMAf
 2Oyfx8yNboNPrO75lUVFKE8yLa5CLOluD+9Q6NSDZqDzjH9wtzRNRVINyXsSDpYishXuQKfUr
 67DgSvfHQKZ47T856eNBTTtvClNXJHdSlKAdJqO0K9jgk56XerPMjTwuyvaBpBpMRW3rIgi6K
 dZfzktDblXHY3Qsv2/r4XGUTcJuOMaZE5LK/pZk3kjaJoGAwOiIrdxGkPAeIufA9BiyeuGP0J
 /nlrg5yGP0pLmqQtS16l4oJN4VyVubeZ+HkgSnfge51Tmfd6WRv11Y41ViBtDepbSy3suFUpN
 9Ncr4QRwHTAcSm7J9l4MxMwNw1B/7TzoFkpI7rH/VGfXlEIMi83MHwFVmc/7WNPZxCV5kesIK
 eZMArqMVgkhgF33RU7VuV+mxAkkpt3vxvCvYX7+plEN+XwndGYcU7p/anBQYUTz9oDf3Tzyey
 pvi9vk94efqSK2K3RwlKpTLPb8qKrN4ThJG5qEtzQh+CNZJzFMwMadjXA1Aj+ydLRTzieycMO
 4YeCDv4nQA4yfFTF4+8Wl2sxYP0cBzk782qhv7IlV9wU8oXmmj+PTkOYspzOmjRKnQ9ou127D
 sobBjdkrXJt2tFvrysENSGpbg5JETizRMn2jtyhj/znXoMx6cubBKXo0NskDhZpUF6SSvIrL/
 4JFQHbzXkuS5zMfZUNzq8TJBYrm+wujpJiVtXvhtm916VUyZVI8SULPBklyyGzipYy+901Zbd
 FXP736xj2vHhd4ZgwFoiaNTEKHfeNk0nDFRHvKQcfS7hMRsH2HD2NDBkvfdKvSiy+a5FozRo+
 23jVLruDR/JWKj+PlsYQyniXVdMUz223zNH+lEkg112Jt+0ku1uzCaFPGsanLb7+IsGEqHko+
 mX4fmaW07+22sfz+V1wqlVMQRAd04qNo82rMd+79dlmpuHnopitj0C0MfHw/o/WjRAqfiwbR0
 csayr8UkZEbI8u47Xj9ZHLUxfVzpxF4Qt2eMA0thzMJzmyNBYSz9V+/HtLj3fTd7d4Ys9/ZFF
 fiLcUPDqkLb11o=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 62d70fda7b520..f868bd7db009a 100644
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

