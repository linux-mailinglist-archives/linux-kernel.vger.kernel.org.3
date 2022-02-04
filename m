Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8F4A9C45
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376271AbiBDPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:52:48 -0500
Received: from smtp2.axis.com ([195.60.68.18]:54919 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230391AbiBDPwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643989965;
  x=1675525965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CoLT4kOyJTOYiMhPnHVf6C6Qn7q68tPCzzuEiZsphtM=;
  b=XNhhjurkO4gAmniBOWKsVbyXJOY8RJCi1RTMKPO21tFiLiHj+xB3cnLO
   IuLvmqrmCsT062Dy4EyNRtJPHr8jmcknrM0GTgPpsemJ4ZXSXr+iNHbjg
   NKM351WndNDn9bsG2x82yadifWAJfTQMs+g4O2kYLOjv8FfnYao8FltIn
   fnc2EZA6gWaD1MbLt6Xlb53X+PPVRHtre1W7aZN/R3axwY4jOenegWSlu
   vZ6hdV837Yrtr9UcLzg90atiLEg3isczcalFJfAxzE/8J8+Q+/ASnK1U8
   gJQN2dWwZvFRFx0TtwtB/9TleVwnWkUKv5UQin8UiH9ANUZWIeS7s0Sr4
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] regulator: Add bindings for TPS62864x
Date:   Fri, 4 Feb 2022 16:52:40 +0100
Message-ID: <20220204155241.576342-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204155241.576342-1-vincent.whitchurch@axis.com>
References: <20220204155241.576342-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the TPS62864/TPS6286/TPS62868/TPS62869 voltage
regulators.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../bindings/regulator/ti,tps62864.yaml       | 62 +++++++++++++++++++
 include/dt-bindings/regulator/ti,tps62864.h   |  9 +++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
 create mode 100644 include/dt-bindings/regulator/ti,tps62864.h

diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
new file mode 100644
index 000000000000..e3d739a37ab0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/ti,tps62864.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/ti,tps62864.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TPS62864/TPS6286/TPS62868/TPS62869 voltage regulator
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,tps62864
+      - ti,tps62866
+      - ti,tps62868
+      - ti,tps62869
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "SW":
+        type: object
+        $ref: regulator.yaml#
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/regulator/ti,tps62864.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      regulator@48 {
+        compatible = "ti,tps62864";
+        reg = <0x48>;
+
+        regulators {
+          SW {
+            regulator-name = "+0.85V";
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <890000>;
+            regulator-initial-mode = <TPS62864_MODE_FPWM>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/include/dt-bindings/regulator/ti,tps62864.h b/include/dt-bindings/regulator/ti,tps62864.h
new file mode 100644
index 000000000000..8db31f23d956
--- /dev/null
+++ b/include/dt-bindings/regulator/ti,tps62864.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_REGULATOR_TI_TPS62864_H
+#define _DT_BINDINGS_REGULATOR_TI_TPS62864_H
+
+#define TPS62864_MODE_NORMAL			0
+#define TPS62864_MODE_FPWM			1
+
+#endif
-- 
2.34.1

