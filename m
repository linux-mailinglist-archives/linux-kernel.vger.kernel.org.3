Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8440246E6AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhLIKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:38:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53972 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhLIKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:38:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30DFECE2576;
        Thu,  9 Dec 2021 10:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50DEC341CD;
        Thu,  9 Dec 2021 10:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046120;
        bh=ew2ogF06dXNGi9pAo0OWriibGYCVYjyM2fN8TTJwYQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koQEO1fWV1//J2ssLSoWLtYGbEF3WPDR6o238d9rePVTb/VF7+tP7EVJxc2kW+ten
         vZXyj1LxHuUTZj5bHpzk6CCtFwDpgc6tJwnGVkUEr3oZDA1z8/vrSiKBBTqPqGqrW5
         6lCgaT/FAF1eDCO9M2idMBK0Chu4/S4qWhYf2A6pMIVbUs9BVy6W88zbqkeUycotIr
         2frESJHY+GZzZ2gsFl64ZoxKkBXAWNTD11qhHhHDQnvvfLcrLfpVNSihSDs9+8Vjai
         uMg3Ic9MA7y1Yl+X73lUBO8pcXVqlzwQq24SqtIz+sa6FqMoAXPN93KpDN7w8R9VX6
         ogM5uGsyrm52w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] arm64: dts: qcom: sm8450: Add tlmm nodes
Date:   Thu,  9 Dec 2021 16:04:54 +0530
Message-Id: <20211209103505.197453-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tlmm node found in SM8450 SoC and uart pin configuration

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 96fbf4be3f89..fb93d53d3433 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -343,6 +343,8 @@ uart7: serial@99c000 {
 				reg = <0 0x0099c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -366,6 +368,32 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,sm8450-tlmm";
+			reg = <0 0x0f100000 0 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 211>;
+			wakeup-parent = <&pdc>;
+
+			qup_uart7_rx: qup-uart7-rx {
+				pins = "gpio26";
+				function = "qup7";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart7_tx: qup-uart7-tx {
+				pins = "gpio27";
+				function = "qup7";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
 		intc: interrupt-controller@17100000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.31.1

