Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFED482ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiACHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:48:00 -0500
Received: from st43p00im-zteg10073501.me.com ([17.58.63.180]:57874 "EHLO
        st43p00im-zteg10073501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbiACHr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641196079; bh=2YbMTcQIr5y6YcT0ka7hcRvxxoTx5VI1wckXwfdlRH4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=ZzbLVWOEkbV/v/cLEdaCSPRjm3gYHrvRi/zZT2y+2iAyBOz+KWPPubAAFIaejRUNL
         PPtLiydzh671kqw3W2Pp2/NJQXlrXi2x1N4DHbnC7nO+ire09pcI02Tcvlebnb5Y8G
         8KSEq+OFLBAvjE3Bm/Cg4M68LhB0LHfYfwJYyM0CICXk4+5H5ZNnkjxU/RG0V0ADho
         X5n72nvhB0ApO2sTSRHGaXZbjHmHuSsd/ByGMAtW/TTe1dKL0xmr8jDwc9M3bvpPXh
         UU3RQLD0SgSY1aWE1V+Y88KETrFVA44VvELkYbPMFlKlsJxi0LcsYU8ItKKi5v1Elu
         gLExFAx93K72Q==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10073501.me.com (Postfix) with ESMTPSA id 62A4736078A;
        Mon,  3 Jan 2022 07:47:58 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH RESEND v2 1/5] dt-bindings: pci: st-pcie: PCIe controller found on STi platforms
Date:   Mon,  3 Jan 2022 08:47:27 +0100
Message-Id: <20220103074731.3651-2-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103074731.3651-1-avolmat@me.com>
References: <20220103074731.3651-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-03_02:2022-01-01,2022-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201030052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addition of the bindings for the Designware based PCIe controller
that can be found on STi platforms such as STiH407, STiH410 or STiH418.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 .../devicetree/bindings/pci/st,st-pcie.yaml   | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st,st-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 9ed0dfba7f89..3a92078128f7 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 5
     items:
       enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
-              ulreg, smu, mpu, apb, phy ]
+              ulreg, smu, mpu, apb, phy, mem-window ]
 
   num-lanes:
     description: |
diff --git a/Documentation/devicetree/bindings/pci/st,st-pcie.yaml b/Documentation/devicetree/bindings/pci/st,st-pcie.yaml
new file mode 100644
index 000000000000..2fa686d573c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,st-pcie.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,st-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe RC controller on ST STi platform
+
+maintainers:
+  - Alain Volmat <avolmat@me.com>
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: st,stih407-pcie
+
+  reg:
+    items:
+      - description: Controller control and status registers.
+      - description: PCIe configuration registers.
+      - description: Memory made available to the controller
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: mem-window
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+    - description: Controller reset
+    - description: Powerdown reset (optional)
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: softreset
+      - const: powerdown
+    minItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie
+
+  reset-gpios: true
+
+  st,syscfg:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: syscfg node phandle and offsets of the 2 registers
+                 controlling root complex and ltssm.
+
+required:
+  - interrupts
+  - '#interrupt-cells'
+  - interrupt-map
+  - interrupt-map-mask
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/reset/stih407-resets.h>
+    pcie1: pcie@9b10000 {
+      compatible = "st,stih407-pcie";
+      device_type = "pci";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      reg = <0x09b10000 0x1000>,
+            <0x3fff0000 0x10000>,
+            <0x40000000 0xc0000000>;
+      reg-names = "dbi", "config", "mem-window";
+
+      #interrupt-cells = <1>;
+      interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "msi";
+      interrupt-map-mask = <0 0 0 7>;
+      interrupt-map = <0 0 0 1 &intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 2 &intc GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 3 &intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 4 &intc GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+      st,syscfg = <&syscfg_core 0xdc 0xe4>;
+
+      ranges = <0x82000000 0 0x30000000 0x30000000 0 0x05550000>, /* non-prefetchable memory */
+               <0xc2000000 0 0x35550000 0x35550000 0 0x0AAA0000>; /* prefetchable memory */
+      bus-range = <0x00 0xff>;
+
+      resets = <&softreset STIH407_PCIE1_SOFTRESET>,
+               <&powerdown STIH407_PCIE1_POWERDOWN>;
+
+      reset-names = "softreset", "powerdown";
+
+      phys = <&phy_port1 PHY_TYPE_PCIE>;
+      phy-names = "pcie";
+
+      reset-gpios = <&pio34 5 GPIO_ACTIVE_LOW>;
+    };
-- 
2.25.1

