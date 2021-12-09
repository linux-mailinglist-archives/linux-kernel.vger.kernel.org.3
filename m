Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11146E494
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhLIIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:52:39 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35596 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhLIIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:52:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D6FACE24D8;
        Thu,  9 Dec 2021 08:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA33C341CD;
        Thu,  9 Dec 2021 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639039738;
        bh=zBJhgNyeN4aAnBx7xOT/ysXcwAgmkYJoftQISRplLtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2sawxaeW6MWvYFX3MpEBtGwQiRwzMrtI4UwmphcNuJ0Qj7QBlYwsXh6X7fDA97aU
         wan0yqx8uBYWtKqGwMLQUgGwVVMI707XxIIqQ0TFYXdCHqKfoXdZVcvXa7uqThmxYR
         FlL3k7JwfJuCrbN3bMDJo/IDru8o908kLMHR3Sp896mUlMULlgdfMk9jSxoOU41sum
         agAZdwT9KHz5UHcMib9eOHVcjtTElNI2ANwObYCnOg83Rj9LVfqIo9e5ButyXUkVAr
         4tUudr/o/F3NA4HKBMjCSgfEcCh10fHf2CDSJ9s0hR+tve5p2b1+IwOuwI+OhEDWZU
         V8kjFv9YPmMVA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>, viveka@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
Date:   Thu,  9 Dec 2021 14:18:41 +0530
Message-Id: <20211209084842.189627-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209084842.189627-1-vkoul@kernel.org>
References: <20211209084842.189627-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8450 SoC has several bus fabrics that could be
controlled and tuned dynamically according to the bandwidth demand

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
 .../dt-bindings/interconnect/qcom,sm8450.h    | 171 ++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8450.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 3fd1a134162d..cbb24f9bb609 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -104,6 +104,17 @@ properties:
       - qcom,sm8350-mmss-noc
       - qcom,sm8350-compute-noc
       - qcom,sm8350-system-noc
+      - qcom,sm8450-aggre1-noc
+      - qcom,sm8450-aggre2-noc
+      - qcom,sm8450-clk-virt
+      - qcom,sm8450-config-noc
+      - qcom,sm8450-gem-noc
+      - qcom,sm8450-lpass-ag-noc
+      - qcom,sm8450-mc-virt
+      - qcom,sm8450-mmss-noc
+      - qcom,sm8450-nsp-noc
+      - qcom,sm8450-pcie-anoc
+      - qcom,sm8450-system-noc
 
   '#interconnect-cells':
     enum: [ 1, 2 ]
diff --git a/include/dt-bindings/interconnect/qcom,sm8450.h b/include/dt-bindings/interconnect/qcom,sm8450.h
new file mode 100644
index 000000000000..8f3c5e1fb4c4
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8450.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8450_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8450_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_QUP_1				1
+#define MASTER_A1NOC_CFG			2
+#define MASTER_SDCC_4				3
+#define MASTER_UFS_MEM				4
+#define MASTER_USB3_0				5
+#define SLAVE_A1NOC_SNOC			6
+#define SLAVE_SERVICE_A1NOC			7
+
+#define	MASTER_QDSS_BAM				0
+#define	MASTER_QUP_0				1
+#define	MASTER_QUP_2				2
+#define	MASTER_A2NOC_CFG			3
+#define	MASTER_CRYPTO				4
+#define	MASTER_IPA				5
+#define	MASTER_SENSORS_PROC			6
+#define	MASTER_SP				7
+#define	MASTER_QDSS_ETR				8
+#define	MASTER_QDSS_ETR_1			9
+#define	MASTER_SDCC_2				10
+#define	SLAVE_A2NOC_SNOC			11
+#define	SLAVE_SERVICE_A2NOC			12
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define SLAVE_QUP_CORE_0			3
+#define SLAVE_QUP_CORE_1			4
+#define SLAVE_QUP_CORE_2			5
+
+#define	MASTER_GEM_NOC_CNOC			0
+#define	MASTER_GEM_NOC_PCIE_SNOC		1
+#define	SLAVE_AHB2PHY_SOUTH			2
+#define	SLAVE_AHB2PHY_NORTH			3
+#define	SLAVE_AOSS			        4
+#define	SLAVE_CAMERA_CFG			5
+#define	SLAVE_CLK_CTL			        6
+#define	SLAVE_CDSP_CFG			        7
+#define	SLAVE_RBCPR_CX_CFG			8
+#define	SLAVE_RBCPR_MMCX_CFG			9
+#define	SLAVE_RBCPR_MXA_CFG			10
+#define	SLAVE_RBCPR_MXC_CFG			11
+#define	SLAVE_CRYPTO_0_CFG			12
+#define	SLAVE_CX_RDPM				13
+#define	SLAVE_DISPLAY_CFG			14
+#define	SLAVE_GFX3D_CFG			        15
+#define	SLAVE_IMEM_CFG			        16
+#define	SLAVE_IPA_CFG			        17
+#define	SLAVE_IPC_ROUTER_CFG			18
+#define	SLAVE_LPASS			        19
+#define	SLAVE_CNOC_MSS			        20
+#define	SLAVE_MX_RDPM				21
+#define	SLAVE_PCIE_0_CFG			22
+#define	SLAVE_PCIE_1_CFG			23
+#define	SLAVE_PDM				24
+#define	SLAVE_PIMEM_CFG				25
+#define	SLAVE_PRNG				26
+#define	SLAVE_QDSS_CFG				27
+#define	SLAVE_QSPI_0				28
+#define	SLAVE_QUP_0				29
+#define	SLAVE_QUP_1				30
+#define	SLAVE_QUP_2				31
+#define	SLAVE_SDCC_2				32
+#define	SLAVE_SDCC_4				33
+#define	SLAVE_SPSS_CFG				34
+#define	SLAVE_TCSR				35
+#define	SLAVE_TLMM				36
+#define	SLAVE_TME_CFG				37
+#define	SLAVE_UFS_MEM_CFG			38
+#define	SLAVE_USB3_0				39
+#define	SLAVE_VENUS_CFG				40
+#define	SLAVE_VSENSE_CTRL_CFG			41
+#define	SLAVE_A1NOC_CFG				42
+#define	SLAVE_A2NOC_CFG				43
+#define	SLAVE_DDRSS_CFG				44
+#define	SLAVE_CNOC_MNOC_CFG			45
+#define	SLAVE_PCIE_ANOC_CFG			46
+#define	SLAVE_SNOC_CFG				47
+#define	SLAVE_IMEM				48
+#define	SLAVE_PIMEM				49
+#define	SLAVE_SERVICE_CNOC			50
+#define	SLAVE_PCIE_0				51
+#define	SLAVE_PCIE_1				52
+#define	SLAVE_QDSS_STM				53
+#define	SLAVE_TCU				54
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_MSS_PROC				4
+#define MASTER_MNOC_HF_MEM_NOC			5
+#define MASTER_MNOC_SF_MEM_NOC			6
+#define MASTER_COMPUTE_NOC			7
+#define MASTER_ANOC_PCIE_GEM_NOC		8
+#define MASTER_SNOC_GC_MEM_NOC			9
+#define MASTER_SNOC_SF_MEM_NOC			10
+#define SLAVE_GEM_NOC_CNOC			11
+#define SLAVE_LLCC				12
+#define SLAVE_MEM_NOC_PCIE_SNOC			13
+#define MASTER_MNOC_HF_MEM_NOC_DISP		14
+#define MASTER_MNOC_SF_MEM_NOC_DISP		15
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		16
+#define SLAVE_LLCC_DISP				17
+
+#define MASTER_CNOC_LPASS_AG_NOC		0
+#define MASTER_LPASS_PROC			1
+#define SLAVE_LPASS_CORE_CFG			2
+#define SLAVE_LPASS_LPI_CFG			3
+#define SLAVE_LPASS_MPU_CFG			4
+#define SLAVE_LPASS_TOP_CFG			5
+#define SLAVE_LPASS_SNOC			6
+#define SLAVE_SERVICES_LPASS_AML_NOC		7
+#define SLAVE_SERVICE_LPASS_AG_NOC		8
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+#define MASTER_LLCC_DISP			2
+#define SLAVE_EBI1_DISP				3
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_ICP			1
+#define MASTER_CAMNOC_SF			2
+#define MASTER_MDP				3
+#define MASTER_CNOC_MNOC_CFG			4
+#define MASTER_ROTATOR				5
+#define MASTER_CDSP_HCP				6
+#define MASTER_VIDEO				7
+#define MASTER_VIDEO_CV_PROC			8
+#define MASTER_VIDEO_PROC			9
+#define MASTER_VIDEO_V_PROC			10
+#define SLAVE_MNOC_HF_MEM_NOC			11
+#define SLAVE_MNOC_SF_MEM_NOC			12
+#define SLAVE_SERVICE_MNOC			13
+#define MASTER_MDP_DISP				14
+#define MASTER_ROTATOR_DISP			15
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		16
+#define SLAVE_MNOC_SF_MEM_NOC_DISP		17
+
+#define MASTER_CDSP_NOC_CFG			0
+#define MASTER_CDSP_PROC			1
+#define SLAVE_CDSP_MEM_NOC			2
+#define SLAVE_SERVICE_NSP_NOC			3
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define MASTER_PCIE_1				2
+#define SLAVE_ANOC_PCIE_GEM_NOC			3
+#define SLAVE_SERVICE_PCIE_ANOC			4
+
+#define MASTER_GIC_AHB				0
+#define MASTER_A1NOC_SNOC			1
+#define MASTER_A2NOC_SNOC			2
+#define MASTER_LPASS_ANOC			3
+#define MASTER_SNOC_CFG				4
+#define MASTER_PIMEM				5
+#define MASTER_GIC				6
+#define SLAVE_SNOC_GEM_NOC_GC			7
+#define SLAVE_SNOC_GEM_NOC_SF			8
+#define SLAVE_SERVICE_SNOC			9
+
+#endif
-- 
2.31.1

