Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96B4F81AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbiDGOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiDGOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:33:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24007196097
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:31:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l26so11294584ejx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8C/l+c7rN/9oypNyFTUladKOUHUvp21NDypCvhGm2q4=;
        b=F9cMEvcO/3YHOZi5Mlu0Ieq3d23E1QHISYZuxoCBlKB0p198wPw6IgRkFFKZrcgcBv
         wSCsyw2ecQqdqdlbhKj8HTNF5k03MkNco995AiKmR49EAIRRXtYI/1B5c2TPu7O/zBnp
         EMYjmwjBAjjFoWwqfr7rN/EBzn7lEHj+Lw3CW8cTRH3UXa1md6GctUdCqTYXsnQClqSA
         vylexUfLLypqCwbUHaO4nj/GxNISDxc9RyrZrZontMRQ5IE2Vi3PEE/BkATiqn29YQNb
         bPT9iv1z3mIMggK7oWTyt3VTJ5bzQe1GGMDclNoDPgmttYA4OwIXXWlVx+90UeMRdLAL
         4PZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8C/l+c7rN/9oypNyFTUladKOUHUvp21NDypCvhGm2q4=;
        b=udJpp7YzqlamMWVlFgPOfsX6CcS16AqJtxe6cMlyjEU/ruCsiYQibU4MsvdZSg3Fvp
         SjGu3H542ZhthL4QENMjqfsMAc/6wZTlpxWPRpvYX3WwsUqAhOLEcwtdCx2rjMyduEr6
         Dbl13CfQRpDaaenPjfAKt6fPchdBNSez6uHjD/R4ussjTFFEUtq5IwXaK3+huNzgTUX9
         DV2ZWmQKkdvU6iheB++4WiyXCWMvCBWwoS6hLAR3UA37DyyrDBiLbxi7NS/Orze6dQ/9
         igIZSuz5J8CMOI7Hid9HcysTcq8hfs2wnMi7SQbB/obaGCtU/ntDF2nWmtQteENjHzOi
         ypWQ==
X-Gm-Message-State: AOAM532aWuE3eff9bse8uzG3afgL+5Y+AIcmM1XswVmVmCQrdU7KdRiC
        NkJIXshWv5DcnjDAtBZHZMMsFg==
X-Google-Smtp-Source: ABdhPJxrLM0v90dlmVI0Ixso/QZrUBqMb64Q4CF7nuleSfOSGxUH9aWpOHeRH3s/TPpq/EqYrCZg2Q==
X-Received: by 2002:a17:907:3da1:b0:6e8:432c:3e5e with SMTP id he33-20020a1709073da100b006e8432c3e5emr842825ejc.532.1649341891472;
        Thu, 07 Apr 2022 07:31:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b25-20020a056402139900b0041904036ab1sm9345900edv.5.2022.04.07.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:31:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: nuvoton: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:31:27 +0200
Message-Id: <20220407143127.295008-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts            | 6 +++---
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts            | 2 +-
 arch/arm/boot/dts/nuvoton-npcm730-kudo.dts           | 6 +++---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts            | 8 ++++----
 arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts | 6 +++---
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
index eb6eb21cb2a4..d10669fcd527 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gbs.dts
@@ -358,7 +358,7 @@ &fiu0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0cs1_pins>;
 	status = "okay";
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -406,7 +406,7 @@ &fiu3 {
 	pinctrl-0 = <&spi3_pins>, <&spi3cs1_pins>;
 	status = "okay";
 
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -416,7 +416,7 @@ spi-nor@0 {
 		m25p,fast-read;
 		label = "pnor";
 	};
-	spi-nor@1 {
+	flash@1 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
index d4ff49939a3d..491606c4f044 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
@@ -135,7 +135,7 @@ &fiu0 {
 	pinctrl-0 = <&spi0cs1_pins>;
 	status = "okay";
 
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
index 82a104b2a65f..a0c2d7652625 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-kudo.dts
@@ -380,7 +380,7 @@ &fiu0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0cs1_pins>;
 	status = "okay";
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -415,7 +415,7 @@ rwfs@3d00000 {
 			};
 		};
 	};
-	spi-nor@1 {
+	flash@1 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -440,7 +440,7 @@ spare2@800000 {
 
 &fiu3 {
 	pinctrl-0 = <&spi3_pins>;
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 0334641f8829..3dad32834e5e 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -67,7 +67,7 @@ &ehci1 {
 
 &fiu0 {
 	status = "okay";
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -128,7 +128,7 @@ spare4@1300000 {
 &fiu3 {
 	pinctrl-0 = <&spi3_pins>, <&spi3quad_pins>;
 	status = "okay";
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -324,7 +324,7 @@ fan@7 {
 &spi0 {
 	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
 	status = "okay";
-	Flash@0 {
+	flash@0 {
 		compatible = "winbond,w25q128",
 		"jedec,spi-nor";
 		reg = <0x0>;
@@ -345,7 +345,7 @@ partition@1 {
 &spi1 {
 	cs-gpios = <&gpio0 20 GPIO_ACTIVE_LOW>;
 	status = "okay";
-	Flash@0 {
+	flash@0 {
 		compatible = "winbond,w25q128fw",
 		"jedec,spi-nor";
 		reg = <0x0>;
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts b/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
index 767e0ac0df7c..132e702281fc 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-runbmc-olympus.dts
@@ -100,7 +100,7 @@ &fiu0 {
 	pinctrl-0 = <&spi0cs1_pins>;
 	status = "okay";
 
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -139,7 +139,7 @@ rwfs@1d00000 {
 		};
 	};
 
-	spi-nor@1 {
+	flash@1 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -166,7 +166,7 @@ &fiu3 {
 	pinctrl-0 = <&spi3_pins>;
 	status = "okay";
 
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.32.0

