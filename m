Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E924CC1D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiCCPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiCCPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:44:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA6155C28
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:43:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so633010wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvgDxfixSnBIC4U2Qx+y1rXDt5KCfDdRN+geS33dt8U=;
        b=LJc5EsSRKwC/y9D83XKQh92YQEPc97j9frFC9tKxEC7VHc8L47EtFEbGsT3Sxd4XY1
         5Z4jMy5Ff16QFqtE3aX01uwhWI6fLiGxl9VXwHyCHI5unMneXInPdmONYuWOEhZ747sN
         COn1suGOQslk19IZgEMRzpqDvWjiQP6BxcXzruD1nvgbLRYrkyQB6bvCvoOoubtJlqAE
         hb+hSY7/o03G5mO3T6wvwkYjUYL+/EYEmMqBQLR0S/HZprBmOlo8lFVpSJ/ayS80sA9O
         3WJTK1K08gLAKX/e95L0ed02Vj2WpB6GNff4Bu8zyHLnvTYGjk61RF5UskHNYTffbKVm
         +tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvgDxfixSnBIC4U2Qx+y1rXDt5KCfDdRN+geS33dt8U=;
        b=tBTp2faCkZ9U5LIWvlXK6k7KnKku9GgiCPuM/uMYh9+205PCGaOuEy2Zz65qfw93kN
         ci7lTw/R0BpbmyF+SRvWsSt4dIOeeYnAzA0J7+kU0UkMJURUiYQNWFCJKrbjXWFugDmP
         o+OiQBuFDZmRQHv88rI7MoRWUq8R2Oy7oRHNTbPtqE7Spf43GhFf6BBFrMSgKiEAOGU9
         WLnVG3SgU+4jwDzPjQNLuAb9RhW4/09QVbiMSa1zckpKjza2JFq87qDCVDQjleiWXRo9
         6USaZ7xmDKa1B+IszJpaKzEKsHem1aevgxJbdDBC2VGtGK9OScz+MX2GFJ9FqV6++i5q
         Zpow==
X-Gm-Message-State: AOAM5306ib3ij1QxJ+rBaqsIn5ffNtB0ypGStJPzQGisnR3kQpuH7x8+
        Zr/T5uBp8XMbpumyqLs4tJH2gg==
X-Google-Smtp-Source: ABdhPJyKxcIjDMZvDj1Q88hFM1nS7uCRsMbcaWtJ8QIvbD9LrP9UTTU0vAwO2xjUAHNha8wkdlZB5Q==
X-Received: by 2002:a05:600c:3b83:b0:37c:e735:ad87 with SMTP id n3-20020a05600c3b8300b0037ce735ad87mr4134101wms.120.1646322188478;
        Thu, 03 Mar 2022 07:43:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb19:8b2c:5e00:e059:ffd7:be1c:ef2c])
        by smtp.gmail.com with ESMTPSA id d8-20020a056000114800b001f045f3435asm3272452wrx.108.2022.03.03.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:43:08 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v21 1/3] dt-bindings: input: Add bindings for Mediatek matrix keypad
Date:   Thu,  3 Mar 2022 16:43:00 +0100
Message-Id: <20220303154302.252041-2-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303154302.252041-1-mkorpershoek@baylibre.com>
References: <20220303154302.252041-1-mkorpershoek@baylibre.com>
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

From: "fengping.yu" <fengping.yu@mediatek.com>

This patch add devicetree bindings for Mediatek matrix keypad driver.

Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../input/mediatek,mt6779-keypad.yaml         | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
new file mode 100644
index 000000000000..b1770640f94b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/mediatek,mt6779-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek's Keypad Controller device tree bindings
+
+maintainers:
+  - Fengping Yu <fengping.yu@mediatek.com>
+
+allOf:
+  - $ref: "/schemas/input/matrix-keymap.yaml#"
+
+description: |
+  Mediatek's Keypad controller is used to interface a SoC with a matrix-type
+  keypad device. The keypad controller supports multiple row and column lines.
+  A key can be placed at each intersection of a unique row and a unique column.
+  The keypad controller can sense a key-press and key-release and report the
+  event using a interrupt to the cpu.
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt6779-keypad
+      - items:
+          - enum:
+              - mediatek,mt6873-keypad
+          - const: mediatek,mt6779-keypad
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
+      - const: kpd
+
+  wakeup-source:
+    description: use any event on keypad as wakeup event
+    type: boolean
+
+  debounce-delay-ms:
+    maximum: 256
+    default: 16
+
+required:
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
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        keyboard@10010000 {
+          compatible = "mediatek,mt6779-keypad";
+          reg = <0 0x10010000 0 0x1000>;
+          interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_FALLING>;
+          clocks = <&clk26m>;
+          clock-names = "kpd";
+        };
+    };
-- 
2.32.0

