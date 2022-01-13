Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFB48D2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiAMHcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiAMHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:32:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C8C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 23:32:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id l15so8366653pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 23:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJ7jhTxZtYx2s5hY3iEvxpmsU4PPvMVmZGrdRkEcvPI=;
        b=IJSx48yyim2T+/autKNyiGUP5WVCIa2LnzXnNoCi6Gr8LHqpcsTey0lxosDSWWukoQ
         Itwtn9aJjQ8QeRk28BDdMwEOfJrG3FrUz3yPlgbA3Abg3QwKfQW5QmZvkriKl39DdQQU
         MwSLZ6ACdE1JK6QSgl/1slJLqLO9rP6cq5P8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJ7jhTxZtYx2s5hY3iEvxpmsU4PPvMVmZGrdRkEcvPI=;
        b=ggMfeOyxDCjABv92aY0DmFuIP5CBB5kqxs2YOdRBkwOnjwDujdE0XG3IxBOxA5/ZyV
         LRPhnHLZ6kVO2QibPkNeRIN1i9KPlhUdbm53R6PqX78dn2RXYhdR26Ps+JSniz0Vt+g3
         V9387F0KkmbpdURt4mm7fHGWiBMyOLEmRixGoxCGD6vdwDgY/vX/a+ys5khfrhKVr+cK
         br/7y6kqck+DxZsG7QlKQ5980+2Ky9J7/iwiqPQ7f3bjQwg6zwFADb9yXGT1tD6aIEaW
         l8Aj2UdXwu78DlL9r7Aiwx1rstzedcL6pGeFoVxHk9ssG4aeMlxW2lQEPsfs9JJqpiog
         m0iA==
X-Gm-Message-State: AOAM5323FKVJ/qTyeJO+KkpIZXbVEak1JExomHBJdJhkRtBuwax2EPmQ
        HnQiENC3v4KjukvUGf7Ra7HAUg==
X-Google-Smtp-Source: ABdhPJziGsBxli+6Iq6w6hS+WQ2CJbZK7AzLfAwT/ACq/ydScWMRWwiOoZBeFrG0UOgEMIqdg1xPcg==
X-Received: by 2002:a17:902:904b:b0:143:73ff:eb7d with SMTP id w11-20020a170902904b00b0014373ffeb7dmr3518103plz.85.1642059129830;
        Wed, 12 Jan 2022 23:32:09 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3ced:e0da:4852:430c])
        by smtp.gmail.com with ESMTPSA id om3sm7747701pjb.49.2022.01.12.23.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 23:32:09 -0800 (PST)
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
Subject: [PATCH v2 3/3] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Date:   Thu, 13 Jan 2022 15:31:58 +0800
Message-Id: <20220113073158.2171673-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220113073158.2171673-1-hsinyi@chromium.org>
References: <20220113073158.2171673-1-hsinyi@chromium.org>
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
2.34.1.575.g55b058a8bb-goog

