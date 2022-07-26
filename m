Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561915813A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiGZM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbiGZM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:56:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC225C78
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso8099042wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:cc;
        bh=Pv8Wb/XUfgDvlUBb7xZCItYlnc14Qbd8klbk0fBR/cI=;
        b=JQC0LDeiyCTONLO9wJzCR3DZayr2OeSY97UtihVtK2Bg//mORTzwXNPQ+3bZvguNmQ
         G8HgNDfEkkPic2mCzlej2yTg5sJBWpWQOKJW4hmFNVLOtUNlTHZLmvnLaYTGO57swON9
         JnMb07hRleek6DOVe9ppMcxjCwr4KlqQ5aYSfJsjWJ43VFGGsOTp1NkHXUuBaFtIwwkt
         /bgJS8DYAK1Zn8Fw53JRW+sZoWXXjJs3uWAfYWySQg+Yc5Wpnwa6Ee7Xuue3cpQ89FD+
         e5reycwqnH7QxWvpijS7glQJuXIBJEVn4DgeAUml+0SWnmHj/ADspwBVxwBwtXp/TTOc
         0OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:cc;
        bh=Pv8Wb/XUfgDvlUBb7xZCItYlnc14Qbd8klbk0fBR/cI=;
        b=JLYOgepiMOlsi7SPw7i+4HP5a8kjSvHZjIWUhGEZUAHfdlNkdNBk0tG/Jrr6mSRF57
         9y8JieWLbH2aG6toxB/Ne+vwnulGWc6FOt8j7q7B87eq9hV6FstAg4MmQk+qyB48AuDa
         ZTmPxt/rqIiCrU9DlVSPY13tBBVFppZ2TQ+Ur0oBwkJftxejK2vxArgIybOzS5vQMyGP
         iL3axUmB/N+PwBHlVH9dlj3YJ7AQk+75rIDRkGX8I93qzQFSED5HhIvFg1l2IUn8t+6d
         /fWUkZgF47NICsikn/Ibt9PeKGbpRVWKT9SYZVVFBv4U7vxE9BExcduyeVHmT101T70J
         0Shw==
X-Gm-Message-State: AJIora8pPWRrwaXKDp+Br9HSDM05Jx5C8WnHDYySQ3yun+hm+g0whuos
        s/8cID6ow8bKEiVmXi2Xxh6yvg==
X-Google-Smtp-Source: AGRyM1vvvRdQPmoQCB+VQgE8Mf8j6lPcMzabj6A5fEyQBKVFOEwxFB9YOwKu5xXK1jyzEiBm23752g==
X-Received: by 2002:a05:600c:19cc:b0:3a3:3cfe:d548 with SMTP id u12-20020a05600c19cc00b003a33cfed548mr12225185wmq.6.1658840196274;
        Tue, 26 Jul 2022 05:56:36 -0700 (PDT)
Received: from [192.168.2.253] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm14171549wrp.116.2022.07.26.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:56:35 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Tue, 26 Jul 2022 14:56:12 +0200
Subject: [PATCH v2 7/7] arm64: dts: mediatek: mt8183-pumpkin: add keypad support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v2-7-6d42c357cb76@baylibre.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
X-Mailer: b4 0.10.0-dev-78725
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
index 530e0c9ce0c9..a1d01639df30 100644
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
+	mediatek,keys-per-group = <2>;
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
b4 0.10.0-dev-78725
