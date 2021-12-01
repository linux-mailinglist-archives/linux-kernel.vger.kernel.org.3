Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4076D46486B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347558AbhLAHdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60028 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347488AbhLAHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:32:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BC38B81DB4;
        Wed,  1 Dec 2021 07:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD803C53FD0;
        Wed,  1 Dec 2021 07:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343772;
        bh=/0+0OMCO4Ol9mRu+prhPrggfUn9DX4muACmDlOVzmUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8iMNfkxOgYaYW4QvefD1Ie562FmK+VjqL1TPSQqr9481tjBlgofHclTAU6gMpUDH
         wQp4sDO3nnxWfiKIIvlX71uG/ivWTLadL4BhrZrx585Ss7nG7C7b+Weiz3Q+ciwmpJ
         uuNAmLLWG0m3Ef+Z4paG2xvsnyVh/p1o3GkYTikuVehXLaA9svtbfXNUEWCVSRwz/l
         ldnX+rtQUumy+Qyr0YjBNv2yFQYK5PuqtYB5TeA1eVbrihUpr2iUTpkgByaCLqqcsN
         BX5qQDzOueUxlZ9tOLr6HkILQJw6PeXnV8qmTyYGohF9xZ1pxaiAGQxyQ0UK4UYQma
         upnIM8XrgEB1g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] arm64: dts: qcom: sm8450: Add tlmm nodes
Date:   Wed,  1 Dec 2021 12:59:03 +0530
Message-Id: <20211201072915.3969178-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tlmm node found in SM8450 SoC and uart pin configuration

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d838283bde4b..f0b9e80238a2 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -343,6 +343,8 @@ uart7: serial@99c000 {
 				reg = <0 0x0099c000 0 0x4000>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart7_default_state>;
 				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -366,6 +368,33 @@ pdc: interrupt-controller@b220000 {
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
+			qup_uart7_default_state: qup-uart3-default-state {
+				rx {
+					pins = "gpio26";
+					function = "qup7";
+					drive-strength = <2>;
+					bias-disable;
+				};
+				tx {
+					pins = "gpio27";
+					function = "qup7";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+		};
+
 		intc: interrupt-controller@17100000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.31.1

