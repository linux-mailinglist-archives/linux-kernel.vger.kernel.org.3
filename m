Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D194A85DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351039AbiBCOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351059AbiBCOKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:10:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C8C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 06:10:39 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id t9so13063plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ye0S9ZGhY+9EmUZN3Zyu0p+11AX+B8bmbaaOWhr2T0c=;
        b=STDUWwb7a/y85Ok/NB5I7fhKge4GwjC4knpXMRyn9PW8JuUjtD7b56eE/ncs7hF9U6
         JS5nlLRclPPFsDEZbVjsJUoEHgBJ5osV5YnHkwEN891F1RH3DX/Dn0KFYZ9SNOFMlq0P
         ANg5M0M5z7FaE1kLG+qErqJvc3obODs7RZI4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ye0S9ZGhY+9EmUZN3Zyu0p+11AX+B8bmbaaOWhr2T0c=;
        b=UbekyCMXniTM/8cokRB5R67E9pHBcvgp2f8sA7tfLVPkLOzQOZtZPGyckuGMxkfP00
         DD6rYSJMZkArois9bMRbZ5C28p0gGliRhbACop/Ig8pG6qlekKPkQqtwEABw93k6Ut3z
         akS6B55XlfdYoL0IbkYGtldxgWqTpa6pK3n+Mv9xaPTiSC+Qz6IgduM2BzHFOtFYPgGc
         5ugwIQcXhWiOQoHST9oLrbN14SGDD6VM6zVlkeLVQoxBI1FDA2XA4/USIGQ7kXwvYV2R
         jRrlwXl8PwYaG6S6FYVV4j7o8Mi1u3m1k2WvUQnT7RWT3mOjgCwLH8bImE7Q5TchdGwm
         GhJA==
X-Gm-Message-State: AOAM532o64obiNsRqhTOktC+KUrfbCzEduFY2AppmiThHnSz0Z4lbktj
        7kn6sAbF1vv3Y4jcr/mAmgu5Yw==
X-Google-Smtp-Source: ABdhPJzoYwpMxEEv91fmnBO89N5wgJxdp3QJbpKicysgnntwueXq+qnjqpTLcsJFXmHlbsX9bsA6iQ==
X-Received: by 2002:a17:902:e806:: with SMTP id u6mr37236170plg.10.1643897439187;
        Thu, 03 Feb 2022 06:10:39 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cbdf:65ae:127:f762])
        by smtp.gmail.com with ESMTPSA id w11sm29532818pfu.50.2022.02.03.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:10:38 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v6 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Date:   Thu,  3 Feb 2022 22:10:23 +0800
Message-Id: <20220203141023.570180-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220203141023.570180-1-hsinyi@chromium.org>
References: <20220203141023.570180-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List panel under aux-bus node if it's connected to anx7625's aux bus.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../display/bridge/analogix,anx7625.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 1d3e88daca041a..0d38d6fe39830f 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -83,6 +83,9 @@ properties:
     type: boolean
     description: let the driver enable audio HDMI codec function or not.
 
+  aux-bus:
+    $ref: /schemas/display/dp-aux-bus.yaml#
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -167,5 +170,19 @@ examples:
                     };
                 };
             };
+
+            aux-bus {
+                panel {
+                    compatible = "innolux,n125hce-gn1";
+                    power-supply = <&pp3300_disp_x>;
+                    backlight = <&backlight_lcd0>;
+
+                    port {
+                        panel_in: endpoint {
+                            remote-endpoint = <&anx7625_out>;
+                        };
+                    };
+                };
+            };
         };
     };
-- 
2.35.0.rc2.247.g8bbb082509-goog

