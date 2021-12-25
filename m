Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2247F358
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhLYOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:07:13 -0500
Received: from ixit.cz ([94.230.151.217]:55832 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhLYOHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:07:11 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 59DC82243C;
        Sat, 25 Dec 2021 15:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640441229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xR/SY7X8iCJ0TMqmA0GgaAUU+CTGg5NJifKY7cx5oHU=;
        b=vzFrbvwQq9Csn52kDoq439vq+XZf/ReSO7mumrTzaz4W415PhnCJcBYCvQuN09IUa/e4DA
        c2I2O9kHVPUkVXOPNCB1gLt/69GZpR3hCjmIy0yNmREZTeNycWbjZwSiBSzKt/5Li534LP
        quU9cTDX6hPfVwv8cHUZyWt4smIXoJw=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: syscon: Add Qualcomm TCSR registers
Date:   Sat, 25 Dec 2021 15:07:07 +0100
Message-Id: <20211225140708.22000-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm devices have a set of registers that provide various control and status
functions for their peripherals.

Modification:
 - dropped "qcom,tcsr-ipq6018", "syscon", "simple-mfd", since it's not
   used anywhere.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/mfd/qcom,tcsr.txt     | 23 -------------------
 .../devicetree/bindings/mfd/syscon.yaml       |  8 +++++++
 2 files changed, 8 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt b/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
deleted file mode 100644
index c5f4f0ddfcc3..000000000000
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-QCOM Top Control and Status Register
-
-Qualcomm devices have a set of registers that provide various control and status
-functions for their peripherals.  This node is intended to allow access to these
-registers via syscon.
-
-Required properties:
-- compatible:	Should contain:
-		"qcom,tcsr-ipq6018", "syscon", "simple-mfd" for IPQ6018
-		"qcom,tcsr-ipq8064", "syscon" for IPQ8064
-		"qcom,tcsr-apq8064", "syscon" for APQ8064
-		"qcom,tcsr-msm8660", "syscon" for MSM8660
-		"qcom,tcsr-msm8960", "syscon" for MSM8960
-		"qcom,tcsr-msm8974", "syscon" for MSM8974
-		"qcom,tcsr-apq8084", "syscon" for APQ8084
-		"qcom,tcsr-msm8916", "syscon" for MSM8916
-- reg: Address range for TCSR registers
-
-Example:
-	tcsr: syscon@1a400000 {
-		compatible = "qcom,tcsr-msm8960", "syscon";
-		reg = <0x1a400000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index eeac1cbc5a17..6d6058b694e7 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -60,6 +60,14 @@ properties:
               - samsung,exynos5433-sysreg
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
+              - qcom,tcsr-apq8064
+              - qcom,tcsr-apq8084
+              - qcom,tcsr-ipq6018
+              - qcom,tcsr-ipq8064
+              - qcom,tcsr-msm8660
+              - qcom,tcsr-msm8916
+              - qcom,tcsr-msm8960
+              - qcom,tcsr-msm8974
 
           - const: syscon
 
-- 
2.34.1

