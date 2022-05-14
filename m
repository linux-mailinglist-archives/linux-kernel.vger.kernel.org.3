Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA993527453
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiENVzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiENVys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0288F2DAB2
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so11113233plk.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NA8yQhD9uR4XpE+J5Tv4lK1OtXwMbiM19OGeD+Yvc0=;
        b=dQueLe2E+xIqElBrLZerlL3uK1Z/T4RUfWioJIsqqx8MMqJ++If+Mf5+bWcxzLyuJP
         cTZHXuROgDnqv0ybm4TB/sN2em9hSgXl24fI3MA49Qvf+CpWeOnUsE/On9UNI/Bl+bF9
         n/LeYNk5H5LWQ+6xvbQ2FGeEf8S3XAdaz1NYIWPhJnJEz3Iag37PKbNheecJAzPEbJn2
         0JYNnnO2QPyq0FLm61BiZR/uaNP3gL9bY3jYw3E/S2i9uManLW9HcLpag7IJMpI6jv42
         S1htLABUxqh+MhqZJ7qbOobVqJEYOnZK+2sLrglKF7E1C0CH2NpjNXxnY1jYauzR2NX4
         JCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NA8yQhD9uR4XpE+J5Tv4lK1OtXwMbiM19OGeD+Yvc0=;
        b=jewD+5iXlOzGQ4h8PiJm8Z/W6LoQP5ZMdN8bp32B8uSPCUt9KnqA1vLIy8gWI3953Z
         DUUsYx9xjGq2DXAw0VmkkR6pGTI5q45LitgMU/DgZ0OKQSqyDfBrBb0oXIlu/Xw9irgE
         qlTpoRF6J7W5cFZ52NUSYgNp0/5bdeK3iFmkBUZph9IyApBTBahTMfBDv8fauTZoVOCB
         iFbqnS3pm7dAkGgA36lWAXEKF21Dk3fvpDXe2JvxGiDynbexvPfNdGChMokI44Yrdi0y
         gTigO48iX6D4XanO5IsQ+wJ0/8Pk7xjtK46RsIzFtlAn1jkyEgqDFdMTqLrDqnrkRe/K
         kAig==
X-Gm-Message-State: AOAM531SHYnCuEqGl4Dlf8/1+rGDEF4u6jQVUYJLXFM0RiQUKtYDAeIW
        BuxJi+Mat2xGc4Uf6RLFQW+bsQ==
X-Google-Smtp-Source: ABdhPJxqxWjzuEmAtKkxj7t14etkOzrua38LB0zf8b/2WCdpKJmVC6pfXiIznWNxn1hPVYZOCsxIfQ==
X-Received: by 2002:a17:903:18a:b0:15e:c983:7c14 with SMTP id z10-20020a170903018a00b0015ec9837c14mr10689981plg.9.1652565286032;
        Sat, 14 May 2022 14:54:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015e8d4eb2d2sm4189522plx.284.2022.05.14.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:45 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: Fix ordering of 'clocks' & 'clock-names' for sdhci nodes
Date:   Sun, 15 May 2022 03:24:22 +0530
Message-Id: <20220514215424.1007718-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 9dff30c8fc85..ab2a1e7955b5 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -384,10 +384,10 @@ sdhc_1: mmc@7824900 {
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
index aadefb38a7cf..9cd7c625d331 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1472,10 +1472,10 @@ sdhc_1: mmc@7824000 {
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
@@ -1490,10 +1490,10 @@ sdhc_2: mmc@7864000 {
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
index 99230e8d643f..362960d3fd18 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -470,10 +470,10 @@ sdhc1: mmc@f9824900 {
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
@@ -493,10 +493,10 @@ sdhc2: mmc@f98a4900 {
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
index 97c4e6c6f6c8..86dbf8ea04bc 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -798,10 +798,10 @@ sdcc1: mmc@7804000 {
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
index df0006d4a560..9076892ff4f8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -704,10 +704,10 @@ sdhc_1: mmc@7c4000 {
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
@@ -2587,10 +2587,10 @@ sdhc_2: mmc@8804000 {
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
index f1e86effa063..e63d1a4499f8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -873,10 +873,10 @@ sdhc_1: mmc@7c4000 {
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
@@ -2950,10 +2950,10 @@ sdhc_2: mmc@8804000 {
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
index 34b177f0ce87..6d872e2f400a 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1282,10 +1282,12 @@ sdhc_2: mmc@c084000 {
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
@@ -1334,11 +1336,11 @@ sdhc_1: mmc@c0c4000 {
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
2.35.3

