Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9EF467685
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380492AbhLCLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbhLCLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:37:08 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542EC06173E;
        Fri,  3 Dec 2021 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=S3Tw/8Fei/1i+bTG4/JHPJIzBoM/42mdFCJiUaqrlEk=; b=JNJRcWx8B+6Y2uXfXXuJAYvP2U
        hvTqRmdC+GW12dYo73eDmMLR6E9gb6H1MqTx5SG4Ip0GAcpBKfR1nLK8HmzioIR6iC75YIucFABvM
        scwil74Qcoodj6qb+fhavYrfoelTmLBiv5L4JcICxZHM7mUK0PGWssav/ItoV1puTLmc=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt6ot-0004Ez-Fa; Fri, 03 Dec 2021 12:33:39 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/14] dt-bindings: Add en7523-scu device tree binding documentation
Date:   Fri,  3 Dec 2021 12:33:23 +0100
Message-Id: <20211203113331.20510-7-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203113331.20510-1-nbd@nbd.name>
References: <20211203113331.20510-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

Adds device tree binding documentation for clocks in the EN7523 SOC.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 .../bindings/clock/airoha,en7523-scu.yaml     | 58 +++++++++++++++++++
 include/dt-bindings/clock/en7523-clk.h        | 17 ++++++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
 create mode 100644 include/dt-bindings/clock/en7523-clk.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
new file mode 100644
index 000000000000..79660f8126fa
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
+    scu: scu@1fa20000 {
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
2.30.1

