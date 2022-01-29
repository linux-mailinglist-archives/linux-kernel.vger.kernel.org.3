Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379D24A3199
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353137AbiA2ThR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:17 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37292
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353078AbiA2ThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:00 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D42943F4BC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485012;
        bh=aWs9MFAf4+mGeKyXFFmmho+fwz/+ZD3RFsWsucBweiU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hArjU2AeMt5L6U1o277akxloVrPJ55paLQovP2eI+oWS4tn+doBQhe1RD3YUbo5M5
         R/xUuczV9HxoftTFqVh2qacwdEti0A9eMQO9s6VP6uKaTRigAUxXRrq1TFdzT2NxaV
         pkSB9PwsKDuH0HaC4SQOEjVS2EF9Ku7GPxH3L2ib2OpWQRqimoi7gRRwuwmghcYjjp
         SlKLrmVkxvZR6XpzvrO2aTrjEQ13cdSGaPW7tzg2/nA7du5w9eh+70yJpo1+pxmrJ/
         /AnU+2uxhtfZgzVos83Ces/OOleIVAG8Icd+TA/EAGKILRDp4QPoiglipeHY7mCMCS
         sfT7nfkqQzafQ==
Received: by mail-ed1-f69.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso4742565edj.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWs9MFAf4+mGeKyXFFmmho+fwz/+ZD3RFsWsucBweiU=;
        b=NG1MTuU65M3vhk70KW20bAdaU+dnNuN/CUJV2gOpgIZnr2XkOLARMX6OT6Ax2fe/FY
         TJu4iDgU+qHfe5c6Upq/5O1uFek79Z2BBjkt7xhbYnSjWSO0em7+rGebePHTgW4x5x9N
         QfUYiqioRpObrs7UNgVQwN0lYVfy/BPcyd7t84PIAhPog19NfZ2n5TmWo/UC/4OKmBP4
         YKZKYhhwLgsJkjhV7o7MBuFYGBNXADaBkI4s4iwq8TRtYjNwCsAciuhnUmWd7vWBV2qu
         qOzLK07O3ODGmhpUQLbVcIkcmdhg+IxH50UcKJYVG5Ngb+lR/n7pF5OA/PrC82v6oq8A
         xrsA==
X-Gm-Message-State: AOAM53078pbPW6tiCBcNNGvk2YK/XH4I9tWYPTnqHa+q+zi4ATZ/Sh4s
        coDNJsb6gYWmdWtsvEVAV/35D4qiQZQdjCWN/5WeREVcM7BVSvaOXXYAU6kL/iZhmdjhtNsFabb
        qzkAVf7CEQ6QfSB8Ex7/fMVSCBf0f2T0IKkUwBsle9A==
X-Received: by 2002:a17:906:58d4:: with SMTP id e20mr11497469ejs.769.1643485012497;
        Sat, 29 Jan 2022 11:36:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK4GEK3O3dtaeIo1993o51uYQOxqNVlu9jOjRfve+nnNRq3R7aTnPPnhTn/1e2TTrcGT1/Uw==
X-Received: by 2002:a17:906:58d4:: with SMTP id e20mr11497455ejs.769.1643485012324;
        Sat, 29 Jan 2022 11:36:52 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: phy: samsung,mipi-video-phy: convert to dtschema
Date:   Sat, 29 Jan 2022 20:36:41 +0100
Message-Id: <20220129193646.372481-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung SoC MIPI CSIS/DSIM DPHY bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/phy/samsung,mipi-video-phy.yaml  | 113 ++++++++++++++++++
 .../devicetree/bindings/phy/samsung-phy.txt   |  29 -----
 2 files changed, 113 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
new file mode 100644
index 000000000000..54aa056b224d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,mipi-video-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P/Exynos SoC MIPI CSIS/DSIM DPHY
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description: |
+  For samsung,s5pv210-mipi-video-phy compatible PHYs the second cell in the
+  PHY specifier identifies the PHY and its meaning is as follows::
+    0 - MIPI CSIS 0,
+    1 - MIPI DSIM 0,
+    2 - MIPI CSIS 1,
+    3 - MIPI DSIM 1.
+
+  samsung,exynos5420-mipi-video-phy and samsung,exynos5433-mipi-video-phy
+  support additional fifth PHY::
+    4 - MIPI CSIS 2.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s5pv210-mipi-video-phy
+      - samsung,exynos5420-mipi-video-phy
+      - samsung,exynos5433-mipi-video-phy
+
+  "#phy-cells":
+    const: 1
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU system controller interface, valid only for
+      samsung,s5pv210-mipi-video-phy and samsung,exynos5420-mipi-video-phy.
+
+  samsung,pmu-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU system controller interface, valid for
+      samsung,exynos5433-mipi-video-phy.
+
+  samsung,disp-sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to DISP system controller interface, valid for
+      samsung,exynos5433-mipi-video-phy.
+
+  samsung,cam0-sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to CAM0 system controller interface, valid for
+      samsung,exynos5433-mipi-video-phy.
+
+  samsung,cam1-sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to CAM1 system controller interface, valid for
+      samsung,exynos5433-mipi-video-phy.
+
+required:
+  - compatible
+  - "#phy-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s5pv210-mipi-video-phy
+              - samsung,exynos5420-mipi-video-phy
+    then:
+      properties:
+        samsung,pmu-syscon: false
+        samsung,disp-sysreg: false
+        samsung,cam0-sysreg: false
+        samsung,cam1-sysreg: false
+      required:
+        - syscon
+    else:
+      properties:
+        syscon: false
+      required:
+        - samsung,pmu-syscon
+        - samsung,disp-sysreg
+        - samsung,cam0-sysreg
+        - samsung,cam1-sysreg
+
+additionalProperties: false
+
+examples:
+  - |
+    phy {
+        compatible = "samsung,exynos5433-mipi-video-phy";
+        #phy-cells = <1>;
+        samsung,pmu-syscon = <&pmu_system_controller>;
+        samsung,cam0-sysreg = <&syscon_cam0>;
+        samsung,cam1-sysreg = <&syscon_cam1>;
+        samsung,disp-sysreg = <&syscon_disp>;
+    };
+
+  - |
+    phy {
+        compatible = "samsung,s5pv210-mipi-video-phy";
+        syscon = <&pmu_system_controller>;
+        #phy-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 390065f49b62..6ab16734eb65 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -1,32 +1,3 @@
-Samsung S5P/Exynos SoC series MIPI CSIS/DSIM DPHY
--------------------------------------------------
-
-Required properties:
-- compatible : should be one of the listed compatibles:
-	- "samsung,s5pv210-mipi-video-phy"
-	- "samsung,exynos5420-mipi-video-phy"
-	- "samsung,exynos5433-mipi-video-phy"
-- #phy-cells : from the generic phy bindings, must be 1;
-
-In case of s5pv210 and exynos5420 compatible PHYs:
-- syscon - phandle to the PMU system controller
-
-In case of exynos5433 compatible PHY:
- - samsung,pmu-syscon - phandle to the PMU system controller
- - samsung,disp-sysreg - phandle to the DISP system registers controller
- - samsung,cam0-sysreg - phandle to the CAM0 system registers controller
- - samsung,cam1-sysreg - phandle to the CAM1 system registers controller
-
-For "samsung,s5pv210-mipi-video-phy" compatible PHYs the second cell in
-the PHY specifier identifies the PHY and its meaning is as follows:
-  0 - MIPI CSIS 0,
-  1 - MIPI DSIM 0,
-  2 - MIPI CSIS 1,
-  3 - MIPI DSIM 1.
-"samsung,exynos5420-mipi-video-phy" and "samsung,exynos5433-mipi-video-phy"
-supports additional fifth PHY:
-  4 - MIPI CSIS 2.
-
 Samsung Exynos SoC series Display Port PHY
 -------------------------------------------------
 
-- 
2.32.0

