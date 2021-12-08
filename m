Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C046DB2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbhLHSiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:38:12 -0500
Received: from ixit.cz ([94.230.151.217]:33328 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238954AbhLHSiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:38:11 -0500
Received: from localhost.localdomain (unknown [213.151.89.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3990221F5E;
        Wed,  8 Dec 2021 19:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638988476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cq8s/Jy9V1OTXNRQdifNniAnhlZAOYvwgu+gFPAuA1Q=;
        b=WTICIv2uzuwyuXeAUDBj5vXPOFIYcGiiSkGkv9VPDKkhJEOcqhxIl4tgVMDLa2x1Y/Bd01
        EUNQiLJUqRnfFFv9RUm5orlk5a2SmpOtHol6PoJUA0nvyHqjmGcrF6TRZ4An3G9jyNti7c
        +sB2qGuh11KUQd4Ax9bm/msi9rld1bU=
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: input: pwm-vibrator: Convert txt bindings to yaml
Date:   Wed,  8 Dec 2021 19:34:34 +0100
Message-Id: <20211208183434.98087-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts txt binding to new YAML format and simplify example.

Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - added Sebastian review
 - replace anyOf with minItems

 .../bindings/input/pwm-vibrator.txt           | 66 -------------------
 .../bindings/input/pwm-vibrator.yaml          | 57 ++++++++++++++++
 2 files changed, 57 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.yaml

diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
deleted file mode 100644
index 88c775a3fe21..000000000000
--- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-* PWM vibrator device tree bindings
-
-Registers a PWM device as vibrator. It is expected, that the vibrator's
-strength increases based on the duty cycle of the enable PWM channel
-(100% duty cycle meaning strongest vibration, 0% meaning no vibration).
-
-The binding supports an optional direction PWM channel, that can be
-driven at fixed duty cycle. If available this is can be used to increase
-the vibration effect of some devices.
-
-Required properties:
-- compatible: should contain "pwm-vibrator"
-- pwm-names: Should contain "enable" and optionally "direction"
-- pwms: Should contain a PWM handle for each entry in pwm-names
-
-Optional properties:
-- vcc-supply: Phandle for the regulator supplying power
-- direction-duty-cycle-ns: Duty cycle of the direction PWM channel in
-                           nanoseconds, defaults to 50% of the channel's
-			   period.
-
-Example from Motorola Droid 4:
-
-&omap4_pmx_core {
-	vibrator_direction_pin: pinmux_vibrator_direction_pin {
-		pinctrl-single,pins = <
-		OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1) /* dmtimer8_pwm_evt (gpio_27) */
-		>;
-	};
-
-	vibrator_enable_pin: pinmux_vibrator_enable_pin {
-		pinctrl-single,pins = <
-		OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1) /* dmtimer9_pwm_evt (gpio_28) */
-		>;
-	};
-};
-
-/ {
-	pwm8: dmtimer-pwm {
-		pinctrl-names = "default";
-		pinctrl-0 = <&vibrator_direction_pin>;
-
-		compatible = "ti,omap-dmtimer-pwm";
-		#pwm-cells = <3>;
-		ti,timers = <&timer8>;
-		ti,clock-source = <0x01>;
-	};
-
-	pwm9: dmtimer-pwm {
-		pinctrl-names = "default";
-		pinctrl-0 = <&vibrator_enable_pin>;
-
-		compatible = "ti,omap-dmtimer-pwm";
-		#pwm-cells = <3>;
-		ti,timers = <&timer9>;
-		ti,clock-source = <0x01>;
-	};
-
-	vibrator {
-		compatible = "pwm-vibrator";
-		pwms = <&pwm9 0 1000000000 0>,
-                       <&pwm8 0 1000000000 0>;
-		pwm-names = "enable", "direction";
-		direction-duty-cycle-ns = <1000000000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
new file mode 100644
index 000000000000..a70a636ee112
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/input/pwm-vibrator.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: PWM vibrator
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: >
+  Registers a PWM device as vibrator. It is expected, that the vibrator's
+  strength increases based on the duty cycle of the enable PWM channel
+  (100% duty cycle meaning strongest vibration, 0% meaning no vibration).
+
+  The binding supports an optional direction PWM channel, that can be
+  driven at fixed duty cycle. If available this is can be used to increase
+  the vibration effect of some devices.
+
+properties:
+  compatible:
+    const: pwm-vibrator
+
+  pwm-names:
+    items:
+      - const: enable
+      - const: direction
+    minItems: 1
+
+  pwms:
+    minItems: 1
+    maxItems: 2
+
+  vcc-supply: true
+
+  direction-duty-cycle-ns:
+    description: >
+      Duty cycle of the direction PWM channel in nanoseconds,
+      defaults to 50% of the channel's period.
+
+required:
+  - compatible
+  - pwm-names
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    vibrator {
+        compatible = "pwm-vibrator";
+        pwms = <&pwm9 0 1000000000 0>,
+               <&pwm8 0 1000000000 0>;
+        pwm-names = "enable", "direction";
+        direction-duty-cycle-ns = <1000000000>;
+    };
-- 
2.33.0

