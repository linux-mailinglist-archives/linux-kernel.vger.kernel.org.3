Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BD53E309
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiFFGvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFFGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:50:49 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6F13DE0;
        Sun,  5 Jun 2022 23:50:47 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2566YucU035313;
        Mon, 6 Jun 2022 14:34:57 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 6 Jun
 2022 14:49:41 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 4/5] dt-bindings: crypto: add documentation for aspeed hace
Date:   Mon, 6 Jun 2022 14:49:34 +0800
Message-ID: <20220606064935.1458903-5-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2566YucU035313
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding documentation for the Aspeed Hash
and Crypto Engines (HACE) Controller.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
---
 .../bindings/crypto/aspeed,ast2500-hace.yaml  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml

diff --git a/Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml b/Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
new file mode 100644
index 000000000000..a772d232de09
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/aspeed,ast2500-hace.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED HACE hash and crypto Hardware Accelerator Engines
+
+maintainers:
+  - Neal Liu <neal_liu@aspeedtech.com>
+
+description: |
+  The Hash and Crypto Engine (HACE) is designed to accelerate the throughput
+  of hash data digest, encryption, and decryption. Basically, HACE can be
+  divided into two independently engines - Hash Engine and Crypto Engine.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2500-hace
+      - aspeed,ast2600-hace
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    hace: crypto@1e6d0000 {
+        compatible = "aspeed,ast2600-hace";
+        reg = <0x1e6d0000 0x200>;
+        interrupts = <4>;
+        clocks = <&syscon ASPEED_CLK_GATE_YCLK>;
+        resets = <&syscon ASPEED_RESET_HACE>;
+    };
-- 
2.25.1

