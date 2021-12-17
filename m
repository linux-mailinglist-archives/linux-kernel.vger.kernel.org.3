Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825D2478407
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhLQEUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhLQEUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:20:21 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C774C06175B;
        Thu, 16 Dec 2021 20:20:20 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id j11so978223pgs.2;
        Thu, 16 Dec 2021 20:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iENCssM+7j9yuFOoYg1txSwEuQxBBByhieQXs6KDMvI=;
        b=Gd8x4qElW2XQnr3xHo3QEW8JU5/nb2Js11/VU/maEtCky+BWKcDpPdvBSRVijNuegs
         sILsHxgpnOKpM8IdhZci4Vk76CXQ/jMwAIQ8i9cXPHUxfGnt8M+XsxisAtH7gUBxmuu7
         nPt1jQF0l6H2XBNA4g5hZYAbQhlKtgrok7Yni5iCPMuTUKlOp7VPYUTTi/ZFv9zfoGAz
         iFPxW+3F33VhfudaiEBVIBhfwq8JA2T3Q6sHMt3dDv1XoPlGLmSrrfU8DHFDYw1JLThg
         Vb8ZmsO/cVcWK1EwhfsCLqd7EVGCb2z85YTBV9/SAd05KmYbZEW90tZUvJCqWPOHdYIc
         Y6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iENCssM+7j9yuFOoYg1txSwEuQxBBByhieQXs6KDMvI=;
        b=d512kZAAOc2FwcuUlq871zgYNpraagadWnUTFrXcYpeXOaGmnenFSDZVR+HHC4wSqX
         Rg0ei3HQsxbzVE0ik6+LOyzSffj4+UTWZsPPlviox+xQOxx6xC3KgqvsOB2Jd1EJYRGi
         DGmfN6wnjUoBpzDL4PBGztBHkSXbHUXTWKTRr52yha+fari3Lfn/LftYwijg+4AoxL+s
         1xUIaYBnT7QOAWoiEe8A3VLEgraQOBmFrg9bByLzj5Rn6WQq+CINwqZQh6IWUry0SJOe
         ssPh0wApGr+BV05ru1QBXNhsuRK+cRUOZmm1wEILwRQfjMUYwHYMFh5A7GL3eYQ8fGsZ
         u2qA==
X-Gm-Message-State: AOAM532BsaSM+DMFPsZ/gPhk4BZ/j17+aXmXjnuEkq/xH4rnsPPB2OTX
        qK/FLAfdoQjsBkc9VD4tF/G3vjFjWUA=
X-Google-Smtp-Source: ABdhPJwTX2oCmkdBhcbswY9jbqXaWWpE2Z/DsL+tv39GBks/dedys7lG1EmcCubEdTamu2xcgx9vSQ==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr1265162pgd.541.1639714819230;
        Thu, 16 Dec 2021 20:20:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mq10sm7553496pjb.3.2021.12.16.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:18 -0800 (PST)
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
Subject: [PATCH v4 5/6] dt-bindings: bus: Convert GISB arbiter to YAML
Date:   Thu, 16 Dec 2021 20:20:00 -0800
Message-Id: <20211217042001.479577-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217042001.479577-1-f.fainelli@gmail.com>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Broadcom STB GISB bus arbiter to YAML to help with
validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/bus/brcm,gisb-arb.txt | 34 ----------
 .../bindings/bus/brcm,gisb-arb.yaml           | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
 create mode 100644 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
deleted file mode 100644
index 10f6d0a8159d..000000000000
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Broadcom GISB bus Arbiter controller
-
-Required properties:
-
-- compatible:
-    "brcm,bcm7278-gisb-arb" for V7 28nm chips
-    "brcm,gisb-arb" or "brcm,bcm7445-gisb-arb" for other 28nm chips
-    "brcm,bcm7435-gisb-arb" for newer 40nm chips
-    "brcm,bcm7400-gisb-arb" for older 40nm chips and all 65nm chips
-    "brcm,bcm7038-gisb-arb" for 130nm chips
-- reg: specifies the base physical address and size of the registers
-- interrupts: specifies the two interrupts (timeout and TEA) to be used from
-  the parent interrupt controller. A third optional interrupt may be specified
-  for breakpoints.
-
-Optional properties:
-
-- brcm,gisb-arb-master-mask: 32-bits wide bitmask used to specify which GISB
-  masters are valid at the system level
-- brcm,gisb-arb-master-names: string list of the litteral name of the GISB
-  masters. Should match the number of bits set in brcm,gisb-master-mask and
-  the order in which they appear
-
-Example:
-
-gisb-arb@f0400000 {
-	compatible = "brcm,gisb-arb";
-	reg = <0xf0400000 0x800>;
-	interrupts = <0>, <2>;
-	interrupt-parent = <&sun_l2_intc>;
-
-	brcm,gisb-arb-master-mask = <0x7>;
-	brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
-};
diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
new file mode 100644
index 000000000000..b23c3001991e
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/brcm,gisb-arb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom GISB bus Arbiter controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm7445-gisb-arb  # for other 28nm chips
+          - const: brcm,gisb-arb
+      - items:
+          - enum:
+              - brcm,bcm7278-gisb-arb  # for V7 28nm chips
+              - brcm,bcm7435-gisb-arb  # for newer 40nm chips
+              - brcm,bcm7400-gisb-arb  # for older 40nm chips and all 65nm chips
+              - brcm,bcm7038-gisb-arb  # for 130nm chips
+              - brcm,gisb-arb          # fallback compatible
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    items:
+      - description: timeout interrupt line
+      - description: target abort interrupt line
+      - description: breakpoint interrupt line
+
+  brcm,gisb-arb-master-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      32-bits wide bitmask used to specify which GISB masters are valid at the
+      system level
+
+  brcm,gisb-arb-master-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: >
+      String list of the litteral name of the GISB masters. Should match the
+      number of bits set in brcm,gisb-master-mask and the order in which they
+      appear from MSB to LSB.
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
+    gisb-arb@f0400000 {
+      compatible = "brcm,gisb-arb";
+      reg = <0xf0400000 0x800>;
+      interrupts = <0>, <2>;
+      interrupt-parent = <&sun_l2_intc>;
+      brcm,gisb-arb-master-mask = <0x7>;
+      brcm,gisb-arb-master-names = "bsp_0", "scpu_0", "cpu_0";
+    };
-- 
2.25.1

