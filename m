Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA7481F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbhL3SG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbhL3SGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:06:19 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F7C061401
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:06:19 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:a9e6:6f2a:78f1:2f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 7933828A0E7;
        Thu, 30 Dec 2021 19:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640887576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGj3YaXaI0HU4mQ6kyQqrXDJPLCNvz7W06S9IzY/Nzo=;
        b=I2Ai4GZN8LoAL21Qf62aeFieQYJ62ATMnemURKbF/AwNSdG7q5WBe7wuUvhxHUE7FhCAmr
        OCLNF4zW6FVVbZwuqm8dQk5aV/W/P5NPYUv6RH1nOZ47EYmbura3ylUeJqGNIl2l5g9I3k
        KH5jzwD94w6aCB5bzW2mBzZnw8fH/CusVq5WYi887BjsoZie+VdXAs1IPpo3uniBi+a4wL
        vrusP1IpGco30L0WOglCAnCE1yEITWrg36Gxo/lf/as7kkVDJClCihkqNUxEhxXxgs6rRP
        z8KfTN+JmKQkVZn1SOT/MpjHtmqSCZmt2JawqB43chQ7EWFO4GbVCHMx1rfStA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 1/3] dt-bindings: power: reset: Convert gpio-restart binding to schema
Date:   Thu, 30 Dec 2021 19:06:01 +0100
Message-Id: <c47705dbf6e9e287332f3ccb91578e81dbb81625.1640887456.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640887456.git.sander@svanheule.net>
References: <cover.1640887456.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the gpio-restart binding from plain text format to a schema
binding, maintaining the original content and updating formatting where
required.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 .../bindings/power/reset/gpio-restart.txt     | 54 -----------
 .../bindings/power/reset/gpio-restart.yaml    | 92 +++++++++++++++++++
 2 files changed, 92 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.txt b/Documentation/devicetree/bindings/power/reset/gpio-restart.txt
deleted file mode 100644
index af3701bc15c4..000000000000
--- a/Documentation/devicetree/bindings/power/reset/gpio-restart.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-Drive a GPIO line that can be used to restart the system from a restart
-handler.
-
-This binding supports level and edge triggered reset.  At driver load
-time, the driver will request the given gpio line and install a restart
-handler. If the optional properties 'open-source' is not found, the GPIO line
-will be driven in the inactive state.  Otherwise its not driven until
-the restart is initiated.
-
-When the system is restarted, the restart handler will be invoked in
-priority order.  The gpio is configured as an output, and driven active,
-triggering a level triggered reset condition. This will also cause an
-inactive->active edge condition, triggering positive edge triggered
-reset. After a delay specified by active-delay, the GPIO is set to
-inactive, thus causing an active->inactive edge, triggering negative edge
-triggered reset. After a delay specified by inactive-delay, the GPIO
-is driven active again.  After a delay specified by wait-delay, the
-restart handler completes allowing other restart handlers to be attempted.
-
-Required properties:
-- compatible : should be "gpio-restart".
-- gpios : The GPIO to set high/low, see "gpios property" in
-  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
-  low to reset the board set it to "Active Low", otherwise set
-  gpio to "Active High".
-
-Optional properties:
-- open-source : Treat the GPIO as being open source and defer driving
-  it to when the restart is initiated.  If this optional property is not
-  specified, the GPIO is initialized as an output in its inactive state.
-- priority : A priority ranging from 0 to 255 (default 128) according to
-  the following guidelines:
-	0:	Restart handler of last resort, with limited restart
-		capabilities
-	128:	Default restart handler; use if no other restart handler is
-		expected to be available, and/or if restart functionality is
-		sufficient to restart the entire system
-	255:	Highest priority restart handler, will preempt all other
-		restart handlers
-- active-delay: Delay (default 100) to wait after driving gpio active [ms]
-- inactive-delay: Delay (default 100) to wait after driving gpio inactive [ms]
-- wait-delay: Delay (default 3000) to wait after completing restart
-  sequence [ms]
-
-Examples:
-
-gpio-restart {
-	compatible = "gpio-restart";
-	gpios = <&gpio 4 0>;
-	priority = <128>;
-	active-delay = <100>;
-	inactive-delay = <100>;
-	wait-delay = <3000>;
-};
diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
new file mode 100644
index 000000000000..6a1f4aeebf49
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/gpio-restart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO-driven system restart
+
+maintainers:
+  - TODO
+
+description:
+  Drive a GPIO line that can be used to restart the system from a restart
+  handler.
+
+  This binding supports level and edge triggered reset. At driver load time,
+  the driver will request the given gpio line and install a restart handler. If
+  the optional properties 'open-source' is not found, the GPIO line will be
+  driven in the inactive state. Otherwise its not driven until the restart is
+  initiated.
+
+  When the system is restarted, the restart handler will be invoked in priority
+  order. The gpio is configured as an output, and driven active, triggering a
+  level triggered reset condition. This will also cause an inactive->active
+  edge condition, triggering positive edge triggered reset. After a delay
+  specified by active-delay, the GPIO is set to inactive, thus causing an
+  active->inactive edge, triggering negative edge triggered reset. After a
+  delay specified by inactive-delay, the GPIO is driven active again. After a
+  delay specified by wait-delay, the restart handler completes allowing other
+  restart handlers to be attempted.
+
+properties:
+  compatible:
+    const: gpio-restart
+
+  gpios:
+    maxItems: 1
+    description:
+      The GPIO to set high/low, see "gpios property" in
+      Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be low
+      to reset the board set it to "Active Low", otherwise set gpio to "Active
+      High".
+
+  open-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Treat the GPIO as being open source and defer driving it to when the
+      restart is initiated. If this optional property is not specified, the
+      GPIO is initialized as an output in its inactive state.
+
+  priority:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      A priority ranging from 0 to 255 (default 128) according to the following
+      guidelines:
+      0:    Restart handler of last resort, with limited restart
+            capabilities
+      128:  Default restart handler; use if no other restart handler is
+            expected to be available, and/or if restart functionality is
+            sufficient to restart the entire system
+      255:  Highest priority restart handler, will preempt all other
+            restart handlers
+
+  active-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Delay (default 100) to wait after driving gpio active [ms]
+
+  inactive-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Delay (default 100) to wait after driving gpio inactive [ms]
+
+  wait-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay (default 3000) to wait after completing restart sequence [ms]
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio-restart {
+      compatible = "gpio-restart";
+      gpios = <&gpio 4 0>;
+      priority = <128>;
+      active-delay = <100>;
+      inactive-delay = <100>;
+      wait-delay = <3000>;
+    };
-- 
2.33.1

