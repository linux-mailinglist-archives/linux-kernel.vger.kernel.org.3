Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841857E728
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiGVTQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiGVTQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:16:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466B5A14B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:16:00 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z22so9117281lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G47quR1ZrGgbuIvZ59TBsJJd6cPVPIYmhWGk53FjaIA=;
        b=spzJf2AITB3NQPutmqI27okRtwimfTO91xAARb293I66WGKv/cLML3hywZoRzlgoO1
         fBl9hcQgHMMGMr0yMet80vyPHKcxuoRtPmPunyfpNcyYVKp4EXf7n6gHcfs7KwqOHU/Z
         6AQxfJ8LT+wdjKubufiFN/GsTTw/YPLnF3e6w8L26VB9pVbpq/pK50eJRaNBgBXRhore
         47C0iCnBKDmsSj60FTjryu4yURM8Sz30TUco1YyUzbluYUuRYUx8nQBaJoG8GbaqUeTL
         rO4m7IBmVhhJ2gEcEUE/0uE6guKEYPN7l5gwEqDPrsucx97PC4T46APB/f87qtIKLdLO
         UmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G47quR1ZrGgbuIvZ59TBsJJd6cPVPIYmhWGk53FjaIA=;
        b=rLzR3vKNkyTa3LTB6KBKyqg9QkPK63+OJKIW+udpS+rNv983+6DGQrwiPMHwxoJDF2
         lPygJ4zwRPTXnJoccO0nXTf+BcdMb6fFDOk5zXsG0mV91WejlFJaCDK3JLAP1YISWc49
         mMLhKPjiXHkToAhbITq8wwlSqh+t3g1OVS3SY2+ThGIkmAAqZxTd1iwCP1BniSu+SNSa
         OgT2RjfclYsUoVAy9a8z+H919U8aloi48YqKOHjDhCqzlqeGpbFu5EHLCgQIsq/veYgK
         Gsi57b4YXcEf7+0/tcQDGXTWaS1ZRqqryjcv4EwNZ4tB4To0mJeZ+k+upaIz5JkWh29I
         7n1A==
X-Gm-Message-State: AJIora/wkFa77uDAdm4sKvcT8C+t6Sgz7XUOyMeTao/rTosbx3hRx1UT
        xEFK/bP3dKWEVHOi3niuK+DzsQ==
X-Google-Smtp-Source: AGRyM1vTa4j/tadJgnKEq9gHixcXZDFaetZSqHt0lkasbn82IkjJKmFFsP6XUHahqlJjNcJz6LaNrQ==
X-Received: by 2002:a19:ad02:0:b0:48a:7246:63c6 with SMTP id t2-20020a19ad02000000b0048a724663c6mr520857lfc.541.1658517358365;
        Fri, 22 Jul 2022 12:15:58 -0700 (PDT)
Received: from krzk-bin.home (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id f7-20020a0565123b0700b0047255d211d7sm287484lfv.262.2022.07.22.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 12:15:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/1] spi/panel: dt-bindings: drop CPHA and CPOL from common properties
Date:   Fri, 22 Jul 2022 21:15:39 +0200
Message-Id: <20220722191539.90641-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
References: <20220722191539.90641-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-cpha and spi-cpol properties are device specific and should be
accepted only if device really needs them.  Drop them from common
spi-peripheral-props.yaml schema, mention in few panel drivers which use
them and include instead in the SPI controller bindings.  The controller
bindings will provide CPHA/CPOL type validation and one place for
description.  Each device schema must list the properties if they are
applicable.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/lgphilips,lb035q02.yaml    |  3 +++
 .../bindings/display/panel/samsung,ld9040.yaml        |  3 +++
 .../bindings/display/panel/sitronix,st7789v.yaml      |  3 +++
 .../devicetree/bindings/display/panel/tpo,td.yaml     |  3 +++
 .../devicetree/bindings/spi/spi-controller.yaml       | 11 +++++++++++
 .../devicetree/bindings/spi/spi-peripheral-props.yaml | 10 ----------
 6 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
index 5e4e0e552c2f..628c4b898111 100644
--- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
+++ b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
@@ -21,6 +21,9 @@ properties:
   enable-gpios: true
   port: true
 
+  spi-cpha: true
+  spi-cpol: true
+
 required:
   - compatible
   - enable-gpios
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
index d525165d6d63..c0fabeb38628 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
@@ -42,6 +42,9 @@ properties:
   panel-height-mm:
     description: physical panel height [mm]
 
+  spi-cpha: true
+  spi-cpol: true
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index 9e1d707c2ace..d984b59daa4a 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -23,6 +23,9 @@ properties:
   backlight: true
   port: true
 
+  spi-cpha: true
+  spi-cpol: true
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
index f902a9d74141..e8c8ee8d7c88 100644
--- a/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
@@ -28,6 +28,9 @@ properties:
   backlight: true
   port: true
 
+  spi-cpha: true
+  spi-cpol: true
+
 required:
   - compatible
   - port
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 678cee68b52a..655713fba7e2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -95,6 +95,17 @@ patternProperties:
     type: object
     $ref: spi-peripheral-props.yaml
 
+    properties:
+      spi-cpha:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires shifted clock phase (CPHA) mode.
+
+      spi-cpol:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires inverse clock polarity (CPOL) mode.
+
     required:
       - compatible
       - reg
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5e32928c4fc3..2349f83c07f3 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -34,16 +34,6 @@ properties:
     description:
       The device requires 3-wire mode.
 
-  spi-cpha:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The device requires shifted clock phase (CPHA) mode.
-
-  spi-cpol:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      The device requires inverse clock polarity (CPOL) mode.
-
   spi-cs-high:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.34.1

