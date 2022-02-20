Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA70F4BD25A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 23:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiBTWbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 17:31:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiBTWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 17:31:06 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5734B874;
        Sun, 20 Feb 2022 14:30:44 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 052BEC83D6;
        Sun, 20 Feb 2022 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645396243; bh=V2nhvOAtYi4w252RToFuWOCUJqBe5w1V1/MDMkrhuKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JAj3RFFH5XFLE8i4H2+ea/NsgZUV+nQ7+/kyGJgwjhIfpWX/Ps2+k3ckg12Al7gwY
         t7cTeT1x1+mhaKjtEATEY3ij1d46G/XZ7CIFgbnS4nF5bNE5Dxqac39AwJG+PwGai4
         vOSndS6s71jbtS8cQi+m7vk/QysCVzDxc1GQoZ0k=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: qcom: msm8226: add power domains
Date:   Sun, 20 Feb 2022 23:30:03 +0100
Message-Id: <20220220223004.507739-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220223004.507739-1-luca@z3ntu.xyz>
References: <20220220223004.507739-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the power domain controller found in MSM8226.

At the same time remove any existing usages of pm8226_s1 as this
regulator is now handled by power domains.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts |  4 ---
 arch/arm/boot/dts/qcom-msm8226.dtsi         | 29 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 42467f705b26..2b7e52fda6a7 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -105,10 +105,6 @@ &rpm_requests {
 	pm8226-regulators {
 		compatible = "qcom,rpm-pm8226-regulators";
 
-		pm8226_s1: s1 {
-			regulator-min-microvolt = <500000>;
-			regulator-max-microvolt = <1275000>;
-		};
 		pm8226_s3: s3 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1350000>;
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index e24e53438b4d..28eca15b5712 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -73,6 +73,35 @@ rpm {
 			rpm_requests: rpm-requests {
 				compatible = "qcom,rpm-msm8226";
 				qcom,smd-channels = "rpm_requests";
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8226-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <1>;
+						};
+						rpmpd_opp_svs_krait: opp2 {
+							opp-level = <2>;
+						};
+						rpmpd_opp_svs_soc: opp3 {
+							opp-level = <3>;
+						};
+						rpmpd_opp_nom: opp4 {
+							opp-level = <4>;
+						};
+						rpmpd_opp_turbo: opp5 {
+							opp-level = <5>;
+						};
+						rpmpd_opp_super_turbo: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
 			};
 		};
 	};
-- 
2.35.1

