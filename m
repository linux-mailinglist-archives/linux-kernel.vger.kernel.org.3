Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687EA507C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354771AbiDSVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbiDSVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FCD23FD8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ao+QLGVykP8whEqJzniS6nnN6H0GlmSyDd2RtpQtg0Q=;
        b=Fw7enXeVX6gLbTtDMbe6iQqhw50i472ZTelsML6rRsFayPscRxss8N/a8Zg3z+h7WPGJvW
        L439zgN+JROPOa4bdSFKYlc+4bqFiIMpUfAKO7W+XalD0pb63XAhYyIEKGQBYgMalmC727
        EyJhuHVbu6HuVdzCEpiNB9DTPiLucFI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-SMws2ZCxMjWyDUbnNXxExQ-1; Tue, 19 Apr 2022 17:48:33 -0400
X-MC-Unique: SMws2ZCxMjWyDUbnNXxExQ-1
Received: by mail-wm1-f72.google.com with SMTP id m125-20020a1c2683000000b00391893a2febso6804605wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ao+QLGVykP8whEqJzniS6nnN6H0GlmSyDd2RtpQtg0Q=;
        b=6ZhKDdV8vkgiqLyN7woQKio/AXhbjgKvCXe3PdDBA76cZCkBGt0g2PxycEJtxAT7HT
         UHE7SxB0A8+KKZF4iqXDn0uhBIwjgtZo0VkFN+5Sm2QHdt7HvwJpUPJGQISFLdBL33w7
         09wcaqGLpq36SaeygfFFvYaSBzY4AHRokeguFxmmOfzQhqAKUyQtqWgPiwYT14lxWRn/
         022l/TbtCFDUf54lh6+OvzUOXJEyakT1+4osiEFt57UZ0unVYUMWmOSS5Z9wf/3w+HPT
         oijRKKYeE+CNcMw7e+tp+0ibyI2erWBfUwas84cZBx1R6Ox63I1KkoSysqq7CaXSLelW
         w2vg==
X-Gm-Message-State: AOAM531am+8omWeZll5makwIpznx2dXv2FJq6bRJOOZidvHzTZ6ZF45F
        DvpmkMRkpSHyjD8crngwyk8yYLKZyBlLLLJloXmUYl1dn9F+r1BJ011Yj89lUryIH9oyTvokq1T
        FfYfd5bPCk6U2gyAE5teiVqJaEK4H40r5ZCxO1Wp7q9KOHma1hd7D4Du3apE9/K1piAn9qeB5cu
        0=
X-Received: by 2002:a1c:7408:0:b0:38e:b7af:c503 with SMTP id p8-20020a1c7408000000b0038eb7afc503mr556008wmc.58.1650404911634;
        Tue, 19 Apr 2022 14:48:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1gaQ3suhLg9SEod8ZyG+DXS89puSlsOl7NF/Ht6muE6d9H9FpIgRAib149d2EYzLX5Lni2w==
X-Received: by 2002:a1c:7408:0:b0:38e:b7af:c503 with SMTP id p8-20020a1c7408000000b0038eb7afc503mr555977wmc.58.1650404911359;
        Tue, 19 Apr 2022 14:48:31 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm13333699wrv.19.2022.04.19.14.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:48:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c" compatible strings
Date:   Tue, 19 Apr 2022 23:48:19 +0200
Message-Id: <20220419214824.335075-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419214824.335075-1-javierm@redhat.com>
References: <20220419214824.335075-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current compatible strings for SSD130x I2C controllers contain both an
"fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
and also that are for devices that can be accessed over an I2C bus.

But a DT is supposed to describe the hardware and not Linux implementation
details. So let's deprecate those compatible strings and add new ones that
only contain the vendor and device name, without any of these suffixes.

These will just describe the device and can be matched by both I2C and SPI
DRM drivers. The required properties should still be enforced for old ones.

While being there, just drop the "sinowealth,sh1106-i2c" compatible string
since that was never present in a released Linux version.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

(no changes since v3)

Changes in v3:
- Drop the "sinowealth,sh1106-i2c", wasn't in a released version (Chen-Yu Tsai)
- Continue enforcing required properties for deprecated strings (Maxime Ripard)

Changes in v2:
- Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven)

 .../bindings/display/solomon,ssd1307fb.yaml   | 44 +++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index ade61d502edd..7653b6c3fcb6 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -12,12 +12,22 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - sinowealth,sh1106-i2c
-      - solomon,ssd1305fb-i2c
-      - solomon,ssd1306fb-i2c
-      - solomon,ssd1307fb-i2c
-      - solomon,ssd1309fb-i2c
+    oneOf:
+      # Deprecated compatible strings
+      - items:
+          - enum:
+              - solomon,ssd1305fb-i2c
+              - solomon,ssd1306fb-i2c
+              - solomon,ssd1307fb-i2c
+              - solomon,ssd1309fb-i2c
+        deprecated: true
+      - items:
+          - enum:
+              - sinowealth,sh1106
+              - solomon,ssd1305
+              - solomon,ssd1306
+              - solomon,ssd1307
+              - solomon,ssd1309
 
   reg:
     maxItems: 1
@@ -136,7 +146,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: sinowealth,sh1106-i2c
+            const: sinowealth,sh1106
     then:
       properties:
         solomon,dclk-div:
@@ -148,7 +158,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1305fb-i2c
+            enum:
+              - solomon,ssd1305-i2c
+              - solomon,ssd1305
     then:
       properties:
         solomon,dclk-div:
@@ -160,7 +172,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1306fb-i2c
+            enum:
+              - solomon,ssd1306-i2c
+              - solomon,ssd1306
     then:
       properties:
         solomon,dclk-div:
@@ -172,7 +186,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1307fb-i2c
+            enum:
+              - solomon,ssd1307-i2c
+              - solomon,ssd1307
     then:
       properties:
         solomon,dclk-div:
@@ -186,7 +202,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1309fb-i2c
+            enum:
+              - solomon,ssd1309-i2c
+              - solomon,ssd1309
     then:
       properties:
         solomon,dclk-div:
@@ -203,14 +221,14 @@ examples:
             #size-cells = <0>;
 
             ssd1307: oled@3c {
-                    compatible = "solomon,ssd1307fb-i2c";
+                    compatible = "solomon,ssd1307";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
                     reset-gpios = <&gpio2 7>;
             };
 
             ssd1306: oled@3d {
-                    compatible = "solomon,ssd1306fb-i2c";
+                    compatible = "solomon,ssd1306";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
                     reset-gpios = <&gpio2 7>;
-- 
2.35.1

