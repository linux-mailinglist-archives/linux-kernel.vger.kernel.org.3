Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE759E942
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiHWRX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241773AbiHWRVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:18 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4F2F391;
        Tue, 23 Aug 2022 07:57:33 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso9965169otv.3;
        Tue, 23 Aug 2022 07:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=X3oSNHfhYN1D8nj/Tus+6OMR/7Xdc3qc/TG8fQDrSaM=;
        b=E/zFZHZulFqGRZrTzXrS2jRjM89qK09z6oSf6JhWBLPOSVJssSBxyQ1QorEq8NcRxd
         Q6/PHEnaFlCdB8fIGBn8/dBw2gyXk9x7RaoFIdbxwTZcHS/bdRJkDmbPbPth9kQ9ifnL
         j/qPUgIIwKkVteJfZ8q4u3sOkNN/hIQ+6n4D4MAPV37CWxM0xY7sdYJwQNah79AquJe2
         6wr/1kfQ40fUHBoZnEY5NlkMDEZUudr4GlvrMp6m+Rr1CkUHBktSCjMCHeRkdfzwdeid
         u+wVfeKl89U6ALbHTGZ3Av1etGwGVMwCSz3zHWGmpKXpjPJQDWXnYJbplj5V0UG9TK7p
         Ra3g==
X-Gm-Message-State: ACgBeo1V1Wwtn8X3hZ9nkDYdgH0DTrZmJsq3ZrhV/rEcaqZTVzdEEa2m
        2gtu18OA5f6XXJ6VXDM+rg==
X-Google-Smtp-Source: AA6agR7DQBou8qC5N4MzG6OFDfSyxvUBlmCTQHSauVZ73UWGC8xCB14yWHMhag68xgrM7MZHRX63/g==
X-Received: by 2002:a05:6830:6999:b0:61d:26f8:94c1 with SMTP id cy25-20020a056830699900b0061d26f894c1mr9511714otb.278.1661266653059;
        Tue, 23 Aug 2022 07:57:33 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:32 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: display: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:42 -0500
Message-Id: <20220823145649.3118479-11-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/arm,komeda.yaml        | 1 +
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 Documentation/devicetree/bindings/display/msm/gpu.yaml           | 1 +
 .../bindings/display/samsung/samsung,exynos7-decon.yaml          | 1 +
 .../devicetree/bindings/display/samsung/samsung,fimd.yaml        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/arm,komeda.yaml b/Documentation/devicetree/bindings/display/arm,komeda.yaml
index 9f4aade97f10..3ad3eef89ca8 100644
--- a/Documentation/devicetree/bindings/display/arm,komeda.yaml
+++ b/Documentation/devicetree/bindings/display/arm,komeda.yaml
@@ -58,6 +58,7 @@ properties:
 patternProperties:
   '^pipeline@[01]$':
     type: object
+    additionalProperties: false
     description:
       clocks
 
diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 3a8614e0f627..84aafcbf0919 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -51,6 +51,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: |
           For LVDS encoders, port 0 is the parallel input
           For LVDS decoders, port 0 is the LVDS input
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 3397bc31d087..0179c816fa6d 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -81,6 +81,7 @@ properties:
 
   zap-shader:
     type: object
+    additionalProperties: false
     description: |
       For a5xx and a6xx devices this node contains a memory-region that
       points to reserved memory to store the zap shader that can be used to
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
index 969bd8c563a5..dec1c9058876 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
@@ -37,6 +37,7 @@ properties:
 
   i80-if-timings:
     type: object
+    additionalProperties: false
     description: timing configuration for lcd i80 interface support
     properties:
       cs-setup:
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
index 5d5cc220f78a..7593938601bb 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
@@ -40,6 +40,7 @@ properties:
 
   i80-if-timings:
     type: object
+    additionalProperties: false
     description: |
       Timing configuration for lcd i80 interface support.
       The parameters are defined as::
-- 
2.34.1

