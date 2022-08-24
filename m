Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8759FF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbiHXQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiHXQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:07:25 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3156880B66;
        Wed, 24 Aug 2022 09:07:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661357239; bh=sHeYLuJA67nZaY4WSbgSXG+UWU/shWLU+cSuvcmzqjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=foe2+KKSacdQ25yG02zYe7gywYei0k3dU4PRovXO3MlbFp4L2wntKjPSC5ZVNV6Hb
         p2x47z5PRHQQHlKb5CRsdTc/CIDkno4FMiPIc7XiMkYapCES2gdYgPugnDoyMU5TuU
         BKx3A+MZpjiv/4OMQOKd+1FqV5o9w/KOOm9NGcmU=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: apple: t8103: Add MCA and its support
Date:   Wed, 24 Aug 2022 18:07:13 +0200
Message-Id: <20220824160715.95779-3-povik+lin@cutebit.org>
In-Reply-To: <20220824160715.95779-1-povik+lin@cutebit.org>
References: <20220824160715.95779-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MCA I2S transceiver node and its supporting NCO, ADMAC nodes.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi |  4 ++
 arch/arm64/boot/dts/apple/t8103.dtsi      | 73 +++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index fe2ae40fa9dd..503a1b243efa 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -76,3 +76,7 @@ wifi0: network@0,0 {
 		local-mac-address = [00 00 00 00 00 00];
 	};
 };
+
+&nco_clkref {
+	clock-frequency = <900000000>;
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 51a63b29d404..5c01d5318386 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -532,6 +532,79 @@ port02: pci@2,0 {
 						<0 0 0 4 &port02 0 0 0 3>;
 			};
 		};
+
+		dart_sio: iommu@235004000 {
+			compatible = "apple,t8103-dart", "apple,dart";
+			reg = <0x2 0x35004000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 635 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			power-domains = <&ps_sio_cpu>;
+		};
+
+		/*
+		 * This is a fabulated representation of the input clock
+		 * to NCO since we don't know the true clock tree.
+		 */
+		nco_clkref: clock-ref {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "nco_ref";
+		};
+
+		nco: clock-controller@23b044000 {
+			compatible = "apple,t8103-nco", "apple,nco";
+			reg = <0x2 0x3b044000 0x0 0x14000>;
+			clocks = <&nco_clkref>;
+			#clock-cells = <1>;
+		};
+
+		admac: dma-controller@238200000 {
+			compatible = "apple,t8103-admac", "apple,admac";
+			reg = <0x2 0x38200000 0x0 0x34000>;
+			dma-channels = <24>;
+			interrupts-extended = <0>,
+					      <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>,
+					      <0>,
+					      <0>;
+			#dma-cells = <1>;
+			iommus = <&dart_sio 2>;
+			power-domains = <&ps_sio_adma>;
+		};
+
+		mca: i2s@38400000 {
+			compatible = "apple,t8103-mca", "apple,mca";
+			reg = <0x2 0x38400000 0x0 0x18000>,
+			      <0x2 0x38300000 0x0 0x30000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 619 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 620 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 621 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 622 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 623 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 624 IRQ_TYPE_LEVEL_HIGH>;
+
+			resets = <&ps_audio_p>;
+			clocks = <&nco 0>, <&nco 1>, <&nco 2>,
+				 <&nco 3>, <&nco 4>, <&nco 4>;
+			power-domains = <&ps_audio_p>, <&ps_mca0>, <&ps_mca1>,
+					<&ps_mca2>, <&ps_mca3>, <&ps_mca4>, <&ps_mca5>;
+			dmas = <&admac 0>, <&admac 1>, <&admac 2>, <&admac 3>,
+			       <&admac 4>, <&admac 5>, <&admac 6>, <&admac 7>,
+			       <&admac 8>, <&admac 9>, <&admac 10>, <&admac 11>,
+			       <&admac 12>, <&admac 13>, <&admac 14>, <&admac 15>,
+			       <&admac 16>, <&admac 17>, <&admac 18>, <&admac 19>,
+			       <&admac 20>, <&admac 21>, <&admac 22>, <&admac 23>;
+			dma-names = "tx0a", "rx0a", "tx0b", "rx0b",
+				"tx1a", "rx1a", "tx1b", "rx1b",
+				"tx2a", "rx2a", "tx2b", "rx2b",
+				"tx3a", "rx3a", "tx3b", "rx3b",
+				"tx4a", "rx4a", "tx4b", "rx4b",
+				"tx5a", "rx5a", "tx5b", "rx5b";
+
+			#sound-dai-cells = <1>;
+		};
 	};
 };
 
-- 
2.33.0

