Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F251E4F81CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbiDGOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344088AbiDGOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF41AEC86
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dr20so11192205ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkWI14MHBWH9U8SSAEnziGPQBShD9+dmC2dsmZi1EzQ=;
        b=vjW72RL5zqh2RQ16glWeQc3hfQR8v+qaNLudwyk6NN3yUFRNAZr1+8amylH1gnlXMt
         5GMuGVhpWNPyONFOt0loTvmdRL/E0RTYc1Zm8uPlWZ+J8wQL9zpb/0Xbh4/JYBMurUJX
         ikxJLCKsfqIjXMOYo9NM/U+pRCJjk/wTQGEfXROjvfQW6SySuv4zNsOEgsfUF25Vl42r
         XzPX8FP0TohUVc1ce2rou3Erm84r1LaTWTzw0FFQ4G9J4VTzPvzTTsRWa0z0i0oYmaob
         t5t6fi5aUalbzXJQsC0Itb92x5nnY0U7eXl5TAcPkK/aTE9NqJV/IStbPtGhJsuZsHKn
         OUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkWI14MHBWH9U8SSAEnziGPQBShD9+dmC2dsmZi1EzQ=;
        b=Gk/WJuK82HvHFMevXPwPuz4Bg7ytxX0WoiILc0fQhD2UNRIyXLJc+8YaZZfElByFIu
         /g+Dtku0hsskX34OAtVg2BzuYwFGlOiDe/Pu3EJAprpjUVO/O/6Jwp9N2Hbn+yYOt5as
         3jGEkBWDtMvtE0XNVzu4IE41PvE4k5kP5l/Kud7EY2IYzSTdG7gNKMFP1HHH6vG2YMTs
         Nkv4aauhRcLu/N5oUalg7lsTcYxYfjvNk9vi6yE9HcZ7ebYummXP6LZ/Vzxf9AcKDOof
         YmRvUwkHejAHJz+leC/CMlsNz42WEI4TQUqPLWh2tzqvw1MqIWnVUKwSYsAyVkp2QVYK
         sfMw==
X-Gm-Message-State: AOAM53234OMTYq/UiQFSovWf/WowzXRhy2symI0j0eH147wrLsMLUl5a
        FdkTDDUkctbLpupsqAUJnAbvog==
X-Google-Smtp-Source: ABdhPJxpv4+LhLQSTsvpt9qR5jhJfnY0N8Dy4bQJaKxC6ZaN00HGFoj7AWmCRL07G7BIhEVb2YdXOg==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr13809645ejc.712.1649341957867;
        Thu, 07 Apr 2022 07:32:37 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hu8-20020a170907a08800b006dfd2056ab2sm7714034ejc.97.2022.04.07.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: marvell: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:32:34 +0200
Message-Id: <20220407143234.295426-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143234.295426-1-krzysztof.kozlowski@linaro.org>
References: <20220407143234.295426-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts             | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts     | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts           | 2 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 4 ++--
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 4 ++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 2 +-
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi                | 2 +-
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi                 | 2 +-
 arch/arm64/boot/dts/marvell/cn9131-db.dtsi                 | 2 +-
 12 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 3e5789f37206..bd4e61d5448e 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -164,7 +164,7 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_quad_pins>;
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <108000000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 1cee26479bfe..d665f742a7d5 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -211,7 +211,7 @@ &spi0 {
 	assigned-clock-parents = <&tbg 1>;
 	assigned-clock-rates = <20000000>;
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c..a4de8d00cf46 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -99,7 +99,7 @@ &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_quad_pins>;
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <54000000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index cd326fe224ce..5e5baf6beea4 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -83,7 +83,7 @@ &i2c0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
@@ -186,7 +186,7 @@ partition@1000000 {
 &cp0_spi1 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-max-frequency = <20000000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index f3b0d57a24a3..39a8e5e99d79 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -155,7 +155,7 @@ &cp0_spi1{
 	pinctrl-names = "default";
 	pinctrl-0 = <&cp0_spi1_pins>;
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 8729c6467303..871f84b4a6ed 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -589,7 +589,7 @@ &cp1_spi1 {
 	pinctrl-0 = <&cp1_spi1_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "st,w25q32";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index f2e8e0df8865..92897bd7e6cf 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -72,7 +72,7 @@ cp1_usb3_0_phy: cp1-usb3-0-phy {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
@@ -238,7 +238,7 @@ &cp1_i2c0 {
 &cp1_spi1 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-max-frequency = <20000000>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index adbfecc678b5..779cf167c33e 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -360,7 +360,7 @@ &cp1_spi1 {
 	pinctrl-0 = <&cp1_spi1_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "st,w25q32";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index dac85fa748de..74bed79e4f5e 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -185,7 +185,7 @@ rtc@32 {
 
 &spi0 {
 	status = "okay";
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index d9f9f2c19740..1acd746284dc 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -175,7 +175,7 @@ &cp0_spi1 {
 	      <0x2000000 0x1000000>;	/* CS0 */
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index c00b69b88bd2..7e20987253a3 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -310,7 +310,7 @@ &cp0_spi1 {
 	pinctrl-0 = <&cp0_spi0_pins>;
 	reg = <0x700680 0x50>;
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
index f995b1bcda01..b7fc241a228c 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
@@ -137,7 +137,7 @@ &cp1_spi1 {
 	pinctrl-0 = <&cp1_spi0_pins>;
 	reg = <0x700680 0x50>;
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
 		compatible = "jedec,spi-nor";
-- 
2.32.0

