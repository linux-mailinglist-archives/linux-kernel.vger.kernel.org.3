Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461FE581C42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 01:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiGZXEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 19:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiGZXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 19:03:51 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E77EE2E;
        Tue, 26 Jul 2022 16:03:50 -0700 (PDT)
Received: from droid01-xa.amlogic.com (10.88.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Wed, 27 Jul 2022
 07:03:43 +0800
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>
Subject: [PATCH v2 4/4] dt-binding: perf: Add Amlogic DDR PMU
Date:   Wed, 27 Jul 2022 07:03:29 +0800
Message-ID: <20220726230329.2844101-4-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726230329.2844101-1-jiucheng.xu@amlogic.com>
References: <20220726230329.2844101-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.88.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Amlogic G12 series DDR
performance monitor unit.

Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
Changes v1 -> v2:
  - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
  - Delete "model", "dmc_nr", "chann_nr" new properties
  - Fix compiling error
---
 .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 45 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
new file mode 100644
index 000000000000..46ef52b61492
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/amlogic,g12-ddr-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic G12 DDR performance monitor
+
+maintainers:
+  - Jiucheng Xu <jiucheng.xu@amlogic.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12b-ddr-pmu
+                amlogic,g12a-ddr-pmu
+                amlogic,sm1-ddr-pmu
+          - const: amlogic,g12-ddr-pmu
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    ddr_pmu: ddr_pmu {
+
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+        compatible = "amlogic,g12a-ddr-pmu";
+        reg = <0x0 0xff638000 0x0 0x100
+               0x0 0xff638c00 0x0 0x100>;
+        interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fd2a56a339b4..e358ee0a5c72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1055,6 +1055,7 @@ M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
 S:	Supported
 W:	http://www.amlogic.com
 F:	Documentation/admin-guide/perf/aml-ddr-pmu.rst
+F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
-- 
2.25.1

