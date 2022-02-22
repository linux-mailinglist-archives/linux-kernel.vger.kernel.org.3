Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9060A4BEF12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiBVBQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiBVBQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:16 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2EC24F2E;
        Mon, 21 Feb 2022 17:15:50 -0800 (PST)
Received: from localhost.localdomain (abxh33.neoplus.adsl.tpnet.pl [83.9.1.33])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 97EDB3F586;
        Tue, 22 Feb 2022 02:15:46 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: clock: add QCOM SM6350 display clock bindings
Date:   Tue, 22 Feb 2022 02:15:28 +0100
Message-Id: <20220222011534.3502-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for display clock controller for
Qualcomm Technology Inc's SM6350 SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../bindings/clock/qcom,dispcc-sm6350.yaml    | 86 +++++++++++++++++++
 .../dt-bindings/clock/qcom,dispcc-sm6350.h    | 48 +++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm6350.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
new file mode 100644
index 000000000000..e706678b353a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sm6350.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,dispcc-sm6350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller Binding for SM6350
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@somainline.org>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains on SM6350.
+
+  See also dt-bindings/clock/qcom,dispcc-sm6350.h.
+
+properties:
+  compatible:
+    const: qcom,sm6350-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 source from GCC
+      - description: Byte clock from DSI PHY
+      - description: Pixel clock from DSI PHY
+      - description: Link clock from DP PHY
+      - description: VCO DIV clock from DP PHY
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: gcc_disp_gpll0_clk
+      - const: dsi0_phy_pll_out_byteclk
+      - const: dsi0_phy_pll_out_dsiclk
+      - const: dp_phy_pll_link_clk
+      - const: dp_phy_pll_vco_div_clk
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
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
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm6350.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sm6350-dispcc";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&gcc GCC_DISP_GPLL0_CLK>,
+               <&dsi_phy 0>,
+               <&dsi_phy 1>,
+               <&dp_phy 0>,
+               <&dp_phy 1>;
+      clock-names = "bi_tcxo",
+                    "gcc_disp_gpll0_clk",
+                    "dsi0_phy_pll_out_byteclk",
+                    "dsi0_phy_pll_out_dsiclk",
+                    "dp_phy_pll_link_clk",
+                    "dp_phy_pll_vco_div_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,dispcc-sm6350.h b/include/dt-bindings/clock/qcom,dispcc-sm6350.h
new file mode 100644
index 000000000000..cb54aae2723e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sm6350.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6350_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_SM6350_H
+
+/* DISP_CC clocks */
+#define DISP_CC_PLL0				0
+#define DISP_CC_MDSS_AHB_CLK			1
+#define DISP_CC_MDSS_AHB_CLK_SRC		2
+#define DISP_CC_MDSS_BYTE0_CLK			3
+#define DISP_CC_MDSS_BYTE0_CLK_SRC		4
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC		5
+#define DISP_CC_MDSS_BYTE0_INTF_CLK		6
+#define DISP_CC_MDSS_DP_AUX_CLK			7
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC		8
+#define DISP_CC_MDSS_DP_CRYPTO_CLK		9
+#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC		10
+#define DISP_CC_MDSS_DP_LINK_CLK		11
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC		12
+#define DISP_CC_MDSS_DP_LINK_DIV_CLK_SRC	13
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK		14
+#define DISP_CC_MDSS_DP_PIXEL_CLK		15
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC		16
+#define DISP_CC_MDSS_ESC0_CLK			17
+#define DISP_CC_MDSS_ESC0_CLK_SRC		18
+#define DISP_CC_MDSS_MDP_CLK			19
+#define DISP_CC_MDSS_MDP_CLK_SRC		20
+#define DISP_CC_MDSS_MDP_LUT_CLK		21
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK		22
+#define DISP_CC_MDSS_PCLK0_CLK			23
+#define DISP_CC_MDSS_PCLK0_CLK_SRC		24
+#define DISP_CC_MDSS_ROT_CLK			25
+#define DISP_CC_MDSS_ROT_CLK_SRC		26
+#define DISP_CC_MDSS_RSCC_AHB_CLK		27
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK		28
+#define DISP_CC_MDSS_VSYNC_CLK			29
+#define DISP_CC_MDSS_VSYNC_CLK_SRC		30
+#define DISP_CC_SLEEP_CLK			31
+#define DISP_CC_XO_CLK				32
+
+/* GDSCs */
+#define MDSS_GDSC				0
+
+#endif
-- 
2.35.1

