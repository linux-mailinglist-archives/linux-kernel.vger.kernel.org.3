Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD747B189
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhLTQot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:44:49 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:58075 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbhLTQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:44:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1640018680; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=m4hG+W3KsyalIduYAoa4330EoexpXuiea87uLp45xNs=; b=DEKdBzlNIc97KvK+ltRFQCcOxXJkQINq0w8h8MN9rsOXf5LtLMcnSF1af+fYn+VpUM28s9Fz
 sL6xWqwdBALWdO5niFmiY4zWt/+uVC0HLooqvBKOOiZpTxe+jePlbce4108VufW2mvg9KpQ3
 bU52rZ075420EVeRIwIg9aYI1sE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61c0b2f86babcc7a03d97ac9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Dec 2021 16:44:40
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B96EC43619; Mon, 20 Dec 2021 16:44:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C224C4361C;
        Mon, 20 Dec 2021 16:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5C224C4361C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 4/5] dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280
Date:   Mon, 20 Dec 2021 22:13:57 +0530
Message-Id: <1640018638-19436-5-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640018638-19436-1-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPASS(Low Power Audio Subsystem) clock provider have a bunch of generic
properties that are needed in a device tree. Also add clock ids for
LPASS core clocks and audio clock IDs for LPASS client to request for
the clocks.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    | 169 +++++++++++++++++++++
 .../dt-bindings/clock/qcom,lpassaudiocc-sc7280.h   |  43 ++++++
 .../dt-bindings/clock/qcom,lpasscorecc-sc7280.h    |  26 ++++
 3 files changed, 238 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
 create mode 100644 include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
new file mode 100644
index 0000000..3893936
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sc7280-lpasscorecc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm LPASS Core & Audio Clock Controller Binding for SC7280
+
+maintainers:
+  - Taniya Das <tdas@codeaurora.org>
+
+description: |
+  Qualcomm LPASS core and audio clock control module which supports the
+  clocks and power domains on SC7280.
+
+  See also:
+  - dt-bindings/clock/qcom,lpasscorecc-sc7280.h
+  - dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
+
+properties:
+  clocks: true
+
+  clock-names: true
+
+  compatible:
+    enum:
+      - qcom,sc7280-lpassaoncc
+      - qcom,sc7280-lpassaudiocc
+      - qcom,sc7280-lpasscorecc
+      - qcom,sc7280-lpasshm
+
+  power-domains:
+    maxItems: 1
+
+  '#clock-cells':
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
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sc7280-lpassaudiocc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: LPASS_AON_CC_MAIN_RCG_CLK_SRC
+
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: lpass_aon_cc_main_rcg_clk_src
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-lpassaoncc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: LPASS_AON_CC_MAIN_RCG_CLK_SRC
+
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: iface
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-lpasshm
+              - qcom,sc7280-lpasscorecc
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+
+        clock-names:
+          items:
+            - const: bi_tcxo
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
+    lpass_audiocc: clock-controller@3300000 {
+      compatible = "qcom,sc7280-lpassaudiocc";
+      reg = <0x3300000 0x30000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
+      clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
+      power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
+    lpass_hm: clock-controller@3c00000 {
+      compatible = "qcom,sc7280-lpasshm";
+      reg = <0x3c00000 0x28>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+      clock-names = "bi_tcxo";
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
+    lpasscore: clock-controller@3900000 {
+      compatible = "qcom,sc7280-lpasscorecc";
+      reg = <0x3900000 0x50000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+      clock-names = "bi_tcxo";
+      power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>;
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
+    #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
+    lpass_aon: clock-controller@3380000 {
+      compatible = "qcom,sc7280-lpassaoncc";
+      reg = <0x3380000 0x30000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>, <&lpasscore LPASS_CORE_CC_CORE_CLK>;
+      clock-names = "bi_tcxo", "iface";
+      #clock-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
new file mode 100644
index 0000000..20ef2ea
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_LPASS_AUDIO_CC_SC7280_H
+#define _DT_BINDINGS_CLK_QCOM_LPASS_AUDIO_CC_SC7280_H
+
+/* LPASS_AUDIO_CC clocks */
+#define LPASS_AUDIO_CC_PLL				0
+#define LPASS_AUDIO_CC_PLL_OUT_AUX2			1
+#define LPASS_AUDIO_CC_PLL_OUT_AUX2_DIV_CLK_SRC		2
+#define LPASS_AUDIO_CC_PLL_OUT_MAIN_DIV_CLK_SRC		3
+#define LPASS_AUDIO_CC_CDIV_RX_MCLK_DIV_CLK_SRC		4
+#define LPASS_AUDIO_CC_CODEC_MEM0_CLK			5
+#define LPASS_AUDIO_CC_CODEC_MEM1_CLK			6
+#define LPASS_AUDIO_CC_CODEC_MEM2_CLK			7
+#define LPASS_AUDIO_CC_CODEC_MEM_CLK			8
+#define LPASS_AUDIO_CC_EXT_MCLK0_CLK			9
+#define LPASS_AUDIO_CC_EXT_MCLK0_CLK_SRC		10
+#define LPASS_AUDIO_CC_EXT_MCLK1_CLK			11
+#define LPASS_AUDIO_CC_EXT_MCLK1_CLK_SRC		12
+#define LPASS_AUDIO_CC_RX_MCLK_2X_CLK			13
+#define LPASS_AUDIO_CC_RX_MCLK_CLK			14
+#define LPASS_AUDIO_CC_RX_MCLK_CLK_SRC			15
+
+/* LPASS_AON_CC clocks */
+#define LPASS_AON_CC_PLL				0
+#define LPASS_AON_CC_PLL_OUT_EVEN			1
+#define LPASS_AON_CC_PLL_OUT_MAIN_CDIV_DIV_CLK_SRC	2
+#define LPASS_AON_CC_PLL_OUT_ODD			3
+#define LPASS_AON_CC_AUDIO_HM_H_CLK			4
+#define LPASS_AON_CC_CDIV_TX_MCLK_DIV_CLK_SRC		5
+#define LPASS_AON_CC_MAIN_RCG_CLK_SRC			6
+#define LPASS_AON_CC_TX_MCLK_2X_CLK			7
+#define LPASS_AON_CC_TX_MCLK_CLK			8
+#define LPASS_AON_CC_TX_MCLK_RCG_CLK_SRC		9
+#define LPASS_AON_CC_VA_MEM0_CLK			10
+
+/* LPASS_AON_CC power domains */
+#define LPASS_AON_CC_LPASS_AUDIO_HM_GDSC		0
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
new file mode 100644
index 0000000..28ed2a0
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_LPASS_CORE_CC_SC7280_H
+#define _DT_BINDINGS_CLK_QCOM_LPASS_CORE_CC_SC7280_H
+
+/* LPASS_CORE_CC clocks */
+#define LPASS_CORE_CC_DIG_PLL				0
+#define LPASS_CORE_CC_DIG_PLL_OUT_MAIN_DIV_CLK_SRC	1
+#define LPASS_CORE_CC_DIG_PLL_OUT_ODD			2
+#define LPASS_CORE_CC_CORE_CLK				3
+#define LPASS_CORE_CC_CORE_CLK_SRC			4
+#define LPASS_CORE_CC_EXT_IF0_CLK_SRC			5
+#define LPASS_CORE_CC_EXT_IF0_IBIT_CLK			6
+#define LPASS_CORE_CC_EXT_IF1_CLK_SRC			7
+#define LPASS_CORE_CC_EXT_IF1_IBIT_CLK			8
+#define LPASS_CORE_CC_LPM_CORE_CLK			9
+#define LPASS_CORE_CC_LPM_MEM0_CORE_CLK			10
+#define LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK		11
+
+/* LPASS_CORE_CC power domains */
+#define LPASS_CORE_CC_LPASS_CORE_HM_GDSC		0
+
+#endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

