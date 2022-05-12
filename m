Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8C524CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353699AbiELMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353664AbiELMYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:24:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61F248258
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so2886100wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEL25fIAOxZ58SCupHBAbwosUkv+Gl8sueS42GQV8/0=;
        b=hmJKYH3GoV5OPRognhaYZ9+ey9NKhNM6sjc6eiy81im7gczC0H9b8FiR7Ynz3TR2aO
         EtsHN4T+aZLesVCtqXMrOouFUZ0JeTeDAP3e227fx4J9gnYhikxOjKCKJYufyHjNO++H
         r7gu1qICR7hpGKy2Fx4ERghUJfTGx+zUO+RQQ12CRjki/XcuVH25CzD0uo8ilTc7N0QX
         S2j9NtLnAZJBji7+i54njL8ORu9Ph55VVxsVX8jHBGqIkBhETEEywKjaWD6j++UpZVaL
         SnSRYZY/dbyyAE1QccpUR5ph/44KCoclXmeaiIYnLjiEp86PKr8BtlvuhN6R2B5OxqIw
         3wWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEL25fIAOxZ58SCupHBAbwosUkv+Gl8sueS42GQV8/0=;
        b=CvGgdDozrz9mZMqX2DGahwsvxeWMUoHdLCrCbNaNZL/hotIkvCHhzSofDu76lzLJe7
         AjlWRReB5JNbz+53siH/HPzNFdaY+58g/FvKSgT2y4QK3S/fEVMHIOgIOv44WSvRxPPO
         WRIB6kL5S72ZtWvLSjHW7hAh38bRaQukaYCq1qhPe4bsRJTzmnPmAQr60Xv5Pq3cYiUJ
         izKkuUXF9YiYQra9HdNq838rFr1Y90ATvNWHcRTz0/tot8el+NaKTQAaF4divRJxpQyk
         6bhM2JZEL0xxNTRoY2ht9c8ifnfVOHLZ1hTK0H9h6AeWBYeOU2aPwfW0X9VfNfH/Si00
         shPA==
X-Gm-Message-State: AOAM530phkWY6EVwvNoaF+uzJDMzG+nFZk07BT/tNzp71DqlQJtaxxP7
        ChQ7cgrkGQTGOO2GuLDLSBsK7w==
X-Google-Smtp-Source: ABdhPJy2UcZEE5+c7sRO4tFxsA0JEIP0dOgsO3PQO1bZq+4Emf94ol1GlRDSyhrBYOiYdVC3cajVNA==
X-Received: by 2002:a1c:7510:0:b0:394:1961:708 with SMTP id o16-20020a1c7510000000b0039419610708mr9895075wmc.201.1652358279313;
        Thu, 12 May 2022 05:24:39 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc156000000b003942a244f30sm3047819wmi.9.2022.05.12.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:39 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com
Subject: [PATCH v6 2/7] dt-bindings: thermal: Add binding document for mt6873 thermal controller
Date:   Thu, 12 May 2022 14:24:28 +0200
Message-Id: <20220512122433.1399802-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512122433.1399802-1-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

This patch adds binding document for mt6873 thermal controller.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
---
 .../thermal/mediatek-thermal-lvts.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
new file mode 100644
index 000000000000..69ffe7b14c21
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek-thermal-lvts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek SoC LVTS thermal controller (DTS) binding
+
+maintainers:
+  - Yu-Chia Chang <ethan.chang@mediatek.com>
+  - Ben Tseng <ben.tseng@mediatek.com>
+
+properties:
+  compatible:
+    const: mediatek,mt6873-lvts
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: lvts_clk
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - "#thermal-sensor-cells"
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
+    dts: lvts@1100b000 {
+        compatible = "mediatek,mt6873-lvts";
+        reg = <0x1100b000 0x1000>;
+        clocks = <&infracfg CLK_INFRA_THERM>;
+        clock-names = "lvts_clk";
+        #thermal-sensor-cells = <0>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+    thermal-zones {
+        cpu_thermal: cpu-thermal {
+            polling-delay-passive = <0>;
+            polling-delay = <0>;
+
+            thermal-sensors = <&dts>;
+            trips {
+                cpu_alert1: cpu-alert1 {
+                    temperature = <85000>;
+                    hysteresis = <0>;
+                    type = "passive";
+                };
+
+                cpu_crit: cpu-crit {
+                    temperature = <120000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
+            };
+
+            cooling-maps {
+            };
+        };
+    };
+...
-- 
2.35.1

