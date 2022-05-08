Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0F51ECC7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiEHKHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiEHKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:07:35 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F436473
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 03:03:41 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 069A03EE78;
        Sun,  8 May 2022 12:03:38 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: qcom: sm6125: Move sdc2 pinctrl from seine-pdx201 to sm6125
Date:   Sun,  8 May 2022 12:03:33 +0200
Message-Id: <20220508100336.127176-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.0
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

Both the sdc2-on and sdc2-off pinctrl nodes are used by the
sdhci@4784000 node in sm6125.dtsi.  Surprisingly sdc2-off is defined in
sm6125, yet its sdc2-on counterpart is only defined in board-specific DT
for the Sony Seine PDX201 board/device resulting in an "undefined label
&sdc2_state_on" error if sm6125.dtsi were included elsewhere.
This sm6125 base dtsi should not rely on externally defined labels; the
properties referencing it should then also be written externally.
Since the sdc2-on pin configuration is board-independent just like
sdc2-off, move it from seine-pdx201.dts into sm6125.dtsi.

The SDCard-detect pin (gpio98) is however board-specific, and remains as
an overwrite in seine-pdx201.dts for both the on and off state.

As a drive-by cleanup, reorder bias- and drive-strength properties.

Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
Fixes: 82e1783890b7 ("arm64: dts: qcom: sm6125: Add support for Sony Xperia 10II")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 34 +++++--------------
 arch/arm64/boot/dts/qcom/sm6125.dtsi          | 24 +++++++++++--
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 871ccbba445b..4916e6c8b625 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -91,8 +91,16 @@ &hsusb_phy1 {
 &sdc2_state_off {
 	sd-cd {
 		pins = "gpio98";
+		drive-strength = <2>;
 		bias-disable;
+	};
+};
+
+&sdc2_state_on {
+	sd-cd {
+		pins = "gpio98";
 		drive-strength = <2>;
+		bias-pull-up;
 	};
 };
 
@@ -102,32 +110,6 @@ &sdhc_1 {
 
 &tlmm {
 	gpio-reserved-ranges = <22 2>, <28 6>;
-
-	sdc2_state_on: sdc2-on {
-		clk {
-			pins = "sdc2_clk";
-			bias-disable;
-			drive-strength = <16>;
-		};
-
-		cmd {
-			pins = "sdc2_cmd";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-
-		data {
-			pins = "sdc2_data";
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-
-		sd-cd {
-			pins = "gpio98";
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-	};
 };
 
 &usb3 {
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index e81b2a7794fb..3fadf5196c4d 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -389,20 +389,40 @@ tlmm: pinctrl@500000 {
 			sdc2_state_off: sdc2-off {
 				clk {
 					pins = "sdc2_clk";
-					bias-disable;
 					drive-strength = <2>;
+					bias-disable;
 				};
 
 				cmd {
 					pins = "sdc2_cmd";
+					drive-strength = <2>;
 					bias-pull-up;
+				};
+
+				data {
+					pins = "sdc2_data";
 					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_state_on: sdc2-on {
+				clk {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
 				};
 
 				data {
 					pins = "sdc2_data";
+					drive-strength = <10>;
 					bias-pull-up;
-					drive-strength = <2>;
 				};
 			};
 		};
-- 
2.36.0

