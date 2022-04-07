Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F241D4F81CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbiDGOfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbiDGOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA12A1AE3E6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so11192098ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+dTwnak9vn0Xq/FNz7L5Lta8DfZbbUxVcVeUYhy0Oo=;
        b=CcHwGJqutkt9xFzWyqxJM70FnzyOTsFK1P2Ajf0cw1xArfZnT+jFIf3XoZDuaaUsDi
         /apcNme277VjeqHtzHsaxiwQnmIU12CfskFIvbJ6Ia2BTu3IHwhD1lYxcmk9xUB9m9LX
         3RA4zjh/mOk6oG06kWsOkRCHDcbw5D4IHG2209yRubhiWF6CPuSSInCg91Vn0IDNhP/i
         DXsypQiRSHkfgPCQjhd2szP9WiRdSM4vQM6+JbqEeKwZ53mLz6LxU8lXGif1nhVsXVFI
         CJGFwawBqbYvA82ltKgH23szroEwi66E18/VfM+VoCwzC5kiAWSptGZDGWgLj5g3HhqG
         Fwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/+dTwnak9vn0Xq/FNz7L5Lta8DfZbbUxVcVeUYhy0Oo=;
        b=lTPMZ3PDz+SKc3+Mjk7afwsKI1td5sZU/pnAcKkpvukRoMYJlGUXm4skgx0ZrSOEkM
         NVDQfpRzG1dFXJMjEVfsemGZR6PN7FnU5yRUzAu2JscIzyaQ9eadpuuGu1vj5DzZz63P
         NtToO8gFL6++rBMTorXfgNI86UEwSK4H/IvIjAKDwLPZ3LxeEwcrtQyTcPvGmE5aR/UL
         cOe8MmoW8VOWyDd9ClCZhrEFCQmPEft5OjnaFgs0wzC+YKPycprAoVAK4M68pBSBEkkE
         ovV/1h1Vs3IRYwJ31gUm3jSVczwoaplz4NmPWvGxWPSfiu/QqYeU5ihzijmFTakTtWmY
         GPiQ==
X-Gm-Message-State: AOAM531cjr1CMy3Jfm3qLOCqgeDYf6JtKnItvZX90YFhEMXsyohAeMf+
        AyePGF3EeLOlw4baXVq99yYgGw==
X-Google-Smtp-Source: ABdhPJze2fb9+zsAnj+RWb893ds/Vq/BzND6U45VxtLiOdlTgL/zprJsduE9htbrMAZrWNr221+wog==
X-Received: by 2002:a17:906:60d4:b0:6db:f0a8:f39e with SMTP id f20-20020a17090660d400b006dbf0a8f39emr13614119ejk.54.1649341956856;
        Thu, 07 Apr 2022 07:32:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hu8-20020a170907a08800b006dfd2056ab2sm7714034ejc.97.2022.04.07.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:36 -0700 (PDT)
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
Subject: [PATCH 1/2] ARM: dts: marvell: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:32:33 +0200
Message-Id: <20220407143234.295426-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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
 arch/arm/boot/dts/armada-370-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts         | 2 +-
 arch/arm/boot/dts/armada-375-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-381-netgear-gs110emx.dts        | 2 +-
 arch/arm/boot/dts/armada-385-atl-x530.dts                | 2 +-
 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi           | 2 +-
 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts          | 2 +-
 arch/arm/boot/dts/armada-385-db-ap.dts                   | 2 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts          | 2 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts            | 2 +-
 arch/arm/boot/dts/armada-388-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-388-gp.dts                      | 2 +-
 arch/arm/boot/dts/armada-388-rd.dts                      | 2 +-
 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi      | 2 +-
 arch/arm/boot/dts/armada-390-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-398-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                | 2 +-
 arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts         | 2 +-
 arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi            | 2 +-
 arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts        | 2 +-
 arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi           | 2 +-
 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts     | 2 +-
 arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi        | 2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts                 | 2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts           | 2 +-
 arch/arm/boot/dts/dove-cubox.dts                         | 2 +-
 arch/arm/boot/dts/dove-d2plug.dts                        | 2 +-
 arch/arm/boot/dts/dove-d3plug.dts                        | 2 +-
 arch/arm/boot/dts/dove-dove-db.dts                       | 2 +-
 arch/arm/boot/dts/kirkwood-dir665.dts                    | 2 +-
 arch/arm/boot/dts/kirkwood-synology.dtsi                 | 2 +-
 36 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 77261a2fb949..a7dc4c04d10b 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -203,7 +203,7 @@ &spi0 {
 	pinctrl-names = "default";
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "mx25l25635e", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index a624b2371fb6..0abac5ffe45a 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -159,7 +159,7 @@ &spi0 {
 	pinctrl-0 = <&spi0_pins2>;
 	pinctrl-names = "default";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		/* MX25L8006E */
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 64f2ce254fb6..e72b8ed4b997 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -258,7 +258,7 @@ fan_alarm_pin: fan-alarm-pin {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q064", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 0e679465cbb5..4c4092790a20 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -64,7 +64,7 @@ &spi0 {
 
 	status = "disabled";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "n25q128a13", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts b/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
index 0a961116a1f9..396172067f6a 100644
--- a/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
+++ b/arch/arm/boot/dts/armada-381-netgear-gs110emx.dts
@@ -242,7 +242,7 @@ &spi0 {
 	pinctrl-names = "default";
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dts/armada-385-atl-x530.dts
index ed3f41c7df71..241f5d7c80e9 100644
--- a/arch/arm/boot/dts/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
@@ -168,7 +168,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 
-	spi-flash@1 {
+	flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
index 624bbcae68c0..10ad46f29393 100644
--- a/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
@@ -365,7 +365,7 @@ &spi1 {
 	pinctrl-names = "default";
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "w25q32", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
index 7881df3b28a0..389d9c75d546 100644
--- a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -126,7 +126,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index 0e4613bb56ee..332f8fce77dc 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -192,7 +192,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p128", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
index d8769956cbfc..2622af73c9da 100644
--- a/arch/arm/boot/dts/armada-385-synology-ds116.dts
+++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
@@ -223,7 +223,7 @@ &spi0 {
 	pinctrl-0 = <&spi0_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "macronix,mx25l6405d", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index f240018148f6..c9ff3f8c5e58 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -485,7 +485,7 @@ &spi0 {
 	pinctrl-0 = <&spi0_pins &spi0cs0_pins>;
 	status = "okay";
 
-	spi-nor@0 {
+	flash@0 {
 		compatible = "spansion,s25fl164k", "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index a2bec07bf4c5..5130eccc32af 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -133,7 +133,7 @@ pcie@2,0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "w25q32", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 9d873257ac45..e2ba50520b6b 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -395,7 +395,7 @@ &spi0 {
 	pinctrl-0 = <&spi0_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p128", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index 328a4d6afd2c..c0efafd45b33 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -97,7 +97,7 @@ pcie@1,0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p128", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
index 363ac4238859..2c64bc6e5a17 100644
--- a/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
+++ b/arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
@@ -101,7 +101,7 @@ &spi1 {
 	/* The microsom has an optional W25Q32 on board, connected to CS0 */
 	pinctrl-0 = <&spi1_pins>;
 
-	w25q32: spi-flash@0 {
+	w25q32: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "w25q32", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-390-db.dts b/arch/arm/boot/dts/armada-390-db.dts
index 0e29474ae9a2..792d0a0184e8 100644
--- a/arch/arm/boot/dts/armada-390-db.dts
+++ b/arch/arm/boot/dts/armada-390-db.dts
@@ -81,7 +81,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	pinctrl-names = "default";
 
-	spi-flash@1 {
+	flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "n25q128a13",
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
index fc28308e5bc5..ec6cdbeedde7 100644
--- a/arch/arm/boot/dts/armada-398-db.dts
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -79,7 +79,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	pinctrl-names = "default";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "n25q128a13", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 606fd3476a59..3e77b4337802 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -134,7 +134,7 @@ phy_int_pin: phy-int-pin {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "n25q128a13", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts b/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
index a022c68dc943..c28e140b4afc 100644
--- a/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
+++ b/arch/arm/boot/dts/armada-xp-crs305-1g-4s-bit.dts
@@ -15,7 +15,7 @@ / {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi b/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
index 32fb21b2bf6a..47b003a81bd4 100644
--- a/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
+++ b/arch/arm/boot/dts/armada-xp-crs305-1g-4s.dtsi
@@ -80,7 +80,7 @@ &usb0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts b/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
index 21f442afab1f..20ba5c823bb2 100644
--- a/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
+++ b/arch/arm/boot/dts/armada-xp-crs326-24g-2s-bit.dts
@@ -15,7 +15,7 @@ / {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi b/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
index f3e1a25ca5f2..cab99d8e2911 100644
--- a/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
+++ b/arch/arm/boot/dts/armada-xp-crs326-24g-2s.dtsi
@@ -80,7 +80,7 @@ &usb0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts b/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
index e05aee6cdc04..2caa3980fdf6 100644
--- a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
+++ b/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s-bit.dts
@@ -15,7 +15,7 @@ / {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi b/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi
index c8b1355ce15e..7028482ce4b2 100644
--- a/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi
+++ b/arch/arm/boot/dts/armada-xp-crs328-4c-20s-4s.dtsi
@@ -80,7 +80,7 @@ &usb0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
index 8a3aa616bbd0..02bef8dc4270 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -93,7 +93,7 @@ &sdio {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p64";
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 4ec0ae01b61d..d1b61dad0c46 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -89,7 +89,7 @@ nand@0 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p64";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 5d04dc68cf57..75318fd0fc11 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -235,7 +235,7 @@ phy3: ethernet-phy@3 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "m25p64", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index b4cca507cf13..d1d348b91c0a 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -220,7 +220,7 @@ phy3: ethernet-phy@3 {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "n25q128a13", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 8480a16919a0..36932e3b781a 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -255,7 +255,7 @@ gpio_fan_pin: gpio-fan-pin {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "everspin,mr25h256";
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 809e821d7399..5551bac1962c 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -274,7 +274,7 @@ fan2_alarm_pin: fan2-alarm-pin {
 &spi0 {
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q064", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/dove-cubox.dts b/arch/arm/boot/dts/dove-cubox.dts
index 3e1584e787ae..2639b9fe0ab4 100644
--- a/arch/arm/boot/dts/dove-cubox.dts
+++ b/arch/arm/boot/dts/dove-cubox.dts
@@ -127,7 +127,7 @@ &spi0 {
 	status = "okay";
 
 	/* spi0.0: 4M Flash Winbond W25Q32BV */
-	spi-flash@0 {
+	flash@0 {
 		compatible = "st,w25q32";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/dove-d2plug.dts b/arch/arm/boot/dts/dove-d2plug.dts
index 273f12ca2512..a0e8996c2ffd 100644
--- a/arch/arm/boot/dts/dove-d2plug.dts
+++ b/arch/arm/boot/dts/dove-d2plug.dts
@@ -62,7 +62,7 @@ &spi0 {
 	status = "okay";
 
 	/* spi0.0: 4M Flash Macronix MX25L3205D */
-	spi-flash@0 {
+	flash@0 {
 		compatible = "st,m25l3205d";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/dove-d3plug.dts b/arch/arm/boot/dts/dove-d3plug.dts
index 826026c28f90..1e81d1b97055 100644
--- a/arch/arm/boot/dts/dove-d3plug.dts
+++ b/arch/arm/boot/dts/dove-d3plug.dts
@@ -79,7 +79,7 @@ &spi0 {
 	status = "okay";
 
 	/* spi0.0: 2M Flash Macronix MX25L1605D */
-	spi-flash@0 {
+	flash@0 {
 		compatible = "st,m25l1605d";
 		spi-max-frequency = <86000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/dove-dove-db.dts b/arch/arm/boot/dts/dove-dove-db.dts
index 1754a62e014e..c1912dc6bfc3 100644
--- a/arch/arm/boot/dts/dove-dove-db.dts
+++ b/arch/arm/boot/dts/dove-dove-db.dts
@@ -27,7 +27,7 @@ &spi0 {
 	status = "okay";
 
 	/* spi0.0: 4M Flash ST-M25P32-VMF6P */
-	spi-flash@0 {
+	flash@0 {
 		compatible = "st,m25p32";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index b3ad3f607d31..c32300611d2c 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -78,7 +78,7 @@ pmx_btn_wps: pmx-btn-wps {
 
 		spi@10600 {
 			status = "okay";
-			m25p80@0 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "mxicy,mx25l12805d", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index 217bd374e52b..8f6c387d3a8b 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -198,7 +198,7 @@ rtc@10300 {
 		spi@10600 {
 			status = "okay";
 
-			m25p80@0 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "st,m25p80", "jedec,spi-nor";
-- 
2.32.0

