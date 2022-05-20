Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567B52ED30
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349838AbiETNdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349769AbiETNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:33:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8C5163295;
        Fri, 20 May 2022 06:33:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D0FE51F463B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653053591;
        bh=QDz+2vPFi19R9vlOd4Rq6jmq6Zwn41yhv87cVTbFMbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnHs3otv0nq1ho89dy9ykICb7uxX+lMrcld1X05YQmayU0IgOBs7Hs7lX7XMY7mfl
         4uxtAPpQdETiPOesuwCb8cNjt+8/sBLVFoKtwTuVq/8f93F/+Z5rJW8u+LDR//6rhs
         9rQnYmsk8IpzUPgqRWp6O85LsKV65LV8hrCF3K99G5ucVNtytfg5dZXQoQGMdWFFWT
         XUNqp7LluGVJqSgmb5vSoWmhjLeIaTiAD7cUUTQMTe8AA6cuRDTWgrLirWl+9vgKGS
         nIcNkBiHa2v1hSbyQr+94cVZ4qG+SA3/feEG51Lc8TSrA10/Mefx+ZBWPPFQ0cQhX6
         7N35Nz3bwiGlQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: regulator: Add bindings for MT6331 regulator
Date:   Fri, 20 May 2022 15:33:02 +0200
Message-Id: <20220520133305.265310-2-angelogioacchino.delregno@collabora.com>
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

Add the bindings for the regulators found in the MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/regulator/mt6331-regulator.yaml  | 272 ++++++++++++++++++
 1 file changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml
new file mode 100644
index 000000000000..333c74cdbcbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mt6331-regulator.yaml
@@ -0,0 +1,272 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mt6331-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6331 Regulator from MediaTek Integrated
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description: |
+  List of regulators provided by this controller. It is named
+  according to its regulator type, buck_<name> and ldo_<name>.
+  MT6331 regulators node should be sub node of the MT6397 MFD node.
+
+patternProperties:
+  "^buck_v(core2|io18|dvfs11|dvfs12|dvfs13|dvfs14)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(core2|io18|dvfs11|dvfs12|dvfs13|dvfs14)$"
+
+    unevaluatedProperties: false
+
+  "^ldo_v(avdd32aud|auxa32)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(avdd32aud|auxa32)$"
+
+    unevaluatedProperties: false
+
+  "^ldo_v(dig18|emc33|ibr|mc|mch|mipi|rtc|sram|usb10)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^v(dig18|emc33|ibr|mc|mch|mipi|rtc|sram|usb10)$"
+
+    unevaluatedProperties: false
+
+  "^ldo_vcam(a|af|d|io)$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^vcam(a|af|d|io)$"
+
+    unevaluatedProperties: false
+
+  "^ldo_vtcxo[12]$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^vtcxo[12]$"
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+  "^ldo_vgp[1234]$":
+    type: object
+    $ref: "regulator.yaml#"
+
+    properties:
+      regulator-name:
+        pattern: "^vgp[12]$"
+
+    required:
+      - regulator-name
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      regulators {
+        mt6331_vdvfs11_reg: buck-vdvfs11 {
+          regulator-name = "vdvfs11";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6331_vdvfs12_reg: buck-vdvfs12 {
+          regulator-name = "vdvfs12";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6331_vdvfs13_reg: buck-vdvfs13 {
+          regulator-name = "vdvfs13";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6331_vdvfs14_reg: buck-vdvfs14 {
+          regulator-name = "vdvfs14";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6331_vcore2_reg: buck-vcore2 {
+          regulator-name = "vcore2";
+          regulator-min-microvolt = <700000>;
+          regulator-max-microvolt = <1493750>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <1>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6331_vio18_reg: buck-vio18 {
+          regulator-name = "vio18";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+          regulator-ramp-delay = <12500>;
+          regulator-enable-ramp-delay = <0>;
+          regulator-allowed-modes = <0 1>;
+        };
+        mt6331_vtcxo1_reg: ldo-vtcxo1 {
+          regulator-name = "vtcxo1";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-always-on;
+          regulator-boot-on;
+        };
+        mt6331_vtcxo2_reg: ldo-vtcxo2 {
+          regulator-name = "vtcxo2";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-always-on;
+          regulator-boot-on;
+        };
+        mt6331_avdd32_aud_reg: ldo-avdd32aud {
+          regulator-name = "avdd32_aud";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <3200000>;
+        };
+        mt6331_vauxa32_reg: ldo-vauxa32 {
+          regulator-name = "vauxa32";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <3200000>;
+        };
+        mt6331_vcama_reg: ldo-vcama {
+          regulator-name = "vcama";
+          regulator-min-microvolt = <1500000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-always-on;
+        };
+        mt6331_vio28_reg: ldo-vio28 {
+          regulator-name = "vio28";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-always-on;
+          regulator-boot-on;
+        };
+        mt6331_vcamaf_reg: ldo-vcamaf {
+          regulator-name = "vcam_af";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vmc_reg: ldo-vmc {
+          regulator-name = "vmc";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vmch_reg: ldo-vmch {
+          regulator-name = "vmch";
+          regulator-min-microvolt = <3000000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vemc33_reg: ldo-vemc33 {
+          regulator-name = "vemc33";
+          regulator-min-microvolt = <3300000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vgp1_reg: ldo-vgp1 {
+          regulator-name = "vgp1";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vsim1_reg: ldo-vsim1 {
+          regulator-name = "vsim1";
+          regulator-min-microvolt = <1700000>;
+          regulator-max-microvolt = <3100000>;
+        };
+        mt6331_vsim2_reg: ldo-vsim2 {
+          regulator-name = "vsim2";
+          regulator-min-microvolt = <1700000>;
+          regulator-max-microvolt = <3100000>;
+        };
+        mt6331_vmipi_reg: ldo-vmipi {
+          regulator-name = "vmipi";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vibr_reg: ldo-vibr {
+          regulator-name = "vibr";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <3300000>;
+        };
+        mt6331_vgp4_reg: ldo-vgp4 {
+          regulator-name = "vgp4";
+          regulator-min-microvolt = <1600000>;
+          regulator-max-microvolt = <2200000>;
+        };
+        mt6331_vcamd_reg: ldo-vcamd {
+          regulator-name = "vcamd";
+          regulator-min-microvolt = <900000>;
+          regulator-max-microvolt = <1500000>;
+        };
+        mt6331_vusb10_reg: ldo-vusb10 {
+          regulator-name = "vusb";
+          regulator-min-microvolt = <1000000>;
+          regulator-max-microvolt = <1300000>;
+          regulator-boot-on;
+        };
+        mt6331_vcamio_reg: ldo-vcamio {
+          regulator-name = "vcam_io";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <1800000>;
+        };
+        mt6331_vsram_reg: ldo-vsram {
+          regulator-name = "vsram";
+          regulator-min-microvolt = <1012500>;
+          regulator-max-microvolt = <1012500>;
+          regulator-always-on;
+          regulator-boot-on;
+        };
+        mt6331_vgp2_reg: ldo-vgp2 {
+          regulator-name = "vgp2";
+          regulator-min-microvolt = <1100000>;
+          regulator-max-microvolt = <1500000>;
+          regulator-boot-on;
+        };
+        mt6331_vgp3_reg: ldo-vgp3 {
+          regulator-name = "vgp3";
+          regulator-min-microvolt = <1200000>;
+          regulator-max-microvolt = <1800000>;
+        };
+        mt6331_vrtc_reg: ldo-vrtc {
+          regulator-name = "vrtc";
+          regulator-min-microvolt = <2800000>;
+          regulator-max-microvolt = <2800000>;
+          regulator-always-on;
+        };
+        mt6331_vdig18_reg: ldo-vdig18 {
+          regulator-name = "dvdd18_dig";
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+        };
+      };
+    };
+...
-- 
2.35.1

