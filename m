Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D057EE64
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiGWKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbiGWKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:09:06 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6207F526;
        Sat, 23 Jul 2022 03:02:13 -0700 (PDT)
Received: from localhost.localdomain (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id E4EFB20682;
        Sat, 23 Jul 2022 12:01:41 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: clock: add SM6375 QCOM global clock bindings
Date:   Sat, 23 Jul 2022 12:01:34 +0200
Message-Id: <20220723100135.91784-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220723100135.91784-1-konrad.dybcio@somainline.org>
References: <20220723100135.91784-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for global clock controller for SM6375 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v2:
- reference qcom,gcc.yaml

 .../bindings/clock/qcom,sm6375-gcc.yaml       |  48 ++++
 include/dt-bindings/clock/qcom,sm6375-gcc.h   | 234 ++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sm6375-gcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
new file mode 100644
index 000000000000..fb1c36888d18
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gcc.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm6375-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for SM6375
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@somainline.org>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on SM6375
+
+  See also:
+  - dt-bindings/clock/qcom,sm6375-gcc.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm6375-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board XO Active-Only source
+      - description: Sleep clock source
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    clock-controller@1400000 {
+      compatible = "qcom,sm6375-gcc";
+      reg = <0x01400000 0x1f0000>;
+      clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+               <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
+               <&sleep_clk>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,sm6375-gcc.h b/include/dt-bindings/clock/qcom,sm6375-gcc.h
new file mode 100644
index 000000000000..1e9801e1cedf
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm6375-gcc.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM6375_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM6375_H
+
+/* Clocks */
+#define GPLL0						0
+#define GPLL0_OUT_EVEN					1
+#define GPLL0_OUT_ODD					2
+#define GPLL1						3
+#define GPLL10						4
+#define GPLL11						5
+#define GPLL3						6
+#define GPLL3_OUT_EVEN					7
+#define GPLL4						8
+#define GPLL5						9
+#define GPLL6						10
+#define GPLL6_OUT_EVEN					11
+#define GPLL7						12
+#define GPLL8						13
+#define GPLL8_OUT_EVEN					14
+#define GPLL9						15
+#define GPLL9_OUT_MAIN					16
+#define GCC_AHB2PHY_CSI_CLK				17
+#define GCC_AHB2PHY_USB_CLK				18
+#define GCC_BIMC_GPU_AXI_CLK				19
+#define GCC_BOOT_ROM_AHB_CLK				20
+#define GCC_CAM_THROTTLE_NRT_CLK			21
+#define GCC_CAM_THROTTLE_RT_CLK				22
+#define GCC_CAMERA_AHB_CLK				23
+#define GCC_CAMERA_XO_CLK				24
+#define GCC_CAMSS_AXI_CLK				25
+#define GCC_CAMSS_AXI_CLK_SRC				26
+#define GCC_CAMSS_CAMNOC_ATB_CLK			27
+#define GCC_CAMSS_CAMNOC_NTS_XO_CLK			28
+#define GCC_CAMSS_CCI_0_CLK				29
+#define GCC_CAMSS_CCI_0_CLK_SRC				30
+#define GCC_CAMSS_CCI_1_CLK				31
+#define GCC_CAMSS_CCI_1_CLK_SRC				32
+#define GCC_CAMSS_CPHY_0_CLK				33
+#define GCC_CAMSS_CPHY_1_CLK				34
+#define GCC_CAMSS_CPHY_2_CLK				35
+#define GCC_CAMSS_CPHY_3_CLK				36
+#define GCC_CAMSS_CSI0PHYTIMER_CLK			37
+#define GCC_CAMSS_CSI0PHYTIMER_CLK_SRC			38
+#define GCC_CAMSS_CSI1PHYTIMER_CLK			39
+#define GCC_CAMSS_CSI1PHYTIMER_CLK_SRC			40
+#define GCC_CAMSS_CSI2PHYTIMER_CLK			41
+#define GCC_CAMSS_CSI2PHYTIMER_CLK_SRC			42
+#define GCC_CAMSS_CSI3PHYTIMER_CLK			43
+#define GCC_CAMSS_CSI3PHYTIMER_CLK_SRC			44
+#define GCC_CAMSS_MCLK0_CLK				45
+#define GCC_CAMSS_MCLK0_CLK_SRC				46
+#define GCC_CAMSS_MCLK1_CLK				47
+#define GCC_CAMSS_MCLK1_CLK_SRC				48
+#define GCC_CAMSS_MCLK2_CLK				49
+#define GCC_CAMSS_MCLK2_CLK_SRC				50
+#define GCC_CAMSS_MCLK3_CLK				51
+#define GCC_CAMSS_MCLK3_CLK_SRC				52
+#define GCC_CAMSS_MCLK4_CLK				53
+#define GCC_CAMSS_MCLK4_CLK_SRC				54
+#define GCC_CAMSS_NRT_AXI_CLK				55
+#define GCC_CAMSS_OPE_AHB_CLK				56
+#define GCC_CAMSS_OPE_AHB_CLK_SRC			57
+#define GCC_CAMSS_OPE_CLK				58
+#define GCC_CAMSS_OPE_CLK_SRC				59
+#define GCC_CAMSS_RT_AXI_CLK				60
+#define GCC_CAMSS_TFE_0_CLK				61
+#define GCC_CAMSS_TFE_0_CLK_SRC				62
+#define GCC_CAMSS_TFE_0_CPHY_RX_CLK			63
+#define GCC_CAMSS_TFE_0_CSID_CLK			64
+#define GCC_CAMSS_TFE_0_CSID_CLK_SRC			65
+#define GCC_CAMSS_TFE_1_CLK				66
+#define GCC_CAMSS_TFE_1_CLK_SRC				67
+#define GCC_CAMSS_TFE_1_CPHY_RX_CLK			68
+#define GCC_CAMSS_TFE_1_CSID_CLK			69
+#define GCC_CAMSS_TFE_1_CSID_CLK_SRC			70
+#define GCC_CAMSS_TFE_2_CLK				71
+#define GCC_CAMSS_TFE_2_CLK_SRC				72
+#define GCC_CAMSS_TFE_2_CPHY_RX_CLK			73
+#define GCC_CAMSS_TFE_2_CSID_CLK			74
+#define GCC_CAMSS_TFE_2_CSID_CLK_SRC			75
+#define GCC_CAMSS_TFE_CPHY_RX_CLK_SRC			76
+#define GCC_CAMSS_TOP_AHB_CLK				77
+#define GCC_CAMSS_TOP_AHB_CLK_SRC			78
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK			79
+#define GCC_CPUSS_AHB_CLK_SRC				80
+#define GCC_CPUSS_AHB_POSTDIV_CLK_SRC			81
+#define GCC_CPUSS_GNOC_CLK				82
+#define GCC_DISP_AHB_CLK				83
+#define GCC_DISP_GPLL0_CLK_SRC				84
+#define GCC_DISP_GPLL0_DIV_CLK_SRC			85
+#define GCC_DISP_HF_AXI_CLK				86
+#define GCC_DISP_SLEEP_CLK				87
+#define GCC_DISP_THROTTLE_CORE_CLK			88
+#define GCC_DISP_XO_CLK					89
+#define GCC_GP1_CLK					90
+#define GCC_GP1_CLK_SRC					91
+#define GCC_GP2_CLK					92
+#define GCC_GP2_CLK_SRC					93
+#define GCC_GP3_CLK					94
+#define GCC_GP3_CLK_SRC					95
+#define GCC_GPU_CFG_AHB_CLK				96
+#define GCC_GPU_GPLL0_CLK_SRC				97
+#define GCC_GPU_GPLL0_DIV_CLK_SRC			98
+#define GCC_GPU_MEMNOC_GFX_CLK				99
+#define GCC_GPU_SNOC_DVM_GFX_CLK			100
+#define GCC_GPU_THROTTLE_CORE_CLK			101
+#define GCC_PDM2_CLK					102
+#define GCC_PDM2_CLK_SRC				103
+#define GCC_PDM_AHB_CLK					104
+#define GCC_PDM_XO4_CLK					105
+#define GCC_PRNG_AHB_CLK				106
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK			107
+#define GCC_QMIP_CAMERA_RT_AHB_CLK			108
+#define GCC_QMIP_DISP_AHB_CLK				109
+#define GCC_QMIP_GPU_CFG_AHB_CLK			110
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK			111
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK			112
+#define GCC_QUPV3_WRAP0_CORE_CLK			113
+#define GCC_QUPV3_WRAP0_S0_CLK				114
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC			115
+#define GCC_QUPV3_WRAP0_S1_CLK				116
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC			117
+#define GCC_QUPV3_WRAP0_S2_CLK				118
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC			119
+#define GCC_QUPV3_WRAP0_S3_CLK				120
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC			121
+#define GCC_QUPV3_WRAP0_S4_CLK				122
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC			123
+#define GCC_QUPV3_WRAP0_S5_CLK				124
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC			125
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK			126
+#define GCC_QUPV3_WRAP1_CORE_CLK			127
+#define GCC_QUPV3_WRAP1_S0_CLK				128
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC			129
+#define GCC_QUPV3_WRAP1_S1_CLK				130
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC			131
+#define GCC_QUPV3_WRAP1_S2_CLK				132
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC			133
+#define GCC_QUPV3_WRAP1_S3_CLK				134
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC			135
+#define GCC_QUPV3_WRAP1_S4_CLK				136
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC			137
+#define GCC_QUPV3_WRAP1_S5_CLK				138
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC			139
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK			140
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK			141
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK			142
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK			143
+#define GCC_RX5_PCIE_CLKREF_EN_CLK			144
+#define GCC_SDCC1_AHB_CLK				145
+#define GCC_SDCC1_APPS_CLK				146
+#define GCC_SDCC1_APPS_CLK_SRC				147
+#define GCC_SDCC1_ICE_CORE_CLK				148
+#define GCC_SDCC1_ICE_CORE_CLK_SRC			149
+#define GCC_SDCC2_AHB_CLK				150
+#define GCC_SDCC2_APPS_CLK				151
+#define GCC_SDCC2_APPS_CLK_SRC				152
+#define GCC_SYS_NOC_CPUSS_AHB_CLK			153
+#define GCC_SYS_NOC_UFS_PHY_AXI_CLK			154
+#define GCC_SYS_NOC_USB3_PRIM_AXI_CLK			155
+#define GCC_UFS_MEM_CLKREF_CLK				156
+#define GCC_UFS_PHY_AHB_CLK				157
+#define GCC_UFS_PHY_AXI_CLK				158
+#define GCC_UFS_PHY_AXI_CLK_SRC				159
+#define GCC_UFS_PHY_ICE_CORE_CLK			160
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC			161
+#define GCC_UFS_PHY_PHY_AUX_CLK				162
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC			163
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK			164
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK			165
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK			166
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC			167
+#define GCC_USB30_PRIM_MASTER_CLK			168
+#define GCC_USB30_PRIM_MASTER_CLK_SRC			169
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK			170
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC		171
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC	172
+#define GCC_USB30_PRIM_SLEEP_CLK			173
+#define GCC_USB3_PRIM_CLKREF_CLK			174
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC			175
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK			176
+#define GCC_USB3_PRIM_PHY_PIPE_CLK			177
+#define GCC_VCODEC0_AXI_CLK				178
+#define GCC_VENUS_AHB_CLK				179
+#define GCC_VENUS_CTL_AXI_CLK				180
+#define GCC_VIDEO_AHB_CLK				181
+#define GCC_VIDEO_AXI0_CLK				182
+#define GCC_VIDEO_THROTTLE_CORE_CLK			183
+#define GCC_VIDEO_VCODEC0_SYS_CLK			184
+#define GCC_VIDEO_VENUS_CLK_SRC				185
+#define GCC_VIDEO_VENUS_CTL_CLK				186
+#define GCC_VIDEO_XO_CLK				187
+
+/* Resets */
+#define GCC_CAMSS_OPE_BCR				0
+#define GCC_CAMSS_TFE_BCR				1
+#define GCC_CAMSS_TOP_BCR				2
+#define GCC_GPU_BCR					3
+#define GCC_MMSS_BCR					4
+#define GCC_PDM_BCR					5
+#define GCC_PRNG_BCR					6
+#define GCC_QUPV3_WRAPPER_0_BCR				7
+#define GCC_QUPV3_WRAPPER_1_BCR				8
+#define GCC_QUSB2PHY_PRIM_BCR				9
+#define GCC_QUSB2PHY_SEC_BCR				10
+#define GCC_SDCC1_BCR					11
+#define GCC_SDCC2_BCR					12
+#define GCC_UFS_PHY_BCR					13
+#define GCC_USB30_PRIM_BCR				14
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR			15
+#define GCC_VCODEC0_BCR					16
+#define GCC_VENUS_BCR					17
+#define GCC_VIDEO_INTERFACE_BCR				18
+#define GCC_USB3_DP_PHY_PRIM_BCR			19
+#define GCC_USB3_PHY_PRIM_SP0_BCR			20
+
+/* GDSCs */
+#define USB30_PRIM_GDSC					0
+#define UFS_PHY_GDSC					1
+#define CAMSS_TOP_GDSC					2
+#define VENUS_GDSC					3
+#define VCODEC0_GDSC					4
+#define HLOS1_VOTE_MM_SNOC_MMU_TBU_NRT_GDSC		5
+#define HLOS1_VOTE_MM_SNOC_MMU_TBU_RT_GDSC		6
+#define HLOS1_VOTE_TURING_MMU_TBU0_GDSC			7
+#define HLOS1_VOTE_TURING_MMU_TBU1_GDSC			8
+
+#endif
-- 
2.37.1

