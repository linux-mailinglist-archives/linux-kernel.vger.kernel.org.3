Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2650CC00
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiDWPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiDWPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:54:35 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A430D76CD;
        Sat, 23 Apr 2022 08:51:38 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E8A7ACEA9A;
        Sat, 23 Apr 2022 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650729097; bh=gSbrHxZK4RDsD1E2dWZWdLIdJD+pfxPIFBz0U4bXCaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h0wG6sNWvwviSiuFF0vtQwkAotSDzhtzVmLZRMY5p0GoVXuniZqnWz5V9VeDyy92z
         95kociYmBqHHlyJS0sg0WcWGROrJOqm7dNRur1uAduWu7yN8/Ww9fNp7zmwu3znkzL
         f2oNjUGx+0MV5pY9EnhdSzT1MiLcBY4G7GHYW3II=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: qcom: apq8026-lg-lenok: Enable ADSP
Date:   Sat, 23 Apr 2022 17:50:59 +0200
Message-Id: <20220423155059.660387-5-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423155059.660387-1-luca@z3ntu.xyz>
References: <20220423155059.660387-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the reserved memory for ADSP and enable it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 2b7e52fda6a7..193569f0ca5f 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -8,6 +8,8 @@
 #include "qcom-msm8226.dtsi"
 #include "qcom-pm8226.dtsi"
 
+/delete-node/ &adsp_region;
+
 / {
 	model = "LG G Watch R";
 	compatible = "lg,lenok", "qcom,apq8026";
@@ -23,6 +25,13 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	reserved-memory {
+		adsp_region: adsp@3300000 {
+			reg = <0x03300000 0x1400000>;
+			no-map;
+		};
+	};
+
 	vreg_wlan: wlan-regulator {
 		compatible = "regulator-fixed";
 
@@ -38,6 +47,10 @@ vreg_wlan: wlan-regulator {
 	};
 };
 
+&adsp {
+	status = "okay";
+};
+
 &blsp1_i2c1 {
 	status = "okay";
 
-- 
2.36.0

