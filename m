Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27D477977
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhLPQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:41:46 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43824
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233443AbhLPQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:41:45 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A2C13F1FD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639672904;
        bh=JfLJ4CziLh4wHDu8UqBCS+3mFRyC0Pfk57YtxR/Sqww=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Q3Y0zxePCuXbDvP4CmBazRXBAc1zTgCfHENjbspZGlx+3CAi9YU6pdX6Y2VEpmhMd
         SpUVwBEBSNHnRZPtRObpgioluiS8a2S1ncyhQX4A5xyAXYOJqcFG0UjZ/F9AFtQ37P
         245L3ZCMUezSblEQmL3BVb5znOI4kVyr9w3VpPMhGydPo+S2euhu6z121FR9pexjx+
         oQOKXs6EJK42IubN2OZEeZv1yasOAQSUZ3FuI503HTnLWYeH2tkwpFVmReRvLAUvIE
         3b9qIJw7qjP8h5+/b7hK4uI8JqWCyiHJmXFX64yn1x+tK4/vzH/tEEz4C2WlF+xc38
         b6tB7RhKeyLYw==
Received: by mail-wr1-f72.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so7123760wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfLJ4CziLh4wHDu8UqBCS+3mFRyC0Pfk57YtxR/Sqww=;
        b=xYoUdrV/BUj2nxA0V47L5KI4rVcra6qgNSaW9xafjdytMFnUwECzHsUUA+z1u8nFYg
         VMTzdp4tkziRDmOqMEezKivaKkv9wGO4W9klb44BDcQqCn4pnq7lgaxXrQDo3e0NyIpu
         H9aUdVBg2m3onKBCzQJXLxZjm44ppNvWvV/hxCRfpsEkV7GTaQsy5bDzrHDeDH6eS9uM
         ZNUeVj/UJ8e8wYm+lgZx1nf2Y7PrL0MV2wqOCaIvAgDKs0a2g6uiBteMMHeSwyMr1NPE
         HiNnBmwsPPiDzvoevBPvBr3A/o7vD+WzcC4CdUrF2lsXvRzhLvHR/KBiaAUTAxVwkWdj
         /RSg==
X-Gm-Message-State: AOAM531qGG5c9bkazeXzDXYRP28BGjT/AUJhYMQxyCtBItJU1HWG+7tU
        gALbgiY5SaiJ0AvTYQsULlEEmux36VaIY4qYYlpIbZFpyJJw6TVB7IagOmtka+LoS/wB/XvF4Sk
        E30lALLzDVZLAOt1jlCXC4+aUpA03fEhHJ/fc7Q8EGA==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr5766093wmq.18.1639672903692;
        Thu, 16 Dec 2021 08:41:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybNZu1IHHUp1mPGGOaQaPtFp+rlseoN/NNYDl1gNaarMkwRFjQl6C0YHI4YeWDd2Z1dR678Q==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr5766066wmq.18.1639672903395;
        Thu, 16 Dec 2021 08:41:43 -0800 (PST)
Received: from alex.home (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id e7sm6453994wrg.31.2021.12.16.08.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:41:43 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 2/2] dt-bindings: Migrate DA9063 text bindings to YAML
Date:   Thu, 16 Dec 2021 17:40:37 +0100
Message-Id: <20211216164037.2888316-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216164037.2888316-1-alexandre.ghiti@canonical.com>
References: <20211216164037.2888316-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DA9063 devices bindings used text format, so migrate those bindings to YAML
format before adding any new bindings.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---

Changes in v2:
- Fix all errors detected with make dt_binding_checks

 .../bindings/input/da9063-onkey.yaml          |  39 ++++++
 .../devicetree/bindings/mfd/da9063.txt        | 111 ------------------
 .../devicetree/bindings/mfd/da9063.yaml       | 105 +++++++++++++++++
 .../bindings/regulator/da9063-regulator.yaml  |  51 ++++++++
 .../devicetree/bindings/rtc/da9063-rtc.yaml   |  31 +++++
 .../bindings/watchdog/da9063-watchdog.yaml    |  31 +++++
 6 files changed, 257 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/da9063-onkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/da9063.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/da9063-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/da9063-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9063-watchdog.yaml

diff --git a/Documentation/devicetree/bindings/input/da9063-onkey.yaml b/Documentation/devicetree/bindings/input/da9063-onkey.yaml
new file mode 100644
index 000000000000..e49f69f7aaac
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/da9063-onkey.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/da9063-onkey.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OnKey driver for Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Support Opensource <support.opensource@diasemi.com>
+
+description: |
+  This module is part of the DA9063 MFD device. For more details, see
+  Documentation/devicetree/bindings/mfd/da9063.yaml.
+
+  The OnKey controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  This node defines the OnKey settings for controlling the key
+  functionality of the device. The node should contain the compatible property
+  with the value "dlg,da9063-onkey".
+
+properties:
+  compatible:
+    const: dlg,da9063-onkey
+
+  dlg,disable-key-power:
+    description: |
+      Disable power-down using a long key-press. If this
+      entry exists the OnKey driver will remove support for the KEY_POWER key
+      press. If this entry does not exist then by default the key-press
+      triggered power down is enabled and the OnKey will support both KEY_POWER
+      and KEY_SLEEP.
+    type: boolean
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Documentation/devicetree/bindings/mfd/da9063.txt
deleted file mode 100644
index 91b79a21d403..000000000000
--- a/Documentation/devicetree/bindings/mfd/da9063.txt
+++ /dev/null
@@ -1,111 +0,0 @@
-* Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
-
-DA9063 consists of a large and varied group of sub-devices (I2C Only):
-
-Device                   Supply Names    Description
-------                   ------------    -----------
-da9063-regulator        :               : LDOs & BUCKs
-da9063-onkey            :               : On Key
-da9063-rtc              :               : Real-Time Clock (DA9063 only)
-da9063-watchdog         :               : Watchdog
-
-======
-
-Required properties:
-
-- compatible : Should be "dlg,da9063" or "dlg,da9063l"
-- reg : Specifies the I2C slave address (this defaults to 0x58 but it can be
-  modified to match the chip's OTP settings).
-- interrupts : IRQ line information.
-- interrupt-controller
-
-Sub-nodes:
-
-- regulators : This node defines the settings for the LDOs and BUCKs.
-  The DA9063(L) regulators are bound using their names listed below:
-
-    bcore1    : BUCK CORE1
-    bcore2    : BUCK CORE2
-    bpro      : BUCK PRO
-    bmem      : BUCK MEM
-    bio       : BUCK IO
-    bperi     : BUCK PERI
-    ldo1      : LDO_1	(DA9063 only)
-    ldo2      : LDO_2	(DA9063 only)
-    ldo3      : LDO_3
-    ldo4      : LDO_4	(DA9063 only)
-    ldo5      : LDO_5	(DA9063 only)
-    ldo6      : LDO_6	(DA9063 only)
-    ldo7      : LDO_7
-    ldo8      : LDO_8
-    ldo9      : LDO_9
-    ldo10     : LDO_10	(DA9063 only)
-    ldo11     : LDO_11
-
-  The component follows the standard regulator framework and the bindings
-  details of individual regulator device can be found in:
-  Documentation/devicetree/bindings/regulator/regulator.txt
-
-- rtc : This node defines settings for the Real-Time Clock associated with
-  the DA9063 only. The RTC is not present in DA9063L. There are currently
-  no entries in this binding, however compatible = "dlg,da9063-rtc" should
-  be added if a node is created.
-
-- onkey : This node defines the OnKey settings for controlling the key
-  functionality of the device. The node should contain the compatible property
-  with the value "dlg,da9063-onkey".
-
-  Optional onkey properties:
-
-  - dlg,disable-key-power : Disable power-down using a long key-press. If this
-    entry exists the OnKey driver will remove support for the KEY_POWER key
-    press. If this entry does not exist then by default the key-press
-    triggered power down is enabled and the OnKey will support both KEY_POWER
-    and KEY_SLEEP.
-
-- watchdog : This node defines settings for the Watchdog timer associated
-  with the DA9063 and DA9063L. There are currently no entries in this
-  binding, however compatible = "dlg,da9063-watchdog" should be added
-  if a node is created.
-
-
-Example:
-
-	pmic0: da9063@58 {
-		compatible = "dlg,da9063"
-		reg = <0x58>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-
-		rtc {
-			compatible = "dlg,da9063-rtc";
-		};
-
-		wdt {
-			compatible = "dlg,da9063-watchdog";
-		};
-
-		onkey {
-			compatible = "dlg,da9063-onkey";
-			dlg,disable-key-power;
-		};
-
-		regulators {
-			DA9063_BCORE1: bcore1 {
-				regulator-name = "BCORE1";
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp = <500000>;
-				regulator-max-microamp = <2000000>;
-				regulator-boot-on;
-			};
-			DA9063_LDO11: ldo11 {
-				regulator-name = "LDO_11";
-				regulator-min-microvolt = <900000>;
-				regulator-max-microvolt = <3600000>;
-				regulator-boot-on;
-			};
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/mfd/da9063.yaml b/Documentation/devicetree/bindings/mfd/da9063.yaml
new file mode 100644
index 000000000000..62a8df68bf3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/da9063.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/da9063.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Support Opensource <support.opensource@diasemi.com>
+
+description: |
+  DA9063 consists of a large and varied group of sub-devices (I2C Only):
+
+  Device                   Supply Names    Description
+  ------                   ------------    -----------
+  da9063-regulator        :               : LDOs & BUCKs
+  da9063-onkey            :               : On Key
+  da9063-rtc              :               : Real-Time Clock (DA9063 only)
+  da9063-watchdog         :               : Watchdog
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - dlg,da9063
+              - dlg,da9063l
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  regulators:
+    $ref: ../regulator/da9063-regulator.yaml
+
+  onkey:
+    $ref: ../input/da9063-onkey.yaml
+
+  rtc:
+    $ref: ../rtc/da9063-rtc.yaml
+
+  watchdog:
+    $ref: ../watchdog/da9063-watchdog.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/irq.h>
+
+        i2c1 {
+                #size-cells = <0>;
+                #address-cells = <1>;
+
+                pmic0: da9063@58 {
+                        compatible = "dlg,da9063";
+                        reg = <0x58>;
+                        interrupt-parent = <&gpio6>;
+                        interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+                        interrupt-controller;
+
+                        rtc {
+                                compatible = "dlg,da9063-rtc";
+                        };
+
+                        wdt {
+                                compatible = "dlg,da9063-watchdog";
+                        };
+
+                        onkey {
+                                compatible = "dlg,da9063-onkey";
+                                dlg,disable-key-power;
+                        };
+
+                        regulators {
+                                DA9063_BCORE1: bcore1 {
+                                        regulator-name = "BCORE1";
+                                        regulator-min-microvolt = <300000>;
+                                        regulator-max-microvolt = <1570000>;
+                                        regulator-min-microamp = <500000>;
+                                        regulator-max-microamp = <2000000>;
+                                        regulator-boot-on;
+                                };
+                                DA9063_LDO11: ldo11 {
+                                        regulator-name = "LDO_11";
+                                        regulator-min-microvolt = <900000>;
+                                        regulator-max-microvolt = <3600000>;
+                                        regulator-boot-on;
+                                };
+                        };
+                };
+        };
diff --git a/Documentation/devicetree/bindings/regulator/da9063-regulator.yaml b/Documentation/devicetree/bindings/regulator/da9063-regulator.yaml
new file mode 100644
index 000000000000..0180b3684c0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/da9063-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/da9063-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator driver for Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Support Opensource <support.opensource@diasemi.com>
+
+description: |
+  This module is part of the DA9063 MFD device. For more details, see
+  Documentation/devicetree/bindings/mfd/da9063.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  This node defines the settings for the LDOs and BUCKs.
+  The DA9063(L) regulators are bound using their names listed below:
+
+  bcore1    : BUCK CORE1
+  bcore2    : BUCK CORE2
+  bpro      : BUCK PRO
+  bmem      : BUCK MEM
+  bio       : BUCK IO
+  bperi     : BUCK PERI
+  ldo1      : LDO_1	(DA9063 only)
+  ldo2      : LDO_2	(DA9063 only)
+  ldo3      : LDO_3
+  ldo4      : LDO_4	(DA9063 only)
+  ldo5      : LDO_5	(DA9063 only)
+  ldo6      : LDO_6	(DA9063 only)
+  ldo7      : LDO_7
+  ldo8      : LDO_8
+  ldo9      : LDO_9
+  ldo10     : LDO_10	(DA9063 only)
+  ldo11     : LDO_11
+
+  The component follows the standard regulator framework and the bindings
+  details of individual regulator device can be found in:
+  Documentation/devicetree/bindings/regulator/regulator.txt
+
+properties:
+  compatible:
+    const: dlg,da9063-regulator
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/rtc/da9063-rtc.yaml b/Documentation/devicetree/bindings/rtc/da9063-rtc.yaml
new file mode 100644
index 000000000000..3db1a9e5b572
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/da9063-rtc.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/da9063-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTC driver for Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Support Opensource <support.opensource@diasemi.com>
+
+description:
+  This module is part of the DA9063 MFD device. For more details, see
+  Documentation/devicetree/bindings/mfd/da9063.yaml.
+
+  The RTC controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  This node defines settings for the Real-Time Clock associated with
+  the DA9063 only. The RTC is not present in DA9063L. There are currently
+  no entries in this binding, however compatible = "dlg,da9063-rtc" should
+  be added if a node is created.
+
+properties:
+  compatible:
+    const: dlg,da9063-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/watchdog/da9063-watchdog.yaml b/Documentation/devicetree/bindings/watchdog/da9063-watchdog.yaml
new file mode 100644
index 000000000000..d3286f4c04d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/da9063-watchdog.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/da9063-watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Watchdog driver for Dialog DA9063/DA9063L Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Support Opensource <support.opensource@diasemi.com>
+
+description: |
+  This module is part of the DA9063 MFD device. For more details, see
+  Documentation/devicetree/bindings/mfd/da9063.yaml.
+
+  The watchdog controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+  This node defines settings for the Watchdog timer associated
+  with the DA9063 and DA9063L. There are currently no entries in this
+  binding, however compatible = "dlg,da9063-watchdog" should be added
+  if a node is created.
+
+properties:
+  compatible:
+    const: dlg,da9063-watchdog
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.32.0

