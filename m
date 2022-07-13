Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1933573DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiGMULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiGMULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:11:08 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751702A73D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:11:07 -0700 (PDT)
Received: from localhost.localdomain (abxj14.neoplus.adsl.tpnet.pl [83.9.3.14])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 76E703F7A3;
        Wed, 13 Jul 2022 22:11:04 +0200 (CEST)
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
Subject: [PATCH 3/4] arm64: dts: qcom: sm8450: Add SDHCI2
Date:   Wed, 13 Jul 2022 22:10:46 +0200
Message-Id: <20220713201047.1449786-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713201047.1449786-1-konrad.dybcio@somainline.org>
References: <20220713201047.1449786-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and configure the SDHCI host responsible for (mostly) SD Card and
its corresponding pins' sleep states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 09e7587de0de..daea2fe7f83d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2355,6 +2355,26 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 211>;
 			wakeup-parent = <&pdc>;
 
+			sdc2_sleep_state: sdc2-sleep {
+				clk {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
 			pcie0_default_state: pcie0-default-state {
 				perst {
 					pins = "gpio94";
@@ -3101,6 +3121,45 @@ ufs_mem_phy_lanes: phy@1d87400 {
 			};
 		};
 
+		sdhc_2: sdhci@8804000 {
+			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0 0x08804000 0 0x1000>;
+
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC2_BCR>;
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
+			interconnect-names = "sdhc-ddr","cpu-sdhc";
+			iommus = <&apps_smmu 0x4a0 0x0>;
+			power-domains = <&rpmhpd SM8450_CX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			bus-width = <4>;
+			dma-coherent;
+
+			status = "disabled";
+
+			sdhc2_opp_table: sdhc2-opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+			};
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm8450-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
-- 
2.37.0

