Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C355B160
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiFZK6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiFZK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:58:16 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B1FC7;
        Sun, 26 Jun 2022 03:58:10 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 782A82007F;
        Sun, 26 Jun 2022 12:58:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1656241087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2lRbLCGLO//PPx5AL6HlGD2fXxIUX6lj4i4qlI1zl6I=;
        b=jpMZdkPUbSBvAmqPwF9KmKC32PbScHrroi6f1Xu/1ITUDaSLU37303IED9H2hUv9npDCKD
        XILsVrMutEuQLsMvWvCea5gx2BBK/0jAmgVWDkQUWnPR/N2lErrLvpwMFFjI/jsf00kHh8
        qXIEwWEv/g2bmLWd693Y3oJj5PMLPIk=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: qcom: timer should use only 32-bit size
Date:   Sun, 26 Jun 2022 12:57:59 +0200
Message-Id: <20220626105800.35586-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason the timer needs > 32-bits of address or size.
Since we using 32-bit size, we need to define ranges properly.

Fixes warnings as:
```
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: timer@17c90000: #size-cells:0:0: 1 was expected
        From schema: Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
```

Signed-off-by: David Heidelberg <david@ixit.cz>

---
v3: change also address-size to 32-bit
v2: Replaces "dt-bindings: timer: add #size-cells 2 for ARM", link:
https://lore.kernel.org/all/CAL_JsqJMMCBnukFZLJ8X14s1PwqT=VEwKjDVj8mm4h55pZpcuw@mail.gmail.com/T/#m528649c3b9d5c1340408584991c8cb0f6d74b6fb

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sm6350.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 22 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8450.dtsi  | 22 +++++++++++-----------
 9 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index c89499e366d3..748575ed1490 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -525,9 +525,9 @@ timer {
 		};
 
 		timer@b120000 {
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x10000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x0b120000 0x0 0x1000>;
 
@@ -535,49 +535,49 @@ frame@b120000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b121000 0x0 0x1000>,
-				      <0x0 0x0b122000 0x0 0x1000>;
+				reg = <0x0b121000 0x1000>,
+				      <0x0b122000 0x1000>;
 			};
 
 			frame@b123000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0xb123000 0x0 0x1000>;
+				reg = <0x0b123000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b124000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b124000 0x0 0x1000>;
+				reg = <0x0b124000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b125000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b125000 0x0 0x1000>;
+				reg = <0x0b125000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b126000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b126000 0x0 0x1000>;
+				reg = <0x0b126000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b127000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b127000 0x0 0x1000>;
+				reg = <0x0b127000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b128000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b128000 0x0 0x1000>;
+				reg = <0x0b128000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 705dc60f2151..8769ad30f1c7 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3384,9 +3384,9 @@ watchdog@17c10000 {
 		};
 
 		timer@17c20000{
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0 0x17c20000 0 0x1000>;
 
@@ -3394,49 +3394,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c21000 0 0x1000>,
-				      <0 0x17c22000 0 0x1000>;
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c23000 0 0x1000>;
+				reg = <0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c25000 0 0x1000>;
+				reg = <0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c27000 0 0x1000>;
+				reg = <0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c29000 0 0x1000>;
+				reg = <0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2b000 0 0x1000>;
+				reg = <0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2d000 0 0x1000>;
+				reg = <0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 3eafc50b6abd..d22405658f13 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4771,9 +4771,9 @@ watchdog@17c10000 {
 		};
 
 		timer@17c20000 {
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0 0x17c20000 0 0x1000>;
 
@@ -4781,49 +4781,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c21000 0 0x1000>,
-				      <0 0x17c22000 0 0x1000>;
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c23000 0 0x1000>;
+				reg = <0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c25000 0 0x1000>;
+				reg = <0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c27000 0 0x1000>;
+				reg = <0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c29000 0 0x1000>;
+				reg = <0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2b000 0 0x1000>;
+				reg = <0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2d000 0 0x1000>;
+				reg = <0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0692ae0e60a4..aa21a29fd0b1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4948,9 +4948,9 @@ slimbam: dma-controller@17184000 {
 		};
 
 		timer@17c90000 {
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0 0x17c90000 0 0x1000>;
 
@@ -4958,49 +4958,49 @@ frame@17ca0000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17ca0000 0 0x1000>,
-				      <0 0x17cb0000 0 0x1000>;
+				reg = <0x17ca0000 0x1000>,
+				      <0x17cb0000 0x1000>;
 			};
 
 			frame@17cc0000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17cc0000 0 0x1000>;
+				reg = <0x17cc0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17cd0000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17cd0000 0 0x1000>;
+				reg = <0x17cd0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17ce0000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17ce0000 0 0x1000>;
+				reg = <0x17ce0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17cf0000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17cf0000 0 0x1000>;
+				reg = <0x17cf0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17d00000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17d00000 0 0x1000>;
+				reg = <0x17d00000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17d10000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17d10000 0 0x1000>;
+				reg = <0x17d10000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d4f8f33f3f0c..b44734cd8d6f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1304,57 +1304,57 @@ timer@17c20000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 
 			frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c27000 0x0 0x1000>;
+				reg = <0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5725fe47009d..8abaa28cebbc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3944,9 +3944,9 @@ watchdog@17c10000 {
 		};
 
 		timer@17c20000 {
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
@@ -3955,49 +3955,49 @@ frame@17c21000{
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c26000 0x0 0x1000>;
+				reg = <0x17c26000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c8962acfddbe..d0760e6ec942 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4867,9 +4867,9 @@ watchdog@17c10000 {
 		};
 
 		timer@17c20000 {
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
@@ -4878,49 +4878,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c27000 0x0 0x1000>;
+				reg = <0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index dd32b227df49..3293f76478df 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1933,9 +1933,9 @@ intc: interrupt-controller@17a00000 {
 
 		timer@17c20000 {
 			compatible = "arm,armv7-timer-mem";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 
@@ -1943,49 +1943,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x17c21000 0x1000>,
+				      <0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c27000 0x0 0x1000>;
+				reg = <0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7d08fad76371..d3990ba0640d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2857,9 +2857,9 @@ intc: interrupt-controller@17100000 {
 
 		timer@17420000 {
 			compatible = "arm,armv7-timer-mem";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
 			reg = <0x0 0x17420000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 
@@ -2867,49 +2867,49 @@ frame@17421000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17421000 0x0 0x1000>,
-				      <0x0 0x17422000 0x0 0x1000>;
+				reg = <0x17421000 0x1000>,
+				      <0x17422000 0x1000>;
 			};
 
 			frame@17423000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17423000 0x0 0x1000>;
+				reg = <0x17423000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17425000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17425000 0x0 0x1000>;
+				reg = <0x17425000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17427000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17427000 0x0 0x1000>;
+				reg = <0x17427000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17429000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17429000 0x0 0x1000>;
+				reg = <0x17429000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@1742b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x1742b000 0x0 0x1000>;
+				reg = <0x1742b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@1742d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x1742d000 0x0 0x1000>;
+				reg = <0x1742d000 0x1000>;
 				status = "disabled";
 			};
 		};
-- 
2.35.1

