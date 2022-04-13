Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102A24FF84A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiDMOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiDMOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:02:57 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663263C735;
        Wed, 13 Apr 2022 07:00:35 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso1208945otf.12;
        Wed, 13 Apr 2022 07:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2Wl/nq/dpqitiEtaYG1649KE5qjpYJCnCT/UcTfasY=;
        b=fQjmAf5xzU65eRhgsJBJQVo4vQcBcBQIyAGx9LKUNUPNCMeee7epytFYsDPN9OPHKz
         NwoFm9dAJovxz8bMHm9iHml7TNWVo+tzbfdL/0KEhqAMCDu6it/ppeg4gAoCArXogEhz
         Zw39DvbG0ZTOxz4r2uD9W4jxWJayW2jSJIvqE3I5v0YdVHkNCWlvuB5/R3Yj0OiZEiuW
         ycM06C7Qt7UDrPEn9ykcTaLcD1c8sHOcuzW+9SdrLoDZTOafrBvKP/t4yR9LhQcvccYc
         kxq8v3fXTp7WfLtNk648MGO3qCKi2ju74Ik+PUJNLfMi3ggoAKLU/DlLcSKBMYkiEzh3
         kiKg==
X-Gm-Message-State: AOAM530RveEtoJuBGFNHyVqVKt+Yx8Ap+uqrYYwCM9WbHXq+yO4H9w+m
        37bXSgJFYNcPEZbWvv5YcwR+StgFYw==
X-Google-Smtp-Source: ABdhPJwJmT21alPgGoRzX/oYfAlptyAhoCoH1dqMI6H16MGqg8MgrK3zMh3QLc1pK3xtMska4vwR+Q==
X-Received: by 2002:a05:6830:1f49:b0:5b2:5c16:3dd1 with SMTP id u9-20020a0568301f4900b005b25c163dd1mr14832949oth.207.1649858434660;
        Wed, 13 Apr 2022 07:00:34 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id 71-20020a9d084d000000b005e969b3f0b1sm653146oty.67.2022.04.13.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:00:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: panel-timing: Define a single type for properties
Date:   Wed, 13 Apr 2022 09:00:15 -0500
Message-Id: <20220413140016.3131013-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
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

It's not good practice to define multiple types for the same property, so
factor out the type reference making the properties always an uint32-array
with a length of 1 or 3 items.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/panel-timing.yaml  | 42 ++++++++-----------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-timing.yaml b/Documentation/devicetree/bindings/display/panel/panel-timing.yaml
index 9bf592dc3033..7749de95ee40 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-timing.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-timing.yaml
@@ -71,78 +71,72 @@ properties:
 
   hfront-porch:
     description: Horizontal front porch panel timing
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-        maxItems: 1
+      - maxItems: 1
         items:
           description: typical number of pixels
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-        minItems: 3
+      - minItems: 3
         maxItems: 3
         items:
           description: min, typ, max number of pixels
 
   hback-porch:
     description: Horizontal back porch timing
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-        maxItems: 1
+      - maxItems: 1
         items:
           description: typical number of pixels
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-        minItems: 3
+      - minItems: 3
         maxItems: 3
         items:
           description: min, typ, max number of pixels
 
   hsync-len:
     description: Horizontal sync length panel timing
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-        maxItems: 1
+      - maxItems: 1
         items:
           description: typical number of pixels
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-        minItems: 3
+      - minItems: 3
         maxItems: 3
         items:
           description: min, typ, max number of pixels
 
   vfront-porch:
     description: Vertical front porch panel timing
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-        maxItems: 1
+      - maxItems: 1
         items:
           description: typical number of lines
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-        minItems: 3
+      - minItems: 3
         maxItems: 3
         items:
           description: min, typ, max number of lines
 
   vback-porch:
     description: Vertical back porch panel timing
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-        maxItems: 1
+      - maxItems: 1
         items:
           description: typical number of lines
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-        minItems: 3
+      - minItems: 3
         maxItems: 3
         items:
           description: min, typ, max number of lines
 
   vsync-len:
     description: Vertical sync length panel timing
+    $ref: /schemas/types.yaml#/definitions/uint32-array
     oneOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-        maxItems: 1
+      - maxItems: 1
         items:
           description: typical number of lines
-      - $ref: /schemas/types.yaml#/definitions/uint32-array
-        minItems: 3
+      - minItems: 3
         maxItems: 3
         items:
           description: min, typ, max number of lines
-- 
2.32.0

