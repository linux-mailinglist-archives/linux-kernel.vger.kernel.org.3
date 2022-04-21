Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A065350AAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442208AbiDUVqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343498AbiDUVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:46:38 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A124E3BD;
        Thu, 21 Apr 2022 14:43:39 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C76B5CC10C;
        Thu, 21 Apr 2022 21:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650577387; bh=2Hlmv3hxYGQtorTzm2FTGISpw7EMEoWJ0bemUHHve7U=;
        h=From:To:Cc:Subject:Date;
        b=KBa5XWHVsFAtQ801Vou6rRucnYY4LyS32bVHYsnnYLKleuCwi545v/jP+mazJWR1N
         hP2Yb4e2tPbxuvldTAFNutuaWkap1Psbn9wl8y/YtdUo1v+++2ETpIvybqYCQB8N83
         6oYVZaczCP8MNcISb8taI8Eq0E73IX0fS6t6CJak=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: msm8974-FP2: Add support for touchscreen
Date:   Thu, 21 Apr 2022 23:42:41 +0200
Message-Id: <20220421214243.352469-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the touchscreen found on the new display module of the FP2.
To add some detail, FP2 has two different screen/touchscreen variants
("display module"), the old module has Synaptics touchscreen, the new
one this Ilitek touchscreen.

We're only supporting the new display module for now.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../boot/dts/qcom-msm8974pro-fairphone-fp2.dts    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 96427d75ea82..8f07d8e363aa 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -57,6 +57,21 @@ vibrator {
 	};
 };
 
+&blsp1_i2c2 {
+	status = "okay";
+
+	touchscreen@41 {
+		compatible = "ilitek,ili2120";
+		reg = <0x41>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 55 GPIO_ACTIVE_LOW>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <1920>;
+	};
+};
+
 &blsp1_uart2 {
 	status = "okay";
 };
-- 
2.36.0

