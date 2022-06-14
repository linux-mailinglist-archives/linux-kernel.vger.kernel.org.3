Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125DC54BAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbiFNTvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbiFNTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:51:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4603123D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:51:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f8so8595356plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Ecx08SwSkVkIJVWaln62nBgxH1hkKlL33dPGnZJP9s=;
        b=fGN/HzmfpmvlZzkPBNUh8eD8hJkMU2DLPWEkt4XPSmX0TNH7VBT0p+jv9eHqBmUaQe
         qJ8DzAz2S77m1OfnPLyDKfRQwcwFEJaMm6brFwjLIFrleLYj/+ZDHakP2j8Lqv3djP48
         ++RkD1QDKG7H2sAtJAFTDBEKzekz6aKqlxLWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Ecx08SwSkVkIJVWaln62nBgxH1hkKlL33dPGnZJP9s=;
        b=v+waOuyFnIe/sDuaJnm3cMTlmVJsECwzLrRuOmzh+NSD+I/EbhWU3+XartRR047qJB
         vzMTm5PE/RKM6i9znHa6psV1kJHZ+2C8HHRbQNlyNFk8bC8B34OUAeWtaGzpbDP/kRMc
         hf4BJIMNvkHf2HIPkGq5xCol8FnZfcdAAbX03fZQ/UVh9RAoTGhVBQYJpwFctqvntFkx
         zz64Wq+b4IF3gBNXLba0vMIMS29KT7Nd3VHc5GB2PwmMED7NQ3HncgTGmYBmxBZlSiF0
         Sl+fyzJRrb9A+Ao0XXROGWLcyoAyJesxnADYNYYqvltGSiTMYDDP3oC32Hp1zB5P6c5m
         3h2A==
X-Gm-Message-State: AJIora+qotPl6GBk/EuCbfiWG0cKSUbXkEAQiq7tGRCK+ftImqp926Eu
        efk0D2lOkhY/IHbbdwz0irbInw==
X-Google-Smtp-Source: AGRyM1s7JWSIE6WZKxGTi/o5Ek/zUhL6bbR2KfTSGXVfOwo0GmL8v90QzFlnUqLDn1YrPQMfqWk6JQ==
X-Received: by 2002:a17:902:d484:b0:167:770b:666 with SMTP id c4-20020a170902d48400b00167770b0666mr5652568plg.148.1655236307622;
        Tue, 14 Jun 2022 12:51:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:82ae:1136:b202:95da])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b0015e8d4eb29csm7625484plr.230.2022.06.14.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:51:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: cros-ec: Reorganize property availability
Date:   Tue, 14 Jun 2022 12:51:43 -0700
Message-Id: <20220614195144.2794796-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614195144.2794796-1-swboyd@chromium.org>
References: <20220614195144.2794796-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various properties in the cros-ec binding only apply to different
compatible strings. For example, the interrupts and reg property are
required for all cros-ec devices except for the rpmsg version. Add some
conditions to update the availability of properties so that they can't
be used with compatibles that don't support them.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/chrome/google,cros-ec-typec.yaml |  1 +
 .../bindings/extcon/extcon-usbc-cros-ec.yaml  |  1 +
 .../i2c/google,cros-ec-i2c-tunnel.yaml        |  1 +
 .../bindings/mfd/google,cros-ec.yaml          | 29 +++++++++++++------
 .../bindings/pwm/google,cros-ec-pwm.yaml      |  1 +
 .../regulator/google,cros-ec-regulator.yaml   |  1 +
 .../bindings/sound/google,cros-ec-codec.yaml  |  1 +
 7 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
index 2d98f7c4d3bc..adde8c44372b 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -37,6 +37,7 @@ examples:
       cros_ec: ec@0 {
         compatible = "google,cros-ec-spi";
         reg = <0>;
+        interrupts = <35 0>;
 
         typec {
           compatible = "google,cros-ec-typec";
diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
index 2d82b44268db..2e5b39881449 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
@@ -40,6 +40,7 @@ examples:
         cros-ec@0 {
             compatible = "google,cros-ec-spi";
             reg = <0>;
+            interrupts = <44 0>;
 
             usbc_extcon0: extcon0 {
                 compatible = "google,extcon-usbc-cros-ec";
diff --git a/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml b/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
index 6e1c70e9275e..cf523615f5e3 100644
--- a/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
+++ b/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
@@ -47,6 +47,7 @@ examples:
             compatible = "google,cros-ec-spi";
             reg = <0>;
             spi-max-frequency = <5000000>;
+            interrupts = <99 0>;
 
             i2c-tunnel {
                 compatible = "google,cros-ec-i2c-tunnel";
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index e25caf8ef9f4..178e26ab115c 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -20,19 +20,16 @@ properties:
   compatible:
     oneOf:
       - description:
-          For implementations of the EC is connected through I2C.
+          For implementations of the EC connected through I2C.
         const: google,cros-ec-i2c
       - description:
-          For implementations of the EC is connected through SPI.
+          For implementations of the EC connected through SPI.
         const: google,cros-ec-spi
       - description:
-          For implementations of the EC is connected through RPMSG.
+          For implementations of the EC connected through RPMSG.
         const: google,cros-ec-rpmsg
 
-  controller-data:
-    description:
-      SPI controller data, see bindings/spi/samsung,spi-peripheral-props.yaml
-    type: object
+  controller-data: true
 
   google,cros-ec-spi-pre-delay:
     description:
@@ -62,8 +59,7 @@ properties:
       the SCP.
     $ref: "/schemas/types.yaml#/definitions/string"
 
-  spi-max-frequency:
-    description: Maximum SPI frequency of the device in Hz.
+  spi-max-frequency: true
 
   reg:
     maxItems: 1
@@ -158,12 +154,27 @@ allOf:
               - google,cros-ec-rpmsg
     then:
       properties:
+        controller-data: false
         google,cros-ec-spi-pre-delay: false
         google,cros-ec-spi-msg-delay: false
         spi-max-frequency: false
     else:
       $ref: /schemas/spi/spi-peripheral-props.yaml
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: google,cros-ec-rpmsg
+    then:
+      properties:
+        mediatek,rpmsg-name: false
+
+      required:
+        - reg
+        - interrupts
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index c8577bdf6c94..3afe1480df52 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -48,6 +48,7 @@ examples:
         cros-ec@0 {
             compatible = "google,cros-ec-spi";
             reg = <0>;
+            interrupts = <101 0>;
 
             cros_ec_pwm: pwm {
                 compatible = "google,cros-ec-pwm";
diff --git a/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
index 69e5402da761..0921f012c901 100644
--- a/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
@@ -41,6 +41,7 @@ examples:
             reg = <0>;
             #address-cells = <1>;
             #size-cells = <0>;
+            interrupts = <99 0>;
 
             regulator@0 {
                 compatible = "google,cros-ec-regulator";
diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index c3e9f3485449..67134e06765a 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -57,6 +57,7 @@ examples:
         cros-ec@0 {
             compatible = "google,cros-ec-spi";
             reg = <0>;
+            interrupts = <93 0>;
 
             codecs {
                 #address-cells = <2>;
-- 
https://chromeos.dev

