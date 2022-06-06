Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1FC53E775
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiFFNXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbiFFNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:23:38 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216426AE4;
        Mon,  6 Jun 2022 06:23:36 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0BBFCCCD41;
        Mon,  6 Jun 2022 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654521815; bh=SugJZ3N7itj+AQjc/th4lWFZxXLSDruuiFiYAcg6tgU=;
        h=From:To:Cc:Subject:Date;
        b=pTGmjpsnb+e9O7cE+ctoCkP1rhL3sx4dgInO6z/RDCUs97pMU0OMKKIkBmbmAfl/e
         jwsfnTmYSYUCHBmj3W63iL2OZ89fcCCFO0NMRngU9LH2oReLYNQFaoRh30ALGdsL6D
         4fHh/DJrYJLHU2WPLj0KoaYYs7TTRrQO8gA3P+xE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: remoteproc: qcom: q6v5: fix example
Date:   Mon,  6 Jun 2022 15:23:24 +0200
Message-Id: <20220606132324.1497349-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the node in the examples that is present in msm8974.dtsi, which uses
proper flags for the interrupts and add required 'xo' clock among
others.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../bindings/remoteproc/qcom,q6v5.txt         | 41 +++++++++++--------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index b677900b3aae..f861862b9770 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -257,29 +257,23 @@ related to the Hexagon.  See ../soc/qcom/qcom,smd.yaml and
 The following example describes the resources needed to boot control the
 Hexagon, as it is found on MSM8974 boards.
 
-	modem-rproc@fc880000 {
-		compatible = "qcom,q6v5-pil";
-		reg = <0xfc880000 0x100>,
-		      <0xfc820000 0x020>;
+	remoteproc@fc880000 {
+		compatible = "qcom,msm8974-mss-pil";
+		reg = <0xfc880000 0x100>, <0xfc820000 0x020>;
 		reg-names = "qdsp6", "rmb";
 
-		interrupts-extended = <&intc 0 24 1>,
-				      <&modem_smp2p_in 0 0>,
-				      <&modem_smp2p_in 1 0>,
-				      <&modem_smp2p_in 2 0>,
-				      <&modem_smp2p_in 3 0>;
-		interrupt-names = "wdog",
-				  "fatal",
-				  "ready",
-				  "handover",
-				  "stop-ack";
+		interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
+				      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+				      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+				      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
 
 		clocks = <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
 			 <&gcc GCC_MSS_CFG_AHB_CLK>,
-			 <&gcc GCC_BOOT_ROM_AHB_CLK>;
-		clock-names = "iface", "bus", "mem";
-
-		qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
+			 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+			 <&xo_board>;
+		clock-names = "iface", "bus", "mem", "xo";
 
 		resets = <&gcc GCC_MSS_RESTART>;
 		reset-names = "mss_restart";
@@ -289,6 +283,8 @@ Hexagon, as it is found on MSM8974 boards.
 		mx-supply = <&pm8841_s1>;
 		pll-supply = <&pm8941_l12>;
 
+		qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
+
 		qcom,smem-states = <&modem_smp2p_out 0>;
 		qcom,smem-state-names = "stop";
 
@@ -299,4 +295,13 @@ Hexagon, as it is found on MSM8974 boards.
 		mpss {
 			memory-region = <&mpss_region>;
 		};
+
+		smd-edge {
+			interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,ipc = <&apcs 8 12>;
+			qcom,smd-edge = <0>;
+
+			label = "modem";
+		};
 	};
-- 
2.36.1

