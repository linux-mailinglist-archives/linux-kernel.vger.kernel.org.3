Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A1500AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbiDNKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbiDNKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18C36F4A5;
        Thu, 14 Apr 2022 03:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE7461E6D;
        Thu, 14 Apr 2022 10:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544D7C385AE;
        Thu, 14 Apr 2022 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931408;
        bh=Y2aGv88e5fvitjsk2xbnWu4JwxO1Aq2HvAslEfjqqeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4x3fE5bq4kg+f8mAMTmYYy0Rrtfz/vvTVOgEkjWA/hH/eTG/oWR7vKF1KQn2IoZL
         fEFZYsGFlD8FnSSrxDYZi6ptBFTLO98LLAGTX8fST368yC4PmyGuwfw+TDmpc7Ngwi
         eG11vt0f63cFZkIJ8OeZKRnGAAFW0hakmMe9x13rN0PPwaCCIGeQAsZcT1W722kUws
         K/VQuhRtAturoRPGlWsxgTNmCfHGsyiTjj778DmO9HoX2yjW9dxvdmVMyZqMKwE+ej
         /9Xs0vQgh/CfBE2BvWoyRlmsPIYLZDjE0aDeiiWhKtnFrRjsXE16sAS57t6QoRzyip
         EBuTYv9egS6TQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: qcom: sm8450: Add qup nodes for qup0
Date:   Thu, 14 Apr 2022 15:46:26 +0530
Message-Id: <20220414101630.1189052-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414101630.1189052-1-vkoul@kernel.org>
References: <20220414101630.1189052-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qup0 has 7 SEs, with SE7 as uart and already added, so add the
remaining 6 SEs (i2c and spi) along with pinconf for these SEs

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 412 +++++++++++++++++++++++++++
 1 file changed, 412 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 93ff677f0d35..48f8035ea200 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -334,6 +334,25 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
+	qup_opp_table_100mhz: qup-100mhz-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			required-opps = <&rpmhpd_opp_min_svs>;
+		};
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+	};
+
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -746,6 +765,292 @@ qupv3_id_0: geniqup@9c0000 {
 			ranges;
 			status = "disabled";
 
+			i2c0: i2c@980000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00980000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c0_data_clk>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi0: spi@980000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00980000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
+				power-domains = <&rpmhpd SM8450_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@984000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00984000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c1_data_clk>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi1: spi@984000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00984000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi1_data_clk>, <&qup_spi1_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@988000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00988000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c2_data_clk>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi2: spi@988000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00988000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+
+			i2c3: i2c@98c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x0098c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c3_data_clk>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi3: spi@98c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x0098c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi3_data_clk>, <&qup_spi3_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c4: i2c@990000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00990000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c4_data_clk>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi4: spi@990000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00990000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>;
+				power-domains = <&rpmhpd SM8450_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c5: i2c@994000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00994000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c5_data_clk>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi5: spi@994000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00994000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+
+			i2c6: i2c@998000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x998000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c6_data_clk>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi6: spi@998000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x998000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			uart7: serial@99c000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0 0x0099c000 0 0x4000>;
@@ -1121,6 +1426,41 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 211>;
 			wakeup-parent = <&pdc>;
 
+			qup_i2c0_data_clk: qup-i2c0-data-clk {
+				pins = "gpio0", "gpio1";
+				function = "qup0";
+			};
+
+			qup_i2c1_data_clk: qup-i2c1-data-clk {
+				pins = "gpio4", "gpio5";
+				function = "qup1";
+			};
+
+			qup_i2c2_data_clk: qup-i2c2-data-clk {
+				pins = "gpio8", "gpio9";
+				function = "qup2";
+			};
+
+			qup_i2c3_data_clk: qup-i2c3-data-clk {
+				pins = "gpio12", "gpio13";
+				function = "qup3";
+			};
+
+			qup_i2c4_data_clk: qup-i2c4-data-clk {
+				pins = "gpio16", "gpio17";
+				function = "qup4";
+			};
+
+			qup_i2c5_data_clk: qup-i2c5-data-clk {
+				pins = "gpio206", "gpio207";
+				function = "qup5";
+			};
+
+			qup_i2c6_data_clk: qup-i2c6-data-clk {
+				pins = "gpio20", "gpio21";
+				function = "qup6";
+			};
+
 			qup_i2c13_data_clk: qup-i2c13-data-clk {
 				pins = "gpio48", "gpio49";
 				function = "qup13";
@@ -1135,6 +1475,78 @@ qup_i2c14_data_clk: qup-i2c14-data-clk {
 				bias-pull-up;
 			};
 
+			qup_spi0_cs: qup-spi0-cs {
+				pins = "gpio3";
+				function = "qup0";
+			};
+
+			qup_spi0_data_clk: qup-spi0-data-clk {
+				pins = "gpio0", "gpio1", "gpio2";
+				function = "qup0";
+			};
+
+			qup_spi1_cs: qup-spi1-cs {
+				pins = "gpio7";
+				function = "qup1";
+			};
+
+			qup_spi1_data_clk: qup-spi1-data-clk {
+				pins = "gpio4", "gpio5", "gpio6";
+				function = "qup1";
+			};
+
+			qup_spi2_cs: qup-spi2-cs {
+				pins = "gpio11";
+				function = "qup2";
+			};
+
+			qup_spi2_data_clk: qup-spi2-data-clk {
+				pins = "gpio8", "gpio9", "gpio10";
+				function = "qup2";
+			};
+
+			qup_spi3_cs: qup-spi3-cs {
+				pins = "gpio15";
+				function = "qup3";
+			};
+
+			qup_spi3_data_clk: qup-spi3-data-clk {
+				pins = "gpio12", "gpio13", "gpio14";
+				function = "qup3";
+			};
+
+			qup_spi4_cs: qup-spi4-cs {
+				pins = "gpio19";
+				function = "qup4";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi4_data_clk: qup-spi4-data-clk {
+				pins = "gpio16", "gpio17", "gpio18";
+				function = "qup4";
+			};
+
+			qup_spi5_cs: qup-spi5-cs {
+				pins = "gpio85";
+				function = "qup5";
+			};
+
+			qup_spi5_data_clk: qup-spi5-data-clk {
+				pins = "gpio206", "gpio207", "gpio84";
+				function = "qup5";
+			};
+
+			qup_spi6_cs: qup-spi6-cs {
+				pins = "gpio23";
+				function = "qup6";
+			};
+
+			qup_spi6_data_clk: qup-spi6-data-clk {
+				pins = "gpio20", "gpio21", "gpio22";
+				function = "qup6";
+			};
+
 			qup_uart7_rx: qup-uart7-rx {
 				pins = "gpio26";
 				function = "qup7";
-- 
2.34.1

