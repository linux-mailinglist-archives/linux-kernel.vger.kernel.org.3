Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7854EE32C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiCaVTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiCaVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:18:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04FF239324
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:17:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bq8so1848875ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhUgoUjmHfkmZB66Ljg+9BeuLZIJH4fmuI4EW/8GfzI=;
        b=YPb7yEyvES+dt9sHShI1By6hbIuwJMoBkGCPyvywEl10wdUYLHpyRz6ttW3nS19EoB
         0Scw63WuhrpxDyPhFmQF5POGjAENRqmJs2F7bKJDWekzzCX/F8GH7395WjBcys/rLSKq
         933w0xbpcUSlkNg4SHoitM2JuItD5yxMhU1HkjaFADRxDzJGurZM+ENUlIUcL/T+I3F3
         UYQ8GnnPV0CN9j2tHB5mSQgIyvQJDn+/dSCU4Hd4IK6vA8OctoeENwKjg0arRlsRqvJV
         3uV3qXPwQZ+bQBqSp+antnUeCmrCbJA9z+Fbvd2oETMUXTbFfBH8NQdAi13eugRD96zt
         HkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhUgoUjmHfkmZB66Ljg+9BeuLZIJH4fmuI4EW/8GfzI=;
        b=mqfENNgDaJVJG0ogYWq947Z+NMd7w7/aV/SLEAakDBXAbYwc/ltdSXv6kn+ijKlZJQ
         Dij40DXqDIwSrCT4aUWS6wkon4e4bf+VZVAgqyIVSreDzZtccYKE1CGM7PLOO4AKvAZg
         xzwmPwgKXy3f081BJrT7SQlt8hd8oEvEBv0fGCtUOKnNHu+f+xP+OUpUecdyCCX1fSMb
         TMr8WgLHEtAjUsReF37CL1qHqQaHruQrtnQYeFB+DZ3Cy8iF+pwHS+iuNjWQmr1vGRg2
         DCwvdpILetd0huGbqP3wt9VZvTrWrWz5Vgibz4OSVn2H07apW/pk9Sa4Z5GK4xD2PAja
         Qx+Q==
X-Gm-Message-State: AOAM530oRIO355n4hyhEfXRknor9sh/Bxh4dVpa4NXSl1IoCYT+Nwein
        IiXZyfb3hVHUkR11YqWrB2OKdw==
X-Google-Smtp-Source: ABdhPJznpX+KjZxb6pXEL6EoqM5vXbcnxtx2K142UoNbZtdPIFgL+oOQNPa0G2T6B6EaAQgFtY8ugg==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr6741191ejb.484.1648761426516;
        Thu, 31 Mar 2022 14:17:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id nc13-20020a1709071c0d00b006dfa376ee55sm202518ejc.131.2022.03.31.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:17:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] ARM: dts: exynos: correct array of voltages in i9100 and Trats
Date:   Thu, 31 Mar 2022 23:16:53 +0200
Message-Id: <20220331211653.175200-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
References: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array of uint32 numbers (voltages) should be within one bracket pair <>,
according to Devicetree types and DT schema.

This fixes DT schema warnings like:

  exynos4210-trats.dtb: pmic@66: max8997,pmic-buck1-dvs-voltage: [[1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1000000, 950000]] is too short
    From schema: Documentation/devicetree/bindings/regulator/maxim,max8997.yaml

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 28 +++++++++++++-------------
 arch/arm/boot/dts/exynos4210-trats.dts | 28 +++++++++++++-------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 3c0a18b30837..4058e780e288 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -421,20 +421,20 @@ pmic@66 {
 						 <&gpx0 6 GPIO_ACTIVE_HIGH>,
 						 <&gpl0 0 GPIO_ACTIVE_HIGH>;
 
-		max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
-						 <1250000>, <1200000>,
-						 <1150000>, <1100000>,
-						 <1000000>, <950000>;
-
-		max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
-						 <950000>,  <900000>,
-						 <1100000>, <1000000>,
-						 <950000>,  <900000>;
-
-		max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
-						 <1200000>, <1200000>,
-						 <1200000>, <1200000>,
-						 <1200000>, <1200000>;
+		max8997,pmic-buck1-dvs-voltage = <1350000 1300000
+						  1250000 1200000
+						  1150000 1100000
+						  1000000  950000>;
+
+		max8997,pmic-buck2-dvs-voltage = <1100000 1000000
+						   950000  900000
+						  1100000 1000000
+						   950000  900000>;
+
+		max8997,pmic-buck5-dvs-voltage = <1200000 1200000
+						  1200000 1200000
+						  1200000 1200000
+						  1200000 1200000>;
 
 		pinctrl-0 = <&max8997_irq>, <&otg_gp>, <&usb_sel>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 01f44d95f671..23041db78f2e 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -302,20 +302,20 @@ pmic@66 {
 						 <&gpx0 6 GPIO_ACTIVE_HIGH>,
 						 <&gpl0 0 GPIO_ACTIVE_HIGH>;
 
-		max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
-						 <1250000>, <1200000>,
-						 <1150000>, <1100000>,
-						 <1000000>, <950000>;
-
-		max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
-						 <950000>,  <900000>,
-						 <1100000>, <1000000>,
-						 <950000>,  <900000>;
-
-		max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
-						 <1200000>, <1200000>,
-						 <1200000>, <1200000>,
-						 <1200000>, <1200000>;
+		max8997,pmic-buck1-dvs-voltage = <1350000 1300000
+						  1250000 1200000
+						  1150000 1100000
+						  1000000  950000>;
+
+		max8997,pmic-buck2-dvs-voltage = <1100000 1000000
+						   950000  900000
+						  1100000 1000000
+						   950000  900000>;
+
+		max8997,pmic-buck5-dvs-voltage = <1200000 1200000
+						  1200000 1200000
+						  1200000 1200000
+						  1200000 1200000>;
 
 		regulators {
 			valive_reg: LDO2 {
-- 
2.32.0

