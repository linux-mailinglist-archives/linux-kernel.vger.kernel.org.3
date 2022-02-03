Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418074A7CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348572AbiBCA3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:29:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49480 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiBCA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:29:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C0460F70;
        Thu,  3 Feb 2022 00:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DAFC004E1;
        Thu,  3 Feb 2022 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643848188;
        bh=qbauBxRZfFJXJcEvFeOVzCSZEL6mvF1hBgdnTbdFeI8=;
        h=From:To:Cc:Subject:Date:From;
        b=kGoMuLq8TOLnaZPtZaJWBw63kgW2ytM5niYrgefeCG7FKn4V6YysUgbS6L2NOUKRC
         kbj7w+KQtcZiBa0BXa+0mnuYyAVrqzuwJjyTEkKyhA8U3jf3xGL8rSlPz4SVqjB8ZT
         fNqc7XpWFFSdQlQBLglww+EJXWgUbKCqzdCkqRC/O04GcecpqmvWFG4BvzgKpMd0rz
         QfvEII4p0jZvFbGOi5/37fvBVZi3R0+/BPvWEoo0J7QcUvQbrSaMMc72iZbBjFu2mC
         C0hOLaO4K2aOGZMysjurlwzjaDBIm4/VN6g4C2ZB6u7hfbCO3GeQXqUzz9qd1QFXrR
         IdVmyY7Yt9XMQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm8450: add interconnect nodes
Date:   Thu,  3 Feb 2022 05:59:36 +0530
Message-Id: <20220203002936.3009402-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And the various interconnect nodes found in SM8450 SoC and use it for
UFS controller.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---

Changes in v2:
	- Fix the mc_virt node
	- Add clk_virt node
	- Rebase to rc1

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 10c25ad2d0c7..ccc67918c46a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/interconnect/qcom,sm8450.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -250,6 +251,18 @@ scm: scm {
 		};
 	};
 
+	clk_virt: interconnect@0 {
+		compatible = "qcom,sm8450-clk-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	mc_virt: interconnect@1 {
+		compatible = "qcom,sm8450-mc-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
 	memory@a0000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -620,6 +633,54 @@ i2c14: i2c@a98000 {
 			};
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm8450-config-noc";
+			reg = <0 0x01500000 0 0x1c000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1680000 {
+			compatible = "qcom,sm8450-system-noc";
+			reg = <0 0x01680000 0 0x1e200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		pcie_noc: interconnect@16c0000 {
+			compatible = "qcom,sm8450-pcie-anoc";
+			reg = <0 0x016c0000 0 0xe280>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm8450-aggre1-noc";
+			reg = <0 0x016e0000 0 0x1c080>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm8450-aggre2-noc";
+			reg = <0 0x01700000 0 0x31080>;
+			#interconnect-cells = <2>;
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
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -988,6 +1049,13 @@ cpufreq_hw: cpufreq@17d91000 {
 			#freq-domain-cells = <1>;
 		};
 
+		gem_noc: interconnect@19100000 {
+			compatible = "qcom,sm8450-gem-noc";
+			reg = <0 0x19100000 0 0xbb800>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -1004,6 +1072,9 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			iommus = <&apps_smmu 0xe0 0x0>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
+					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
 			clock-names =
 				"core_clk",
 				"bus_aggr_clk",
@@ -1102,6 +1173,20 @@ usb_1_dwc3: usb@a600000 {
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
+
+		nsp_noc: interconnect@320c0000 {
+			compatible = "qcom,sm8450-nsp-noc";
+			reg = <0 0x320c0000 0 0x10000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		lpass_ag_noc: interconnect@3c40000 {
+			compatible = "qcom,sm8450-lpass-ag-noc";
+			reg = <0 0x3c40000 0 0x17200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
 	};
 
 	timer {
-- 
2.31.1

