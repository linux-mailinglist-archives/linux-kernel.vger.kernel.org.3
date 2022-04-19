Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4618507C24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358066AbiDSVvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiDSVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DF5A3FD8F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650404915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOWD5uHxwjIw4P4KTgLk1c7Fc4yJRbBCDK06WY08/Ts=;
        b=FAUmgzu72tSxk3WOPP53YnRGSBhp3YB2uXd78pWoudAkj6JxtnmzIcFuGqgL2ZPJxA/PyI
        v68HYma6Gzd4tJwwmNr5/GmvXUCtRowBpSn4Co5+OZBM0c9txuhsnpmddQ/nTXfwbNKoOv
        k7lbDxg4HGupQTiVS3iukX377Q9v49s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-BiDILdG2PNWBTxjexCVgkw-1; Tue, 19 Apr 2022 17:48:34 -0400
X-MC-Unique: BiDILdG2PNWBTxjexCVgkw-1
Received: by mail-wm1-f72.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so21881wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOWD5uHxwjIw4P4KTgLk1c7Fc4yJRbBCDK06WY08/Ts=;
        b=tktoE32pc1KFggHdHmTwAyKM3S4wbIpmyPl9etUbGX997Bl2dZD80u3uBNNrwOUMKC
         mUMX0lUgm4ZqcPY2NB3fgYx0NT3la+6zKGzy7zcYD9RzlvXeIvg5w2z/iUy6LSh6egXY
         dpxPQXifH16zgr3SbkibNPwPt3MdCjGG57/QXwrp4grFfJ1hcBZ5pR1jMi56Vl46SuOE
         OR+SbRfwKzwZl7C/yykKdNUS+CxnDuRFkFLEyyILvw6uBlnWNNnzm8H7gLnbBahvx/8k
         DyhdfvprXgeptuHCWqC4T5ivlUjMlS8sEDNG3I1vSjuqe8ffDJ6jxVbhC0LhpLvWULuJ
         GT4g==
X-Gm-Message-State: AOAM533EK3mq/1ZNpNOD/ZQqiGHlPGgxII8elW9dzDJGdLmk25k/pTci
        frJ5lRPqN59qpQ8gyVhhMpXzI+GfFy/F0HYA73DpjRjhwSo8nsdo0Ey8XnLuXSrSMnQLybjKBOS
        g1BaOqTg5xfZ15D7MKmBCzJQtQ/tqk+VunBN+OHKtDprgufSxXXGN6J6T/rzRRBZIPEtCWlIxHr
        Y=
X-Received: by 2002:a5d:4e4c:0:b0:207:a883:cf3a with SMTP id r12-20020a5d4e4c000000b00207a883cf3amr13440378wrt.534.1650404912838;
        Tue, 19 Apr 2022 14:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtK/nKbkXvYZOyVAfoxwqPAU4d5VNvQn2+OPjUudoKqzOB3izC+Q3htlXoreIBc6gm8H2luw==
X-Received: by 2002:a5d:4e4c:0:b0:207:a883:cf3a with SMTP id r12-20020a5d4e4c000000b00207a883cf3amr13440351wrt.534.1650404912596;
        Tue, 19 Apr 2022 14:48:32 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d5587000000b00207a8cde900sm13333699wrv.19.2022.04.19.14.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:48:32 -0700 (PDT)
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
Subject: [PATCH v5 2/5] dt-bindings: display: ssd1307fb: Extend schema for SPI controllers
Date:   Tue, 19 Apr 2022 23:48:20 +0200
Message-Id: <20220419214824.335075-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419214824.335075-1-javierm@redhat.com>
References: <20220419214824.335075-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

(no changes since v4)

Changes in v4:
- Add a description for the dc-gpios property for SPI (Geert Uytterhoeven)

Changes in v3:
- Add a comment to the properties required for SPI (Geert Uytterhoeven)

Changes in v2:
- Don't add compatible strings with an "-spi" suffix (Geert Uytterhoeven)

 .../bindings/display/solomon,ssd1307fb.yaml   | 42 ++++++++++++++++++-
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 7653b6c3fcb6..3fbd87c2c120 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -38,9 +38,20 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  # Only required for SPI
+  dc-gpios:
+    description:
+      GPIO connected to the controller's D/C# (Data/Command) pin,
+      that is needed for 4-wire SPI to tell the controller if the
+      data sent is for a command register or the display data RAM
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
@@ -220,14 +231,14 @@ examples:
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
@@ -238,3 +249,30 @@ examples:
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

