Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB8B478404
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhLQEU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhLQEUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:20:20 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB7C061747;
        Thu, 16 Dec 2021 20:20:18 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v13-20020a17090a088d00b001b0e3a74cf7so3397396pjc.1;
        Thu, 16 Dec 2021 20:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LopG2br+9EBkgFCWCvvz7i5E0kmkV07MyNs9kSUl6Qs=;
        b=dVRGlh5gdS7+FzRPuTDAREASjyY9nZx8ZRYPkvBlroQQYhPbfY0Vs7AUHRBnAPG6FR
         QCAIkn7lI8re6rCaK1o7EmMr37N+HiMZrn8tDHEL+QMX2EfKafaQZu7yzTL2UcXLfu0r
         q3OE91miOxpj5qYMKttufbFiZRtIzDocyUVQl2bKbtHGzPsbMtlfqq4fqhlAt6iKkHOD
         O+0nx1vF9vjaAuN9ULYJBCpwPTKuGgT1+moLTE1gbcApWIOqkNmXEojWI2C3Om2CV1MX
         DirJhH+0JzDD64QyZ5ezX7FjBI8sIDbMQ9ZEIidgh8+FWBqc7ImZpNk4kb5XkcYWuyst
         bcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LopG2br+9EBkgFCWCvvz7i5E0kmkV07MyNs9kSUl6Qs=;
        b=bW6KwYownt32jEF4xWkTXNJug01vDAxMx6fuUkWss/8N/LCWguD7Npbut4e2Nww+gk
         SajZUbi+J0RJ8Yr7gW7DtCgRFbA8KjckwNeawI35bgF0wprtPH5xrS5Tfos580DZw9Bm
         HNNcq+Y0LN18F2TXKplDyWDMB4MZ+5PdQAHNd7l+HWtdIe2F4MsR/+sV/8czSyaj1gkt
         NAm14st0TJ8PHCJEZAztJgYgkRpwG4wZASxFlYdyW4F9/Oc9rRE/gSKkeXI6Q6tFvej3
         Fs+8r/e+YiyjuExdLw9Rsr7ydHys0Z4N8oWx4DRzSJSrKB9QDwogQRn+D+Wq3kWpe57f
         3CKw==
X-Gm-Message-State: AOAM5325dd0sKbfiE0UVDtuREMyoiqgAhQ3FrTbOKbrqdp3y3pL6iW9P
        AjAdVBcL887R3DFjRewu3XKOsawp/u0=
X-Google-Smtp-Source: ABdhPJzF4eI6Lj2lVooltyfuOQeuC75yPK4VP5B07vClQbXFNYg1RVkN3gJhf1zKOlrbvGmeQ4czvA==
X-Received: by 2002:a17:90b:3758:: with SMTP id ne24mr1664848pjb.59.1639714817399;
        Thu, 16 Dec 2021 20:20:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mq10sm7553496pjb.3.2021.12.16.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v4 4/6] dt-bindings: ata: Convert Broadcom SATA to YAML
Date:   Thu, 16 Dec 2021 20:19:59 -0800
Message-Id: <20211217042001.479577-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217042001.479577-1-f.fainelli@gmail.com>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
to help with validation.

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/ata/brcm,sata-brcm.txt           | 45 ----------
 .../bindings/ata/brcm,sata-brcm.yaml          | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 45 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
deleted file mode 100644
index b9ae4ce4a0a0..000000000000
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ /dev/null
@@ -1,45 +0,0 @@
-* Broadcom SATA3 AHCI Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA controller should have its own node.
-
-Required properties:
-- compatible         : should be one or more of
-			"brcm,bcm7216-ahci"
-			"brcm,bcm7425-ahci"
-			"brcm,bcm7445-ahci"
-			"brcm,bcm-nsp-ahci"
-			"brcm,sata3-ahci"
-			"brcm,bcm63138-ahci"
-- reg                : register mappings for AHCI and SATA_TOP_CTRL
-- reg-names          : "ahci" and "top-ctrl"
-- interrupts         : interrupt mapping for SATA IRQ
-
-Optional properties:
-
-- reset: for "brcm,bcm7216-ahci" must be a valid reset phandle
-  pointing to the RESCAL reset controller provider node.
-- reset-names: for "brcm,bcm7216-ahci", must be "rescal".
-
-Also see ahci-platform.txt.
-
-Example:
-
-	sata@f045a000 {
-		compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
-		reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
-		reg-names = "ahci", "top-ctrl";
-		interrupts = <0 30 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sata0: sata-port@0 {
-			reg = <0>;
-			phys = <&sata_phy 0>;
-		};
-
-		sata1: sata-port@1 {
-			reg = <1>;
-			phys = <&sata_phy 1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
new file mode 100644
index 000000000000..235a93ac86b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/brcm,sata-brcm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom SATA3 AHCI Controller
+
+description:
+  SATA nodes are defined to describe on-chip Serial ATA controllers.
+  Each SATA controller should have its own node.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: sata-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7216-ahci
+              - brcm,bcm7445-ahci
+              - brcm,bcm7425-ahci
+              - brcm,bcm63138-ahci
+          - const: brcm,sata3-ahci
+      - items:
+          - const: brcm,bcm-nsp-ahci
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: ahci
+      - const: top-ctrl
+
+  interrupts:
+    maxItems: 1
+
+  dma-coherent: true
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - brcm,bcm7216-ahci
+          - brcm,bcm63138-ahci
+then:
+  properties:
+    resets:
+      maxItems: 1
+    reset-names:
+      enum:
+        - rescal
+        - ahci
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@f045a000 {
+        compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
+        reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
+        reg-names = "ahci", "top-ctrl";
+        interrupts = <0 30 0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sata0: sata-port@0 {
+            reg = <0>;
+            phys = <&sata_phy 0>;
+        };
+
+        sata1: sata-port@1 {
+            reg = <1>;
+            phys = <&sata_phy 1>;
+        };
+    };
-- 
2.25.1

