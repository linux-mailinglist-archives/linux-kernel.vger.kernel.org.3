Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB349228E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbiARJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiARJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:20:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A57C061746
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:20:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso1778345pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 01:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kp2JX1puGgzXBsvWu8HbdG09bQuSVyJ347xkXdyu4zM=;
        b=iv59fl/+TUN+el5syUDm5Q/h9mk7/lMUY0VPBIFqmNn0QRc/6edIaPvpLBE72jhAlL
         DarFZ6GtROPD9sX3dKbdtjgsvsmkQRPWJIBx7Cgn4CG8DAUa2+XxmKDSbQRcrX8pa7LZ
         MVDz20uwoFy9g2As45611p0L/nstkFWaG1oM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kp2JX1puGgzXBsvWu8HbdG09bQuSVyJ347xkXdyu4zM=;
        b=6goZVg/FZJwGCNV3jHWWNJjHbuQPzknhtfPViCgZauXxd0Vv0rAQus7DDwwKIatHWQ
         +xB9NDQd5gG0e+ZLn+teH5zTzcbM5H+iGzq8E+7B8gZ8EvUG4C1IC9tvTyIHWEFQcpxA
         dF6X1OjH/OFMWanFadTwlptOL4xeiFZOEDNEgQsFjE6HPspR+XV05EmKnV+KW+gEtmJa
         NEMu+8711s8ljuYwhekAkwVp73XI2//AO3Na/Ps5B9/ris01fLYv7Sb2JQ/8sezgzyKn
         Z6ampKNcWNvPp3CIFrYyrnzoJQjYUYaVJHQCK8hBkIEYnPc9A+FoK5hLDwSadDGB5nsR
         MVrQ==
X-Gm-Message-State: AOAM530BeumbjztGnQEDtOXixKFZiYRgOo6YNyTtS+Hd4PGKOT9LuZ31
        wPzKEKs7cBy66MJy6DAW4LS9pw==
X-Google-Smtp-Source: ABdhPJxSYdZj6GlxPX1EcP3nJedapwQ4dsYkk+FXgi6D1vUmmCz6wwa/8hmHr6JqKMsLEwhJm6YGHA==
X-Received: by 2002:a17:902:ea85:b0:14a:3c49:f140 with SMTP id x5-20020a170902ea8500b0014a3c49f140mr26185537plb.31.1642497616208;
        Tue, 18 Jan 2022 01:20:16 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:4448:8072:97f1:64dd])
        by smtp.gmail.com with ESMTPSA id y1sm14691501pgs.4.2022.01.18.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 01:20:15 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Date:   Tue, 18 Jan 2022 17:20:02 +0800
Message-Id: <20220118092002.4267-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118092002.4267-1-hsinyi@chromium.org>
References: <20220118092002.4267-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List panel under aux-bus node if it's connected to anx7625's aux bus.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Xin Ji <xji@analogixsemi.com>
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
2.34.1.703.g22d0c6ccf7-goog

