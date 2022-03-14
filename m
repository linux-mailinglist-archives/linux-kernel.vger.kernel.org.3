Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31144D7DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiCNIpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiCNIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:45:38 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364639B86;
        Mon, 14 Mar 2022 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dOoRnrMcujfIeRM6SMTH0qBYGMOdBjxcajKfKM+54Qc=; b=CO3ZwM0jHy8YSkJhJ43lUHSG3N
        GnRmA6CdQ+BHonhLoax43Zj4VhtruBfj3s/7pCzuW5h0nYkYTIg51wWthzCeLVOsWqLZAU9IbscyI
        0LfjY71jIk47EuNs6EBgDTQ+daiFLPaD7z9H7Cr5t0pOK1/+6TtjlCX6VHMblXIopRL8=;
Received: from p200300daa7204f006c015a90d6b6c4d6.dip0.t-ipconnect.de ([2003:da:a720:4f00:6c01:5a90:d6b6:c4d6] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nTgJP-0002UN-G9; Mon, 14 Mar 2022 09:44:19 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     soc@kernel.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>, Rob Herring <robh@kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/6] dt-bindings: Add en7523-scu device tree binding documentation
Date:   Mon, 14 Mar 2022 09:44:03 +0100
Message-Id: <20220314084409.84394-2-nbd@nbd.name>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314084409.84394-1-nbd@nbd.name>
References: <20220314084409.84394-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Adds device tree binding documentation for clocks in the EN7523 SOC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../bindings/clock/airoha,en7523-scu.yaml     | 58 +++++++++++++++++++
 include/dt-bindings/clock/en7523-clk.h        | 17 ++++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
 create mode 100644 include/dt-bindings/clock/en7523-clk.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
new file mode 100644
index 000000000000..d60e74654809
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/airoha,en7523-scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: EN7523 Clock Device Tree Bindings
+
+maintainers:
+  - Felix Fietkau <nbd@nbd.name>
+  - John Crispin <nbd@nbd.name>
+
+description: |
+  This node defines the System Control Unit of the EN7523 SoC,
+  a collection of registers configuring many different aspects of the SoC.
+
+  The clock driver uses it to read and configure settings of the
+  PLL controller, which provides clocks for the CPU, the bus and
+  other SoC internal peripherals.
+
+  Each clock is assigned an identifier and client nodes use this identifier
+  to specify which clock they consume.
+
+  All these identifiers can be found in:
+  [1]: <include/dt-bindings/clock/en7523-clk.h>.
+
+  The clocks are provided inside a system controller node.
+
+properties:
+  compatible:
+    items:
+      - const: airoha,en7523-scu
+
+  reg:
+    maxItems: 2
+
+  "#clock-cells":
+    description:
+      The first cell indicates the clock number, see [1] for available
+      clocks.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/en7523-clk.h>
+    scu: system-controller@1fa20000 {
+      compatible = "airoha,en7523-scu";
+      reg = <0x1fa20000 0x400>,
+            <0x1fb00000 0x1000>;
+      #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
new file mode 100644
index 000000000000..717d23a5e5ae
--- /dev/null
+++ b/include/dt-bindings/clock/en7523-clk.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_
+#define _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_
+
+#define EN7523_CLK_GSW		0
+#define EN7523_CLK_EMI		1
+#define EN7523_CLK_BUS		2
+#define EN7523_CLK_SLIC		3
+#define EN7523_CLK_SPI		4
+#define EN7523_CLK_NPU		5
+#define EN7523_CLK_CRYPTO	6
+#define EN7523_CLK_PCIE		7
+
+#define EN7523_NUM_CLOCKS	8
+
+#endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
-- 
2.35.1

