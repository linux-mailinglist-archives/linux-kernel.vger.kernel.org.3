Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FDA502924
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353016AbiDOMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352819AbiDOL7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:42 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CCEB6E4B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:57:08 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id B55953F639;
        Fri, 15 Apr 2022 13:57:05 +0200 (CEST)
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
Subject: [PATCH 16/23] ARM: dts: qcom-msm8974: Convert ADSP to a MMIO device
Date:   Fri, 15 Apr 2022 13:56:26 +0200
Message-Id: <20220415115633.575010-17-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cx-supply has been removed as it's supposed to be set on a
per-board basis.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 60 ++++++++++++++---------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 3370d48e9ad9..32938cdd5497 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -339,36 +339,6 @@ timer {
 		clock-frequency = <19200000>;
 	};
 
-	remoteproc_adsp: adsp-pil {
-		compatible = "qcom,msm8974-adsp-pil";
-
-		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
-		interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
-
-		cx-supply = <&pm8841_s2>;
-
-		clocks = <&xo_board>;
-		clock-names = "xo";
-
-		memory-region = <&adsp_region>;
-
-		qcom,smem-states = <&adsp_smp2p_out 0>;
-		qcom,smem-state-names = "stop";
-
-		smd-edge {
-			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
-
-			qcom,ipc = <&apcs 8 8>;
-			qcom,smd-edge = <1>;
-
-			label = "lpass";
-		};
-	};
-
 	smem {
 		compatible = "qcom,smem";
 
@@ -1590,6 +1560,36 @@ dsi0_phy: dsi-phy@fd922a00 {
 			};
 		};
 
+		remoteproc_adsp: remoteproc@fe200000 {
+			compatible = "qcom,msm8974-adsp-pil";
+			reg = <0xfe200000 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					       <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					       <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					       <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					       <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_region>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			smd-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 8>;
+				qcom,smd-edge = <1>;
+				label = "lpass";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		imem: imem@fe805000 {
 			status = "disabled";
 			compatible = "syscon", "simple-mfd";
-- 
2.35.2

