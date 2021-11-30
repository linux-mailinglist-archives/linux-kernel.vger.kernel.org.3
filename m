Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8178463FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbhK3V1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:27:06 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:46353 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbhK3V0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:26:23 -0500
Received: from localhost.localdomain (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 699371F57E;
        Tue, 30 Nov 2021 22:23:00 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clock: add QCOM SM6125 display clock bindings
Date:   Tue, 30 Nov 2021 22:21:32 +0100
Message-Id: <20211130212137.25303-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for display clock controller for
Qualcomm Technology Inc's SM6125 SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 .../bindings/clock/qcom,dispcc-sm6125.yaml    | 87 +++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm6125.h    | 41 +++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6125.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
new file mode 100644
index 000000000000..971a72bbb631
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6125.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6125.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock Controller Binding for SM6125
+
+maintainers:
+  - Martin Botka <martin.botka@somainline.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks and
+  power domains on SM6125.
+
+  See also:
+    dt-bindings/clock/qcom,dispcc-sm6125.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6125-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: Pixel clock from DSI PHY1
+      - description: Link clock from DP PHY
+      - description: VCO DIV clock from DP PHY
+      - description: AHB config clock from GCC
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: dsi0_phy_pll_out_byteclk
+      - const: dsi0_phy_pll_out_dsiclk
+      - const: dsi1_phy_pll_out_dsiclk
+      - const: dp_phy_pll_link_clk
+      - const: dp_phy_pll_vco_div_clk
+      - const: cfg_ahb_clk
+
+  '#clock-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
+    clock-controller@5f00000 {
+      compatible = "qcom,sm6125-dispcc";
+      reg = <0x5f00000 0x20000>;
+      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+               <&dsi0_phy 0>,
+               <&dsi0_phy 1>,
+               <&dsi1_phy 0>,
+               <&dp_phy 0>,
+               <&dp_phy 1>,
+               <&gcc GCC_DISP_AHB_CLK>;
+      clock-names = "bi_tcxo",
+                    "dsi0_phy_pll_out_byteclk",
+                    "dsi0_phy_pll_out_dsiclk",
+                    "dsi1_phy_pll_out_dsiclk",
+                    "dp_phy_pll_link_clk",
+                    "dp_phy_pll_vco_div_clk",
+                    "cfg_ahb_clk";
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm6125.h b/include/dt-bindings/clock/qcom,dispcc-sm6125.h
new file mode 100644
index 000000000000..d3fa45aa0e83
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm6125.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6125_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6125_H
+
+#define DISP_CC_PLL0			0
+#define DISP_CC_MDSS_AHB_CLK		1
+#define DISP_CC_MDSS_AHB_CLK_SRC	2
+#define DISP_CC_MDSS_BYTE0_CLK		3
+#define DISP_CC_MDSS_BYTE0_CLK_SRC	4
+#define DISP_CC_MDSS_BYTE0_INTF_CLK	5
+#define DISP_CC_MDSS_DP_AUX_CLK		6
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC	7
+#define DISP_CC_MDSS_DP_CRYPTO_CLK	8
+#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC	9
+#define DISP_CC_MDSS_DP_LINK_CLK	10
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC	11
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK	12
+#define DISP_CC_MDSS_DP_PIXEL_CLK	13
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC	14
+#define DISP_CC_MDSS_ESC0_CLK		15
+#define DISP_CC_MDSS_ESC0_CLK_SRC	16
+#define DISP_CC_MDSS_MDP_CLK		17
+#define DISP_CC_MDSS_MDP_CLK_SRC	18
+#define DISP_CC_MDSS_MDP_LUT_CLK	19
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK	20
+#define DISP_CC_MDSS_PCLK0_CLK		21
+#define DISP_CC_MDSS_PCLK0_CLK_SRC	22
+#define DISP_CC_MDSS_ROT_CLK		23
+#define DISP_CC_MDSS_ROT_CLK_SRC	24
+#define DISP_CC_MDSS_VSYNC_CLK		25
+#define DISP_CC_MDSS_VSYNC_CLK_SRC	26
+#define DISP_CC_XO_CLK			27
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC			0
+
+#endif
-- 
2.34.0

