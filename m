Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65E4790F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238835AbhLQQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhLQQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:05:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46F7C061574;
        Fri, 17 Dec 2021 08:05:51 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a23so2541129pgm.4;
        Fri, 17 Dec 2021 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWD/xuGtdH1vss0QKEe+SxlNOvbCee/X04hkdboMWhA=;
        b=dWlsdu7oCxzg3RBvdZbW+lTGmjBadSeJvpFFk5WPyT9nQBVJrvLfTe0Ec06e42/8MH
         BkILqlQzuWOQs3ud5TrVay3UYtnrEWZupDHopSfWPxRcAJE8z1Mlxz1KEpCH3uIZp5Uw
         SitdjJ/L/sg4CUx8lCivHAjXD6PsLvj/ARuy32F8JRvFlVF/NGLYx+6hok8hzRjaRIep
         c6AyBihz4VErdnOcN6SaihOLEoh9kKAb+KKBVg2kXENZbYMQdpQbcJ6q/rje1EMJ5Nbv
         jIxYYhhwezWN9FDiXm3mj8sluCmJW8yW09Nihx7Gq6hhEdUhpydvfovQA/uDuA7soNv9
         augg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWD/xuGtdH1vss0QKEe+SxlNOvbCee/X04hkdboMWhA=;
        b=XB8pVXOqtjN4cmgq2gf0I8/Uo2kFwDdxguMu+yWGqzZqYj+VgIZdRYcRCYRBKIfih7
         T1XvhCgpjoTPoNpTGKc/UoqKJDGMekkRdaOLzfUAoXlLCAQtZLAGtcguwYRGmrmBAxrp
         +PsAz/CtwyPMYyEyEUy6VPr6BC6b9rFqbKHZ+BbW0TVPBYV+/NA/chehfeaR3x67VwLG
         fVGfdHAoRk+CgVhSb7RAcCT1St74wXHL0jZp3JBiakIUxUoHf4U26vn75XBsZEtLaodi
         wZZmJncz3ikh50kbfVQ8px/3lfRs3InaBqvkCWSXjtgHG1jYVl5hhaedPkkQUwqIR2w9
         cPkA==
X-Gm-Message-State: AOAM530dFQsIPtxf7EEHi62MjbZTN3kzkwmZYUKv3S38XSRnsb7g5gMz
        5mVyPp1o0fres4ulm+1m/lD3PxtyUfU=
X-Google-Smtp-Source: ABdhPJxneCY5MjjbickIGgW9bkzxlA2EuFgNUsyXtmmNSN6YJro71fRRp0tLcev9FVybgwTGQnur5Q==
X-Received: by 2002:a63:db16:: with SMTP id e22mr3387791pgg.577.1639757150581;
        Fri, 17 Dec 2021 08:05:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z23sm4020760pfr.189.2021.12.17.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:05:50 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v5 1/2] dt-bindings: interrupt-controller: Convert BCM7120 L2 to YAML
Date:   Fri, 17 Dec 2021 08:05:45 -0800
Message-Id: <20211217160546.497012-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217160546.497012-1-f.fainelli@gmail.com>
References: <20211217160546.497012-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom BCM7120 Level 2 interrupt controller Device Tree
binding to YAML to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../brcm,bcm7120-l2-intc.txt                  |  88 ------------
 .../brcm,bcm7120-l2-intc.yaml                 | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
deleted file mode 100644
index addd86b6ca2f..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-Broadcom BCM7120-style Level 2 interrupt controller
-
-This interrupt controller hardware is a second level interrupt controller that
-is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
-platforms. It can be found on BCM7xxx products starting with BCM7120.
-
-Such an interrupt controller has the following hardware design:
-
-- outputs multiple interrupts signals towards its interrupt controller parent
-
-- controls how some of the interrupts will be flowing, whether they will
-  directly output an interrupt signal towards the interrupt controller parent,
-  or if they will output an interrupt signal at this 2nd level interrupt
-  controller, in particular for UARTs
-
-- has one 32-bit enable word and one 32-bit status word
-
-- no atomic set/clear operations
-
-- not all bits within the interrupt controller actually map to an interrupt
-
-The typical hardware layout for this controller is represented below:
-
-2nd level interrupt line		Outputs for the parent controller (e.g: ARM GIC)
-
-0 -----[ MUX ] ------------|==========> GIC interrupt 75
-          \-----------\
-                       |
-1 -----[ MUX ] --------)---|==========> GIC interrupt 76
-          \------------|
-                       |
-2 -----[ MUX ] --------)---|==========> GIC interrupt 77
-          \------------|
-                       |
-3 ---------------------|
-4 ---------------------|
-5 ---------------------|
-7 ---------------------|---|===========> GIC interrupt 66
-9 ---------------------|
-10 --------------------|
-11 --------------------/
-
-6 ------------------------\
-                           |===========> GIC interrupt 64
-8 ------------------------/
-
-12 ........................ X
-13 ........................ X 		(not connected)
-..
-31 ........................ X
-
-Required properties:
-
-- compatible: should be "brcm,bcm7120-l2-intc"
-- reg: specifies the base physical address and size of the registers
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an interrupt
-  source, should be 1.
-- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
-  node, valid values depend on the type of parent interrupt controller
-- brcm,int-map-mask: 32-bits bit mask describing how many and which interrupts
-  are wired to this 2nd level interrupt controller, and how they match their
-  respective interrupt parents. Should match exactly the number of interrupts
-  specified in the 'interrupts' property.
-
-Optional properties:
-
-- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
-  wakeup source for system suspend/resume.
-
-- brcm,int-fwd-mask: if present, a bit mask to configure the interrupts which
-  have a mux gate, typically UARTs. Setting these bits will make their
-  respective interrupt outputs bypass this 2nd level interrupt controller
-  completely; it is completely transparent for the interrupt controller
-  parent. This should have one 32-bit word per enable/status pair.
-
-Example:
-
-irq0_intc: interrupt-controller@f0406800 {
-	compatible = "brcm,bcm7120-l2-intc";
-	interrupt-parent = <&intc>;
-	#interrupt-cells = <1>;
-	reg = <0xf0406800 0x8>;
-	interrupt-controller;
-	interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
-	brcm,int-map-mask = <0xeb8>, <0x140>;
-	brcm,int-fwd-mask = <0x7>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
new file mode 100644
index 000000000000..5d7731ea4182
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7120-l2-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM7120-style Level 2 interrupt controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+description: >
+  This interrupt controller hardware is a second level interrupt controller that
+  is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
+  platforms. It can be found on BCM7xxx products starting with BCM7120.
+
+  Such an interrupt controller has the following hardware design:
+
+  - outputs multiple interrupts signals towards its interrupt controller parent
+
+  - controls how some of the interrupts will be flowing, whether they will
+    directly output an interrupt signal towards the interrupt controller parent,
+    or if they will output an interrupt signal at this 2nd level interrupt
+    controller, in particular for UARTs
+
+  - has one 32-bit enable word and one 32-bit status word
+
+  - no atomic set/clear operations
+
+  - not all bits within the interrupt controller actually map to an interrupt
+
+  The typical hardware layout for this controller is represented below:
+
+  2nd level interrupt line		Outputs for the parent controller (e.g: ARM GIC)
+
+  0 -----[ MUX ] ------------|==========> GIC interrupt 75
+            \-----------\
+                         |
+  1 -----[ MUX ] --------)---|==========> GIC interrupt 76
+            \------------|
+                         |
+  2 -----[ MUX ] --------)---|==========> GIC interrupt 77
+            \------------|
+                         |
+  3 ---------------------|
+  4 ---------------------|
+  5 ---------------------|
+  7 ---------------------|---|===========> GIC interrupt 66
+  9 ---------------------|
+  10 --------------------|
+  11 --------------------/
+
+  6 ------------------------\
+                            |===========> GIC interrupt 64
+  8 ------------------------/
+
+  12 ........................ X
+  13 ........................ X           (not connected)
+  ..
+  31 ........................ X
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: brcm,bcm7120-l2-intc
+
+  reg:
+    maxItems: 1
+    description: >
+      Specifies the base physical address and size of the registers
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
+
+  brcm,int-map-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      32-bits bit mask describing how many and which interrupts are wired to
+      this 2nd level interrupt controller, and how they match their respective
+      interrupt parents. Should match exactly the number of interrupts
+      specified in the 'interrupts' property.
+
+  brcm,irq-can-wake:
+    type: boolean
+    description: >
+      If present, this means the L2 controller can be used as a wakeup source
+      for system suspend/resume.
+
+  brcm,int-fwd-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      if present, a bit mask to configure the interrupts which have a mux gate,
+      typically UARTs. Setting these bits will make their respective interrupt
+      outputs bypass this 2nd level interrupt controller completely; it is
+      completely transparent for the interrupt controller parent. This should
+      have one 32-bit word per enable/status pair.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+examples:
+  - |
+    irq0_intc: interrupt-controller@f0406800 {
+      compatible = "brcm,bcm7120-l2-intc";
+      interrupt-parent = <&intc>;
+      #interrupt-cells = <1>;
+      reg = <0xf0406800 0x8>;
+      interrupt-controller;
+      interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
+      brcm,int-map-mask = <0xeb8>, <0x140>;
+      brcm,int-fwd-mask = <0x7>;
+    };
-- 
2.25.1

