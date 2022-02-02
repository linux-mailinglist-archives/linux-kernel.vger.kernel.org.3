Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78F4A7578
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345820AbiBBQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbiBBQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:06:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EBC061401
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:06:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k17so18817928plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ye0S9ZGhY+9EmUZN3Zyu0p+11AX+B8bmbaaOWhr2T0c=;
        b=THKJNrl8wZq9kLm8aIUQsyrUyYnORIkUj0AsqjphNpw6zKOLSU8mqe9LQMXJhqfiew
         6DsPPj5bqxhMpt7Fi9y3F1lK310+oJJ9mGsTFpzoKxamrrhR4Ba+/AupkvmyEhHI99Zg
         W2nXGzr1QnqjZvGL1A0rlvwPLTg4hCskXlNps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ye0S9ZGhY+9EmUZN3Zyu0p+11AX+B8bmbaaOWhr2T0c=;
        b=JypB3epR4+P0Rcj74AijP10i6sojPtf/JVPlib4KonTVz2koFv0fls3TWM2YYkU1hE
         SWukhJdr8J8hCv/y1CrL7iOYUTY16iIpkpEArw+DSePEDTrFeMQK018QMr1YwI8t+/zG
         Tp2xduF93snsWCpSGjuarfXW3CLVrBMFY0dr8v3NqFNbQST4f4Po7jFVYmqjAXNcGDjV
         roOaajmJlQ2SI/PND35aslGXNKf7ydx1uP8zt2+o+v7sDqdCsoatGhv2/DOACxvj7b6+
         ZCUqYPUCEyiLPDSAgQwA5DtVXsO4GFjg+9b3cqOj2EHHS74cDgm5x5ww8Hn0VO9RFabt
         8Now==
X-Gm-Message-State: AOAM531X7Xvpi6jRIIluyTy0Mr0G62QY4feIJ2tmL3K3szj5TJzLnKSA
        c03G/54xTo14H706b/KbE87CLg==
X-Google-Smtp-Source: ABdhPJwmobxexK4WZn3maJdnwfwFpSVFi9apHR9NwFwzjjq9KmTbT11kIv6UjVpfSKsQhHnnARnRsg==
X-Received: by 2002:a17:90b:38c7:: with SMTP id nn7mr8872415pjb.124.1643817976720;
        Wed, 02 Feb 2022 08:06:16 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:7ce0:466c:be86:774])
        by smtp.gmail.com with ESMTPSA id g5sm14722397pgc.51.2022.02.02.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:06:16 -0800 (PST)
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
Subject: [PATCH RESEND v5 4/4] dt-bindings: drm/bridge: anx7625: Add aux-bus node
Date:   Thu,  3 Feb 2022 00:06:02 +0800
Message-Id: <20220202160602.440792-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202160602.440792-1-hsinyi@chromium.org>
References: <20220202160602.440792-1-hsinyi@chromium.org>
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

