Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67456B096
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbiGHCTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiGHCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:19:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B550274343;
        Thu,  7 Jul 2022 19:19:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b2so15196765plx.7;
        Thu, 07 Jul 2022 19:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQUS1uH91aVB+0XmXBENBE6FQndufm4Tu4vHhSYzrys=;
        b=VP310OkbcIo5wULkEMRYyC8Jn48+GGgcFkvppM0u4eayWjHH7Uk/rFRsGkUFjJ3mCO
         XOTxGFDYZ9Z4b8SuEhSmi3NbIvH4VeU7tauefXlcOoI29cgT4MjfQZRkOP43eP2SiWTH
         soTTMFf8Ytc/SaoyQyb93krx13oQSkGiTgAbCBmqMiXrMnjzAB1rBs5s+9/HSUNj6iWG
         qI7KuFzQcu33Em4UDvukzPEVv+zgNHNhgw6mgkcPtmzEIj6y2ZyrIOIAnd1OHnQy+weg
         Oye9HksqfYbWnv9rzhbbaD/kpJFd0ooLga6Iz0k+se4ct/MZ6eskBVitHO48uzmpW8nJ
         LPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQUS1uH91aVB+0XmXBENBE6FQndufm4Tu4vHhSYzrys=;
        b=w7ois+YayeQNXFIfDR0LFRo/O2+/RL1ag3bvnaRwWrflZ0JFPb9ulJx26IUpamIXTZ
         JQ8gOz5WOB2UwRsF+OMi4EiHAHv8Zjhh/kcamG51nPAKfW9jYmVfrkFuavK0ssmXcGs7
         Qs3shgawZm4xxH+8LSvdFZvANTmPjZbdmCsWxd4Jq5fSauWR2K4HOtN/4Y0Rj+O5lRMU
         S4wYFdAc5nguVo6T0dWP22sKvAqUjesfblDg5+AXx+dLbWtZHf+zOeosNN7ZNJCSZIo5
         30yfiDukRH4Njai9Wx5xHbn191kggUzjKtURJa1ArxDi2zWygsx7zzfTiPZ04MD+Dvuw
         9EoA==
X-Gm-Message-State: AJIora/1sk8jNEgM/NOiqFhIlj0MVBlVHXrmdrC1J52+X8uaUTBQNLqM
        ajVnNrVDCDfCmx2GLeQ3V/A=
X-Google-Smtp-Source: AGRyM1sDsSK9Mdd7E9ePhl3agk2mvYgX9I66p/yZJNZ2D+EGlTvaLBMJweE1+Ro+nVEg+T5N51uRPA==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr8912325pjj.82.1657246758218;
        Thu, 07 Jul 2022 19:19:18 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0015e8d4eb1dbsm12678820plg.37.2022.07.07.19.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 19:19:17 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: display: panel: Add Novatek NT35596S panel bindings
Date:   Fri,  8 Jul 2022 10:18:24 +0800
Message-Id: <20220708021824.9167-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708021824.9167-1-mollysophia379@gmail.com>
References: <20220708021824.9167-1-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for "novatek,nt35596s" panel.

Signed-off-by: MollySophia <mollysophia379@gmail.com>
---
 .../display/panel/novatek,nt35596s.yaml       | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
new file mode 100644
index 000000000000..937b194a6f18
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt35596s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT35596S based DSI display Panels
+
+maintainers:
+  - Molly Sophia <mollysophia379@gmail.com>
+
+description: |
+  The nt35596s IC from Novatek is a generic DSI Panel IC used to drive dsi
+  panels.
+  Right now, support is added only for a JDI FHD+ LCD display panel with a
+  resolution of 1080x2160. It is a video mode DSI panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - jdi,fhd-nt35596s
+      - const: novatek,nt35596s
+    description: This indicates the panel manufacturer of the panel that is
+      in turn using the NT35596S panel driver. This compatible string
+      determines how the NT35596S panel driver is configured for the indicated
+      panel. The novatek,nt35596s compatible shall always be provided as a fallback.
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be 8mA, gpio
+      can be configured using mux, pinctrl, pinctrl-names (active high)
+
+  vddi0-supply:
+    description: phandle of the regulator that provides the supply voltage
+      Power IC supply
+
+  vddpos-supply:
+    description: phandle of the positive boost supply regulator
+
+  vddneg-supply:
+    description: phandle of the negative boost supply regulator
+
+  reg: true
+  port: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - vddi0-supply
+  - vddpos-supply
+  - vddneg-supply
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "jdi,fhd-nt35596s", "novatek,nt35596s";
+            reg = <0>;
+            vddi0-supply = <&vreg_l14a_1p88>;
+            vddpos-supply = <&lab>;
+            vddneg-supply = <&ibb>;
+
+            backlight = <&pmi8998_wled>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+            port {
+                jdi_nt35596s_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.37.0

