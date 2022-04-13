Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A94FF496
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiDMKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDMKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:20:40 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268F57150;
        Wed, 13 Apr 2022 03:18:18 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 23DA5u8O006812;
        Wed, 13 Apr 2022 18:05:57 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 13 Apr
 2022 18:17:41 +0800
From:   ryan_chen <ryan_chen@aspeedtech.com>
To:     ryan_chen <ryan_chen@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bmc-sw@aspeedtech.com>
Subject: [PATCH v2 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C driver
Date:   Wed, 13 Apr 2022 18:17:34 +0800
Message-ID: <20220413101735.27678-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413101735.27678-1-ryan_chen@aspeedtech.com>
References: <20220413101735.27678-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 23DA5u8O006812
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AST2600 support new register set for I2C controller, add bindings document
to support driver of i2c new register mode controller

Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
---
 .../bindings/i2c/aspeed,i2c-ast2600.ymal      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
new file mode 100644
index 000000000000..7c75f5bac24f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AST2600 I2C Controller on the AST26XX SoCs Device Tree Bindings
+
+maintainers:
+  - Ryan Chen <ryan_chen@aspeedtech.com>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-i2c
+
+  reg:
+    minItems: 1
+    items:
+      - description: address offset and range of bus
+      - description: address offset and range of bus buffer
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      root clock of bus, should reference the APB
+      clock in the second cell
+
+  resets:
+    maxItems: 1
+
+  bus-frequency:
+    minimum: 500
+    maximum: 2000000
+    default: 100000
+    description: frequency of the bus clock in Hz defaults to 100 kHz when not
+      specified
+
+  multi-master:
+    type: boolean
+    description:
+      states that there is another master active on this bus
+
+required:
+  - reg
+  - compatible
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    i2c_gr: i2c-global-regs@0 {
+      compatible = "aspeed,ast2600-i2c-global", "syscon";
+      reg = <0x0 0x20>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+    };
+
+    i2c0: i2c-bus@80 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #interrupt-cells = <1>;
+      compatible = "aspeed,ast2600-i2c-bus";
+      reg = <0x80 0x80>, <0xC00 0x20>;
+      clocks = <&syscon ASPEED_CLK_APB2>;
+      resets = <&syscon ASPEED_RESET_I2C>;
+      bus-frequency = <100000>;
+    };
-- 
2.17.1

