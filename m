Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881905198EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiEDH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbiEDHzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:55:50 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093618E33;
        Wed,  4 May 2022 00:52:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D3128421F5;
        Wed,  4 May 2022 07:52:09 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC cpufreq
Date:   Wed,  4 May 2022 16:51:51 +0900
Message-Id: <20220504075153.185208-3-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504075153.185208-1-marcan@marcan.st>
References: <20220504075153.185208-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding represents the cpufreq/DVFS hardware present in Apple SoCs.
The hardware has an independent controller per CPU cluster, but we
represent them as a single cpufreq node since there can only be one
systemwide cpufreq device (and since in the future, interactions with
memory controller performance states will also involve cooperation
between multiple frequency domains).

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../bindings/cpufreq/apple,soc-cpufreq.yaml   | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
new file mode 100644
index 000000000000..f398c1bd5de5
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/apple,soc-cpufreq.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/apple,soc-cpufreq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC cpufreq device
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple SoCs (e.g. M1) have a per-cpu-cluster DVFS controller that is part of
+  the cluster management register block. This binding uses the standard
+  operating-points-v2 table to define the CPU performance states, with the
+  opp-level property specifying the hardware p-state index for that level.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-soc-cpufreq
+          - apple,t6000-soc-cpufreq
+      - const: apple,soc-cpufreq
+
+  reg:
+    minItems: 1
+    maxItems: 6
+    description: One register region per CPU cluster DVFS controller
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: cluster0
+      - const: cluster1
+      - const: cluster2
+      - const: cluster3
+      - const: cluster4
+      - const: cluster5
+
+  '#freq-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - '#freq-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    // This example shows a single CPU per domain and 2 domains,
+    // with two p-states per domain.
+    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
+    cpus {
+      #address-cells = <2>;
+      #size-cells = <0>;
+
+      cpu@0 {
+        compatible = "apple,icestorm";
+        device_type = "cpu";
+        reg = <0x0 0x0>;
+        operating-points-v2 = <&ecluster_opp>;
+        apple,freq-domain = <&cpufreq_hw 0>;
+      };
+
+      cpu@10100 {
+        compatible = "apple,firestorm";
+        device_type = "cpu";
+        reg = <0x0 0x10100>;
+        operating-points-v2 = <&pcluster_opp>;
+        apple,freq-domain = <&cpufreq_hw 1>;
+      };
+    };
+
+    ecluster_opp: opp-table-0 {
+      compatible = "operating-points-v2";
+      opp-shared;
+
+      opp01 {
+        opp-hz = /bits/ 64 <600000000>;
+        opp-level = <1>;
+        clock-latency-ns = <7500>;
+      };
+      opp02 {
+        opp-hz = /bits/ 64 <972000000>;
+        opp-level = <2>;
+        clock-latency-ns = <22000>;
+      };
+    };
+
+    pcluster_opp: opp-table-1 {
+      compatible = "operating-points-v2";
+      opp-shared;
+
+      opp01 {
+        opp-hz = /bits/ 64 <600000000>;
+        opp-level = <1>;
+        clock-latency-ns = <8000>;
+      };
+      opp02 {
+        opp-hz = /bits/ 64 <828000000>;
+        opp-level = <2>;
+        clock-latency-ns = <19000>;
+      };
+    };
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      cpufreq_hw: cpufreq@210e20000 {
+        compatible = "apple,t8103-soc-cpufreq", "apple,soc-cpufreq";
+        reg = <0x2 0x10e20000 0 0x1000>,
+              <0x2 0x11e20000 0 0x1000>;
+        reg-names = "cluster0", "cluster1";
+        #freq-domain-cells = <1>;
+      };
+    };
-- 
2.35.1

