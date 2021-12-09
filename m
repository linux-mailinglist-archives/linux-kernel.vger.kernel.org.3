Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC046E6C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhLIKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhLIKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:39:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642DCC0617A2;
        Thu,  9 Dec 2021 02:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A9080CE255A;
        Thu,  9 Dec 2021 10:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4903AC341C6;
        Thu,  9 Dec 2021 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046142;
        bh=9sq8ndYzSGXB8R3Q0+KkZsXPLEcGo+K6kQVSHJ1KZmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjNsUjkAW1LN7TqgA6I3jQLmBSrqDFcVnUrs9F14h3evoxc1QDkSZ4SaHLCdfTsot
         i/BuFM7lZkVoJjHrRLOAWhUTgqZmT/ZfQ6H4C9iHaxH9M0tmxGblPG5zG5XLX/l+3P
         Nx5WZJpdFh73AG6DGxjxjavb+7Y44Fs8L0UNsJJevEQrm3bgF2eCN+pHPhoPiXHmC0
         qfFUNXDau4GEXwbECTo4rro+flIdUDiLfoNb5YFAbyScdRQa7QevJy2X1TFCUSfXyG
         1kD7nzkXRxbRsimRVROgGAn0m+jCg/1YlLT4KzV2JuH5SdfT7VTpHkpRRwDfw9ko0d
         ZTGCVP3f9UDQA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] arm64: dts: qcom: sm8450: add interconnect nodes
Date:   Thu,  9 Dec 2021 16:05:01 +0530
Message-Id: <20211209103505.197453-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
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
index 9556d2fc46e0..f75de777f6ea 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm8450.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/gpio/gpio.h>
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
+			compatible = "qcom,sm8450-system-noc";
+			reg = <0 0x01680000 0 0x1e200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pcie_noc: interconnect@16c0000 {
+			compatible = "qcom,sm8450-pcie-anoc";
+			reg = <0 0x016c0000 0 0xe280>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm8450-aggre1-noc";
+			reg = <0 0x016e0000 0 0x1c080>;
+			#interconnect-cells = <1>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm8450-aggre2-noc";
+			reg = <0 0x01700000 0 0x31080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sm8450-mmss-noc";
+			reg = <0 0x01740000 0 0x1f080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -816,6 +872,13 @@ rpmhcc: clock-controller {
 			};
 		};
 
+		gem_noc: interconnect@19100000 {
+			compatible = "qcom,sm8450-gem-noc";
+			reg = <0 0x19100000 0 0xbb800>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -832,6 +895,9 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			iommus = <&apps_smmu 0xe0 0x0>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
+					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
 			clock-names =
 				"core_clk",
 				"bus_aggr_clk",
@@ -887,6 +953,20 @@ ufs_mem_phy_lanes: lanes@1d87400 {
 				#clock-cells = <0>;
 			};
 		};
+
+		nsp_noc: interconnect@320c0000 {
+			compatible = "qcom,sm8450-nsp-noc";
+			reg = <0 0x320c0000 0 0x10000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		lpass_ag_noc: interconnect@3c40000 {
+			compatible = "qcom,sm8450-lpass-ag-noc";
+			reg = <0 0x3c40000 0 0x17200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
 	};
 
 	timer {
-- 
2.31.1

