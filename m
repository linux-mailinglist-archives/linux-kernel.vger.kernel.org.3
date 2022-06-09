Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FAF544812
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiFIJyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiFIJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:54:37 -0400
X-Greylist: delayed 2337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 02:54:35 PDT
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [85.10.195.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A7B19578A;
        Thu,  9 Jun 2022 02:54:33 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654768471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ai7MXDHhQ0YkmN4XjLxpe4VHIXkfJfMzV2EfEfNPqA=;
        b=q3qFRsOM0276IDWHlcDx5ar0aVWlGYi/hivWeZCNX4vetaAs94nL3WD5W8jjKIOhuUX10N
        9yklJLJ3nk7v2sGTmgwLFqQeVGhqc7pc7D4Q7f6XO8uyQQs/rbO0US5qfm1lIVFId7/7Pw
        bO90EOk4ZKWREEwZeszqcT25Swz+KVC5EQ5/vwrwBolzzaZbsDbhfVE4JhzEH3KRmETdK+
        wpI5ZLpRQecrGgxz9fOojk+YXK3NgdHV20zpn+o1tW/0OPi7qQy4Gpi2WFX8cWWSToOm0w
        FaurpkpwnXFGyId4LP9VlVA6Z7BiAPgpfvQxSJdO+bU4q8iJFqSV6IRepJB7Ng==
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Martinz <amartinz@shiftphones.com>,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 2/2] arm64: dts: qcom/sdm845-shift-axolotl: Add audio support
Date:   Thu,  9 Jun 2022 11:54:12 +0200
Message-Id: <20220609095412.211060-2-amartinz@shiftphones.com>
In-Reply-To: <20220609095412.211060-1-amartinz@shiftphones.com>
References: <20220609095412.211060-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio support for the SHIFT6mq phone.

The primary microphone and headphone jack are handled by the
SDM845 sound card and WCD9340 codec.

The primary speaker needs to go through the TFA9890 speaker
amplifier.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Tested-by: Dylan Van Assche <me@dylanvanassche.be>
---
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index fa72f23ef0c2..8c4967d6d0e3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -8,6 +8,8 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
@@ -492,6 +494,19 @@ touchscreen@38 {
 	};
 };
 
+&i2c11 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tfa9890_codec: tfa9890@34 {
+		compatible = "nxp,tfa9890";
+		reg = <0x34>;
+		vddd-supply = <&vreg_s4a_1p8>;
+		reset-gpio = <&tlmm 7 0>;
+		#sound-dai-cells = <1>;
+	};
+};
+
 &ipa {
 	status = "okay";
 
@@ -530,6 +545,27 @@ volume_down_resin: resin {
 	};
 };
 
+&q6afedai {
+	qi2s@22 {
+		reg = <22>;
+		qcom,sd-lines = <0>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
 /*
  * Prevent garbage data on bluetooth UART lines
  */
@@ -578,6 +614,84 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&sound {
+	model = "SHIFT6mq";
+	compatible = "qcom,sdm845-sndcard";
+	pinctrl-0 = <&quat_mi2s_active &quat_mi2s_sd0_active>;
+	pinctrl-names = "default";
+
+	audio-routing = "RX_BIAS", "MCLK",
+			"AMIC1", "MIC BIAS1",
+			"AMIC2", "MIC BIAS2",
+			"AMIC3", "MIC BIAS3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	speaker-dai-link {
+		link-name = "Speaker Playback";
+		codec {
+			sound-dai = <&tfa9890_codec 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		codec {
+			sound-dai = <&wcd9340 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		codec {
+			sound-dai = <&wcd9340 1>;
+		};
+
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
@@ -686,6 +800,15 @@ config {
 			bias-pull-down;
 		};
 	};
+
+	wcd_intr_default: wcd_intr_default {
+		pins = <54>;
+		function = "gpio";
+
+		input-enable;
+		bias-pull-down;
+		drive-strength = <2>;
+	};
 };
 
 &uart6 {
@@ -756,6 +879,24 @@ &venus {
 	firmware-name = "qcom/sdm845/axolotl/venus.mbn";
 };
 
+&wcd9340 {
+	pinctrl-0 = <&wcd_intr_default>;
+	pinctrl-names = "default";
+	clock-names = "extclk";
+	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+	reset-gpios = <&tlmm 64 0>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+
+	qcom,micbias1-microvolt = <2700000>;
+	qcom,micbias2-microvolt = <2700000>;
+	qcom,micbias3-microvolt = <2700000>;
+	qcom,micbias4-microvolt = <2700000>;
+};
+
 &wifi {
 	status = "okay";
 
-- 
2.36.1

