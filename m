Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D032532D82
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiEXP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiEXP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:28:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D206F62211
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t13so7044212wrg.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2Kq4AjX60Auvs3EuDkJuXpELchmlwLWXQGbXPVKMFg=;
        b=MaqBpO0pzw2Nv86cZdqlL2ALSDFOV1BK9LgFUwh35kTr5l0ZencTSTkfJUfpzHwq4A
         LZNnnNo4Zc7/yvDJ1AA+qsJqoF8vsxLvFmggzUmZ3J5jYs56Z/bj1NfI0oMUTFC/IcMw
         A9a6feB5qVngeQMPrdhkk5bM3jqtrnhSwpr+EGbm2w0cPK8Crl381CE7ZLc6ma6SjgqY
         Vh5VpS57UfOIivGNOEOPheHHd29CzvCa6rUM/gr/Cw8fXNJq1J/qr4O9AXlq0bnRlruP
         mADsDpqLi9PDK5UBvn8ADQNFzFPEWEEP+h70O9ijS0SmGSyYgB8cwcUf4KPSnYs9rKFv
         ge3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2Kq4AjX60Auvs3EuDkJuXpELchmlwLWXQGbXPVKMFg=;
        b=QAs8IvcbNaSesPJ//qahIuLBjcUfdljNanSYB6qKodeO94QrwmQvSvd7UFgMY1RWDf
         zLRXIFMIclkrZdwyjYqG8vE14YX3UGnuzoWF57RdwZ6EmEERIMWYuqQ34D810rWirjL5
         +wt9gRHf+Rr/uz/jYcyzwLgXIJE3I17hoa3JyOanOJgwMKmbyL0zlKnnnqyUBtBdBNN9
         31DwHxxbNrqCnpgNpNXtW3Jz+Ab7pz8VO9jPTJmbGP3X2r/ZDX0q0xHGaDXGwCPwpiPy
         xpyeA6mHf+c3JkUiJY85J/ylntCzmEyqvFnjrRM0Bj9f1MPvL/2VRxwVlkQcXScVCE1u
         pzdw==
X-Gm-Message-State: AOAM533YtS9l1VNhhQkjaZfNcw0G6MrwzpWGZxyyZgGtfCBvdmrq8P+H
        umIkZ0diHu/pUH4DubEQ3VHrRQ==
X-Google-Smtp-Source: ABdhPJzhL25As+aiDUdp92860cR8SXhTp4IGDzPkkcaizWyOIZvd4NfNBonbrx5zCl7T9cfzyR+7Mw==
X-Received: by 2002:a05:6000:1541:b0:20f:e8f0:be4e with SMTP id 1-20020a056000154100b0020fe8f0be4emr6471819wry.658.1653406085387;
        Tue, 24 May 2022 08:28:05 -0700 (PDT)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003974027722csm2703693wms.47.2022.05.24.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 08:28:05 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v7 2/6] dt-bindings: thermal: Add binding document for LVTS thermal controllers
Date:   Tue, 24 May 2022 17:25:49 +0200
Message-Id: <20220524152552.246193-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152552.246193-1-abailon@baylibre.com>
References: <20220524152552.246193-1-abailon@baylibre.com>
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

This patch adds binding document for mt8192 and mt8195 thermal
controllers.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../thermal/mediatek,mt8192-lvts.yaml         | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
new file mode 100644
index 000000000000..914c877d1f2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/mediatek,mt8192-lvts.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC LVTS thermal controller
+
+maintainers:
+  - Yu-Chia Chang <ethan.chang@mediatek.com>
+  - Ben Tseng <ben.tseng@mediatek.com>
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+  - $ref: /nvmem/nvmem-consumer.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8192-lvts
+      - mediatek,mt8195-lvts
+
+  reg:
+    minItems: 2
+    maxItems: 4
+
+  interrupts:
+    maxItems: 2
+
+  clocks:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  nvmem-cells:
+    maxItems: 2
+    description: Calibration data for thermal sensors
+
+  nvmem-cell-names:
+    items:
+      - const: e_data1
+      - const: e_data2
+
+  resets:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+
+required:
+  - '#thermal-sensor-cells'
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - nvmem-cells
+  - nvmem-cell-names
+  - resets
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
+    lvts: lvts@1100b000 {
+        compatible = "mediatek,mt8195-lvts";
+        #thermal-sensor-cells = <1>;
+        reg = <0 0x1100b000 0 0x1000>,
+              <0 0x11278000 0 0x1000>;
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+        resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>,
+                 <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+        nvmem-cells = <&lvts_e_data1 &lvts_e_data2>;
+        nvmem-cell-names = "e_data1","e_data2";
+    };
+...
-- 
2.35.1

