Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E953EDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiFFSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiFFSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:42:58 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA831A04B0;
        Mon,  6 Jun 2022 11:42:56 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id y12so13160322ior.7;
        Mon, 06 Jun 2022 11:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v3EH5Ud1ia9pHiXc/1x/9CrXiVNDXe9p4RQEE8BsW8Q=;
        b=Y/OlMJxtYbBr5dzdc0wqjMrus9HBqMaZ0SYltdJsaZMwA5S1jq5L8EDKEOUBtT/RPs
         oeXlbK5YhftlffQlcizY9BlqA3Z58rpPo0U19zJUeklBO2kg8yuX9dWA8MMl+vGNhxDK
         2FY8mdWMWvQzggP7pIghtGgpLfkTPAz1O/YNV+20LaGsksF5lvs1h02QkT+x9PBx3xYZ
         bKAcOnWJgJ1BJepe3en1ofqAelF5FKNSszKp8mlxRooljZPbrlJCxA6zJyUjkgt0oOM/
         kgVDVvlUV4Xg4bxFM9nHOsj1mTwzI8oP+2UXMRP2sy8rrZ97dsAsGOHMOc/9hgcLJo8o
         uD9Q==
X-Gm-Message-State: AOAM532+tMxeZIDLyK9ZRwMBNbY6n3FgNn6BDeO3dC5M9b28VVoyZxFr
        DtipEhVsiWx7Z+E9tgCDVw==
X-Google-Smtp-Source: ABdhPJykicPbd4l5VuYUBNpWEqEgIVCiwbp7IDshM5LUKwNUsZqLKJeDp22MIGU2/tVKIHbiM8QZBg==
X-Received: by 2002:a02:ba82:0:b0:331:5aaf:e4b0 with SMTP id g2-20020a02ba82000000b003315aafe4b0mr13777880jao.196.1654540975731;
        Mon, 06 Jun 2022 11:42:55 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id q2-20020a5d87c2000000b0065a47e16f53sm5908060ios.37.2022.06.06.11.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:42:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: Convert adc-keys to DT schema
Date:   Mon,  6 Jun 2022 13:42:42 -0500
Message-Id: <20220606184243.1057145-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the adc-keys binding to DT schema format.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/adc-keys.txt    |  67 ------------
 .../devicetree/bindings/input/adc-keys.yaml   | 103 ++++++++++++++++++
 2 files changed, 103 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.yaml

diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
deleted file mode 100644
index 6c8be6a9ace2..000000000000
--- a/Documentation/devicetree/bindings/input/adc-keys.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-ADC attached resistor ladder buttons
-------------------------------------
-
-Required properties:
- - compatible: "adc-keys"
- - io-channels: Phandle to an ADC channel
- - io-channel-names = "buttons";
- - keyup-threshold-microvolt: Voltage above or equal to which all the keys are
-			      considered up.
-
-Optional properties:
-	- poll-interval: Poll interval time in milliseconds
-	- autorepeat: Boolean, Enable auto repeat feature of Linux input
-	  subsystem.
-
-Each button (key) is represented as a sub-node of "adc-keys":
-
-Required subnode-properties:
-	- label: Descriptive name of the key.
-	- linux,code: Keycode to emit.
-	- press-threshold-microvolt: voltage above or equal to which this key is
-				     considered pressed.
-
-No two values of press-threshold-microvolt may be the same.
-All values of press-threshold-microvolt must be less than
-keyup-threshold-microvolt.
-
-Example:
-
-#include <dt-bindings/input/input.h>
-
-	adc-keys {
-		compatible = "adc-keys";
-		io-channels = <&lradc 0>;
-		io-channel-names = "buttons";
-		keyup-threshold-microvolt = <2000000>;
-
-		button-up {
-			label = "Volume Up";
-			linux,code = <KEY_VOLUMEUP>;
-			press-threshold-microvolt = <1500000>;
-		};
-
-		button-down {
-			label = "Volume Down";
-			linux,code = <KEY_VOLUMEDOWN>;
-			press-threshold-microvolt = <1000000>;
-		};
-
-		button-enter {
-			label = "Enter";
-			linux,code = <KEY_ENTER>;
-			press-threshold-microvolt = <500000>;
-		};
-	};
-
-+--------------------------------+------------------------+
-| 2.000.000 <= value             | no key pressed         |
-+--------------------------------+------------------------+
-| 1.500.000 <= value < 2.000.000 | KEY_VOLUMEUP pressed   |
-+--------------------------------+------------------------+
-| 1.000.000 <= value < 1.500.000 | KEY_VOLUMEDOWN pressed |
-+--------------------------------+------------------------+
-|   500.000 <= value < 1.000.000 | KEY_ENTER pressed      |
-+--------------------------------+------------------------+
-|              value <   500.000 | no key pressed         |
-+--------------------------------+------------------------+
diff --git a/Documentation/devicetree/bindings/input/adc-keys.yaml b/Documentation/devicetree/bindings/input/adc-keys.yaml
new file mode 100644
index 000000000000..a3a1af9550bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-keys.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/adc-keys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC attached resistor ladder buttons
+
+maintainers:
+  - Heinrich Schuchardt <xypron.glpk@gmx.de>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+allOf:
+  - $ref: /schemas/input/input.yaml#
+
+properties:
+  compatible:
+    const: adc-keys
+
+  io-channels:
+    maxItems: 1
+
+  io-channel-names:
+    const: buttons
+
+  keyup-threshold-microvolt:
+    description:
+      Voltage above or equal to which all the keys are considered up.
+
+patternProperties:
+  '^button-':
+    type: object
+    additionalProperties: false
+    description:
+      Each button (key) is represented as a sub-node.
+
+    properties:
+      label: true
+
+      linux,code:
+        description: Keycode to emit.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      press-threshold-microvolt:
+        description:
+          Voltage above or equal to which this key is considered pressed. No
+          two values of press-threshold-microvolt may be the same. All values
+          of press-threshold-microvolt must be less than
+          keyup-threshold-microvolt.
+
+    required:
+      - label
+      - linux,code
+      - press-threshold-microvolt
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - keyup-threshold-microvolt
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    // +--------------------------------+------------------------+
+    // | 2.000.000 <= value             | no key pressed         |
+    // +--------------------------------+------------------------+
+    // | 1.500.000 <= value < 2.000.000 | KEY_VOLUMEUP pressed   |
+    // +--------------------------------+------------------------+
+    // | 1.000.000 <= value < 1.500.000 | KEY_VOLUMEDOWN pressed |
+    // +--------------------------------+------------------------+
+    // |   500.000 <= value < 1.000.000 | KEY_ENTER pressed      |
+    // +--------------------------------+------------------------+
+    // |              value <   500.000 | no key pressed         |
+    // +--------------------------------+------------------------+
+
+    adc-keys {
+        compatible = "adc-keys";
+        io-channels = <&lradc 0>;
+        io-channel-names = "buttons";
+        keyup-threshold-microvolt = <2000000>;
+
+        button-up {
+            label = "Volume Up";
+            linux,code = <KEY_VOLUMEUP>;
+            press-threshold-microvolt = <1500000>;
+        };
+
+        button-down {
+            label = "Volume Down";
+            linux,code = <KEY_VOLUMEDOWN>;
+            press-threshold-microvolt = <1000000>;
+        };
+
+        button-enter {
+            label = "Enter";
+            linux,code = <KEY_ENTER>;
+            press-threshold-microvolt = <500000>;
+        };
+    };
+...
-- 
2.34.1

