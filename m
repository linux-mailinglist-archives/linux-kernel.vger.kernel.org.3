Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5264A319F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353153AbiA2ThU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37332
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353084AbiA2ThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:04 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C64A440023
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485015;
        bh=LyTtoI1YW7+oTxeL8M/tztYAXTSPk1l09vBr/yrLL8w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EqzX+xB3xNHIlBQ9mIMNjpodNSJX5yY/1ukgW8hGtu5h1sjGQ4YA4Puvgpeupg0p1
         I+n1DgzlFPhSEZxUL8ZcZv3yWiCMSW2GFxWcVf3R6jwtgP0FQ4KCfBqG1u//Tm292R
         Plu92KFcf58cVbCbGZ2UD4Nt5vI0LHnYT62IQdPoYRyOR5zcRA7vQYiaBCKpWjq8lN
         W/IftmDRHIUt1unZzH15FOHkYRLpcIIpTjT6g+/tjTyrUsdxDMI0JORE6RDAnazt8m
         UDTbTqRcjoJMAW3pCwbFjGbLi+xPGbNDFZP7YFqCzkY0sCPgPXbEtHlGd7S6OyKUys
         ToOVjb0oNk+vQ==
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a0564020f1600b00407b56326a2so4782162eda.18
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyTtoI1YW7+oTxeL8M/tztYAXTSPk1l09vBr/yrLL8w=;
        b=QRkskLW2F5x/LeFZ62oWSMRBFR7oPGIt5byIg2cWU8Y/dPgv8aVgwOnDTxIw5ZrGJB
         MimFpsar5UarWyhuqW/xCDe3AUS8oDLQV+937UD/xpWTAtqJ+5hc5R6mrEDIsrJE2dZf
         4aQhfgoGYY4CIbyx2v9hpDAnY9uCtaRhjj29abXI2Fj/1v2CfcZ6Qul6R2RRtDXoE1md
         pLeC0ipXqKVNY0c5+mlufsPm6oOglcgEMkLp3aPmuV3cVbQ5dKJtQyNX6IBnaEvjUeAL
         m0Y/1fHFdg9roI+7ikHd+0VIHff8i/dYE9U8AeGuYgSWg0uYaZlikOrL0dyfsHm06oIB
         LNIw==
X-Gm-Message-State: AOAM531D+p1vPM9Aib2OUjJP9TXwL6l2aq2rrR7++n3nAojAtYRzFOZw
        OGfCsdyHgPLwPC22JgofLclMr+AdLTZyubyzchLFrM93WAiCK7TreN7C8lMZawVyeqnxICax3jL
        zEFMrN0eswUo9izaba3sy1WnfUE7oyQIaFNT3VqOdJA==
X-Received: by 2002:a17:907:94d1:: with SMTP id dn17mr11331182ejc.79.1643485014979;
        Sat, 29 Jan 2022 11:36:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhzfd/xglI5jZWhrnmvGmbIdIE9B6L8oszbLHSQI9bjRqWCja/h/zdfcLDY7eJzLx7Op0Xrw==
X-Received: by 2002:a17:907:94d1:: with SMTP id dn17mr11331165ejc.79.1643485014717;
        Sat, 29 Jan 2022 11:36:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:53 -0800 (PST)
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
Subject: [PATCH 5/8] dt-bindings: phy: samsung,usb2-phy: convert to dtschema
Date:   Sat, 29 Jan 2022 20:36:43 +0100
Message-Id: <20220129193646.372481-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung SoC USB 2.0 PHY bindings to DT schema format.

Except the conversion, add also vbus-supply property which was already
used by the driver and DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/phy/samsung,usb2-phy.yaml        | 102 ++++++++++++++++++
 .../devicetree/bindings/phy/samsung-phy.txt   |  60 -----------
 MAINTAINERS                                   |   2 +-
 3 files changed, 103 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
new file mode 100644
index 000000000000..056e270a4e88
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5P/Exynos SoC USB 2.0 PHY
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description: |
+  The first phandle argument in the PHY specifier identifies the PHY, its
+  meaning is compatible dependent. For the currently supported SoCs (Exynos4210
+  and Exynos4212) it is as follows::
+    0 - USB device ("device"),
+    1 - USB host ("host"),
+    2 - HSIC0 ("hsic0"),
+    3 - HSIC1 ("hsic1"),
+  Exynos3250 has only USB device phy available as phy 0.
+
+  Exynos4210 and Exynos4212 use mode switching and require that mode switch
+  register is supplied.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos3250-usb2-phy
+      - samsung,exynos4210-usb2-phy
+      - samsung,exynos4x12-usb2-phy
+      - samsung,exynos5250-usb2-phy
+      - samsung,exynos5420-usb2-phy
+      - samsung,s5pv210-usb2-phy
+
+  clocks:
+    items:
+      - description: PHY module gate clock.
+      - description: Reference rate clock of PHY module.
+
+  clock-names:
+    items:
+      - const: phy
+      - const: ref
+
+  "#phy-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  samsung,pmureg-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU system controller interface.
+
+  samsung,sysreg-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to system registers interface.
+
+  vbus-supply:
+    description:
+      VBUS power source.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - reg
+  - samsung,pmureg-phandle
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos4x12-usb2-phy
+              - samsung,exynos5250-usb2-phy
+              - samsung,exynos5420-usb2-phy
+    then:
+      required:
+        - samsung,sysreg-phandle
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+
+    phy@12130000 {
+        compatible = "samsung,exynos5420-usb2-phy";
+        reg = <0x12130000 0x100>;
+        #phy-cells = <1>;
+        clocks = <&clock CLK_USBH20>, <&clock CLK_SCLK_USBPHY300>;
+        clock-names = "phy", "ref";
+        samsung,sysreg-phandle = <&sysreg_system_controller>;
+        samsung,pmureg-phandle = <&pmu_system_controller>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index 839ffe2a2d05..d26ac7401258 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -1,63 +1,3 @@
-Samsung S5P/Exynos SoC series USB PHY
--------------------------------------------------
-
-Required properties:
-- compatible : should be one of the listed compatibles:
-	- "samsung,exynos3250-usb2-phy"
-	- "samsung,exynos4210-usb2-phy"
-	- "samsung,exynos4x12-usb2-phy"
-	- "samsung,exynos5250-usb2-phy"
-	- "samsung,exynos5420-usb2-phy"
-	- "samsung,s5pv210-usb2-phy"
-- reg : a list of registers used by phy driver
-	- first and obligatory is the location of phy modules registers
-- samsung,sysreg-phandle - handle to syscon used to control the system registers
-- samsung,pmureg-phandle - handle to syscon used to control PMU registers
-- #phy-cells : from the generic phy bindings, must be 1;
-- clocks and clock-names:
-	- the "phy" clock is required by the phy module, used as a gate
-	- the "ref" clock is used to get the rate of the clock provided to the
-	  PHY module
-
-Optional properties:
-- vbus-supply: power-supply phandle for vbus power source
-
-The first phandle argument in the PHY specifier identifies the PHY, its
-meaning is compatible dependent. For the currently supported SoCs (Exynos 4210
-and Exynos 4212) it is as follows:
-  0 - USB device ("device"),
-  1 - USB host ("host"),
-  2 - HSIC0 ("hsic0"),
-  3 - HSIC1 ("hsic1"),
-Exynos3250 has only USB device phy available as phy 0.
-
-Exynos 4210 and Exynos 4212 use mode switching and require that mode switch
-register is supplied.
-
-Example:
-
-For Exynos 4412 (compatible with Exynos 4212):
-
-usbphy: phy@125b0000 {
-	compatible = "samsung,exynos4x12-usb2-phy";
-	reg = <0x125b0000 0x100>;
-	clocks = <&clock 305>, <&clock 2>;
-	clock-names = "phy", "ref";
-	#phy-cells = <1>;
-	samsung,sysreg-phandle = <&sys_reg>;
-	samsung,pmureg-phandle = <&pmu_reg>;
-};
-
-Then the PHY can be used in other nodes such as:
-
-phy-consumer@12340000 {
-	phys = <&usbphy 2>;
-	phy-names = "phy";
-};
-
-Refer to DT bindings documentation of particular PHY consumer devices for more
-information about required PHYs and the way of specification.
-
 Samsung SATA PHY Controller
 ---------------------------
 
diff --git a/MAINTAINERS b/MAINTAINERS
index ddcee331dc09..46f6ced8370a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17168,7 +17168,7 @@ SAMSUNG USB2 PHY DRIVER
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/phy/samsung-phy.txt
+F:	Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
 F:	Documentation/driver-api/phy/samsung-usb2.rst
 F:	drivers/phy/samsung/phy-exynos4210-usb2.c
 F:	drivers/phy/samsung/phy-exynos4x12-usb2.c
-- 
2.32.0

