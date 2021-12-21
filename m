Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59D47C020
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhLUMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:52:40 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:38806 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhLUMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:52:39 -0500
Received: by mail-qv1-f48.google.com with SMTP id o10so12308832qvc.5;
        Tue, 21 Dec 2021 04:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m1B7l3mS3kUTU8so7uOc+jIgCAO6knrVM5YQ4rwdLGo=;
        b=du8Ph5G6fF+BjVIcIE+396epK7WwFzTa1QsaYDMoelUAbd+2LdZpwfpNqEQyRkn5aC
         MXm2iWFiiVHmlkfdiim4ZExbgsnm2dYVWSvojL9eKtASgL4Uz7YfDci0YFltFg/eeHZB
         nWHYfumF2XNR32UZ8vzt+N9bRAGcAzbbnifVeZjtNeu+0rLYnmfzpuc46eaQmf6HNI3M
         XSXCvl3sJ42vmoJ4Pwl2tY0Dt6GEnRLbrrzl/uYP8APMAjbnrq3/H4nOTaowwII2fQCO
         zlBnauCiwUKYPsTgh+9cj1+UH3Wp/8JvBph1E4UxQ8yUsbCQ9bn8L82CY8REEhiDbu4E
         /k/A==
X-Gm-Message-State: AOAM5309AjpPsLS2CnIW3EHQcTvNozP7QJ9PUjh/96xE9GSulgD4OfR4
        nKF3GVR1v8goLTyAXiuqbQ==
X-Google-Smtp-Source: ABdhPJyuBOkK+1SyYLuLwxdaZwirAVxpp2OHAD0Tudg+XxkEaltQoeTJ6bX0JnXjQ/rxB6rRKyvAXw==
X-Received: by 2002:a05:6214:1cc4:: with SMTP id g4mr2008650qvd.45.1640091158530;
        Tue, 21 Dec 2021 04:52:38 -0800 (PST)
Received: from xps15.. ([24.55.105.145])
        by smtp.googlemail.com with ESMTPSA id x15sm13932938qko.82.2021.12.21.04.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:52:38 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: Add SPI peripheral schema to SPI based displays
Date:   Tue, 21 Dec 2021 08:52:09 -0400
Message-Id: <20211221125209.1195932-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support enabled, several SPI based display
binding examples have warnings:

Documentation/devicetree/bindings/display/panel/samsung,ld9040.example.dt.yaml: lcd@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 'spi-3wire' were unexpected)
Documentation/devicetree/bindings/display/panel/ilitek,ili9322.example.dt.yaml: display@0: Unevaluated properties are not allowed ('reg' was unexpected)
Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.example.dt.yaml: display@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
Documentation/devicetree/bindings/display/panel/abt,y030xx067a.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
Documentation/devicetree/bindings/display/panel/sony,acx565akm.example.dt.yaml: panel@2: Unevaluated properties are not allowed ('spi-max-frequency', 'reg' were unexpected)
Documentation/devicetree/bindings/display/panel/tpo,td.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('reg', 'spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
Documentation/devicetree/bindings/display/panel/innolux,ej030na.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dt.yaml: panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)

Fix all of these by adding a reference to spi-peripheral-props.yaml.
With this, the description that the binding must follow
spi-controller.yaml is both a bit out of date and redundant, so remove
it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This is dependent on spi-peripheral-props.yaml landing in 5.17-rc1.
---
 .../devicetree/bindings/display/panel/abt,y030xx067a.yaml  | 5 +----
 .../devicetree/bindings/display/panel/ilitek,ili9322.yaml  | 4 +---
 .../devicetree/bindings/display/panel/innolux,ej030na.yaml | 5 +----
 .../bindings/display/panel/kingdisplay,kd035g6-54nt.yaml   | 5 +----
 .../bindings/display/panel/lgphilips,lb035q02.yaml         | 5 +----
 .../devicetree/bindings/display/panel/samsung,ld9040.yaml  | 7 +------
 .../devicetree/bindings/display/panel/samsung,s6e63m0.yaml | 1 +
 .../bindings/display/panel/sitronix,st7789v.yaml           | 5 +----
 .../devicetree/bindings/display/panel/sony,acx565akm.yaml  | 5 +----
 .../devicetree/bindings/display/panel/tpo,td.yaml          | 5 +----
 10 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
index a108029ecfab..acd2f3faa6b9 100644
--- a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS LCD panel
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
index e89c1ea62ffa..7d221ef35443 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
@@ -15,11 +15,9 @@ description: |
   960 TFT source driver pins and 240 TFT gate driver pins, VCOM, VCOML and
   VCOMH outputs.
 
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
index cda36c04e85c..72788e3e6c59 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
+++ b/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Innolux EJ030NA 3.0" (320x480 pixels) 24-bit TFT LCD panel
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
index c45c92a3d41f..2a2756d19681 100644
--- a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
index 830e335ddb53..5e4e0e552c2f 100644
--- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
+++ b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: LG.Philips LB035Q02 Panel
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
index 060ee27a4749..d525165d6d63 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Andrzej Hajda <a.hajda@samsung.com>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
@@ -63,8 +60,6 @@ examples:
 
         lcd@0 {
             compatible = "samsung,ld9040";
-            #address-cells = <1>;
-            #size-cells = <0>;
 
             reg = <0>;
             vdd3-supply = <&ldo7_reg>;
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
index ea58df49263a..940f7f88526f 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
@@ -12,6 +12,7 @@ maintainers:
 allOf:
   - $ref: panel-common.yaml#
   - $ref: /schemas/leds/backlight/common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index fa46d151e7b3..9e1d707c2ace 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sitronix ST7789V RGB panel with SPI control bus
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
index 95d053c548ab..98abdf4ddeac 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
@@ -6,15 +6,12 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sony ACX565AKM SDI Panel
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
index 4aa605613445..f902a9d74141 100644
--- a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
@@ -6,16 +6,13 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Toppoly TD Panels
 
-description: |
-  The panel must obey the rules for a SPI slave device as specified in
-  spi/spi-controller.yaml
-
 maintainers:
   - Marek Belisko <marek@goldelico.com>
   - H. Nikolaus Schaller <hns@goldelico.com>
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-- 
2.32.0

