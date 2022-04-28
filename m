Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C75128C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiD1Bav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiD1Bao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:30:44 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7FF6E4DB;
        Wed, 27 Apr 2022 18:27:30 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 4F548586;
        Wed, 27 Apr 2022 18:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651109250;
        bh=JaNZyZ33VkrGjyfJq+sNEy33LoIDr90dC4eiqTLC1iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKJCjrtXYb26ndEp79AovS4PVlSuvQKw+uBFt0Ci97JN/S8toeGHAWj+C99Wwlc9N
         oMwfCPL8OLL6ukpGHsAV2Dj/8F+Shs5ta8zW6xCncWqWH7rMwaUw2d0Sr4D7q/Tnli
         pTJ9ghhgYnZz89YmU8np7C0nYTYlRydPZ+JjAK8E=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: hwmon: Add nuvoton,nct6775
Date:   Wed, 27 Apr 2022 18:27:06 -0700
Message-Id: <20220428012707.24921-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220428012707.24921-1-zev@bewilderbeest.net>
References: <20220428012707.24921-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These Super I/O chips have an i2c interface that some systems expose
to a BMC; the BMC's device tree can now describe that via this
binding.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../bindings/hwmon/nuvoton,nct6775.yaml       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
new file mode 100644
index 000000000000..358b262431fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct6775.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT6775 and compatible Super I/O chips
+
+maintainers:
+  - Zev Weiss <zev@bewilderbeest.net>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct6106
+      - nuvoton,nct6116
+      - nuvoton,nct6775
+      - nuvoton,nct6776
+      - nuvoton,nct6779
+      - nuvoton,nct6791
+      - nuvoton,nct6792
+      - nuvoton,nct6793
+      - nuvoton,nct6795
+      - nuvoton,nct6796
+      - nuvoton,nct6797
+      - nuvoton,nct6798
+
+  reg:
+    maxItems: 1
+
+  nuvoton,tsi-channel-mask:
+    description:
+      Bitmask indicating which TSI temperature sensor channels are
+      active.  LSB is TSI0, bit 1 is TSI1, etc.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0xff
+    default: 0
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        superio@4d {
+            compatible = "nuvoton,nct6779";
+            reg = <0x4d>;
+            nuvoton,tsi-channel-mask = <0x03>;
+        };
+    };
-- 
2.36.0

