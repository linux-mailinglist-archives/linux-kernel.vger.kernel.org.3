Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5E475563
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbhLOJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhLOJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:45:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925BC061574;
        Wed, 15 Dec 2021 01:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86A88B81EAD;
        Wed, 15 Dec 2021 09:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8B7C34617;
        Wed, 15 Dec 2021 09:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639561517;
        bh=A8h0YspTqP/eQH75i0tKRxbgVT7PVfC0QCj0g7fWeZA=;
        h=From:To:Cc:Subject:Date:From;
        b=ijESK3xltfGFKlzANenQqA6Rq/QC2OmiYnLa5O444htAA9U4LYkUACuwOWhUTZ5SY
         aTqQqDLf/6IhgOfsummCx72a+IaJg/O4G5bhnB3hnDCrBd5qRG7KEknwlIWUND74P0
         yfTRriK5aORXmlo/27aWZexnvG++wV1NO1OqY1p4RsO+NC+qZXnHGq7vw3uGCuCqGj
         MEde5/iEJm2hay1E5aNGsX+fa7kC5V0jRYRkwgwg0oavhMTPP42dQ8mZPVVt/7KblF
         qjj7NsvbvFbRiM9zDI2tF3fVTJSa5l/X+Z7kn0sSqbFMDc3bjhEO323PSi7xhzkUVk
         qy6Zej5Z/r/Pg==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     robh+dt@kernel.org, stefan.wahren@i2se.com, nsaenz@kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3] dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema
Date:   Wed, 15 Dec 2021 10:44:49 +0100
Message-Id: <20211215094448.280796-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

This converts the VCHIQ bindings to YAML format.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Co-developed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

---
Changes since v2:
 - Reinstate fallback compatible

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 17 ------
 .../bindings/soc/bcm/brcm,bcm2835-vchiq.yaml  | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
deleted file mode 100644
index f331316183f6..000000000000
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Broadcom VCHIQ firmware services
-
-Required properties:
-
-- compatible:	Should be "brcm,bcm2835-vchiq" on BCM2835, otherwise
-		"brcm,bcm2836-vchiq".
-- reg:		Physical base address and length of the doorbell register pair
-- interrupts:	The interrupt number
-		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
-
-Example:
-
-mailbox@7e00b840 {
-	compatible = "brcm,bcm2835-vchiq";
-	reg = <0x7e00b840 0xf>;
-	interrupts = <0 2>;
-};
diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
new file mode 100644
index 000000000000..e04439b3355b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm2835-vchiq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom VCHIQ firmware services
+
+maintainers:
+  - Nicolas Saenz Julienne <nsaenz@kernel.org>
+
+description:
+  The VCHIQ communication channel can be provided by BCM283x and Capri SoCs,
+  to communicate with the VPU-side OS services.
+
+properties:
+  compatible:
+    oneOf:
+      - description: BCM2835 based boards
+        items:
+          - enum:
+              - brcm,bcm2835-vchiq
+
+      - description: BCM2836/BCM2837 based boards
+        items:
+          - enum:
+              - brcm,bcm2836-vchiq
+          - const: brcm,bcm2835-vchiq
+
+  reg:
+    description: Physical base address and length of the doorbell register pair
+    minItems: 1
+
+  interrupts:
+    description: Interrupt number of the doorbell interrupt
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    mailbox@7e00b840 {
+      compatible = "brcm,bcm2835-vchiq";
+      reg = <0x7e00b840 0xf>;
+      interrupts = <0 2>;
+    };
+
+...
-- 
2.33.1

