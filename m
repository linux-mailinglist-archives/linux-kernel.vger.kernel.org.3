Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1156C46340B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbhK3MW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:22:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55882 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhK3MWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:22:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AUCIshn126893;
        Tue, 30 Nov 2021 06:18:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638274734;
        bh=d1hVcbCHAV8MVdq3XebYM0To3kzExTrCri8MDLnSj0Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RWytly33M7k6TBhdw2RZhuhVv5LRqY8i2/qhhNOPkWurexuXAZXM3rM1VBfSvh7Pc
         e+ncHHvbe8X23kBn+GB0BW2MQadDsoGkNGTTMawlvaVwBx5NsrcrBtgMsCwoS+ncR8
         gtzRyYW3/K1b/CsTzJPlhm45Dvoc+CD5SVJA4+Fg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AUCIs2x101833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 06:18:54 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 06:18:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 06:18:53 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AUCIliQ058207;
        Tue, 30 Nov 2021 06:18:51 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 1/2] dt-bindings: mux: Document mux-states property
Date:   Tue, 30 Nov 2021 17:48:46 +0530
Message-ID: <20211130121847.11112-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130121847.11112-1-a-govindraju@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, it is required to provide the state to which the mux
controller has be set to, from the consumer device tree node. Document the
property mux-states that can be used for adding this support.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../devicetree/bindings/mux/gpio-mux.yaml     | 11 ++++++--
 .../devicetree/bindings/mux/mux-consumer.yaml | 14 ++++++++++
 .../bindings/mux/mux-controller.yaml          | 26 ++++++++++++++++++-
 3 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
index 0a7c8d64981a..ee4de9fbaf4d 100644
--- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
+++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
@@ -26,7 +26,10 @@ properties:
       List of gpios used to control the multiplexer, least significant bit first.
 
   '#mux-control-cells':
-    const: 0
+    enum: [ 0, 1 ]
+
+  '#mux-state-cells':
+    enum: [ 1, 2 ]
 
   idle-state:
     default: -1
@@ -34,7 +37,11 @@ properties:
 required:
   - compatible
   - mux-gpios
-  - "#mux-control-cells"
+anyOf:
+  - required:
+      - "#mux-control-cells"
+  - required:
+      - "#mux-state-cells"
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
index 7af93298ab5c..64f353714227 100644
--- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
+++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
@@ -25,6 +25,11 @@ description: |
   strings to label each of the mux controllers listed in the "mux-controls"
   property.
 
+  If it is required to provide the state that the mux controller needs to
+  be set to, the property "mux-states" must be used. An optional property
+  "mux-state-names" can be used to provide a list of strings, to label
+  each of the mux controllers listed in the "mux-states" property.
+
   mux-ctrl-specifier typically encodes the chip-relative mux controller number.
   If the mux controller chip only provides a single mux controller, the
   mux-ctrl-specifier can typically be left out.
@@ -35,12 +40,21 @@ properties:
   mux-controls:
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  mux-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
   mux-control-names:
     description:
       Devices that use more than a single mux controller can use the
       "mux-control-names" property to map the name of the requested mux
       controller to an index into the list given by the "mux-controls" property.
 
+  mux-state-names:
+    description:
+      Devices that use more than a single mux controller can use the
+      "mux-state-names" property to map the name of the requested mux
+      controller to an index into the list given by the "mux-states" property.
+
 additionalProperties: true
 
 ...
diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
index 736a84c3b6a5..b29dbf521f01 100644
--- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
+++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
@@ -25,7 +25,9 @@ description: |
   --------------------
 
   Mux controller nodes must specify the number of cells used for the
-  specifier using the '#mux-control-cells' property.
+  specifier using the '#mux-control-cells' or 'mux-state-cells'
+  property. Value of '#mux-state-cells' will always be one greater then
+  the value of '#mux-control-cells'.
 
   Optionally, mux controller nodes can also specify the state the mux should
   have when it is idle. The idle-state property is used for this. If the
@@ -67,6 +69,8 @@ select:
           pattern: '^mux-controller'
     - required:
         - '#mux-control-cells'
+    - required:
+        - '#mux-state-cells'
 
 properties:
   $nodename:
@@ -75,6 +79,9 @@ properties:
   '#mux-control-cells':
     enum: [ 0, 1 ]
 
+  '#mux-state-cells':
+    enum: [ 1, 2 ]
+
   idle-state:
     $ref: /schemas/types.yaml#/definitions/int32
     minimum: -2
@@ -179,4 +186,21 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    mux1: mux-controller {
+        compatible = "gpio-mux";
+        #mux-state-cells = <1>;
+        mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
+    };
+
+    transceiver4: can-phy4 {
+        compatible = "ti,tcan1042";
+        #phy-cells = <0>;
+        max-bitrate = <5000000>;
+        standby-gpios = <&exp_som 7 GPIO_ACTIVE_HIGH>;
+        mux-states = <&mux1 1>;
+    };
 ...
-- 
2.17.1

