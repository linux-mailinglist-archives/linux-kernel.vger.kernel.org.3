Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98004CCA02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiCCXZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:25:01 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D2710D0;
        Thu,  3 Mar 2022 15:24:15 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so7542359oos.9;
        Thu, 03 Mar 2022 15:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vfm2jK+tU0YA9XVn2HUL++BRTsYSj8H0ghNLcRVI0aY=;
        b=lF1M84G8Md/LQpNzWjJypf0LJm1j8AToDqmju4sbtk6VrdZ8lICzBDK3sD2OSB8Wsa
         wnIWzSc8Doeun093xFHZ71pxqHpywVKk8jJImEj2kQZeBSpKXyDsHPWOufEXbKcyF2lQ
         WpEH5ByIQmB+J1M6gI7coCB0qGG3WrzWrRgvOTzfGnxAQcNxthS4o8LCVeG9dpgzFcF3
         m52fJ9nfQM4WjTt7vnOR+S7sewlKZk8g1FaJwFM5OaPMagt1QSHWfElp7A+H2pQc/Q2f
         QlGle2OwYOHBVnrB9bT4ccyVIMV1Jgqg0WPKgKELBoH2WrJo9tkxxzMkOCtRLeXxRDFP
         GSAA==
X-Gm-Message-State: AOAM533JIrMLtZLlgy/TzRt8SzgOls6PWiaYSWsy9z6I2d87XvsCZZzu
        D806gHQ/HYnejB0jOpFZquY56JEF9Q==
X-Google-Smtp-Source: ABdhPJy/AfNGD3ko7bxz0ZgWRWoEoA/ewhRmp21gvsTgCpu1A+pig7QyPb5sbwgUIyO1QIXOWxOmYw==
X-Received: by 2002:a05:6870:f286:b0:d7:84b:f1bf with SMTP id u6-20020a056870f28600b000d7084bf1bfmr6015116oap.179.1646349854971;
        Thu, 03 Mar 2022 15:24:14 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id l6-20020a056870d3c600b000d75713938csm1724128oag.7.2022.03.03.15.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:24:14 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        - <patches@opensource.cirrus.com>
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org
Subject: [PATCH v3] dt-bindings: mfd: Fix pinctrl node name warnings
Date:   Thu,  3 Mar 2022 17:23:49 -0600
Message-Id: <20220303232350.2591143-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent addition pinctrl.yaml in commit c09acbc499e8 ("dt-bindings:
pinctrl: use pinctrl.yaml") resulted in some node name warnings:

Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: \
 lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
Documentation/devicetree/bindings/mfd/cirrus,madera.example.dt.yaml: \
 codec@1a: $nodename:0: 'codec@1a' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: \
 pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'

Fix the node names to the preferred 'pinctrl'. For cirrus,madera,
nothing from pinctrl.yaml schema is used, so just drop the reference.

Fixes: c09acbc499e8 ("dt-bindings: pinctrl: use pinctrl.yaml")
Cc: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix lochnagar-pinctrl nodename in example
v3:
 - And fix lochnagar-pinctrl nodename in 'required'. Sigh...
---
 Documentation/devicetree/bindings/mfd/brcm,cru.yaml         | 4 ++--
 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 6 +++---
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml          | 3 ---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
index be4a2df71c25..b85819fbb07c 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
@@ -39,7 +39,7 @@ patternProperties:
   '^phy@[a-f0-9]+$':
     $ref: ../phy/bcm-ns-usb2-phy.yaml
 
-  '^pin-controller@[a-f0-9]+$':
+  '^pinctrl@[a-f0-9]+$':
     $ref: ../pinctrl/brcm,ns-pinmux.yaml
 
   '^syscon@[a-f0-9]+$':
@@ -94,7 +94,7 @@ examples:
             reg = <0x180 0x4>;
         };
 
-        pin-controller@1c0 {
+        pinctrl@1c0 {
             compatible = "brcm,bcm4708-pinmux";
             reg = <0x1c0 0x24>;
             reg-names = "cru_gpio_control";
diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
index c00ad3e21c21..ad285cb480c9 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
@@ -126,7 +126,7 @@ properties:
       clock-frequency:
         const: 12288000
 
-  lochnagar-pinctrl:
+  pinctrl:
     type: object
     $ref: /schemas/pinctrl/cirrus,lochnagar.yaml#
 
@@ -255,7 +255,7 @@ required:
   - reg
   - reset-gpios
   - lochnagar-clk
-  - lochnagar-pinctrl
+  - pinctrl
 
 additionalProperties: false
 
@@ -293,7 +293,7 @@ examples:
                 clock-frequency = <32768>;
             };
 
-            lochnagar-pinctrl {
+            pinctrl {
                 compatible = "cirrus,lochnagar-pinctrl";
 
                 gpio-controller;
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index c85f759ae5a3..8a90d8273767 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -107,9 +107,6 @@ properties:
 
     additionalProperties: false
 
-allOf:
-  - $ref: "pinctrl.yaml#"
-
 required:
   - pinctrl-0
   - pinctrl-names
-- 
2.32.0

