Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7DC5A902B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiIAH0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiIAHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:25:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782A126DC6;
        Thu,  1 Sep 2022 00:24:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso868742wmr.3;
        Thu, 01 Sep 2022 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UdAmWTgkJipeODMGpW+N7ZQfDmGFLYG6XzCqt23eXNc=;
        b=SpQObxbZoUVQ69C0H4fWm7Pr3DFyq8Ct3i/elpvxSnYpxC9rpnAhpRyZR00Q06t0/U
         lGs1mOX1DK+TOT1fcrNNivAfgt8lSovh4ucSMbC/LOH1tJXckcTptLsKG4S9hubNONyV
         7DcHnjlF5pmvaQHhXala85gakrKS15jp3ivAxdawgiUByqTvQpp61DCXBFIHq6uxRUj5
         8yT2Ctdm5WueK5WvxKn5W1WDfGOC+2/3el3641vuL8qjQCdV3URO+5HfPHbB1iUk8ep8
         EUBzWRW6HAK41XnWFTslGQA6mI3/Ct2ATkcAgA9YwYkmW5Hj4EiwNLQ9+YSWHm+wWJX/
         IB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UdAmWTgkJipeODMGpW+N7ZQfDmGFLYG6XzCqt23eXNc=;
        b=E6hQMZhYBNaDhU3cVbEVpac0gyKaa414WpbbzK/DaIwFhuqA/ZGflHGFE3FXbHYHWP
         qqW0pXoMtQdfp0pMgMHxgatKD6T09O/P1UW2gGokm7NfbLlGrrupdkxessMuxhu/g5/N
         uhyCQkN69ditqrbk8n/KMBy2K8IW/Njex7/Fj0yqljT0K/izGEEHQBv4VScNsPHmE44A
         X6pGe0eAeHqgxfF/yEZSIM9BjtPIQCqHeVuovxLKrorcTqs1WlEOYxmdiI8RWHi8V0Ik
         ZtwtBcvRKkiWCY/04zZb8TGCAs3Ec9EeF/Qvjw6FhdG4DO7xGfe7NZBWVirnkVm4GlnA
         114A==
X-Gm-Message-State: ACgBeo1ZyOT7PdDdVQBlE9MxuWKURXeZEgaJLaCj0hz4a2rR/DZFTNFo
        /6nlMDpuhdNBOO0inS+yUFI=
X-Google-Smtp-Source: AA6agR6HYby52/attmvq0MBjTnGuNpyQR3Srj1VL/dtCxkOB/VOb/GPLMuKQgHPOOIMNJMnQ+OHN4Q==
X-Received: by 2002:a05:600c:490:b0:3a5:a6aa:bf2f with SMTP id d16-20020a05600c049000b003a5a6aabf2fmr4155929wme.17.1662017082607;
        Thu, 01 Sep 2022 00:24:42 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b00226f2ab6e2asm1532165wrq.68.2022.09.01.00.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:24:41 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] arm64: dts: qcom: sm6115: Add sdhci nodes and related pinctrl
Date:   Thu,  1 Sep 2022 10:24:06 +0300
Message-Id: <20220901072414.1923075-8-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the two sdhci's present on the SM6115 and the related
pinctrl.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 171 +++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 00fd185c87aa..cde963c56ac9 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -399,6 +399,110 @@ tlmm: pinctrl@500000 {
 			gpio-ranges = <&tlmm 0 0 121>;
 			#gpio-cells = <2>;
 			interrupt-controller;
+
+			sdc1_state_on: sdc1-on {
+				clk {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				rclk {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_state_off: sdc1-off {
+				clk {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				rclk {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc2_state_on: sdc2-on {
+				clk {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				sd-cd {
+					pins = "gpio88";
+					function = "gpio";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
+			sdc2_state_off: sdc2-off {
+				clk {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				sd-cd {
+					pins = "gpio88";
+					function = "gpio";
+					bias-disable;
+					drive-strength = <2>;
+				};
+			};
 		};
 
 		gcc: clock-controller@1400000 {
@@ -449,6 +553,73 @@ rpm_msg_ram: memory@45f0000 {
 			reg = <0x45f0000 0x7000>;
 		};
 
+		sdhc_1: sdhci@4744000 {
+			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x4744000 0x1000>, <0x4745000 0x1000>, <0x4748000 0x8000>;
+			reg-names = "hc", "cqhci", "ice";
+
+			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo_board>,
+				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+			clock-names = "iface", "core", "xo", "ice_core_clk";
+
+			pinctrl-0 = <&sdc1_state_on>;
+			pinctrl-1 = <&sdc1_state_off>;
+			pinctrl-names = "default", "sleep";
+
+			bus-width = <8>;
+			non-removable;
+			status = "disabled";
+		};
+
+		sdhc_2: sdhci@4784000 {
+			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x04784000 0x1000>;
+			reg-names = "hc";
+
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
+
+			pinctrl-0 = <&sdc2_state_on>;
+			pinctrl-1 = <&sdc2_state_off>;
+			pinctrl-names = "default", "sleep";
+
+			power-domains = <&rpmpd SM6115_VDDCX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			iommus = <&apps_smmu 0x00a0 0x0>;
+			resets = <&gcc GCC_SDCC2_BCR>;
+
+			bus-width = <4>;
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			status = "disabled";
+
+			sdhc2_opp_table: sdhc2-opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+			};
+		};
+
 		usb3: usb@4ef8800 {
 			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
 			reg = <0x04ef8800 0x400>;
-- 
2.37.2

