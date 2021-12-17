Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB9478A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhLQLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:37:02 -0500
Received: from muru.com ([72.249.23.125]:39412 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231373AbhLQLhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:37:01 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A19EE80FB;
        Fri, 17 Dec 2021 11:37:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Tero Kristo <kristo@kernel.org>
Subject: [PATCH] dt-bindings: clock: Add binding for TI clksel
Date:   Fri, 17 Dec 2021 13:36:40 +0200
Message-Id: <20211217113640.59840-1-tony@atomide.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prepare for fixing lots of devicetree unique_unit_address
warnings for the TI clock nodes, let's add a binding for the clksel
clocks. This allows us to move the overlapping devicetree clocks to be
children of the related clksel nodes. And then we need the reg property
only for the parent clksel node.

We want to set #clock-cells = <1> in case we ever start parsing the clkcsel
clocks directly using a clksel driver rather than using the existing
component clock drivers and child nodes. We also need to update the clock
drivers to get the IO address from the parent clksel node before updating
the dts files. These will be posted as separate patches.

Cc: Tero Kristo <kristo@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../bindings/clock/ti/ti,clksel.yaml          | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml

diff --git a/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
new file mode 100644
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
@@ -0,0 +1,41 @@
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
+  The TI CLKSEL clocks consist of consist of a mux, divider, multiplier and
+  gate bits.
+
+properties:
+  compatible:
+    const: ti,clksel
+
+  reg:
+    maxItems: 1
+    description: The CLKSEL register
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    clksel_gfx_fclk: clock@52c {
+      compatible = "ti,clksel";
+      reg = <0x25c 0x4>;
+      #clock-cells = <1>;
+    };
+...
-- 
2.34.1
