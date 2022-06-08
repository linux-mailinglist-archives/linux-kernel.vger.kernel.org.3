Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC4543E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiFHVMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiFHVMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:21 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27363DFC73;
        Wed,  8 Jun 2022 14:12:20 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id d123so1293941iof.10;
        Wed, 08 Jun 2022 14:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AMhNLgb7YvQzjxicdIWro1Pk5lisZYU78DetdhihqKs=;
        b=AU0j1Nghrs+l7CJNwmhfg1BRGbdZYg8D2LeHtB+c/I14F9MJzD7fL9I7zf19cGizL1
         2dhEQjON1GL4ilUWUtCgburY0e33hJH2anu581y6tdyAMlYpBtaWQInqHoODFRROwt2t
         77thnUQU9RgUyXSpor8d5U5zKMqZgcc8Kp9kYwWN0D2+rUoDMiBUshxlH1urUXU/Fad0
         WEkkC5kRYQnA3Ad8R1QuuVR47yuybsHpTOMJGETyNQDZP4rYDpvy/XGMP15Oa0sQm3Qi
         2wj0lwbq6XOzhb/BzQk50R1ULAdsHXZHKwRC+TTWTWMQP3QS77/P+XYuAjAVpOL5I29k
         bdzQ==
X-Gm-Message-State: AOAM533Ge2kF0JyOlNu8CcxoKh5k4m/yQzwHCQZfC7Qxqi5cGrvsPPNZ
        SfWwCQRmjeuOpyDbYZw8tg==
X-Google-Smtp-Source: ABdhPJwmlUPv5v56FAmPATpFlhIHG63zJhWjtwMYeF3C0AI+A88YFyEy+LZKnWN7Lf7zRfBsEKp7Ow==
X-Received: by 2002:a05:6638:264e:b0:32e:bc45:bff0 with SMTP id n14-20020a056638264e00b0032ebc45bff0mr20016342jat.282.1654722740108;
        Wed, 08 Jun 2022 14:12:20 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id v11-20020a02cbab000000b00331bd537addsm3295264jap.102.2022.06.08.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:12:19 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: input: Centralize 'linux,input-type' definition
Date:   Wed,  8 Jun 2022 15:12:06 -0600
Message-Id: <20220608211207.2058487-5-robh@kernel.org>
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

Multiple bindings use 'linux,input-type', but there is not a central
definition and type. Add 'linux,input-type' to input.yaml and update all
the users to use it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/azoteq,iqs7222.yaml  |  1 -
 .../devicetree/bindings/input/gpio-keys.yaml       |  7 +------
 Documentation/devicetree/bindings/input/input.yaml | 14 ++++++++++++++
 .../devicetree/bindings/input/iqs626a.yaml         |  4 ----
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
index 5ea10fe7ffe9..a13bd3e41dd3 100644
--- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
+++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
@@ -471,7 +471,6 @@ patternProperties:
           linux,code: true
 
           linux,input-type:
-            $ref: /schemas/types.yaml#/definitions/uint32
             enum: [1, 5]
             default: 1
             description:
diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index cd07107fd5ed..6b49b1afdd95 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -36,12 +36,7 @@ patternProperties:
           description: Key / Axis code to emit.
 
         linux,input-type:
-          description:
-            Specify event type this button/key generates. If not specified defaults to
-            <1> == EV_KEY.
-          $ref: /schemas/types.yaml#/definitions/uint32
-
-          default: 1
+          default: 1  # EV_KEY
 
         linux,input-value:
           description: |
diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index e3701a0bc500..17512f4347fd 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -31,6 +31,17 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 0x2ff
 
+  linux,input-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 1   # EV_KEY
+      - 2   # EV_REL
+      - 3   # EV_ABS
+      - 5   # EV_SW
+    description:
+      Specifies whether the event is to be interpreted as a key, relative,
+      absolute, or switch.
+
   poll-interval:
     description: Poll interval time in milliseconds.
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -47,4 +58,7 @@ properties:
       reset automatically. Device with key pressed reset feature can specify
       this property.
 
+dependencies:
+  linux,input-type: [ "linux,code" ]
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
index 008959f2d425..4df27646c980 100644
--- a/Documentation/devicetree/bindings/input/iqs626a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
@@ -491,16 +491,12 @@ patternProperties:
           linux,code: true
 
           linux,input-type:
-            $ref: /schemas/types.yaml#/definitions/uint32
             enum: [1, 5]
             description:
               Specifies whether the event is to be interpreted as a key (1) or
               a switch (5). By default, Hall-channel events are interpreted as
               switches and all others are interpreted as keys.
 
-        dependencies:
-          linux,input-type: ["linux,code"]
-
         additionalProperties: false
 
     dependencies:
-- 
2.34.1

