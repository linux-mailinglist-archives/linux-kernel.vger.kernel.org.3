Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AFA4AD4BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354640AbiBHJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiBHJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:24:50 -0500
Received: from mail-m17635.qiye.163.com (mail-m17635.qiye.163.com [59.111.176.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E267C03FEC1;
        Tue,  8 Feb 2022 01:24:47 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id E7D434002DD;
        Tue,  8 Feb 2022 17:13:35 +0800 (CST)
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, david.wu@rock-chips.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Tue,  8 Feb 2022 17:13:24 +0800
Message-Id: <20220208091326.12495-3-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpKTkxWGhhJHU1LTh8dHk
        NMVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6Ixw*HT5WDiEZSThKL0sK
        KCowCzpVSlVKTU9PSEpKTUpNQ0lOVTMWGhIXVQISHR4VHFUBExoUOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBTUpLQzcG
X-HM-Tid: 0a7ed89c1b8cd991kuwse7d434002dd
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible strings for the Naneng combo PHY found on rockchip SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changes in v8: None
Changes in v7:
- remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel

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

 .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
new file mode 100644
index 000000000000..f14454401419
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -0,0 +1,109 @@
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
+      In PCIe mode one can choose to use an internal or an external reference
+      clock.
+      By default the internal clock is selected. The PCIe PHY provides a 100MHz
+      differential clock output(optional with SSC) for system applications.
+      When selecting this option an externally 100MHz differential
+      reference clock needs to be provided to the PCIe PHY.
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

