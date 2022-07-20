Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C757B8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbiGTOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiGTOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:48:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425752DD7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a18-20020a05600c349200b003a30de68697so2545180wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:to:cc;
        bh=o7NWJMKmrg5UzWFssb9UC6+9fr3X64sVc8zqbdDmg/4=;
        b=35Q7aaLTpf6XHFiAk3xPyLuE7i3lVuBjTEOr4YEtua/WiSxQNGV5E7wgmPYZvrXdMz
         cb8+kgykVVSkEBD2kqKYw3w87eRLhTkDH4ekVHbv6Ct3OZOx8qIPGI9GE+lXGbLcXKa5
         677DZ1rDcZ1/vIdTs1a+kY5+jO4kbzxHXkF7rp3f8V3OVj2+AbMMjUcF0WPkDlQaJkN+
         lGn1dr92MXwPIn5iTDypPp9qq3tn8ZCYf9mlO7foOBdNrj85JwjhbuitB1nUgnvX8WM/
         txABYDNzMJXhCuTSuSUzbZHYOmgX7XUJbgn9PnY/mM1+iErCmsEpGi3f36wb/3TcvYFL
         4QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:to:cc;
        bh=o7NWJMKmrg5UzWFssb9UC6+9fr3X64sVc8zqbdDmg/4=;
        b=73PGN1XJONOmtnYdbwMA0dppgtNfbmaqbjwkyLLAzynhJHdZoyoCrtiaHSp91xUcAM
         X73SQmpmMM21m6bOV9c+NyL7KKs3862qKpxpJIBMzSfeAR0qwZZD3yq6Sm7nh/aWmVJD
         PZyCrli9OKm+cVutODATz+l31WeoJ8W1ynzSwe1EfUQoJb+5APNzdwqOfvPVhKgImATf
         8gIKUk1dyTX+R150MrmeANUGhubCG+rd9ZEufwSkQeOO3PwdjiK0DH/a20QMTbFbcTKJ
         XNr1++7cg8ihYKQCUJxRNOhLxaFmH4ya8uLWo3axQJJrLF4aUvbTotcjwdtfyG4qRWv3
         ReEQ==
X-Gm-Message-State: AJIora9yfEPve6XvvoOtV+e4HuU9ub/M3+1N5uf0GQ2HQv220R0M858j
        W5CjdME+aeiUEcyvHuzQvu6LjgU35CTDMQ==
X-Google-Smtp-Source: AGRyM1ucwB2vU/aGRAvjhlYFu9788qVNYbD0PNW11PcdfR+3DHacpm9xpneOLojFxCjqxsBH2JlD1w==
X-Received: by 2002:a05:600c:cd:b0:3a3:f40:8776 with SMTP id u13-20020a05600c00cd00b003a30f408776mr4254459wmm.9.1658328523535;
        Wed, 20 Jul 2022 07:48:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb19:85e6:1900:c639:22f8:bed9:44dd])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003a31673515bsm3321121wmq.7.2022.07.20.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:48:43 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Wed, 20 Jul 2022 16:48:42 +0200
Subject: [PATCH v1 6/6] arm64: dts: mediatek: mt8183-pumpkin: add keypad support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v1-6-ef9fc29dbff4@baylibre.com>
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0-dev-54fef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add device-tree bindings for the keypad driver on the MT8183 Pumpkin
board.

The MT8183 Pumpkin board has 2 buttons connected using: KPROW0,
KPROW1 and KPCOL0.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 530e0c9ce0c9..add697c94b05 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include "mt8183.dtsi"
 #include "mt6358.dtsi"
 
@@ -122,6 +123,18 @@ &i2c6 {
 	clock-frequency = <100000>;
 };
 
+&keyboard {
+	pinctrl-names = "default";
+	pinctrl-0 = <&keyboard_pins>;
+	status = "okay";
+	linux,keymap = <MATRIX_KEY(0x00, 0x00, KEY_VOLUMEDOWN)
+			MATRIX_KEY(0x01, 0x00, KEY_VOLUMEUP)>;
+	keypad,num-rows = <2>;
+	keypad,num-columns = <1>;
+	debounce-delay-ms = <32>;
+	mediatek,double-keys;
+};
+
 &mmc0 {
 	status = "okay";
 	pinctrl-names = "default", "state_uhs";
@@ -226,6 +239,14 @@ pins_cmd_dat {
 		};
 	};
 
+	keyboard_pins: keyboard {
+		pins_keyboard {
+			pinmux = <PINMUX_GPIO91__FUNC_KPROW1>,
+				 <PINMUX_GPIO92__FUNC_KPROW0>,
+				 <PINMUX_GPIO93__FUNC_KPCOL0>;
+		};
+	};
+
 	mmc0_pins_default: mmc0-pins-default {
 		pins_cmd_dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,

-- 
b4 0.10.0-dev-54fef
