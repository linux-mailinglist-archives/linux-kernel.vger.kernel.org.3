Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8850947D8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhLVVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbhLVVan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:30:43 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C1AC061574;
        Wed, 22 Dec 2021 13:30:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so13617486edb.5;
        Wed, 22 Dec 2021 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9xBnp+DcnB6XC5obBOXShIXNIp0uQFFeRvqFbdve3w=;
        b=BOyE9hxYPdMU2y5WUQnnm+p4QwH8QQt6K/e+4iD6zZ/oQWSYfvd+ETgFHHAD2wkEqb
         FuEPHeB0WLKhN8pguiTPR2VzuQJxeF4QOnJtG9iUiY6Vjx+axAFS9FaaWGoBsEJCkYJR
         N4d+KpiAmge/Spiza0Vtc1ryWD73w8TLQHiZp4qSpNzWKL0EnGErK+HrAbzqAMmy8VrN
         G7rvEByUqTdqyVxiVRVvFmH2j2iweJKwY+lqBpcZdtO++o3Kb1u8ml2g1fYEM6EMAFmH
         0xgSNRnoMdxW0XbmTN8a89UEr/z3gZx5pLMmctzmZ3LmVKqyMlRJooowfoMWy3JM+Yf1
         rGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9xBnp+DcnB6XC5obBOXShIXNIp0uQFFeRvqFbdve3w=;
        b=d7IRmRruQIGeoUsbY5IULuHrx2bh2Xdk+eAH+Jqsucm4fRTyIEKebiN6Tx9+p+ZnTq
         80hsMWRTIWl/9z6OMrXYkJR63d3O30Idm9mQDL8AhhJ9hHaXxur0p+tSYPRqWGp2aO3a
         9ntX1QkVaT5uzFPx5kYkHd3TOw/PIrKHfjJnK+7fXHt9ZHa9OEo1QsMGNi3nyHAQ6nrc
         MrVNUaxKJQPWtCEgpQwn6l96iq8JtIPjHFg6guWg6bX8HnZDxOE1VO9jWtqd3Eo2ts7e
         +3EhOsSbEBRSoW+91sh5ZY8L9bAP8QqtudjxDxnwTmt5II8XWB+awfaSq77yHKMOa5ly
         3omg==
X-Gm-Message-State: AOAM531A7wfsLD/R5AnjLHapSf6hFGT7Hcsxfo7MRjRfuvmOSA2Tu1cK
        TZlHazcprau/P3rGIIFQ+mbj09TZzCOnOg==
X-Google-Smtp-Source: ABdhPJyXgoXKOqrBn8mrW2mn2gHaC6E5k8NmTCsecC/cPmhf+k3OxerK4SD9CswDtgpfmM16W5coig==
X-Received: by 2002:a05:6402:440a:: with SMTP id y10mr4257267eda.371.1640208641640;
        Wed, 22 Dec 2021 13:30:41 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ne2sm1087776ejc.108.2021.12.22.13.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 13:30:41 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, lee.jones@linaro.org,
        yifeng.zhao@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 2/4] dt-bindings: phy: rockchip: add naneng multi phy bindings
Date:   Wed, 22 Dec 2021 22:30:30 +0100
Message-Id: <20211222213032.7678-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211222213032.7678-1-jbx6244@gmail.com>
References: <20211222213032.7678-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Zhao <yifeng.zhao@rock-chips.com>

Add the compatible strings for the Naneng multi phy found on Rockchip SoCs.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changes in v6:
- change from comb to multi phy
- add parent node
- change compatible strings
- remove rockchip,sgmii-mac-sel
- remove rockchip,dis-u3otg0-port
- remove rockchip,dis-u3otg1-port

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
---
 .../phy/phy-rockchip-naneng-multiphy.yaml     | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-multiphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-multiphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-multiphy.yaml
new file mode 100644
index 000000000..40ec1b240
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-multiphy.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-multiphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SoC Naneng Multi Phy Device Tree Bindings
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3566-naneng-multiphy
+      - rockchip,rk3568-naneng-multiphy
+
+  rockchip,pipe-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Some additional phy settings are accessed through GRF regs.
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "multi-phy@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+
+      clocks:
+        items:
+          - description: reference clock
+          - description: apb clock
+          - description: pipe clock
+
+      clock-names:
+        items:
+          - const: ref
+          - const: apb
+          - const: pipe
+
+      resets:
+        items:
+          - description: exclusive PHY reset line
+
+      rockchip,enable-ssc:
+        type: boolean
+        description:
+          The option SSC can be enabled for U3, SATA and PCIE.
+          Most commercially available platforms use SSC to reduce EMI.
+
+      rockchip,ext-refclk:
+        type: boolean
+        description:
+          Many PCIe connections, especially backplane connections,
+          require a synchronous reference clock between the two link partners.
+          To achieve this a common clock source, referred to as REFCLK in
+          the PCI Express Card Electromechanical Specification,
+          should be used by both ends of the PCIe link.
+          In PCIe mode one can choose to use an internal
+          or an external reference clock.
+          By default the internal clock is selected. The PCIe PHY provides a 100MHz
+          differential clock output(optional with SSC) for system applications.
+          When selecting this option an externally 100MHz differential
+          reference clock needs to be provided to the PCIe PHY.
+
+      rockchip,pipe-phy-grf:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          Some additional pipe settings are accessed through GRF regs.
+
+      "#phy-cells":
+        const: 1
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+      - resets
+      - rockchip,pipe-phy-grf
+      - "#phy-cells"
+
+    additionalProperties: false
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
+    pipe_phy_grf1: syscon@fdc80000 {
+      compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+      reg = <0xfdc80000 0x1000>;
+    };
+
+    pipe_phy_grf2: syscon@fdc90000 {
+      compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+      reg = <0xfdc90000 0x1000>;
+    };
+
+    multiphy: multiphy {
+      compatible = "rockchip,rk3568-naneng-multiphy";
+      rockchip,pipe-grf = <&pipegrf>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      multiphy0: multi-phy@fe820000 {
+        reg = <0x0 0xfe820000 0x0 0x100>;
+        clocks = <&pmucru CLK_PCIEPHY0_REF>,
+                 <&cru PCLK_PIPEPHY0>,
+                 <&cru PCLK_PIPE>;
+        clock-names = "ref", "apb", "pipe";
+        assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
+        assigned-clock-rates = <100000000>;
+        resets = <&cru SRST_PIPEPHY0>;
+        rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
+        #phy-cells = <1>;
+      };
+
+      multiphy1: multi-phy@fe830000 {
+        reg = <0x0 0xfe830000 0x0 0x100>;
+        clocks = <&pmucru CLK_PCIEPHY1_REF>,
+                 <&cru PCLK_PIPEPHY1>,
+                 <&cru PCLK_PIPE>;
+        clock-names = "ref", "apb", "pipe";
+        assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
+        assigned-clock-rates = <100000000>;
+        resets = <&cru SRST_PIPEPHY1>;
+        rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
+        #phy-cells = <1>;
+      };
+
+      multiphy2: multi-phy@fe840000 {
+        reg = <0x0 0xfe840000 0x0 0x100>;
+        clocks = <&pmucru CLK_PCIEPHY2_REF>,
+                 <&cru PCLK_PIPEPHY2>,
+                 <&cru PCLK_PIPE>;
+        clock-names = "ref", "apb", "pipe";
+        assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
+        assigned-clock-rates = <100000000>;
+        resets = <&cru SRST_PIPEPHY2>;
+        rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
+        #phy-cells = <1>;
+      };
+    };
-- 
2.20.1

