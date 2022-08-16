Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86146595C18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiHPMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiHPMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329073340E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:44:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a9so14722581lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7axPEVk6MWtPTP7h5E9Ae0SR4WCvVBdWSVGZwXrfCJc=;
        b=dZqAsC4XhmDGuivuJcwZM7XD6vsmSzcY0u4o8BuY6kIwGsvI6j05G+i7ZngVXzhyt3
         0+zhxwe+OpM9q3PkrseisLeE+hZs9AmQhAPvAGf79ksMxYi7TezPrZF5RvvF4N/4H7ps
         s6j2nlWSf+mnm5lw+I5OqKCqtSUEOmsEP3L4F2LR1D3Tw3Qo4s4dTdpRh9ZQe+dzDOQd
         ZsgPxCHQZndYyn1puvJ9uDMb1G1drtDUPT5MWl4ZSF0dw1QkhHRdcCZc3k/HR9cJR/Ab
         1/FKLJk66XuLQZZJmMq+crAjRH2GMFwlQIx5BaLcCY6gHf70h9FVgDJpvcF6sOOjVin6
         Barw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7axPEVk6MWtPTP7h5E9Ae0SR4WCvVBdWSVGZwXrfCJc=;
        b=DauNrkQWpNrOvF3xWDkzCiVqeTYsW2KKYHqMEwCMeaqgL/sM8AxN7MAMqPRbyL0XAs
         g49AdTjkVF2qRUbLyhGcW15T3YFXnECEJIBXiVxthDLkJ2bq1lG1z+mb8L/Qzld1Gbd0
         SO0hHGLOPhMpvdKNkdKzBbx3QLN+7lJnS0JfHIqR0Izt67CW669DHkfDKUf7rr6tzXX8
         IGnMz+Vkhg/fyEDOwDLavQCbhcQOcTuErFuFKeZfZ2WasWrdL+/4kzgVBb4kkyBlkb8O
         8HYiFdJPBRd3rGFL/o1q13B5OZMhcszdE+jH2LBqxJWDzNFhHa7L+P5iAm0pbceMIQfX
         U6pA==
X-Gm-Message-State: ACgBeo3J5mZ5Sd0nBRum7ku/9aqnV4EzaE+Wl4DqJIR6Y2shdrR6t83H
        Mu3RxyIdtOpQmBBPCdZRgOYmqA==
X-Google-Smtp-Source: AA6agR6mLRrkmmfsWWDpLPe2t3pnsuvb7LjZmhWGTARYqtxu2V3K4lbwTakD8q/5jl7F2/IulI5udw==
X-Received: by 2002:a19:434d:0:b0:48c:fe67:5e83 with SMTP id m13-20020a19434d000000b0048cfe675e83mr7430482lfj.630.1660653836368;
        Tue, 16 Aug 2022 05:43:56 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:55 -0700 (PDT)
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
Subject: [PATCH v3 08/10] dt-bindings: iio: potentiometer: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:19 +0300
Message-Id: <20220816124321.67817-9-krzysztof.kozlowski@linaro.org>
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
 .../bindings/iio/potentiometer/microchip,mcp41010.yaml   | 9 +++++----
 .../bindings/iio/potentiometer/microchip,mcp4131.yaml    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
index 567697d996ec..87e88f2a9908 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.yaml
@@ -25,14 +25,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     spi {
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
index 32e92bced81f..896fe0b5edcc 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
+++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
@@ -80,14 +80,15 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
-additionalProperties: false
-
 required:
   - compatible
   - reg
 
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

