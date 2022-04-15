Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A123502937
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353109AbiDOMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352942AbiDOMAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:00:04 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B2EAAB56
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:57:17 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 456DF3F67E;
        Fri, 15 Apr 2022 13:57:15 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/23] ARM: dts: qcom-msm8974-rhine: Add NFC and enable I2C hosts
Date:   Fri, 15 Apr 2022 13:56:31 +0200
Message-Id: <20220415115633.575010-22-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable I2C hosts that are (supposed to be) used on Rhine and add NXP
PN544 NFC node.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 1120972ae4d2..15beb9df3631 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -85,6 +85,22 @@ rmi4-f11@11 {
 	};
 };
 
+&blsp1_i2c6 {
+	status = "okay";
+	clock-frequency = <355000>;
+
+	nfc@28 {
+		compatible = "nxp,pn544-i2c";
+		reg = <0x28>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <59 IRQ_TYPE_EDGE_RISING>;
+
+		enable-gpios = <&pm8941_gpios 23 GPIO_ACTIVE_HIGH>;
+		firmware-gpios = <&tlmm 77 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &blsp1_uart2 {
 	status = "okay";
 };
@@ -93,6 +109,13 @@ &blsp2_dma {
 	qcom,controlled-remotely;
 };
 
+&blsp2_i2c5 {
+	status = "okay";
+	clock-frequency = <355000>;
+
+	/* sii8334 MHL HDMI bridge */
+};
+
 &otg {
 	status = "okay";
 
-- 
2.35.2

