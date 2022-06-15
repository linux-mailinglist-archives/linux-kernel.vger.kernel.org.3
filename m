Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B0454C620
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347888AbiFOK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346597AbiFOK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:29:38 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1089B4BFD4;
        Wed, 15 Jun 2022 03:29:36 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C0DF200CD4;
        Wed, 15 Jun 2022 12:29:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 66511200CCF;
        Wed, 15 Jun 2022 12:29:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 061C3180219B;
        Wed, 15 Jun 2022 18:29:33 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH 1/3] arm64: dts: imx8mm-evk: add bt-sco sound card support
Date:   Wed, 15 Jun 2022 18:15:32 +0800
Message-Id: <1655288134-14083-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655288134-14083-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655288134-14083-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bt-sco sound card, which supports wb profile as default

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index c42b966f7a64..d99b562bb00e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -75,6 +75,11 @@
 		linux,autosuspend-period = <125>;
 	};
 
+	bt_sco_codec: bt_sco_codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	wm8524: audio-codec {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8524";
@@ -107,6 +112,25 @@
 			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
 		};
 	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
 };
 
 &A53_0 {
@@ -346,6 +370,16 @@
 	status = "okay";
 };
 
+&sai2 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clk IMX8MM_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -494,6 +528,15 @@
 		>;
 	};
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
+			MX8MM_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
+			MX8MM_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
+			MX8MM_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0    0xd6
+		>;
+	};
+
 	pinctrl_sai3: sai3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-- 
2.17.1

