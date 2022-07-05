Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7186567914
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiGEVCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiGEVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:02:01 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF017A98
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:01:58 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05A8D42448
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657054912;
        bh=AoMSkRbSsal7DXav6tHJCoGyFX+s+KqI3+R+nsluk4Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=r4ipIkMB/SfIsygquOfPs3RGoXlFuxrUuoUT/xoY4wzHC0oP0psVEqcic+0sQy63n
         7VFmKBOcU5gaDAyLdKAy20qo9yCy/o9Y/oy5VXJtnp5FD+NYNFhcRZjGDcUYeBQ8YF
         YNudFpllua1i7eOgz0HOVyavp6CNEjWR3zEqrPt5zxgweZ4km+MXZd3wx33LkRim0i
         2AQV3D1n1Q+Jr+3CIWjq6Gsdx6iKnPV8hKmI3oLZZDefihxfmB8PgR7ow7+nDHJJWl
         BbuAoz+etMxtQRdeJvcjIBnsokXzJ5q6eElOeqHIImfjN4eSGYP9EUwI3NmWWJvmjP
         oJVrzCm/bFY2w==
Received: by mail-wm1-f71.google.com with SMTP id j19-20020a05600c191300b003a048196712so7293948wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoMSkRbSsal7DXav6tHJCoGyFX+s+KqI3+R+nsluk4Y=;
        b=PU9ptF7Vz5SnMSL0T89DyDd6l4chYCslLzYszc4VDPxtGXIHWhUXHx8fy4vnxl2tR3
         s6wg8m28igtm6iF3yotEr7+Hk68G/A6jTmCkY3hm7UWJmyJXU0SOS16bq+sG2nqAoRqk
         GE09ofZQy6aDVMKOB6jwH9+f4ozoq48uThkvbdePlujqDUx9mPzAvw18sAQp7eNb5jTG
         9hXDIiBkWy1p9i6yoUeEIs2Q/TitDfCjdde/PgL4e+wCLEEXkvYiFlsLVZicCTGe8Nvq
         quiInUThZ/LtVmgZvU9WHG0kYjP9f9fOWxivegwBhlbgWG7XXOFxywtRQ+qWRIIYzISJ
         xjyw==
X-Gm-Message-State: AJIora+FULv4a4eWCejiyJl2bpESKjR0PSx2VKFTd+uL5iFJVoBVDnxN
        aPi21dZej1Rc4uDfr2tG4hRgSzQvFgHuYnlGQQFgQm8eDXP8wb9Uk/KfOgt07EsAK8D3aQZ39Tj
        i8EEZdbZKzDz9kVBH0UwvNzBZj9sgt2QeK0Ml/jgAWA==
X-Received: by 2002:a5d:64ad:0:b0:21b:b412:a34b with SMTP id m13-20020a5d64ad000000b0021bb412a34bmr34737448wrp.161.1657054910461;
        Tue, 05 Jul 2022 14:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1utl+vdlW/hT+y0u8P/5xgHHhGX/aEi5Iu3pv5PVf+eB3fFB+ZuQGqJZ0/RfxSFhjz/+hEgCA==
X-Received: by 2002:a5d:64ad:0:b0:21b:b412:a34b with SMTP id m13-20020a5d64ad000000b0021bb412a34bmr34737424wrp.161.1657054910311;
        Tue, 05 Jul 2022 14:01:50 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm2517667wru.28.2022.07.05.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:01:50 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 4/4] riscv: dts: sifive unmatched: Add PWM controlled LEDs
Date:   Tue,  5 Jul 2022 23:01:43 +0200
Message-Id: <20220705210143.315151-5-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the two PWM controlled LEDs to the HiFive Unmatched device
tree. D12 is just a regular green diode, but D2 is an RGB diode with 3
PWM inputs controlling the three different colours.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../boot/dts/sifive/hifive-unmatched-a00.dts  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index c4ed9efdff03..beaefe74755a 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -4,6 +4,8 @@
 #include "fu740-c000.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
 
 /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
 #define RTCCLK_FREQ		1000000
@@ -44,6 +46,46 @@ gpio-poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 	};
+
+	led-controller-1 {
+		compatible = "pwm-leds";
+
+		led-d12 {
+			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
+			active-low;
+			color = <LED_COLOR_ID_GREEN>;
+			max-brightness = <255>;
+			label = "d12";
+		};
+	};
+
+	led-controller-2 {
+		compatible = "pwm-leds-multicolor";
+
+		multi-led {
+			color = <LED_COLOR_ID_RGB>;
+			max-brightness = <255>;
+			label = "d2";
+
+			led-red {
+				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
+				active-low;
+				color = <LED_COLOR_ID_RED>;
+			};
+
+			led-green {
+				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
+				active-low;
+				color = <LED_COLOR_ID_GREEN>;
+			};
+
+			led-blue {
+				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
+				active-low;
+				color = <LED_COLOR_ID_BLUE>;
+			};
+		};
+	};
 };
 
 &uart0 {
-- 
2.37.0

