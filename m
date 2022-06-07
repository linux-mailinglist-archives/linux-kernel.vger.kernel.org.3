Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30C5541FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386562AbiFGWtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381400AbiFGVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:40:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB4232A45
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:06:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 129so16760084pgc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Am5aGfsC1axZlOULyuACem/6+XgiQ9wXJ5AxdoUZZyw=;
        b=BGOwhJTnVdp3I5vsGAiMaSPty5yVDLkvo0iFxUWaRbLO48HZDG2m2g31IRd/i61RJD
         cplVpC/n6+a9WUpARLyGuyHaIrbjXSGdtTeLPzgvpeOYyuGy2atgUBjtc6b4N1vAcdt6
         wabuMv7xZ2cpk1nStoT2ujhjkI+PBH8IM/Bvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Am5aGfsC1axZlOULyuACem/6+XgiQ9wXJ5AxdoUZZyw=;
        b=2GJPde3jizG2IAtOWu3T5Kk4eZHks4ZHfCHu3wbQYxlHhvNah1kxITxQjHV679XbKI
         Wyt3nau/T1LchYGyKcSXlIDjX6Zi8lnD5ZQW8vyx+UBkZMlxy8DmlbS27zKst73//eFa
         vMe8hWR3MeExaK4B2JaiGwGXrvl3HJUw/R/0S6pJQZKPhsmXe3v/+22J6Tx/zfzwtK0r
         ptC8LYlhELMPOWXaheJDKigCMS7Q203qj5qaynsOo0kyZEHU3Ty+O6Kl9k/ynx+u3NiQ
         54QEGZab1bjI+4IEwG+MEvgBMXOkKY3zd2GuHwNu1CtSGvE3i3GjyvA/1WjWfwQ6gF9q
         iecg==
X-Gm-Message-State: AOAM531RVBYQqjjyv33+0XmAUaHB/TbNzWgBL2O2i5PxXglCERALMHD+
        JjyuvrJctZo/SyNIoE1Uo2DoH9iyN6id+w==
X-Google-Smtp-Source: ABdhPJwK88zzGqSUFlf6HNcaHNY6NeEJA3B8fT0RLY7q7mLsnknl0nXD4wTz+3eWL0ef64qxs1Ro+w==
X-Received: by 2002:a63:2c89:0:b0:3fe:1c0a:75d2 with SMTP id s131-20020a632c89000000b003fe1c0a75d2mr2077597pgs.310.1654628809959;
        Tue, 07 Jun 2022 12:06:49 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm13236084pfq.120.2022.06.07.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:06:49 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH 3/7] dt-bindings: usb: Add Type-C switch binding
Date:   Tue,  7 Jun 2022 19:00:21 +0000
Message-Id: <20220607190131.1647511-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220607190131.1647511-1-pmalani@chromium.org>
References: <20220607190131.1647511-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 .../devicetree/bindings/usb/typec-switch.yaml | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml

diff --git a/Documentation/devicetree/bindings/usb/typec-switch.yaml b/Documentation/devicetree/bindings/usb/typec-switch.yaml
new file mode 100644
index 000000000000..60a600a63fef
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/typec-switch.yaml
@@ -0,0 +1,76 @@
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
+    items:
+      - enum:
+          - typec-switch
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
+    anx7625 {
+      typecswitch {
+        compatible = "typec-switch";
+        mode-switch;
+        orientation-switch;
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            anx_ep: endpoint {
+              remote-endpoint = <&typec_controller>;
+            };
+          };
+        };
+      };
+    };
-- 
2.36.1.255.ge46751e96f-goog

