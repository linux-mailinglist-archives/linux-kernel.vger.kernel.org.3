Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5751A0BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350740AbiEDNYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348396AbiEDNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:23:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002D40E53
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:19:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j6so2806425ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtRXlZ6cLHKAcMNy9RZzniYXCerLrLi7gRFRODKYeuA=;
        b=h0cUVB+2J6EsRUSAXbsvlZuCkuOVTrnIIjx59jxQC4m5XPywkDcVaRvJ1AwCxc844H
         mOZVxSPwiq6xFpP6cAezHduw9kPbPiwkmnOQ0Ed7SkctRf9T/Ra4KoC0hg6T2TBUpiGe
         RtuDtXLg/hELtmUp0G0stcdgv7wokCLVRUqcbDvnABtUblZCiSR3tIaVtrfJxRYrzWDz
         D6W5KhcmCBc0erBTZ8Kp+QORfVWNkh+aME4X/WGL9JTAdYCj4V79FsLOvOSrm1GUTYZE
         475MO7zXv7tLq84eZs6YW+cfVK2LSn9XQR3KX0JG7DdE7MErotJF+K2zM/rwjZG+842S
         5s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtRXlZ6cLHKAcMNy9RZzniYXCerLrLi7gRFRODKYeuA=;
        b=sVB8uhXMSUaJxjMiCrJC1ZkgLBARcYx86LJUL4IPBftlhOIUfWo4G7Lbp3/mCUDbbu
         N65suIOf9zDULO0FZPWFwmHsRySOZzLCXyF6eeL46jhda0gup+vIk33wo1u6q/pfMJFJ
         /IemTwxsiuh9Ug36EWz+9g52Eu/WiPsHzAqymZMirUDdZkL3BQMmCGga3NemNTajhBBw
         +LBP2s1DqvOHrwCJp/bd52x0Q2DbQqv8SOtpvXqvox3QItTSR2jUKe5OrYzWQx/BWYXJ
         LB+9lnDzQO4KXN8hXKAbvVZ8FbGXG+996VHSyrzIDcma3Yu6bWAAFSADCGHQvfELv4mj
         7Grw==
X-Gm-Message-State: AOAM532PFos4KO7YD27sqD2RwZaT042wIbZkoUDdjX3WSfaf2vw8zmdn
        9mqYmSmdps/PBIUAuRWh+NMNdA==
X-Google-Smtp-Source: ABdhPJyQDf58gvAOiIvCu1q0/QJwYa1lbyJA7AR6+c/S6wUKcF13UysUQFWbRgiJQ6paalLOpLihzA==
X-Received: by 2002:a17:907:8a0b:b0:6f4:4899:db98 with SMTP id sc11-20020a1709078a0b00b006f44899db98mr14039008ejc.622.1651670380906;
        Wed, 04 May 2022 06:19:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gx3-20020a1709068a4300b006f3ef214dc4sm5660924ejc.42.2022.05.04.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 06:19:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/13] arm64: dts: qcom: align DWC3 USB clocks with DT schema
Date:   Wed,  4 May 2022 15:19:22 +0200
Message-Id: <20220504131923.214367-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
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

Align order of clocks and their names with Qualcomm DWC3 USB DT schema.
No functional impact expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi   |  2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi     | 11 +++++++----
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  6 +++---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi |  8 ++++----
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 11 +++++++----
 arch/arm64/boot/dts/qcom/msm8994.dtsi |  5 ++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 +++++++++-----
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 11 +++++++----
 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 11 +++++++----
 arch/arm64/boot/dts/qcom/sc7280.dtsi  | 22 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 12 ++++++++----
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 22 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/sm6125.dtsi  | 14 ++++++++++----
 arch/arm64/boot/dts/qcom/sm6350.dtsi  | 11 +++++++----
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 20 ++++++++++++++------
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 20 ++++++++++++++------
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 21 ++++++++++++++-------
 arch/arm64/boot/dts/qcom/sm8450.dtsi  | 10 +++++++---
 18 files changed, 151 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 9d5e934f2272..c5da723f7674 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -646,7 +646,7 @@ usb3: usb3@8af8800 {
 			clocks = <&gcc GCC_USB3_MASTER_CLK>,
 				 <&gcc GCC_USB3_SLEEP_CLK>,
 				 <&gcc GCC_USB3_MOCK_UTMI_CLK>;
-			clock-names = "master", "sleep", "mock_utmi";
+			clock-names = "core", "sleep", "mock_utmi";
 			ranges;
 			status = "disabled";
 
diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 4d45be049613..089033299fa2 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -490,10 +490,13 @@ usb: usb@a6f8800 {
 			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 835de9834833..c89499e366d3 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -662,7 +662,7 @@ usb2: usb@70f8800 {
 			clocks = <&gcc GCC_USB1_MASTER_CLK>,
 				 <&gcc GCC_USB1_SLEEP_CLK>,
 				 <&gcc GCC_USB1_MOCK_UTMI_CLK>;
-			clock-names = "master",
+			clock-names = "core",
 				      "sleep",
 				      "mock_utmi";
 
@@ -741,8 +741,8 @@ usb3: usb@8af8800 {
 				<&gcc GCC_USB0_MASTER_CLK>,
 				<&gcc GCC_USB0_SLEEP_CLK>,
 				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
-			clock-names = "sys_noc_axi",
-				"master",
+			clock-names = "cfg_noc",
+				"core",
 				"sleep",
 				"mock_utmi";
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 253fde08db44..4c38b15c6fd4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -563,8 +563,8 @@ usb_0: usb@8af8800 {
 				<&gcc GCC_USB0_MASTER_CLK>,
 				<&gcc GCC_USB0_SLEEP_CLK>,
 				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
-			clock-names = "sys_noc_axi",
-				"master",
+			clock-names = "cfg_noc",
+				"core",
 				"sleep",
 				"mock_utmi";
 
@@ -603,8 +603,8 @@ usb_1: usb@8cf8800 {
 				<&gcc GCC_USB1_MASTER_CLK>,
 				<&gcc GCC_USB1_SLEEP_CLK>,
 				<&gcc GCC_USB1_MOCK_UTMI_CLK>;
-			clock-names = "sys_noc_axi",
-				"master",
+			clock-names = "cfg_noc",
+				"core",
 				"sleep",
 				"mock_utmi";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 49903a6e9dfd..ffc3ec2cd3bc 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -759,10 +759,13 @@ usb3: usb@70f8800 {
 			clocks = <&gcc GCC_USB_PHY_CFG_AHB_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_PCNOC_USB3_AXI_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface",
-				      "mock_utmi", "sleep";
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 10c1cce74dad..0318d42c5736 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -438,7 +438,10 @@ usb3: usb@f92f8800 {
 				 <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_SLEEP_CLK>,
 				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
-			clock-names = "core", "iface", "sleep", "mock_utmi", "ref", "xo";
+			clock-names = "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b717c01d87e8..9932186f7ceb 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2718,11 +2718,15 @@ usb3: usb@6af8800 {
 			interrupt-names = "hs_phy_irq", "ss_phy_irq";
 
 			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
-				<&gcc GCC_USB30_MASTER_CLK>,
-				<&gcc GCC_AGGRE2_USB3_AXI_CLK>,
-				<&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				<&gcc GCC_USB30_SLEEP_CLK>,
-				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 0200d532b531..758c45bbbe78 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2023,10 +2023,13 @@ usb3: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_AGGRE1_USB3_AXI_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e9f834361660..bedb4991cc5c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -2762,10 +2762,13 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e2857d3393ef..5d51b6ce45ef 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3069,10 +3069,13 @@ usb_2: usb@8cf8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
-				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SEC_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface","mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
@@ -3249,10 +3252,13 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 7f875bf9390a..b72e8e6c52f3 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1215,11 +1215,15 @@ usb3: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
 				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "bus",
-				      "mock_utmi", "sleep";
+				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "bus";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 6af80a627c3a..0692ae0e60a4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3844,10 +3844,13 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
@@ -3892,10 +3895,13 @@ usb_2: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
-				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SEC_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 50def880bc87..135e6e0da27a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -487,12 +487,18 @@ usb3: usb@4ef8800 {
 			#size-cells = <1>;
 			ranges;
 
-			clocks = <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
 				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index fb1a0f662575..d4f8f33f3f0c 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1034,10 +1034,13 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a57a13486c6c..47700697c5ef 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3614,11 +3614,15 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep", "xo";
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
@@ -3659,11 +3663,15 @@ usb_2: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
-				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep", "xo";
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 881550cf7557..c8962acfddbe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2995,11 +2995,15 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_EN>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep", "xo";
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
@@ -3046,11 +3050,15 @@ usb_2: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
-				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_EN>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep", "xo";
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e1eba30dc7ad..dd32b227df49 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2449,10 +2449,13 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep";
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
@@ -2492,11 +2495,15 @@ usb_2: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
-				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_EN>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep", "xo";
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_SEC_MASTER_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7f52c3cfdfb7..e8c19b37ca0e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3107,11 +3107,15 @@ usb_1: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_0_CLKREF_EN>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-				      "sleep", "xo";
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
 
 			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
-- 
2.32.0

