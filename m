Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF09493CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355646AbiASPSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355645AbiASPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:18:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D462C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:18:05 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c5so2880889pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kp2JX1puGgzXBsvWu8HbdG09bQuSVyJ347xkXdyu4zM=;
        b=ZaOoXpvKVo/hhWAxlfGIC4Hk1xJcaYgYgke072IZ/a1xoXNvgiTsIFrkIm391CbNWe
         rXo3/f6oF4ai4CzsZgsQIdn5xyO5h2SUmwlkA2BWP3pdVw2lYIdh+nfCp00F3gye0UHE
         sXXsTfTiASjt0LRqtXNbmgE8FuBtcTux/WwiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kp2JX1puGgzXBsvWu8HbdG09bQuSVyJ347xkXdyu4zM=;
        b=0Ax1ZIXFUDYSaNxgIrUdBOEKXoZKA59L8bCgGAZ9ha7xPGnoyX4KAJa8Dm8J87LztJ
         aKlFRkgjvFrnP80IbzMD5qAM+T4B2+7ZF0HyRda2gZkOqFyltdiU2cChGnB2n1bimiwl
         1Uz5Vm/52tdyzwqD+sFakf/isNLM5b/S4A8PypgamV+nBOIbD25UuiAldmKtmSW6uJH9
         uN5SxDo66QTaKyleJcWtx8O3krmQSPNc6GsvN7U9oa1uwU7O7oIZgF6z0wWjAOlpJeqC
         v7MZDtqO4xdki6LG2PYPZ+ueRvtAPlzKhzmxUnaotSccRWjcU+Apub49reuzskcFRmPN
         F/rA==
X-Gm-Message-State: AOAM532q3O7N0HqvdQnYgeTAeL1K+FhI/bnsv02RkBGjBCs0UyNt5Mvi
        j6d8Ip0GROy2WAtkuutC4QYCZQ==
X-Google-Smtp-Source: ABdhPJwq/W/AkvyyrQ2/pwRcgiWGOEiwcnyR4t8Y9k4BxxuoDweqV6ttCqo15/59QA8a3KuadqovyA==
X-Received: by 2002:a63:317:: with SMTP id 23mr20669854pgd.318.1642605484698;
        Wed, 19 Jan 2022 07:18:04 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ab3b:7ccf:392:3f04])
        by smtp.gmail.com with ESMTPSA id ip14sm6731596pjb.11.2022.01.19.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:18:04 -0800 (PST)
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
Subject: [PATCH v5 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Date:   Wed, 19 Jan 2022 23:17:51 +0800
Message-Id: <20220119151751.986185-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220119151751.986185-1-hsinyi@chromium.org>
References: <20220119151751.986185-1-hsinyi@chromium.org>
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

