Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB06544A62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiFILi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiFILiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:38:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA8188E79
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:38:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so46920560ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JjVcCjPWopZoVok7sQ6y2jDbmAaxW7SE17z6RGPEhY=;
        b=jEMQ75IloZxvNniRgYBzPlf4+g0m//3KEQiIaYM5viFYyNteg2tK/Ccyu7CW9A1CdB
         jSlftkGTMkaLOY/sUtwbaI9OAzz6MEOiUQ1dswNBB5BbbWiBkcVxxXbEWCVeZxDsebkN
         dopdePPONdd2VSR5054u0SI3hm9ftRnja5C4JtF9LBe40nTzZvvD1tDVxU1y8nR+Iw7e
         YgPItBrLE9LUm6ncxKsdkGu49L4DkKcNZTsR8nWO9VJhLfmP4OfOKpJBxeqwtLX5iHBc
         GEbQqLyJoODgMxJ+Vl7Ji/ENfJesTGPP9ZCMNM83Z4VP6got/PmFlf1eZtecvh1zqCli
         JjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JjVcCjPWopZoVok7sQ6y2jDbmAaxW7SE17z6RGPEhY=;
        b=jTipBXE8bJnqhI5OO8JZifjtn+BAQpkrfPtFVeJoPTTqctfcoW/0IRhLH1FtAbDBlh
         4ABaMksRt21nPVOPjtwADuvE5SWUT7zM9XrhcBLlF4xLlahU1E6o1STi+W++1mVk4rqN
         uTCF3FtZh/21eiSYuAFLKtE6urNW187f0aodium+ScdqyuAFx+yP+AO7B37RZtvb36hs
         6UiDlw2WOkeRUNIKskqXEv8BSYdJitAsJ9K9mkes/l2UfEOQPyhYMl6peUjca0Ev0AEl
         DCEAUchVldQnnWeC+t/IGTUxhQ0EvppePkNWjNj/JXW3GpsIvZyT23FVolsVlJb1sFih
         delw==
X-Gm-Message-State: AOAM531C7fiIgMHGd3Ap5MHjHXBL7LmTyENWVmfkl0e5TjSGjSZrnVLx
        xkrLXroZXnYn4DwlJUCkSqH/r7QWri0GIg==
X-Google-Smtp-Source: ABdhPJyPc47ZjUQ43Y5uJTBP8nR5b0LcqJAtYTahvX7YOJm5ATvAq0Q4vv9sqDRidfJ+0tG9qWqpAg==
X-Received: by 2002:a17:907:3fa4:b0:6fe:b83b:d667 with SMTP id hr36-20020a1709073fa400b006feb83bd667mr35014528ejc.481.1654774732041;
        Thu, 09 Jun 2022 04:38:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906308a00b006fece722508sm10615622ejv.135.2022.06.09.04.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:38:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/48] dt-bindings: input: gpio-keys: enforce node names to match all properties
Date:   Thu,  9 Jun 2022 13:38:43 +0200
Message-Id: <20220609113843.380260-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio-keys DT schema matches all properties with a wide pattern and
applies specific schema to children.  This has drawback - all regular
properties are also matched and are silently ignored, even if they are
not described in schema.  Basically this allows any non-object property
to be present.

Enforce specific naming pattern for children (keys) to narrow the
pattern thus do not match other properties.  This will require all
children to be named with 'key-' prefix or '-key' suffix.

Removal of "if:" within patternProperties causes drop of one indentation
level, but there are no other changes in the affected block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/input/gpio-keys.yaml  | 157 +++++++++---------
 1 file changed, 77 insertions(+), 80 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index 645dfa1e0d07..27bb5c6ab8d9 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -16,86 +16,83 @@ properties:
       - gpio-keys-polled
 
 patternProperties:
-  ".*":
-    if:
-      type: object
-    then:
-      $ref: input.yaml#
-
-      properties:
-        gpios:
-          maxItems: 1
-
-        interrupts:
-          maxItems: 1
-
-        label:
-          description: Descriptive name of the key.
-
-        linux,code:
-          description: Key / Axis code to emit.
-
-        linux,input-type:
-          default: 1  # EV_KEY
-
-        linux,input-value:
-          description: |
-            If linux,input-type is EV_ABS or EV_REL then this
-            value is sent for events this button generates when pressed.
-            EV_ABS/EV_REL axis will generate an event with a value of 0
-            when all buttons with linux,input-type == type and
-            linux,code == axis are released. This value is interpreted
-            as a signed 32 bit value, e.g. to make a button generate a
-            value of -1 use:
-
-            linux,input-value = <0xffffffff>; /* -1 */
-
-          $ref: /schemas/types.yaml#/definitions/uint32
-
-        debounce-interval:
-          description:
-            Debouncing interval time in milliseconds. If not specified defaults to 5.
-          $ref: /schemas/types.yaml#/definitions/uint32
-
-          default: 5
-
-        wakeup-source:
-          description: Button can wake-up the system.
-
-        wakeup-event-action:
-          description: |
-            Specifies whether the key should wake the system when asserted, when
-            deasserted, or both. This property is only valid for keys that wake up the
-            system (e.g., when the "wakeup-source" property is also provided).
-
-            Supported values are defined in linux-event-codes.h:
-
-              EV_ACT_ANY        - both asserted and deasserted
-              EV_ACT_ASSERTED   - asserted
-              EV_ACT_DEASSERTED - deasserted
-          $ref: /schemas/types.yaml#/definitions/uint32
-          enum: [0, 1, 2]
-
-        linux,can-disable:
-          description:
-            Indicates that button is connected to dedicated (not shared) interrupt
-            which can be disabled to suppress events from the button.
-          type: boolean
-
-      required:
-        - linux,code
-
-      anyOf:
-        - required:
-            - interrupts
-        - required:
-            - gpios
-
-      dependencies:
-        wakeup-event-action: [ wakeup-source ]
-        linux,input-value: [ gpios ]
-
-      unevaluatedProperties: false
+  "^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$":
+    $ref: input.yaml#
+
+    properties:
+      gpios:
+        maxItems: 1
+
+      interrupts:
+        maxItems: 1
+
+      label:
+        description: Descriptive name of the key.
+
+      linux,code:
+        description: Key / Axis code to emit.
+
+      linux,input-type:
+        default: 1  # EV_KEY
+
+      linux,input-value:
+        description: |
+          If linux,input-type is EV_ABS or EV_REL then this
+          value is sent for events this button generates when pressed.
+          EV_ABS/EV_REL axis will generate an event with a value of 0
+          when all buttons with linux,input-type == type and
+          linux,code == axis are released. This value is interpreted
+          as a signed 32 bit value, e.g. to make a button generate a
+          value of -1 use:
+
+          linux,input-value = <0xffffffff>; /* -1 */
+
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      debounce-interval:
+        description:
+          Debouncing interval time in milliseconds. If not specified defaults to 5.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+        default: 5
+
+      wakeup-source:
+        description: Button can wake-up the system.
+
+      wakeup-event-action:
+        description: |
+          Specifies whether the key should wake the system when asserted, when
+          deasserted, or both. This property is only valid for keys that wake up the
+          system (e.g., when the "wakeup-source" property is also provided).
+
+          Supported values are defined in linux-event-codes.h:
+
+            EV_ACT_ANY        - both asserted and deasserted
+            EV_ACT_ASSERTED   - asserted
+            EV_ACT_DEASSERTED - deasserted
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+
+      linux,can-disable:
+        description:
+          Indicates that button is connected to dedicated (not shared) interrupt
+          which can be disabled to suppress events from the button.
+        type: boolean
+
+    required:
+      - linux,code
+
+    anyOf:
+      - required:
+          - interrupts
+      - required:
+          - gpios
+
+    dependencies:
+      wakeup-event-action: [ wakeup-source ]
+      linux,input-value: [ gpios ]
+
+    unevaluatedProperties: false
 
 if:
   properties:
-- 
2.34.1

