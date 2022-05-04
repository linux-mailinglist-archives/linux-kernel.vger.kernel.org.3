Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A451A0B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350596AbiEDNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350453AbiEDNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C03E5FC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l7so2864986ejn.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6S+HSLj2lOjLFyHSsTGoc9llbySR0mUOnbz2m/3gyM=;
        b=s/YY9IAU6+ETYvVK7KOX3MnnlFyvyaA360NXjFal1nVW7nSlKfPvuI/ryD7a9iqUlO
         HtPSdI2LTYZXu59m7pYBvCIfEouWYraS8gWE4uW8IidxDxbaTTG2+LCwYs4Bz4lzE7sN
         mSNJjGIkKjGvIgl3xXb/26vNFOt0VKIrAgTyRZPkdkJyWLP4NmbO6K4u9hPCKwKPYudy
         HWbvxb8ED9ZAZ3vptt0gdJPctozdFZtlOy41SLxfvDUx2QGqkAkj6F33x7zK5d0Jmt/z
         u45ZjCoUfB0yxzl+JeLI44BlZK0b7tx6qiCKqQ/3yiV6nUi0dVgisczYlZhgvpR9OBqY
         WyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6S+HSLj2lOjLFyHSsTGoc9llbySR0mUOnbz2m/3gyM=;
        b=2+SA1U3eR5+MbzBDxVp31ZAmVXNRK3LZQCiI2Y5KjYRH8fzwYLD/OzdJPB3NGHf0WF
         +zR+I5arVdL6EtDw6EZbVhhJPf7O4BnIlaHOYfUB3ibLHDE6biSTzPFkwk/XTB0WORDk
         zxSH0Z0T7cmYhAmbSCOYsmOgKuh6cZqLc05J3pB8FaIO06XsORdQ+AcvrEVK8lEE3DrC
         wNX5s1l9e8vyg/9t1rqfVYIHe+Ytv/FFC6+6RRDFa+LUVjZXinHwc8SnON9/eqLngRu7
         p17YickSvMsxKld9mLa8TZRvIxq5E02yVyzcz5o6cWSsMebO8lgxUj+qRCYoOLt8V2cm
         1xVA==
X-Gm-Message-State: AOAM533eGkYo8/eJTJFc7xITa89QBW89Ub+dQ13YjMr7oAwMvS4m0zm/
        2pHdIJv4SB4LzDSNjmqVEC4AB10LikGb6w==
X-Google-Smtp-Source: ABdhPJwhVllXOstmoh8625gM/aXrZ6grJik93kV6nqg8dv5utJXlBtK64FvCuppfpVyGtTAHOP04mw==
X-Received: by 2002:a17:907:9690:b0:6f3:bf14:4c68 with SMTP id hd16-20020a170907969000b006f3bf144c68mr19831577ejc.584.1651670374242;
        Wed, 04 May 2022 06:19:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/13] arm64: dts: qcom: correct DWC3 node names and unit addresses
Date:   Wed,  4 May 2022 15:19:16 +0200
Message-Id: <20220504131923.214367-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
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

Align DWC3 USB node names with DT schema ("usb" is expected) and correct
the unit addresses to match the "reg" property.  This also implies
overriding nodes by label, instead of full path.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts   | 18 ++++++++---------
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  6 +++---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  4 ++--
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 20 +++++++++----------
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |  7 ++++---
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  4 ++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  2 +-
 11 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 56e54ce4d10e..49afbb1a066a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -1052,22 +1052,22 @@ &ufshc {
 &usb2 {
 	status = "okay";
 	extcon = <&usb2_id>;
+};
 
-	dwc3@7600000 {
-		extcon = <&usb2_id>;
-		dr_mode = "otg";
-		maximum-speed = "high-speed";
-	};
+&usb2_dwc3 {
+	extcon = <&usb2_id>;
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
 };
 
 &usb3 {
 	status = "okay";
 	extcon = <&usb3_id>;
+};
 
-	dwc3@6a00000 {
-		extcon = <&usb3_id>;
-		dr_mode = "otg";
-	};
+&usb3_dwc3 {
+	extcon = <&usb3_id>;
+	dr_mode = "otg";
 };
 
 &usb3phy {
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a4d363c187fc..835de9834833 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -653,7 +653,7 @@ qusb_phy_1: qusb@59000 {
 			status = "disabled";
 		};
 
-		usb2: usb2@7000000 {
+		usb2: usb@70f8800 {
 			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
 			reg = <0x0 0x070F8800 0x0 0x400>;
 			#address-cells = <2>;
@@ -730,7 +730,7 @@ qusb_phy_0: qusb@79000 {
 			status = "disabled";
 		};
 
-		usb3: usb3@8A00000 {
+		usb3: usb@8af8800 {
 			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
 			reg = <0x0 0x8AF8800 0x0 0x400>;
 			#address-cells = <2>;
@@ -756,7 +756,7 @@ usb3: usb3@8A00000 {
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
-			dwc_0: usb@8A00000 {
+			dwc_0: usb@8a00000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0x8A00000 0x0 0xcd00>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 943243d5515b..519938530c35 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -578,7 +578,7 @@ usb_0: usb@8af8800 {
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
-			dwc_0: dwc3@8a00000 {
+			dwc_0: usb@8a00000 {
 				compatible = "snps,dwc3";
 				reg = <0x8a00000 0xcd00>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
@@ -618,7 +618,7 @@ usb_1: usb@8cf8800 {
 			resets = <&gcc GCC_USB1_BCR>;
 			status = "disabled";
 
-			dwc_1: dwc3@8c00000 {
+			dwc_1: usb@8c00000 {
 				compatible = "snps,dwc3";
 				reg = <0x8c00000 0xcd00>;
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index be4f643b1fd1..a7090befc16f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -308,19 +308,19 @@ &usb3 {
 	extcon = <&typec>;
 
 	qcom,select-utmi-as-pipe-clk;
+};
 
-	dwc3@6a00000 {
-		extcon = <&typec>;
+&usb3_dwc3 {
+	extcon = <&typec>;
 
-		/* usb3-phy is not used on this device */
-		phys = <&hsusb_phy1>;
-		phy-names = "usb2-phy";
+	/* usb3-phy is not used on this device */
+	phys = <&hsusb_phy1>;
+	phy-names = "usb2-phy";
 
-		maximum-speed = "high-speed";
-		snps,is-utmi-l1-suspend;
-		snps,usb2-gadget-lpm-disable;
-		snps,hird-threshold = /bits/ 8 <0>;
-	};
+	maximum-speed = "high-speed";
+	snps,is-utmi-l1-suspend;
+	snps,usb2-gadget-lpm-disable;
+	snps,hird-threshold = /bits/ 8 <0>;
 };
 
 &hsusb_phy1 {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 205af7b479a8..fc2e026d4c07 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2731,7 +2731,7 @@ usb3: usb@6af8800 {
 			power-domains = <&gcc USB30_GDSC>;
 			status = "disabled";
 
-			usb3_dwc3: dwc3@6a00000 {
+			usb3_dwc3: usb@6a00000 {
 				compatible = "snps,dwc3";
 				reg = <0x06a00000 0xcc00>;
 				interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
@@ -3059,7 +3059,7 @@ usb2: usb@76f8800 {
 			qcom,select-utmi-as-pipe-clk;
 			status = "disabled";
 
-			dwc3@7600000 {
+			usb2_dwc3: usb@7600000 {
 				compatible = "snps,dwc3";
 				reg = <0x07600000 0xcc00>;
 				interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 4a84de6cee1e..0200d532b531 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2040,7 +2040,7 @@ usb3: usb@a8f8800 {
 
 			resets = <&gcc GCC_USB_30_BCR>;
 
-			usb3_dwc3: dwc3@a800000 {
+			usb3_dwc3: usb@a800000 {
 				compatible = "snps,dwc3";
 				reg = <0x0a800000 0xcd00>;
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a80c578484ba..2f3104a84417 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -337,9 +337,10 @@ &usb2_phy_sec {
 &usb3 {
 	status = "okay";
 
-	dwc3@7580000 {
-		dr_mode = "host";
-	};
+};
+
+&usb3_dwc3 {
+	dr_mode = "host";
 };
 
 &usb2_phy_prim {
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index bc446c6002d0..568821259f11 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -544,7 +544,7 @@ usb3: usb@7678800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 			status = "disabled";
 
-			dwc3@7580000 {
+			usb3_dwc3: usb@7580000 {
 				compatible = "snps,dwc3";
 				reg = <0x07580000 0xcd00>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
@@ -573,7 +573,7 @@ usb2: usb@79b8800 {
 			assigned-clock-rates = <19200000>, <133333333>;
 			status = "disabled";
 
-			dwc3@78c0000 {
+			usb@78c0000 {
 				compatible = "snps,dwc3";
 				reg = <0x078c0000 0xcc00>;
 				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 925340fbbb59..e9f834361660 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2786,7 +2786,7 @@ usb_1: usb@a6f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
-			usb_1_dwc3: dwc3@a600000 {
+			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xe000>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 692cf4be4eef..6af80a627c3a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3868,7 +3868,7 @@ usb_1: usb@a6f8800 {
 					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
-			usb_1_dwc3: dwc3@a600000 {
+			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
@@ -3916,7 +3916,7 @@ usb_2: usb@a8f8800 {
 					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
-			usb_2_dwc3: dwc3@a800000 {
+			usb_2_dwc3: usb@a800000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a800000 0 0xcd00>;
 				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 90a4c09e67f1..a57a13486c6c 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3635,7 +3635,7 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
-			usb_1_dwc3: dwc3@a600000 {
+			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.32.0

