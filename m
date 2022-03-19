Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC87D4DE9E0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbiCSRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiCSRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:48:42 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D862467E5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:47:18 -0700 (PDT)
Received: from localhost.localdomain (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 5DD053F64C;
        Sat, 19 Mar 2022 18:47:16 +0100 (CET)
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
Subject: [PATCH 12/15] arm64: dts: qcom: msm8994: Add OCMEM node
Date:   Sat, 19 Mar 2022 18:46:42 +0100
Message-Id: <20220319174645.340379-13-konrad.dybcio@somainline.org>
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

Add OCMEM node to allow for GPU SRAM access.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi |  8 ++++++++
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 1de1d9c4643d..92c1f87d6bba 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -24,6 +24,14 @@ &mmcc {
 			       <800000000>;
 };
 
+&ocmem {
+	reg = <0xfdd00000 0x2000>, <0xfec00000 0x100000>;
+
+	gmu-sram@0 {
+		reg = <0x0 0x80000>;
+	};
+};
+
 &rpmcc {
 	compatible = "qcom,rpmcc-msm8992";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index a2210cf9d0b4..2f531e93f3c6 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -1052,6 +1052,23 @@ mmcc: clock-controller@fd8c0000 {
 					       <960000000>,
 					       <600000000>;
 		};
+
+		ocmem: ocmem@fdd00000 {
+			compatible = "qcom,msm8974-ocmem";
+			reg = <0xfdd00000 0x2000>,
+			      <0xfec00000 0x200000>;
+			reg-names = "ctrl", "mem";
+			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
+				 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
+			clock-names = "core", "iface";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gmu_sram: gmu-sram@0 {
+				reg = <0x0 0x180000>;
+			};
+		};
 	};
 
 	timer: timer {
-- 
2.35.1

