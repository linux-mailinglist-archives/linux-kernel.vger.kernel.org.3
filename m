Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1553E7FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiFFQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiFFQGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:06:49 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD258E52A7;
        Mon,  6 Jun 2022 09:06:47 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 89D28CD361;
        Mon,  6 Jun 2022 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654531576; bh=o9eixXtP/Xx2M72rr+rsSeCZivwh5KMZsFPSUC13lhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p2lrpkAjAckkN/gcgXfr6BiCj7ajAkXyu3tfJ2Z0ipTkPVvszYVyHnsVdoVuQaAsH
         8ewkiYQch+POrrxMXT3j8Mimt59m6Q9GFDe9FMTZo7hCbHu6J/IalpnMJ6RLKROYFU
         pz+K3O9Gbf/0dDFIZBA+ILvwG/lKw4hXQM2TaRPg=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: qcom: msm8974-*: re-add remoteproc supplies
Date:   Mon,  6 Jun 2022 18:04:23 +0200
Message-Id: <20220606160421.1641778-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606160421.1641778-1-luca@z3ntu.xyz>
References: <20220606160421.1641778-1-luca@z3ntu.xyz>
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

As part of a recent cleanup commit, the remoteproc supplies for adsp and
modem were removed from msm8974.dtsi and now need to be set in the
device dts. Do so.

Fixes: f300826d27be ("ARM: dts: qcom-msm8974: Sort and clean up nodes")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Bjorn, could you please pick this up for -fixes so it lands in an
upcoming 5.19-rc?

 .../boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts   | 11 +++++++++++
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi | 11 +++++++++++
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts    | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 9493886a5c0d..2d699de713ce 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -313,6 +313,17 @@ otg {
 	};
 };
 
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+};
+
 &rpm_requests {
 	pm8841-regulators {
 		compatible = "qcom,rpm-pm8841-regulators";
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 1d21de46f85c..60bf96304687 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -183,6 +183,17 @@ &pm8941_wled {
 	qcom,num-strings = <2>;
 };
 
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+};
+
 &rpm_requests {
 	pm8841-regulators {
 		compatible = "qcom,rpm-pm8841-regulators";
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 9bd8faea61a5..48f0c47a45ef 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -288,6 +288,17 @@ lcd_dcdc_en_pin_a: lcd-dcdc-en-active {
 
 };
 
+&remoteproc_adsp {
+	cx-supply = <&pm8841_s2>;
+};
+
+&remoteproc_mss {
+	cx-supply = <&pm8841_s2>;
+	mss-supply = <&pm8841_s3>;
+	mx-supply = <&pm8841_s1>;
+	pll-supply = <&pm8941_l12>;
+};
+
 &rpm_requests {
 	pm8941-regulators {
 		compatible = "qcom,rpm-pm8941-regulators";
-- 
2.36.1

