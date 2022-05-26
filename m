Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC85354AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiEZUlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348752AbiEZUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:41:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A232E2758
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:40:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f21so5035407ejh.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqhBoLtTEqtC8SyTJYD8D3FCPQDdwFN33ubMEAOxADA=;
        b=klhTqkkBjZyyKz+geuEig4N438/PxZQ/zSYVKjOQWVE63SWsAaH54JHjaeLTd8Z1+L
         Xpup8sZb0TTCmS0WHy1GGT0yIZ6eP/qkypf4RDPFgB1Hy6M2iPXO/h4fHFbRDqlBZzrj
         56EWK8A0soyJck4ID7w0gkqr7OcT+ZVV6V4m5NsAlnwg1wx9P/PLAYgh1wvHjPJJjYq0
         k2jqM+pbMF5WaDDbV4+k2CLOHC+q3i+lQDQy3ZKuUa9I0nApipuQIQIhcTlc/IxeEysk
         L1atKlUDrU0KmSEOjeh2lk6spoHkSB0PAH/wpOL15MvWMhnDS9+8pKH8lUfv6lM9SVBe
         gcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqhBoLtTEqtC8SyTJYD8D3FCPQDdwFN33ubMEAOxADA=;
        b=BuCLPRhZPkwFsvZKjqbySYtwFLxwCljUp0NWpuNFDwmpIYylGn+bAOBb0nJtGccA3c
         jzqgXX0ig0VExqoLHXwdawW6po7g8+YErUfU7akGndboSofTmLSjassTHmQuFGm7xswq
         nf4sTbPJiUpVKoVInMkVscl0oNJqJWUy3FP6H0/cqbycME3Vxpy7WVUuFNzf/qlxfdSs
         upimzHwHkNqZxvZf5uAXH+vYWdUmySEfSo4Oe0YPtmlgIVoIt9g1tykjyxFB9rDIwTQZ
         CcpO8BPsCRkIVX+ToE96IEqB6aOAcWgpCVofCxIttICu+MKvPcnwlxlQfQTVH8x4Ygju
         P9Ig==
X-Gm-Message-State: AOAM533RJzA99njB9bsgwiIhSNOwl+AGBLmdaeMqKozzdKJb0662PL5L
        S8QDcv9ykm/7oYwBM6ihPXiErA==
X-Google-Smtp-Source: ABdhPJz01ojWcoqHShRpJ9jXwcNEqh7yWxJDa0rGnMF9Xm3ORBLS6PhyZAenvDbuZhG78ZdanV4IWw==
X-Received: by 2002:a17:907:9805:b0:6f4:fe0e:5547 with SMTP id ji5-20020a170907980500b006f4fe0e5547mr34631737ejc.426.1653597656769;
        Thu, 26 May 2022 13:40:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q9-20020a50cc89000000b0042ac2705444sm1200203edi.58.2022.05.26.13.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:40:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: omap: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:40:44 +0200
Message-Id: <20220526204044.831656-1-krzysztof.kozlowski@linaro.org>
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/omap2420-h4.dts           | 2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts        | 2 +-
 arch/arm/boot/dts/omap3-evm.dts             | 2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi          | 2 +-
 arch/arm/boot/dts/omap3-igep.dtsi           | 2 +-
 arch/arm/boot/dts/omap3-ldp.dts             | 6 +++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-n900.dts            | 4 ++--
 arch/arm/boot/dts/omap3-n950-n9.dtsi        | 4 ++--
 arch/arm/boot/dts/omap3-overo-base.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
 arch/arm/boot/dts/omap3430-sdp.dts          | 6 +++---
 arch/arm/boot/dts/omap5-l4.dtsi             | 2 +-
 13 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index af964f139abf..5acf5dd87c59 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -21,7 +21,7 @@ &gpmc {
 
 	nor@0,0 {
 		compatible = "cfi-flash";
-		linux,mtd-name= "intel,ge28f256l18b85";
+		linux,mtd-name = "intel,ge28f256l18b85";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0 0 0x04000000>;
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index c9332195d096..abd403c228c7 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -60,7 +60,7 @@ nand@0,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name= "hynix,h8kds0un0mer-4em";
+		linux,mtd-name = "hynix,h8kds0un0mer-4em";
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 5cc0cf7cd16c..f95eea63b355 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -60,7 +60,7 @@ nand@0,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name= "micron,mt29f2g16abdhc";
+		linux,mtd-name = "micron,mt29f2g16abdhc";
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 0365f06165e9..28a6a9345be5 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -127,7 +127,7 @@ lcd: td028ttec1@0 {
 			spi-cpol;
 			spi-cpha;
 
-			backlight= <&backlight>;
+			backlight = <&backlight>;
 			label = "lcd";
 			port {
 				lcd_in: endpoint {
diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 99f5585097a1..219202610463 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -111,7 +111,7 @@ nand@0,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name= "micron,mt29c4g96maz";
+		linux,mtd-name = "micron,mt29c4g96maz";
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 9c6a92724590..36fc8805e0c1 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -103,7 +103,7 @@ nand@0,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name= "micron,nand";
+		linux,mtd-name = "micron,nand";
 		nand-bus-width = <16>;
 		gpmc,device-width = <2>;
 		ti,nand-ecc-opt = "bch8";
@@ -215,11 +215,11 @@ &mmc1 {
 };
 
 &mmc2 {
-	status="disabled";
+	status = "disabled";
 };
 
 &mmc3 {
-	status="disabled";
+	status = "disabled";
 };
 
 &omap3_pmx_core {
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 73d477898ec2..c595afe4181d 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -372,7 +372,7 @@ nand@0,0 {
 		gpmc,device-width = <2>;
 		gpmc,wait-pin = <0>;
 		gpmc,wait-monitoring-ns = <0>;
-		gpmc,burst-length= <4>;
+		gpmc,burst-length = <4>;
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <100>;
 		gpmc,cs-wr-off-ns = <100>;
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index d40c3d2c4914..dd7971556449 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -568,8 +568,8 @@ MATRIX_KEY(0x07, 0x02, KEY_F8)
 };
 
 &twl_gpio {
-	ti,pullups	= <0x0>;
-	ti,pulldowns	= <0x03ff3f>; /* BIT(0..5) | BIT(8..17) */
+	ti,pullups = <0x0>;
+	ti,pulldowns = <0x03ff3f>; /* BIT(0..5) | BIT(8..17) */
 };
 
 &i2c2 {
diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 7dde9fbb06d3..f68da828b050 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -162,8 +162,8 @@ twl_power: power {
 };
 
 &twl_gpio {
-	ti,pullups	= <0x000001>; /* BIT(0) */
-	ti,pulldowns	= <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
+	ti,pullups = <0x000001>; /* BIT(0) */
+	ti,pulldowns = <0x008106>; /* BIT(1) | BIT(2) | BIT(8) | BIT(15) */
 };
 
 &vdac {
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 006a6d97231c..adc714c39825 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -222,7 +222,7 @@ &gpmc {
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
-		linux,mtd-name= "micron,mt29c4g96maz";
+		linux,mtd-name = "micron,mt29c4g96maz";
 		reg = <0 0 4>;	/* CS0, offset 0, IO size 4 */
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 37608af6c07f..559853764487 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -666,7 +666,7 @@ tsc2046@0 {
 
 	lcd: lcd@1 {
 		reg = <1>;	/* CS1 */
-		compatible =	"tpo,td043mtea1";
+		compatible = "tpo,td043mtea1";
 		spi-max-frequency = <100000>;
 		spi-cpol;
 		spi-cpha;
diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
index 7d530ae3483b..258ecd9e4519 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -53,7 +53,7 @@ &gpmc {
 
 	nor@0,0 {
 		compatible = "cfi-flash";
-		linux,mtd-name= "intel,pf48f6000m0y1be";
+		linux,mtd-name = "intel,pf48f6000m0y1be";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0 0 0x08000000>;
@@ -105,7 +105,7 @@ nand@1,0 {
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
-		linux,mtd-name= "micron,mt29f1g08abb";
+		linux,mtd-name = "micron,mt29f1g08abb";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ti,nand-ecc-opt = "sw";
@@ -148,7 +148,7 @@ partition@780000 {
 	};
 
 	onenand@2,0 {
-		linux,mtd-name= "samsung,kfm2g16q2m-deb8";
+		linux,mtd-name = "samsung,kfm2g16q2m-deb8";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "ti,omap2-onenand";
diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
index 06cc3a19ddaa..3b505fe415ed 100644
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -482,7 +482,7 @@ usb3_phy: usb3phy@4400 {
 				clocks = <&usb_phy_cm_clk32k>,
 				<&sys_clkin>,
 				<&l3init_clkctrl OMAP5_USB_OTG_SS_CLKCTRL 8>;
-				clock-names =	"wkupclk",
+				clock-names = "wkupclk",
 				"sysclk",
 				"refclk";
 				#phy-cells = <0>;
-- 
2.34.1

