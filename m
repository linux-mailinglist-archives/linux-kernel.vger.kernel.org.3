Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE9543E56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiFHVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiFHVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:19 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D10F3DEB60;
        Wed,  8 Jun 2022 14:12:16 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id y79so1707269iof.2;
        Wed, 08 Jun 2022 14:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1cawpvk6T5EodVUg6iifiBSPNSIcr6LOGTYf0md8yw=;
        b=znctldVMHQ7L84N6oQnZaazney5BnrT3oMxNlnjZRMew9VIQb+bJ5xWja//6odV1g6
         kZ1W6n0cWzwMyEOekw/IJ1IKRL3hTCvlBl9vk3F3HmP17WJhEDbSF+gTT0o+n1uoPOly
         ywYfsjl4Pj2EzAC+9P16HA241KKlJ/k5x548elnNhzlRW/O23KHJ2Bl9cx4m4DtBH67n
         K+wZI2Oa+SbE13Xh48mq2TJkOrlF8s+no5kiALA211Ap9XfrZZvrv4eS4iBT3XJXU3ir
         1Cslf+eGKdtFA8Tb9vFohINSl1eHVmwWAcKs5kzBN7to9YrA2u3kruBMMYX5Astj62rP
         IZ9Q==
X-Gm-Message-State: AOAM533JGIiCTvNBt+NnENQuhRQjc9zzjYJf/pc39UHF78tCZn4J+BpW
        EhZqITdh8YPoIEKPd0o43w==
X-Google-Smtp-Source: ABdhPJz8JweMimbib7XFTTeIJs6gv1vdcpW9D8QjkC4FazxTImuhLjRpfjIMw2c69m+iViiIFrQGXw==
X-Received: by 2002:a05:6638:1a92:b0:331:dc7a:1cd0 with SMTP id ce18-20020a0566381a9200b00331dc7a1cd0mr4155213jab.293.1654722735959;
        Wed, 08 Jun 2022 14:12:15 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id v11-20020a02cbab000000b00331bd537addsm3295264jap.102.2022.06.08.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:12:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: input: Centralize 'linux,code' definition
Date:   Wed,  8 Jun 2022 15:12:04 -0600
Message-Id: <20220608211207.2058487-3-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220608211207.2058487-1-robh@kernel.org>
References: <20220608211207.2058487-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple bindings use 'linux,code', but there is not a central
definition and type. Add 'linux,code' to input.yaml and update all the
users to use it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/adc-joystick.yaml   |  2 +-
 .../input/allwinner,sun4i-a10-lradc-keys.yaml     |  5 ++---
 .../devicetree/bindings/input/azoteq,iqs7222.yaml |  7 ++-----
 .../devicetree/bindings/input/gpio-keys.yaml      |  1 -
 .../devicetree/bindings/input/input.yaml          |  8 ++++++++
 .../devicetree/bindings/input/iqs269a.yaml        | 15 ++++++---------
 .../devicetree/bindings/input/iqs626a.yaml        |  5 ++---
 .../devicetree/bindings/input/iqs62x-keys.yaml    |  5 ++---
 .../devicetree/bindings/input/max77650-onkey.yaml |  8 ++++----
 9 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
index 2ee04e03bc22..64d961458ac7 100644
--- a/Documentation/devicetree/bindings/input/adc-joystick.yaml
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -45,6 +45,7 @@ additionalProperties: false
 patternProperties:
   "^axis@[0-9a-f]+$":
     type: object
+    $ref: input.yaml#
     description: >
       Represents a joystick axis bound to the given ADC channel.
       For each entry in the io-channels list, one axis subnode with a matching
@@ -57,7 +58,6 @@ patternProperties:
         description: Index of an io-channels list entry bound to this axis.
 
       linux,code:
-        $ref: /schemas/types.yaml#/definitions/uint32
         description: EV_ABS specific event code generated by the axis.
 
       abs-range:
diff --git a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
index 3399fc288afb..9700dc468b25 100644
--- a/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
+++ b/Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
@@ -44,14 +44,13 @@ properties:
 patternProperties:
   "^button-[0-9]+$":
     type: object
+    $ref: input.yaml#
     properties:
       label:
         $ref: /schemas/types.yaml#/definitions/string
         description: Descriptive name of the key
 
-      linux,code:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Keycode to emit
+      linux,code: true
 
       channel:
         $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
index a3a1e5a65306..5ea10fe7ffe9 100644
--- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
+++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
@@ -421,6 +421,7 @@ patternProperties:
     patternProperties:
       "^event-(prox|touch)$":
         type: object
+        $ref: input.yaml#
         description:
           Represents a proximity or touch event reported by the channel.
 
@@ -467,11 +468,7 @@ patternProperties:
               The IQS7222B does not feature channel-specific timeouts; the time-
               out specified for any one channel applies to all channels.
 
-          linux,code:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            description:
-              Numeric key or switch code associated with the event. Specify
-              KEY_RESERVED (0) to opt out of event reporting.
+          linux,code: true
 
           linux,input-type:
             $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index 7fe1966ea28a..cd07107fd5ed 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -34,7 +34,6 @@ patternProperties:
 
         linux,code:
           description: Key / Axis code to emit.
-          $ref: /schemas/types.yaml#/definitions/uint32
 
         linux,input-type:
           description:
diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index 43d2f299c332..e3701a0bc500 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -23,6 +23,14 @@ properties:
       minimum: 0
       maximum: 0x2ff
 
+  linux,code:
+    description:
+      Specifies a single numeric keycode value to be used for reporting
+      button/switch events. Specify KEY_RESERVED (0) to opt out of event
+      reporting.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0x2ff
+
   poll-interval:
     description: Poll interval time in milliseconds.
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
index 9c154e5e1a91..c22f8f27913a 100644
--- a/Documentation/devicetree/bindings/input/iqs269a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
@@ -370,6 +370,7 @@ patternProperties:
     patternProperties:
       "^event-prox(-alt)?$":
         type: object
+        $ref: input.yaml#
         description:
           Represents a proximity event reported by the channel in response to
           a decrease in counts. Node names suffixed with '-alt' instead corre-
@@ -396,14 +397,13 @@ patternProperties:
             default: 10
             description: Specifies the threshold for the event.
 
-          linux,code:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            description: Numeric key or switch code associated with the event.
+          linux,code: true
 
         additionalProperties: false
 
       "^event-touch(-alt)?$":
         type: object
+        $ref: input.yaml#
         description: Represents a touch event reported by the channel.
 
         properties:
@@ -421,14 +421,13 @@ patternProperties:
             default: 4
             description: Specifies the hysteresis for the event.
 
-          linux,code:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            description: Numeric key or switch code associated with the event.
+          linux,code: true
 
         additionalProperties: false
 
       "^event-deep(-alt)?$":
         type: object
+        $ref: input.yaml#
         description: Represents a deep-touch event reported by the channel.
 
         properties:
@@ -446,9 +445,7 @@ patternProperties:
             default: 0
             description: Specifies the hysteresis for the event.
 
-          linux,code:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            description: Numeric key or switch code associated with the event.
+          linux,code: true
 
         additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
index 0cb736c541c9..e645521da8ba 100644
--- a/Documentation/devicetree/bindings/input/iqs626a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
@@ -449,6 +449,7 @@ patternProperties:
     patternProperties:
       "^event-(prox|touch|deep)(-alt)?$":
         type: object
+        $ref: input.yaml#
         description:
           Represents a proximity, touch or deep-touch event reported by the
           channel in response to a decrease in counts. Node names suffixed with
@@ -487,9 +488,7 @@ patternProperties:
               Specifies the hysteresis for the event (touch and deep-touch
               events only).
 
-          linux,code:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            description: Numeric key or switch code associated with the event.
+          linux,code: true
 
           linux,input-type:
             $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
index 77fe3b545b35..e677e31fe8fe 100644
--- a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
+++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
@@ -89,15 +89,14 @@ properties:
 patternProperties:
   "^hall-switch-(north|south)$":
     type: object
+    $ref: input.yaml#
     description:
       Represents north/south-field Hall-effect sensor touch or proximity
       events. Note that north/south-field orientation is reversed on the
       IQS620AXzCSR device due to its flip-chip package.
 
     properties:
-      linux,code:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Numeric switch code associated with the event.
+      linux,code: true
 
       azoteq,use-prox:
         $ref: /schemas/types.yaml#/definitions/flag
diff --git a/Documentation/devicetree/bindings/input/max77650-onkey.yaml b/Documentation/devicetree/bindings/input/max77650-onkey.yaml
index 3a2ad6ec64db..48edc0c8c1dd 100644
--- a/Documentation/devicetree/bindings/input/max77650-onkey.yaml
+++ b/Documentation/devicetree/bindings/input/max77650-onkey.yaml
@@ -16,15 +16,15 @@ description: |
   The onkey controller is represented as a sub-node of the PMIC node on
   the device tree.
 
+allOf:
+  - $ref: input.yaml#
+
 properties:
   compatible:
     const: maxim,max77650-onkey
 
   linux,code:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      The key-code to be reported when the key is pressed. Defaults
-      to KEY_POWER.
+    default: 116  # KEY_POWER
 
   maxim,onkey-slide:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1

