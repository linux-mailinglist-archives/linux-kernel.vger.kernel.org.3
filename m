Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315A4F885E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiDGURw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiDGURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7254488CDE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649362401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXSOuQeCYTD72y4Xo1UTiURod41sQfVrbEsc1IcuHsY=;
        b=dMRpyR3lnKFCL7Ew3FaTZAbPzivt31j9vFFS6IIIoryDdeIX6cgIC+h3P12FiAdtgrvVkT
        urQqV+uqY7adwGcXWvJ6GLMl0k9v4WKNTkxDpJXuPhcR4d3pZ0xjhzxlkQltUWG+cmd7iQ
        4emlA8pJlFGz3JILdYfiWtPmxTeXb9g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-NHLBsDf4MN64P7ISEGuxHg-1; Thu, 07 Apr 2022 16:03:02 -0400
X-MC-Unique: NHLBsDf4MN64P7ISEGuxHg-1
Received: by mail-wm1-f70.google.com with SMTP id bg8-20020a05600c3c8800b0038e6a989925so1767286wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXSOuQeCYTD72y4Xo1UTiURod41sQfVrbEsc1IcuHsY=;
        b=eVy/AB6Xaf0hg4SdzFyq2sW7Ez3JNlCXoK246eYqQkRjkcCBJMy+b78o89PJMBpdcH
         eiP5fB02X9jf9Jf0avHCovwXVK/xx+ckjDsbdJtYx3MZ650MOi8pp7twWAT5vGdiwCj5
         AKDzSvvd8i/c7ghdzzELpU/tz6OtRRkGGt/ek9xnIWaa1z/1dqD2qKBPGWUbQp8FS9ub
         xB9p5fKJcNjwxTHmmFvOw1TWPoQrPI02Eam9ICsy2O94NBhlBlH06IQu109Nt5dVcUmK
         m2fHawZSxyueWxsTLReFJMCcrNhNwHp+AV4jyewc2B1lkLnuwXamwQTnSpiSbHs6E8uY
         d7Tg==
X-Gm-Message-State: AOAM533s7kyqYY/Unang/D24e31m0xC45GAKT54fprIQHH8+5MVlolbF
        euZ/l76+MOM3tWfs6R6oBq5dElZuOJbl1WltVW8NIKr7/QK5A0e3zOIEw2voHn8GZU1HCievL1n
        MOIw8iqJ8iGxu64nCDrpOojAVYHrxrO39CXUCnjd/hqyasAXmlgu/CxAuruMnWsY9+WQIUqzIw0
        Y=
X-Received: by 2002:a05:600c:3009:b0:381:194a:8cb5 with SMTP id j9-20020a05600c300900b00381194a8cb5mr14371875wmh.43.1649361781036;
        Thu, 07 Apr 2022 13:03:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdVrchp6+fH6bFHOo2gCCwpez8T6oth+OyDwzFP+IdgOSajN+NtmKi8IXgiPU7SpRh+LyMoA==
X-Received: by 2002:a05:600c:3009:b0:381:194a:8cb5 with SMTP id j9-20020a05600c300900b00381194a8cb5mr14371846wmh.43.1649361780754;
        Thu, 07 Apr 2022 13:03:00 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm1048712wry.36.2022.04.07.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:03:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
Date:   Thu,  7 Apr 2022 22:02:01 +0200
Message-Id: <20220407200205.28838-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407200205.28838-1-javierm@redhat.com>
References: <20220407200205.28838-1-javierm@redhat.com>
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

The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
add to the schema the compatible strings, properties and examples for SPI.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .../bindings/display/solomon,ssd1307fb.yaml   | 89 +++++++++++++++----
 1 file changed, 71 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 46207f2c12b8..05e7975296a7 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -31,6 +31,15 @@ properties:
               - solomon,ssd1307-i2c
               - solomon,ssd1309-i2c
 
+      # SSD130x SPI controllers
+      - items:
+          - enum:
+              - sinowealth,sh1106-spi
+              - solomon,ssd1305-spi
+              - solomon,ssd1306-spi
+              - solomon,ssd1307-spi
+              - solomon,ssd1309-spi
+
   reg:
     maxItems: 1
 
@@ -40,9 +49,14 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  dc-gpios:
+    maxItems: 1
+
   vbat-supply:
     description: The supply for VBAT
 
+  spi-max-frequency: true
+
   solomon,height:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 16
@@ -148,19 +162,10 @@ allOf:
       properties:
         compatible:
           contains:
-            const: sinowealth,sh1106-i2c
-    then:
-      properties:
-        solomon,dclk-div:
-          default: 1
-        solomon,dclk-frq:
-          default: 5
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: solomon,ssd1305-i2c
+            enum:
+              - sinowealth,sh1106-i2c
+              - solomon,ssd1305-i2c
+              - solomon,ssd1305-spi
     then:
       properties:
         solomon,dclk-div:
@@ -172,7 +177,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1306-i2c
+            enum:
+              - solomon,ssd1306-i2c
+              - solomon,ssd1306-spi
     then:
       properties:
         solomon,dclk-div:
@@ -184,7 +191,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1307-i2c
+            enum:
+              - solomon,ssd1307-i2c
+              - solomon,ssd1307-spi
     then:
       properties:
         solomon,dclk-div:
@@ -198,7 +207,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1309-i2c
+            enum:
+              - solomon,ssd1309-i2c
+              - solomon,ssd1309-spi
     then:
       properties:
         solomon,dclk-div:
@@ -206,6 +217,21 @@ allOf:
         solomon,dclk-frq:
           default: 10
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sinowealth,sh1106-spi
+              - solomon,ssd1305-spi
+              - solomon,ssd1306-spi
+              - solomon,ssd1307-spi
+              - solomon,ssd1309-spi
+    then:
+      required:
+        - spi-max-frequency
+        - dc-gpios
+
 additionalProperties: false
 
 examples:
@@ -214,14 +240,14 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
-            ssd1307: oled@3c {
+            ssd1307_i2c: oled@3c {
                     compatible = "solomon,ssd1307-i2c";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
                     reset-gpios = <&gpio2 7>;
             };
 
-            ssd1306: oled@3d {
+            ssd1306_i2c: oled@3d {
                     compatible = "solomon,ssd1306-i2c";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
@@ -232,3 +258,30 @@ examples:
                     solomon,lookup-table = /bits/ 8 <0x3f 0x3f 0x3f 0x3f>;
             };
     };
+  - |
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ssd1307_spi: oled@0 {
+                    compatible = "solomon,ssd1307-spi";
+                    reg = <0x0>;
+                    pwms = <&pwm 4 3000>;
+                    reset-gpios = <&gpio2 7>;
+                    dc-gpios = <&gpio2 8>;
+                    spi-max-frequency = <10000000>;
+            };
+
+            ssd1306_spi: oled@1 {
+                    compatible = "solomon,ssd1306-spi";
+                    reg = <0x1>;
+                    pwms = <&pwm 4 3000>;
+                    reset-gpios = <&gpio2 7>;
+                    dc-gpios = <&gpio2 8>;
+                    spi-max-frequency = <10000000>;
+                    solomon,com-lrremap;
+                    solomon,com-invdir;
+                    solomon,com-offset = <32>;
+                    solomon,lookup-table = /bits/ 8 <0x3f 0x3f 0x3f 0x3f>;
+            };
+    };
-- 
2.35.1

