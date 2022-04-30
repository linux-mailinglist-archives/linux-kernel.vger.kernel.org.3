Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B183B515F27
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383069AbiD3Q1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382997AbiD3Q10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:27:26 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E25F8D1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:24:04 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 4F2903F732;
        Sat, 30 Apr 2022 18:24:02 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] arm64: dts: qcom: msm8998-yoshino: Add USB extcon
Date:   Sat, 30 Apr 2022 18:23:43 +0200
Message-Id: <20220430162353.607709-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220430162353.607709-1-konrad.dybcio@somainline.org>
References: <20220430162353.607709-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While not strictly necessary, at least on maple, configure the USB extcon,
which requires two pins on Yoshino.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index fd65dee55626..170cd2df3e5e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -91,6 +91,14 @@ vph_pwr: vph-pwr-regulator {
 		regulator-boot-on;
 	};
 
+	extcon_usb: extcon-usb {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&tlmm 38 GPIO_ACTIVE_HIGH>;
+		vbus-gpio = <&tlmm 128 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_extcon_active &usb_vbus_active>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "Side buttons";
@@ -644,6 +652,13 @@ cam1_vdig_default: cam1-vdig-default {
 		drive-strength = <2>;
 	};
 
+	usb_extcon_active: usb-extcon-active {
+		pins = "gpio38";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <16>;
+	};
+
 	hall_sensor0_default: acc-cover-open {
 		pins = "gpio124";
 		function = "gpio";
@@ -659,6 +674,14 @@ ts_int_n: ts-int-n {
 		bias-pull-up;
 	};
 
+	usb_vbus_active: usb-vbus-active {
+		pins = "gpio128";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
+	};
+
 	ts_vddio_en: ts-vddio-en-default {
 		pins = "gpio133";
 		function = "gpio";
@@ -689,6 +712,7 @@ &usb3 {
 &usb3_dwc3 {
 	/* Force to peripheral until we have Type-C hooked up */
 	dr_mode = "peripheral";
+	extcon = <&extcon_usb>;
 };
 
 &usb3phy {
-- 
2.35.2

