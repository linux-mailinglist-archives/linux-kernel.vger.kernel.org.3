Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276851E98A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446904AbiEGTml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346517AbiEGTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:42:37 -0400
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF020BE4;
        Sat,  7 May 2022 12:38:49 -0700 (PDT)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id AA43A2007F;
        Sat,  7 May 2022 21:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1651952327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HW4Cx51Vp49UQrokPwRu5HexTiL/GEL06MgcDX2AjBg=;
        b=QxvMjoKgVNL+cBPygbvBVrGL0vW6gOpO1VuZ5BFNZt+nn9HAyeU05OS/tM2QqUo7k+AYyr
        wdwkUA24jazqp9hl5zfs8ljPQ4lC6R44ZQSjmNBP4s42LWH3YrYGmTatkIVgj7yZRB7ovE
        i7p2RO6Vi0Ki9vayvuvJxkNBpPgjQbE=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     David Heidelberg <david@ixit.cz>, Rob Herring <robh@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: watchdog: improve QCOM compatible parsing for modern chips
Date:   Sat,  7 May 2022 21:38:45 +0200
Message-Id: <20220507193846.35487-1-david@ixit.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - updated compatible list as two compatibles has been added upstream
 -> resolve merge conflict
v3:
 - rebased, added Guenter R-b

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
2.35.1

