Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7A4FF5E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiDMLms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiDMLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:42:44 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80F2DCD;
        Wed, 13 Apr 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649850024;
  x=1681386024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FWnlFVwBXwjdCQpxgKO0flfwGUoGO5yQHXmc9QYxVE=;
  b=jYf7uxTK7d33yZb5MDXQ4NvfY2aLFMSKEeBhhb5hWf7kKtU/V5clbIiI
   28w57Y4bVFkBQFY8tu6dxrvLFZEuagGmOvgBya3RJhXmspIyp9wLbrtfd
   nDRYXE135ZahH2IvH8VkV0qMovgfaAYTkRHU7XlG0c6sH/s5Ae5Kl1ZJt
   vqz54aS7WhjFjWGlKptbonabbmbgzeDoyM3OHgMFYeOVTLO7Nc8Jv4yxe
   sKo2jNEPCS5x3zkVkE6TKN4EEw/sw3SyjIqgE+yhoG9sNLKtWC18R1bCG
   6kq/f7nqLKYQg6CacEJr2z8nHiZfKamVXJ9nuz2xieGFEregYQsPoLtW0
   w==;
From:   Camel Guo <camel.guo@axis.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC:     Camel Guo <camel.guo@axis.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Date:   Wed, 13 Apr 2022 13:40:12 +0200
Message-ID: <20220413114014.2204623-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413114014.2204623-1-camel.guo@axis.com>
References: <20220413114014.2204623-1-camel.guo@axis.com>
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

Document the TMP401, TMP411 and TMP43x device devicetree bindings

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Camel Guo <camel.guo@axis.com>
---

Notes:
    v3:
    - Remove unneeded address-cells and size-cells;
    - Change range of ti,n-factor to [-128, 127];
    - Remove unneeded 'items' of ti,beta-compensation;
    - Got Reviewed-by from Krzysztof.
    
    v2:
    - Fix format and describe hardware properties instead of programming
      models

 .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 105 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
new file mode 100644
index 000000000000..fe0ac08faa1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
@@ -0,0 +1,105 @@
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
+
+  reg:
+    maxItems: 1
+
+  ti,extended-range-enable:
+    description:
+      When set, this sensor measures over extended temperature range.
+    type: boolean
+
+  ti,n-factor:
+    description:
+      value to be used for converting remote channel measurements to
+      temperature.
+    $ref: /schemas/types.yaml#/definitions/int32
+    items:
+      minimum: -128
+      maximum: 127
+
+  ti,beta-compensation:
+    description:
+      value to select beta correction range.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
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

