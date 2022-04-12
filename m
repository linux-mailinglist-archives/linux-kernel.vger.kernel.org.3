Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1B4FE5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357602AbiDLQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbiDLQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D44EB5D5E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649780872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M///uq33RMEHTxjoVs129eG8XW6VZX+ANQltzYppS6w=;
        b=PALWjQjIeP/7sRCh8zv3gyPfpAJbEBiYCNvRsjcnQytliO7rilfsEu/6pVoQHsB0kjnTkN
        moggwOKNkpWP11ratsaLjUZYjs3R44sXLRfMp69Sgxj3UwmDWx3scQQSvarHoXn/tK2Jjq
        xH0hiiK1DbNu73GbSEylCzPAtHTBi2A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-1yxcwYl4Ojugmel_Mzj-eQ-1; Tue, 12 Apr 2022 12:27:51 -0400
X-MC-Unique: 1yxcwYl4Ojugmel_Mzj-eQ-1
Received: by mail-wr1-f71.google.com with SMTP id s8-20020adfc548000000b00207a28e0583so1636301wrf.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M///uq33RMEHTxjoVs129eG8XW6VZX+ANQltzYppS6w=;
        b=p6m3LvWT/RYef5GbYQOKHlgV7pSiOYIp+AEVy2D1x1ZiE4nwlENK8y1HT2A6qvvSRp
         Yc81RaW9vxhm8QDAlHDEFnekNoRwm7ij2mGZCPMpjZZVcK13dTAJxsHSjU3jOQVbjeLl
         TZfvhrE2tS3tlsJG0m+GHOuqrNseSb5mmhYLq/XLk+DYecXiLEtaVIizeaYiHvfzWg5Q
         +lQLgVlGmZ004cMR9xj5tXKSsqnAci8/8glOr8edE9IuJlqV5I3iviFAatut/H7/wxjc
         CBHqa3Mgi+lf3pNelVgJ6p7EaZL4uUSiAAQOCW2OFpeaT5xAhO1bokF3kM38Vwa7afNY
         7Ivg==
X-Gm-Message-State: AOAM533iLL+efvs3NPmx8Z3QmjbWzMRHfWXhn4bz6p68DNVDUh2kTdGI
        i95FfpWJqa36vgN5hzFnOE1ErP/1cj4djV2/bI1VaD14Azo02hpYt7RAOz59vHcHBaG7+RYD9wl
        8A6H9RZZ7CEjwCXOnZuHEP0/sKAt+ylcgCCTt563IwkyPydSSgbGWM3pS0Eeh4gexXAikooa0s5
        o=
X-Received: by 2002:a05:600c:3588:b0:38c:6d7f:6fd8 with SMTP id p8-20020a05600c358800b0038c6d7f6fd8mr4795596wmq.25.1649780870474;
        Tue, 12 Apr 2022 09:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzryxA9KF33Y/kGHkOm+XLc/HDsLdgWiUOLZYjTIDFY5X+9rR3gPvbvCQWHVPnx1wiijk1LQQ==
X-Received: by 2002:a05:600c:3588:b0:38c:6d7f:6fd8 with SMTP id p8-20020a05600c358800b0038c6d7f6fd8mr4795565wmq.25.1649780870214;
        Tue, 12 Apr 2022 09:27:50 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00207a49fa6a1sm7700358wrq.81.2022.04.12.09.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:27:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
Date:   Tue, 12 Apr 2022 18:27:26 +0200
Message-Id: <20220412162729.184783-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412162729.184783-1-javierm@redhat.com>
References: <20220412162729.184783-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Solomon SSD130x OLED displays can either have an I2C or SPI interface,
add to the schema the properties and examples for OLED devices under SPI.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v3:
- Add a comment to the properties required for SPI (Geert Uytterhoeven)

Changes in v2:
- Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven)

 .../bindings/display/solomon,ssd1307fb.yaml   | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 7653b6c3fcb6..7d7de92df86f 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -38,9 +38,16 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  # Only required for SPI
+  dc-gpios:
+    maxItems: 1
+
   vbat-supply:
     description: The supply for VBAT
 
+  # Only required for SPI
+  spi-max-frequency: true
+
   solomon,height:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 16
@@ -220,14 +227,14 @@ examples:
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
@@ -238,3 +245,30 @@ examples:
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

