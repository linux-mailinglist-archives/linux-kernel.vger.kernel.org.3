Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8586E56095F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiF2Soq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiF2Sol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:44:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F0255B6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:44:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k22so23787782wrd.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pXoQXaJVOBcKlATEFLMjlObz89E2TzcKnRwvkevhS5E=;
        b=TiMYrDEEt89rfAhGSFc1B5YD3QZqhuKNQ4xkwTWbfZevazAu2mhWMcaTHlUtEcCYNZ
         PZRE+oCT7U1sfBKQyVcQtfW6MZHEx0/00YN7x9xtHXEvM66WuXzC3JHAuIaJACEF+8Lm
         Hi+2bqPC3qtad3Acb6APfQDnOpnq/J2finDaPIEGzIFWNzts89ClnAGqPbeivMqinot9
         sYWU92G+3pHd8cF5N/57yPUnJQSiQXdwpp5FBZasFli56ZAAGmS3Wy0xq4xlBe5AAQvX
         DpaLUbu+pp302S7qix947oJA4JAylye0BCc7vc9b73mEghugzKgH8kClzyL2HlRKy3yR
         KjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pXoQXaJVOBcKlATEFLMjlObz89E2TzcKnRwvkevhS5E=;
        b=JxFeXowwHS/wdTIlrYr5yudHQrr5ZGqTwBNO+KofB2DCcb9KdTIwsZ4m4jJEl/q2IB
         bruDXnr3RYLyixsZXOhxvlsp72fuxVVYabpwvFR2K/XQjTs0CxbrFy0t8RXWpIocbkob
         Lt2zaCfoPdTz2Ale9VxQ9sQbaOlJO/yKxwJHvXVqh6Y6++a4Vv/38ffm70xWlM4U6C4e
         xYhGlOQCbvONM7nyTS9xH/0Medbbb2jGKvQwZ6UMbkuNbJsiMnliy5hAw1ALliCMdvFG
         auILuahU/QktKr72DPJcgpMyQqnq6T7p4hwicppIEOTn4fahmLQLp4LEnGDOuMZbBExb
         UGVg==
X-Gm-Message-State: AJIora/fQ+tWYSxESrbicJ4V+isj/sttjbHuX9pDQi8SCRsmU6+r87Ld
        HErQaoyxxfmKLhVgLrgJDm9FXg==
X-Google-Smtp-Source: AGRyM1vxQHSJHGoQ6vCc8iCXWBFLLrjeWelTxc3fxvXsEsQpUDS+RGNItkpvnJxJOyD3/PmICtlZFw==
X-Received: by 2002:a5d:49cf:0:b0:21b:818a:a09b with SMTP id t15-20020a5d49cf000000b0021b818aa09bmr4543186wrs.676.1656528277831;
        Wed, 29 Jun 2022 11:44:37 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm3834371wmj.35.2022.06.29.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:44:37 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 01/15] dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
Date:   Wed, 29 Jun 2022 19:43:30 +0100
Message-Id: <20220629184343.3438856-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629184343.3438856-1-mail@conchuod.ie>
References: <20220629184343.3438856-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

A dt-schema binding for the Ilitek ili9341 was created as
panel/ilitek,ili9341.yaml but the txt binding was ignored in the
process. Move the remaining items in the txt binding to the yaml one &
delete it.

The example in the txt binding has a spi-max-frequency which disagrees
with the yaml replacement (and its own documentation) so change that to
conform with the binding. There are no users in tree of the Adafruit
yx240qv29 to check against.

Link: https://cdn-learn.adafruit.com/assets/assets/000/046/879/original/SPEC-YX240QV29-T_Rev.A__1_.pdf
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/display/ilitek,ili9341.txt       | 27 -----------
 .../display/panel/ilitek,ili9341.yaml         | 48 +++++++++++++------
 2 files changed, 34 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt

diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
deleted file mode 100644
index 169b32e4ee4e..000000000000
--- a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Ilitek ILI9341 display panels
-
-This binding is for display panels using an Ilitek ILI9341 controller in SPI
-mode.
-
-Required properties:
-- compatible:	"adafruit,yx240qv29", "ilitek,ili9341"
-- dc-gpios:	D/C pin
-- reset-gpios:	Reset pin
-
-The node for this driver must be a child node of a SPI controller, hence
-all mandatory properties described in ../spi/spi-bus.txt must be specified.
-
-Optional properties:
-- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
-- backlight:	phandle of the backlight device attached to the panel
-
-Example:
-	display@0{
-		compatible = "adafruit,yx240qv29", "ilitek,ili9341";
-		reg = <0>;
-		spi-max-frequency = <32000000>;
-		dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
-		rotation = <270>;
-		backlight = <&backlight>;
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
index 6058948a9764..c5571391ca28 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - adafruit,yx240qv29
           # ili9341 240*320 Color on stm32f429-disco board
           - st,sf-tc240t-9370-t
       - const: ilitek,ili9341
@@ -47,31 +48,50 @@ properties:
   vddi-led-supply:
     description: Voltage supply for the LED driver (1.65 .. 3.3 V)
 
-additionalProperties: false
+unevaluatedProperties: false
 
 required:
   - compatible
   - reg
   - dc-gpios
-  - port
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - st,sf-tc240t-9370-t
+then:
+  required:
+    - port
 
 examples:
   - |+
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
         panel: display@0 {
-                 compatible = "st,sf-tc240t-9370-t",
-                              "ilitek,ili9341";
-                 reg = <0>;
-                 spi-3wire;
-                 spi-max-frequency = <10000000>;
-                 dc-gpios = <&gpiod 13 0>;
-                 port {
-                         panel_in: endpoint {
-                           remote-endpoint = <&display_out>;
-                      };
-                 };
-             };
+            compatible = "st,sf-tc240t-9370-t",
+                         "ilitek,ili9341";
+            reg = <0>;
+            spi-3wire;
+            spi-max-frequency = <10000000>;
+            dc-gpios = <&gpiod 13 0>;
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&display_out>;
+                };
+            };
+        };
+        display@1{
+            compatible = "adafruit,yx240qv29", "ilitek,ili9341";
+            reg = <1>;
+            spi-max-frequency = <10000000>;
+            dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+            rotation = <270>;
+            backlight = <&backlight>;
         };
+    };
 ...
-- 
2.36.1

