Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8031A473F76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhLNJal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhLNJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:30:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD81C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:30:33 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id p13so17379301pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p7Abiu5YPTk6mF9OJXvuGojCIqoc3uKd3FHkRhinETw=;
        b=p8vdgF5KZqov5buBQFXcZ3oNPtizjR3s6ruseI+Ik5xx17v1dfmyaAQjSS/XSeQkO1
         RaOUAZPFgaIjjO2VWwl7Cz2cpVL6wk6K0mgOWVqM6jiYCSkJ3fMjRD3NYNCq9YrAXqrQ
         nV9pEp2Jdo+O6Oxih7+J0CqHCSMjFy8frjRe1BcyNjUBqODVh6FSc2guug/8lJa+7bLL
         DIsaJFYDmlalvmlYGT6hZNxJ0Nq52YnFJd8duu7Kh2kU62r6g7IL/0Tt4axJcFuiMvlz
         PCiAocIl8sVjCqKvMtAaTJWsnUFJWE269tlJFAIWJ+PUdc4BZfxxlx7pyq0MyjnmA5pQ
         NWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p7Abiu5YPTk6mF9OJXvuGojCIqoc3uKd3FHkRhinETw=;
        b=lPlZBYuaXJvdb+Ui0NeO1OZjKb93wxuS3bnZltQ6RjJ4lGemxegpyyy2vjnndixOBi
         qQMnG8V3+SaNuZ2HUpLtqwNhRbpLbhuUzRqX2C+ycx4WsFG8kbobEdrpyrvZokX919U+
         XgE02VosLMSMKDCQ0nyjiE95cfmYZo11driT+a9lsnx2EwD02dJz5X5VBGhbP2mLUbYK
         RJoEa0QE9aavOOAS4nzL0NLMbjDL5fRKTAlzLrtdfuXyNna2Jbfnuwu/fbTVVrP09/mo
         TADsyhu5dkgWF9tWWTqqBduD99idUT3JefjtZNVgDXs2M3SDA7ngQ4sX+Xfxkvta3xJL
         05vQ==
X-Gm-Message-State: AOAM532bG6NGzbbiRAniNOP7hJJt1PzvAFGL2YizYqCGBEeMZgpcEBcO
        +NgUowe3s1gaqux+weQZfUoH3w==
X-Google-Smtp-Source: ABdhPJxfVSB/25cJtKVzJCFaOZZPgLuUW7D0lmA8dFk7+RIGERxohCwOBEFexsYdH/nf9AGtNw9bqA==
X-Received: by 2002:a63:fc58:: with SMTP id r24mr2851921pgk.342.1639474232507;
        Tue, 14 Dec 2021 01:30:32 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c21sm15143184pfl.138.2021.12.14.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 01:30:32 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 RESEND 4/5] dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
Date:   Tue, 14 Dec 2021 17:30:10 +0800
Message-Id: <20211214093011.19775-5-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214093011.19775-1-shawn.guo@linaro.org>
References: <20211214093011.19775-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interconnect/qcom,qcm2290.yaml   | 137 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
new file mode 100644
index 000000000000..f65a2fe846de
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,qcm2290.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCM2290 Network-On-Chip interconnect
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description: |
+  The Qualcomm QCM2290 interconnect providers support adjusting the
+  bandwidth requirements between the various NoC fabrics.
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    enum:
+      - qcom,qcm2290-bimc
+      - qcom,qcm2290-cnoc
+      - qcom,qcm2290-snoc
+
+  '#interconnect-cells':
+    const: 1
+
+  clock-names:
+    items:
+      - const: bus
+      - const: bus_a
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Bus A Clock
+
+# Child node's properties
+patternProperties:
+  '^interconnect-[a-z0-9]+$':
+    type: object
+    description:
+      The interconnect providers do not have a separate QoS register space,
+      but share parent's space.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,qcm2290-qup-virt
+          - qcom,qcm2290-mmrt-virt
+          - qcom,qcm2290-mmnrt-virt
+
+      '#interconnect-cells':
+        const: 1
+
+      clock-names:
+        items:
+          - const: bus
+          - const: bus_a
+
+      clocks:
+        items:
+          - description: Bus Clock
+          - description: Bus A Clock
+
+    required:
+      - compatible
+      - '#interconnect-cells'
+      - clock-names
+      - clocks
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#interconnect-cells'
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+    snoc: interconnect@1880000 {
+        compatible = "qcom,qcm2290-snoc";
+        reg = <0x01880000 0x60200>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+                 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+
+        qup_virt: interconnect-qup {
+            compatible = "qcom,qcm2290-qup-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_QUP_CLK>,
+                     <&rpmcc RPM_SMD_QUP_A_CLK>;
+        };
+
+        mmnrt_virt: interconnect-mmnrt {
+            compatible = "qcom,qcm2290-mmnrt-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
+                     <&rpmcc RPM_SMD_MMNRT_A_CLK>;
+        };
+
+        mmrt_virt: interconnect-mmrt {
+            compatible = "qcom,qcm2290-mmrt-virt";
+            #interconnect-cells = <1>;
+            clock-names = "bus", "bus_a";
+            clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
+                     <&rpmcc RPM_SMD_MMRT_A_CLK>;
+        };
+    };
+
+    cnoc: interconnect@1900000 {
+        compatible = "qcom,qcm2290-cnoc";
+        reg = <0x01900000 0x8200>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+                 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+    };
+
+    bimc: interconnect@4480000 {
+        compatible = "qcom,qcm2290-bimc";
+        reg = <0x04480000 0x80000>;
+        #interconnect-cells = <1>;
+        clock-names = "bus", "bus_a";
+        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,qcm2290.h b/include/dt-bindings/interconnect/qcom,qcm2290.h
new file mode 100644
index 000000000000..6cbbb7fe0bd3
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qcm2290.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* QCM2290 interconnect IDs */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QCM2290_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QCM2290_H
+
+/* BIMC */
+#define MASTER_APPSS_PROC		0
+#define MASTER_SNOC_BIMC_RT		1
+#define MASTER_SNOC_BIMC_NRT		2
+#define MASTER_SNOC_BIMC		3
+#define MASTER_TCU_0			4
+#define MASTER_GFX3D			5
+#define SLAVE_EBI1			6
+#define SLAVE_BIMC_SNOC			7
+
+/* CNOC */
+#define MASTER_SNOC_CNOC		0
+#define MASTER_QDSS_DAP			1
+#define SLAVE_BIMC_CFG			2
+#define SLAVE_CAMERA_NRT_THROTTLE_CFG	3
+#define SLAVE_CAMERA_RT_THROTTLE_CFG	4
+#define SLAVE_CAMERA_CFG		5
+#define SLAVE_CLK_CTL			6
+#define SLAVE_CRYPTO_0_CFG		7
+#define SLAVE_DISPLAY_CFG		8
+#define SLAVE_DISPLAY_THROTTLE_CFG	9
+#define SLAVE_GPU_CFG			10
+#define SLAVE_HWKM			11
+#define SLAVE_IMEM_CFG			12
+#define SLAVE_IPA_CFG			13
+#define SLAVE_LPASS			14
+#define SLAVE_MESSAGE_RAM		15
+#define SLAVE_PDM			16
+#define SLAVE_PIMEM_CFG			17
+#define SLAVE_PKA_WRAPPER		18
+#define SLAVE_PMIC_ARB			19
+#define SLAVE_PRNG			20
+#define SLAVE_QDSS_CFG			21
+#define SLAVE_QM_CFG			22
+#define SLAVE_QM_MPU_CFG		23
+#define SLAVE_QPIC			24
+#define SLAVE_QUP_0			25
+#define SLAVE_SDCC_1			26
+#define SLAVE_SDCC_2			27
+#define SLAVE_SNOC_CFG			28
+#define SLAVE_TCSR			29
+#define SLAVE_USB3			30
+#define SLAVE_VENUS_CFG			31
+#define SLAVE_VENUS_THROTTLE_CFG	32
+#define SLAVE_VSENSE_CTRL_CFG		33
+#define SLAVE_SERVICE_CNOC		34
+
+/* SNOC */
+#define MASTER_CRYPTO_CORE0		0
+#define MASTER_SNOC_CFG			1
+#define MASTER_TIC			2
+#define MASTER_ANOC_SNOC		3
+#define MASTER_BIMC_SNOC		4
+#define MASTER_PIMEM			5
+#define MASTER_QDSS_BAM			6
+#define MASTER_QUP_0			7
+#define MASTER_IPA			8
+#define MASTER_QDSS_ETR			9
+#define MASTER_SDCC_1			10
+#define MASTER_SDCC_2			11
+#define MASTER_QPIC			12
+#define MASTER_USB3_0			13
+#define SLAVE_APPSS			14
+#define SLAVE_SNOC_CNOC			15
+#define SLAVE_IMEM			16
+#define SLAVE_PIMEM			17
+#define SLAVE_SNOC_BIMC			18
+#define SLAVE_SERVICE_SNOC		19
+#define SLAVE_QDSS_STM			20
+#define SLAVE_TCU			21
+#define SLAVE_ANOC_SNOC			22
+
+/* QUP Virtual */
+#define MASTER_QUP_CORE_0		0
+#define SLAVE_QUP_CORE_0		1
+
+/* MMNRT Virtual */
+#define MASTER_CAMNOC_SF		0
+#define MASTER_VIDEO_P0			1
+#define MASTER_VIDEO_PROC		2
+#define SLAVE_SNOC_BIMC_NRT		3
+
+/* MMRT Virtual */
+#define MASTER_CAMNOC_HF		0
+#define MASTER_MDP0			1
+#define SLAVE_SNOC_BIMC_RT		2
+
+#endif
-- 
2.17.1

