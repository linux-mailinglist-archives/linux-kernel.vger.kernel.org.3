Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3883A50AAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442224AbiDUVq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442184AbiDUVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:46:39 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EAC4ECD3;
        Thu, 21 Apr 2022 14:43:39 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2AB70CDE54;
        Thu, 21 Apr 2022 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650577388; bh=o3wdUNgBE3wuRROncA9CScyhhBAu3iR9aZM8k1nZ2kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YqLfMnNR5mub1LUgcnvmCzVJOnZb7bNNbWBT0vplGEjzN8Qvl8Gh9jq0Rub3RHwqy
         6OyVPaDwgjJcXBXRdtyQFmhQOIgVrgTNvNG9td5Nuoil8bYmxkpvidvURdAHDJNjDE
         d2FFiaRcmxMWiBNvJbM1tFjLkvSE9xaRK+U4L83E=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: msm8974-FP2: Configure charger
Date:   Thu, 21 Apr 2022 23:42:42 +0200
Message-Id: <20220421214243.352469-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421214243.352469-1-luca@z3ntu.xyz>
References: <20220421214243.352469-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the relevant properties on the smbb charger to allow the device to
charge properly.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
index 8f07d8e363aa..34266126d5a2 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dts
@@ -397,6 +397,16 @@ &sdhc_2 {
 	pinctrl-1 = <&sdc2_off>;
 };
 
+&smbb {
+	usb-charge-current-limit = <1500000>;
+	qcom,fast-charge-safe-current = <1500000>;
+	qcom,fast-charge-current-limit = <1500000>;
+	qcom,fast-charge-safe-voltage = <4380000>;
+	qcom,fast-charge-high-threshold-voltage = <4350000>;
+	qcom,auto-recharge-threshold-voltage = <4240000>;
+	qcom,minimum-input-voltage = <4450000>;
+};
+
 &tlmm {
 	panel_pin: panel {
 		te {
-- 
2.36.0

