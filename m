Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45AC52E5DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244415AbiETHFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346501AbiETHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:04:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941CA1632AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq17so13918088ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jfNyVwUF1+P8dTurv6gNDME2b5kyZbxmMIy3awLSjto=;
        b=a8WhdtG5vl1SACkxAONcGdxKvjQkWDYwR6VcAGPV4XbgnYmI2XFHqTblPEquy+TrRz
         /FhsG4sXNVnpRFNeZmL48sBNGF2A6wnfdkof3agoMXS7kRBcV6ripQyLQ/rtYIL2gpMC
         ymtde16M9/3B2UTN1+HWsVDqSvLpbXqp28cGweiP0+8sTtl+giinUQfFEX/tfLYVWQ8N
         oHd9tO+bog69V9E9tbat678ACW3TOSYG5odGEFCbHiLg3nlfgCxv8ug+6foDVwWFOzK5
         d+D/xfFGxD9DNsmBxZHC9lQ585PyVfCfDtz5PueGtSVf2O0OZBsWo0IaoOHvMkjUquOP
         TkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jfNyVwUF1+P8dTurv6gNDME2b5kyZbxmMIy3awLSjto=;
        b=X2AO29+miKUg/a3p3u+1e8dlU2/teepaRIO5qeh9cJKrxijCEDzTEeNisgj1YOSXIm
         N365lbV2zeB9o48XLyaRUW/+hV0nNln6sJ9pRsGofknxuhLZao1uSP9Bn5DIXCeL5W5c
         +7CSc+d0UFghlIf45ydqSNsyU5/nn8vX5Ww+XmQewHQ22QbWRhjYJkf38n4slMEwqvif
         ZBy6wJeDU/Ky/RBeobksAJq5YJbOSyi/8R28qTCN+ma8P716JfvhgcKq44j9ErPnuXS5
         yk/Hcli+asozHYx1EV2Nr8EdSiFoxhMRe2BykM9UV/KdJoUxIh9g0CPDOIQaK7qSi2FX
         Hd5A==
X-Gm-Message-State: AOAM532TWnMTWSXJE+awDLUo9suMT/SkD63xQ5DtVab/vImF+zVDPXR6
        7DYjOkYg7g99uDfCqeYF3trhhg==
X-Google-Smtp-Source: ABdhPJxjimWMeCRLKNBVw/i4Pt/dk/qVTbzMPo3CrfLKShvrMrkjS5sM8s028ZthjSj93O5aMteoCA==
X-Received: by 2002:a17:907:3f95:b0:6f4:f45a:9f66 with SMTP id hr21-20020a1709073f9500b006f4f45a9f66mr7302277ejc.544.1653030260094;
        Fri, 20 May 2022 00:04:20 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id md17-20020a170906ae9100b006feaf472637sm336092ejb.53.2022.05.20.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 00:04:19 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: interconnect: Add Qualcomm SM6350 NoC support
Date:   Fri, 20 May 2022 09:03:14 +0200
Message-Id: <20220520070318.48521-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520070318.48521-1-luca.weiss@fairphone.com>
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices.

As SM6350 has two pairs of NoCs sharing the same reg, allow this in the
binding documentation, as was done for qcm2290.

Because the main qcom,rpmh.yaml file is getting too complicated for our
use cases, create a new qcom,rpmh-common.yaml and a separate
qcom,sm6350-rpmh.yaml that defines our new bindings.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v1:
* Split sm6350 into separate yaml with new rpmh-common.yaml

 .../interconnect/qcom,rpmh-common.yaml        |  41 +++++
 .../interconnect/qcom,sm6350-rpmh.yaml        |  82 ++++++++++
 .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
new file mode 100644
index 000000000000..6121eea3e87d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+  - Odelu Kukatla <okukatla@codeaurora.org>
+
+description: |
+   RPMh interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
+
+properties:
+  '#interconnect-cells':
+    enum: [ 1, 2 ]
+
+  qcom,bcm-voters:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+    description: |
+      List of phandles to qcom,bcm-voter nodes that are required by
+      this interconnect to send RPMh commands.
+
+  qcom,bcm-voter-names:
+    description: |
+      Names for each of the qcom,bcm-voters specified.
+
+required:
+  - '#interconnect-cells'
+  - qcom,bcm-voters
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
new file mode 100644
index 000000000000..89fe17c31b8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sm6350-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6350 RPMh Network-On-Chip Interconnect
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description: |
+  Qualcomm RPMh-based interconnect provider on SM6350.
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm6350-aggre1-noc
+      - qcom,sm6350-aggre2-noc
+      - qcom,sm6350-config-noc
+      - qcom,sm6350-dc-noc
+      - qcom,sm6350-gem-noc
+      - qcom,sm6350-mmss-noc
+      - qcom,sm6350-npu-noc
+      - qcom,sm6350-system-noc
+
+  reg:
+    maxItems: 1
+
+  '#interconnect-cells': true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+    $ref: qcom,rpmh-common.yaml#
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm6350-clk-virt
+          - qcom,sm6350-compute-noc
+
+      '#interconnect-cells': true
+
+    required:
+      - compatible
+
+    unevaluatedProperties: false
+
+examples:
+  - |
+    config_noc: interconnect@1500000 {
+        compatible = "qcom,sm6350-config-noc";
+        reg = <0x01500000 0x28000>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    system_noc: interconnect@1620000 {
+        compatible = "qcom,sm6350-system-noc";
+        reg = <0x01620000 0x17080>;
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+
+        clk_virt: interconnect-clk-virt {
+            compatible = "qcom,sm6350-clk-virt";
+            #interconnect-cells = <2>;
+            qcom,bcm-voters = <&apps_bcm_voter>;
+        };
+    };
diff --git a/include/dt-bindings/interconnect/qcom,sm6350.h b/include/dt-bindings/interconnect/qcom,sm6350.h
new file mode 100644
index 000000000000..e662cede9aaa
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm6350.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Qualcomm SM6350 interconnect IDs
+ *
+ * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM6350_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SM6350_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_QUP_0			1
+#define MASTER_EMMC			2
+#define MASTER_UFS_MEM			3
+#define A1NOC_SNOC_SLV			4
+#define SLAVE_SERVICE_A1NOC		5
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_QUP_1			2
+#define MASTER_CRYPTO_CORE_0		3
+#define MASTER_IPA			4
+#define MASTER_QDSS_ETR			5
+#define MASTER_SDCC_2			6
+#define MASTER_USB3			7
+#define A2NOC_SNOC_SLV			8
+#define SLAVE_SERVICE_A2NOC		9
+
+#define MASTER_CAMNOC_HF0_UNCOMP	0
+#define MASTER_CAMNOC_ICP_UNCOMP	1
+#define MASTER_CAMNOC_SF_UNCOMP		2
+#define MASTER_QUP_CORE_0		3
+#define MASTER_QUP_CORE_1		4
+#define MASTER_LLCC			5
+#define SLAVE_CAMNOC_UNCOMP		6
+#define SLAVE_QUP_CORE_0		7
+#define SLAVE_QUP_CORE_1		8
+#define SLAVE_EBI_CH0			9
+
+#define MASTER_NPU			0
+#define MASTER_NPU_PROC			1
+#define SLAVE_CDSP_GEM_NOC		2
+
+#define SNOC_CNOC_MAS			0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_A1NOC_CFG			2
+#define SLAVE_A2NOC_CFG			3
+#define SLAVE_AHB2PHY			4
+#define SLAVE_AHB2PHY_2			5
+#define SLAVE_AOSS			6
+#define SLAVE_BOOT_ROM			7
+#define SLAVE_CAMERA_CFG		8
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG	9
+#define SLAVE_CAMERA_RT_THROTTLE_CFG	10
+#define SLAVE_CLK_CTL			11
+#define SLAVE_RBCPR_CX_CFG		12
+#define SLAVE_RBCPR_MX_CFG		13
+#define SLAVE_CRYPTO_0_CFG		14
+#define SLAVE_DCC_CFG			15
+#define SLAVE_CNOC_DDRSS		16
+#define SLAVE_DISPLAY_CFG		17
+#define SLAVE_DISPLAY_THROTTLE_CFG	18
+#define SLAVE_EMMC_CFG			19
+#define SLAVE_GLM			20
+#define SLAVE_GRAPHICS_3D_CFG		21
+#define SLAVE_IMEM_CFG			22
+#define SLAVE_IPA_CFG			23
+#define SLAVE_CNOC_MNOC_CFG		24
+#define SLAVE_CNOC_MSS			25
+#define SLAVE_NPU_CFG			26
+#define SLAVE_PDM			27
+#define SLAVE_PIMEM_CFG			28
+#define SLAVE_PRNG			29
+#define SLAVE_QDSS_CFG			30
+#define SLAVE_QM_CFG			31
+#define SLAVE_QM_MPU_CFG		32
+#define SLAVE_QUP_0			33
+#define SLAVE_QUP_1			34
+#define SLAVE_SDCC_2			35
+#define SLAVE_SECURITY			36
+#define SLAVE_SNOC_CFG			37
+#define SLAVE_TCSR			38
+#define SLAVE_UFS_MEM_CFG		39
+#define SLAVE_USB3			40
+#define SLAVE_VENUS_CFG			41
+#define SLAVE_VENUS_THROTTLE_CFG	42
+#define SLAVE_VSENSE_CTRL_CFG		43
+#define SLAVE_SERVICE_CNOC		44
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_GEM_NOC_CFG		1
+#define SLAVE_LLCC_CFG			2
+
+#define MASTER_AMPSS_M0			0
+#define MASTER_SYS_TCU			1
+#define MASTER_GEM_NOC_CFG		2
+#define MASTER_COMPUTE_NOC		3
+#define MASTER_MNOC_HF_MEM_NOC		4
+#define MASTER_MNOC_SF_MEM_NOC		5
+#define MASTER_SNOC_GC_MEM_NOC		6
+#define MASTER_SNOC_SF_MEM_NOC		7
+#define MASTER_GRAPHICS_3D		8
+#define SLAVE_MCDMA_MS_MPU_CFG		9
+#define SLAVE_MSS_PROC_MS_MPU_CFG	10
+#define SLAVE_GEM_NOC_SNOC		11
+#define SLAVE_LLCC			12
+#define SLAVE_SERVICE_GEM_NOC		13
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_VIDEO_P0			1
+#define MASTER_VIDEO_PROC		2
+#define MASTER_CAMNOC_HF		3
+#define MASTER_CAMNOC_ICP		4
+#define MASTER_CAMNOC_SF		5
+#define MASTER_MDP_PORT0		6
+#define SLAVE_MNOC_HF_MEM_NOC		7
+#define SLAVE_MNOC_SF_MEM_NOC		8
+#define SLAVE_SERVICE_MNOC		9
+
+#define MASTER_NPU_SYS			0
+#define MASTER_NPU_NOC_CFG		1
+#define SLAVE_NPU_CAL_DP0		2
+#define SLAVE_NPU_CP			3
+#define SLAVE_NPU_INT_DMA_BWMON_CFG	4
+#define SLAVE_NPU_DPM			5
+#define SLAVE_ISENSE_CFG		6
+#define SLAVE_NPU_LLM_CFG		7
+#define SLAVE_NPU_TCM			8
+#define SLAVE_NPU_COMPUTE_NOC		9
+#define SLAVE_SERVICE_NPU_NOC		10
+
+#define MASTER_SNOC_CFG			0
+#define A1NOC_SNOC_MAS			1
+#define A2NOC_SNOC_MAS			2
+#define MASTER_GEM_NOC_SNOC		3
+#define MASTER_PIMEM			4
+#define MASTER_GIC			5
+#define SLAVE_APPSS			6
+#define SNOC_CNOC_SLV			7
+#define SLAVE_SNOC_GEM_NOC_GC		8
+#define SLAVE_SNOC_GEM_NOC_SF		9
+#define SLAVE_OCIMEM			10
+#define SLAVE_PIMEM			11
+#define SLAVE_SERVICE_SNOC		12
+#define SLAVE_QDSS_STM			13
+#define SLAVE_TCU			14
+
+#endif
-- 
2.36.1

