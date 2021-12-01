Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7959464887
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbhLAHdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60332 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347594AbhLAHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF46FB81DB4;
        Wed,  1 Dec 2021 07:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6622BC53FCE;
        Wed,  1 Dec 2021 07:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343791;
        bh=JXRzfFY7RW+lpnD0P5F80pjzcfss6AovJmixExX2ThY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GehYp/GKoWWGbJaAsurHxyAUyiFa4jvhem+FwWTROsjS/IHXZU0l/Aw6+HLM709mQ
         1Jl7edT1ir1mUG8BRCNS7WE9e3yUendvTKIQqEzxAJ0gIzaeNMs/rPdEtHZroRbTcX
         n1sBIx24qX6mDWkLeQ9UCLBuLDQTMcubJuP3vu/Gls1kyVY4wRJXca5pfx54oDbw/p
         2ISF/Mrxd/odhJ81A36owycdiHKZgvpJv4iojOU8WYNohrgdKxiBiCGKC9TtJ+Pxcl
         Gtlzr8vJ4tEtmsKhAaJef+RS0OwooGKljBRdwmu7SNJm53tkIH8dFk/h3GrBOj+GgE
         irUKFuJcPbjPA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] arm64: dts: qcom: sm8450: add interconnect nodes
Date:   Wed,  1 Dec 2021 12:59:10 +0530
Message-Id: <20211201072915.3969178-11-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And the various interconnect nodes found in SM8450 SoC and use it for
UFS controller.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 75827bbfb3ad..4c7cdcea33fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-sm8450.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,sm8450.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -573,6 +574,61 @@ uart7: serial@99c000 {
 			};
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm8450-config-noc";
+			reg = <0 0x01500000 0 0x1c000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mc_virt: interconnect@1580000 {
+			compatible = "qcom,sm8450-mc-virt";
+			reg = <0 0x01580000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1680000 {
+			reg = <0 0x01680000 0 0x1e200>;
+			compatible = "qcom,sm8450-system-noc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pcie_noc: interconnect@16c0000 {
+			reg = <0 0x016c0000 0 0xe280>;
+			compatible = "qcom,sm8450-pcie-anoc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			reg = <0 0x016e0000 0 0x1c080>;
+			compatible = "qcom,sm8450-aggre1-noc";
+			#interconnect-cells = <1>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			reg = <0 0x01700000 0 0x31080>;
+			compatible = "qcom,sm8450-aggre2-noc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			reg = <0 0x01740000 0 0x1f080>;
+			compatible = "qcom,sm8450-mmss-noc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -817,6 +873,13 @@ rpmhcc: clock-controller {
 			};
 		};
 
+		gem_noc: interconnect@19100000 {
+			reg = <0 0x19100000 0 0xbb800>;
+			compatible = "qcom,sm8450-gem-noc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -833,6 +896,9 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			iommus = <&apps_smmu 0xe0 0x0>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
+					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
 			clock-names =
 				"core_clk",
 				"bus_aggr_clk",
@@ -888,6 +954,20 @@ ufs_mem_phy_lanes: lanes@1d87400 {
 				#clock-cells = <0>;
 			};
 		};
+
+		nsp_noc: interconnect@320c0000 {
+			reg = <0 0x320c0000 0 0x10000>;
+			compatible = "qcom,sm8450-nsp-noc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		lpass_ag_noc: interconnect@3c40000 {
+			reg = <0 0x3c40000 0 0x17200>;
+			compatible = "qcom,sm8450-lpass-ag-noc";
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
 	};
 
 	timer {
-- 
2.31.1

