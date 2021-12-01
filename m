Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9834647E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347252AbhLAH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:26:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55076 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbhLAH0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:26:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4EE8B81DDD;
        Wed,  1 Dec 2021 07:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1479BC53FCE;
        Wed,  1 Dec 2021 07:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343407;
        bh=UbqYFCpeJwG2H23Oja+6h8WnJZp2As3Z/6nK/lC/ha4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t552G696Gllnfiev4QvGjRGU+tmkBu8WJlHOuqFCZS3GBFXCVZKv/N/bxK82ZTVwo
         D7qSZiuXj3eAik95mRtjE/pW7GvAE4kIZ2iFCgpWnc5gmtZftIbP0Eoym+F+SLUsBC
         3DK1DTR/8wiL+EwvjB6erGjjs4iHa7ZdgHKH/8P7j9RyTCZ2B10YoFWpzI0MpEG0vD
         JOaxAEKccEOi4+n8Oe0g4yURMVwwsn2PYxkaLdiLq8Nk3y65GeGF08nOpds9Y7olzF
         Td1rcuz/aRFK3GnTGyRLUcRm0Gc3ng9WHeGUuCGYVc9r70gKB1YcSH+3UJ/wKDtT1I
         7RTBiDLsshGTw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: clock: Add SM8450 GCC clock bindings
Date:   Wed,  1 Dec 2021 12:53:07 +0530
Message-Id: <20211201072310.3968679-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072310.3968679-1-vkoul@kernel.org>
References: <20211201072310.3968679-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for global clock controller on SM8450 SoCs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/clock/qcom,gcc-sm8450.yaml       |  85 ++++++
 include/dt-bindings/clock/qcom,gcc-sm8450.h   | 244 ++++++++++++++++++
 2 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8450.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
new file mode 100644
index 000000000000..58d98a766de6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8450.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-sm8450.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for SM8450
+
+maintainers:
+  - Vinod Koul <vkoul@kernel.org>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on SM8450
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-sm8450.h
+
+properties:
+  compatible:
+    const: qcom,gcc-sm8450
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: PCIE 0 Pipe clock source (Optional clock)
+      - description: PCIE 1 Pipe clock source (Optional clock)
+      - description: PCIE 1 Phy Auxillary clock source (Optional clock)
+      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
+      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
+      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
+      - description: USB3 Phy wrapper pipe clock source (Optional clock)
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: sleep_clk
+      - const: pcie_0_pipe_clk # Optional clock
+      - const: pcie_1_pipe_clk # Optional clock
+      - const: pcie_1_phy_aux_clk # Optional clock
+      - const: ufs_phy_rx_symbol_0_clk # Optional clock
+      - const: ufs_phy_rx_symbol_1_clk # Optional clock
+      - const: ufs_phy_tx_symbol_0_clk # Optional clock
+      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk # Optional clock
+    minItems: 2
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
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,gcc-sm8450";
+      reg = <0x00100000 0x001f4200>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
+      clock-names = "bi_tcxo", "sleep_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,gcc-sm8450.h b/include/dt-bindings/clock/qcom,gcc-sm8450.h
new file mode 100644
index 000000000000..cf1469312c4c
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sm8450.h
@@ -0,0 +1,244 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8450_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM8450_H
+
+/* GCC HW clocks */
+#define CORE_BI_PLL_TEST_SE					0
+#define PCIE_0_PIPE_CLK						1
+#define PCIE_1_PHY_AUX_CLK					2
+#define PCIE_1_PIPE_CLK						3
+#define UFS_PHY_RX_SYMBOL_0_CLK					4
+#define UFS_PHY_RX_SYMBOL_1_CLK					5
+#define UFS_PHY_TX_SYMBOL_0_CLK					6
+#define USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK			7
+
+/* GCC clocks */
+#define GCC_AGGRE_NOC_PCIE_0_AXI_CLK				8
+#define GCC_AGGRE_NOC_PCIE_1_AXI_CLK				9
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				10
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			11
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				12
+#define GCC_ANOC_PCIE_PWRCTL_CLK				13
+#define GCC_BOOT_ROM_AHB_CLK					14
+#define GCC_CAMERA_AHB_CLK					15
+#define GCC_CAMERA_HF_AXI_CLK					16
+#define GCC_CAMERA_SF_AXI_CLK					17
+#define GCC_CAMERA_XO_CLK					18
+#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK				19
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				20
+#define GCC_CPUSS_AHB_CLK					21
+#define GCC_CPUSS_AHB_CLK_SRC					22
+#define GCC_CPUSS_AHB_POSTDIV_CLK_SRC				23
+#define GCC_CPUSS_CONFIG_NOC_SF_CLK				24
+#define GCC_DDRSS_GPU_AXI_CLK					25
+#define GCC_DDRSS_PCIE_SF_TBU_CLK				26
+#define GCC_DISP_AHB_CLK					27
+#define GCC_DISP_HF_AXI_CLK					28
+#define GCC_DISP_SF_AXI_CLK					29
+#define GCC_DISP_XO_CLK						30
+#define GCC_EUSB3_0_CLKREF_EN					31
+#define GCC_GP1_CLK						32
+#define GCC_GP1_CLK_SRC						33
+#define GCC_GP2_CLK						34
+#define GCC_GP2_CLK_SRC						35
+#define GCC_GP3_CLK						36
+#define GCC_GP3_CLK_SRC						37
+#define GCC_GPLL0						38
+#define GCC_GPLL0_OUT_EVEN					39
+#define GCC_GPLL4						40
+#define GCC_GPLL9						41
+#define GCC_GPU_CFG_AHB_CLK					42
+#define GCC_GPU_GPLL0_CLK_SRC					43
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				44
+#define GCC_GPU_MEMNOC_GFX_CLK					45
+#define GCC_GPU_SNOC_DVM_GFX_CLK				46
+#define GCC_PCIE_0_AUX_CLK					47
+#define GCC_PCIE_0_AUX_CLK_SRC					48
+#define GCC_PCIE_0_CFG_AHB_CLK					49
+#define GCC_PCIE_0_CLKREF_EN					50
+#define GCC_PCIE_0_MSTR_AXI_CLK					51
+#define GCC_PCIE_0_PHY_RCHNG_CLK				52
+#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC				53
+#define GCC_PCIE_0_PIPE_CLK					54
+#define GCC_PCIE_0_PIPE_CLK_SRC					55
+#define GCC_PCIE_0_SLV_AXI_CLK					56
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				57
+#define GCC_PCIE_1_AUX_CLK					58
+#define GCC_PCIE_1_AUX_CLK_SRC					59
+#define GCC_PCIE_1_CFG_AHB_CLK					60
+#define GCC_PCIE_1_CLKREF_EN					61
+#define GCC_PCIE_1_MSTR_AXI_CLK					62
+#define GCC_PCIE_1_PHY_AUX_CLK					63
+#define GCC_PCIE_1_PHY_AUX_CLK_SRC				64
+#define GCC_PCIE_1_PHY_RCHNG_CLK				65
+#define GCC_PCIE_1_PHY_RCHNG_CLK_SRC				66
+#define GCC_PCIE_1_PIPE_CLK					67
+#define GCC_PCIE_1_PIPE_CLK_SRC					68
+#define GCC_PCIE_1_SLV_AXI_CLK					69
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				70
+#define GCC_PDM2_CLK						71
+#define GCC_PDM2_CLK_SRC					72
+#define GCC_PDM_AHB_CLK						73
+#define GCC_PDM_XO4_CLK						74
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				75
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				76
+#define GCC_QMIP_DISP_AHB_CLK					77
+#define GCC_QMIP_GPU_AHB_CLK					78
+#define GCC_QMIP_PCIE_AHB_CLK					79
+#define GCC_QMIP_VIDEO_CV_CPU_AHB_CLK				80
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				81
+#define GCC_QMIP_VIDEO_V_CPU_AHB_CLK				82
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				83
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				84
+#define GCC_QUPV3_WRAP0_CORE_CLK				85
+#define GCC_QUPV3_WRAP0_S0_CLK					86
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				87
+#define GCC_QUPV3_WRAP0_S1_CLK					88
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				89
+#define GCC_QUPV3_WRAP0_S2_CLK					90
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				91
+#define GCC_QUPV3_WRAP0_S3_CLK					92
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				93
+#define GCC_QUPV3_WRAP0_S4_CLK					94
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				95
+#define GCC_QUPV3_WRAP0_S5_CLK					96
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				97
+#define GCC_QUPV3_WRAP0_S6_CLK					98
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				99
+#define GCC_QUPV3_WRAP0_S7_CLK					100
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC				101
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				102
+#define GCC_QUPV3_WRAP1_CORE_CLK				103
+#define GCC_QUPV3_WRAP1_S0_CLK					104
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				105
+#define GCC_QUPV3_WRAP1_S1_CLK					106
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				107
+#define GCC_QUPV3_WRAP1_S2_CLK					108
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				109
+#define GCC_QUPV3_WRAP1_S3_CLK					110
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				111
+#define GCC_QUPV3_WRAP1_S4_CLK					112
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				113
+#define GCC_QUPV3_WRAP1_S5_CLK					114
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				115
+#define GCC_QUPV3_WRAP1_S6_CLK					116
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC				117
+#define GCC_QUPV3_WRAP2_CORE_2X_CLK				118
+#define GCC_QUPV3_WRAP2_CORE_CLK				119
+#define GCC_QUPV3_WRAP2_S0_CLK					120
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				121
+#define GCC_QUPV3_WRAP2_S1_CLK					122
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				123
+#define GCC_QUPV3_WRAP2_S2_CLK					124
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				125
+#define GCC_QUPV3_WRAP2_S3_CLK					126
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				127
+#define GCC_QUPV3_WRAP2_S4_CLK					128
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				129
+#define GCC_QUPV3_WRAP2_S5_CLK					130
+#define GCC_QUPV3_WRAP2_S5_CLK_SRC				131
+#define GCC_QUPV3_WRAP2_S6_CLK					132
+#define GCC_QUPV3_WRAP2_S6_CLK_SRC				133
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				134
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				135
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				136
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				137
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				138
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				139
+#define GCC_SDCC2_AHB_CLK					140
+#define GCC_SDCC2_APPS_CLK					141
+#define GCC_SDCC2_APPS_CLK_SRC					142
+#define GCC_SDCC2_AT_CLK					143
+#define GCC_SDCC4_AHB_CLK					144
+#define GCC_SDCC4_APPS_CLK					145
+#define GCC_SDCC4_APPS_CLK_SRC					146
+#define GCC_SDCC4_AT_CLK					147
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				148
+#define GCC_UFS_0_CLKREF_EN					149
+#define GCC_UFS_PHY_AHB_CLK					150
+#define GCC_UFS_PHY_AXI_CLK					151
+#define GCC_UFS_PHY_AXI_CLK_SRC					152
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK				153
+#define GCC_UFS_PHY_ICE_CORE_CLK				154
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				155
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				156
+#define GCC_UFS_PHY_PHY_AUX_CLK					157
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				158
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				159
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				160
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC				161
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				162
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC				163
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				164
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC				165
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				166
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				167
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			168
+#define GCC_USB30_PRIM_MASTER_CLK				169
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				170
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				171
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			172
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		173
+#define GCC_USB30_PRIM_SLEEP_CLK				174
+#define GCC_USB3_0_CLKREF_EN					175
+#define GCC_USB3_PRIM_PHY_AUX_CLK				176
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				177
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				178
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				179
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				180
+#define GCC_VIDEO_AHB_CLK					181
+#define GCC_VIDEO_AXI0_CLK					182
+#define GCC_VIDEO_AXI1_CLK					183
+#define GCC_VIDEO_XO_CLK					184
+
+/* GCC resets */
+#define GCC_CAMERA_BCR						0
+#define GCC_DISPLAY_BCR						1
+#define GCC_GPU_BCR						2
+#define GCC_MMSS_BCR						3
+#define GCC_PCIE_0_BCR						4
+#define GCC_PCIE_0_LINK_DOWN_BCR				5
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				6
+#define GCC_PCIE_0_PHY_BCR					7
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			8
+#define GCC_PCIE_1_BCR						9
+#define GCC_PCIE_1_LINK_DOWN_BCR				10
+#define GCC_PCIE_1_NOCSR_COM_PHY_BCR				11
+#define GCC_PCIE_1_PHY_BCR					12
+#define GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR			13
+#define GCC_PCIE_PHY_BCR					14
+#define GCC_PCIE_PHY_CFG_AHB_BCR				15
+#define GCC_PCIE_PHY_COM_BCR					16
+#define GCC_PDM_BCR						17
+#define GCC_QUPV3_WRAPPER_0_BCR					18
+#define GCC_QUPV3_WRAPPER_1_BCR					19
+#define GCC_QUPV3_WRAPPER_2_BCR					20
+#define GCC_QUSB2PHY_PRIM_BCR					21
+#define GCC_QUSB2PHY_SEC_BCR					22
+#define GCC_SDCC2_BCR						23
+#define GCC_SDCC4_BCR						24
+#define GCC_UFS_PHY_BCR						25
+#define GCC_USB30_PRIM_BCR					26
+#define GCC_USB3_DP_PHY_PRIM_BCR				27
+#define GCC_USB3_DP_PHY_SEC_BCR					28
+#define GCC_USB3_PHY_PRIM_BCR					29
+#define GCC_USB3_PHY_SEC_BCR					30
+#define GCC_USB3PHY_PHY_PRIM_BCR				31
+#define GCC_USB3PHY_PHY_SEC_BCR					32
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				33
+#define GCC_VIDEO_AXI0_CLK_ARES					34
+#define GCC_VIDEO_AXI1_CLK_ARES					35
+#define GCC_VIDEO_BCR						36
+
+/* GCC power domains */
+#define PCIE_0_GDSC						0
+#define PCIE_1_GDSC						1
+#define UFS_PHY_GDSC						2
+#define USB30_PRIM_GDSC						3
+
+#endif
-- 
2.31.1

