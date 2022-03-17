Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F534DC515
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiCQL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiCQL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:57:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933561E5A61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:55:52 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C7CAA3F4C1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518150;
        bh=NNkRDkWPiveTHGJJVi4+4/ORT85T+y0AcSaoWSMmS+o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OX8zauacky3oRLsDVfqWe8xxFJXFv7PNAwHvpsqe3kSBUnUZ71f5lCHNrUqiNgwWu
         eBZWUqylZD0snULESvcnHISMvW+3HAYvYT+UUKjbwaPZeeqPtQsZBCCVKGB6jVaARc
         c3uKLPbMnE1DVm4ECGzdPkmOMfgikQeIyptst08QaivIIgO9Z4WxIOhPKJYL9I8P1v
         ML7ort4c8/p1TrtCeCw8FTRwXYb2LUtCodl/QULjJ92QyLhgWqcV7fP/afDixRNR8f
         1XZKp4eCw2EHK0+9to+7U/2qVdhix0kzPyderXWg88WkA/15L4dHtjT8/NfSH1BRFC
         1w0tB5CPJTR9w==
Received: by mail-wr1-f72.google.com with SMTP id q4-20020adfc504000000b00203e15159e8so1350795wrf.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNkRDkWPiveTHGJJVi4+4/ORT85T+y0AcSaoWSMmS+o=;
        b=OUTOx4OdmlNyfMEkwuZJcHaCeMS303ySODD5bhMIAUJWrire7DNUAAzf6xFcphEsPI
         8UxyWebaoXr6xUnPH5NvmLw/mMgKXtQA2l/fJ3JGAgRKxdEOt8Xf3tkAnRBXUznRl3Yi
         ujcmd02cAYtdtdw1QvImOrbx9g8BGRgvkyw1L8arwP0mpbjf928xe8qKj33MG31RIuwV
         Trgv0OFBRxNTx4CMrO7pNccAzwE2TYAtbQ5ABGrBPOIxjiNl+MPq2vXuNYSv3J1g5v2l
         1P9BfywUvvlUPwcXhztKakjEg5X5zOMnkYb0i+RmyaI7LU3b9W2zsEUPIi6rqEt9bpmj
         HJ4Q==
X-Gm-Message-State: AOAM5304DsrL/ZqzwOiOBl6IGadortB8QZKLI0P6y2pzcDxBKa1MA7lC
        O/jlrFZS36rSWyakaHnI3YZyYk9uhBNaHoDY2tdGvDYH7f1K8vQ/Y7jQ8UdDeA9F4gFeEHMvlml
        MRvGyqa99qlpg1AaxuiHbzCt2XeU61Q2b63gVZsI/6w==
X-Received: by 2002:adf:e7c2:0:b0:203:e177:f93f with SMTP id e2-20020adfe7c2000000b00203e177f93fmr3811102wrn.671.1647518149323;
        Thu, 17 Mar 2022 04:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzluksm2ijGbV1ETbB+BHuJenpk8meaKL2FHMzBNsHmttg1+/DKcyqO/YoDEeWrnQIt4k8a0g==
X-Received: by 2002:adf:e7c2:0:b0:203:e177:f93f with SMTP id e2-20020adfe7c2000000b00203e177f93fmr3811087wrn.671.1647518149108;
        Thu, 17 Mar 2022 04:55:49 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b0038995cb915fsm11462862wms.9.2022.03.17.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:55:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 01/18] ARM: dts: nspire: use lower case hex addresses in node unit addresses
Date:   Thu, 17 Mar 2022 12:55:25 +0100
Message-Id: <20220317115542.450032-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all hex addresses in node unit addresses to lower case to fix
dt_binding_check and dtc W=1 warnings.

Conversion was done using sed:

  $ sed -e 's/@\([a-zA-Z0-9_-]*\) {/@\L\1 {/' -i arch/arm/boot/dts/nspire*
  $ sed -e 's/<0x\([a-zA-Z0-9_-]*\) /<0x\L\1 /g' -i arch/arm/boot/dts/nspire*

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/nspire-classic.dtsi | 10 ++---
 arch/arm/boot/dts/nspire-cx.dts       |  4 +-
 arch/arm/boot/dts/nspire.dtsi         | 60 +++++++++++++--------------
 3 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/nspire-classic.dtsi b/arch/arm/boot/dts/nspire-classic.dtsi
index 41744cc2bc72..01e1bb7c3c6c 100644
--- a/arch/arm/boot/dts/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire-classic.dtsi
@@ -17,7 +17,7 @@ clcd_pads: endpoint {
 
 &fast_timer {
 	/* compatible = "lsi,zevio-timer"; */
-	reg = <0x90010000 0x1000>, <0x900A0010 0x8>;
+	reg = <0x90010000 0x1000>, <0x900a0010 0x8>;
 };
 
 &uart {
@@ -30,12 +30,12 @@ &uart {
 
 &timer0 {
 	/* compatible = "lsi,zevio-timer"; */
-	reg = <0x900C0000 0x1000>, <0x900A0018 0x8>;
+	reg = <0x900c0000 0x1000>, <0x900a0018 0x8>;
 };
 
 &timer1 {
 	compatible = "lsi,zevio-timer";
-	reg = <0x900D0000 0x1000>, <0x900A0020 0x8>;
+	reg = <0x900d0000 0x1000>, <0x900a0020 0x8>;
 };
 
 &keypad {
@@ -66,10 +66,10 @@ ahb {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		intc: interrupt-controller@DC000000 {
+		intc: interrupt-controller@dc000000 {
 			compatible = "lsi,zevio-intc";
 			interrupt-controller;
-			reg = <0xDC000000 0x1000>;
+			reg = <0xdc000000 0x1000>;
 			#interrupt-cells = <1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 0c16b04e2744..590b7dff6ae5 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -92,10 +92,10 @@ ahb {
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		intc: interrupt-controller@DC000000 {
+		intc: interrupt-controller@dc000000 {
 			compatible = "arm,pl190-vic";
 			interrupt-controller;
-			reg = <0xDC000000 0x1000>;
+			reg = <0xdc000000 0x1000>;
 			#interrupt-cells = <1>;
 		};
 
diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 90e033d9141f..bb240e6a3a6f 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -20,9 +20,9 @@ bootrom: bootrom@0 {
 		reg = <0x00000000 0x80000>;
 	};
 
-	sram: sram@A4000000 {
+	sram: sram@a4000000 {
 		device = "memory";
-		reg = <0xA4000000 0x20000>;
+		reg = <0xa4000000 0x20000>;
 	};
 
 	timer_clk: timer_clk {
@@ -33,12 +33,12 @@ timer_clk: timer_clk {
 
 	base_clk: base_clk {
 		#clock-cells = <0>;
-		reg = <0x900B0024 0x4>;
+		reg = <0x900b0024 0x4>;
 	};
 
 	ahb_clk: ahb_clk {
 		#clock-cells = <0>;
-		reg = <0x900B0024 0x4>;
+		reg = <0x900b0024 0x4>;
 		clocks = <&base_clk>;
 	};
 
@@ -71,28 +71,28 @@ ahb {
 		#size-cells = <1>;
 		ranges;
 
-		spi: spi@A9000000 {
-			reg = <0xA9000000 0x1000>;
+		spi: spi@a9000000 {
+			reg = <0xa9000000 0x1000>;
 		};
 
-		usb0: usb@B0000000 {
+		usb0: usb@b0000000 {
 			compatible = "lsi,zevio-usb";
-			reg = <0xB0000000 0x1000>;
+			reg = <0xb0000000 0x1000>;
 			interrupts = <8>;
 
 			usb-phy = <&usb_phy>;
 			vbus-supply = <&vbus_reg>;
 		};
 
-		usb1: usb@B4000000 {
-			reg = <0xB4000000 0x1000>;
+		usb1: usb@b4000000 {
+			reg = <0xb4000000 0x1000>;
 			interrupts = <9>;
 			status = "disabled";
 		};
 
-		lcd: lcd@C0000000 {
+		lcd: lcd@c0000000 {
 			compatible = "arm,pl111", "arm,primecell";
-			reg = <0xC0000000 0x1000>;
+			reg = <0xc0000000 0x1000>;
 			interrupts = <21>;
 
 			/*
@@ -105,17 +105,17 @@ lcd: lcd@C0000000 {
 			clock-names = "clcdclk", "apb_pclk";
 		};
 
-		adc: adc@C4000000 {
-			reg = <0xC4000000 0x1000>;
+		adc: adc@c4000000 {
+			reg = <0xc4000000 0x1000>;
 			interrupts = <11>;
 		};
 
-		tdes: crypto@C8010000 {
-			reg = <0xC8010000 0x1000>;
+		tdes: crypto@c8010000 {
+			reg = <0xc8010000 0x1000>;
 		};
 
-		sha256: crypto@CC000000 {
-			reg = <0xCC000000 0x1000>;
+		sha256: crypto@cc000000 {
+			reg = <0xcc000000 0x1000>;
 		};
 
 		apb@90000000 {
@@ -143,16 +143,16 @@ uart: serial@90020000 {
 				interrupts = <1>;
 			};
 
-			timer0: timer@900C0000 {
-				reg = <0x900C0000 0x1000>;
+			timer0: timer@900c0000 {
+				reg = <0x900c0000 0x1000>;
 				clocks = <&timer_clk>, <&timer_clk>,
 					 <&timer_clk>;
 				clock-names = "timer0clk", "timer1clk",
 					      "apb_pclk";
 			};
 
-			timer1: timer@900D0000 {
-				reg = <0x900D0000 0x1000>;
+			timer1: timer@900d0000 {
+				reg = <0x900d0000 0x1000>;
 				interrupts = <19>;
 				clocks = <&timer_clk>, <&timer_clk>,
 					 <&timer_clk>;
@@ -171,18 +171,18 @@ rtc: rtc@90090000 {
 				interrupts = <4>;
 			};
 
-			misc: misc@900A0000 {
-				reg = <0x900A0000 0x1000>;
+			misc: misc@900a0000 {
+				reg = <0x900a0000 0x1000>;
 			};
 
-			pwr: pwr@900B0000 {
-				reg = <0x900B0000 0x1000>;
+			pwr: pwr@900b0000 {
+				reg = <0x900b0000 0x1000>;
 				interrupts = <15>;
 			};
 
-			keypad: input@900E0000 {
+			keypad: input@900e0000 {
 				compatible = "ti,nspire-keypad";
-				reg = <0x900E0000 0x1000>;
+				reg = <0x900e0000 0x1000>;
 				interrupts = <16>;
 
 				scan-interval = <1000>;
@@ -191,8 +191,8 @@ keypad: input@900E0000 {
 				clocks = <&apb_pclk>;
 			};
 
-			contrast: contrast@900F0000 {
-				reg = <0x900F0000 0x1000>;
+			contrast: contrast@900f0000 {
+				reg = <0x900f0000 0x1000>;
 			};
 
 			led: led@90110000 {
-- 
2.32.0

