Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E74FC688
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiDKVPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbiDKVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F6032A73A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649711574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ+QBfaH3h1Scl+hTaH0HyHu0TpM43OebOl6PoDY/RM=;
        b=O7UgSMvDea4s6LNfh4Ggk/XC5yGF3whpTdUniHCcFVSZxKhnDrgeg/UUH6Cl3OEOmwbkGj
        Ilde8KAZoRptjXuw9FIgqKYM6qhqFc/FzQAOm9wG9uDc8JMo34GAQmdkeTnxhqRv6j4j+U
        mCs2OpCElKMoxAJHtiXMnI2WAEytwPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-wZIkvYxGMm-kHzO1cT2oaQ-1; Mon, 11 Apr 2022 17:12:53 -0400
X-MC-Unique: wZIkvYxGMm-kHzO1cT2oaQ-1
Received: by mail-wm1-f72.google.com with SMTP id l19-20020a05600c1d1300b0038e736f98faso5037534wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQ+QBfaH3h1Scl+hTaH0HyHu0TpM43OebOl6PoDY/RM=;
        b=Y2pkEVWuDbizs4r5+hYrVI86XdAX6wdO7QRwQR9OzQ6cO78S/PAMLWCHLaOVHeDdWg
         YN77sVJWrQOYlKoEc+BDFxHfwaM2jAg0VV+8Tbp18SBgIF+8b0yfFz1G/LT6L45ABKd6
         bOpmTgHKP2NRHCJhrxiyaelJMhNcwazRhF6afKfyPkvGB1+mQKWGNvwJT9kQJZ9zEriX
         EGqN89Vf37MmHRKIwPx2BM9MRwV2SLJHjU8atH9kAGt7Spa8cSWegkkBNTXBtRShZv/j
         x0H5Q+ezGwODe6TOcogzSEG9cDiDEjcJihJJfK5n+TG91oCpvLoQ8/4w9ff/dyD9lpsN
         11xA==
X-Gm-Message-State: AOAM532kcMcJ5yAKdG8Bm1cPjesjnDFj7vGQ2kWI47MbzrBz/vCcr++7
        A+Bn3CDuo3wNAdN2InTCbIOE+F7IfIzXOyvmgoeICBEpjneYAOF7+888SCfYQfwtxMOl7vPoTX/
        00Q9n3mAwboAfmMzxMb3V+/emtE5JReu9DwV08JJmY7PARpwPtifNqQSgV4p8U4gAHu4NfGHPI8
        w=
X-Received: by 2002:a1c:202:0:b0:38e:ab4b:ce72 with SMTP id 2-20020a1c0202000000b0038eab4bce72mr978225wmc.152.1649711571955;
        Mon, 11 Apr 2022 14:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfuB7hkZg8q50JjIIMsDyKbYBXK9LNBxTvZbXiee0cHgIO0ETUBqdWkPQZa7/y0oGvzWZVvw==
X-Received: by 2002:a1c:202:0:b0:38e:ab4b:ce72 with SMTP id 2-20020a1c0202000000b0038eab4bce72mr978199wmc.152.1649711571661;
        Mon, 11 Apr 2022 14:12:51 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6d89000000b00203d62072c4sm28723722wrs.43.2022.04.11.14.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:12:51 -0700 (PDT)
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
Subject: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
Date:   Mon, 11 Apr 2022 23:12:40 +0200
Message-Id: <20220411211243.11121-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411211243.11121-1-javierm@redhat.com>
References: <20220411211243.11121-1-javierm@redhat.com>
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

The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
add to the schema the properties and examples for OLED devices under SPI.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v2:
- Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven).

 .../bindings/display/solomon,ssd1307fb.yaml   | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 6b9d0c72739a..b58d2d7bd8c1 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -39,9 +39,14 @@ properties:
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
@@ -160,6 +165,7 @@ allOf:
         compatible:
           contains:
             const: solomon,ssd1305
+
     then:
       properties:
         solomon,dclk-div:
@@ -213,14 +219,14 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
-            ssd1307: oled@3c {
+            ssd1307_i2c: oled@3c {
                     compatible = "solomon,ssd1307";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
                     reset-gpios = <&gpio2 7>;
             };
 
-            ssd1306: oled@3d {
+            ssd1306_i2c: oled@3d {
                     compatible = "solomon,ssd1306";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
@@ -231,3 +237,30 @@ examples:
                     solomon,lookup-table = /bits/ 8 <0x3f 0x3f 0x3f 0x3f>;
             };
     };
+  - |
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ssd1307_spi: oled@0 {
+                    compatible = "solomon,ssd1307";
+                    reg = <0x0>;
+                    pwms = <&pwm 4 3000>;
+                    reset-gpios = <&gpio2 7>;
+                    dc-gpios = <&gpio2 8>;
+                    spi-max-frequency = <10000000>;
+            };
+
+            ssd1306_spi: oled@1 {
+                    compatible = "solomon,ssd1306";
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

