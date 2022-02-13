Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C24B3AE0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiBMKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:34:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiBMKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:34:56 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD92C5DE66
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:34:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so16144069pja.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaE8rdmOlwWqUb0OkieD4Ifqh+45CRaIN9t5xJmzq/U=;
        b=F/iPtsAVyE3zfhNHTOKy6Ss3n4Di/6whgRfIL1jeyJwM75hCYoSe+cN/0GARZhDaIK
         2zylYQRRcqy4ILGnTAANK11FULjNy2v9JhDzSmZfD8Tjki2P+985by+41GxyUB6e9l7k
         XRNItK5pSXbtCW5fsb731Wa6fRNPVk67tvaSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaE8rdmOlwWqUb0OkieD4Ifqh+45CRaIN9t5xJmzq/U=;
        b=vnZU0WWxgI2BhsiBwikf/Zbv6MMlft7CPbB+QBW6P104Hdgvi5ibvgC5FeLskWylpO
         kptvP6/O7ptdhwmHFByKK0yG5EbLIIRRHTplxxEwl8JR3TSOwbRhCWk5Hpu/GeI9scWr
         cAVb79wRJyisGA0xNKaXeX2+wNnsbzyNU5onnXtXytTlgTFa6T72DzVXsjvjMy8yDuk8
         jfgwqNjQ15+V2VNn+ARfiEVw+55Y7r/4MZHIddk9L3/x6mkrVMmFM+ZTNecXcoSUmAi+
         QZ2+qh8nAZUrgQOURz0t6Ig+/GRZzKUzUSWBNOhPONOeyhEf8Yvr+ZNTpveaOGlFxDW/
         HEMw==
X-Gm-Message-State: AOAM533VGvUaT6Wsp5bcd7+fwUHgYJmefBPc4W7PIzE0yhOeyFE7FQLj
        EMvvE0M+14ETCq4VpG8qzRdox8Pj9Y++ZQ==
X-Google-Smtp-Source: ABdhPJybMLnNcKW28zmhskixVEukX3DCMuQiWQikE3x6Y9kLtBv1Vv7JU8vhVj7UK+2EoVikj9Sk8g==
X-Received: by 2002:a17:902:eb90:: with SMTP id q16mr8828315plg.76.1644748491136;
        Sun, 13 Feb 2022 02:34:51 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3653:bf18:8571:5f26])
        by smtp.gmail.com with ESMTPSA id n85sm1589407pfd.142.2022.02.13.02.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 02:34:50 -0800 (PST)
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
Subject: [PATCH v7 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Date:   Sun, 13 Feb 2022 18:34:37 +0800
Message-Id: <20220213103437.3363848-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220213103437.3363848-1-hsinyi@chromium.org>
References: <20220213103437.3363848-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List panel under aux-bus node if it's connected to anx7625's aux bus.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.35.1.265.g69c8d7142f-goog

