Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA50527AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiEOWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEOWSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 18:18:09 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB22C105;
        Sun, 15 May 2022 15:18:07 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8287F2007F;
        Mon, 16 May 2022 00:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1652653080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ybIBHjPejoUG7gKQIT2nuQfzYTY7QcYBd6Ac2woJbhQ=;
        b=jg8VyXGVCl0xQpTw7gMICa+oq3PUKr5CStnlWiKQOfRAF2MadguxJbn34DfdNkm1rDTQ78
        O9CR0lMa23/fETD1f/X98gCDDDfDh/3bRfDwhWYtqhK9SM4Xm9EqQgm7YwfV7d9bTru/zx
        HoU8AQY+LZUX0EeVs6kOGbWkgscV60k=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: timer should use only 32-bit size
Date:   Mon, 16 May 2022 00:17:57 +0200
Message-Id: <20220515221758.88723-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason the timer needs > 32-bits of size.
Since we using 32-bit size, we need to define ranges properly.

Fixes warnings as:
```
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: timer@17c90000: #size-cells:0:0: 1 was expected
        From schema: Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
```

Signed-off-by: David Heidelberg <david@ixit.cz>

---
Replaces "dt-bindings: timer: add #size-cells 2 for ARM"
v2: fix accidental change of value 0x0 to 0

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sm6350.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 20 ++++++++++----------
 arch/arm64/boot/dts/qcom/sm8450.dtsi  | 20 ++++++++++----------
 9 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index c89499e366d3..8638231dbd2f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -526,8 +526,8 @@ timer {
 
 		timer@b120000 {
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x10000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x0b120000 0x0 0x1000>;
 
@@ -535,49 +535,49 @@ frame@b120000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b121000 0x0 0x1000>,
-				      <0x0 0x0b122000 0x0 0x1000>;
+				reg = <0x0 0x0b121000 0x1000>,
+				      <0x0 0x0b122000 0x1000>;
 			};
 
 			frame@b123000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0xb123000 0x0 0x1000>;
+				reg = <0x0 0x0b123000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b124000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b124000 0x0 0x1000>;
+				reg = <0x0 0x0b124000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b125000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b125000 0x0 0x1000>;
+				reg = <0x0 0x0b125000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b126000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b126000 0x0 0x1000>;
+				reg = <0x0 0x0b126000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b127000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b127000 0x0 0x1000>;
+				reg = <0x0 0x0b127000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@b128000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x0b128000 0x0 0x1000>;
+				reg = <0x0 0x0b128000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5dcaac23a138..4b7be66e04df 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3385,8 +3385,8 @@ watchdog@17c10000 {
 
 		timer@17c20000{
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0 0x17c20000 0 0x1000>;
 
@@ -3394,49 +3394,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c21000 0 0x1000>,
-				      <0 0x17c22000 0 0x1000>;
+				reg = <0 0x17c21000 0x1000>,
+				      <0 0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c23000 0 0x1000>;
+				reg = <0 0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c25000 0 0x1000>;
+				reg = <0 0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c27000 0 0x1000>;
+				reg = <0 0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c29000 0 0x1000>;
+				reg = <0 0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2b000 0 0x1000>;
+				reg = <0 0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2d000 0 0x1000>;
+				reg = <0 0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e66fc67de206..1b81cd1e84e9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -4772,8 +4772,8 @@ watchdog@17c10000 {
 
 		timer@17c20000 {
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0 0x17c20000 0 0x1000>;
 
@@ -4781,49 +4781,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c21000 0 0x1000>,
-				      <0 0x17c22000 0 0x1000>;
+				reg = <0 0x17c21000 0x1000>,
+				      <0 0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c23000 0 0x1000>;
+				reg = <0 0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c25000 0 0x1000>;
+				reg = <0 0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c27000 0 0x1000>;
+				reg = <0 0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c29000 0 0x1000>;
+				reg = <0 0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2b000 0 0x1000>;
+				reg = <0 0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17c2d000 0 0x1000>;
+				reg = <0 0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0692ae0e60a4..9a1705bfa425 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4949,8 +4949,8 @@ slimbam: dma-controller@17184000 {
 
 		timer@17c90000 {
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0 0x17c90000 0 0x1000>;
 
@@ -4958,49 +4958,49 @@ frame@17ca0000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17ca0000 0 0x1000>,
-				      <0 0x17cb0000 0 0x1000>;
+				reg = <0 0x17ca0000 0x1000>,
+				      <0 0x17cb0000 0x1000>;
 			};
 
 			frame@17cc0000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17cc0000 0 0x1000>;
+				reg = <0 0x17cc0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17cd0000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17cd0000 0 0x1000>;
+				reg = <0 0x17cd0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17ce0000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17ce0000 0 0x1000>;
+				reg = <0 0x17ce0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17cf0000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17cf0000 0 0x1000>;
+				reg = <0 0x17cf0000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17d00000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17d00000 0 0x1000>;
+				reg = <0 0x17d00000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17d10000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0 0x17d10000 0 0x1000>;
+				reg = <0 0x17d10000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d4f8f33f3f0c..fc473cb8c93b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1305,56 +1305,56 @@ timer@17c20000 {
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 
 			frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x0 0x17c21000 0x1000>,
+				      <0x0 0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x0 0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x0 0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c27000 0x0 0x1000>;
+				reg = <0x0 0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x0 0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x0 0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x0 0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 8ea44c4b56b4..066cc00191b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3945,8 +3945,8 @@ watchdog@17c10000 {
 
 		timer@17c20000 {
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
@@ -3955,49 +3955,49 @@ frame@17c21000{
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x0 0x17c21000 0x1000>,
+				      <0x0 0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x0 0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x0 0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c26000 0x0 0x1000>;
+				reg = <0x0 0x17c26000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x0 0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x0 0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x0 0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index cf0c97bd5ad3..ae7d0573e1dc 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4868,8 +4868,8 @@ watchdog@17c10000 {
 
 		timer@17c20000 {
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
@@ -4878,49 +4878,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x0 0x17c21000 0x1000>,
+				      <0x0 0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x0 0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x0 0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c27000 0x0 0x1000>;
+				reg = <0x0 0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x0 0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x0 0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x0 0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 743cba9b683c..58e6bb4a1899 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1934,8 +1934,8 @@ intc: interrupt-controller@17a00000 {
 		timer@17c20000 {
 			compatible = "arm,armv7-timer-mem";
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 
@@ -1943,49 +1943,49 @@ frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c21000 0x0 0x1000>,
-				      <0x0 0x17c22000 0x0 0x1000>;
+				reg = <0x0 0x17c21000 0x1000>,
+				      <0x0 0x17c22000 0x1000>;
 			};
 
 			frame@17c23000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c23000 0x0 0x1000>;
+				reg = <0x0 0x17c23000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c25000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c25000 0x0 0x1000>;
+				reg = <0x0 0x17c25000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c27000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c27000 0x0 0x1000>;
+				reg = <0x0 0x17c27000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c29000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c29000 0x0 0x1000>;
+				reg = <0x0 0x17c29000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2b000 0x0 0x1000>;
+				reg = <0x0 0x17c2b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17c2d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17c2d000 0x0 0x1000>;
+				reg = <0x0 0x17c2d000 0x1000>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7d08fad76371..64ceff515337 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2858,8 +2858,8 @@ intc: interrupt-controller@17100000 {
 		timer@17420000 {
 			compatible = "arm,armv7-timer-mem";
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0 0 0 0 0x20000000>;
 			reg = <0x0 0x17420000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 
@@ -2867,49 +2867,49 @@ frame@17421000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17421000 0x0 0x1000>,
-				      <0x0 0x17422000 0x0 0x1000>;
+				reg = <0x0 0x17421000 0x1000>,
+				      <0x0 0x17422000 0x1000>;
 			};
 
 			frame@17423000 {
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17423000 0x0 0x1000>;
+				reg = <0x0 0x17423000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17425000 {
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17425000 0x0 0x1000>;
+				reg = <0x0 0x17425000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17427000 {
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17427000 0x0 0x1000>;
+				reg = <0x0 0x17427000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17429000 {
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x17429000 0x0 0x1000>;
+				reg = <0x0 0x17429000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@1742b000 {
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x1742b000 0x0 0x1000>;
+				reg = <0x0 0x1742b000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@1742d000 {
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x0 0x1742d000 0x0 0x1000>;
+				reg = <0x0 0x1742d000 0x1000>;
 				status = "disabled";
 			};
 		};
-- 
2.35.1

