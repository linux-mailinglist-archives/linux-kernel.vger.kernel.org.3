Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE9515F2C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383116AbiD3Q2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383045AbiD3Q1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:27:33 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12A5FF13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:24:10 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 678ED3F744;
        Sat, 30 Apr 2022 18:24:08 +0200 (CEST)
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
Subject: [PATCH 10/14] arm64: dts: qcom: msm8998*: Keep MMCC & MMSS_SMMU enabled by default
Date:   Sat, 30 Apr 2022 18:23:48 +0200
Message-Id: <20220430162353.607709-10-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220430162353.607709-1-konrad.dybcio@somainline.org>
References: <20220430162353.607709-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMCC is a component of the SoC that should always be configured. It was kept
off due to misconfiguration on clamshell machines. Keep it disabled on these
ones and enable it by default on all the others.

Exactly the same story applies to MMSS_SMMU, which directly depends on MMCC.

Do note, that if a platform doesn't use neither EFIFB (only applies to WoA
devices in this case) or simplefb (applies to precisely 2 msm8998 devices
as of this commit), this will not cause any harm.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi    | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts    |  8 --------
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi |  8 --------
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  2 --
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index a8756bcdad3b..7928b8197474 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -93,6 +93,20 @@ &CPU7 {
 	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
 };
 
+/*
+ * If EFIFB is used, enabling MMCC will cause important MMSS clocks to be cleaned
+ * up, because as far as Linux is concerned - they are unused. Disable it by default
+ * on clamshell devices, as it will break them, unless either simplefb is configured to
+ * hold a vote for these clocks, or panels are brought up properly, using drm/msm.
+ */
+&mmcc {
+	status = "disabled";
+};
+
+&mmss_smmu {
+	status = "disabled";
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 33f641ca6c94..56bcd4a1ddb1 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -205,14 +205,6 @@ touchscreen@14 {
 	};
 };
 
-&mmcc {
-	status = "okay";
-};
-
-&mmss_smmu {
-	status = "okay";
-};
-
 &pm8998_gpio {
 	vol_up_pin_a: vol-up-active {
 		pins = "gpio6";
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 9a6e10fb4920..08fe7c00b5ff 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -276,14 +276,6 @@ &lab {
 	regulator-soft-start;
 };
 
-&mmcc {
-	status = "ok";
-};
-
-&mmss_smmu {
-	status = "ok";
-};
-
 &pm8005_regulators {
 	/* VDD_GFX supply */
 	pm8005_s1: s1 {
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 69cdbb104e4c..df7cb679ea59 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2370,7 +2370,6 @@ mmcc: clock-controller@c8c0000 {
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 			reg = <0xc8c0000 0x40000>;
-			status = "disabled";
 
 			clock-names = "xo",
 				      "gpll0",
@@ -2405,7 +2404,6 @@ mmss_smmu: iommu@cd00000 {
 				 <&mmcc BIMC_SMMU_AXI_CLK>;
 			clock-names = "iface-mm", "iface-smmu",
 				      "bus-mm", "bus-smmu";
-			status = "disabled";
 
 			#global-interrupts = <0>;
 			interrupts =
-- 
2.35.2

