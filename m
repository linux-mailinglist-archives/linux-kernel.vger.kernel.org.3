Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213AC55528F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358452AbiFVRhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbiFVRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:37:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4030D3465E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:37:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y6so15999882plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip37DPD07EETfXOxsfp2/EM6PqDmL5lG+cbJGq8qMS0=;
        b=ZPHnCjyjvUbujGkd26KmywiDqMZnRn48AeNxI9NqxorRJckmyQ2rnpsqvG9X4vPxNh
         u1wNPA+vvIAxgPsOKZUUdMFB8CrSxzONRQmtkdNpmliEFOwYNtDAh8RUvR/b3uHqaZt2
         h1n/g5chy8zFgcrmI2Y6OwlWY7m9sjIvjyM0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip37DPD07EETfXOxsfp2/EM6PqDmL5lG+cbJGq8qMS0=;
        b=KvGIFGTJBWgM7EgE2K3TrS70fxAXjtc7VqUvRAHeOY6+2pthULJl9hr6zvDLnM4jSt
         /I3weYRXh3cXx4sFUtazmwW7t2g+6flcLhmpuruZUq1D945x08JHN1E5v7uS1U+g45IP
         E+WL9FybT/CUMFPXu8i6AIti+/W/x/w1duJhsekRM7HuSW+k6D4VmdP/MA0GlphXHIP/
         tyW9yNGseOG3tVUTwR80WZr3nZEWGmHJu6t3mgp1YQtqB/xpZvClylsxnYJ5r8r7+lBd
         lbBVenMRtSgyMpgbCDhKV/n1MzTyi7hqOr3qdiKfizEU35v9c1v7zRhBg+EdM/gEAMVm
         g+Ag==
X-Gm-Message-State: AJIora/oGdKnij8qMkGwaZgF7T+fB7+wjYipucwBUE8OmM5mFBc6mE7s
        oC1d/sqVju956LEiE/KKGiSF4DsbB8fdgA==
X-Google-Smtp-Source: AGRyM1vsXsxyT7P5XEC2KEN3AdZUJCoJzWRcoryprlb4+a2186xYoUq1U1dIzCQjIjHiHaFAJrvmhg==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr50693283pjr.62.1655919451266;
        Wed, 22 Jun 2022 10:37:31 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090b079100b001ece55aec38sm35470pjz.30.2022.06.22.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:37:30 -0700 (PDT)
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
Subject: [PATCH v5 1/9] dt-bindings: usb: Add Type-C switch binding
Date:   Wed, 22 Jun 2022 17:34:30 +0000
Message-Id: <20220622173605.1168416-2-pmalani@chromium.org>
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

Introduce a binding which represents a component that can control the
routing of USB Type-C data lines as well as address data line
orientation (based on CC lines' orientation).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v4:
- Added Reviewed-by tags.
- Patch moved to 1/9 position (since Patch v4 1/7 and 2/7 were
  applied to usb-next)

Changes since v3:
- No changes.

Changes since v2:
- Added Reviewed-by and Tested-by tags.

Changes since v1:
- Removed "items" from compatible.
- Fixed indentation in example.

 .../devicetree/bindings/usb/typec-switch.yaml | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml

diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
new file mode 100644
index 000000000000..78b0190c8543
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/typec-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB Type-C Switch
+
+maintainers:
+  - Prashant Malani <pmalani@chromium.org>
+
+description:
+  A USB Type-C switch represents a component which routes USB Type-C data
+  lines to various protocol host controllers (e.g USB, VESA DisplayPort,
+  Thunderbolt etc.) depending on which mode the Type-C port, port partner
+  and cable are operating in. It can also modify lane routing based on
+  the orientation of a connected Type-C peripheral.
+
+properties:
+  compatible:
+    const: typec-switch
+
+  mode-switch:
+    type: boolean
+    description: Specify that this switch can handle alternate mode switching.
+
+  orientation-switch:
+    type: boolean
+    description: Specify that this switch can handle orientation switching.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph binding modelling data lines to the Type-C switch.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Link between the switch and a Type-C connector.
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - ports
+
+anyOf:
+  - required:
+      - mode-switch
+  - required:
+      - orientation-switch
+
+additionalProperties: true
+
+examples:
+  - |
+    drm-bridge {
+        usb-switch {
+            compatible = "typec-switch";
+            mode-switch;
+            orientation-switch;
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    anx_ep: endpoint {
+                        remote-endpoint = <&typec_controller>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.37.0.rc0.104.g0611611a94-goog

