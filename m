Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41508596B02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiHQIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiHQIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:08:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413594E63F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n4so15266125wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VWXG1e9/DRSLvY5QEUtPtlLQfPC+KRrU45gKoV7pXAc=;
        b=NmM9L1PaffPpCsm/C4/QFhphpWYhLPEMeeIXMsHVx+Gx6cwHyUbPB+W5EQHS5EJ82y
         X/wINA6ev0mpTwDayZwDE6yvvRlTgM1lbaWx8aHtMnHbFEKSMDWQ0ReaD4GMoRNh4naT
         3WNlCO7ZqEOehjoUs2RHdyj/jHRF/5wCPuOum7W8n+mwDwGQTsAYo/4WyPgBN1DlHohP
         JPqcaJ+/Gt3ntySPDCiXHkJiMCsSwaoblu88SOG4VmJn4Kgr/ZXn0XOoMCS3p60ogBnl
         D5LL0QVWUWn/cKMzPW/Oj+PqUtsyrgBgf/fqpBOSX783sp9tUInUxHELxusOUgt7etgL
         BoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VWXG1e9/DRSLvY5QEUtPtlLQfPC+KRrU45gKoV7pXAc=;
        b=TukhulMCE9/CeM+8QqiEfgUEOrmUUV+r+ok2pKVMAAi0UFFBWO2YEa2PIWurRPyrMM
         i0/0EUbt6qep3QVPWNoSf3EfhvOI/Il8Z0En2mn+kOt6ZshOTqMlJliNu7ixJ2bH9XGd
         IfL2FYmXm9iPahniK4Bh3tay6RWn+qLP3dnfjzycUb8A6kihbOB8Cni+35QsKzTcZvCr
         /bmLXInCky2ozqcBjIs2hafX0pXiVso+jezYrQuEDYtjMih9xbNYBmXb+eUXPjV3d+lN
         krEucJSUP/U08BbwpPTE+y/NjtNMDhZEmXrFgNUtHvAcDnBXgmUtWh4MmjE35bCLFzte
         ja6g==
X-Gm-Message-State: ACgBeo2GUx2oCcyRQLWrkjv8RZnjSLwOySmt+C9Lh9CeuQCZ76KbTS5L
        WIcDU9IPFVyOQMHlMCh4zFUYJw==
X-Google-Smtp-Source: AA6agR7KY4TOelp2cDbEEwT9aNbQBHNA36aSrdAhKK+734vr4aWgVXADl++KkjH3cOTyGim9KWp26Q==
X-Received: by 2002:adf:e44b:0:b0:220:5bc5:e942 with SMTP id t11-20020adfe44b000000b002205bc5e942mr13366911wrm.179.1660723717790;
        Wed, 17 Aug 2022 01:08:37 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a54d610e5fsm1391992wmq.26.2022.08.17.01.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 01:08:37 -0700 (PDT)
From:   bchihi@baylibre.com
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for LVTS thermal controllers
Date:   Wed, 17 Aug 2022 10:07:52 +0200
Message-Id: <20220817080757.352021-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080757.352021-1-bchihi@baylibre.com>
References: <20220817080757.352021-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
new file mode 100644
index 000000000000..31d9e220513a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -0,0 +1,152 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC LVTS thermal controller
+
+maintainers:
+  - Yu-Chia Chang <ethan.chang@mediatek.com>
+  - Ben Tseng <ben.tseng@mediatek.com>
+
+description: |
+  LVTS (Low Voltage Thermal Sensor).
+  The architecture will be first used on mt8192 and mt8195.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8192-lvts-ap
+      - mediatek,mt8192-lvts-mcu
+      - mediatek,mt8195-lvts-ap
+      - mediatek,mt8195-lvts-mcu
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+    description: LVTS instance registers.
+
+  interrupts:
+    maxItems: 1
+    description: LVTS instance interrupts.
+
+  clocks:
+    maxItems: 1
+    description: LVTS instance clock.
+
+  resets:
+    maxItems: 1
+    description: |
+      LVTS instance SW reset for HW AP/MCU domain to clean temporary data
+      on HW initialization/resume.
+
+  nvmem-cells:
+    minItems: 1
+    maxItems: 2
+    description: Calibration efuse data for LVTS
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 2
+    description: Calibration efuse cell names for LVTS
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8192-lvts-ap
+              - mediatek,mt8192-lvts-mcu
+    then:
+      properties:
+        nvmem-cells:
+          items:
+            - description: Calibration efuse data for LVTS
+
+        nvmem-cell-names:
+          items:
+            - const: lvts_calib_data1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8195-lvts-ap
+              - mediatek,mt8195-lvts-mcu
+    then:
+      properties:
+        nvmem-cells:
+          items:
+            - description: Calibration efuse data 1 for LVTS
+            - description: Calibration efuse data 2 for LVTS
+
+        nvmem-cell-names:
+          items:
+            - const: lvts_calib_data1
+            - const: lvts_calib_data2
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
+    #include <dt-bindings/reset/mt8192-resets.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      lvts_ap: thermal-sensor@1100b000 {
+        compatible = "mediatek,mt8192-lvts-ap";
+        #thermal-sensor-cells = <1>;
+        reg = <0 0x1100b000 0 0x1000>;
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg CLK_INFRA_THERM>;
+        resets = <&infracfg MT8192_INFRA_RST0_THERM_CTRL_SWRST>;
+        nvmem-cells = <&lvts_e_data1>;
+        nvmem-cell-names = "lvts_calib_data1";
+      };
+
+      lvts_mcu: thermal-sensor@11278000 {
+        compatible = "mediatek,mt8192-lvts-mcu";
+        #thermal-sensor-cells = <1>;
+        reg = <0 0x11278000 0 0x1000>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg CLK_INFRA_THERM>;
+        resets = <&infracfg MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_e_data1>;
+        nvmem-cell-names = "lvts_calib_data1";
+      };
+    };
+
+    thermal_zones: thermal-zones {
+      cpu0-thermal {
+        polling-delay = <0>;
+        polling-delay-passive = <0>;
+        thermal-sensors = <&lvts_mcu 0>;
+      };
+
+      vpu1-thermal {
+        polling-delay = <0>;
+        polling-delay-passive = <0>;
+        thermal-sensors = <&lvts_ap 0>;
+      };
+    };
-- 
2.34.1

