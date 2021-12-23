Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4747E2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348158AbhLWMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348134AbhLWMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:53 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E5C061759
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:08:52 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:29a7:866a:cac1:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6A9252866B4;
        Thu, 23 Dec 2021 13:08:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640261330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3Mn3xMvrNsKG9t4FirRIQpmR0nVLWUMlv6hgLgUkJg=;
        b=BiCxdQ77GN1gvGMuSb+7oYUL2r4KE8593nrHE6IP8/Ao+7SImTS4OFm3IlobVBILxm0YzU
        T+JW/i5/U06V9HeGMdkFWSWJI0czmS0SxFJbg6qA3Kb+z0CXjHuZL0CHQea1FHtdA0JB9N
        DRry3YOo1UqiWJUxOltrVvH/tDMhe8/+lK8WvhKSvVXxX5Uc+OECFydAU4RNrOgkbH0gma
        A0F/Va2Vv/IZYH8g0Oj3i6JlwYf/fQzkJa+rq/UNZT2iVTMkRm0etTDARyQQ+uBnzG6vf8
        vdqzg9RZDK0V9RtbghiIIOu/Zh9QACBKa+nKra8G5iiTvT+RXFeloGMvpOyq+w==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 3/4] dt-bindings: interrupt-controller: realtek,rtl-intc: replace irq mapping
Date:   Thu, 23 Dec 2021 13:08:33 +0100
Message-Id: <8a5931f18a6f1c92f8c8e4965dc65674d7e5a4c4.1640261161.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640261161.git.sander@svanheule.net>
References: <cover.1640261161.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding incorrectly specified the "interrupt-map" property should be
used, although the use is non-standard. A quirk had to be introduced in
commit de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
definition of interrupt-map") to allow the driver to function again.

Update the binding to require a list of parent interrupts instead, and
replace the "interrupt-map" property by the custom
"realtek,interrupt-routing" property.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---

The registers for this interrupt controller have 4 bits per SoC
interrupt. This means that, in theory, 15 output interrupts could be
wired up (a value of 0 means 'disconnected'), but we have only ever seen
this router being used to map to the six MIPS CPU hardware interrupts.
---
 .../realtek,rtl-intc.yaml                     | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
index 9e76fff20323..4f7f30111a8e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -6,6 +6,11 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek RTL SoC interrupt controller devicetree bindings
 
+description:
+  Interrupt router for Realtek MIPS SoCs, allowing up to 32 SoC interrupts to
+  be routed to one of up to 15 parent interrupts, or left disconnected. Most
+  commonly, the CPU's six hardware interrupts are used as parent interrupts.
+
 maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
   - Bert Vermeulen <bert@biot.com>
@@ -15,30 +20,40 @@ properties:
   compatible:
     const: realtek,rtl-intc
 
-  "#interrupt-cells":
-    const: 1
-
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
+  "#interrupt-cells":
+    const: 1
 
   interrupt-controller: true
 
-  "#address-cells":
-    const: 0
+  interrupts:
+    minItems: 1
+    maxItems: 15
+    description:
+      List of interrupts where SoC interrupts inputs can be routed to. Must be
+      provided in the same order as the output lines. The first interrupt is
+      thus selected via routing value 0, etc.
 
-  interrupt-map:
-    description: Describes mapping from SoC interrupts to CPU interrupts
+  realtek,interrupt-routing:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      List of <soc_int irq_idx> pairs, where "soc_int" is the interrupt line
+      number as provided by this controller. "irq_idx" is the index of the
+      interrupt in the list as specified the interrupts property.
+    items:
+      items:
+        - description: SoC interrupt index
+        - description: parent interrupt index
 
 required:
   - compatible
   - reg
   - "#interrupt-cells"
   - interrupt-controller
-  - "#address-cells"
-  - interrupt-map
+  - interrupts
+  - realtek,interrupt-routing
 
 additionalProperties: false
 
@@ -49,9 +64,11 @@ examples:
       #interrupt-cells = <1>;
       interrupt-controller;
       reg = <0x3000 0x20>;
-      #address-cells = <0>;
-      interrupt-map =
-              <31 &cpuintc 2>,
-              <30 &cpuintc 1>,
-              <29 &cpuintc 5>;
+
+      interrupt-parent = <&cpu_intc>;
+      interrupts = <2>, <3>, <4>;
+      realtek,interrupt-routing =
+              <31 0>, /* route to cpu_intc interrupt 2 */
+              <30 1>, /* route to cpu_intc interrupt 3 */
+              <29 2>; /* route to cpu_intc interrupt 4 */
     };
-- 
2.33.1

