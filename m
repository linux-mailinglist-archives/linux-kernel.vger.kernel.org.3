Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DE595C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiHPMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiHPMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D53F1D4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:44:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v10so10386450ljh.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DTTVWNUuMuaI4chfKvwmUvgtvzhYatcrU+SN3O9eX+s=;
        b=Rz/Bg7RXfF9irofPn2f5JRMl6e7xpzl07U7q2YW7ggsvflNyOQXQetfbdsPZrj64dw
         kjJLbrLhG/EJWS7zRk7OmFJtsxamRr88a9UNMtgl5BLF1MiJXIXwsogyQTRvU5+cmp8X
         aikirXAb7svNW5KlQ8wRRA9rihIW3PB5/5LvJyn56MJPpGI/kzEUVaV1fdr5Tnd0Y5o2
         GFWuXuG86Mj4cTUbJD0Q+/hXTH1CZMbipuGJNpObXdQ7CLvEMRWoRxCKod2o2IV2ndnL
         FkyORuHzOIxP4HMz4niUBSyR4qeWl15yBwyT64yYxIO4vtBtkksCjzJFMx1TMrb9E/r9
         Yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DTTVWNUuMuaI4chfKvwmUvgtvzhYatcrU+SN3O9eX+s=;
        b=Axaig0vq7qRBO/XxCHa5A7O7Gc4ArYK6gqYNnP5foDQyn1FljF/pQsW9lfnZ4Ch1Vp
         TkKEgYfHmdVhsQxfTqpMSyEh1DIBOyQtQ/LUI2dvLHGb+0ZgvTzVVRK6E13jB5KU2Asp
         M++vSF5x09dkPeh98MT/EWJ41PtuX4J3k5s3pF89s5QudlyGFVZpTX1cn8x6YJ0/D3qz
         WpK2sg3F3X14jttRCVec6zSHrce5Xw4cL0jTZ3RPOhQyY0LVdAjm7fMGCoHz+osUqPDI
         1esY0BRlZyevel0sw53h7FgBNG/KO3dCLCdk3A05XsH+ZYgW+0RanxFPXskZfucJiJWc
         M81A==
X-Gm-Message-State: ACgBeo2FsAI21dTnacxr5sP9ClGJAgXiQa+5tsblEgTfdyrEeQ2BHKa5
        MlfTlTphUqDracp3dIj5zeBBXg==
X-Google-Smtp-Source: AA6agR6fGVu+pxqV/ukc2QaGNAOXAG0OJBCmVDysetGBzD8b2PceHFIC8XraGHh0rASo187HWNwA7Q==
X-Received: by 2002:a05:651c:30d:b0:261:9979:5061 with SMTP id a13-20020a05651c030d00b0026199795061mr639524ljp.520.1660653842421;
        Tue, 16 Aug 2022 05:44:02 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:44:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andrew Davis <afd@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 10/10] dt-bindings: iio: temperature: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:21 +0300
Message-Id: <20220816124321.67817-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
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

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/iio/temperature/maxim,max31855k.yaml           | 4 ++--
 .../devicetree/bindings/iio/temperature/maxim,max31856.yaml | 6 ++++--
 .../devicetree/bindings/iio/temperature/maxim,max31865.yaml | 6 ++++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
index 9969bac66aa1..0805ed7e2113 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
@@ -32,7 +32,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
   spi-cpha: true
 
 required:
@@ -40,6 +39,7 @@ required:
   - reg
 
 allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -53,7 +53,7 @@ allOf:
       properties:
         spi-cpha: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
index 873b34766676..228a94165487 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
@@ -19,7 +19,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
   spi-cpha: true
 
   thermocouple-type:
@@ -34,7 +33,10 @@ required:
   - reg
   - spi-cpha
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
index aafb33b16549..a2823ed6867b 100644
--- a/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.yaml
@@ -25,7 +25,6 @@ properties:
       enables 3-wire RTD connection. Else 2-wire or 4-wire RTD connection.
     type: boolean
 
-  spi-max-frequency: true
   spi-cpha: true
 
 required:
@@ -33,7 +32,10 @@ required:
   - reg
   - spi-cpha
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

