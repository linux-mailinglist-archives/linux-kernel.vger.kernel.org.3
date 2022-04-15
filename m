Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD7502901
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbiDOL7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352754AbiDOL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:17 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0746A8EDB;
        Fri, 15 Apr 2022 04:56:49 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id BF9123F642;
        Fri, 15 Apr 2022 13:56:47 +0200 (CEST)
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
Subject: [PATCH 06/23] ARM: dts: qcom-msm8974: Fix up SDHCI nodes
Date:   Fri, 15 Apr 2022 13:56:16 +0200
Message-Id: <20220415115633.575010-7-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add missing labels (and remove their redefinition from klte)
- Commonize bus-width
- Add non-removable on sdhc_1, as it's supposed to have an eMMC on it

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts |  4 ++--
 arch/arm/boot/dts/qcom-msm8974.dtsi             | 13 ++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
index e4a01a631403..571b396f32cf 100644
--- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -534,7 +534,7 @@ te {
 		};
 	};
 
-	sdhc_1: sdhci@f9824900 {
+	sdhci@f9824900 {
 		status = "okay";
 
 		vmmc-supply = <&pma8084_l20>;
@@ -547,7 +547,7 @@ sdhc_1: sdhci@f9824900 {
 		pinctrl-0 = <&sdhc1_pin_a>;
 	};
 
-	sdhc_2: sdhci@f9864900 {
+	sdhci@f9864900 {
 		status = "okay";
 
 		max-frequency = <100000000>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 71fc24e34092..5392c595e5ec 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -740,7 +740,7 @@ blsp2_uart4: serial@f9960000 {
 			status = "disabled";
 		};
 
-		sdhci@f9824900 {
+		sdhc_1: sdhci@f9824900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -751,10 +751,13 @@ sdhci@f9824900 {
 				 <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			bus-width = <8>;
+			non-removable;
+
 			status = "disabled";
 		};
 
-		sdhci@f9864900 {
+		sdhc_3: sdhci@f9864900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -765,10 +768,12 @@ sdhci@f9864900 {
 				 <&gcc GCC_SDCC3_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			bus-width = <4>;
+
 			status = "disabled";
 		};
 
-		sdhci@f98a4900 {
+		sdhc_2: sdhci@f98a4900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
@@ -779,6 +784,8 @@ sdhci@f98a4900 {
 				 <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&xo_board>;
 			clock-names = "core", "iface", "xo";
+			bus-width = <4>;
+
 			status = "disabled";
 		};
 
-- 
2.35.2

