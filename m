Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26C4A5A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiBAKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:52:49 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38025 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236923AbiBAKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643712765; x=1675248765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6KknDCjwM7jSQmGcvr0KGnyte9YCPrjOO1akE9YMiOA=;
  b=zKkopEP5fCxZPIKMEVgbYR70F9ysdyIwGfBkKsZMmzyeUH3X5LGSRxps
   RwD4Y4rCEZEOzF2KKaihQA8EkVU5vdh5jlwjUZixpJvkrU1ZXC80CnN6X
   PXri9VgfAyWnkreS+GP8ZgM2Ezjh6CyKJy28dcnnOniJ9GHw02HA3jcST
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Feb 2022 02:52:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 02:52:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 1 Feb 2022 02:52:43 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 1 Feb 2022 02:52:38 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <ohad@wizery.com>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>
CC:     <linux-remoteproc@vger.kernel.org>, <swboyd@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <kuabhs@chromium.org>, <quic_pillair@quicinc.com>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v10 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
Date:   Tue, 1 Feb 2022 16:22:03 +0530
Message-ID: <1643712724-12436-3-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1643712724-12436-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <pillair@codeaurora.org>

Add WPSS PIL loading support for SC7280 SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  | 219 +++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
new file mode 100644
index 0000000..2424de7
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
@@ -0,0 +1,219 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-wpss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7280 WPSS Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  This document defines the binding for a component that loads and boots firmware
+  on the Qualcomm Technology Inc. WPSS.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc7280-wpss-pil
+
+  reg:
+    maxItems: 1
+    description:
+      The base address and size of the qdsp6ss register
+
+  interrupts:
+    items:
+      - description: Watchdog interrupt
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Handover interrupt
+      - description: Stop acknowledge interrupt
+      - description: Shutdown acknowledge interrupt
+
+  interrupt-names:
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+      - const: shutdown-ack
+
+  clocks:
+    items:
+      - description: GCC WPSS AHB BDG Master clock
+      - description: GCC WPSS AHB clock
+      - description: GCC WPSS RSCP clock
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: ahb_bdg
+      - const: ahb
+      - const: rscp
+      - const: xo
+
+  power-domains:
+    items:
+      - description: CX power domain
+      - description: MX power domain
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mx
+
+  resets:
+    items:
+      - description: AOSS restart
+      - description: PDC SYNC
+
+  reset-names:
+    items:
+      - const: restart
+      - const: pdc_sync
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the reserved-memory for the Hexagon core
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      The name of the firmware which should be loaded for this remote
+      processor.
+
+  qcom,halt-regs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle reference to a syscon representing TCSR followed by the
+      three offsets within syscon for q6, modem and nc halt registers.
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the Hexagon core
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+  glink-edge:
+    type: object
+    description: |
+      Qualcomm G-Link subnode which represents communication edge, channels
+      and devices related to the ADSP.
+
+    properties:
+      interrupts:
+        items:
+          - description: IRQ from WPSS to GLINK
+
+      mboxes:
+        items:
+          - description: Mailbox for communication between APPS and WPSS
+
+      label:
+        description: The names of the state bits used for SMP2P output
+        items:
+          - const: wpss
+
+      qcom,remote-pid:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: ID of the shared memory used by GLINK for communication with WPSS
+        maxItems: 1
+
+    required:
+      - interrupts
+      - mboxes
+      - label
+      - qcom,remote-pid
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - power-domain-names
+  - resets
+  - reset-names
+  - qcom,halt-regs
+  - memory-region
+  - qcom,qmp
+  - qcom,smem-states
+  - qcom,smem-state-names
+  - glink-edge
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    #include <dt-bindings/reset/qcom,sdm845-aoss.h>
+    #include <dt-bindings/reset/qcom,sdm845-pdc.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+    remoteproc@8a00000 {
+        compatible = "qcom,sc7280-wpss-pil";
+        reg = <0x08a00000 0x10000>;
+
+        interrupts-extended = <&intc GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
+                              <&wpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&wpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&wpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&wpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+                              <&wpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover",
+                          "stop-ack", "shutdown-ack";
+
+        clocks = <&gcc GCC_WPSS_AHB_BDG_MST_CLK>,
+                 <&gcc GCC_WPSS_AHB_CLK>,
+                 <&gcc GCC_WPSS_RSCP_CLK>,
+                 <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "ahb_bdg", "ahb",
+                      "rscp", "xo";
+
+        power-domains = <&rpmhpd SC7280_CX>,
+                        <&rpmhpd SC7280_MX>;
+        power-domain-names = "cx", "mx";
+
+        memory-region = <&wpss_mem>;
+
+        qcom,qmp = <&aoss_qmp>;
+
+        qcom,smem-states = <&wpss_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        resets = <&aoss_reset AOSS_CC_WCSS_RESTART>,
+                 <&pdc_reset PDC_WPSS_SYNC_RESET>;
+        reset-names = "restart", "pdc_sync";
+
+        qcom,halt-regs = <&tcsr_mutex 0x37000>;
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_WPSS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "wpss";
+            qcom,remote-pid = <13>;
+        };
+    };
-- 
2.7.4

