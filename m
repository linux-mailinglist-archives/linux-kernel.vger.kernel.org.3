Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA13555296
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376467AbiFVRjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359087AbiFVRjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:39:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE02CE1A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:39:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so111554pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qgh99EBxGgLNrQTAUT0hETOyP/8Bs0IDb9y71koPqbA=;
        b=SxSb10pEPpA/mENH9tzX6Cx4oRXwsEntigCH1GfQqMz3fKctzHYOnNjRXELwerRmJX
         o+ygM/XRwkGLxGi42dre8nMzn1ieuUINu8zUE7JNm+loDfEPcCz9Gdti2V1e9qLpv0Qh
         Od7ZyY1Yse22gI3/vFlHziZy/hOu+5Mt2iyz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qgh99EBxGgLNrQTAUT0hETOyP/8Bs0IDb9y71koPqbA=;
        b=YtM5k2vjSKwB4Ne7dYzRLiN7fQuwCdb3c3sy6XwPjUpGJZdNJ6gKw4tGF+5vgYbCGE
         rQ3wJLOVoS9KCOTCICAiaS3C/CT0e/bHi0IxeKAcyCYABlpqicTppM5nujXyRGCD/4Sp
         slnzld1ZwITfV4hxtBwcN5VZtic/3yUKm/Iq/R9nDKCPiaQmordXX9phYoaL7qg897iH
         U6t0sEjWNpJ5hL25ksSfGAGGBaDdfjMytG9whYopCCpuiGVCulrPnfzGqirTKvEDVtBD
         vzPLiHB09Lnb8nfZJXTwWBp1jgMvHCduya60e04NG4g/Y4XlmV9igiDnQyssqL+YLiX6
         8KaA==
X-Gm-Message-State: AJIora/oapSycPgT30xA0HXodxchQxNbdO5jzTEaRuYqA0hdS4TE8JXb
        +s7XROLhvFMws4gPRHq+8qzfpDFKp3muJw==
X-Google-Smtp-Source: AGRyM1so94Fp7yZbSDNTBz4EDR3Fp6stUXIwlclYmUkkdIYNS8v22rCU52FSM10UI+XCNclyA+LvZA==
X-Received: by 2002:a17:90a:5911:b0:1ec:9e24:c671 with SMTP id k17-20020a17090a591100b001ec9e24c671mr4854060pji.173.1655919541762;
        Wed, 22 Jun 2022 10:39:01 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090b079100b001ece55aec38sm35470pjz.30.2022.06.22.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:39:01 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v5 2/9] dt-bindings: drm/bridge: anx7625: Add mode-switch support
Date:   Wed, 22 Jun 2022 17:34:31 +0000
Message-Id: <20220622173605.1168416-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622173605.1168416-1-pmalani@chromium.org>
References: <20220622173605.1168416-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analogix 7625 can be used in systems to switch USB Type-C DisplayPort
alternate mode lane traffic between 2 Type-C ports.

Update the binding to accommodate this usage by introducing a switch
property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v4:
- Added Reviewed-by tags.
- Patch moved to 2/9 position (since Patch v4 1/7 and 2/7 were
  applied to usb-next).

Changes since v3:
- Fix unevaluatedProperties usage.
- Add additionalProperties to top level "switches" nodes.
- Make quotes consistent.
- Add '^..$' to regex.
(All suggested by Krzysztof Kozlowski)

Changes since v2:
- Added Reviewed-by and Tested-by tags.

Changes since v1:
- Introduced patternProperties for "switch" children (suggested by
  Krzysztof Kozlowski).
- Added unevaluatedProperties descriptor (suggested by Krzysztof
  Kozlowski).
- Added "address-cells" and "size-cells" properties to "switches".

 .../display/bridge/analogix,anx7625.yaml      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 35a48515836e..bc6f7644db31 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -105,6 +105,34 @@ properties:
       - port@0
       - port@1
 
+  switches:
+    type: object
+    description: Set of switches controlling DisplayPort traffic on
+      outgoing RX/TX lanes to Type C ports.
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^switch@[01]$':
+        $ref: /schemas/usb/typec-switch.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
+
+    required:
+      - switch@0
+
 required:
   - compatible
   - reg
@@ -167,5 +195,41 @@ examples:
                     };
                 };
             };
+            switches {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                switch@0 {
+                    compatible = "typec-switch";
+                    reg = <0>;
+                    mode-switch;
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        port@0 {
+                            reg = <0>;
+                            anx_typec0: endpoint {
+                                remote-endpoint = <&typec_port0>;
+                            };
+                        };
+                    };
+                };
+                switch@1 {
+                    compatible = "typec-switch";
+                    reg = <1>;
+                    mode-switch;
+
+                    ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        port@0 {
+                            reg = <0>;
+                            anx_typec1: endpoint {
+                                remote-endpoint = <&typec_port1>;
+                            };
+                        };
+                    };
+                };
+            };
         };
     };
-- 
2.37.0.rc0.104.g0611611a94-goog

