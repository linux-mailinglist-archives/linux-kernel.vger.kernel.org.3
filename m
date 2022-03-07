Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B538F4CFE1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiCGMXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiCGMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:23:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73DB80214;
        Mon,  7 Mar 2022 04:22:12 -0800 (PST)
X-UUID: fc07827f524f442a890c80ead9d36977-20220307
X-UUID: fc07827f524f442a890c80ead9d36977-20220307
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1464127879; Mon, 07 Mar 2022 20:22:07 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 7 Mar 2022 20:22:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 20:21:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 20:21:59 +0800
From:   Tim Chang <jia-wei.chang@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Subject: [PATCH 1/4] dt-bindings: cpufreq: mediatek: transform cpufreq-mediatek into yaml
Date:   Mon, 7 Mar 2022 20:21:48 +0800
Message-ID: <20220307122151.11666-2-jia-wei.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert Mediatek cpufreq devicetree binding to YAML.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
---
 .../bindings/cpufreq/cpufreq-mediatek.yaml    | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
new file mode 100644
index 000000000000..584946eb3790
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek CPUFREQ driver Device Tree Bindings
+
+maintainers:
+  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
+
+description: |
+  CPUFREQ is used for scaling clock frequency of CPUs.
+  The module cooperates with CCI DEVFREQ to manage frequency for some Mediatek
+  SoCs.
+
+properties:
+  clocks:
+    items:
+      - description:
+          The first one is the multiplexer for clock input of CPU cluster.
+      - description:
+          The other is used as an intermediate clock source when the original
+          CPU is under transition and not stable yet.
+
+  clock-names:
+    items:
+      - const: "cpu"
+      - const: "intermediate"
+
+  operating-points-v2:
+    description:
+      For details, please refer to
+      Documentation/devicetree/bindings/opp/opp-v2.yaml
+
+  opp-table: true
+
+  proc-supply:
+    description:
+      Phandle of the regulator for CPU cluster that provides the supply
+      voltage.
+
+  sram-supply:
+    description:
+      Phandle of the regulator for sram of CPU cluster that provides the supply
+      voltage. When present, the cpufreq driver needs to do "voltage tracking"
+      to step by step scale up/down Vproc and Vsram to fit SoC specific needs.
+      When absent, the voltage scaling flow is handled by hardware, hence no
+      software "voltage tracking" is needed.
+
+  "#cooling-cells":
+    description:
+      For details, please refer to
+      Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
+
+required:
+  - clocks
+  - clock-names
+  - operating-points-v2
+  - proc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    /* Example 1 (MT7623 SoC) */
+    #include <dt-bindings/clock/mt2701-clk.h>
+    cpu_opp_table: opp-table-0 {
+      compatible = "operating-points-v2";
+      opp-shared;
+      opp-598000000 {
+        opp-hz = /bits/ 64 <598000000>;
+        opp-microvolt = <1050000>;
+      };
+
+      /* ... */
+
+    };
+
+    cpus {
+      #address-cells = <2>;
+      #size-cells = <0>;
+      cpu0: cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a7";
+        reg = <0x0>;
+        clocks = <&infracfg CLK_INFRA_CPUSEL>, <&apmixedsys CLK_APMIXED_MAINPLL>;
+        clock-names = "cpu", "intermediate";
+        operating-points-v2 = <&cpu_opp_table>;
+        proc-supply = <&mt6380_vcpu_reg>;
+        #cooling-cells = <2>;
+      };
+
+      /* ... */
+
+    };
+
+  - |
+    /* Example 2 (MT8173 SoC) */
+    #include <dt-bindings/clock/mt8173-clk.h>
+    cluster1_opp: opp-table-1 {
+      compatible = "operating-points-v2";
+      opp-shared;
+      opp-507000000 {
+        opp-hz = /bits/ 64 <507000000>;
+        opp-microvolt = <828000>;
+      };
+
+      /* ... */
+
+    };
+
+    cpus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      cpu2: cpu@100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a72";
+        reg = <0x100>;
+        enable-method = "psci";
+        cpu-idle-states = <&CPU_SLEEP_0>;
+        #cooling-cells = <2>;
+        clocks = <&infracfg CLK_INFRA_CA72SEL>, <&apmixedsys CLK_APMIXED_MAINPLL>;
+        clock-names = "cpu", "intermediate";
+        operating-points-v2 = <&cluster1_opp>;
+        proc-supply = <&mt6397_vpca15_reg>;
+      };
+
+      /* ... */
+
+    };
-- 
2.18.0

