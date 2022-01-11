Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9348B955
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbiAKVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:23:20 -0500
Received: from ixit.cz ([94.230.151.217]:55930 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbiAKVXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:23:18 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 198F12243C;
        Tue, 11 Jan 2022 22:23:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1641936194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZimlnBQpBEisj8Iz4EeSG9ExZsV338uX9MeSY0WUgrM=;
        b=1qiy1xm9LL+9dZjjuZOdAgq0LGZZO49alk9ErLCK3alBYAa2PwExVq9VD9P+9TtGgjMSwv
        smqFAVbCcJIaqANTsVIqjPMf+VBXsj3z8DgQxd40pWqC0PFeaXOAOtvYmIjWxwjY3qOJPM
        +kXBEJl/6o7THqVVB/RQpgCVW5mBAk4=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: watchdog: improve QCOM compatible parsing for modern chips
Date:   Tue, 11 Jan 2022 22:23:10 +0100
Message-Id: <20220111212310.97566-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse compatible as expected for modern QCOMs.

Fixes warnings as:
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: ['qcom,apss-wdt-sdm845', 'qcom,kpss-wdt'] is too long
        From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: watchdog@17980000: compatible: Additional items are not allowed ('qcom,kpss-wdt' was unexpected)
        From schema: Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - updated compatible list as two compatibles has been added upstream
 -> resolve merge conflict
---
 .../bindings/watchdog/qcom-wdt.yaml           | 37 +++++++++++--------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 16c6f82a13ca..4ff8c59c59ab 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -14,22 +14,27 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,apss-wdt-qcs404
-      - qcom,apss-wdt-sc7180
-      - qcom,apss-wdt-sc7280
-      - qcom,apss-wdt-sdm845
-      - qcom,apss-wdt-sdx55
-      - qcom,apss-wdt-sm6350
-      - qcom,apss-wdt-sm8150
-      - qcom,apss-wdt-sm8250
-      - qcom,kpss-timer
-      - qcom,kpss-wdt
-      - qcom,kpss-wdt-apq8064
-      - qcom,kpss-wdt-ipq4019
-      - qcom,kpss-wdt-ipq8064
-      - qcom,kpss-wdt-msm8960
-      - qcom,scss-timer
+    oneOf:
+      - items:
+          - enum:
+              - qcom,apss-wdt-qcs404
+              - qcom,apss-wdt-sc7180
+              - qcom,apss-wdt-sc7280
+              - qcom,apss-wdt-sdm845
+              - qcom,apss-wdt-sdx55
+              - qcom,apss-wdt-sm6350
+              - qcom,apss-wdt-sm8150
+              - qcom,apss-wdt-sm8250
+          - const: qcom,kpss-wdt
+      - items:
+          - enum:
+              - qcom,kpss-wdt
+              - qcom,kpss-timer
+              - qcom,kpss-wdt-apq8064
+              - qcom,kpss-wdt-ipq4019
+              - qcom,kpss-wdt-ipq8064
+              - qcom,kpss-wdt-msm8960
+              - qcom,scss-timer
 
   reg:
     maxItems: 1
-- 
2.34.1

