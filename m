Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE4561556
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiF3InR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiF3InN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:43:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2A263BD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:43:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ej4so25581401edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TVbxG/Efdp+Xp6FWpMq53cm0SYgXc6g4XAjPfhZ3Vc=;
        b=F/ZvoG6oXBJjhO3CIgRP3Eai5qBjzyZNzlSKKJaHkLGpzeg8+vGkxCIdVCT/MZUsnv
         IiC5u65mfbOalOcrSGBxWES4h2coLi9MDloK/0A3VgoS28Iu7qAUhKelkiopwrB7ip8M
         u2uNEG7VbwpKvBfMYB3KBvbcWfflLLSQT56p1aiBdcCqz7WtQ5uMJFDJmzKg77YYnarm
         4lyk243pq+els5rA3Kz8d4PhZ6TLq1/lahPfjoGV8Q2mn+C50gRPXH7K8jxkwt9kRVnC
         3+GIghvufBaX9B3i37z+TXR7DMY6aACqI7ROBBan8jMO5io+b34M1WTCJxtK8jEbkZHD
         aTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TVbxG/Efdp+Xp6FWpMq53cm0SYgXc6g4XAjPfhZ3Vc=;
        b=H9KMGhmlCBge3c3X2HJ0N+3H9aDzV//sOz47sUO/1pN+b6OxSTaolvAbJK/oOaQLLF
         C6Q6uTF0AyvSJGfzfeP6f7dixixETIQdtnw0JTL5purmQP49Oti6WjI4/4tSsBvuHbfB
         wVbnV/6DTKMZytCu8DYxhn9NmvnijTIX8r0pjNQUekdriA20VPP958salqgVtvdfAUas
         /+MXZcptXQSxRMHuKgiUA0bN6LwkPWranibCIhuTBx3ak5WxsAhzT0oosJkWNNtFzstz
         c/jpu0MpzAr8iKusnhU3IoK0S4nrgTnkHYfY0UXE4//RjFLnUAgd8Px2S51hVd0+V/6p
         m6+g==
X-Gm-Message-State: AJIora8hm0El8EYUnl5j2bCpk0+JhS/LUOUwhJ2Zdd/5mKWXNa41PNO1
        Dz8NdbhcGyjHeKuM3NaB0umsiw==
X-Google-Smtp-Source: AGRyM1uAqFvIsZEp7TuQNguYADRIyLxNF1cRAe8bMA8owQXgSYJomn2+JQnTeBEg833mJ9lwAWNTtQ==
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id ew4-20020a056402538400b004316d84b451mr9864029edb.46.1656578589954;
        Thu, 30 Jun 2022 01:43:09 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h8-20020a170906260800b00718f4d4f073sm8785841ejc.88.2022.06.30.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:43:09 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: Switch PSCI cpu idle states from PC to OSI
Date:   Thu, 30 Jun 2022 11:42:50 +0300
Message-Id: <20220630084250.1763869-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
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

This switches from the flat PC idle states of sdm845 to OSI hierarchical
idle states. The exceptions are the cheza plaftorms, which need to remain
with PC idle states. So in order allow all the other platforms to switch,
while cheza platforms to remain the same, replace the PC idle states with
the OSI ones in the main SDM845 dtsi, and then override the inherited OSI
states with PC ones, delete inherited psci cpus nodes, domain idle states
and power domain properties.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

In order to maintain bisectability, I kept everything in one patch.

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 132 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 136 +++++++++++++--------
 2 files changed, 214 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index e7e4cc5936aa..8640748fc53c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -145,6 +145,138 @@ panel_in_edp: endpoint {
 	};
 };

+&psci {
+	/delete-node/ cpu0;
+	/delete-node/ cpu1;
+	/delete-node/ cpu2;
+	/delete-node/ cpu3;
+	/delete-node/ cpu4;
+	/delete-node/ cpu5;
+	/delete-node/ cpu6;
+	/delete-node/ cpu7;
+	/delete-node/ cpu-cluster0;
+};
+
+&cpus {
+	/delete-node/ domain-idle-states;
+};
+
+&cpu_idle_states {
+		LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+			compatible = "arm,idle-state";
+			idle-state-name = "little-power-down";
+			arm,psci-suspend-param = <0x40000003>;
+			entry-latency-us = <350>;
+			exit-latency-us = <461>;
+			min-residency-us = <1890>;
+			local-timer-stop;
+		};
+
+		LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
+			compatible = "arm,idle-state";
+			idle-state-name = "little-rail-power-down";
+			arm,psci-suspend-param = <0x40000004>;
+			entry-latency-us = <360>;
+			exit-latency-us = <531>;
+			min-residency-us = <3934>;
+			local-timer-stop;
+		};
+
+		BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+			compatible = "arm,idle-state";
+			idle-state-name = "big-power-down";
+			arm,psci-suspend-param = <0x40000003>;
+			entry-latency-us = <264>;
+			exit-latency-us = <621>;
+			min-residency-us = <952>;
+			local-timer-stop;
+		};
+
+		BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
+			compatible = "arm,idle-state";
+			idle-state-name = "big-rail-power-down";
+			arm,psci-suspend-param = <0x40000004>;
+			entry-latency-us = <702>;
+			exit-latency-us = <1061>;
+			min-residency-us = <4488>;
+			local-timer-stop;
+		};
+
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "arm,idle-state";
+			idle-state-name = "cluster-power-down";
+			arm,psci-suspend-param = <0x400000F4>;
+			entry-latency-us = <3263>;
+			exit-latency-us = <6562>;
+			min-residency-us = <9987>;
+			local-timer-stop;
+		};
+};
+
+&CPU0 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU1 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU2 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU3 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+			   &LITTLE_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU4 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU5 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU6 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
+&CPU7 {
+	/delete-property/ power-domains;
+	/delete-property/ power-domain-names;
+	cpu-idle-states = <&BIG_CPU_SLEEP_0
+			   &BIG_CPU_SLEEP_1
+			   &CLUSTER_SLEEP_0>;
+};
+
 /*
  * Reserved memory changes
  *
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 83439739de37..6bb027d2ab58 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -188,7 +188,7 @@ spss_mem: spss@97b00000 {
 		};
 	};

-	cpus {
+	cpus: cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;

@@ -197,15 +197,14 @@ CPU0: cpu@0 {
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_0>;
 			L2_0: l2-cache {
@@ -222,15 +221,14 @@ CPU1: cpu@100 {
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_100>;
 			L2_100: l2-cache {
@@ -244,15 +242,14 @@ CPU2: cpu@200 {
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_200>;
 			L2_200: l2-cache {
@@ -266,9 +263,6 @@ CPU3: cpu@300 {
 			compatible = "qcom,kryo385";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
-					   &LITTLE_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
 			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -276,6 +270,8 @@ &LITTLE_CPU_SLEEP_1
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
 			#cooling-cells = <2>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			next-level-cache = <&L2_300>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -289,14 +285,13 @@ CPU4: cpu@400 {
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_400>;
 			L2_400: l2-cache {
@@ -311,14 +306,13 @@ CPU5: cpu@500 {
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_500>;
 			L2_500: l2-cache {
@@ -333,14 +327,13 @@ CPU6: cpu@600 {
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_600>;
 			L2_600: l2-cache {
@@ -355,14 +348,13 @@ CPU7: cpu@700 {
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0
-					   &BIG_CPU_SLEEP_1
-					   &CLUSTER_SLEEP_0>;
 			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
 					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			next-level-cache = <&L2_700>;
 			L2_700: l2-cache {
@@ -407,53 +399,35 @@ core7 {
 			};
 		};

-		idle-states {
+		cpu_idle_states: idle-states {
 			entry-method = "psci";

 			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
-				idle-state-name = "little-power-down";
-				arm,psci-suspend-param = <0x40000003>;
+				idle-state-name = "little-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
 				entry-latency-us = <350>;
 				exit-latency-us = <461>;
 				min-residency-us = <1890>;
 				local-timer-stop;
 			};

-			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
-				compatible = "arm,idle-state";
-				idle-state-name = "little-rail-power-down";
-				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <360>;
-				exit-latency-us = <531>;
-				min-residency-us = <3934>;
-				local-timer-stop;
-			};
-
 			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
-				idle-state-name = "big-power-down";
-				arm,psci-suspend-param = <0x40000003>;
+				idle-state-name = "big-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
 				entry-latency-us = <264>;
 				exit-latency-us = <621>;
 				min-residency-us = <952>;
 				local-timer-stop;
 			};
+		};

-			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
-				compatible = "arm,idle-state";
-				idle-state-name = "big-rail-power-down";
-				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <702>;
-				exit-latency-us = <1061>;
-				min-residency-us = <4488>;
-				local-timer-stop;
-			};
-
+		domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
-				compatible = "arm,idle-state";
-				idle-state-name = "cluster-power-down";
-				arm,psci-suspend-param = <0x400000F4>;
+				compatible = "domain-idle-state";
+				idle-state-name = "cluster-power-collapse";
+				arm,psci-suspend-param = <0x4100c244>;
 				entry-latency-us = <3263>;
 				exit-latency-us = <6562>;
 				min-residency-us = <9987>;
@@ -1050,9 +1024,63 @@ slpi_smp2p_in: slave-kernel {
 		};
 	};

-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+
 	};

 	soc: soc@0 {
--
2.34.3

