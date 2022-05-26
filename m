Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419D5354EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiEZUp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiEZUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:44:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253BD5DA6F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:44:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so3148870edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOY58nRo2FBMVZy4R9dChoRFoguqNiD/V0YfBQb6+is=;
        b=jP0bjuQktDPX6JTVbJjvC+zRgIO8NTyrFajRszjwmIwb1XAOJzbMLaoYRW4V9EiAvC
         unlwEAj2AHm1wi/ncAhOpQltINgTs8tyspxKTxa45VV/Q9qryXDtlCggrdOE05keuzg5
         SdkZ1uKmYeQ4JjSlTUnxAyZsOJS4MoGnPqC2g2TRh+wE9jGJJyLBacNOg5dZbcc8Nns0
         DujxcKG2MHdwp505Fqt4dhqJvokj5t88Tx9ZrCFJJJdBx2rrWKdK9QQgrLExp0cwzio+
         GlCCQx79fnPsReDh2OMi6GifCZ2J8Q1D6fpPp8sgJfg7YyqQf9a8S/jIp8c3LHDb6SRH
         gFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOY58nRo2FBMVZy4R9dChoRFoguqNiD/V0YfBQb6+is=;
        b=YMar6u1cHuHA6FQdY231dOIyRn8eu9lbfluWV+ypI7GkNofGP3mQOAOyPa9UaVs+p9
         mgD4T7TB2EIV9rEeqVDhtJ+RhVnqELKDM4fqVBxkBRMN5JRFG2tPww5tfRalsnEQkL3X
         fY/+f7KpIKM2uNNz090bNkVLyclWNWclHSg0cZfILcapeZkkxv+FPmnxQt9ynWQtCsPm
         oB0wKJNp2IlYpn4OxHXKIl+2e/RX+hKXmNkb1uSbupYne9HmAghJMnVlCsrd1xxOGeSL
         uiQOSNunZPPWWN60YFK6dFIiNNhJYASPP5uBJagetaWGVDDMWNkbbkZLonne7zuyJHXv
         U2/w==
X-Gm-Message-State: AOAM5317vIdi+2EHOjUxD7w3Jkr+BmFa7jdVkWQanl/DFYPpNMagm1R7
        z+juL8o3ULxHMaX+9LgUJ+ufyQ==
X-Google-Smtp-Source: ABdhPJyrLaR89tqeL23Sv2113VdbG8ErSnQMN2ndTBmG7bJIm8BHM2LMNk1k5z6mSMinJ7S/qaYvBw==
X-Received: by 2002:aa7:dbc1:0:b0:42b:77a2:4f81 with SMTP id v1-20020aa7dbc1000000b0042b77a24f81mr19418697edt.287.1653597849731;
        Thu, 26 May 2022 13:44:09 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709061ccf00b006fec5cef701sm803475ejh.197.2022.05.26.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:44:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: mediatek: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:44:02 +0200
Message-Id: <20220526204402.832393-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204402.832393-1-krzysztof.kozlowski@linaro.org>
References: <20220526204402.832393-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/mt2701.dtsi | 8 ++++----
 arch/arm/boot/dts/mt7623.dtsi | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index ef583cfd3baf..b8eba3ba153c 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -427,9 +427,9 @@ audsys: clock-controller@11220000 {
 
 		afe: audio-controller {
 			compatible = "mediatek,mt2701-audio";
-			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
 				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
-			interrupt-names	= "afe", "asys";
+			interrupt-names = "afe", "asys";
 			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 
 			clocks = <&infracfg CLK_INFRA_AUDIO>,
@@ -559,7 +559,7 @@ jpegdec: jpegdec@15004000 {
 		compatible = "mediatek,mt2701-jpgdec";
 		reg = <0 0x15004000 0 0x1000>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+		clocks = <&imgsys CLK_IMG_JPGDEC_SMI>,
 			  <&imgsys CLK_IMG_JPGDEC>;
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
@@ -573,7 +573,7 @@ jpegenc: jpegenc@1500a000 {
 			     "mediatek,mtk-jpgenc";
 		reg = <0 0x1500a000 0 0x1000>;
 		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_VENC>;
+		clocks = <&imgsys CLK_IMG_VENC>;
 		clock-names = "jpgenc";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index f4848362b3be..25d31e40a553 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -241,7 +241,7 @@ infracfg: syscon@10001000 {
 	};
 
 	pericfg: syscon@10003000 {
-		compatible =  "mediatek,mt7623-pericfg",
+		compatible = "mediatek,mt7623-pericfg",
 			      "mediatek,mt2701-pericfg",
 			      "syscon";
 		reg = <0 0x10003000 0 0x1000>;
@@ -628,9 +628,9 @@ audsys: clock-controller@11220000 {
 		afe: audio-controller {
 			compatible = "mediatek,mt7623-audio",
 				     "mediatek,mt2701-audio";
-			interrupts =  <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
 				      <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
-			interrupt-names	= "afe", "asys";
+			interrupt-names = "afe", "asys";
 			power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 
 			clocks = <&infracfg CLK_INFRA_AUDIO>,
-- 
2.34.1

