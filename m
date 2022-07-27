Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CEA582FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbiG0Rbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiG0R3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:29:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AA8049C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t17so15695072lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTTVWNUuMuaI4chfKvwmUvgtvzhYatcrU+SN3O9eX+s=;
        b=U002gDRLMVsJcBk1u0QPgZOu1snf9GyRDIF0+hEXGZ3haziNjkH7VmHhe5k2dep76h
         jGP1rmKNRvmnY0TKJOym7pFkVHO0Kzpg5nM8r6n8X2eRaMlpLLp321HsxcZxZYeR2tKj
         dkCnVXuPkopn82sXC+6c6aJ3W9/+CnsLa768eW2cazuEiSffHnabzcZaJe/b1gW8rSDz
         6YitIkc57NAJWyu483kFfVoK2QTJveFGqunRBSo1523GJGyLiiZzC/MHbCcu8HhYGvEw
         Ab5DHDdwaUDwHCPINisD+tdZt5JiZmV/9vcDZO8x4qnkGSl97nw9JO5myfTyQ1VFH15x
         OCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTTVWNUuMuaI4chfKvwmUvgtvzhYatcrU+SN3O9eX+s=;
        b=uRvrULO3Rnd2y1ivO2nNpf9LcxwgL37F+dDBXJAHOE5Iv40rrwvRAVn+/VM8+qNp7+
         mG/AiqCiUp6wVZ85W8d62K5C488UAAgEF+d+Eviep6AseI07pucgkqLr0nSNsjd8gDCI
         8UR3iuylA5FFHaEEAPDZBKX2EOBwYZssdAxjrrnYVLKZd43CeDmbgwrghZPt0GJpuGF8
         ymKICjQKpoUHZXaVZH017AF/4CDODArnxNuEj+p0KALiEN+pPNL2gm0Q9RZJFGq77XmW
         DX83HpvgsKylKs78/xGfQYaIa7FFgoy5q0E0Smx/Mv/oON5FOKeQ9Mh5LtMzrPPT7ZD5
         pWsA==
X-Gm-Message-State: AJIora8WhbLCKgwqoN1Db+flml7BVyIdL5ga7N6GHqyyJke7grlKTNBV
        Y7aH8nMASQvSdBFfUzMzEwKWug==
X-Google-Smtp-Source: AGRyM1vVIiFk5cN8M18OeA3AFnnZUsvMne4m446kxamz2WkV0ZBhabaZIWjFAE7Y/F+ZoYUbqBF+nw==
X-Received: by 2002:a05:6512:2350:b0:48a:794b:382 with SMTP id p16-20020a056512235000b0048a794b0382mr8070684lfu.185.1658940453508;
        Wed, 27 Jul 2022 09:47:33 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:32 -0700 (PDT)
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
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
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
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Lukas Wunner <lukas@wunner.de>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 10/10] dt-bindings: iio: temperature: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:46 +0200
Message-Id: <20220727164646.387541-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

