Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA434DE9D1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiCSRsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbiCSRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:48:29 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52D91DA8C4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:47:07 -0700 (PDT)
Received: from localhost.localdomain (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 357713F660;
        Sat, 19 Mar 2022 18:47:05 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] arm64: dts: qcom: msm8994: Add MMCC node
Date:   Sat, 19 Mar 2022 18:46:35 +0100
Message-Id: <20220319174645.340379-6-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319174645.340379-1-konrad.dybcio@somainline.org>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
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

Describe the Multimedia Clock Controller block in the DT.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index c7bb8235a169..195d8de4cd5a 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -4,6 +4,8 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8994.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8994.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
@@ -1012,6 +1014,44 @@ sdc2_data_off: sdc2-data-off {
 				drive-strength = <2>;
 			};
 		};
+
+		mmcc: clock-controller@fd8c0000 {
+			compatible = "qcom,mmcc-msm8994";
+			reg = <0xfd8c0000 0x5200>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+
+			clock-names = "xo",
+				      "gpll0",
+				      "mmssnoc_ahb",
+				      "oxili_gfx3d_clk_src",
+				      "dsi0pll",
+				      "dsi0pllbyte",
+				      "dsi1pll",
+				      "dsi1pllbyte",
+				      "hdmipll";
+			clocks = <&xo_board>,
+				 <&gcc GPLL0_OUT_MMSSCC>,
+				 <&rpmcc RPM_SMD_MMSSNOC_AHB_CLK>,
+				 <&rpmcc RPM_SMD_GFX3D_CLK_SRC>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+
+			assigned-clocks = <&mmcc MMPLL0_PLL>,
+					  <&mmcc MMPLL1_PLL>,
+					  <&mmcc MMPLL3_PLL>,
+					  <&mmcc MMPLL4_PLL>,
+					  <&mmcc MMPLL5_PLL>;
+			assigned-clock-rates = <800000000>,
+					       <1167000000>,
+					       <1020000000>,
+					       <960000000>,
+					       <600000000>;
+		};
 	};
 
 	timer: timer {
-- 
2.35.1

