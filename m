Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB47F4C5130
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiBYWGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiBYWG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:06:29 -0500
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 14:05:55 PST
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835C1F636C;
        Fri, 25 Feb 2022 14:05:55 -0800 (PST)
Received: from localhost.localdomain (89-166-24-184.bb.dnainternet.fi [89.166.24.184])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 809A83F67D;
        Fri, 25 Feb 2022 22:58:09 +0100 (CET)
From:   Jami Kettunen <jami.kettunen@somainline.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH] arm64: dts: qcom: msm8998-oneplus-common: Add NFC
Date:   Fri, 25 Feb 2022 23:56:42 +0200
Message-Id: <20220225215642.3916-1-jami.kettunen@somainline.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OnePlus 5/5T both have an NXP PN553 which is supported by the
nxp-nci-i2c driver in mainline. It detects/reads NFC tags using
"nfctool" and with the NearD test scripts data can also be written
to be received by another device.

Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
---
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 9823d48a91b1..dbaea360bffc 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -188,6 +188,23 @@ rmi4_f12: rmi4-f12@12 {
 	};
 };
 
+&blsp1_i2c6 {
+	status = "okay";
+
+	nfc@28 {
+		compatible = "nxp,nxp-nci-i2c";
+		reg = <0x28>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <92 IRQ_TYPE_LEVEL_HIGH>;
+
+		enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nfc_int_active &nfc_enable_active>;
+	};
+};
+
 &blsp1_uart3 {
 	status = "okay";
 
@@ -462,6 +479,20 @@ ts_reset_active: ts-reset-active {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	nfc_int_active: nfc-int-active {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_enable_active: nfc-enable-active {
+		pins = "gpio12", "gpio116";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
 };
 
 &ufshc {
-- 
2.35.1

