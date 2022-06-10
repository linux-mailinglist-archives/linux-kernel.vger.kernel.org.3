Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99BD546E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350489AbiFJUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348862AbiFJUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:40:51 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E5C8BC1;
        Fri, 10 Jun 2022 13:40:49 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id y16so158827ili.13;
        Fri, 10 Jun 2022 13:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nAvb3P2a4wY9hENy4s31EHxLoq20t7wJfzc0k0RgVzg=;
        b=sXJd1rHeWaVGzvwuOH9aNHmQYAOFvL2Hg/R1lvsB/qjFndRFGiaIMCnNqiatzpMLrZ
         G0oK1kkp5xtTV3u+lUyvWqk/vKAFiguYbFNcJZg3qGs0h6grinTBX63GrOPF6LcXFaMy
         tp+Zv11R5hmuKAp61qGgDCTTUtXvB5L7vUpj5PjDHnjwBcl1S82+XuwWtemF8jNTNVVi
         35TQT1WHAZpToY6AQKMUrCxHmRm9WlPY1wVWVY8zBsc4oLLIz/2rmXtkkVEVvgpYqani
         /kh/iLb9CkhsobZCNyqEtk99d0BS9r7mosyPp8xPVI6k2REC04csDFD+eRrBN8Kp5w+I
         PhHw==
X-Gm-Message-State: AOAM5302H2UFlseDmqdWtM0WsoL97ErXnkVjVmIiYcDxce+gs7f/DE8U
        lpI9fIicsnUTPcPqJWnD5lCxWO7SCw==
X-Google-Smtp-Source: ABdhPJwZ9K+rp8XDD+tCC6aqdUSu0IC1lm7lUFxEz2sIOi9p74vhZUp78IrbD4m/aSzN6nklbR8iMw==
X-Received: by 2002:a05:6e02:1c88:b0:2d1:87ea:18c with SMTP id w8-20020a056e021c8800b002d187ea018cmr26193110ill.321.1654893648351;
        Fri, 10 Jun 2022 13:40:48 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id x15-20020a02908f000000b0032e8c565e12sm23772jaf.109.2022.06.10.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:40:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: panel-simple: Add Arm virtual platforms display
Date:   Fri, 10 Jun 2022 14:38:18 -0600
Message-Id: <20220610203818.2193593-1-robh@kernel.org>
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
 .../bindings/display/arm,pl11x.yaml           | 15 +-------------
 .../bindings/display/panel/panel-simple.yaml  | 20 +++++++++++++------
 2 files changed, 15 insertions(+), 20 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 21ba90c9fe33..97afd276c54a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -19,9 +19,6 @@ description: |
 
   If the panel is more advanced a dedicated binding file is required.
 
-allOf:
-  - $ref: panel-common.yaml#
-
 properties:
 
   compatible:
@@ -35,6 +32,8 @@ properties:
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
       - ampire,am800480r3tmqwa1h
+        # Arm, Ltd. Virtual Platforms Display
+      - arm,rtsm-display
         # AU Optronics Corporation 10.1" WSVGA TFT LCD panel
       - auo,b101aw03
         # AU Optronics Corporation 10.1" WSVGA TFT LCD panel
@@ -340,9 +339,18 @@ properties:
 
 additionalProperties: false
 
-required:
-  - compatible
-  - power-supply
+allOf:
+  - $ref: panel-common.yaml#
+  - if:
+      # Most 'simple' panels must have a single supply, but a virtual display does not
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,rtsm-display
+    then:
+      required:
+        - power-supply
 
 examples:
   - |
-- 
2.34.1

