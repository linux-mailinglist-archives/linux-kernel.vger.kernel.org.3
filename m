Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D297D500AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiDNKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiDNKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CE6D4E9;
        Thu, 14 Apr 2022 03:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33981CE2847;
        Thu, 14 Apr 2022 10:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DEFC385AB;
        Thu, 14 Apr 2022 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931411;
        bh=PAuA1R5pgMkjaytEfqWHsX4zuB2dH++pJfdyC2C5qb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgNmfAjQbB5TJjVwLiBYjFVYmg/XZQVki2NXWU8HMukCs4CE90rBaqPqPgsX3oodL
         vnEIDKCJ0lGy6gHFIHpyDAnGh+El6HzTu88BTENRu1z+DPANX+2EcYqewwGRQq9uRx
         FXEK6wJHB2QS4Ya3gvir24/7LCulgdCgBrKuP4tRY6Cf+GsocVINtKWqqZ9KOgQHuD
         t8BpmGtZzLBA+22wNAJn8dgpi0vnhkKxLHhcqpPAdlQGnyT+Hl0qORuFaHpoUCs6+Q
         paRYO5Nzbn3/PNTXMt727yXOl4F47WDlCi7lq+oIfZ/Klq/8ZSIEahQMSvEzVxHeeV
         chKTU6uTOT1sA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] arm64: dts: qcom: sm8450: Add qup nodes for qup1
Date:   Thu, 14 Apr 2022 15:46:27 +0530
Message-Id: <20220414101630.1189052-5-vkoul@kernel.org>
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

qup1 has 7 SEs, I2C13 and I2C14 were already added so added the
remaining SEs (i2c and spi) along with pinconf for these SEs
Also add interconnect properties for I2C13 and I2C14

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 359 +++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 48f8035ea200..3097a6e3ab4e 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1098,6 +1098,206 @@ qupv3_id_1: geniqup@ac0000 {
 			ranges;
 			status = "disabled";
 
+			i2c8: i2c@a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c8_data_clk>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi8: spi@a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a80000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi8_data_clk>, <&qup_spi8_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c9: i2c@a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c9_data_clk>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi9: spi@a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a84000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi9_data_clk>, <&qup_spi9_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c10: i2c@a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c10_data_clk>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi10: spi@a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a88000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi10_data_clk>, <&qup_spi10_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c11: i2c@a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a8c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c11_data_clk>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi11: spi@a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a8c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi11_data_clk>, <&qup_spi11_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c12: i2c@a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x00a90000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c12_data_clk>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				status = "disabled";
+			};
+
+			spi12: spi@a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a90000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi12_data_clk>, <&qup_spi12_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			i2c13: i2c@a94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00a94000 0 0x4000>;
@@ -1106,6 +1306,33 @@ i2c13: i2c@a94000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c13_data_clk>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi13: spi@a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a94000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi13_data_clk>, <&qup_spi13_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1119,6 +1346,33 @@ i2c14: i2c@a98000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c14_data_clk>;
 				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi14: spi@a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x00a98000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi14_data_clk>, <&qup_spi14_cs>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>,
+						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
+				interconnect-names = "qup-core", "qup-config", "qup-memory";
+				dmas = <&gpi_dma1 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma1 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
@@ -1461,6 +1715,31 @@ qup_i2c6_data_clk: qup-i2c6-data-clk {
 				function = "qup6";
 			};
 
+			qup_i2c8_data_clk: qup-i2c8-data-clk {
+				pins = "gpio28", "gpio29";
+				function = "qup8";
+			};
+
+			qup_i2c9_data_clk: qup-i2c9-data-clk {
+				pins = "gpio32", "gpio33";
+				function = "qup9";
+			};
+
+			qup_i2c10_data_clk: qup-i2c10-data-clk {
+				pins = "gpio36", "gpio37";
+				function = "qup10";
+			};
+
+			qup_i2c11_data_clk: qup-i2c11-data-clk {
+				pins = "gpio40", "gpio41";
+				function = "qup11";
+			};
+
+			qup_i2c12_data_clk: qup-i2c12-data-clk {
+				pins = "gpio44", "gpio45";
+				function = "qup12";
+			};
+
 			qup_i2c13_data_clk: qup-i2c13-data-clk {
 				pins = "gpio48", "gpio49";
 				function = "qup13";
@@ -1547,6 +1826,86 @@ qup_spi6_data_clk: qup-spi6-data-clk {
 				function = "qup6";
 			};
 
+			qup_spi8_cs: qup-spi8-cs {
+				pins = "gpio31";
+				function = "qup8";
+			};
+
+			qup_spi8_data_clk: qup-spi8-data-clk {
+				pins = "gpio28", "gpio29", "gpio30";
+				function = "qup8";
+			};
+
+			qup_spi9_cs: qup-spi9-cs {
+				pins = "gpio35";
+				function = "qup9";
+			};
+
+			qup_spi9_data_clk: qup-spi9-data-clk {
+				pins = "gpio32", "gpio33", "gpio34";
+				function = "qup9";
+			};
+
+			qup_spi10_cs: qup-spi10-cs {
+				pins = "gpio39";
+				function = "qup10";
+			};
+
+			qup_spi10_data_clk: qup-spi10-data-clk {
+				pins = "gpio36", "gpio37", "gpio38";
+				function = "qup10";
+			};
+
+			qup_spi11_cs: qup-spi11-cs {
+				pins = "gpio43";
+				function = "qup11";
+			};
+
+			qup_spi11_data_clk: qup-spi11-data-clk {
+				pins = "gpio40", "gpio41", "gpio42";
+				function = "qup11";
+			};
+
+			qup_spi12_cs: qup-spi12-cs {
+				pins = "gpio47";
+				function = "qup12";
+			};
+
+			qup_spi12_data_clk: qup-spi12-data-clk {
+				pins = "gpio44", "gpio45", "gpio46";
+				function = "qup12";
+			};
+
+			qup_spi13_cs: qup-spi13-cs {
+				pins = "gpio51";
+				function = "qup13";
+			};
+
+			qup_spi13_data_clk: qup-spi13-data-clk {
+				pins = "gpio48", "gpio49", "gpio50";
+				function = "qup13";
+			};
+
+			qup_spi14_cs: qup-spi14-cs {
+				pins = "gpio55";
+				function = "qup14";
+			};
+
+			qup_spi14_data_clk: qup-spi14-data-clk {
+				pins = "gpio52", "gpio53", "gpio54";
+				function = "qup14";
+			};
+
+			qup_spi15_cs: qup-spi15-cs {
+				pins = "gpio59";
+				function = "qup15";
+			};
+
+			qup_spi15_data_clk: qup-spi15-data-clk {
+				pins = "gpio56", "gpio57", "gpio58";
+				function = "qup15";
+			};
+
 			qup_uart7_rx: qup-uart7-rx {
 				pins = "gpio26";
 				function = "qup7";
-- 
2.34.1

