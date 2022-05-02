Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E0516BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383653AbiEBIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379601AbiEBIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:17:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289D3F300;
        Mon,  2 May 2022 01:14:08 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4KsG8D6dZxz4ySx;
        Mon,  2 May 2022 18:14:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsG872SpXz4x7Y;
        Mon,  2 May 2022 18:13:59 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 02/11] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
Date:   Mon,  2 May 2022 10:13:32 +0200
Message-Id: <20220502081341.203369-3-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502081341.203369-1-clg@kaod.org>
References: <20220502081341.203369-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "interrupt" property is optional because it is only necessary for
controllers supporting DMAs (Not implemented yet in the new driver).

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 .../bindings/spi/aspeed,ast2600-fmc.yaml      | 82 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
new file mode 100644
index 000000000000..42a56f3c337c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SMC controllers bindings
+
+maintainers:
+  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+  - Cédric Le Goater <clg@kaod.org>
+
+description: |
+  This binding describes the Aspeed Static Memory Controllers (FMC and
+  SPI) of the AST2400, AST2500 and AST2600 SOCs.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-fmc
+      - aspeed,ast2600-spi
+      - aspeed,ast2500-fmc
+      - aspeed,ast2500-spi
+      - aspeed,ast2400-fmc
+      - aspeed,ast2400-spi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    spi@1e620000 {
+        reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "aspeed,ast2600-fmc";
+        clocks = <&syscon ASPEED_CLK_AHB>;
+        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+
+	flash@0 {
+                reg = < 0 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+
+	flash@1 {
+                reg = < 1 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+
+	flash@2 {
+                reg = < 2 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e8c2f611766..3d74b5010cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3100,6 +3100,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 F:	drivers/mmc/host/sdhci-of-aspeed*
 
+ASPEED SMC SPI DRIVER
+M:	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+M:	Cédric Le Goater <clg@kaod.org>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
-- 
2.35.1

