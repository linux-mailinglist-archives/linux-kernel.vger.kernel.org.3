Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8993572E80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiGMGxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiGMGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:53:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1FDF629
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 72so9699780pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=01vFMdurFLLB2L+21AvnP2mw3p+aEDf6OlIWo3hzJN4=;
        b=EUzdGpNKIulWKMyQ1cjL4jnDgA/l2vRDXwXi+WQTQ/l5rzbiTjFjat1IQYBXGqBreB
         HCzW42mWqE0CBrhZ6sqhEqZDq+EpXkf838oATbqK5DWJR1Vl3tCGednYG4BCljJECFMv
         qf9UPHqvfXyvRZOoM3JhPaso37Uly6SYJ8vRWgyDkm57MSsipHPZo0YWYmb6OBDUIwCr
         zAhGPfuCtNj6cjzfLgKIyzfRmRoZkdV1g4vgcqiUuHH8RKRjdXonHJgQkNiPV4s7G2qC
         DO3Bly1gMjou4+fCjeUrSvrXupWGYMcAgqG/A8WxttImgxeKFVO3LbawcRYRp/Pbx2KF
         70MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01vFMdurFLLB2L+21AvnP2mw3p+aEDf6OlIWo3hzJN4=;
        b=dDLkwyiGW9OuyeYutFjIpoSHxgM3SF9WZ3d6/ApbI5w/F+1Axx2PkKF3se+JQIBaLR
         3kLwxCA2sVFl5O+mW+TrkF9EPPUmt6d3z/Etn7TWWKvQ0xbcMXg6PpJAQPMpBCjEoLye
         03LLfjjzdJr3gAVIAeEW4wgnjPfzX9GK6/c2YloTf0fIcvZ3CGqm77USGPIRY4gEmfEe
         FTFjp1sSIm+V6TVIbz1wSZKcyKuI35zeNi6IhrkLavJ9w4NC0BI6OJX7ZCSRZ4nLjIRr
         2JsSH1aUSpKXqzksvGDpp7RqA8pcZa49KNSfC5DyPiYdJQZpnh8xC0AXe6qRWqEhCfhX
         hBHw==
X-Gm-Message-State: AJIora/L13lEa0tfzrlflle41w5iUjByGSH6Wa5plwx2oX6ZiqWL416j
        FCMQb3CG00ybd6/65JG6ba2K+g==
X-Google-Smtp-Source: AGRyM1vq8SgAr+uTGKmjWKQBrfQ9VPsmQ5+sUYCLQXIkaMpuftq5GcSvwSjtIuXCBcUOzKiN3iMPQA==
X-Received: by 2002:a65:6c08:0:b0:3f2:6a6a:98d with SMTP id y8-20020a656c08000000b003f26a6a098dmr1824359pgu.30.1657695196693;
        Tue, 12 Jul 2022 23:53:16 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b0016be5ed14d5sm8098456pla.40.2022.07.12.23.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:53:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] arm64: dts: qcom: Move clocks to CPU nodes
Date:   Wed, 13 Jul 2022 12:22:57 +0530
Message-Id: <25855e87505d1969fb3fba3661cbf31e44cb2747.1657695140.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657695140.git.viresh.kumar@linaro.org>
References: <cover.1657695140.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock specific properties must be part the consumer nodes, i.e. the
CPUs here, instead of the node that manages the frequency engine.

Move the clocks properties to the CPU node instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 19 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 18 ++++++++++++++++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 18 ++++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 19 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 18 ++++++++++++++++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 19 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++--
 8 files changed, 128 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5dcaac23a138..4c9a5f5e4ab4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -138,6 +138,8 @@ &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -164,6 +166,8 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_100>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -186,6 +190,8 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_200>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -208,6 +214,8 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_300>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -230,6 +238,8 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -252,6 +262,8 @@ &LITTLE_CPU_SLEEP_1
 			capacity-dmips-mhz = <415>;
 			dynamic-power-coefficient = <137>;
 			next-level-cache = <&L2_500>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -274,6 +286,8 @@ &BIG_CPU_SLEEP_1
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_600>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu6_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -296,6 +310,8 @@ &BIG_CPU_SLEEP_1
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <480>;
 			next-level-cache = <&L2_700>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu6_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
@@ -3538,9 +3554,6 @@ cpufreq_hw: cpufreq@18323000 {
 			reg = <0 0x18323000 0 0x1400>, <0 0x18325800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-			clock-names = "xo", "alternate";
-
 			#freq-domain-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index e66fc67de206..f7600dbdd1e1 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -172,6 +172,8 @@ CPU0: cpu@0 {
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_0>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -195,6 +197,8 @@ CPU1: cpu@100 {
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_100>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -215,6 +219,8 @@ CPU2: cpu@200 {
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_200>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -235,6 +241,8 @@ CPU3: cpu@300 {
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_300>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -255,6 +263,8 @@ CPU4: cpu@400 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -275,6 +285,8 @@ CPU5: cpu@500 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_500>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -295,6 +307,8 @@ CPU6: cpu@600 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_600>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -315,6 +329,8 @@ CPU7: cpu@700 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_700>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			operating-points-v2 = <&cpu7_opp_table>;
 			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3>,
 					<&epss_l3 MASTER_EPSS_L3_APPS &epss_l3 SLAVE_EPSS_L3_SHARED>;
@@ -4915,8 +4931,6 @@ cpufreq_hw: cpufreq@18591000 {
 			reg = <0 0x18591000 0 0x1000>,
 			      <0 0x18592000 0 0x1000>,
 			      <0 0x18593000 0 0x1000>;
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
-			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0692ae0e60a4..3154a8f67f76 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -202,6 +202,8 @@ &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -227,6 +229,8 @@ &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -249,6 +253,8 @@ &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -271,6 +277,8 @@ &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -293,6 +301,8 @@ CPU4: cpu@400 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -315,6 +325,8 @@ CPU5: cpu@500 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -337,6 +349,8 @@ CPU6: cpu@600 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -359,6 +373,8 @@ CPU7: cpu@700 {
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -5022,9 +5038,6 @@ cpufreq_hw: cpufreq@17d43000 {
 
 			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
 
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-			clock-names = "xo", "alternate";
-
 			#freq-domain-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d4f8f33f3f0c..645fb73fdad2 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -43,6 +43,8 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_0>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
@@ -62,6 +64,8 @@ CPU1: cpu@100 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_100>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
@@ -78,6 +82,8 @@ CPU2: cpu@200 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_200>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
@@ -94,6 +100,8 @@ CPU3: cpu@300 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_300>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
@@ -110,6 +118,8 @@ CPU4: cpu@400 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
@@ -126,6 +136,8 @@ CPU5: cpu@500 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			next-level-cache = <&L2_500>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
@@ -143,6 +155,8 @@ CPU6: cpu@600 {
 			capacity-dmips-mhz = <1894>;
 			dynamic-power-coefficient = <703>;
 			next-level-cache = <&L2_600>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
@@ -159,6 +173,8 @@ CPU7: cpu@700 {
 			capacity-dmips-mhz = <1894>;
 			dynamic-power-coefficient = <703>;
 			next-level-cache = <&L2_700>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
@@ -1462,8 +1478,6 @@ cpufreq_hw: cpufreq@18323000 {
 			compatible = "qcom,cpufreq-hw";
 			reg = <0 0x18323000 0 0x1000>, <0 0x18325800 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1";
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-			clock-names = "xo", "alternate";
 
 			#freq-domain-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 8ea44c4b56b4..bb38e36ae659 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -51,6 +51,8 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
 			next-level-cache = <&L2_0>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -75,6 +77,8 @@ CPU1: cpu@100 {
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
 			next-level-cache = <&L2_100>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -97,6 +101,8 @@ CPU2: cpu@200 {
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
 			next-level-cache = <&L2_200>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -118,6 +124,8 @@ CPU3: cpu@300 {
 			capacity-dmips-mhz = <488>;
 			dynamic-power-coefficient = <232>;
 			next-level-cache = <&L2_300>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -139,6 +147,8 @@ CPU4: cpu@400 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
 			next-level-cache = <&L2_400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -160,6 +170,8 @@ CPU5: cpu@500 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
 			next-level-cache = <&L2_500>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -181,6 +193,8 @@ CPU6: cpu@600 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <369>;
 			next-level-cache = <&L2_600>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -202,6 +216,8 @@ CPU7: cpu@700 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <421>;
 			next-level-cache = <&L2_700>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			operating-points-v2 = <&cpu7_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -4102,9 +4118,6 @@ cpufreq_hw: cpufreq@18323000 {
 			reg-names = "freq-domain0", "freq-domain1",
 				    "freq-domain2";
 
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-			clock-names = "xo", "alternate";
-
 			#freq-domain-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index cf0c97bd5ad3..29c496e85dda 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -101,6 +101,8 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -125,6 +127,8 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -146,6 +150,8 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -167,6 +173,8 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -188,6 +196,8 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -209,6 +219,8 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -231,6 +243,8 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -252,6 +266,8 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			operating-points-v2 = <&cpu7_opp_table>;
 			interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
@@ -5020,8 +5036,6 @@ cpufreq_hw: cpufreq@18591000 {
 			reg-names = "freq-domain0", "freq-domain1",
 				    "freq-domain2";
 
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-			clock-names = "xo", "alternate";
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 743cba9b683c..c7e9447f0388 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -66,6 +66,8 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -85,6 +87,8 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -101,6 +105,8 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -117,6 +123,8 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
@@ -133,6 +141,8 @@ CPU4: cpu@400 {
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
@@ -149,6 +159,8 @@ CPU5: cpu@500 {
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
@@ -166,6 +178,8 @@ CPU6: cpu@600 {
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
@@ -182,6 +196,8 @@ CPU7: cpu@700 {
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
@@ -2074,9 +2090,6 @@ cpufreq_hw: cpufreq@18591000 {
 			      <0 0x18593000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
 
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
-			clock-names = "xo", "alternate";
-
 			#freq-domain-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7d08fad76371..229cf5eb6447 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -48,6 +48,8 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
@@ -67,6 +69,8 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
@@ -83,6 +87,8 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
@@ -99,6 +105,8 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
@@ -115,6 +123,8 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
@@ -131,6 +141,8 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
@@ -148,6 +160,8 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
@@ -164,6 +178,8 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
 			qcom,freq-domain = <&cpufreq_hw 2>;
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
@@ -2998,8 +3014,6 @@ cpufreq_hw: cpufreq@17d91000 {
 			      <0 0x17d92000 0 0x1000>,
 			      <0 0x17d93000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
-			clock-names = "xo", "alternate";
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.31.1.272.g89b43f80a514

