Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481264C4932
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbiBYPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbiBYPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:38:05 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A541628
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:37:30 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DD74D3FCA9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645803448;
        bh=DH1NoDQWkkmBpO6rD7PN1xLEKF0Vshadk2vJi0dTvdU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=jxUNSSzD0TL7jvZKy9N/5kIoWezzcxy3+Tb6TSsa0ndlTEm6oYlHARpHjTxqdiuE1
         lBVLimB1prMPCIFIlciEoq9agIeuWzR7dBkqIyW2Ismv7YGQRnBuIRlHO2sib5L2/+
         aYXu5uoQciaPPp9LS4MWIaxZH1j7w2BdGuPU9XygUFNeCbWajVXpJjb70whBZFlyX3
         vWFDl6HFKg5BTpQypFXoMQk8WMoFP7Aw0QJKJODLycX2e4CNvF2eqXBWeZC1J7UjBh
         J++pdHvkEdLnV4lWd2PxFgojBulpLeoBRSOWc28waQDKwAYpJR1nrwPvkcYp9j5ZCj
         JJD2iCBvwZjIQ==
Received: by mail-wr1-f72.google.com with SMTP id j8-20020adfc688000000b001e3322ced69so1019152wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH1NoDQWkkmBpO6rD7PN1xLEKF0Vshadk2vJi0dTvdU=;
        b=udiedD+TQEBhy3L0d/1cNNLmpLVITZ41IxVxuOwi3KFF4XNI6UaRCrh8xSrhX924r9
         QUzABXARf6cjR52RH7KN7ckr6BjQmjcePojO+UyEVmecD/mKVxEf/3LFFSscEKdmjZAW
         6tvRMaIB0uMRTrV9FPMiqLgLG61xtulbQ3e79A+2Tnjbcxv+5S5bFdnZtuCiJoIvdD55
         hDsaCPJ91dfYNuf5OLCjnkF4JEuLL12JcWAnVOB7I95Mm6tKxDlzqHz/oqompnbCsIb8
         rM276VWhFmzEz+e8DYOIjg22BO8AivMr6ZzWmOruHLlZvN/Iaob4qlp4hRnj5FqZsWPc
         4Bvw==
X-Gm-Message-State: AOAM530MDN8IjziJx+YamcXp3sK74BwZopCP4iW0medW9OUC513nVWJg
        bscuT8A0NiVlmOxCYN30y19O4XGkaZ6MmJCOiVd4FIo9LAp+Q73fnOTKgzKvS0zYAPE5rj9mr3B
        Dz1RG2avnuyyXRNUt9mhvt9VIt4Y7EBFu+M5eGBIPGQ==
X-Received: by 2002:adf:f691:0:b0:1ed:f546:bd81 with SMTP id v17-20020adff691000000b001edf546bd81mr6474377wrp.542.1645803448601;
        Fri, 25 Feb 2022 07:37:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDdXxzBIgGt45TJgFU8stqqgn9WKVBbpQ29snMfUo6EUQ2DHKvlAK26yT08CtmXZ6jA7cqHg==
X-Received: by 2002:adf:f691:0:b0:1ed:f546:bd81 with SMTP id v17-20020adff691000000b001edf546bd81mr6474367wrp.542.1645803448438;
        Fri, 25 Feb 2022 07:37:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p15-20020adfce0f000000b001edc0bcf875sm2647168wrn.102.2022.02.25.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:37:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: timer: exynos4210-mct: describe known hardware and its interrupts
Date:   Fri, 25 Feb 2022 16:36:48 +0100
Message-Id: <20220225153650.289923-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Samsung Exynos SoCs use almost the same Multi-Core Timer
block, so only two compatibles were used so far (for Exynos4210 and
Exynos4412 flavors) with Exynos4210-one being used in most of the SoCs.
However the Exynos4210 flavor actually differs by number of interrupts.

Add new compatibles, maintaining backward compatibility with Exynos4210,
and constraints for number of interrupts.  This allows to exactly match
the Exynos MCT hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../timer/samsung,exynos4210-mct.yaml         | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index f11cbc7ccc14..d4e23fd7a1da 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -19,9 +19,20 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - samsung,exynos4210-mct
-      - samsung,exynos4412-mct
+    oneOf:
+      - enum:
+          - samsung,exynos4210-mct
+          - samsung,exynos4412-mct
+      - items:
+          - enum:
+              - samsung,exynos3250-mct
+              - samsung,exynos5250-mct
+              - samsung,exynos5260-mct
+              - samsung,exynos5420-mct
+              - samsung,exynos5433-mct
+              - samsung,exynos850-mct
+              - tesla,fsd-mct
+          - const: samsung,exynos4210-mct
 
   clocks:
     minItems: 2
@@ -63,6 +74,44 @@ required:
   - interrupts
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos3250-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 8
+          maxItems: 8
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5250-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5260-mct
+              - samsung,exynos5420-mct
+              - samsung,exynos5433-mct
+              - samsung,exynos850-mct
+    then:
+      properties:
+        interrupts:
+          minItems: 12
+          maxItems: 12
+
 additionalProperties: false
 
 examples:
-- 
2.32.0

