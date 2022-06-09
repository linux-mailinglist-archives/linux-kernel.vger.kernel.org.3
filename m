Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6645453F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbiFISRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiFISRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:17:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA7D3B1E8E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:17:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r71so22611659pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hU6Im3vb1keVHVlY7TcHchEc2Qgf7bjh4PzS2LAsp0g=;
        b=UptN1Jr96I8pLOyRcmzeta9p2WveOwoPhhXgeRA7kM9cI69tEGxnQCJAtBRXxvWhlo
         Rn+Zv7iVzfdyTpBslG9yo/0iXXDJuo5vIHo5/6V0jyzg5tKmcFOEjk9i67KRqMQfc6wx
         mKFigbgfsH0ZXEoxgFBmfHafg8B4ipYc1phjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hU6Im3vb1keVHVlY7TcHchEc2Qgf7bjh4PzS2LAsp0g=;
        b=VrlbVtFgs+5pHGUKNNzwz2NCnoZENvzYSNBJSX4qPv1AWwzPM2akx7IvpN0tmZwNsB
         r11VPNeyt4lH5vZIOIp0YpKgiD857niqoMxAs9CDiSdylaK7zcZ+EpTPlj3lI2XWAssX
         pSyt4urEdgivDGLgiUyOD1mm1D1yu4lRD6d+j/litjSEuYYZeuXMbCZOgePzHD0OCBV7
         7YJ/iU8IWTJRhflR3KGZFdL76PD/BbnkMGkjuoSFfzy5/76CFcGt8sXVG1ys0dyvoFHo
         aP1RoE8B/0VAVATL4XUGskX4VvxF6kIOaGO3EJ+gv4Y/uliKdaBm2O5tPUsD4qNXj7M1
         vPGg==
X-Gm-Message-State: AOAM530fInP4g8VEa9an5OoB0eZKBnJRrAUpTYHEDuZDzbg0QiYzJLbC
        4napVqWtLE1Cro8QdtQWehPn/1s7ctsIxA==
X-Google-Smtp-Source: ABdhPJz2vJgUxsLAZYPstcdskHIS7FJzu4/qiYfO60Xj6S8dALbWGNZF34CISl4QlQBx7EQS+mZUBg==
X-Received: by 2002:a05:6a00:10cc:b0:506:e0:d6c3 with SMTP id d12-20020a056a0010cc00b0050600e0d6c3mr41488331pfu.33.1654798668551;
        Thu, 09 Jun 2022 11:17:48 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b003fb0354c43asm17728049pgj.32.2022.06.09.11.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:17:48 -0700 (PDT)
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
Subject: [PATCH v2 4/7] dt-bindings: drm/bridge: anx7625: Add mode-switch support
Date:   Thu,  9 Jun 2022 18:09:43 +0000
Message-Id: <20220609181106.3695103-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220609181106.3695103-1-pmalani@chromium.org>
References: <20220609181106.3695103-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analogix 7625 can be used in systems to switch USB Type-C DisplayPort
alternate mode lane traffic between 2 Type-C ports.

Update the binding to accommodate this usage by introducing a switch
property.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v1:
- Introduced patternProperties for "switch" children (suggested by Krzysztof Kozlowski).
- Added unevaluatedProperties descriptor (suggested by Krzysztof Kozlowski).
- Added "address-cells" and "size-cells" properties to "switches".

 .../display/bridge/analogix,anx7625.yaml      | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 35a48515836e..cb4a23391244 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -105,6 +105,33 @@ properties:
       - port@0
       - port@1
 
+  switches:
+    type: object
+    description: Set of switches controlling DisplayPort traffic on
+      outgoing RX/TX lanes to Type C ports.
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      'switch@[01]':
+        $ref: /schemas/usb/typec-switch.yaml#
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
@@ -167,5 +194,41 @@ examples:
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
2.36.1.476.g0c4daa206d-goog

