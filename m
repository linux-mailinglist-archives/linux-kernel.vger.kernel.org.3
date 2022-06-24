Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A1559F96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiFXRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiFXRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:07:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9264D60A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:07:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so5951291ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWDsA5LutZmEUM7IrG96DY9f8c0y1Wd0MZ7dphsyywg=;
        b=ZBapUNKRXvf53+qtHX5NCLLYePhguRw4kAMk2F7zjt436VkGGkBNICiMqnxz0GHvsM
         FpMy7tJQR41GLimSCylzTa/hHGgNp71RAS9Q0tYdY5vlW9/P6Oh9znoM/zMW8+255KTV
         b9vh1T3IDSziq/3ze5QZR1xjsDfDPsCAQkhFLDNIONRteQys2wOpd1iLVumJlrFWdbeZ
         05r/fp2mDsZvvo5anyvNYEhbEUANPD6CNdTU9ckU8EnUoTSXJis2UeoHjwtI0vqBqDGV
         1S9t8hKpwJY+nTP8H51X/QAT0bBjWh/MXuJQxoDnbgK7ci0Vk2ytZBUE42ku7plBiWdR
         fEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xWDsA5LutZmEUM7IrG96DY9f8c0y1Wd0MZ7dphsyywg=;
        b=7CtO8CLIEPcrp7WEP9cuAwfAR6qf2Rde1toK1jmGj8l2B6CLC3fEloyuvzhsnfY+2G
         aXGZGEk0j5DUqYphjfV0fhgbklf8CdlG4duEjKO867RnyL/nRA4f34GbGbnaa6S48UA4
         6jsxamuv0UvZ4Le+vZ1bXrt40KrFd069cv4StYYjpUz7oNEj8essOMarEMrmKt9AwCj9
         7juSN6L5jb3NcMMGSSWw3VCE5lCww07bJ8Gq4RvZil+3b4RZrMesYSRDsmcfGVRULSOg
         KhhoNOvUlf+y+Is9CkG3VuyAakAHnMvWxty64VLn+4Hs2EYVUbPku9pQJgzJhUXUtWk6
         rQ6g==
X-Gm-Message-State: AJIora9VOiinFsLzKFGh05Kbv5HJfpSK0V3qUvTyttXUX9ahW9gCzuVD
        a3oIPVYWFa1WzdHHbWdqHHjCKg==
X-Google-Smtp-Source: AGRyM1uvN4/zjWbekB9cs96yidSoVDrR43X0yFOcqdz6eQ030hUSjBrh7eT51jheRehIsj84rRqv0Q==
X-Received: by 2002:a17:906:39d1:b0:6fa:8e62:c8a2 with SMTP id i17-20020a17090639d100b006fa8e62c8a2mr14454097eje.487.1656090465752;
        Fri, 24 Jun 2022 10:07:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7dc13000000b00435959d3605sm2455929edu.84.2022.06.24.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:07:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] MIPS: dts: correct gpio-keys names and properties
Date:   Fri, 24 Jun 2022 19:07:39 +0200
Message-Id: <20220624170740.66271-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio-keys children do not use unit addresses.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See: https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/
---
 arch/mips/boot/dts/img/pistachio_marduk.dts   |  4 +--
 arch/mips/boot/dts/ingenic/gcw0.dts           | 31 +++++++++----------
 arch/mips/boot/dts/ingenic/rs90.dts           | 18 +++++------
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  9 ++----
 .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  6 ++--
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 +--
 .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  6 ++--
 arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 +--
 .../qca/ar9331_openembed_som9331_board.dts    |  4 +--
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 ++---
 10 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index a8708783f04b..a8da2f992b1a 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -59,12 +59,12 @@ led-1 {
 
 	keys {
 		compatible = "gpio-keys";
-		button@1 {
+		button-1 {
 			label = "Button 1";
 			linux,code = <0x101>; /* BTN_1 */
 			gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 		};
-		button@2 {
+		button-2 {
 			label = "Button 2";
 			linux,code = <0x102>; /* BTN_2 */
 			gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
diff --git a/arch/mips/boot/dts/ingenic/gcw0.dts b/arch/mips/boot/dts/ingenic/gcw0.dts
index 4abb0318416c..5d33f26fd28c 100644
--- a/arch/mips/boot/dts/ingenic/gcw0.dts
+++ b/arch/mips/boot/dts/ingenic/gcw0.dts
@@ -130,89 +130,86 @@ backlight: backlight {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		autorepeat;
 
-		button@0 {
+		button-0 {
 			label = "D-pad up";
 			linux,code = <KEY_UP>;
 			linux,can-disable;
 			gpios = <&gpe 21 GPIO_ACTIVE_LOW>;
 		};
 
-		button@1 {
+		button-1 {
 			label = "D-pad down";
 			linux,code = <KEY_DOWN>;
 			linux,can-disable;
 			gpios = <&gpe 25 GPIO_ACTIVE_LOW>;
 		};
 
-		button@2 {
+		button-2 {
 			label = "D-pad left";
 			linux,code = <KEY_LEFT>;
 			linux,can-disable;
 			gpios = <&gpe 23 GPIO_ACTIVE_LOW>;
 		};
 
-		button@3 {
+		button-3 {
 			label = "D-pad right";
 			linux,code = <KEY_RIGHT>;
 			linux,can-disable;
 			gpios = <&gpe 24 GPIO_ACTIVE_LOW>;
 		};
 
-		button@4 {
+		button-4 {
 			label = "Button A";
 			linux,code = <KEY_LEFTCTRL>;
 			linux,can-disable;
 			gpios = <&gpe 29 GPIO_ACTIVE_LOW>;
 		};
 
-		button@5 {
+		button-5 {
 			label = "Button B";
 			linux,code = <KEY_LEFTALT>;
 			linux,can-disable;
 			gpios = <&gpe 20 GPIO_ACTIVE_LOW>;
 		};
 
-		button@6 {
+		button-6 {
 			label = "Button Y";
 			linux,code = <KEY_SPACE>;
 			linux,can-disable;
 			gpios = <&gpe 27 GPIO_ACTIVE_LOW>;
 		};
 
-		button@7 {
+		button-7 {
 			label = "Button X";
 			linux,code = <KEY_LEFTSHIFT>;
 			linux,can-disable;
 			gpios = <&gpe 28 GPIO_ACTIVE_LOW>;
 		};
 
-		button@8 {
+		button-8 {
 			label = "Left shoulder button";
 			linux,code = <KEY_TAB>;
 			linux,can-disable;
 			gpios = <&gpb 20 GPIO_ACTIVE_LOW>;
 		};
 
-		button@9 {
+		button-9 {
 			label = "Right shoulder button";
 			linux,code = <KEY_BACKSPACE>;
 			linux,can-disable;
 			gpios = <&gpe 26 GPIO_ACTIVE_LOW>;
 		};
 
-		button@10 {
+		button-10 {
 			label = "Start button";
 			linux,code = <KEY_ENTER>;
 			linux,can-disable;
 			gpios = <&gpb 21 GPIO_ACTIVE_LOW>;
 		};
 
-		button@11 {
+		button-11 {
 			label = "Select button";
 			linux,code = <KEY_ESC>;
 			linux,can-disable;
@@ -223,7 +220,7 @@ button@11 {
 			gpios = <&gpd 18 GPIO_ACTIVE_HIGH>;
 		};
 
-		button@12 {
+		button-12 {
 			label = "Power slider";
 			linux,code = <KEY_POWER>;
 			linux,can-disable;
@@ -231,7 +228,7 @@ button@12 {
 			wakeup-source;
 		};
 
-		button@13 {
+		button-13 {
 			label = "Power hold";
 			linux,code = <KEY_PAUSE>;
 			linux,can-disable;
diff --git a/arch/mips/boot/dts/ingenic/rs90.dts b/arch/mips/boot/dts/ingenic/rs90.dts
index 74fee7f01352..e8df70dd42bf 100644
--- a/arch/mips/boot/dts/ingenic/rs90.dts
+++ b/arch/mips/boot/dts/ingenic/rs90.dts
@@ -52,53 +52,51 @@ backlight: backlight {
 
 	keys@0 {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		key@0 {
+		key-0 {
 			label = "D-pad up";
 			linux,code = <KEY_UP>;
 			gpios = <&gpc 10 GPIO_ACTIVE_LOW>;
 		};
 
-		key@1 {
+		key-1 {
 			label = "D-pad down";
 			linux,code = <KEY_DOWN>;
 			gpios = <&gpc 11 GPIO_ACTIVE_LOW>;
 		};
 
-		key@2 {
+		key-2 {
 			label = "D-pad left";
 			linux,code = <KEY_LEFT>;
 			gpios = <&gpb 31 GPIO_ACTIVE_LOW>;
 		};
 
-		key@3 {
+		key-3 {
 			label = "D-pad right";
 			linux,code = <KEY_RIGHT>;
 			gpios = <&gpd 21 GPIO_ACTIVE_LOW>;
 		};
 
-		key@4 {
+		key-4 {
 			label = "Button A";
 			linux,code = <KEY_LEFTCTRL>;
 			gpios = <&gpc 31 GPIO_ACTIVE_LOW>;
 		};
 
-		key@5 {
+		key-5 {
 			label = "Button B";
 			linux,code = <KEY_LEFTALT>;
 			gpios = <&gpc 30 GPIO_ACTIVE_LOW>;
 		};
 
-		key@6 {
+		key-6 {
 			label = "Right shoulder button";
 			linux,code = <KEY_BACKSPACE>;
 			gpios = <&gpc 12 GPIO_ACTIVE_LOW>;
 			debounce-interval = <10>;
 		};
 
-		key@7 {
+		key-7 {
 			label = "Start button";
 			linux,code = <KEY_ENTER>;
 			gpios = <&gpd 17 GPIO_ACTIVE_LOW>;
diff --git a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
index d7fa5d55dbf3..ab70637bbec5 100644
--- a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
+++ b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
@@ -52,22 +52,19 @@ keys0 {
 		pinctrl-0 = <&user_buttons_s0>;
 		pinctrl-names = "default";
 
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		button@sw1 {
+		button-1 {
 			label = "ESC";
 			linux,code = <1>;
 			gpios = <&gpio1 12 0>;
 		};
 
-		button@sw2 {
+		button-2 {
 			label = "Home";
 			linux,code = <102>;
 			gpios = <&gpio1 13 0>;
 		};
 
-		button@sw3 {
+		button-3 {
 			label = "Menu";
 			linux,code = <139>;
 			gpios = <&gpio1 14 0>;
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 7fccf6357225..f3dff4009ab5 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -23,17 +23,15 @@ extosc: ref {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button@0 {
+		button-0 {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
 			debounce-interval = <60>;
 		};
 
-		button@1 {
+		button-1 {
 			label = "qss";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio 7 GPIO_ACTIVE_LOW>;
diff --git a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
index 7695d326df11..c857cd22f7db 100644
--- a/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
@@ -33,10 +33,8 @@ led-0 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button@0 {
+		button-0 {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index d38aa73f1a2e..40e4c5da0e65 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -49,16 +49,14 @@ system {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button@0 {
+		button-0 {
 			label = "jumpstart";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 		};
 
-		button@1 {
+		button-1 {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
index 11778abacf66..ed184d861d5f 100644
--- a/arch/mips/boot/dts/qca/ar9331_omega.dts
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -31,10 +31,8 @@ system {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button@0 {
+		button-0 {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
diff --git a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
index e6622f8e8c2b..dc65ebd60bbc 100644
--- a/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
+++ b/arch/mips/boot/dts/qca/ar9331_openembed_som9331_board.dts
@@ -33,10 +33,8 @@ led-0 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button@0 {
+		button-0 {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index c8290d36cfbe..5f424c2cd781 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -49,22 +49,20 @@ led3g {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		button@0 {
+		button-0 {
 			label = "wps";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		button@1 {
+		button-1 {
 			label = "sw1";
 			linux,code = <BTN_0>;
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
 		};
 
-		button@2 {
+		button-2 {
 			label = "sw2";
 			linux,code = <BTN_1>;
 			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

