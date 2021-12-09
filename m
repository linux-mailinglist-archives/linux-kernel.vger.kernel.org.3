Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3F46E9C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhLIOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:16 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:35093 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbhLIOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059400; x=1670595400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=nhu/DRtvsNP69U2TczNII5EIaKqMthBCJ+8MxNclmJ0=;
  b=evQpZirtDf9FKE17dV9GwPh0fBoziPbiX8IiDFGGRmS/LZ4hmrsEOdGi
   YRKuqGQ2adsWxzlkkuHV/fnjbukFhbEj9VZxoleFU32k2JD+87D2oQz2E
   3DhHytfdbUaMld8c3ndtufU1p4y+tv4Sljxx+I9QYAP3yAEYFIC78jtxI
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 09 Dec 2021 06:16:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:16:40 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:39 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:36 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 3/9] dt-bindings: arm: Adds CoreSight TPDM hardware definitions
Date:   Thu, 9 Dec 2021 22:15:37 +0800
Message-ID: <20211209141543.21314-4-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds new coresight-tpdm.yaml file describing the bindings required
to define tpdm in the device trees.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../bindings/arm/coresight-tpdm.yaml          | 83 +++++++++++++++++++
 .../devicetree/bindings/arm/coresight.txt     |  7 ++
 MAINTAINERS                                   |  1 +
 3 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml

diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
new file mode 100644
index 000000000000..63b0583afcfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trace, Profiling and Diagnostics Monitor - TPDM
+
+description: |
+  The TPDM or Monitor serves as data collection component for various dataset
+  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
+  Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
+  Single Bit (DSB). It performs data collection in the data producing clock
+  domain and transfers it to the data collection time domain, generally ATB
+  clock domain.
+
+  The primary use case of the TPDM is to collect data from different data
+  sources and send it to a TPDA for packetization, timestamping, and funneling.
+
+maintainers:
+  - Tao Zhang <quic_taozha@quicinc.com>
+  - Mao Jinlong <quic_jinlmao@quicinc.com>
+  - Suzuki K Poulose <suzuki.poulose@arm.com>
+  - Mathieu Poirier <mathieu.poirier@linaro.org>
+
+properties:
+  $nodename:
+    pattern: "^tpdm(@[0-9a-f]+)$"
+  compatible:
+    items:
+      - const: qcom,coresight-tpdm
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+   items:
+     - const: apb_pclk
+
+  out-ports:
+    description: |
+      Output connections from the TPDM to legacy CoreSight trace bus.
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port:
+        description: Output connection from the TPDM to legacy CoreSight
+          Trace bus.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  # minimum TPDM definition.
+  - |
+    tpdm@6980000 {
+      compatible = "qcom,coresight-tpdm", "arm,primecell";
+      reg = <0x6980000 0x1000>;
+
+      clocks = <&aoss_qmp>;
+      clock-names = "apb_pclk";
+
+      out-ports {
+        port {
+          tpdm_turing_out_funnel_turing: endpoint {
+            remote-endpoint =
+              <&funnel_turing_in_tpdm_turing>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index c68d93a35b6c..f7ce8af48574 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -52,6 +52,10 @@ its hardware characteristcs.
 			"arm,coresight-cti", "arm,primecell";
 			See coresight-cti.yaml for full CTI definitions.
 
+		- Trace, Profiling and Diagnostics Monitor (TPDM):
+			"qcom,coresight-tpdm", "arm,primecell";
+			See coresight-tpdm.yaml for full TPDM definitions.
+
 	* reg: physical base address and length of the register
 	  set(s) of the component.
 
@@ -82,6 +86,9 @@ its hardware characteristcs.
 * Required properties for Coresight Cross Trigger Interface (CTI)
 	See coresight-cti.yaml for full CTI definitions.
 
+* Required properties for Trace, Profiling and Diagnostics Monitor (TPDM)
+	See coresight-tpdm.yaml for full TPDM definitions.
+
 * Required properties for devices that don't show up on the AMBA bus, such as
   non-configurable replicators and non-configurable funnels:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 59f39b3194f6..d763ba684b99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15566,6 +15566,7 @@ M:	Jinlong Mao <quic_jinlmao@quicinc.com>
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
 F:	drivers/hwtracing/coresight/coresight-tpdm.c
 
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
-- 
2.17.1

