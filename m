Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC512582FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiG0Rbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiG0R3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:29:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28E52477
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so20432389lfd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNmQiW5AvIOtEUDHlEIUtIO/nCYrI/d8smXZXTrIU/o=;
        b=iWVXqzqfgZWyU6q37aPpBdfPk83KO2tiGk/vS4ImIdjeT2Dl+ubQlKovcWSMO8KLi+
         XwvXqv6Se2XkUBte+uexnIyqDWxxfM0u0eOWoES6PD0zssoj//+yD59C9yD0hTc0h9xd
         OJYba76JcO8JmYRV/v0dPrIFWkYQk785XpnZrV7QFo/tnpdo/SW9GYzql8UngmibcjR7
         cJBtJKoQGp8m9zCsbIAFltb5r3tLwcBSLBei7BirzZAUDtF8jJpMjxo2m8OYcqfkXqoh
         RVXUhQDUyJMgPmr640Dn12uoRvcqGywVXK2mIhMMU7GyeDheyh8xdE88NXCTLjDQlvPY
         1p9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNmQiW5AvIOtEUDHlEIUtIO/nCYrI/d8smXZXTrIU/o=;
        b=t5qH3BPQY9eXCUPuN/0zjDJeOG99N0Sv/4XDQJVvPNGiHXH5JvT3oq66AZah/FpP7h
         pslnGabuAqsxjTEBTDjQZAm5TWVn9SK7cNXctNygrMTZVMaqbe5fGn7T8udpb31WyX9d
         Q/SOYcXQn7AESvsZ34jaWTWREt0dSHgA5V+lsjbbTMY6h/NxkSH9q4nOiy6lIh30VGLg
         SNh56zbdtBYaMJbgSCe8U0zJBKv61Khd06WdPJoR1i9cxA4NWhw3dwj53vpbtKlsJe8a
         /J4yIMRXk1lGnqIL3urfshUxjL0+dg9th3YIoMmq1HyF93JyXT9Oeu9zWFVH8aUEbIii
         ipwQ==
X-Gm-Message-State: AJIora87eMEEu9gP9ANGC1jB2alSrQkQrvElL4fxXh1sOCt1llPKQNPq
        4kzWdW8jE5LVngeed+XF6UPIDQ==
X-Google-Smtp-Source: AGRyM1ut7IU0GDmY5J6kKoccIPiyd8sybZvYlRabx++YLduroVnAeRYMEgFsMozQNRD25CBNiFMpLA==
X-Received: by 2002:a05:6512:c16:b0:48a:97b2:e060 with SMTP id z22-20020a0565120c1600b0048a97b2e060mr4471424lfu.660.1658940450562;
        Wed, 27 Jul 2022 09:47:30 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm3375149lfz.307.2022.07.27.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:47:29 -0700 (PDT)
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
Subject: [PATCH v2 09/10] dt-bindings: iio: samsung,sensorhub-rinato: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:46:45 +0200
Message-Id: <20220727164646.387541-10-krzysztof.kozlowski@linaro.org>
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
 .../bindings/iio/samsung,sensorhub-rinato.yaml           | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml b/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
index a88b3b14d6bd..dd2ae2bd1ad7 100644
--- a/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
+++ b/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.yaml
@@ -40,10 +40,6 @@ properties:
     description:
       Reset the sensorhub.
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
@@ -52,6 +48,11 @@ required:
   - mcu-ap-gpios
   - mcu-reset-gpios
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
-- 
2.34.1

