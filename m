Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534424A7FEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349413AbiBCHji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:39:38 -0500
Received: from muru.com ([72.249.23.125]:45812 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbiBCHjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:39:37 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 411DD80EE;
        Thu,  3 Feb 2022 07:39:21 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Tero Kristo <kristo@kernel.org>
Subject: [PATCHv2] dt-bindings: clock: Add binding for TI clksel
Date:   Thu,  3 Feb 2022 09:39:29 +0200
Message-Id: <20220203073929.59296-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for fixing lots of devicetree unique_unit_address
warnings for the TI clock nodes, let's add a binding for the TI clksel
clocks. This allows us to move the overlapping reg properties for the
component clocks to be children of the related clksel nodes. And with
that we need the reg property only for the parent clksel node making
the reg property unique like it should be.

We want to set #clock-cells = <2> in case we ever start parsing ranges
of clkcsel instances directly using a clksel driver rather than using the
existing component clock drivers and child nodes.

And before the devicetree files can be updated, we need to update the
TI clock drivers to get the IO address from the parent clksel node.

Cc: Tero Kristo <kristo@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Changes since V1:

- Set additionalProperties to type object as suggested by Rob

- Changed #clock-cells to 2 for parsing ranges of clksel instances

- Updated patch description for more info on why this is needed

 .../bindings/clock/ti/ti,clksel.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/ti/ti,clksel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for TI clksel clock
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description: |
+  The TI CLKSEL clocks consist of consist of input clock mux bits, and in some
+  cases also has divider, multiplier and gate bits.
+
+properties:
+  compatible:
+    const: ti,clksel
+
+  reg:
+    maxItems: 1
+    description: The CLKSEL register range
+
+  '#address-cells':
+    enum: [ 0, 1, 2 ]
+
+  '#size-cells':
+    enum: [ 0, 1, 2 ]
+
+  ranges: true
+
+  "#clock-cells":
+    const: 2
+    description: The CLKSEL register and bit offset
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    clksel_gfx_fclk: clock@52c {
+      compatible = "ti,clksel";
+      reg = <0x25c 0x4>;
+      #clock-cells = <2>;
+    };
+...
-- 
2.35.1
