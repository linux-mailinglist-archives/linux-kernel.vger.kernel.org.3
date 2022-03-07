Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68414D033F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiCGPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiCGPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:47:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8697EB37
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:46:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x5so20489606edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L5m6P7fLCOpQVhAoLkaaRIYTfvk9veUQCuvJDzF/V1c=;
        b=PdZQVIGYoSypt74Tuo0iLHZLHiWRG6vXCYsgFDwpM6qXsOTCeEU7R4CQIoq5C0dkh5
         jjExHORdLRHgqKN2d9StsZC092OGT4wCkFoODQBDAnEPYkvKtiu9hk5y8H9QiX3zHK9g
         osvrCBdLuY19+5Ed23HqTWehMMRZfA09MZ/AxURGswP/lN283j86aGyEzAaRbyMDswxe
         KhGNvLZN8Pq3ZPZkevCDHI+QRSNJ6padD8lh312vJ/dUCvCdU+pUyPajHJCWzseeu8qI
         pu39e3BojrA/uZPZODDdt5MXr9tsT0MIaW9FW7xJ70BOfWTu6FcoYjH6qQvk6x0HZmHO
         nm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5m6P7fLCOpQVhAoLkaaRIYTfvk9veUQCuvJDzF/V1c=;
        b=ceYXy9Ea4t46YEW9bUALuytDZstgv4UM5LdWaVEQb5wr3NAvOzpHz8Ik7QBEqnCsbR
         kkmL6Huh/wAohCV2Tk5qhy9fvVUysXbdiRVvdU20/F5540n6Au2AstBq4bz0Oy42eLE2
         ueTslslvRVa2UVrClMC8+z0ynqBdZeZV9tP/jhcTmE2WCBT4iMHFtp2ReGQTVB8oZi7W
         NzrlDzNl0AsGQp/t6ugB2PRO5elTf5cCFZhujktrFn5z+eWofkgD+E/w3H9hW+/x2QJz
         f2rQgF4uW3G11Eqv04KIoeNx/JOmTRSjsZiG882VcLkPdNg977+TDN1iPxk96IHq8cem
         iCGA==
X-Gm-Message-State: AOAM533Ct/xEmGKZMz+xs1RJ/fP6dcuQxZOjVVIcSJBp2vjzWk29IDJc
        scngw7Wy1cXi63YhVKkOYeO+5w==
X-Google-Smtp-Source: ABdhPJz+TkcFsHL4kC2nAluY7JPswqrL7Wk2RJBJZ8M0konGhmQuUI7nNxB6e/fssM8GX54SAHaJRg==
X-Received: by 2002:a05:6402:d06:b0:412:eafd:8b9a with SMTP id eb6-20020a0564020d0600b00412eafd8b9amr11749516edb.278.1646667975836;
        Mon, 07 Mar 2022 07:46:15 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402190c00b0041615cd434csm4210747edz.60.2022.03.07.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:46:15 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, robert.foss@linaro.org,
        xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v1 1/2] Revert "dt-bindings:drm/bridge:anx7625:add vendor define"
Date:   Mon,  7 Mar 2022 16:45:57 +0100
Message-Id: <20220307154558.2505734-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307154558.2505734-1-robert.foss@linaro.org>
References: <20220307154558.2505734-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a43661e7e819b100e1f833a35018560a1d9abb39.
---
 .../display/bridge/analogix,anx7625.yaml      | 65 +------------------
 1 file changed, 2 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 1d3e88daca041..ab48ab2f4240d 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -43,70 +43,14 @@ properties:
   vdd33-supply:
     description: Regulator that provides the supply 3.3V power.
 
-  analogix,lane0-swing:
-    $ref: /schemas/types.yaml#/definitions/uint8-array
-    minItems: 1
-    maxItems: 20
-    description:
-      an array of swing register setting for DP tx lane0 PHY.
-      Registers 0~9 are Swing0_Pre0, Swing1_Pre0, Swing2_Pre0,
-      Swing3_Pre0, Swing0_Pre1, Swing1_Pre1, Swing2_Pre1, Swing0_Pre2,
-      Swing1_Pre2, Swing0_Pre3, they are for [Boost control] and
-      [Swing control] setting.
-      Registers 0~9, bit 3:0 is [Boost control], these bits control
-      post cursor manual, increase the [Boost control] to increase
-      Pre-emphasis value.
-      Registers 0~9, bit 6:4 is [Swing control], these bits control
-      swing manual, increase [Swing control] setting to add Vp-p value
-      for each Swing, Pre.
-      Registers 10~19 are Swing0_Pre0, Swing1_Pre0, Swing2_Pre0,
-      Swing3_Pre0, Swing0_Pre1, Swing1_Pre1, Swing2_Pre1, Swing0_Pre2,
-      Swing1_Pre2, Swing0_Pre3, they are for [R select control] and
-      [R Termination control] setting.
-      Registers 10~19, bit 4:0 is [R select control], these bits are
-      compensation manual, increase it can enhance IO driven strength
-      and Vp-p.
-      Registers 10~19, bit 5:6 is [R termination control], these bits
-      adjust 50ohm impedance of DP tx termination. 00:55 ohm,
-      01:50 ohm(default), 10:45 ohm, 11:40 ohm.
-
-  analogix,lane1-swing:
-    $ref: /schemas/types.yaml#/definitions/uint8-array
-    minItems: 1
-    maxItems: 20
-    description:
-      an array of swing register setting for DP tx lane1 PHY.
-      DP TX lane1 swing register setting same with lane0
-      swing, please refer lane0-swing property description.
-
-  analogix,audio-enable:
-    type: boolean
-    description: let the driver enable audio HDMI codec function or not.
-
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/$defs/port-base
-        unevaluatedProperties: false
+        $ref: /schemas/graph.yaml#/properties/port
         description:
-          MIPI DSI/DPI input.
-
-        properties:
-          endpoint:
-            $ref: /schemas/media/video-interfaces.yaml#
-            type: object
-            additionalProperties: false
-
-            properties:
-              remote-endpoint: true
-
-              bus-type:
-                enum: [1, 5]
-                default: 1
-
-              data-lanes: true
+          Video port for MIPI DSI input.
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
@@ -143,9 +87,6 @@ examples:
             vdd10-supply = <&pp1000_mipibrdg>;
             vdd18-supply = <&pp1800_mipibrdg>;
             vdd33-supply = <&pp3300_mipibrdg>;
-            analogix,audio-enable;
-            analogix,lane0-swing = /bits/ 8 <0x14 0x54 0x64 0x74>;
-            analogix,lane1-swing = /bits/ 8 <0x14 0x54 0x64 0x74>;
 
             ports {
                 #address-cells = <1>;
@@ -155,8 +96,6 @@ examples:
                     reg = <0>;
                     anx7625_in: endpoint {
                         remote-endpoint = <&mipi_dsi>;
-                        bus-type = <5>;
-                        data-lanes = <0 1 2 3>;
                     };
                 };
 
-- 
2.32.0

