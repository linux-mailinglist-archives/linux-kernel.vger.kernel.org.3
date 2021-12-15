Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9E4755BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbhLOKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:04:15 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:39228 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbhLOKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:04:06 -0500
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1D478FDFD6;
        Wed, 15 Dec 2021 17:57:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18835T140477477144320S1639562220094025_;
        Wed, 15 Dec 2021 17:57:11 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 15
X-LOCAL-RCPT-COUNT: 3
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <7e09a493426c9099737eb22075673646>
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v5 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Wed, 15 Dec 2021 17:56:55 +0800
Message-Id: <20211215095657.13183-3-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215095657.13183-1-yifeng.zhao@rock-chips.com>
References: <20211215095657.13183-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible strings for the Naneng combo PHY found on rockchip SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changes in v5:
- modify description for ssc and ext-refclk
- remove apb reset

Changes in v4:
- restyle
- remove some minItems
- add more properties
- remove reset-names
- move #phy-cells
- add rockchip,rk3568-pipe-grf
- add rockchip,rk3568-pipe-phy-grf

Changes in v3: None
Changes in v2:
- Fix dtschema/dtc warnings/errors

 .../phy/phy-rockchip-naneng-combphy.yaml      | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
new file mode 100644
index 000000000000..6b2db5e39f76
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-combphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC Naneng Combo Phy Device Tree Bindings
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-naneng-combphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: reference clock
+      - description: apb clock
+      - description: pipe clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: apb
+      - const: pipe
+
+  resets:
+    items:
+      - description: exclusive PHY reset line
+
+  rockchip,dis-u3otg0-port:
+    type: boolean
+    description:
+      Disable the u3otg0 port.
+
+  rockchip,dis-u3otg1-port:
+    type: boolean
+    description:
+      Disable the u3otg1 port.
+
+  rockchip,enable-ssc:
+    type: boolean
+    description:
+      The option SSC can be enabled for U3, SATA and PCIE.
+      Most commercially available platforms use SSC to reduce EMI.
+
+  rockchip,ext-refclk:
+    type: boolean
+    description:
+      Many PCIe connections, especially backplane connections,
+      require a synchronous reference clock between the two link partners.
+      To achieve this a common clock source, referred to as REFCLK in
+      the PCI Express Card Electromechanical Specification,
+      should be used by both ends of the PCIe link.
+      In PCIe mode, the reference clock can choose to use internal clock
+      or external clock.
+      By default, the internal clock is selected, The PCIe PHY provides
+      100MHz differential clock output(optional with SSC) for system applications.
+      When selecting This option to used external reference clock, a externally
+      100MHz differential clock is needs to be provided for PCIe PHY.
+
+  rockchip,pipe-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional phy settings are accessed through GRF regs.
+
+  rockchip,pipe-phy-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional pipe settings are accessed through GRF regs.
+
+  rockchip,sgmii-mac-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      Select gmac0 or gmac1 to be used as SGMII controller.
+
+  "#phy-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - rockchip,pipe-grf
+  - rockchip,pipe-phy-grf
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+
+    pipegrf: syscon@fdc50000 {
+      compatible = "rockchip,rk3568-pipe-grf", "syscon";
+      reg = <0xfdc50000 0x1000>;
+    };
+
+    pipe_phy_grf0: syscon@fdc70000 {
+      compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+      reg = <0xfdc70000 0x1000>;
+    };
+
+    combphy0: phy@fe820000 {
+      compatible = "rockchip,rk3568-naneng-combphy";
+      reg = <0xfe820000 0x100>;
+      clocks = <&pmucru CLK_PCIEPHY0_REF>,
+               <&cru PCLK_PIPEPHY0>,
+               <&cru PCLK_PIPE>;
+      clock-names = "ref", "apb", "pipe";
+      assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
+      assigned-clock-rates = <100000000>;
+      resets = <&cru SRST_PIPEPHY0>;
+      rockchip,pipe-grf = <&pipegrf>;
+      rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
+      #phy-cells = <1>;
+    };
-- 
2.17.1



