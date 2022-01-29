Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84E4A31A6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353291AbiA2Thv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 14:37:51 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60320
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353121AbiA2ThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 14:37:13 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5A50740318
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643485026;
        bh=wEL89/ynvDT+atuZL4csG/pFwiNgDZ9SBr5HgtriJD4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ijg7hslmQ2QMNqyOZG231syx5KMpd3jfLwPtPa58pRGlFXMQiO+tC2Ttfdh3BlSIi
         103oTWND1A4yw30NDi9hFCmSCrA3VP3Vm7qG3yjtNlsFaa6xZUqne7DsuXakPaiXLI
         xO0o8X5lPry9VbWa6uslH+StoJN/quQfx0S2+/MQxMcCtldCMuZZgsTbKkR5nPT7FO
         gPr/BzqxlM8AupN9iZMVBqEj6/ioOI9KPY3GW9HZe1LtR2LUX2iNFySIeKbJ3UeN0i
         xH8wGFAwjwE6LiPzWtHCcs1aQ0bKkTk+QR032MmhSUx96LyWeHJCbwToNKvlaErSQ3
         Q4wXD1ugirWaQ==
Received: by mail-ed1-f71.google.com with SMTP id bc24-20020a056402205800b00407cf07b2e0so4798218edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEL89/ynvDT+atuZL4csG/pFwiNgDZ9SBr5HgtriJD4=;
        b=mcqWXqHUHG1+FfK9eIEkP/LkEDvpR2FO8Fb/5FuqWPmVgFgR+BzEJHNPgeOz00esx5
         I7IXObR3yzOf5Qm3H3rWuu5rC5zs7QxzBePwS9XuONguB5d1x/CvGu5iGZ7bt9t/GtUz
         mlB7YB9Uao37bRhTXmCY3iRHimYJ6VHDDaqAnOGUtaaQJNViMP4IpIpfJTtTpR8EwpVA
         H20BdhOdN4Cc36fSaO2yGmnWy2rkXCBWKbxrOHPeSAan9REC9cjY2GM6hJ4JeXqv5E0o
         byIywL7SrBn/jDuswmy5Eyo9eRsJ+0EN0SW4jjlHOLZO/h5M7kD6QCypXnEIeS1zopqX
         OcRg==
X-Gm-Message-State: AOAM533h/9KR1pW04H0GilzSph5uf21ljbnjcjoONHWjrsw3hRKmaNkY
        o7v3M2mS7T5OVk5H96AH3NvOOjNari6l5A9a02i10UouBrgK3cGIwb4Qmyrd7RyZA0MjeAHlQEF
        2QgC39IxRrUZYiUWaIIGlTaCuxwxQWn2SPhk0kIDH5w==
X-Received: by 2002:a17:907:7f88:: with SMTP id qk8mr7709005ejc.622.1643485016446;
        Sat, 29 Jan 2022 11:36:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIgwaMH7JjSWPd08LTkb2moQW6C24pusHL1cGkG0T2qvrd39Ci/vgQ+6J35I6bR1JyOn/FSw==
X-Received: by 2002:a17:907:7f88:: with SMTP id qk8mr7708987ejc.622.1643485016259;
        Sat, 29 Jan 2022 11:36:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bf21sm14968026edb.2.2022.01.29.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 11:36:55 -0800 (PST)
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
Subject: [PATCH 6/8] dt-bindings: phy: samsung,exynos5250-sata-phy: convert to dtschema
Date:   Sat, 29 Jan 2022 20:36:44 +0100
Message-Id: <20220129193646.372481-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung Exynos5250 SoC SATA PHY bindings to DT schema
format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../phy/samsung,exynos5250-sata-phy.yaml      | 64 +++++++++++++++++++
 .../devicetree/bindings/phy/samsung-phy.txt   | 26 --------
 2 files changed, 64 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos5250-sata-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos5250-sata-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos5250-sata-phy.yaml
new file mode 100644
index 000000000000..62b39bb46585
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos5250-sata-phy.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,exynos5250-sata-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5250 SoC SATA PHY
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,exynos5250-sata-phy
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sata_phyctrl
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  samsung,syscon-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU system controller interface.
+
+  samsung,exynos-sataphy-i2c-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to I2C SATA interface.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#phy-cells"
+  - reg
+  - samsung,syscon-phandle
+  - samsung,exynos-sataphy-i2c-phandle
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5250.h>
+
+    phy@12170000 {
+        compatible = "samsung,exynos5250-sata-phy";
+        reg = <0x12170000 0x1ff>;
+        clocks = <&clock CLK_SATA_PHYCTRL>;
+        clock-names = "sata_phyctrl";
+        #phy-cells = <0>;
+        samsung,syscon-phandle = <&pmu_system_controller>;
+        samsung,exynos-sataphy-i2c-phandle = <&sata_phy_i2c>;
+    };
diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
index d26ac7401258..1ee78016dc72 100644
--- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
+++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
@@ -1,29 +1,3 @@
-Samsung SATA PHY Controller
----------------------------
-
-SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
-Each SATA PHY controller should have its own node.
-
-Required properties:
-- compatible        : compatible list, contains "samsung,exynos5250-sata-phy"
-- reg : offset and length of the SATA PHY register set;
-- #phy-cells : must be zero
-- clocks : must be exactly one entry
-- clock-names : must be "sata_phyctrl"
-- samsung,exynos-sataphy-i2c-phandle : a phandle to the I2C device, no arguments
-- samsung,syscon-phandle : a phandle to the PMU system controller, no arguments
-
-Example:
-	sata_phy: sata-phy@12170000 {
-		compatible = "samsung,exynos5250-sata-phy";
-		reg = <0x12170000 0x1ff>;
-		clocks = <&clock 287>;
-		clock-names = "sata_phyctrl";
-		#phy-cells = <0>;
-		samsung,exynos-sataphy-i2c-phandle = <&sata_phy_i2c>;
-		samsung,syscon-phandle = <&pmu_syscon>;
-	};
-
 Device-Tree bindings for sataphy i2c client driver
 --------------------------------------------------
 
-- 
2.32.0

