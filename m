Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C92464827
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbhLAH3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347331AbhLAH3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:29:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E702C061574;
        Tue, 30 Nov 2021 23:26:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33F66B81DE1;
        Wed,  1 Dec 2021 07:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB217C53FD3;
        Wed,  1 Dec 2021 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343569;
        bh=1J5pwfTiUMMuBJ6Mwg8ExZKlUrvw41O5UUyaCOGaFOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fEscd3SPic2qODAXsNCzlTL6WWTM0ffWzrpzmWX2qSQYGdbpFzbAcycUYrxDmYjoZ
         CZL/HIVtOueXqohGR2ia/ibXdx9ecGA+QpWqClSuL+hWrUFLjCDSHWMTw1JViPWSMf
         uU9ySGs4qxSh7+2457eNGKDn2DhkaOEasrros9LnRKrLl1fg/kH/SotuUkk9l9GWqP
         U0KRMZQ3P8w30jRElo9GnjGqSEFcv6CrfLhvHHczdO5AYNmxO2r6gfQ6lJXyAnYVnT
         gxQCzOz+eHO5WdIFjwJAK74lPrvE13j5e4ee4lRKyOE6bhYBGCSLHSuPwikypb+1vm
         6TxAbOOaXn0Vw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8450 DT bindings
Date:   Wed,  1 Dec 2021 12:55:56 +0530
Message-Id: <20211201072557.3968915-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072557.3968915-1-vkoul@kernel.org>
References: <20211201072557.3968915-1-vkoul@kernel.org>
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
index 000000000000..786fce091c84
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm8450.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8450_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8450_H
+
+#define MASTER_QSPI_0				1
+#define MASTER_QUP_1				2
+#define MASTER_A1NOC_CFG			3
+#define MASTER_SDCC_4				4
+#define MASTER_UFS_MEM				5
+#define MASTER_USB3_0				6
+#define SLAVE_A1NOC_SNOC			7
+#define SLAVE_SERVICE_A1NOC			8
+
+#define	MASTER_QDSS_BAM				1
+#define	MASTER_QUP_0				2
+#define	MASTER_QUP_2				3
+#define	MASTER_A2NOC_CFG			4
+#define	MASTER_CRYPTO				5
+#define	MASTER_IPA				6
+#define	MASTER_SENSORS_PROC			7
+#define	MASTER_SP				8
+#define	MASTER_QDSS_ETR				9
+#define	MASTER_QDSS_ETR_1			10
+#define	MASTER_SDCC_2				11
+#define	SLAVE_A2NOC_SNOC			12
+#define	SLAVE_SERVICE_A2NOC			13
+
+#define MASTER_QUP_CORE_0			1
+#define MASTER_QUP_CORE_1			2
+#define MASTER_QUP_CORE_2			3
+#define SLAVE_QUP_CORE_0			4
+#define SLAVE_QUP_CORE_1			5
+#define SLAVE_QUP_CORE_2			6
+
+#define	MASTER_GEM_NOC_CNOC			1
+#define	MASTER_GEM_NOC_PCIE_SNOC		2
+#define	SLAVE_AHB2PHY_SOUTH			3
+#define	SLAVE_AHB2PHY_NORTH			4
+#define	SLAVE_AOSS			        5
+#define	SLAVE_CAMERA_CFG			6
+#define	SLAVE_CLK_CTL			        7
+#define	SLAVE_CDSP_CFG			        8
+#define	SLAVE_RBCPR_CX_CFG			9
+#define	SLAVE_RBCPR_MMCX_CFG			10
+#define	SLAVE_RBCPR_MXA_CFG			11
+#define	SLAVE_RBCPR_MXC_CFG			12
+#define	SLAVE_CRYPTO_0_CFG			13
+#define	SLAVE_CX_RDPM				14
+#define	SLAVE_DISPLAY_CFG			15
+#define	SLAVE_GFX3D_CFG			        16
+#define	SLAVE_IMEM_CFG			        17
+#define	SLAVE_IPA_CFG			        18
+#define	SLAVE_IPC_ROUTER_CFG			19
+#define	SLAVE_LPASS			        20
+#define	SLAVE_CNOC_MSS			        21
+#define	SLAVE_MX_RDPM				22
+#define	SLAVE_PCIE_0_CFG			23
+#define	SLAVE_PCIE_1_CFG			24
+#define	SLAVE_PDM				25
+#define	SLAVE_PIMEM_CFG				26
+#define	SLAVE_PRNG				27
+#define	SLAVE_QDSS_CFG				28
+#define	SLAVE_QSPI_0				29
+#define	SLAVE_QUP_0				30
+#define	SLAVE_QUP_1				31
+#define	SLAVE_QUP_2				32
+#define	SLAVE_SDCC_2				33
+#define	SLAVE_SDCC_4				34
+#define	SLAVE_SPSS_CFG				35
+#define	SLAVE_TCSR				36
+#define	SLAVE_TLMM				37
+#define	SLAVE_TME_CFG				38
+#define	SLAVE_UFS_MEM_CFG			39
+#define	SLAVE_USB3_0				40
+#define	SLAVE_VENUS_CFG				41
+#define	SLAVE_VSENSE_CTRL_CFG			42
+#define	SLAVE_A1NOC_CFG				43
+#define	SLAVE_A2NOC_CFG				44
+#define	SLAVE_DDRSS_CFG				45
+#define	SLAVE_CNOC_MNOC_CFG			46
+#define	SLAVE_PCIE_ANOC_CFG			47
+#define	SLAVE_SNOC_CFG				48
+#define	SLAVE_IMEM				49
+#define	SLAVE_PIMEM				50
+#define	SLAVE_SERVICE_CNOC			51
+#define	SLAVE_PCIE_0				52
+#define	SLAVE_PCIE_1				53
+#define	SLAVE_QDSS_STM				54
+#define	SLAVE_TCU				55
+
+#define MASTER_GPU_TCU				1
+#define MASTER_SYS_TCU				2
+#define MASTER_APPSS_PROC			3
+#define MASTER_GFX3D				4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_SNOC_GC_MEM_NOC			10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define SLAVE_GEM_NOC_CNOC			12
+#define SLAVE_LLCC				13
+#define SLAVE_MEM_NOC_PCIE_SNOC			14
+#define MASTER_MNOC_HF_MEM_NOC_DISP		15
+#define MASTER_MNOC_SF_MEM_NOC_DISP		16
+#define MASTER_ANOC_PCIE_GEM_NOC_DISP		17
+#define SLAVE_LLCC_DISP				18
+
+#define MASTER_CNOC_LPASS_AG_NOC		1
+#define MASTER_LPASS_PROC			2
+#define SLAVE_LPASS_CORE_CFG			3
+#define SLAVE_LPASS_LPI_CFG			4
+#define SLAVE_LPASS_MPU_CFG			5
+#define SLAVE_LPASS_TOP_CFG			6
+#define SLAVE_LPASS_SNOC			7
+#define SLAVE_SERVICES_LPASS_AML_NOC		8
+#define SLAVE_SERVICE_LPASS_AG_NOC		9
+
+#define MASTER_LLCC				1
+#define SLAVE_EBI1				2
+#define MASTER_LLCC_DISP			3
+#define SLAVE_EBI1_DISP				4
+
+#define MASTER_CAMNOC_HF			1
+#define MASTER_CAMNOC_ICP			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_MDP				4
+#define MASTER_CNOC_MNOC_CFG			5
+#define MASTER_ROTATOR				6
+#define MASTER_CDSP_HCP				7
+#define MASTER_VIDEO				8
+#define MASTER_VIDEO_CV_PROC			9
+#define MASTER_VIDEO_PROC			10
+#define MASTER_VIDEO_V_PROC			11
+#define SLAVE_MNOC_HF_MEM_NOC			12
+#define SLAVE_MNOC_SF_MEM_NOC			13
+#define SLAVE_SERVICE_MNOC			14
+#define MASTER_MDP_DISP				15
+#define MASTER_ROTATOR_DISP			16
+#define SLAVE_MNOC_HF_MEM_NOC_DISP		17
+#define SLAVE_MNOC_SF_MEM_NOC_DISP		18
+
+#define MASTER_CDSP_NOC_CFG			1
+#define MASTER_CDSP_PROC			2
+#define SLAVE_CDSP_MEM_NOC			3
+#define SLAVE_SERVICE_NSP_NOC			4
+
+#define MASTER_PCIE_ANOC_CFG			1
+#define MASTER_PCIE_0				2
+#define MASTER_PCIE_1				3
+#define SLAVE_ANOC_PCIE_GEM_NOC			4
+#define SLAVE_SERVICE_PCIE_ANOC			5
+
+#define MASTER_GIC_AHB				1
+#define MASTER_A1NOC_SNOC			2
+#define MASTER_A2NOC_SNOC			3
+#define MASTER_LPASS_ANOC			4
+#define MASTER_SNOC_CFG				5
+#define MASTER_PIMEM				6
+#define MASTER_GIC				7
+#define SLAVE_SNOC_GEM_NOC_GC			8
+#define SLAVE_SNOC_GEM_NOC_SF			9
+#define SLAVE_SERVICE_SNOC			10
+
+#endif
-- 
2.31.1

