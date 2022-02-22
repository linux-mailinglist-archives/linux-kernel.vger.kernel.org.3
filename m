Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632254BF538
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiBVJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBVJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:57:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF91939D2;
        Tue, 22 Feb 2022 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645523821; x=1677059821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/GITfRJ7JyzGVGyk49QBHGKWpMw2L1MuwYMc4NlmBf8=;
  b=kb29jcji9Deq7S+S8mb5K+aF3rXJv4PdkBA9h1jRwn/yJBMnrkUcMFtS
   gOgVyn+0KwEybHMCKtpMhUnk6pqxSaz/OKRYZkXxrU3u6jlbT1n8Ixlsz
   ISjrTkFKqvzToOB0YLZS7vKp9YgwB69eP9UNhqkCqsDzzlwV1jxISV7/V
   ACo5ntp7P8yfHJoql1CSfChncpdr1nOAn2LZFT7HxoZKeQhlffyO9xWkm
   BX4YRp6XWPIXFcHtchT5X26VV/WdgizOOrL7LyJD0IoBb15gCNjlGQoG4
   hAKgTXV6a4yzDc6NgZ/Ff+gtHZxJUS0vc4SPlwIe0jS3dyyZ1pBB/Hztv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="250478890"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250478890"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 01:57:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="591248144"
Received: from gio-01395267462.iind.intel.com ([10.49.4.124])
  by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2022 01:56:58 -0800
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
Date:   Tue, 22 Feb 2022 15:26:53 +0530
Message-Id: <20220222095654.9097-2-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222095654.9097-1-shruthi.sanil@intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

Add Device Tree bindings for the Timer IP, which can be used as
clocksource and clockevent device in the Intel Keem Bay SoC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 .../bindings/timer/intel,keembay-timer.yaml   | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
new file mode 100644
index 000000000000..9e6d46ecc2dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/intel,keembay-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay SoC Timers
+
+maintainers:
+  - Shruthi Sanil <shruthi.sanil@intel.com>
+
+description: |
+  The Intel Keem Bay timer driver supports 1 free running counter and 8 timers.
+  Each timer is capable of generating inividual interrupt.
+  Both the features are enabled through the timer general config register.
+
+  The parent node represents the common general configuration details and
+  the child nodes represents the counter and timers.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - intel,keembay-gpt-creg
+          - const: simple-mfd
+
+  reg:
+    description: General configuration register address and length.
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^counter@[0-9a-f]+$":
+    description: Properties for Intel Keem Bay counter.
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - enum:
+                  - intel,keembay-counter
+
+      reg:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - clocks
+
+  "^timer@[0-9a-f]+$":
+    description: Properties for Intel Keem Bay timer
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - enum:
+                  - intel,keembay-timer
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #define KEEM_BAY_A53_TIM
+
+    soc {
+        #address-cells = <0x2>;
+        #size-cells = <0x2>;
+
+        gpt@20331000 {
+            compatible = "intel,keembay-gpt-creg", "simple-mfd";
+            reg = <0x0 0x20331000 0x0 0xc>;
+            ranges = <0x0 0x0 0x20330000 0xF0>;
+            #address-cells = <0x1>;
+            #size-cells = <0x1>;
+
+            counter@e8 {
+                compatible = "intel,keembay-counter";
+                reg = <0xe8 0x8>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+
+            timer@30 {
+                compatible = "intel,keembay-timer";
+                reg = <0x30 0xc>;
+                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
+            };
+        };
+    };
+
+...
-- 
2.17.1

