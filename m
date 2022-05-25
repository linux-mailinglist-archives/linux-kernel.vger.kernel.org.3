Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6DA533F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiEYOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiEYOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:44:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BBAE267
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so29111124ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofMD+z2oV9+oiTcB8ClGG1nsZ8Ej5W9o4q3U+Ksa5Uw=;
        b=moCAWImdMLqDufc3TXmt5sapIcISEyjUSAghKNBvb4vzVLlS7SwsWQDzYB5QUx7G8Y
         P7OD3P8faIwsSTTeOa+T+Owj+UCZcdfkgWab1i/PEvYp3RFHdVwGeSbTmyhKGQ+zCF2/
         q04NK6k+4JVtCWnBc5tcanVUnukRJdkV8eEBu4XYYAFpKJOKO67GC6ehqTrHUXFT+kjx
         1VDlC5Pg5ZiGbuQqhMBYelc6cFIqbodAHrGMbEEmQdRooZ5vyYFSxF7d2kp2KRir55lW
         QJmAapvk4RRGjOd5tN7kP3hI3vxBXGYlW6GK8cf8JG6MVlk8MGfFxteLhqD2iqOdKSAW
         yReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofMD+z2oV9+oiTcB8ClGG1nsZ8Ej5W9o4q3U+Ksa5Uw=;
        b=Zx4l4HbUdwLZgGyG7xA9mWmjG1LPKHJewFy/Zr/WVYta/bKBdQPipHNDcRrr/iqmgn
         4pyXrbngMvj6ZCULP7wTIb1B/ImYdG75oql2f74Dp6AOxwCPpSJbWAK9pqFe60YAoJy2
         cM9aq02jBTzLN9U6xdzkdgBZqHHwNl0POeMsM16HGTShELCTQb+FmYPZrImfHuBLvmEH
         5r1s0PGvV2rDdAvGr2oLY+P2QOigKpCYFBzF3J6tBWRsCaZSBeD3/XUhWF/0ptk66YJQ
         vyA/BGDoXjmynXkPnLRLqCYJb2I6KuexgYufBUh3MqLodDxzwtVhF4/YmkkNPgA5tQvS
         rTOA==
X-Gm-Message-State: AOAM5327fwTq23pEeRJ5Otwdk7iULAnOuAy4cWOlzGd443my1wci9mNx
        LrR2hpybBMZKExslQ1dpsg3hVw==
X-Google-Smtp-Source: ABdhPJy3PWgO5E6DAJkr5aFegnBB8BHm80d8zEbsc269ulJNaqXw0TFRhzJl3d02E0ccvfCfQ2wCDg==
X-Received: by 2002:a17:907:9715:b0:6fe:d943:3116 with SMTP id jg21-20020a170907971500b006fed9433116mr14989002ejc.257.1653489880355;
        Wed, 25 May 2022 07:44:40 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b006f3ef214de1sm8159596ejp.71.2022.05.25.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:44:39 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: qcom: sm6350: Add interconnect support
Date:   Wed, 25 May 2022 16:44:01 +0200
Message-Id: <20220525144404.200390-6-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525144404.200390-1-luca.weiss@fairphone.com>
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
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

Add all the different NoC providers that are found in SM6350 and
populate different nodes that use the interconnect properties.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v2:
* none

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 109 +++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index fb1a0f662575..119073f19285 100644
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
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -552,6 +558,10 @@ i2c2: i2c@888000 {
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
+						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 		};
@@ -578,6 +588,10 @@ i2c6: i2c@980000 {
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -591,6 +605,10 @@ i2c7: i2c@984000 {
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -604,6 +622,10 @@ i2c8: i2c@988000 {
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
@@ -615,6 +637,9 @@ uart9: serial@98c000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -628,11 +653,62 @@ i2c10: i2c@990000 {
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &clk_virt SLAVE_EBI_CH0 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
 				status = "disabled";
 			};
 
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm6350-config-noc";
+			reg = <0 0x01500000 0 0x28000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sm6350-system-noc";
+			reg = <0 0x01620000 0 0x17080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+
+			clk_virt: interconnect-clk-virt {
+				compatible = "qcom,sm6350-clk-virt";
+				#interconnect-cells = <2>;
+				qcom,bcm-voters = <&apps_bcm_voter>;
+			};
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm6350-aggre1-noc";
+			reg = <0 0x016e0000 0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm6350-aggre2-noc";
+			reg = <0 0x01700000 0 0x1f880>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+
+			compute_noc: interconnect-compute-noc {
+				compatible = "qcom,sm6350-compute-noc";
+				#interconnect-cells = <2>;
+				qcom,bcm-voters = <&apps_bcm_voter>;
+			};
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sm6350-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <2>;
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
+			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
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
+			#interconnect-cells = <2>;
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
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		npu_noc: interconnect@9990000 {
+			compatible = "qcom,sm6350-npu-noc";
+			reg = <0 0x09990000 0 0x1600>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm6350-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -1051,6 +1156,10 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			interconnects = <&aggre2_noc MASTER_USB3 0 &clk_virt SLAVE_EBI_CH0 0>,
+					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_USB3 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
-- 
2.36.1

