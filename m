Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367D251572B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239102AbiD2VsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiD2Vrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:47:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF2D95FF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so9688049pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCvRMc8O6UF6nBkCvl4Y1MaoOsMJlPHouIeSUnc6aTs=;
        b=JZVQH/T3cyoT0a/katLDkY4iyGevcLlLIJwiaSP8CErJg4aOiipdtnT8dJfv7aoRXN
         wIUg1EYLiGBHLjzylwG1GjgewlnQmbzr8wEdhcfjqaVUNciTVo5vdtzN434TQIzUmT4q
         Y7aitUVOfS4XGFr7s57B9YfZi/IMFqzK2hQ90bFaIe2ZKL/crHpw88oK1J2q5w69oA4t
         4s7OZ3c3p2XmWkXe670Z8W2SG91z8agU0Deebx57hrbsC/2Errspq6NvMUeBle2glpyJ
         WgnRN93hqr7cqOAYn+hyIPQ4UbDSXEbM4k7xFxROiC58OLel1IgPlaHKdsmUeareSOCb
         6LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCvRMc8O6UF6nBkCvl4Y1MaoOsMJlPHouIeSUnc6aTs=;
        b=Zfv36B3bymMN1V2PPd6/buXd6GnEWpc8kxAgq/NWpHOgTUkZcji8mjFvbvDl12c+XY
         CESg8syu3DzXOseWiiDcvq7pfoMX2gJg2plASAXy8ZDJYEcCrA7QTQaLoNqjH/4Xh7cs
         VPAuxdg/84cGaAk4w1WWDghjpCIItbXx1OZhV2N0AoO2Ns0toh4wuQKZHxsRRvnHSrtm
         ySxAgERWO0Q4p5Hr5pV7JDNFqe5emI54nBHBlPWNTQEHK74s0x3yr4zlAXL9fljy+Mfl
         k/s+ID4s5yfcujl/h8aTfLHL+XxG/Qp72zOwOTpVqjYQ1fyVOz6wfgvnFt2lznR0CEa8
         Mptw==
X-Gm-Message-State: AOAM532cB0Q/nDAOHcwYYRYoUoUlIclDjm8z1ZFqc1PMiqxI1cnPutpo
        xVi2C6UEB2HtT4j7EwCeY8cvcg==
X-Google-Smtp-Source: ABdhPJw/fA7eXd0LRZFJpyBTZ/iN577TQC69lOaDivca0FPa2uG6H0qpMm0UGbESuOZjRlBG1fx3rA==
X-Received: by 2002:a17:902:7d86:b0:156:434a:a901 with SMTP id a6-20020a1709027d8600b00156434aa901mr1074869plm.77.1651268675775;
        Fri, 29 Apr 2022 14:44:35 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id fv12-20020a17090b0e8c00b001cd4989fed0sm15271086pjb.28.2022.04.29.14.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:44:35 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 3/3] arm64: dts: qcom: Fix ordering of 'clocks' & 'clock-names' for sdhci nodes
Date:   Sat, 30 Apr 2022 03:14:20 +0530
Message-Id: <20220429214420.854335-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429214420.854335-1-bhupesh.sharma@linaro.org>
References: <20220429214420.854335-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Qualcomm sdhci-msm device-tree binding has been converted
to yaml format, 'make dtbs_check' reports a number of issues with
ordering of 'clocks' & 'clock-names' for sdhci nodes:

 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb: sdhci@7824900:
  clock-names:0: 'iface' was expected

 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb: sdhci@7824900:
  clock-names:1: 'core' was expected

 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb: sdhci@7824900:
  clock-names:2: 'xo' was expected

Fix the same by updating the offending 'dts' files.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 12 ++++++------
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/qcom/qcs404.dtsi  |  6 +++---
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 12 ++++++------
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 12 ++++++------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 14 ++++++++------
 7 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 943243d5515b..8cd4c1fbca17 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -384,10 +384,10 @@ sdhc_1: sdhci@7824900 {
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&xo>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
-				 <&gcc GCC_SDCC1_APPS_CLK>;
-			clock-names = "xo", "iface", "core";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo>;
+			clock-names = "iface", "core", "xo";
 			max-frequency = <384000000>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 05472510e29d..76bbf7984a62 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1472,10 +1472,10 @@ sdhc_1: sdhci@7824000 {
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			mmc-ddr-1_8v;
 			bus-width = <8>;
 			non-removable;
@@ -1490,10 +1490,10 @@ sdhc_2: sdhci@7864000 {
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			bus-width = <4>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 367ed913902c..3c0df737fa92 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -467,10 +467,10 @@ sdhc1: sdhci@f9824900 {
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-			         <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on &sdc1_rclk_on>;
@@ -490,10 +490,10 @@ sdhc2: sdhci@f98a4900 {
 				<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				<&gcc GCC_SDCC2_AHB_CLK>,
-				<&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
 
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index bc446c6002d0..3d6b88aedff2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -798,10 +798,10 @@ sdcc1: sdcc@7804000 {
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index b6df3186e94c..8b4d7d83e582 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -704,10 +704,10 @@ sdhc_1: sdhci@7c4000 {
 					<GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			interconnects = <&aggre1_noc MASTER_EMMC 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_EMMC_CFG 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
@@ -2594,10 +2594,10 @@ sdhc_2: sdhci@8804000 {
 					<GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 
 			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index ccf5e95071f9..11270d90e1cc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -873,10 +873,10 @@ sdhc_1: sdhci@7c4000 {
 				     <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			interconnects = <&aggre1_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_1 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
@@ -2950,10 +2950,10 @@ sdhc_2: sdhci@8804000 {
 				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_2 0>;
 			interconnect-names = "sdhc-ddr","cpu-sdhc";
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index db18b35d4a7d..65c4e955893b 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1278,10 +1278,12 @@ sdhc_2: sdhci@c084000 {
 			interrupt-names = "hc_irq", "pwr_irq";
 
 			bus-width = <4>;
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-					<&gcc GCC_SDCC2_AHB_CLK>,
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+					<&gcc GCC_SDCC2_APPS_CLK>,
 					<&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
+
 
 			interconnects = <&a2noc 3 &a2noc 10>,
 					<&gnoc 0 &cnoc 28>;
@@ -1330,11 +1332,11 @@ sdhc_1: sdhci@c0c4000 {
 					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>,
 				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
-			clock-names = "core", "iface", "xo", "ice";
+			clock-names = "iface", "core", "xo", "ice";
 
 			interconnects = <&a2noc 2 &a2noc 10>,
 					<&gnoc 0 &cnoc 27>;
-- 
2.35.1

