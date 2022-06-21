Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4E552963
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbiFUCaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbiFUCaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:30:18 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED218E24;
        Mon, 20 Jun 2022 19:30:18 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0AFE1A1255;
        Tue, 21 Jun 2022 04:30:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 645121A1254;
        Tue, 21 Jun 2022 04:30:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B6AFE180222C;
        Tue, 21 Jun 2022 10:30:14 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH v3 2/3] arm64: dts: imx8mq-evk: add bt-sco sound card support
Date:   Tue, 21 Jun 2022 10:16:02 +0800
Message-Id: <1655777763-21153-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655777763-21153-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655777763-21153-1-git-send-email-shengjiu.wang@nxp.com>
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
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 99fed35168eb..82387b9cb800 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -71,12 +71,36 @@
 		linux,autosuspend-period = <125>;
 	};
 
+	audio_codec_bt_sco: audio-codec-bt-sco {
+		compatible = "linux,bt-sco";
+		#sound-dai-cells = <1>;
+	};
+
 	wm8524: audio-codec {
 		#sound-dai-cells = <0>;
 		compatible = "wlf,wm8524";
 		wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 	};
 
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&audio_codec_bt_sco 1>;
+		};
+	};
+
 	sound-wm8524 {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8524-audio";
@@ -386,6 +410,16 @@
 	status = "okay";
 };
 
+&sai3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MQ_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -548,6 +582,15 @@
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
+			MX8MQ_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
+			MX8MQ_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
+			MX8MQ_IOMUXC_SAI3_RXD_SAI3_RX_DATA0     0xd6
+		>;
+	};
+
 	pinctrl_spdif1: spdif1grp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
-- 
2.17.1

