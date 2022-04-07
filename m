Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D414F819F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiDGOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiDGOce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:32:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40721192593
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:30:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x20so6595256edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zllbixT8uwwRAVX+QMa2CP3U9HgtcTg/FeMKsXjsUYM=;
        b=u6ATGlIv6X2WFKo3R1hVE/lTaoxaCg9Er9kklI3dOr/U/syEMPq5alKk5jKRLSoMz0
         J1ZJSvSIoN9sc//+nHCBPtYPO85jf7HtKRlDi6/+xycPUBMI2SL70ZUViNmFT21AZ4DJ
         6elP3inT+iiuIKDg3ER0qpTI1oXh3n/JciGaZu3NUGcXsCnP52+Fd0RcqClZkXxEce8l
         Tdrvr95CWJiNNqwFZuZ2zHGss0FyXg1bQbRB5zPrBLHMIYVpx3CnAaHdBCaFhNZD1gsa
         RzcQ7Hr7UKu1k9hwd0AOtLhQp9Q4FOhrST6VoIkOUXBaWI4WMReKUKkXb+V4KdbikNlc
         AE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zllbixT8uwwRAVX+QMa2CP3U9HgtcTg/FeMKsXjsUYM=;
        b=jXOHUZi32Zts8tQ4FEcQyrYhB/2z+oZX9DJev+HxS0E44vlpyNyhOk9C+J7BYuaJ4Q
         SUUKes81HS/sBTwtVwxhkFBrHwzOFHnA/7EzDs2XK6moAOgnQsBQpH3LRj6Q8dPiLpMd
         gGjNHIN5LX/pTBeRIvu6m4/5nMXr9MdGnGqaaK2bHuA9s6ZUhw6Huxp7rBZ/wYEH/oyM
         datfWMLczuiebHT9TVaxKENL26ofAfZ8PvrKS43oHgbJT9NoLJdUvGnKOQGbrKTjZB/6
         5FcRUk2SEScQ6rdwwsPzS2bYpbBAhIlU7nhlUEnm1Jd96SPIkOwBU4NBOu968vCSGFrn
         tycQ==
X-Gm-Message-State: AOAM530E0kBDrxf7MFVFmPH3Ksss4UZ0w4UEZIIBgddYlgPOLMpKiliB
        mrWn9wpLOYsO2E2vXTXf6Bzk2g==
X-Google-Smtp-Source: ABdhPJylvMQfZo0mmKmPVZrTGayBO1CUslG2f0TvN0gV6Pn8PN9mNCoe3csN+n6Mvj9EGmyt5P+V2g==
X-Received: by 2002:a05:6402:350c:b0:419:3d18:7dd2 with SMTP id b12-20020a056402350c00b004193d187dd2mr14847093edd.148.1649341830705;
        Thu, 07 Apr 2022 07:30:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x9-20020a05640226c900b0041d015bb8a5sm1133039edd.26.2022.04.07.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:30:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:30:27 +0200
Message-Id: <20220407143027.294678-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/da850-evm.dts                  | 2 +-
 arch/arm/boot/dts/dm8168-evm.dts                 | 2 +-
 arch/arm/boot/dts/spear1310-evb.dts              | 2 +-
 arch/arm/boot/dts/spear1340-evb.dts              | 2 +-
 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 2 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts            | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 87c517d65f62..e9aecac4f5b5 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -278,7 +278,7 @@ &spi1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index 5126e2d72ed7..778796c10af8 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -177,7 +177,7 @@ &mcspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcspi1_pins>;
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "w25x32";
 		spi-max-frequency = <48000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 4cbadcb41084..ddd1cf4d0554 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -379,7 +379,7 @@ stmpe_touchscreen {
 					};
 				};
 
-				m25p80@1 {
+				flash@1 {
 					compatible = "st,m25p80";
 					reg = <1>;
 					spi-max-frequency = <12000000>;
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index fd194ebeedc9..3a51a41eb5e4 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -439,7 +439,7 @@ spi0: spi@e0100000 {
 				cs-gpios = <&gpiopinctrl 80 0>, <&gpiopinctrl 24 0>,
 					   <&gpiopinctrl 85 0>;
 
-				m25p80@0 {
+				flash@0 {
 					compatible = "m25p80";
 					reg = <0>;
 					spi-max-frequency = <12000000>;
diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
index 33ae5e0590df..ac53ee3c496b 100644
--- a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
@@ -398,7 +398,7 @@ &qspi {
 	#size-cells = <0>;
 	status = "okay";
 
-	flash0: is25lp016d@0 {
+	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <133000000>;
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index e222d2d2cb44..d142dd30e16b 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -262,7 +262,7 @@ &qspi {
 	#size-cells = <0>;
 	status = "okay";
 
-	flash0: mx66l51235l@0 {
+	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-rx-bus-width = <4>;
@@ -271,7 +271,7 @@ flash0: mx66l51235l@0 {
 		#size-cells = <1>;
 	};
 
-	flash1: mx66l51235l@1 {
+	flash1: flash@1 {
 		compatible = "jedec,spi-nor";
 		reg = <1>;
 		spi-rx-bus-width = <4>;
-- 
2.32.0

