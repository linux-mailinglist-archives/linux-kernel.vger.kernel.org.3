Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443DC477C32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbhLPTIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45010 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbhLPTIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB21361F54
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9A8C36AE3;
        Thu, 16 Dec 2021 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681694;
        bh=R35uPEOykMrb0DhrylFFTZ5kJ+Cv1RybcWf4ZW5qIWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrRsZo4cme+uUjjOSQTpET9IKNtGgsm4G8XFh6+L8h3+RMG2rdyVA35aER0tyA52y
         k7+kAIqgKm3BWpd2uI3E0BU18hX5tXFit2nKsMmDjymUvm8IP2Er3w67bhC3MIVvGc
         iAMDQk8Z9AiJ46KXK9JN3wJJdzkUfuls64e8qmy6zmOUW9iLc3fuFnYzDG9lIUBNSv
         D6JXLExLajmP2uPVbNZ1e+xH1H3POrr3gCJQGQgKi7qkrIr/xce56BKCfP2udWW05f
         l9JLq96HCAKArAqM5cK1OHnUlxulTZVfd2tl2Stb2s81Gao3XpP8HxrNgh9/dQSOAf
         Lpr8JuLmEG29w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Lo <james.lo@mediatek.com>, linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 3/6] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Thu, 16 Dec 2021 11:08:09 -0800
Message-Id: <20211216190812.1574801-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211216190812.1574801-1-sboyd@kernel.org>
References: <20211216190812.1574801-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Lo <james.lo@mediatek.com>

This adds documentation for the SPMI controller found on Mediatek SoCs.

Signed-off-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211119034613.32489-3-james.lo@mediatek.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml

diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
new file mode 100644
index 000000000000..2445c5e0b0ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spmi/mtk,spmi-mtk-pmif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek SPMI Controller Device Tree Bindings
+
+maintainers:
+  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
+
+description: |+
+  On MediaTek SoCs the PMIC is connected via SPMI and the controller allows
+  for multiple SoCs to control a single SPMI master.
+
+allOf:
+  - $ref: "spmi.yaml"
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6873-spmi
+      - mediatek,mt8195-spmi
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: pmif
+      - const: spmimst
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: pmif_sys_ck
+      - const: pmif_tmr_ck
+      - const: spmimst_clk_mux
+
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8192-clk.h>
+
+    spmi: spmi@10027000 {
+        compatible = "mediatek,mt6873-spmi";
+        reg = <0x10027000 0xe00>,
+              <0x10029000 0x100>;
+        reg-names = "pmif", "spmimst";
+        clocks = <&infracfg CLK_INFRA_PMIC_AP>,
+                 <&infracfg CLK_INFRA_PMIC_TMR>,
+                 <&topckgen CLK_TOP_SPMI_MST_SEL>;
+        clock-names = "pmif_sys_ck",
+                      "pmif_tmr_ck",
+                      "spmimst_clk_mux";
+        assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
+        assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

