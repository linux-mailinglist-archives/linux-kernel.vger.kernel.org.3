Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAE250CBFF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbiDWPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiDWPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:54:34 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E41AD64F3;
        Sat, 23 Apr 2022 08:51:37 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2BAA0CEA98;
        Sat, 23 Apr 2022 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650729096; bh=4FbqOnvbK4kBZ8h4ATICE2OUK1SQ+ceRmCqQrNZk+pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZuGGHuQC71JOKl/Z2l7lNTNwp6PPN4wQwfnSE75c60m8RS4MbJvZPvKgNpJzEe5wo
         ckgmlDDVP9o4jwaqTQCeVu5wkD5UQWSvngUSpbxCbYPoctLMDfZ1aSzSeg/6jHbPmG
         9e47pgpsY8kWi1661G5l/CiPjLd51SB+BQWBal/g=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: qcom: msm8226: Add ADSP node
Date:   Sat, 23 Apr 2022 17:50:57 +0200
Message-Id: <20220423155059.660387-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423155059.660387-1-luca@z3ntu.xyz>
References: <20220423155059.660387-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the adsp found on msm8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../boot/dts/qcom-apq8026-asus-sparrow.dts    |  2 +
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 65 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
index ace8cea27949..818c1a201227 100644
--- a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
@@ -8,6 +8,8 @@
 #include "qcom-msm8226.dtsi"
 #include "qcom-pm8226.dtsi"
 
+/delete-node/ &adsp_region;
+
 / {
 	model = "ASUS ZenWatch 2";
 	compatible = "asus,sparrow", "qcom,apq8026";
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 28eca15b5712..3016035d5e21 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8974.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,gcc-msm8974.h>
 
 / {
@@ -60,6 +61,11 @@ smem_region: smem@3000000 {
 			reg = <0x3000000 0x100000>;
 			no-map;
 		};
+
+		adsp_region: adsp@dc00000 {
+			reg = <0x0dc00000 0x1900000>;
+			no-map;
+		};
 	};
 
 	smd {
@@ -115,6 +121,31 @@ smem {
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -512,6 +543,40 @@ tcsr_mutex_block: syscon@fd484000 {
 			compatible = "syscon";
 			reg = <0xfd484000 0x2000>;
 		};
+
+		adsp: remoteproc@fe200000 {
+			compatible = "qcom,msm8226-adsp-pil";
+			reg = <0xfe200000 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+			power-domains = <&rpmpd MSM8226_VDDCX>;
+			power-domain-names = "cx";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_region>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			smd-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&apcs 8 8>;
+				qcom,smd-edge = <1>;
+
+				label = "lpass";
+			};
+		};
 	};
 
 	timer {
-- 
2.36.0

