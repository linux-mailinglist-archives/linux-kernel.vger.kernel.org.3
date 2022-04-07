Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3674F889F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiDGUam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiDGUa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D09F488BF4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649362449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ujVDZk4U6RzShQ/rIDRVpIv+f7MFQZhzBrH2NX9HlA=;
        b=cPKtw1A1OeiDPilpaBVOTQ17rwePe2jR9Ai8on/DXhip3ZDTbTGtWd1ytU6sJ9gJzhoV3n
        QnkCXUaJRuyMaerIC4jrqvVMbT60NoR32Iu34ZsAw+ZRObrBxfYidNB+OFNoM1qZE29UY8
        ACqXld4fRwDUe4gaL8zj2i8qOQzsLyc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-BQFb96o1NBuLGBZ4_ZvBkA-1; Thu, 07 Apr 2022 16:03:01 -0400
X-MC-Unique: BQFb96o1NBuLGBZ4_ZvBkA-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso296650wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ujVDZk4U6RzShQ/rIDRVpIv+f7MFQZhzBrH2NX9HlA=;
        b=tQXLirChw9xBBPOXb38ghFGJmzIxFtObTRquIcYLjyZdCXlMgTqO84r767NAb414KL
         WlGYzGMoK3wnTddY6K5q+gOwiV8tb7D4KE7pyddJP0nn2yRd9YJEB/NR2rz5LAe66u/n
         whhrj6VLkbDheLEQwN3ayNF/dGivqs21RQHJFJN9n9jUe15XMOnE7WoeenhCFdxSd4vh
         HfLrGRrIgVq36k2Jc6kiHayndtzucyefj3e+m+wtQ8WJxXmP0ylVubRiu70Xff0w2iSR
         LzkFvbxakttn2I/99nN+ckAWqsyK9aoq1jZz1qkh4G6rmwvgO32nfJyGIA861xXSVViZ
         MN2w==
X-Gm-Message-State: AOAM532eeCnhkIuWAcrZTT/FChy32AuUbCEdtbFbPQSROLXLBL1fWsxd
        W94x3QkoIyQtHMPSkOrF4hmL1iZE/LoHcSZlHXvsBErqdgp7DT0pf9aWx8+i95C88DgpV0jPMqz
        lDnB94lbk+Xffp/X7n8Mme1WpkjLcXubvSlKzCFrQ/TJjtL+kYXYv2xFeyTgnLGHkLB+d3Jaa04
        k=
X-Received: by 2002:a7b:cd1a:0:b0:38c:720a:a123 with SMTP id f26-20020a7bcd1a000000b0038c720aa123mr13899252wmj.5.1649361779801;
        Thu, 07 Apr 2022 13:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVyONRQEvtL645zP8TFrYruvkYYBDs16vpp3BQmLOliyy4X90HgJIz+51Rgv9qnGmJHkP1ig==
X-Received: by 2002:a7b:cd1a:0:b0:38c:720a:a123 with SMTP id f26-20020a7bcd1a000000b0038c720aa123mr13899228wmj.5.1649361779545;
        Thu, 07 Apr 2022 13:02:59 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a0560001a8f00b002078f74ccd2sm1048712wry.36.2022.04.07.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:02:59 -0700 (PDT)
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
Subject: [PATCH 1/5] dt-bindings: display: ssd1307fb: Deprecate fbdev compatible strings
Date:   Thu,  7 Apr 2022 22:02:00 +0200
Message-Id: <20220407200205.28838-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407200205.28838-1-javierm@redhat.com>
References: <20220407200205.28838-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current compatible strings for SSD130x I2C controllers contain an -fb
suffix, this seems to indicate that are for a fbdev driver. But the DT is
supposed to describe the hardware and not Linux implementation details.

Let's deprecate those compatible strings and add a new enum that contains
compatible strings that don't have a -fb suffix. These will be matched by
the ssd130x-i2c DRM driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .../bindings/display/solomon,ssd1307fb.yaml   | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index ade61d502edd..46207f2c12b8 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -12,12 +12,24 @@ maintainers:
 
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
+
+      # SSD130x I2C controllers
+      - items:
+          - enum:
+              - sinowealth,sh1106-i2c
+              - solomon,ssd1305-i2c
+              - solomon,ssd1306-i2c
+              - solomon,ssd1307-i2c
+              - solomon,ssd1309-i2c
 
   reg:
     maxItems: 1
@@ -148,7 +160,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1305fb-i2c
+            const: solomon,ssd1305-i2c
     then:
       properties:
         solomon,dclk-div:
@@ -160,7 +172,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1306fb-i2c
+            const: solomon,ssd1306-i2c
     then:
       properties:
         solomon,dclk-div:
@@ -172,7 +184,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1307fb-i2c
+            const: solomon,ssd1307-i2c
     then:
       properties:
         solomon,dclk-div:
@@ -186,7 +198,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: solomon,ssd1309fb-i2c
+            const: solomon,ssd1309-i2c
     then:
       properties:
         solomon,dclk-div:
@@ -203,14 +215,14 @@ examples:
             #size-cells = <0>;
 
             ssd1307: oled@3c {
-                    compatible = "solomon,ssd1307fb-i2c";
+                    compatible = "solomon,ssd1307-i2c";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
                     reset-gpios = <&gpio2 7>;
             };
 
             ssd1306: oled@3d {
-                    compatible = "solomon,ssd1306fb-i2c";
+                    compatible = "solomon,ssd1306-i2c";
                     reg = <0x3c>;
                     pwms = <&pwm 4 3000>;
                     reset-gpios = <&gpio2 7>;
-- 
2.35.1

