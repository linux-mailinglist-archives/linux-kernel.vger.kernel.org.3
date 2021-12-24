Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45447F185
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 00:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhLXXqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 18:46:35 -0500
Received: from ixit.cz ([94.230.151.217]:50350 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhLXXqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 18:46:34 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 790C72243C;
        Sat, 25 Dec 2021 00:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640389592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=txYaCsV6ZDsx+W4Kr5aHreCF51BTg6Mh94S+HysQwlw=;
        b=oSPWcJ6zHe1/RR4irukuVEVw4wW9CAQyktQtWiwnn4TPd7iY6cjonJoAtFXi+7Oo6I3Uhw
        gMD/kSZ6fPqA284n7aYTz6Pb3dYBJgjuzMwFoSLT+38p5F69LbwpI109m1OTH+8UciKZk9
        Vu6Wu9JOCZcOh1Q/pNGW02YqmBrenRQ=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: fix timer node clock-frequency
Date:   Sat, 25 Dec 2021 00:46:30 +0100
Message-Id: <20211224234631.109315-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock frequency is read by driver a single uint32,
so the second value was never processed.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 3 +--
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +--
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 3 +--
 arch/arm/boot/dts/qcom-msm8660.dtsi | 3 +--
 arch/arm/boot/dts/qcom-msm8960.dtsi | 3 +--
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 2d539d77bad4..3d5d9ffb66af 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -380,8 +380,7 @@ timer@200a000 {
 				     <1 2 0x301>,
 				     <1 3 0x301>;
 			reg = <0x0200a000 0x100>;
-			clock-frequency = <27000000>,
-					  <32768>;
+			clock-frequency = <27000000>;
 			cpu-offset = <0x80000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..d663521bdd02 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -458,8 +458,7 @@ IRQ_TYPE_EDGE_RISING)>,
 				     <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) |
 						 IRQ_TYPE_EDGE_RISING)>;
 			reg = <0x0200a000 0x100>;
-			clock-frequency = <25000000>,
-					  <32768>;
+			clock-frequency = <25000000>;
 			clocks = <&sleep_clk>;
 			clock-names = "sleep";
 			cpu-offset = <0x80000>;
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index c32415f0e66d..8b58f80093e8 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -120,8 +120,7 @@ timer@200a000 {
 				     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>,
 				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_EDGE_RISING)>;
 			reg = <0x0200a000 0x100>;
-			clock-frequency = <27000000>,
-					  <32768>;
+			clock-frequency = <27000000>;
 			cpu-offset = <0x80000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 1e8aab357f9c..b16060b65593 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -105,8 +105,7 @@ timer@2000000 {
 				     <1 1 0x301>,
 				     <1 2 0x301>;
 			reg = <0x02000000 0x100>;
-			clock-frequency = <27000000>,
-					  <32768>;
+			clock-frequency = <27000000>;
 			cpu-offset = <0x40000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 2a0ec97a264f..ca093b89c9ea 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -99,8 +99,7 @@ timer@200a000 {
 				     <1 2 0x301>,
 				     <1 3 0x301>;
 			reg = <0x0200a000 0x100>;
-			clock-frequency = <27000000>,
-					  <32768>;
+			clock-frequency = <27000000>;
 			cpu-offset = <0x80000>;
 		};
 
-- 
2.34.1

