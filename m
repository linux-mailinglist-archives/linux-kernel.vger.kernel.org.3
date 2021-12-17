Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87372478F25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhLQPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhLQPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:09:22 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81921C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:09:22 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so4296492wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cA5Bx+I+AGs2RfGY4hpgrqrPI8r6zTFIuO5ZwQf2Zak=;
        b=toL2v1mg/OkMSznV2NPL+e6xhb1dTHXYjRr/KURTTyUhKGpWlGy4psR4aVyUZ6TR4/
         HNXEur/I9Xev153quDM4MQq8RtmSmF8YDw7pGBPz/OjEsiyoOI+BHoZBgx/YCZBB25xE
         01BSlpSB4+3ndaRsjlYMZz7FYUY9lfZDftPLJSK11BLauq6ZsMs3VBh8xFRYz5zc+s8K
         nrAQkfRWSVfJYGqpZTV11mU7RsfB0+AzYlCdVWZyT9JTQtHv1cl5D/OO2PCVa36winm6
         lFsxMXVmhYA4+x8xuZKijkbmNX/LZA14U5SkWYVkYyT/HiC5vPaJX/bXZt/v6w0qRbEJ
         MRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA5Bx+I+AGs2RfGY4hpgrqrPI8r6zTFIuO5ZwQf2Zak=;
        b=clx/tu3pm1Std1IFJV0IWnJ/jxcuQ2OcCesJN3vwpzt116pAsCq8r2fJmFo+T/055O
         8vpCeCo7Gdrgwe7xfcyPesegQFmeb41H7TKvtSMJX85L1jhgu5Wk7nfWwoJT0ERw9gx5
         IbhV9HfgDkZuoYthryOANfez08wLeuk0nnOlPNQCPxRHwAfNORPxRpNPQJ15VIFpeimM
         tpQZDRDJWGP9g6IuDrLH/yMOG3vfDG8qb8gr1x8UmX7NEkxQzCxTVauAJ1oHqMrjjt9x
         7c8mgMPjjo4wwO9T7FhY/Imz+9THO+Qza20+t/CdfYhrBglwL688qHYKdTBCA7Ug+86B
         sqWQ==
X-Gm-Message-State: AOAM531tgvKkuE9stJYR0vmw4SYchtGqrfMx6XeyEhD+EqgKguBUUMOj
        L2at2k6n4ZdwKK73sDatAPuhbQ==
X-Google-Smtp-Source: ABdhPJw2QIwL+JN1BE/ytNuThS3hvqjbyhJk1gG3get4Uk4bFSMW9drCtD5/xxhsEnmjYhGJnW27og==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr2832923wrx.569.1639753761014;
        Fri, 17 Dec 2021 07:09:21 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-6441-43a4-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6441:43a4:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id g18sm12655132wmq.4.2021.12.17.07.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 07:09:20 -0800 (PST)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 2/8] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Fri, 17 Dec 2021 16:08:48 +0100
Message-Id: <20211217150854.2081-3-granquet@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211217150854.2081-1-granquet@baylibre.com>
References: <20211217150854.2081-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

This controller is present on several mediatek hardware. Currently
mt8195 and mt8395 have this controller without a functional difference,
so only one compatible field is added.

The controller can have two forms, as a normal display port and as an
embedded display port.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/mediatek/mediatek,dp.yaml         | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
new file mode 100644
index 0000000000000..068b11d766e21
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Display Port Controller
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  Device tree bindings for the Mediatek (embedded) Display Port controller
+  present on some Mediatek SoCs.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-dp-tx
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: faxi clock
+
+  clock-names:
+    items:
+      - const: faxi
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input endpoint of the controller, usually dp_intf
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output endpoint of the controller
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/mt8195-power.h>
+    edp_tx: edp_tx@1c500000 {
+        compatible = "mediatek,mt8195-dp-tx";
+        reg = <0 0x1c500000 0 0x8000>;
+        interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
+        power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&edp_pin>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                edp_in: endpoint {
+                    remote-endpoint = <&dp_intf0_out>;
+                };
+            };
+            port@1 {
+                reg = <1>;
+                edp_out: endpoint {
+                	remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.32.0

