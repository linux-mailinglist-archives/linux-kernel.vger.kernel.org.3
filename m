Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13174C2980
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiBXKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiBXKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:31:07 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E279204299;
        Thu, 24 Feb 2022 02:30:38 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B35F223EA;
        Thu, 24 Feb 2022 11:30:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645698636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixeMclLLzqQV/GX1oaqQ21tg7IiVFwINZ6keVlGAnDM=;
        b=v3S7I9eyf1JDiZEQUCX+1vYSNGWISx88WGQf/yQN/UMnHq/C0Rdf31MqfXiMugdJ084Nqk
        ukBKMspg3R+XxbS7ZPi8xM/stqWDgThoJmancm2xCqQLKAKIbZNARGqq/N3a6VYEDvveJs
        l7y4beUJMMNLZrv8QCxkjZ5D+3l9QMk=
From:   Michael Walle <michael@walle.cc>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     heiko.thiery@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/2] arm64: dts: imx8mn-evk: fix the min/max voltages of the PMIC
Date:   Thu, 24 Feb 2022 11:30:30 +0100
Message-Id: <20220224103030.2040048-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224103030.2040048-1-michael@walle.cc>
References: <20220224103030.2040048-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper voltages as supported by the board instead of the ones
supported by the PMIC. The voltages were taken from both the schematic
of the 8MNANOLPD4-EVK eval board and the datasheet of the IMX8MN SoC.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Please help review and test this. This was never tested on the actual
8MNANOLPD4-EVK because I don't have that board! Instead it is a
"byproduct" of the development of an devicetree for the 8MNANOD3L-EVK
which is quite similar except for the DDR voltage and the buck2
converter.

Changes since v1:
 - swap buck1 and buck2

 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 34 ++++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 2b685c0c7eeb..4eb467df5ba7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -42,8 +42,8 @@ pmic: pmic@25 {
 		regulators {
 			buck1: BUCK1{
 				regulator-name = "VDD_SOC";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
@@ -51,8 +51,8 @@ buck1: BUCK1{
 
 			buck2: BUCK2 {
 				regulator-name = "VDD_ARM_0V9";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1000000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
@@ -62,32 +62,32 @@ buck2: BUCK2 {
 
 			buck4: BUCK4{
 				regulator-name = "VDD_3V3";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			buck5: BUCK5{
 				regulator-name = "VDD_1V8";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			buck6: BUCK6 {
 				regulator-name = "NVCC_DRAM_1V1";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			ldo1: LDO1 {
 				regulator-name = "NVCC_SNVS_1V8";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -95,23 +95,23 @@ ldo1: LDO1 {
 			ldo2: LDO2 {
 				regulator-name = "VDD_SNVS_0V8";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1150000>;
+				regulator-max-microvolt = <800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			ldo3: LDO3 {
 				regulator-name = "VDDA_1V8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			ldo4: LDO4 {
 				regulator-name = "VDD_PHY_1V2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.30.2

