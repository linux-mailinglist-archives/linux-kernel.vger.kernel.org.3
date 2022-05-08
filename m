Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D1551ECC8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiEHKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiEHKHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:07:35 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DA64CC;
        Sun,  8 May 2022 03:03:41 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B06E03F5FE;
        Sun,  8 May 2022 12:03:39 +0200 (CEST)
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
Subject: [PATCH 2/3] arm64: dts: qcom: sm6125: Append -state suffix to pinctrl nodes
Date:   Sun,  8 May 2022 12:03:34 +0200
Message-Id: <20220508100336.127176-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508100336.127176-1-marijn.suijten@somainline.org>
References: <20220508100336.127176-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to qcom,sm6125-pinctrl.yaml all nodes inside the tlmm must be
suffixed by -state:

    qcom/sm6125-sony-xperia-seine-pdx201.dtb: pinctrl@500000: 'sdc2-off', 'sdc2-on' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

The label names have been updated to match, going from sdc2_state_X to
sdc2_X_state.

Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
Fixes: 82e1783890b7 ("arm64: dts: qcom: sm6125: Add support for Sony Xperia 10II")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts     | 4 ++--
 arch/arm64/boot/dts/qcom/sm6125.dtsi                      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 4916e6c8b625..038970c0b68e 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -88,7 +88,7 @@ &hsusb_phy1 {
 	status = "okay";
 };
 
-&sdc2_state_off {
+&sdc2_off_state {
 	sd-cd {
 		pins = "gpio98";
 		drive-strength = <2>;
@@ -96,7 +96,7 @@ sd-cd {
 	};
 };
 
-&sdc2_state_on {
+&sdc2_on_state {
 	sd-cd {
 		pins = "gpio98";
 		drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 3fadf5196c4d..e601b9bfdc04 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -386,7 +386,7 @@ tlmm: pinctrl@500000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			sdc2_state_off: sdc2-off {
+			sdc2_off_state: sdc2-off-state {
 				clk {
 					pins = "sdc2_clk";
 					drive-strength = <2>;
@@ -406,7 +406,7 @@ data {
 				};
 			};
 
-			sdc2_state_on: sdc2-on {
+			sdc2_on_state: sdc2-on-state {
 				clk {
 					pins = "sdc2_clk";
 					drive-strength = <16>;
@@ -490,8 +490,8 @@ sdhc_2: sdhci@4784000 {
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
 
-			pinctrl-0 = <&sdc2_state_on>;
-			pinctrl-1 = <&sdc2_state_off>;
+			pinctrl-0 = <&sdc2_on_state>;
+			pinctrl-1 = <&sdc2_off_state>;
 			pinctrl-names = "default", "sleep";
 
 			power-domains = <&rpmpd SM6125_VDDCX>;
-- 
2.36.0

