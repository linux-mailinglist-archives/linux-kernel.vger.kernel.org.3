Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52585B1146
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIHAbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiIHAbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:31:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272186FC9;
        Wed,  7 Sep 2022 17:31:17 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-158-249.ewe-ip-backbone.de [95.33.158.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A70896601F7D;
        Thu,  8 Sep 2022 01:31:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662597074;
        bh=0IQkKKrWviqP+DaaIRZGIHRLFt3pmMMqqP1bRI8JOfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBNDlY5f+IwbeIqdgUoAGvAKRs4LTPPzFCBETVDeKLM9UcPREM+fF7yXM3r02ylIC
         DS6g7i5JWxAxrsbcaaEnk0rrDfkwyJGDe+ejEe4gV/jR124E9aSDhfVWHfNGC+Twvf
         l5rHzj2CRWVUMf6eAfzD/Ek54fs2GLn0Qn7R7YIcm7WBZd0pdG32B+B48wtmQsg9Lw
         w0ErkFp0UxK+77wtypyfmLMaDLhJgSibYEjytEzTBvYeieyfYLsg0ORvnlTTQGSFRQ
         qAeX6ZWsAYkQDUVg6IiOJYUlOhrSTZ+1EyJ319RP1edM+7+4/n46gQuCb6PdsoF2zf
         MCAUzABF1ehTA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6DF62480792; Thu,  8 Sep 2022 02:31:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 08/13] dt-bindings: mfd: add rk806 binding
Date:   Thu,  8 Sep 2022 02:31:02 +0200
Message-Id: <20220908003107.220143-9-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908003107.220143-1-sebastian.reichel@collabora.com>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for Rockchip's RK806 PMIC.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/mfd/rockchip,rk806.yaml          | 388 ++++++++++++++++++
 1 file changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml

diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
new file mode 100644
index 000000000000..80216440bd9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
@@ -0,0 +1,388 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RK806 Power Management Integrated Circuit
+
+maintainers:
+  - Sebastian Reichel <sebastian.reichel@collabora.com>
+
+description: |
+  Rockchip RK806 series PMIC. This device consists of an spi or
+  i2c controlled MFD that includes multiple switchable regulators.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk806
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  vcc1-supply:
+    description:
+      The input supply for dcdc-reg1.
+
+  vcc2-supply:
+    description:
+      The input supply for dcdc-reg2.
+
+  vcc3-supply:
+    description:
+      The input supply for dcdc-reg3.
+
+  vcc4-supply:
+    description:
+      The input supply for dcdc-reg4.
+
+  vcc5-supply:
+    description:
+      The input supply for dcdc-reg5.
+
+  vcc6-supply:
+    description:
+      The input supply for dcdc-reg6.
+
+  vcc7-supply:
+    description:
+      The input supply for dcdc-reg7.
+
+  vcc8-supply:
+    description:
+      The input supply for dcdc-reg8.
+
+  vcc9-supply:
+    description:
+      The input supply for dcdc-reg9.
+
+  vcc10-supply:
+    description:
+      The input supply for dcdc-reg10.
+
+  vcc11-supply:
+    description:
+      The input supply for pldo-reg1, pldo-reg2 and pldo-reg3.
+
+  vcc12-supply:
+    description:
+      The input supply for pldo-reg4 and pldo-reg5.
+
+  vcc13-supply:
+    description:
+      The input supply for nldo-reg1, nldo-reg2 and nldo-reg3.
+
+  vcc14-supply:
+    description:
+      The input supply for nldo-reg4 and nldo-reg5.
+
+  vcca-supply:
+    description:
+      The input supply for pldo-reg6.
+
+  regulators:
+    type: object
+    patternProperties:
+      "^(dcdc-reg([1-9]|10)|[pn]ldo_reg[1-6])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/rockchip.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@0 {
+            compatible = "rockchip,rk806";
+            reg = <0x0>;
+
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+            vcc1-supply = <&vcc5v0_sys>;
+            vcc2-supply = <&vcc5v0_sys>;
+            vcc3-supply = <&vcc5v0_sys>;
+            vcc4-supply = <&vcc5v0_sys>;
+            vcc5-supply = <&vcc5v0_sys>;
+            vcc6-supply = <&vcc5v0_sys>;
+            vcc7-supply = <&vcc5v0_sys>;
+            vcc8-supply = <&vcc5v0_sys>;
+            vcc9-supply = <&vcc5v0_sys>;
+            vcc10-supply = <&vcc5v0_sys>;
+            vcc11-supply = <&vcc_2v0_pldo_s3>;
+            vcc12-supply = <&vcc5v0_sys>;
+            vcc13-supply = <&vcc5v0_sys>;
+            vcc14-supply = <&vcc_1v1_nldo_s3>;
+            vcca-supply = <&vcc5v0_sys>;
+
+            regulators {
+                vdd_gpu_s0: dcdc-reg1 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <550000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_gpu_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_npu_s0: dcdc-reg2 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <550000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_npu_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_log_s0: dcdc-reg3 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <750000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_log_s0";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <750000>;
+                    };
+                };
+
+                vdd_vdenc_s0: dcdc-reg4 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <550000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_vdenc_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_gpu_mem_s0: dcdc-reg5 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <675000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_gpu_mem_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_npu_mem_s0: dcdc-reg6 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <675000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_npu_mem_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vcc_2v0_pldo_s3: dcdc-reg7 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <2000000>;
+                    regulator-max-microvolt = <2000000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_2v0_pldo_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <2000000>;
+                    };
+                };
+
+                vdd_vdenc_mem_s0: dcdc-reg8 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <675000>;
+                    regulator-max-microvolt = <950000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_vdenc_mem_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd2_ddr_s3: dcdc-reg9 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-name = "vdd2_ddr_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                    };
+                };
+
+                vcc_1v1_nldo_s3: dcdc-reg10 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <1100000>;
+                    regulator-max-microvolt = <1100000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vcc_1v1_nldo_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1100000>;
+                    };
+                };
+
+                avcc_1v8_s0: pldo-reg1 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "avcc_1v8_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd1_1v8_ddr_s3: pldo-reg2 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd1_1v8_ddr_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1800000>;
+                    };
+                };
+
+                vcc_1v8_s3: pldo-reg3 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vcc_1v8_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1800000>;
+                    };
+                };
+
+                vcc_3v3_s0: pldo-reg4 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vcc_3v3_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vccio_sd_s0: pldo-reg5 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vccio_sd_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                master_pldo6_s3: pldo-reg6 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-name = "master_pldo6_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <1800000>;
+                    };
+                };
+
+                vdd_0v75_s3: nldo-reg1 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <750000>;
+                    regulator-ramp-delay = <12500>;
+                    regulator-name = "vdd_0v75_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <750000>;
+                    };
+                };
+
+                vdd2l_0v9_ddr_s3: nldo-reg2 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <900000>;
+                    regulator-max-microvolt = <900000>;
+                    regulator-name = "vdd2l_0v9_ddr_s3";
+                    regulator-state-mem {
+                        regulator-on-in-suspend;
+                        regulator-suspend-microvolt = <900000>;
+                    };
+                };
+
+                master_nldo3: nldo-reg3 {
+                    regulator-name = "master_nldo3";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                avdd_0v75_s0: nldo-reg4 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <750000>;
+                    regulator-max-microvolt = <750000>;
+                    regulator-name = "avdd_0v75_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+
+                vdd_0v85_s0: nldo-reg5 {
+                    regulator-always-on;
+                    regulator-boot-on;
+                    regulator-min-microvolt = <850000>;
+                    regulator-max-microvolt = <850000>;
+                    regulator-name = "vdd_0v85_s0";
+                    regulator-state-mem {
+                        regulator-off-in-suspend;
+                    };
+                };
+            };
+        };
+    };
-- 
2.35.1

