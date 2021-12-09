Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2423046E6CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhLIKjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbhLIKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:39:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07566C061A32;
        Thu,  9 Dec 2021 02:36:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5339FCE257D;
        Thu,  9 Dec 2021 10:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65DCC341EE;
        Thu,  9 Dec 2021 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046156;
        bh=hy/ZuyOjHqnswqkjaBTlL9ZQIsvxOkLLm4CahiCjlDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAtKet/4EAFoliscCEWAzPWkzKC2MrcpLwLTkehMH/rSGZas98JM0HZ+HeW2MPzrx
         6+3MgXeTSJ/5R63HunsfVr9jP0N9fk4RwTDfIkJ5PEGHiXGiVhg+TepupFD0gXj0i5
         697YUZk7xgziYwbj6hthmKLRNvFq7hykquUXspXPE8tuB1OtIZHegy7ySyWWU3EKtL
         XNCOOSUTJIFElmgHu/U8NZUi8gnreL38PABM72VREK9F30daJU3pxsPBJUAgyA/DWv
         U4tIQKegHk7gbT41/R08twf+ZbjfVTcQFK8/Yy2EOa6U3zcSrLKhNPVswhnM8iNgIn
         RbrD+KnDzvWmw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 13/13] arm64: dts: qcom: sm8450: add i2c13 and i2c14 device nodes
Date:   Thu,  9 Dec 2021 16:05:05 +0530
Message-Id: <20211209103505.197453-14-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Add device tree nodes for two i2c blocks: i2c13 and i2c14.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 94bc8b352547..c214ab89b44c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -583,6 +583,44 @@ uart7: serial@99c000 {
 			};
 		};
 
+		qupv3_id_1: geniqup@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x00ac0000 0x0 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			i2c13: i2c@a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a94000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c13_data_clk>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c14: i2c@a98000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0 0x00a98000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c14_data_clk>;
+				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		config_noc: interconnect@1500000 {
 			compatible = "qcom,sm8450-config-noc";
 			reg = <0 0x01500000 0 0x1c000>;
@@ -683,6 +721,20 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 211>;
 			wakeup-parent = <&pdc>;
 
+			qup_i2c13_data_clk: qup-i2c13-data-clk {
+				pins = "gpio48", "gpio49";
+				function = "qup13";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c14_data_clk: qup-i2c14-data-clk {
+				pins = "gpio52", "gpio53";
+				function = "qup14";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
 			qup_uart7_rx: qup-uart7-rx {
 				pins = "gpio26";
 				function = "qup7";
-- 
2.31.1

