Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F99479262
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhLQRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbhLQRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:05:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7CC061748;
        Fri, 17 Dec 2021 09:05:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso3581310wmc.1;
        Fri, 17 Dec 2021 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9hIAHZe2nNZJ5Axu76isAk7I5KUQauC+n1Gzmxr3O4=;
        b=aTT5yMmSmXGPKfZyAo3I8QxPQaP25o7io12t2HNDJwrX2HPAyNYg+WG9Z48ioid0GC
         VY0FKEtb/NdmGBMkLBt37Spa9Y2lTUEr3dB1CavUIJB6ETzIPq1vEhrm+42ta2q4CGtK
         AlvCzJPqlglDTynkYwrHXT0cVo/1GxaNjC0cIzlWYAxXcWVSlDJlM+yLUK3ZsqunpF4a
         /Q9EQQ3aB4cYtz5zWDptYw27kmiIhGLCatvi7JoB0js2gLC+y4OS+h0EpGJDnPjR7U8t
         2j6llNfGKrrj9I5g3733o9GNyW4fEnmjGvx7LHapHRT1g/I3MP1bfJdNqGkVUmmPqJty
         0RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9hIAHZe2nNZJ5Axu76isAk7I5KUQauC+n1Gzmxr3O4=;
        b=xi6WFHbu1we6hJHv4lw1anunm67gtbzI6+6Z80plY5S4EbW3dz1rg6l1LwoXDv1UFh
         tYDkSzkDN/zFrL6b2ajVXMXdjstsuiQVmu8fYfUwnyoMhkG88BsRZo9uPfgY69GlG9sB
         vWRVDmtNDJjBGE8CX+FaDMCTSNhQ5DUm+e1apasROj+GPEdPG90R3bvEjReq4fNc+vwi
         62dum0FNDj8/JdC7+0Tkmz50h4Zo3VK536/kE3PbxWtNZMoUx3lw1QwO3CGndeo1qx+D
         J08OB0mzsBrq/Orx4iN1xYY3dbuIaeKGoHF5v2fFeAxBcN0qpOq5mhNw4Cy8AS3behwp
         1gzA==
X-Gm-Message-State: AOAM532z4sTJnnBQTtPD2A0DX9TQA8EFNQWklVBGLuYyLg23Qdf9YZZ0
        pcoH9a4C8hYK5hhH7QGCNIc3798+WMZiHw==
X-Google-Smtp-Source: ABdhPJw+iD2WUNc1BT49CzoxR659kkkboodHMlBQSfw8cUlXvzpoeRr0Mq+92v6acf/EVtxKQV3EOQ==
X-Received: by 2002:a7b:c10a:: with SMTP id w10mr10224535wmi.183.1639760719852;
        Fri, 17 Dec 2021 09:05:19 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id b6sm13488018wmq.45.2021.12.17.09.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:05:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: regulator: tps6586x: Convert to json-schema
Date:   Fri, 17 Dec 2021 18:05:06 +0100
Message-Id: <20211217170507.2843568-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Texas Instruments TPS6586x bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/regulator/ti,tps6586x.yaml       | 184 ++++++++++++++++++
 .../bindings/regulator/tps6586x.txt           | 135 -------------
 2 files changed, 184 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml b/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
new file mode 100644
index 000000000000..c5ea7012c653
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps6586x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS6586x family of voltage regulator
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    const: ti,tps6586x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  sys-supply:
+    description: input supply for SYS
+
+  vin-sm0-supply:
+    description: input supply for SM0
+
+  vin-sm1-supply:
+    description: input supply for SM1
+
+  vin-sm2-supply:
+    description: input supply for SM2
+
+  vinldo01-supply:
+    description: input supply for LDO0 and LDO1
+
+  vinldo23-supply:
+    description: input supply for LDO2 and LDO3
+
+  vinldo4-supply:
+    description: input supply for LDO4
+
+  vinldo678-supply:
+    description: input supply for LDO6, LDO7 and LDO8
+
+  vinldo9-supply:
+    description: input supply for LDO9
+
+  ti,system-power-controller:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If this property exists, it specifies that this PMIC controls the system power.
+
+  regulators:
+    type: object
+    description: |
+      A node that houses a sub-node for each regulator within the device. Each sub-node is
+      identified using the node's name (or the deprecated regulator-compatible property if
+      present), with valid values listed below. The content of each sub-node is defined by the
+      standard binding for regulators; see regulator.yaml.
+
+      Note: LDO5 and LDO_RTC is supplied by SYS regulator internally and the operating system
+        needs to take care of establishing the proper parent child relationships.
+
+    patternProperties:
+      "^sys|sm[0-2]|ldo[0-9]|ldo_rtc$":
+        $ref: regulator.yaml
+
+allOf:
+  - $ref: /schemas/gpio/gpio.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic@34 {
+        compatible = "ti,tps6586x";
+        reg = <0x34>;
+        interrupts = <0 88 0x4>;
+
+        #gpio-cells = <2>;
+        gpio-controller;
+
+        ti,system-power-controller;
+
+        sys-supply = <&dummy>;
+        vin-sm0-supply = <&dummy>;
+        vin-sm1-supply = <&dummy>;
+        vin-sm2-supply = <&dummy>;
+        vinldo01-supply = <&dummy>;
+        vinldo23-supply = <&dummy>;
+        vinldo4-supply = <&dummy>;
+        vinldo678-supply = <&dummy>;
+        vinldo9-supply = <&dummy>;
+
+        regulators {
+          sys {
+            regulator-name = "vdd_sys";
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          sm0 {
+            regulator-min-microvolt = < 725000>;
+            regulator-max-microvolt = <1500000>;
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          sm1 {
+            regulator-min-microvolt = < 725000>;
+            regulator-max-microvolt = <1500000>;
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          sm2 {
+            regulator-min-microvolt = <3000000>;
+            regulator-max-microvolt = <4550000>;
+            regulator-boot-on;
+            regulator-always-on;
+          };
+
+          ldo0 {
+            regulator-name = "PCIE CLK";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          ldo1 {
+            regulator-min-microvolt = < 725000>;
+            regulator-max-microvolt = <1500000>;
+          };
+
+          ldo2 {
+            regulator-min-microvolt = < 725000>;
+            regulator-max-microvolt = <1500000>;
+          };
+
+          ldo3 {
+            regulator-min-microvolt = <1250000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          ldo4 {
+            regulator-min-microvolt = <1700000>;
+            regulator-max-microvolt = <2475000>;
+          };
+
+          ldo5 {
+            regulator-min-microvolt = <1250000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          ldo6 {
+            regulator-min-microvolt = <1250000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          ldo7 {
+            regulator-min-microvolt = <1250000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          ldo8 {
+            regulator-min-microvolt = <1250000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          ldo9 {
+            regulator-min-microvolt = <1250000>;
+            regulator-max-microvolt = <3300000>;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/regulator/tps6586x.txt b/Documentation/devicetree/bindings/regulator/tps6586x.txt
deleted file mode 100644
index 8b40cac24d93..000000000000
--- a/Documentation/devicetree/bindings/regulator/tps6586x.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-TPS6586x family of regulators
-
-Required properties:
-- compatible: "ti,tps6586x"
-- reg: I2C slave address
-- interrupts: the interrupt outputs of the controller
-- #gpio-cells: number of cells to describe a GPIO
-- gpio-controller: mark the device as a GPIO controller
-- regulators: A node that houses a sub-node for each regulator within the
-  device. Each sub-node is identified using the node's name (or the deprecated
-  regulator-compatible property if present), with valid values listed below.
-  The content of each sub-node is defined by the standard binding for
-  regulators; see regulator.txt.
-  sys, sm[0-2], ldo[0-9] and ldo_rtc
-- sys-supply: The input supply for SYS.
-- vin-sm0-supply: The input supply for the SM0.
-- vin-sm1-supply: The input supply for the SM1.
-- vin-sm2-supply: The input supply for the SM2.
-- vinldo01-supply: The input supply for the LDO1 and LDO2
-- vinldo23-supply: The input supply for the LDO2 and LDO3
-- vinldo4-supply: The input supply for the LDO4
-- vinldo678-supply: The input supply for the LDO6, LDO7 and LDO8
-- vinldo9-supply: The input supply for the LDO9
-
-Optional properties:
-- ti,system-power-controller: Telling whether or not this pmic is controlling
-  the system power.
-
-Each regulator is defined using the standard binding for regulators.
-
-Note: LDO5 and LDO_RTC is supplied by SYS regulator internally and driver
-      take care of making proper parent child relationship.
-
-Example:
-
-	pmu: tps6586x@34 {
-		compatible = "ti,tps6586x";
-		reg = <0x34>;
-		interrupts = <0 88 0x4>;
-
-		#gpio-cells = <2>;
-		gpio-controller;
-
-		ti,system-power-controller;
-
-		sys-supply = <&some_reg>;
-		vin-sm0-supply = <&some_reg>;
-		vin-sm1-supply = <&some_reg>;
-		vin-sm2-supply = <&some_reg>;
-		vinldo01-supply = <...>;
-		vinldo23-supply = <...>;
-		vinldo4-supply = <...>;
-		vinldo678-supply = <...>;
-		vinldo9-supply = <...>;
-
-		regulators {
-			sys_reg: sys {
-				regulator-name = "vdd_sys";
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sm0_reg: sm0 {
-				regulator-min-microvolt = < 725000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sm1_reg: sm1 {
-				regulator-min-microvolt = < 725000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sm2_reg: sm2 {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <4550000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo0_reg: ldo0 {
-				regulator-name = "PCIE CLK";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo1_reg: ldo1 {
-				regulator-min-microvolt = < 725000>;
-				regulator-max-microvolt = <1500000>;
-			};
-
-			ldo2_reg: ldo2 {
-				regulator-min-microvolt = < 725000>;
-				regulator-max-microvolt = <1500000>;
-			};
-
-			ldo3_reg: ldo3 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo4_reg: ldo4 {
-				regulator-min-microvolt = <1700000>;
-				regulator-max-microvolt = <2475000>;
-			};
-
-			ldo5_reg: ldo5 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo6_reg: ldo6 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo7_reg: ldo7 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo8_reg: ldo8 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			ldo9_reg: ldo9 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-			};
-		};
-	};
-- 
2.34.1

