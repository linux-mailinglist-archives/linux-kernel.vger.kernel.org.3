Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319C8465AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354367AbhLBAZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:25:34 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:4585 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354308AbhLBAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638404518; x=1669940518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwiJqMQfTck9TBs06kN6bpPU341kZ0aV2gh7wnNjbGo=;
  b=gd7T7EubJYvXPwHyu65jlt+CsMGU9FtLuGgZjALke8kePD9FitCgprg9
   RhfSoIrzZFs+dOlBElqAE9KM70zXMhu7FOE7jvoHree6ut5eVRs3PJ2ps
   0kZa7UjTdgckvjDpSTtbarrMCUh4jTvBcyww2Q7D95hMav6FMwxzGDCEW
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 16:21:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:21:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:56 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:55 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 1/5] dt-bindings: clock: Add SDX65 GCC clock bindings
Date:   Wed, 1 Dec 2021 16:21:31 -0800
Message-ID: <e15509b2b7c9b600ab38c5269d4fac609c077b5b.1638402361.git.quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638402361.git.quic_vamslank@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi krishna Lanka <quic_vamslank@quicinc.com>

Add device tree bindings for global clock controller on SDX65 SOCs.

Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/clock/qcom,gcc-sdx65.yaml        |  80 ++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdx65.h    | 122 ++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx65.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
new file mode 100644
index 000000000000..16c4cdc7b4d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdx65.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-sdx65.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for SDX65
+
+maintainers:
+  - Vamsi krishna Lanka <quic_vamslank@quicinc.com>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on SDX65
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-sdx65.h
+
+properties:
+  compatible:
+    const: qcom,gcc-sdx65
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Sleep clock source
+      - description: PCIE Pipe clock source
+      - description: USB3 phy wrapper pipe clock source
+      - description: PLL test clock source (Optional clock)
+    minItems: 5
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: bi_tcxo_ao
+      - const: sleep_clk
+      - const: pcie_pipe_clk
+      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk
+      - const: core_bi_pll_test_se # Optional clock
+    minItems: 5
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
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,gcc-sdx65";
+      reg = <0x100000 0x1f7400>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
+               <&pcie_pipe_clk>, <&usb3_phy_wrapper_gcc_usb30_pipe_clk>, <&pll_test_clk>;
+      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
+                    "pcie_pipe_clk", "usb3_phy_wrapper_gcc_usb30_pipe_clk", "core_bi_pll_test_se";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,gcc-sdx65.h b/include/dt-bindings/clock/qcom,gcc-sdx65.h
new file mode 100644
index 000000000000..75ecc9237d8f
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sdx65.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SDX65_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SDX65_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_EVEN						1
+#define GCC_AHB_PCIE_LINK_CLK					2
+#define GCC_BLSP1_AHB_CLK					3
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK				4
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK_SRC				5
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK				6
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK_SRC				7
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK				8
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK_SRC				9
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK				10
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK_SRC				11
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK				12
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK_SRC				13
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK				14
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK_SRC				15
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK				16
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK_SRC				17
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK				18
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK_SRC				19
+#define GCC_BLSP1_SLEEP_CLK					20
+#define GCC_BLSP1_UART1_APPS_CLK				21
+#define GCC_BLSP1_UART1_APPS_CLK_SRC				22
+#define GCC_BLSP1_UART2_APPS_CLK				23
+#define GCC_BLSP1_UART2_APPS_CLK_SRC				24
+#define GCC_BLSP1_UART3_APPS_CLK				25
+#define GCC_BLSP1_UART3_APPS_CLK_SRC				26
+#define GCC_BLSP1_UART4_APPS_CLK				27
+#define GCC_BLSP1_UART4_APPS_CLK_SRC				28
+#define GCC_BOOT_ROM_AHB_CLK					29
+#define GCC_CPUSS_AHB_CLK					30
+#define GCC_CPUSS_AHB_CLK_SRC					31
+#define GCC_CPUSS_AHB_POSTDIV_CLK_SRC				32
+#define GCC_CPUSS_GNOC_CLK					33
+#define GCC_GP1_CLK						34
+#define GCC_GP1_CLK_SRC						35
+#define GCC_GP2_CLK						36
+#define GCC_GP2_CLK_SRC						37
+#define GCC_GP3_CLK						38
+#define GCC_GP3_CLK_SRC						39
+#define GCC_PCIE_0_CLKREF_EN					40
+#define GCC_PCIE_AUX_CLK					41
+#define GCC_PCIE_AUX_CLK_SRC					42
+#define GCC_PCIE_AUX_PHY_CLK_SRC				43
+#define GCC_PCIE_CFG_AHB_CLK					44
+#define GCC_PCIE_MSTR_AXI_CLK					45
+#define GCC_PCIE_PIPE_CLK					46
+#define GCC_PCIE_PIPE_CLK_SRC					47
+#define GCC_PCIE_RCHNG_PHY_CLK					48
+#define GCC_PCIE_RCHNG_PHY_CLK_SRC				49
+#define GCC_PCIE_SLEEP_CLK					50
+#define GCC_PCIE_SLV_AXI_CLK					51
+#define GCC_PCIE_SLV_Q2A_AXI_CLK				52
+#define GCC_PDM2_CLK						53
+#define GCC_PDM2_CLK_SRC					54
+#define GCC_PDM_AHB_CLK						55
+#define GCC_PDM_XO4_CLK						56
+#define GCC_RX1_USB2_CLKREF_EN					57
+#define GCC_SDCC1_AHB_CLK					58
+#define GCC_SDCC1_APPS_CLK					59
+#define GCC_SDCC1_APPS_CLK_SRC					60
+#define GCC_SPMI_FETCHER_AHB_CLK				61
+#define GCC_SPMI_FETCHER_CLK					62
+#define GCC_SPMI_FETCHER_CLK_SRC				63
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				64
+#define GCC_USB30_MASTER_CLK					65
+#define GCC_USB30_MASTER_CLK_SRC				66
+#define GCC_USB30_MOCK_UTMI_CLK					67
+#define GCC_USB30_MOCK_UTMI_CLK_SRC				68
+#define GCC_USB30_MOCK_UTMI_POSTDIV_CLK_SRC			69
+#define GCC_USB30_MSTR_AXI_CLK					70
+#define GCC_USB30_SLEEP_CLK					71
+#define GCC_USB30_SLV_AHB_CLK					72
+#define GCC_USB3_PHY_AUX_CLK					73
+#define GCC_USB3_PHY_AUX_CLK_SRC				74
+#define GCC_USB3_PHY_PIPE_CLK					75
+#define GCC_USB3_PHY_PIPE_CLK_SRC				76
+#define GCC_USB3_PRIM_CLKREF_EN					77
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK				78
+#define GCC_XO_DIV4_CLK						79
+#define GCC_XO_PCIE_LINK_CLK					80
+
+/* GCC resets */
+#define GCC_BLSP1_QUP1_BCR					0
+#define GCC_BLSP1_QUP2_BCR					1
+#define GCC_BLSP1_QUP3_BCR					2
+#define GCC_BLSP1_QUP4_BCR					3
+#define GCC_BLSP1_UART1_BCR					4
+#define GCC_BLSP1_UART2_BCR					5
+#define GCC_BLSP1_UART3_BCR					6
+#define GCC_BLSP1_UART4_BCR					7
+#define GCC_PCIE_BCR						8
+#define GCC_PCIE_LINK_DOWN_BCR					9
+#define GCC_PCIE_NOCSR_COM_PHY_BCR				10
+#define GCC_PCIE_PHY_BCR					11
+#define GCC_PCIE_PHY_CFG_AHB_BCR				12
+#define GCC_PCIE_PHY_COM_BCR					13
+#define GCC_PCIE_PHY_NOCSR_COM_PHY_BCR				14
+#define GCC_PDM_BCR						15
+#define GCC_QUSB2PHY_BCR					16
+#define GCC_SDCC1_BCR						17
+#define GCC_SPMI_FETCHER_BCR					18
+#define GCC_TCSR_PCIE_BCR					19
+#define GCC_USB30_BCR						20
+#define GCC_USB3_PHY_BCR					21
+#define GCC_USB3PHY_PHY_BCR					22
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				23
+
+/* GCC power domains */
+#define USB30_GDSC                                              0
+#define PCIE_GDSC                                               1
+
+#endif
-- 
2.33.1

