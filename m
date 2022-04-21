Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300050A188
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388007AbiDUOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387094AbiDUOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:06:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D63B54C;
        Thu, 21 Apr 2022 07:03:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id CC8D81F45A49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650549776;
        bh=KobM/YFW6qteihzgQdGfGwxjmqXEnE6MKH2uFqLZGwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9dM1kX+AH8Lm+1VoU/JwvMvyv/43aRbTsEa3rmcMoMbNLkHpsFR/GHzto4acWYOF
         c4uB4iqq4KaF+u/uN68AkwSUvs1lY8OpV/go3rfkNP87vuJsdJeVFbRJ7YSlApMc2M
         9u3Zv94nLhAr2HgLUJfzFnk3XfiJhOBc9xkItX5yYObE5LmKMki4q/CT9+1bymk0YP
         eY89JuYMIagA6do3njYZR3seXw7KO3LwsTw6stndZJw50iupK5GvGenZ2DHryYsmyw
         f7DLCm6oXp5gfxQk1D+66wTmZsEpnmvKGwHOqrGzzD2uV/oJu4VBRtxN6/l/5gFGHH
         X0r+o8EbaRNng==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 2/3] dt-bindings: Document ltrf216a light sensor bindings
Date:   Thu, 21 Apr 2022 19:31:32 +0530
Message-Id: <20220421140133.354498-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421140133.354498-1-shreeya.patel@collabora.com>
References: <20220421140133.354498-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for ltrf216a ambient light sensor.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - Take over the maintainership for the bindings
  - Add interrupt and power supply property in DT bindings


 .../bindings/iio/light/liteon,ltrf216a.yaml   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
new file mode 100644
index 000000000000..61008bcc6b88
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTRF216A Ambient Light Sensor
+
+maintainers:
+  - Shreeya Patel <shreeya.patel@collabora.com>
+
+description: |
+  Ambient light sensing with an i2c interface.
+
+properties:
+  compatible:
+    oneOf:
+      - const: liteon,ltrf216a
+      - const: ltr,ltrf216a
+        deprecated: true
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@53 {
+                compatible = "liteon,ltrf216a";
+                reg = <0x53>;
+                vdd-supply = <&vdd_regulator>;
+                interrupt-parent = <&gpio0>;
+                interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
-- 
2.30.2

