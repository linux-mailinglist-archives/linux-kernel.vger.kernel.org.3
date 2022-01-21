Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1280496046
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380915AbiAUOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:02:13 -0500
Received: from mxout70.expurgate.net ([194.37.255.70]:48855 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380887AbiAUOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:02:05 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nAuUG-0001kS-VN; Fri, 21 Jan 2022 15:01:57 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1nAuUG-0008SD-6x; Fri, 21 Jan 2022 15:01:56 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id CB9C3240040;
        Fri, 21 Jan 2022 15:01:55 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 3BE75240049;
        Fri, 21 Jan 2022 15:01:55 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id D76B020065;
        Fri, 21 Jan 2022 15:01:54 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     pavel@ucw.cz, robh+dt@kernel.org, andy.shevchenko@gmail.com
Cc:     Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] dt: bindings: KTD20xx: Introduce the ktd20xx family of RGB drivers
Date:   Fri, 21 Jan 2022 15:01:50 +0100
Message-ID: <20220121140150.1729-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220121140150.1729-1-fe@dev.tdt.de>
References: <20220121140150.1729-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED,
        URIBL_DBL_BLOCKED_OPENDNS,URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1642773716-00005ED7-2D86A72C/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the bindings for the Kinetic KTD2061/58/59/60RGB LED device
driver. The KTD20xx can control RGB LEDs individually. Because of the
hardware limitations, only 7 colors and the color black (off) can be set.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.y=
aml

diff --git a/Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml b/D=
ocumentation/devicetree/bindings/leds/leds-ktd20xx.yaml
new file mode 100644
index 000000000000..c4e440cc6945
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-ktd20xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for KTD20xx RGB LED from Kinetic.
+
+maintainers:
+  - Florian Eckert <fe@dev.tdt.de>
+
+description: |
+  The KTD20XX is multi-channel, I2C LED driver. Into can control up to 1=
2
+  LEDs per device. The RGB value can be set for each LED. Due to hardwar=
e
+  limitations, the full RGB range cannot be used. Only 7 colors and the
+  color black can be set (black means off).
+  R G B
+  0 0 0 =3D Black (off)
+  0 0 1 =3D Blue
+  0 1 0 =3D Green
+  0 1 1 =3D Cyan
+  1 0 0 =3D Red
+  1 0 1 =3D Magenta
+  1 1 0 =3D Yellow
+  1 1 1 =3D White
+
+properties:
+  compatible:
+    enum:
+      - kinetic,ktd20xx
+
+  reg:
+    maxItems: 1
+    description:
+      I2C slave address
+      ktd2061/58/59/60 0x68 0x69 0x6A 0x6B
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  'kinetic,led-current':
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      This value is a current setting for all LEDs connected to this dev=
ice.
+      If this value is not set then the default value off 0x28 (5mA) is =
set.
+      This means all LEDs get 5mA. The max value is 24mA. We have the
+      following mapping in 125uA steps. We can set a maximum of 24mA.
+      0000 0000 (0x00) =3D 0uA
+      0000 0001 (0x01) =3D 125uA
+      .... ....
+      0010 1000 (0x28) =3D 5mA
+      .... ....
+      1100 0000 (0xC0) =3D 24mA
+      1100 0001 (0xC1) =3D 24mA
+      .... ....
+      1111 1111 (0xFF) =3D 24mA
+    minimum: 0
+    maximum: 255
+
+patternProperties:
+  '^multi-led@[0-9a-f]$':
+    type: object
+    allOf:
+      - $ref: leds-class-multicolor.yaml#
+    description:
+      This node represents one of the Multicolor LED. No subnodes need t=
o
+      be added for subchannels since this controller only supports 1bit
+      RGB values. We could display seven different colors and the color
+      black which means off.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 11
+        description:
+          This property identifies wired connection of the LED to this d=
evice.
+          0x00  LEDA1
+          0x01  LEDA2
+          0x02  LEDA3
+          0x03  LEDA4
+          0x04  LEDB1
+          0x05  LEDB2
+          0x06  LEDB3
+          0x07  LEDB4
+          0x08  LEDC1
+          0x09  LEDC2
+          0x0A  LEDC3
+          0x0B  LEDC4
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+   #include <dt-bindings/leds/common.h>
+
+   i2c {
+       #address-cells =3D <1>;
+       #size-cells =3D <0>;
+
+       led-controller@14 {
+           compatible =3D "kinetic,ktd20xx";
+           reg =3D <0x68>;
+           #address-cells =3D <1>;
+           #size-cells =3D <0>;
+           kinetic,led-current =3D <0x28>; // Current for all LEDs is 5m=
A
+
+           multi-led@0 {
+               reg =3D <0x0>;
+               color =3D <LED_COLOR_ID_MULTI>;
+               function =3D LED_FUNCTION_CHARGING;
+               linux,default-trigger =3D "default-on";
+          };
+
+          multi-led@2 {
+            reg =3D <0x2>;
+            color =3D <LED_COLOR_ID_MULTI>;
+            function =3D LED_FUNCTION_STANDBY;
+            linux,default-trigger =3D "default-on";
+         };
+       };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 04d68985d348..b56d8392119c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10743,6 +10743,7 @@ KTD20XX LED CONTROLLER DRIVER
 M:	Florian Eckert <fe@dev.tdt.de>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
 F:	drivers/leds/leds-ktd20xx.c
=20
 KTEST
--=20
2.20.1

