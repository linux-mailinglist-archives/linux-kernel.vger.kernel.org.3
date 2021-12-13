Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0D947360E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbhLMUhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:37:16 -0500
Received: from ixit.cz ([94.230.151.217]:46600 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhLMUhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:37:15 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 78C2524AF0;
        Mon, 13 Dec 2021 21:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639427832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+90KGAMrY23v2OQpsiJN9p+PifxnI4pu7muj49Bnjco=;
        b=shYZIxDS4fXEBKvHySokvyzxf51QZOrWl/2aAi1dOhS+GkdnGSwBF4+IVMJqH+T+ll3doP
        bjS1zQ1kjXC1XsYAbFIolRA5fZdxX3zW6QijdonKhJs/NvK6zeEF6DaQzMBBaLj246Bybw
        AKYQP6kiAHOKgO8gqHvj5cpTo8e4+m4=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: improve QCOM compatible parsing for modern chips
Date:   Mon, 13 Dec 2021 21:37:10 +0100
Message-Id: <20211213203710.122708-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
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

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/watchdog/qcom-wdt.yaml           | 33 +++++++++++--------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index ba60bdf1fecc..71cd392d298b 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -14,20 +14,25 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,apss-wdt-qcs404
-      - qcom,apss-wdt-sc7180
-      - qcom,apss-wdt-sc7280
-      - qcom,apss-wdt-sdm845
-      - qcom,apss-wdt-sdx55
-      - qcom,apss-wdt-sm8150
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
+              - qcom,apss-wdt-sm8150
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
2.33.0

