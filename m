Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59B549BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbiFMSiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244943AbiFMSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:37:57 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF2D31B2;
        Mon, 13 Jun 2022 07:57:29 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id a10so6323105ioe.9;
        Mon, 13 Jun 2022 07:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vf+DFErkUOgrAEhjpjh0uyrSpN6w360tMGoM1ti+yys=;
        b=6CG+ld3pkjACJl2yk7I+NDt4ywuk+L0Br+fzzIe3U4JHoeArs6PUccbBGe05vLXl9x
         66QtZlwiQaPOyKmBfZc+fJ8ESUkVaJi+vSpZBEFZzI0LyH9k9Voa5A1atb9awoGn4Fha
         CGk8HdjUnmlzLjf2uCC5AJ+GS2qlD67EcotrhXFzJAR4oyWsMM0py1RXqTHU9BDYixiM
         YJLH2cCDvS0ZXJS/wX6hvtQyO3SGD31/GhZHVr7WnAzbv6FyWjIHKhdeXURai++7KiBc
         RvXdw9jTjtL1Azqebzrs8xjYGP2N9Is/OQ0OJDb7zNkOl5GVWWgvbnPahD2ZHxlOGJ+J
         GDXA==
X-Gm-Message-State: AOAM532x5GtocEsvwC3GSd4TitUtTXFs+CDhUbJ2G/Oo9tHiRSawCxxi
        ExYO8k43YXb0cdDBEbKQpg==
X-Google-Smtp-Source: ABdhPJzNK3lR7+aIWGt4CeK//NM/uOVYLfLtmdaCa2ptBKeLbsW/SJRNSxVYoMpUUqHSdrnJuYru0w==
X-Received: by 2002:a05:6638:3787:b0:331:aaf5:950c with SMTP id w7-20020a056638378700b00331aaf5950cmr121036jal.118.1655132248369;
        Mon, 13 Jun 2022 07:57:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id r6-20020a924406000000b002cde6e352f8sm4009929ila.66.2022.06.13.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 07:57:28 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: display: Add Arm virtual platforms display
Date:   Mon, 13 Jun 2022 08:57:09 -0600
Message-Id: <20220613145709.3729053-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'arm,rtsm-display' is a panel for Arm, Ltd. virtual platforms (e.g. FVP).
The binding has been in use for a long time, but was never documented.

Some users and an example have a 'panel-dpi' compatible, but that's not
needed without a 'panel-timing' node which none of the users have since
commit 928faf5e3e8d ("arm64: dts: fvp: Remove panel timings"). The
example does have a 'panel-timing' node, but it should not for the
same reasons the node was removed in the dts files. So update the
example in arm,pl11x.yaml to match the schema.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Make arm,rtsm-display its own schema file instead of using
   panel-simple.
---
 .../bindings/display/arm,pl11x.yaml           | 15 +----------
 .../display/panel/arm,rtsm-display.yaml       | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/arm,rtsm-display.yaml

diff --git a/Documentation/devicetree/bindings/display/arm,pl11x.yaml b/Documentation/devicetree/bindings/display/arm,pl11x.yaml
index b545c6d20325..6cc9045e5c68 100644
--- a/Documentation/devicetree/bindings/display/arm,pl11x.yaml
+++ b/Documentation/devicetree/bindings/display/arm,pl11x.yaml
@@ -159,25 +159,12 @@ examples:
     };
 
     panel {
-        compatible = "arm,rtsm-display", "panel-dpi";
-        power-supply = <&vcc_supply>;
+        compatible = "arm,rtsm-display";
 
         port {
             clcd_panel: endpoint {
                 remote-endpoint = <&clcd_pads>;
             };
         };
-
-        panel-timing {
-            clock-frequency = <25175000>;
-            hactive = <640>;
-            hback-porch = <40>;
-            hfront-porch = <24>;
-            hsync-len = <96>;
-            vactive = <480>;
-            vback-porch = <32>;
-            vfront-porch = <11>;
-            vsync-len = <2>;
-        };
     };
 ...
diff --git a/Documentation/devicetree/bindings/display/panel/arm,rtsm-display.yaml b/Documentation/devicetree/bindings/display/panel/arm,rtsm-display.yaml
new file mode 100644
index 000000000000..4ad484f09ba3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/arm,rtsm-display.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/arm,rtsm-display.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm RTSM Virtual Platforms Display
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: arm,rtsm-display
+
+  port: true
+
+required:
+  - compatible
+  - port
+
+additionalProperties: false
+
+...
-- 
2.34.1

