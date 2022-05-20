Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B37B52ED31
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349853AbiETNdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349809AbiETNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:33:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D63163295;
        Fri, 20 May 2022 06:33:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 479D21F463BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653053592;
        bh=nPTVwBA9HaQmt8ZBrYqe8lBcpkZGzyuUXdJGkjUqqGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBrouNEs75VxUIYnkRjqtd3s8kQF17MPQUc+PMXCzY+nmWl5Op/OPqMfRhlpUkkmo
         6UylEAf6BjNzPENa+wCXzQzwV3h8oMx+aafxGU94MuS4jtBa6wvt2XvXYJV9Efaj+H
         Ia+r4Vji3PkZ6K3yUcHeOCVivhFctxgn/rsPdfEPQ9ngd8c5PsqkjpW3nrf9fPX9zu
         k0JBA3Q8Iwjp8z4VxHdkk9uN77oPQs2SG6ueomfZbFEw5KSNaMLssJsfDt4WntAEJf
         keSiDbN8KKP97d5vgVIlSPxzP1IgYWSalM13JornZl+kE6HMdAt3nmYBKqYeLbZTL5
         s6z7cxRZpDuQw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/4] dt-bindings: regulator: Add bindings for MT6332 regulator
Date:   Fri, 20 May 2022 15:33:04 +0200
Message-Id: <20220520133305.265310-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
References: <20220520133305.265310-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for the regulators found in the MT6332 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/regulator/mt6332-regulator.yaml  | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6332-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6332-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6332-regulator.yaml
new file mode 100644
index 000000000000..51077a865dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6332-regulator.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mt6332-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6332 Regulator from MediaTek Integrated
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description: |
+  List of regulators provided by this controller. It is named
+  according to its regulator type, buck_<name> and ldo_<name>.
+  MT6332 regulators node should be sub node of the MT6397 MFD node.
+
+patternProperties:
+  "^buck_v(dram|dvfs2|pa|rf18a|rf18b|sbst)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(dram|dvfs2|pa|rf18a|rf18b|sbst)$"
+
+    unevaluatedProperties: false
+
+  "^ldo_v(bif28|dig18|sram|usb33)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(bif28|dig18|sram|usb33)$"
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      regulators {
+        mt6332_vdram_reg: buck-vdram {
+          regulator-name = "vdram";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-allowed-modes = <0 1>;
+          regulator-always-on;
+        };
+        mt6332_vdvfs2_reg: buck-vdvfs2 {
+          regulator-name = "vdvfs2";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1312500>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6332_vpa_reg: buck-vpa {
+          regulator-name = "vpa";
+          regulator-min-microvolt = <500000>;
+          regulator-max-microvolt = <3400000>;
+        };
+        mt6332_vrf18a_reg: buck-vrf18a {
+          regulator-name = "vrf18a";
+          regulator-min-microvolt = <1050000>;
+          regulator-max-microvolt = <2240625>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6332_vrf18b_reg: buck-vrf18b {
+          regulator-name = "vrf18b";
+          regulator-min-microvolt = <1050000>;
+          regulator-max-microvolt = <2240625>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6332_vsbst_reg: buck-vsbst {
+          regulator-name = "vsbst";
+          regulator-min-microvolt = <3500000>;
+          regulator-max-microvolt = <7468750>;
+        };
+        mt6332_vauxb32_reg: ldo-vauxb32 {
+          regulator-name = "vauxb32";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <3200000>;
+        };
+        mt6332_vbif28_reg: ldo-vbif28 {
+          regulator-name = "vbif28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+        };
+        mt6332_vdig18_reg: ldo-vdig18 {
+          regulator-name = "vdig18";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-always-on;
+        };
+        mt6332_vsram_reg: ldo-vsram {
+          regulator-name = "vauxa32";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-always-on;
+        };
+        mt6332_vusb33_reg: ldo-vusb33 {
+          regulator-name = "vusb33";
+          regulator-min-microvolt = <3300000>;
+          regulator-max-microvolt = <3300000>;
+        };
+      };
+    };
+...
-- 
2.35.1

