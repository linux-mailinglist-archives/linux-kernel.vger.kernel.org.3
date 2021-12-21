Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022F847C0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhLUNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:41:28 -0500
Received: from mxout70.expurgate.net ([194.37.255.70]:58197 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhLUNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:41:27 -0500
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mzfOO-000Aqf-JH; Tue, 21 Dec 2021 14:41:24 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mzfON-0001Ub-G7; Tue, 21 Dec 2021 14:41:23 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 2CCB2240041;
        Tue, 21 Dec 2021 14:41:23 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id AD630240040;
        Tue, 21 Dec 2021 14:41:22 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 675F620331;
        Tue, 21 Dec 2021 14:41:21 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     pavel@ucw.cz, robh+dt@kernel.org
Cc:     Eckert.Florian@googlemail.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v2 2/2] dt: bindings: KTD20xx: Introduce the ktd20xx family of RGB drivers
Date:   Tue, 21 Dec 2021 14:40:52 +0100
Message-ID: <20211221134052.22387-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211221134052.22387-1-fe@dev.tdt.de>
References: <20211221134052.22387-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1640094084-00000598-4BB49225/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the bindings for the Kinetic KTD2061/58/59/60RGB LED device
driver. The KTD20xx can control RGB LEDs individually. Because of the
hardware limitations, only 7 colors and the color black (off) can be set.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 .../bindings/leds/leds-ktd20xx.yaml           | 130 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.y=
aml

diff --git a/Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml b/D=
ocumentation/devicetree/bindings/leds/leds-ktd20xx.yaml
new file mode 100644
index 000000000000..1c39847a4c26
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
+      This means all LEDs get 5mA. The max value is 24mA. We have the fo=
llowing
+      mapping in 125uA steps. We can set a maximum of 24mA.
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
index 736d564f7e93..125bae48c2d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10607,6 +10607,7 @@ KTD20XX LED CONTROLLER DRIVER
 M:	Florian Eckert <fe@dev.tdt.de>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
 F:	drivers/leds/leds-ktd20xx.c
=20
 KTEST
--=20
2.20.1

