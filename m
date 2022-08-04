Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE0589C41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiHDNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiHDNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:10:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2E18E21
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:10:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so21008389wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETAlUNaMGQpo/uPrl7ABLWcA/ucKMRK4Sq2xTm6LKJ0=;
        b=N9mg1GGa3pwtI8qwXcnAzLD7CEsS9/tz7e5TGqSzK+TYejyMwE84o1o+htg5e0jfGa
         QBxFGjvIgNUvt/vOt6d4dG1yGNG746FMXZYKqBhUuq5PFkIFiggS94FEW1HWzmVSL8YN
         VKycWa1BpZmcTDDw4DTb41yyiuExfFx0brq5izSecgSnDkBwXDN4z3C96SkMOGS+Z9RS
         vV1BuNEXObvWZfnqJg5XFPrcLT4tqCeoZqZefNM2mu6diG5F6R3ejU/Tv95FZt0X2xbK
         eQyAN+SfZXUDilGmsLqOIHelMmqfzs8Be/E1VYoBKl+x4Sy1OeomZT+hVK27z58IHnsv
         PsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETAlUNaMGQpo/uPrl7ABLWcA/ucKMRK4Sq2xTm6LKJ0=;
        b=szuFVzbZt9r8Aiu5bBdOlQ9Eau4MeBLTi7/BKkqZDQMiniJB/sPrVaxgttRHryIRbc
         11olGFBOV3hnGQSCkUzAGEst7jQHVUwnjYuZ1VnmAZm9f+r4tq5ScRl6h/j+Q23sd9xb
         ScFcvWnQ5EeMuTnQr7O185VTSv/Wf8aXbET2jooS57ENneyR9pdBpjM+GERf9GLFPGXJ
         GuVd4agEFyHEXTZVJXLgUbe5ILsTuAdZkiiwDMKjo+hSrks96r92yzZwnxn42z64Oh0C
         m2x53DIMzJLVHqnmutTPI4Q9K6ffxpNEiUr0eoCu93db9l2+D7jQJ0sOJb7cIqVa8I8e
         yI5g==
X-Gm-Message-State: ACgBeo3z2zSIYUhMj9FJZhNq8n+u/F0YW/7/mA+++D96O+mjHv6GItPb
        DsajPBEG7+XAEsaQgAcg6XEikg==
X-Google-Smtp-Source: AA6agR4NM2DuUJ9ZgcrlN+3wkc0Rf579Msjd8f9h/Jqtrma62QpnqPtRFG6GD9EJr9FuCtRnPy1P/Q==
X-Received: by 2002:a5d:6f1c:0:b0:21f:121e:1190 with SMTP id ay28-20020a5d6f1c000000b0021f121e1190mr1341352wrb.589.1659618599667;
        Thu, 04 Aug 2022 06:09:59 -0700 (PDT)
Received: from Balsam-ThinkPad-T480.. (235.163.185.81.rev.sfr.net. [81.185.163.235])
        by smtp.gmail.com with ESMTPSA id o15-20020adfcf0f000000b0021d6a520ce9sm1156817wrj.47.2022.08.04.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:09:59 -0700 (PDT)
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
Subject: [PATCH v8.1, 2/7] dt-bindings: thermal: Add binding document for LVTS thermal controllers
Date:   Thu,  4 Aug 2022 15:09:07 +0200
Message-Id: <20220804130912.676043-3-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220804130912.676043-1-bchihi@baylibre.com>
References: <20220804130912.676043-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This patch adds dt-binding documents for mt8192 and mt8195 thermal controllers.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 .../thermal/mediatek,lvts-thermal.yaml        | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
new file mode 100644
index 000000000000..53c44a73f3a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
@@ -0,0 +1,77 @@
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
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: SW reset HW AP/MCU domain to clean temporary data on HW initialization/resume.
+
+  nvmem-cells:
+    items:
+      - description: LVTS calibration data 1 for thermal sensors
+      - description: LVTS calibration data 2 for thermal sensors
+
+  nvmem-cell-names:
+    items:
+      - const: lvts_calib_data1
+      - const: lvts_calib_data2
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
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/reset/mt8195-resets.h>
+
+      lvtsmcu: thermal-sensor@11278000 {
+        compatible = "mediatek,mt8195-lvts-mcu";
+        #thermal-sensor-cells = <1>;
+        reg = <0 0x11278000 0 0x400>;
+        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+        resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+        nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
+      };
+
+...
-- 
2.34.1

