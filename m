Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E6E5354C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiEZUnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiEZUmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:42:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258696441
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so3144709edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADqKJdbqKJgJ+Kg0DAm3wQJ6kaap7SQu0KoHV5lMi6o=;
        b=UW/PIlwYn0ZoAUDaWjJIFIjFaJDJDpE22GNHHXfyeFrpw8sAg9hGAqJUuXHhlcOI0S
         Uuk1MqkSrW2j/eY1+x65UOWevsmO1H24hHTlmrLIzAaBy8fWfIHuESxie3PDbhitU4XI
         UuiZwqwRGIa6jap7jzXiEx8bskStr/mKiHi0Qf1BDp7P8sWEWT6P/x/7aVbaY/A0PXFF
         Q3/h3CdAONbLeV2+sinmhsRtSab2nY8417dlg1stPZtYAp6u1/ymJ/0nCgSeAUkAawHB
         k/ZlXCMweXeHyK3Ym0mGTg8kauAy0Lb4/btc23UYeB4F7ae+HVKBmETprFUIljfL5hM6
         JZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADqKJdbqKJgJ+Kg0DAm3wQJ6kaap7SQu0KoHV5lMi6o=;
        b=v+qI3ulvv+B2tcI7Vb6t9ZG0+2iFSaCduyMQtzz8BXzyH0dIYuRV+huLvZWI69+Xdc
         M8gV6F65OEMXexI8OiS5ek+Nad/13G/FgSYlJaYN2pRTwhHX2M+wqyKsNqLSMkgbGsQA
         3m28RDhLtRor8HdRMF3686Owco+kuyDydt/6+yTHNuPjdMRJb1KGtu8fZB7EFP3yODaf
         nlgk3JZFCC26VZOvVoGV3mjQNyOe58K+FCLQxu4DuaN78Hsd0X8rDz7em7xXP4KalTwu
         gG5kiEmpLceh1l4pz3hsKVOFSM1QzKQGV/Vwr7RlQOUxaeDf63KupXNyuIC7M1Fi2NiB
         LpYA==
X-Gm-Message-State: AOAM532RwWO0vteFfzsfvcsuktQZk6GNCXrarbZNuoJpLAKykleMaZ7Q
        pw6S5vKeC4eAbY1QYqI6czFo4A==
X-Google-Smtp-Source: ABdhPJy3RfkUoqMH5w0G5VrkKRX7O3+5DdIFoLZRfjDU7Ds5U1HKL4bPRFugK9rvtFvsNaJPlNg6zw==
X-Received: by 2002:a05:6402:1113:b0:428:679e:f73f with SMTP id u19-20020a056402111300b00428679ef73fmr42108111edv.378.1653597746602;
        Thu, 26 May 2022 13:42:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r17-20020a50d691000000b0042617ba6389sm1239732edi.19.2022.05.26.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:42:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: rv1108: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:18 +0200
Message-Id: <20220526204218.832029-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204218.832029-1-krzysztof.kozlowski@linaro.org>
References: <20220526204218.832029-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/rv1108-elgin-r1.dts | 14 +++++++-------
 arch/arm/boot/dts/rv1108-evb.dts      | 14 +++++++-------
 arch/arm/boot/dts/rv1108.dtsi         |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 0c99a5934ebf..2d9994379eb2 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -83,7 +83,7 @@ rk805: pmic@18 {
 
 		regulators {
 			vdd_core: DCDC_REG1 {
-				regulator-name= "vdd_core";
+				regulator-name = "vdd_core";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
@@ -95,7 +95,7 @@ regulator-state-mem {
 			};
 
 			vdd_buck2: DCDC_REG2 {
-				regulator-name= "vdd_buck2";
+				regulator-name = "vdd_buck2";
 				regulator-min-microvolt = <2200000>;
 				regulator-max-microvolt = <2200000>;
 				regulator-always-on;
@@ -106,7 +106,7 @@ regulator-state-mem {
 			};
 
 			vcc_ddr: DCDC_REG3 {
-				regulator-name= "vcc_ddr";
+				regulator-name = "vcc_ddr";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
@@ -115,7 +115,7 @@ regulator-state-mem {
 			};
 
 			vcc_io: DCDC_REG4 {
-				regulator-name= "vcc_io";
+				regulator-name = "vcc_io";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
@@ -127,7 +127,7 @@ regulator-state-mem {
 			};
 
 			vdd_10: LDO_REG1 {
-				regulator-name= "vdd_10";
+				regulator-name = "vdd_10";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
@@ -138,7 +138,7 @@ regulator-state-mem {
 			};
 
 			vcc_18: LDO_REG2 {
-				regulator-name= "vcc_18";
+				regulator-name = "vcc_18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
@@ -149,7 +149,7 @@ regulator-state-mem {
 			};
 
 			vdd10_pmu: LDO_REG3 {
-				regulator-name= "vdd10_pmu";
+				regulator-name = "vdd10_pmu";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 46cad7cb94bf..ef150f4ee99d 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -96,7 +96,7 @@ rk805: pmic@18 {
 
 		regulators {
 			vdd_core: DCDC_REG1 {
-				regulator-name= "vdd_core";
+				regulator-name = "vdd_core";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
@@ -108,7 +108,7 @@ regulator-state-mem {
 			};
 
 			vdd_cam: DCDC_REG2 {
-				regulator-name= "vdd_cam";
+				regulator-name = "vdd_cam";
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <2000000>;
 				regulator-state-mem {
@@ -117,7 +117,7 @@ regulator-state-mem {
 			};
 
 			vcc_ddr: DCDC_REG3 {
-				regulator-name= "vcc_ddr";
+				regulator-name = "vcc_ddr";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
@@ -126,7 +126,7 @@ regulator-state-mem {
 			};
 
 			vcc_io: DCDC_REG4 {
-				regulator-name= "vcc_io";
+				regulator-name = "vcc_io";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
@@ -138,7 +138,7 @@ regulator-state-mem {
 			};
 
 			vdd_10: LDO_REG1 {
-				regulator-name= "vdd_10";
+				regulator-name = "vdd_10";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
@@ -149,7 +149,7 @@ regulator-state-mem {
 			};
 
 			vcc_18: LDO_REG2 {
-				regulator-name= "vcc_18";
+				regulator-name = "vcc_18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
@@ -160,7 +160,7 @@ regulator-state-mem {
 			};
 
 			vdd10_pmu: LDO_REG3 {
-				regulator-name= "vdd10_pmu";
+				regulator-name = "vdd10_pmu";
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index c158a7ea86ec..abf3006f0a84 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -748,7 +748,7 @@ sfc_clk: sfc-clk {
 
 		gmac {
 			rmii_pins: rmii-pins {
-				rockchip,pins =	<1 RK_PC5 2 &pcfg_pull_none>,
+				rockchip,pins = <1 RK_PC5 2 &pcfg_pull_none>,
 						<1 RK_PC3 2 &pcfg_pull_none>,
 						<1 RK_PC4 2 &pcfg_pull_none>,
 						<1 RK_PB2 3 &pcfg_pull_none_drv_12ma>,
-- 
2.34.1

