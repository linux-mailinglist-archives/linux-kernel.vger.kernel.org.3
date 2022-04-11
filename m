Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB04FC681
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350082AbiDKVPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240850AbiDKVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A9828989
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649711573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzdFnm3iaZLLnebsfstZZgMbexDrkf5tbznhbFumAH0=;
        b=A6sdiHEBckhhmhIcFvgyKfePsgCx7sJexl9+idDKx1EUnhqo/XccuEK1K+t3MU8nlwTCb7
        LyD8u+3GBOql7Ft4RVsLVuaKFXBMx+mc6uJA+msawD2ZStIeJK3/M5R5foEkP4Lw+c0nq7
        Svcm3b//9X2MVYwIkFeaWtnIDlhiuFU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-h1u-B8UmOxmM7tu-qT6gVg-1; Mon, 11 Apr 2022 17:12:52 -0400
X-MC-Unique: h1u-B8UmOxmM7tu-qT6gVg-1
Received: by mail-wm1-f72.google.com with SMTP id g13-20020a1c4e0d000000b0038eba16aa46so211491wmh.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzdFnm3iaZLLnebsfstZZgMbexDrkf5tbznhbFumAH0=;
        b=5DQqu7j6AK4t7ZtqEte8LksSB+A90LfD6A5n+z60Y3i4bwE5Z1BUednnXzpi2m+qUn
         +CPj3OlHR6d0hAsUHTJ7RfhwGwlB687lurf3T71aRL/QTtBeaUjJxmk5tC81vZLYh95u
         zOIb9Mv/zigRGgMNdVpL13+9MJ7UXEUPfQnKXJLHBDTujpXCz1ScbmjmZb9FWsHUwnWr
         QVrVf4cyXa3Py+U/11mb2JeJ6RTFPOLfNyqGqHEvZoIzWw9EcQ1isEunjx8Mpb1uwFGO
         HB/RRFaL27h1jYV+XZZSMfJsBSJToPNT5cfnoHNBafOp7VEYmguiTrrpBfWuRX94KT8b
         z5pw==
X-Gm-Message-State: AOAM533e0IsuL3aKrjXZVEnthwUCaxJ17BJWcXD82/FlcoXuIKCh30k0
        IQPz9OUh9ok1/OLGfP+7sTbEn4/uGn1zYvPcfsU0X1WSg7X/tdDPzJ8WyUB1yP3WEaybZknQIJ4
        Ue/iQWpSNukI2eRAJIAZr9jCkAEcUe7yH/HUREwxB0uRcYhUzRa+JN8lWLnNnU56suREya6egbD
        g=
X-Received: by 2002:a05:600c:2197:b0:38e:b80c:526a with SMTP id e23-20020a05600c219700b0038eb80c526amr955068wme.76.1649711570632;
        Mon, 11 Apr 2022 14:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu/LM92/Nz7m6CMsPIAZGXuJG/QWu/2OUyuso56zJHaoEzz30UUplaSr4C67jCPONKtccaqw==
X-Received: by 2002:a05:600c:2197:b0:38e:b80c:526a with SMTP id e23-20020a05600c219700b0038eb80c526amr955039wme.76.1649711570337;
        Mon, 11 Apr 2022 14:12:50 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm28723722wrs.43.2022.04.11.14.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:12:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c" compatible strings
Date:   Mon, 11 Apr 2022 23:12:39 +0200
Message-Id: <20220411211243.11121-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411211243.11121-1-javierm@redhat.com>
References: <20220411211243.11121-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
DRM drivers.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v2:
- Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoeven).

 .../bindings/display/solomon,ssd1307fb.yaml   | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index ade61d502edd..6b9d0c72739a 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -12,12 +12,23 @@ maintainers:
 
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
+              - sinowealth,sh1106-i2c
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
@@ -136,7 +147,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: sinowealth,sh1106-i2c
+            const: sinowealth,sh1106
     then:
       properties:
         solomon,dclk-div:
@@ -148,7 +159,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1305fb-i2c
+            const: solomon,ssd1305
     then:
       properties:
         solomon,dclk-div:
@@ -160,7 +171,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1306fb-i2c
+            const: solomon,ssd1306
     then:
       properties:
         solomon,dclk-div:
@@ -172,7 +183,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1307fb-i2c
+            const: solomon,ssd1307
     then:
       properties:
         solomon,dclk-div:
@@ -186,7 +197,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1309fb-i2c
+            const: solomon,ssd1309
     then:
       properties:
         solomon,dclk-div:
@@ -203,14 +214,14 @@ examples:
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

