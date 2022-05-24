Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD35323AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiEXHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiEXHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:08:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AD28723B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:08:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p4so27862696lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cz4d+fm9aCQbgqKo0PSrrCjJpVOn5py/1Tnn7DmY6o=;
        b=FWZe8ib2ybH7BFuAYY8yRm68ebP3KMXeHb7240EFYr0TDeXLGkt7Z5BJbQTRXwtwxD
         2xQ/8ItezylfIl+y22LKPWewIDwVSfD46Wp7c5JcMFC1qAoJ5pZgp2EAlB8OyLyl/4xt
         SBeLKhpxqvJ8kHvQCqaMsVkel2KojiFh1aNlV+q3ltxEyaLoGVvZZuE2oiEBMC+K3cXf
         BrEUdesY/oFyXZDwqdL3JpxnRVBSLOQtEt/2Z6pJpaGZvKUBWlsUH9p26WgPJsPHb9hj
         bq51GhhL4TQY7xqL0Afw3t+CxImKY/ANplKy5Nq0LiP7zmVTaxOW4SyRwSGxg1wXcbu/
         XS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cz4d+fm9aCQbgqKo0PSrrCjJpVOn5py/1Tnn7DmY6o=;
        b=SvufliBthFfqTmZjBudZY2BsBqGSQlrXBV8M1sXgJcFqFeMxye4/5IeS18wpNi+7dy
         SWeyAHm0riSHtLdd0YsWwxamZjyrK81rwWcy3pxxxmBtg/W0zo+SC+n4UitsyztVt1rG
         tOy0fp/fecixPs7IpLdRUP4GqRe3ZzLowb09ZFRQd+hftNFidm0mz0I6NrjIkLUTuJgm
         s6J5vNarftCuy7mGZzJgT1fzBDHQXGVKmd9rTIuD393m5vaDWP/Pn4mouGxx6Rjmtvmj
         Oc6bAJissS4ktvx8+pAnPF42vCWAfRdtOSwYIMee+0qQjBu0UJEkjRUkjwbb5tyVqMJ0
         fprA==
X-Gm-Message-State: AOAM530c50qx1GxAX2h1+d+XRlokrnGcN1uh0k6IaOhyjYgGFGll4HKo
        1Hmn1EXiyjDiLnctLL9bqpBttQ==
X-Google-Smtp-Source: ABdhPJwR5jUv7Pcg0QWVolnrOC51LAyBbSUWTT9ueRJNtriaNIm/aup3/brxDeoHDbMTVR7odMXJUA==
X-Received: by 2002:a05:6512:39cc:b0:478:5c35:e7e8 with SMTP id k12-20020a05651239cc00b004785c35e7e8mr11366052lfu.392.1653376115575;
        Tue, 24 May 2022 00:08:35 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e12-20020a2e8ecc000000b0024f3d1daebdsm2237655ljl.69.2022.05.24.00.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:08:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kyle Swenson <kyle.swenson@est.tech>
Subject: [PATCH v2 2/2] dt-bindings: leds: fix indentation in examples
Date:   Tue, 24 May 2022 09:08:15 +0200
Message-Id: <20220524070815.42997-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220524070815.42997-1-krzysztof.kozlowski@linaro.org>
References: <20220524070815.42997-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The examples were mixing 4-space with 2- and 3-space indentations, so
correct them to use 4-space one.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. None

Cc: Kyle Swenson <kyle.swenson@est.tech>
---
 .../devicetree/bindings/leds/leds-lp50xx.yaml | 110 ++++-----
 .../devicetree/bindings/leds/leds-lp55xx.yaml | 222 +++++++++---------
 .../bindings/leds/leds-pwm-multicolor.yaml    |  36 +--
 3 files changed, 184 insertions(+), 184 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index 29ce0cb7d449..d11898567313 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -78,66 +78,66 @@ additionalProperties: false
 
 examples:
   - |
-   #include <dt-bindings/gpio/gpio.h>
-   #include <dt-bindings/leds/common.h>
-
-   i2c {
-       #address-cells = <1>;
-       #size-cells = <0>;
-
-       led-controller@14 {
-           compatible = "ti,lp5009";
-           reg = <0x14>;
-           #address-cells = <1>;
-           #size-cells = <0>;
-           enable-gpios = <&gpio1 16>;
-
-           multi-led@1 {
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x1>;
-               color = <LED_COLOR_ID_RGB>;
-               function = LED_FUNCTION_CHARGING;
-
-               led@0 {
-                   reg = <0x0>;
-                   color = <LED_COLOR_ID_RED>;
-               };
-
-               led@1 {
-                   reg = <0x1>;
-                   color = <LED_COLOR_ID_GREEN>;
-               };
-
-               led@2 {
-                   reg = <0x2>;
-                   color = <LED_COLOR_ID_BLUE>;
-               };
-          };
-
-          multi-led@3 {
-            #address-cells = <1>;
-            #size-cells = <0>;
-            reg = <0x3>, <0x4>, <0x5>;
-            color = <LED_COLOR_ID_RGB>;
-            function = LED_FUNCTION_STANDBY;
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
 
-            led@3 {
-              reg = <0x3>;
-              color = <LED_COLOR_ID_RED>;
-            };
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-            led@4 {
-              reg = <0x4>;
-              color = <LED_COLOR_ID_GREEN>;
+        led-controller@14 {
+            compatible = "ti,lp5009";
+            reg = <0x14>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            enable-gpios = <&gpio1 16>;
+
+            multi-led@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x1>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_CHARGING;
+
+                led@0 {
+                     reg = <0x0>;
+                     color = <LED_COLOR_ID_RED>;
+                };
+
+                led@1 {
+                     reg = <0x1>;
+                     color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@2 {
+                     reg = <0x2>;
+                     color = <LED_COLOR_ID_BLUE>;
+                };
             };
 
-            led@5 {
-              reg = <0x5>;
-              color = <LED_COLOR_ID_BLUE>;
+            multi-led@3 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x3>, <0x4>, <0x5>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STANDBY;
+
+                led@3 {
+                    reg = <0x3>;
+                    color = <LED_COLOR_ID_RED>;
+                };
+
+                led@4 {
+                    reg = <0x4>;
+                    color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@5 {
+                    reg = <0x5>;
+                    color = <LED_COLOR_ID_BLUE>;
+                };
             };
-         };
-       };
+        };
     };
 
 ...
diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index f552cd143d5b..7ec676e53851 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -108,119 +108,119 @@ additionalProperties: false
 
 examples:
   - |
-   #include <dt-bindings/leds/common.h>
-
-   i2c {
-       #address-cells = <1>;
-       #size-cells = <0>;
-
-       led-controller@32 {
-           #address-cells = <1>;
-           #size-cells = <0>;
-           compatible = "ti,lp8501";
-           reg = <0x32>;
-           clock-mode = /bits/ 8 <2>;
-           pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
-
-           led@0 {
-               reg = <0>;
-               chan-name = "d1";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@1 {
-               reg = <1>;
-               chan-name = "d2";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@2 {
-               reg = <2>;
-               chan-name = "d3";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@3 {
-               reg = <3>;
-               chan-name = "d4";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@4 {
-               reg = <4>;
-               chan-name = "d5";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@5 {
-               reg = <5>;
-               chan-name = "d6";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@6 {
-               reg = <6>;
-               chan-name = "d7";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@7 {
-               reg = <7>;
-               chan-name = "d8";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
-
-           led@8 {
-               reg = <8>;
-               chan-name = "d9";
-               led-cur = /bits/ 8 <0x14>;
-               max-cur = /bits/ 8 <0x20>;
-           };
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@32 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "ti,lp8501";
+            reg = <0x32>;
+            clock-mode = /bits/ 8 <2>;
+            pwr-sel = /bits/ 8 <3>;	/* D1~9 connected to VOUT */
+
+            led@0 {
+                reg = <0>;
+                chan-name = "d1";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@1 {
+                reg = <1>;
+                chan-name = "d2";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@2 {
+                reg = <2>;
+                chan-name = "d3";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@3 {
+                reg = <3>;
+                chan-name = "d4";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@4 {
+                reg = <4>;
+                chan-name = "d5";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@5 {
+                reg = <5>;
+                chan-name = "d6";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@6 {
+                reg = <6>;
+                chan-name = "d7";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@7 {
+                reg = <7>;
+                chan-name = "d8";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
+
+            led@8 {
+                reg = <8>;
+                chan-name = "d9";
+                led-cur = /bits/ 8 <0x14>;
+                max-cur = /bits/ 8 <0x20>;
+            };
         };
 
-       led-controller@33 {
-           #address-cells = <1>;
-           #size-cells = <0>;
-           compatible = "national,lp5523";
-           reg = <0x33>;
-           clock-mode = /bits/ 8 <0>;
-
-           multi-led@2 {
-               #address-cells = <1>;
-               #size-cells = <0>;
-               reg = <0x2>;
-               color = <LED_COLOR_ID_RGB>;
-               function = LED_FUNCTION_STANDBY;
-               linux,default-trigger = "heartbeat";
-
-               led@0 {
-                   led-cur = /bits/ 8 <50>;
-                   max-cur = /bits/ 8 <100>;
-                   reg = <0x0>;
-                   color = <LED_COLOR_ID_GREEN>;
-               };
-
-               led@1 {
-                   led-cur = /bits/ 8 <50>;
-                   max-cur = /bits/ 8 <100>;
-                   reg = <0x1>;
-                   color = <LED_COLOR_ID_BLUE>;
-               };
-
-               led@6 {
-                   led-cur = /bits/ 8 <50>;
-                   max-cur = /bits/ 8 <100>;
-                   reg = <0x6>;
-                   color = <LED_COLOR_ID_RED>;
-               };
+        led-controller@33 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "national,lp5523";
+            reg = <0x33>;
+            clock-mode = /bits/ 8 <0>;
+
+            multi-led@2 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x2>;
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_STANDBY;
+                linux,default-trigger = "heartbeat";
+
+                led@0 {
+                    led-cur = /bits/ 8 <50>;
+                    max-cur = /bits/ 8 <100>;
+                    reg = <0x0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@1 {
+                    led-cur = /bits/ 8 <50>;
+                    max-cur = /bits/ 8 <100>;
+                    reg = <0x1>;
+                    color = <LED_COLOR_ID_BLUE>;
+                };
+
+                led@6 {
+                    led-cur = /bits/ 8 <50>;
+                    max-cur = /bits/ 8 <100>;
+                    reg = <0x6>;
+                    color = <LED_COLOR_ID_RED>;
+                };
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index 6625a528f727..fdaf04e03a8d 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -55,24 +55,24 @@ examples:
         compatible = "pwm-leds-multicolor";
 
         multi-led {
-          color = <LED_COLOR_ID_RGB>;
-          function = LED_FUNCTION_INDICATOR;
-          max-brightness = <65535>;
-
-          led-red {
-              pwms = <&pwm1 0 1000000>;
-              color = <LED_COLOR_ID_RED>;
-          };
-
-          led-green {
-              pwms = <&pwm2 0 1000000>;
-              color = <LED_COLOR_ID_GREEN>;
-          };
-
-          led-blue {
-              pwms = <&pwm3 0 1000000>;
-              color = <LED_COLOR_ID_BLUE>;
-          };
+            color = <LED_COLOR_ID_RGB>;
+            function = LED_FUNCTION_INDICATOR;
+            max-brightness = <65535>;
+
+            led-red {
+                pwms = <&pwm1 0 1000000>;
+                color = <LED_COLOR_ID_RED>;
+            };
+
+            led-green {
+                pwms = <&pwm2 0 1000000>;
+                color = <LED_COLOR_ID_GREEN>;
+            };
+
+            led-blue {
+                pwms = <&pwm3 0 1000000>;
+                color = <LED_COLOR_ID_BLUE>;
+            };
         };
     };
 
-- 
2.34.1

