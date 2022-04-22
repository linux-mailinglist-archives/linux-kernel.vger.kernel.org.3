Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F182F50BA72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448817AbiDVOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448802AbiDVOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:45:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14A5BE58
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:42:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so10704209edw.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHDysFmH1PXQCs0a6Ih6c9304t8zKZ6Uhw6DIQ5pdoI=;
        b=GHd/DCnJCv6AqUlh5rK15JSWfWYDlaAZQ6XO1xHQyYnoOTmj4esjL8lbgQCwDPmBA/
         3qz66CbIAYSlSipQ9Sr6xMsOvBvImt/2ak3VtGLxu/ksk4S1Q8JfmJQEC0blof/v51fk
         E04qQVcgYGCAmyadDw7BzJfZCk/EbjhDHMFApZt3MZtvi/VQHh72OWwyIvASk+j+yvCj
         1hSjOkyip8PZkoqIWidi9NkxkaEbB1x4BmCvUy2DrSiul02Os6ifXWfW+Ikdt2LYq/Cx
         6F3CjQGG9+CAmxptFfvCtiQSOOOoicx8T8x6T3uuytHNORHIsG7Odgs4D6Nzc4ubyMNY
         MzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHDysFmH1PXQCs0a6Ih6c9304t8zKZ6Uhw6DIQ5pdoI=;
        b=IFH6Z24qjLL5WRe8XVX5t/S1ZB7n02UVKNzp0LOU30e8i+D9T81wYlYHLi1wJHf9Uu
         f0uJHcmAQB+oOd8IJXG9ea1xr5Ma1kqrTr6IyjQRvjsvjdr2BT3F667VKI+FS4eb5wAx
         bEnrVfDdLCQy8SGY3CD1oBVPM/rnDES/8W7qCZKrerqCMBt+t7eK6pR/moCOBZsnk4Ly
         ETAMd4ADaF1Lt/sfX6fA6Ao4Mq0e2547/SVUYwFqbGgTtQ3LI0P2Tv8w9KpjEpfo/Ofo
         Upkd3BSTneIHZsWTd7ctVYWkRQIXXWDrFPAQN5s+Ik65yD2MD2/fPHO644IIWvVPyDNg
         H56g==
X-Gm-Message-State: AOAM531zA1M/V39IcuD0TTeUKYHKQica0Pa8+n191Zwubpq2xzy6x2mf
        6jKuWlIDCVjGFDZ41ndWMYVhFw==
X-Google-Smtp-Source: ABdhPJycGrNpVp/ktokoDWc0tcwsB6oYlCmJyoNS9fInHZ4YH0+jD+LQxv1ehU+hb3EdptXcHt2RfQ==
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id f1-20020a056402194100b00413282209c8mr5239472edz.13.1650638525169;
        Fri, 22 Apr 2022 07:42:05 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm818202ejc.176.2022.04.22.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:42:04 -0700 (PDT)
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
Subject: [PATCH 2/4] dt-bindings: interconnect: Add Qualcomm SM6350 NoC support
Date:   Fri, 22 Apr 2022 16:40:18 +0200
Message-Id: <20220422144021.232993-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220422144021.232993-1-luca.weiss@fairphone.com>
References: <20220422144021.232993-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices.

As SM6350 has two pairs of NoCs sharing the same reg, allow this in the
binding documentation, as was done for qcm2290.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  44 ++++++
 .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 5a911be0c2ea..797107212a42 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -72,6 +72,14 @@ properties:
       - qcom,sdx55-mc-virt
       - qcom,sdx55-mem-noc
       - qcom,sdx55-system-noc
+      - qcom,sm6350-aggre1-noc
+      - qcom,sm6350-aggre2-noc
+      - qcom,sm6350-config-noc
+      - qcom,sm6350-dc-noc
+      - qcom,sm6350-gem-noc
+      - qcom,sm6350-mmss-noc
+      - qcom,sm6350-npu-noc
+      - qcom,sm6350-system-noc
       - qcom,sm8150-aggre1-noc
       - qcom,sm8150-aggre2-noc
       - qcom,sm8150-camnoc-noc
@@ -131,6 +139,42 @@ properties:
     description: |
       Names for each of the qcom,bcm-voters specified.
 
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9\-]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,sm6350-clk-virt
+          - qcom,sm6350-compute-noc
+
+      '#interconnect-cells':
+        const: 1
+
+      qcom,bcm-voters:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          maxItems: 1
+        description: |
+          List of phandles to qcom,bcm-voter nodes that are required by
+          this interconnect to send RPMh commands.
+
+      qcom,bcm-voter-names:
+        description: |
+          Names for each of the qcom,bcm-voters specified.
+
+    required:
+      - compatible
+      - '#interconnect-cells'
+      - qcom,bcm-voters
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
diff --git a/include/dt-bindings/interconnect/qcom,sm6350.h b/include/dt-bindings/interconnect/qcom,sm6350.h
new file mode 100644
index 000000000000..c6eab5b42858
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sm6350.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.36.0

