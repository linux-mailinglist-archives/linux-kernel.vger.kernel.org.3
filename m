Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EACB4FB8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiDKKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbiDKKFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:05:49 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7871B4160E;
        Mon, 11 Apr 2022 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649671416;
  x=1681207416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Aw9Ecq6L7fdadg/faZ3YXTQ0SGHw1j32xDTyNi0kHM=;
  b=XxL4bL5gQqGvgs3+kNk4872vI8TUrRicmfn5CKGocooS8TI6L4RqfjPB
   gZtWN12zeSSzYEGaNzM1Gd5xcqRGMpmOSvaj+mdvaL0WqKfQnYTDuFujz
   VVD6rRRx8h7ioA/gCZy4h3lkLUthPsBj3yowYC5YXkDvPapkuphwetIOs
   KJKp2Hso60apAafHXpcTKfoqjSz+jhIVilbvjAJ9l/Pb1rQuJNONefFOt
   Q9G6vkKBafUC1uhzbDaU7Qz7Z9JKBrNnEP673AavPhCkoH874zzYuI/EA
   NiN3hq9cDDnV0DgHZzUNl8jZbqU85XFzH9qDPau+Be+YJOgK0k5bIhjq8
   g==;
From:   Camel Guo <camel.guo@axis.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <kernel@axis.com>, Camel Guo <camel.guo@axis.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Camel Guo <camelg@axis.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Date:   Mon, 11 Apr 2022 12:03:28 +0200
Message-ID: <20220411100329.1783432-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411100329.1783432-1-camel.guo@axis.com>
References: <20220411100329.1783432-1-camel.guo@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Document the TMP401, TMP411 and TMP43x device devicetree bindings

Signed-off-by: Camel Guo <camelg@axis.com>
---
 .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 111 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
new file mode 100644
index 000000000000..28be5cbb009b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,tmp401.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TMP401, TPM411 and TMP43x temperature sensor
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+
+description: |
+  ±1°C Remote and Local temperature sensor
+
+  Datasheets:
+  https://www.ti.com/lit/ds/symlink/tmp401.pdf
+  https://www.ti.com/lit/ds/symlink/tmp411.pdf
+  https://www.ti.com/lit/ds/symlink/tmp431.pdf
+  https://www.ti.com/lit/ds/symlink/tmp435.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,tmp401
+      - ti,tmp411
+      - ti,tmp431
+      - ti,tmp432
+      - ti,tmp435
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  ti,extended-range-enable:
+    description: |
+      When set, this sensor measures over extended temperature range.
+    type: boolean
+
+  ti,n-factor:
+    description: |
+      The value (two's complement) to be programmed in the n-factor correction
+      register.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    items:
+      minimum: 0
+      maximum: 255
+
+  ti,beta-compensation:
+    description: |
+      The value to be programmed in the beta range register.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    items:
+      minimum: 0
+      maximum: 15
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tmp401
+    then:
+      properties:
+        ti,n-factor: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tmp401
+              - ti,tmp411
+    then:
+      properties:
+        ti,beta-compensation: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sensor@4c {
+        compatible = "ti,tmp401";
+        reg = <0x4c>;
+      };
+    };
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sensor@4c {
+        compatible = "ti,tmp431";
+        reg = <0x4c>;
+        ti,extended-range-enable;
+        ti,n-factor = <0x3b>;
+        ti,beta-compensation = <0x7>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..6b0d8f5cc68e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19838,6 +19838,7 @@ TMP401 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
 F:	Documentation/hwmon/tmp401.rst
 F:	drivers/hwmon/tmp401.c
 
-- 
2.30.2

