Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896A50BA73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448837AbiDVOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448814AbiDVOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:45:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DE5BE60
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:42:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t11so16761220eju.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzFn2/g7sDgiQbcroTEeiTulBXi0PZf5vVz0LWiJmqU=;
        b=LO5Oh/IQhAJvRBohzYA81vWqc98/FbUV76QWhvxCZcQUnnqqYdHTjSLMHmKGVe4Pau
         zR5VOhJHo74iopsuD4xoFr7pwGPWu/ksiO7x3bytQ4w5XRW0wbUP5m1hAyrmv1eMN+8k
         sCPI/jyKwLEqhYknFn3x+cFHxM84I+IhwkIpdmtUl4wYLZtrorPL/Jj5B6yssrc/B7iW
         X9MRteQzYIJ+lJdSsi/DHsbb7LMg3og6G5cMr0uD1hPuD7KVvMMGt/4KRsMvu6PDfCq7
         WgngdK2BxXEm2UBV6jjLSS3HBoDnlgSHif7Dmi7jZ0cEgqI3YnQbxPq5J8bt4cQrEzSo
         7sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzFn2/g7sDgiQbcroTEeiTulBXi0PZf5vVz0LWiJmqU=;
        b=KJkYsJcki4WX0D9nRuGJvJqJBjYOe0/Mc0+CKZ3eeF+jRMeb6J0uO+ButTVRnh0/s+
         t64ixAOD9o60nw9SNXzeJCG09pjIZSQ/vsv+RDRpofZNeVrIv0RnpjSwhjTy09wN7/aV
         gGq9hHfZzFDSlGQ8fGMbb9qtNI+nlR6KhaVlA35aU3TKnEn2q4/q12jZWbkvueUiwz/T
         NSMJMboUh+C9GbHIOseZh6+kpYTMHAD0iHuswO4BfER+qbjUTMKBtwQxhSrqcGSWKsfn
         yutHraRFjtFEIFTYPnfq4qBRte0OPn/MQiIg1VulTvXteOgnNtQmZZ+HJlDsEtzs8HUw
         kwZg==
X-Gm-Message-State: AOAM531yOjK0ZzvKDz4m+yjZk+OVMfq05lvijWLS/bLjkVvOpVHwINLo
        gcP4yM2tFdeJDI49I1XjNs8AiQ==
X-Google-Smtp-Source: ABdhPJx6XHxj0UvuwpOzKD9WEnEXnHfjsw/GJVDSws+KxEBNo5pSy/yr/gpwgTWET7+U2kuP6UWMjw==
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id cr21-20020a170906d55500b006db148e05ccmr4358609ejc.63.1650638528269;
        Fri, 22 Apr 2022 07:42:08 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm818202ejc.176.2022.04.22.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:42:07 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: sm6350: Add interconnect support
Date:   Fri, 22 Apr 2022 16:40:20 +0200
Message-Id: <20220422144021.232993-5-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220422144021.232993-1-luca.weiss@fairphone.com>
References: <20220422144021.232993-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the different NoC providers that are found in SM6350 and
populate different nodes that use the interconnect properties.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Newer SoCs seem to have switched to using #interconnect-cells = <2>;
Is this something that should be done for all new implementations as
well? The 'tag' in the second cell seems to be 0 for all cases in
mainline except CPU.

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index fb1a0f662575..6fb6f75a98bf 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1,11 +1,13 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
  * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Luca Weiss <luca.weiss@fairphone.com>
  */
 
 #include <dt-bindings/clock/qcom,gcc-sm6350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,sm6350.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -539,6 +541,10 @@ i2c0: i2c@880000 {
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 &clk_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &clk_virt SLAVE_EBI_CH0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -552,6 +558,10 @@ i2c2: i2c@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 &clk_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &clk_virt SLAVE_EBI_CH0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 		};
@@ -578,6 +588,10 @@ i2c6: i2c@980000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 &clk_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &clk_virt SLAVE_EBI_CH0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -591,6 +605,10 @@ i2c7: i2c@984000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 &clk_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &clk_virt SLAVE_EBI_CH0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -604,6 +622,10 @@ i2c8: i2c@988000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 &clk_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &clk_virt SLAVE_EBI_CH0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -615,6 +637,9 @@ uart9: serial@98c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 &clk_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -628,11 +653,62 @@ i2c10: i2c@990000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 &clk_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &clk_virt SLAVE_EBI_CH0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm6350-config-noc";
+			reg = <0 0x01500000 0 0x28000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sm6350-system-noc";
+			reg = <0 0x01620000 0 0x17080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+
+			clk_virt: interconnect-clk-virt {
+				compatible = "qcom,sm6350-clk-virt";
+				#interconnect-cells = <1>;
+				qcom,bcm-voters = <&apps_bcm_voter>;
+			};
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm6350-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm6350-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f880>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+
+			compute_noc: interconnect-compute-noc {
+				compatible = "qcom,sm6350-compute-noc";
+				#interconnect-cells = <1>;
+				qcom,bcm-voters = <&apps_bcm_voter>;
+			};
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sm6350-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,sm6350-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -933,6 +1009,10 @@ sdhc_2: sdhci@8804000 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "iface", "core", "xo";
+			interconnects = <&aggre2_noc MASTER_SDCC_2 &clk_virt SLAVE_EBI_CH0>,
+					<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_SDCC_2>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
 			qcom,dll-config = <0x0007642c>;
 			qcom,ddr-config = <0x80040868>;
 			power-domains = <&rpmhpd 0>;
@@ -947,11 +1027,15 @@ sdhc2_opp_table: sdhc2-opp-table {
 				opp-100000000 {
 					opp-hz = /bits/ 64 <100000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-peak-kBps = <790000 131000>;
+					opp-avg-kBps = <50000 50000>;
 				};
 
 				opp-202000000 {
 					opp-hz = /bits/ 64 <202000000>;
 					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <3190000 294000>;
+					opp-avg-kBps = <261438 300000>;
 				};
 			};
 		};
@@ -1017,12 +1101,33 @@ dp_phy: dp-phy@88ea200 {
 			};
 		};
 
+		dc_noc: interconnect@9160000 {
+			compatible = "qcom,sm6350-dc-noc";
+			reg = <0 0x09160000 0 0x3200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm6350-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
 			reg-names = "llcc_base", "llcc_broadcast_base";
 		};
 
+		gem_noc: interconnect@9680000 {
+			compatible = "qcom,sm6350-gem-noc";
+			reg = <0 0x09680000 0 0x3e200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		npu_noc: interconnect@9990000 {
+			compatible = "qcom,sm6350-npu-noc";
+			reg = <0 0x09990000 0 0x1600>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm6350-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -1051,6 +1156,10 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			interconnects = <&aggre2_noc MASTER_USB3 &clk_virt SLAVE_EBI_CH0>,
+					<&gem_noc MASTER_AMPSS_M0 &config_noc SLAVE_USB3>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
-- 
2.36.0

