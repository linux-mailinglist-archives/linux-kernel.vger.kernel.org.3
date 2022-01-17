Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BA49062B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiAQKlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbiAQKlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:41:05 -0500
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:1::465:209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABAC061574;
        Mon, 17 Jan 2022 02:41:05 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4JcpNH3yHXzQkLl;
        Mon, 17 Jan 2022 11:41:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642416061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZJi/osAAu0OVjnYoaQ3BbmTK05bonU6IA6ijl0CzXg=;
        b=GR07V2hOvhu+jfZE9JiXggKn4mXPeTQPJk61kZYoJqBJX9Luepjb+N35txqwrqahgMKZVk
        vRkivzjSrGiA2UIy9QtAs28DvoYC6q28mvsWhXsrlqfYrwCz4DZ4N4hsl9inYpbeRS3RH6
        ybpZyw9Chr/uv+FNyDVmbT0IBQY79nyDuyVbvdcsLV0qVXaIQ2PjeYW6S/+SOgE6SNXuOe
        /wPTsVeg7VZp/uW7i2w4IyARPPpfCvXMk7zjAQNJ6/F9LyMcXNZOdZ0BINb6DhTlBRz+5x
        BOnkHuOdnJHfqblgh/95NH2mYq1Kj7sxvmJKdUKwLTZpgPdiPngH/uVWSocLEg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Roland Stigge <stigge@antcom.de>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: hwmon: Add binding for max6639
Date:   Mon, 17 Jan 2022 11:40:25 +0100
Message-Id: <0ed54e36359306ae22215a38fef4630332cec16d.1642413668.git.sylv@sylv.io>
In-Reply-To: <cover.1642413668.git.sylv@sylv.io>
References: <cover.1642413668.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Devicetree binding documentation for Maxim MAX6639 temperature
monitor with PWM fan-speed controller.

The devicetree documentation for the SD3078 device tree.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 .../bindings/hwmon/maxim,max6639.yaml         | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..7093cbeba44b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max6639
+
+maintainers:
+  - Roland Stigge <stigge@antcom.de>
+
+description: |
+  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
+  fan-speed controller.  It monitors its own temperature and one external
+  diode-connected transistor or the temperatures of two external diode-connected
+  transistors, typically available in CPUs, FPGAs, or GPUs.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6639
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - "channel@0"
+  - "channel@1"
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-1]$":
+    type: object
+    description: |
+      Represents the two fans and their specific configuration.
+
+    properties:
+      reg:
+        description: |
+          The fan number.
+        items:
+          minimum: 0
+          maximum: 1
+
+      pwm-polarity:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+        description:
+          PWM output is low at 100% duty cycle when this bit is set to zero. PWM
+          output is high at 100% duty cycle when this bit is set to 1.
+
+      pulses-per-revolution:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2, 3, 4]
+        description:
+          Value specifying the number of pulses per revolution of the controlled
+          FAN.
+
+      rpm-range:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [2000, 4000, 8000, 16000]
+        description:
+          Scales the tachometer counter by setting the maximum (full-scale) value
+          of the RPM range.
+
+    required:
+      - reg
+      - pwm-polarity
+      - pulses-per-revolution
+      - rpm-range
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max6639@10 {
+        compatible = "maxim,max6639";
+        reg = <0x10>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0x0>;
+          pwm-polarity = <1>;
+          pulses-per-revolution = <2>;
+          rpm-range = <4000>;
+        };
+
+        channel@1 {
+          reg = <0x1>;
+          pwm-polarity = <1>;
+          pulses-per-revolution = <2>;
+          rpm-range = <4000>;
+        };
+      };
+    };
+...
-- 
2.33.1

