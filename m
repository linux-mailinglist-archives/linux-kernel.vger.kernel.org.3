Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4D4FFB26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiDMQ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiDMQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B28E4E81
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649867062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ao+QLGVykP8whEqJzniS6nnN6H0GlmSyDd2RtpQtg0Q=;
        b=WtGe88J5tQe5XK6jyC5xZzd8f3XYdv7Tl+rmoJdCe1t8SdiG2NogbsaG2FCh0Qle8CWo1P
        oSXju3k0Ejawjq3xlaN6YmcFXSAGcCTk1aypToLCfrdQZarXDDeFmfBOfttUkIHfWYXP34
        OiR7fGKtqRakmJq7NYARtFoYDbdE7UE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-nLFJHR2qM2aCB5Roj-4JeA-1; Wed, 13 Apr 2022 12:24:21 -0400
X-MC-Unique: nLFJHR2qM2aCB5Roj-4JeA-1
Received: by mail-wr1-f71.google.com with SMTP id 65-20020adf8147000000b00207982c3692so510086wrm.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ao+QLGVykP8whEqJzniS6nnN6H0GlmSyDd2RtpQtg0Q=;
        b=XHkKQKr8muz47i1+dBPuine8lWeBN6nfP8zEtv6s1cFYXlPnRH+zelPPTt+MBVLXbN
         RArW2hOCWKs2mM9KG2jyxhhFSIkYH/WOjyb4yoS4kcFNSdATq/pk1iY934tTfCugVcnB
         GeFE4NJ6M7FaOqjADUJryxokpFrCdvZ0ikf8EitIubYgFA36O6C4kVwGdkVxvC0rQPAU
         oyS/Pg/ipFuYF2pJGLcC7CGl5NVPBePY7VZQnfLY7C6v59IzYzAp0jK0Zchdhcl+86Rn
         F+k3VakdYSPyd+gEKBYKQ8kFCQlr+MV0jrb+W6OhJG9RjfBKwwQbWXJKGQ7dCqOBWKQz
         Qy4g==
X-Gm-Message-State: AOAM531DYTHv8sclaxTVlwL4yirtknE6mZQ90csNJzagl/ZGXSBd0/2V
        cgOI7uhApidhArsSJ3o1pD1lkc2CUb+jWu/oOBhXB7KjouRszX9wbfnyZsg99v2/8H/aAwaYvTO
        urtzC59ywyXtskW5dW3w2NUsdAkktIsOy/SGxEIF07aTkpUHV2uv0diwOkrv7pRmnIxuWyRmQz9
        Y=
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id j31-20020a05600c1c1f00b0038ec4255b1amr9406107wms.69.1649867060434;
        Wed, 13 Apr 2022 09:24:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztW50EuLGrFp4OqBMvgmg4aBfvttQJcfps4djZfXBpZPbWUvbcwrvp9RGGBXzqwCY7Wlu6aQ==
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id j31-20020a05600c1c1f00b0038ec4255b1amr9406070wms.69.1649867060173;
        Wed, 13 Apr 2022 09:24:20 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t9-20020adfa2c9000000b002061561d4a7sm25446096wra.96.2022.04.13.09.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:24:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c" compatible strings
Date:   Wed, 13 Apr 2022 18:23:54 +0200
Message-Id: <20220413162359.325021-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413162359.325021-1-javierm@redhat.com>
References: <20220413162359.325021-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

