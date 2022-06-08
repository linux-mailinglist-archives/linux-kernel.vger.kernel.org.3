Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460F3543E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiFHVMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiFHVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:25 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D793E2E90;
        Wed,  8 Jun 2022 14:12:23 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id s26so10378699ioa.3;
        Wed, 08 Jun 2022 14:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9sfEqVoExp6pZINUa/135mlrQ0MuzQ5O72MBn8Pd+A=;
        b=fHqxg5BzxzkZyFlb3t8zUEh/YQQ+iCywTpE66pUNJJaYrWabQp6ba9h8A2/zo8BQpl
         lir5eOilaw5jDMhyVPcUwNiZaLgfRWwOJjSY0Up48a6KBDsElI4toIeUwbgU1XFKZdmv
         0Q002DVMou0OJtZhD8AyPYrhNGlW/oTjF/njfcBmas3WWjsj7Cjo1Aeh59gBC/BN2kMf
         FTve3Da8ub+guvmBplKPoHxl26iEB5+UqybkcoYrN2cEdv1I2ra2uDWKIIo5tglDeAyo
         T/IYTYo/+GVUHPKwJ81U1E/pU/5W+vHI0a5vICxPSs5hXkVW/5lZ5M0hK5p/nEQsZ1EK
         Xyog==
X-Gm-Message-State: AOAM530xOXIO0zupBMpzyRXlPQ/9aQzKpuKJBJqSgj9zxLFW1+VCLSjj
        lwjmw/xLtLjkDPeiNothvQ==
X-Google-Smtp-Source: ABdhPJwhK5OVFYFeBDh7VlomBBUzhO/WesMM0WGoy0nSyG3Wa5KcusS51b2RMEPThmKcdBXdtp7c4A==
X-Received: by 2002:a02:aa92:0:b0:331:c856:fe69 with SMTP id u18-20020a02aa92000000b00331c856fe69mr6526812jai.187.1654722742525;
        Wed, 08 Jun 2022 14:12:22 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id v11-20020a02cbab000000b00331bd537addsm3295264jap.102.2022.06.08.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:12:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: input: Convert adc-keys to DT schema
Date:   Wed,  8 Jun 2022 15:12:07 -0600
Message-Id: <20220608211207.2058487-6-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220608211207.2058487-1-robh@kernel.org>
References: <20220608211207.2058487-1-robh@kernel.org>
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

The old binding has 'label' as required, but it should never be
required given it's just a human readable description.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Drop Heinrich as a maintainer
 - Use common linux,code definition
 - Drop label as required
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
index 000000000000..7aa078dead37
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
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+allOf:
+  - $ref: input.yaml#
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
+  poll-interval: true
+  autorepeat: true
+
+patternProperties:
+  '^button-':
+    type: object
+    $ref: input.yaml#
+    additionalProperties: false
+    description:
+      Each button (key) is represented as a sub-node.
+
+    properties:
+      label: true
+
+      linux,code: true
+
+      press-threshold-microvolt:
+        description:
+          Voltage above or equal to which this key is considered pressed. No
+          two values of press-threshold-microvolt may be the same. All values
+          of press-threshold-microvolt must be less than
+          keyup-threshold-microvolt.
+
+    required:
+      - linux,code
+      - press-threshold-microvolt
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - keyup-threshold-microvolt
+
+additionalProperties: false
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

