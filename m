Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D48595C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiHPMo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiHPMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D027141
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w15so10417759ljw.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xZf4OdbV43HHtgf1qVIKge/GbJKtAf7d2TC+uXlE1iw=;
        b=rynTyXcnrVRTS54XR7mT6cVGmocPdZptL7qoj9PIuLLKX/oUq5SEsUJ4SAWFFIy+ft
         qEHzX9Ek4Wg9PbKDvyrvwMWpuYFwe1YIEvW3jRelSnmhJfwTbkLC2KIxO0/oq8x6mu13
         lFMwNVxfTIJJa+VJrZ4cX9brlj2YJtuAJPFxtktswcmwD1M8kX0GznqwtfaN2geGmocX
         UrM1DO2i5vNOaAYIx4Fmn1lRxfxCVZlYc3AdNKdGl4A4giWxpWReyUPkRh16n8JP7SyK
         PDQ+qb4xM4FIwfrInTW0g2z9EFvEsiys6HqaRhPucMr9TbyqI1mYjNnYMM84Aux2TXCF
         vK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xZf4OdbV43HHtgf1qVIKge/GbJKtAf7d2TC+uXlE1iw=;
        b=XAtiC02wIj8LD/STLjGwiUpD2GzG3wkrsrJyT2Vu6Qx3lTD17o1GKh/dYvkutbpqvL
         t8oE13bp++tBi3ydJgMs81NsttGpFf9HIKAjrzVogsLVm/6rftiR8G9Jdh4wCzynhpmE
         yFGBsL/a35l/JkJoNue1irernDkAg/bBip48bWj4nh+A8TkKTUG7exxShGcWQpaKv5m0
         pI4qfMvpMosfVn7ljHpZMZuruWWaXfKyCFd4rObpMTMXmByvYP+HXZPOHhbrLzYLUE5y
         Wmd+DrGadx3xH/JXq8tcfpVn1G0Io+ic5tsssWrg3RCH5T10cLVQjLXVDQnphBzIDXwe
         mVQQ==
X-Gm-Message-State: ACgBeo2Plgl5PghL4F4NdfvF6C50An7XK+sR/lNslgLe9EyIG/zEhqbv
        cyd6ikQU+JmQKpj9nObNdR1ZXw==
X-Google-Smtp-Source: AA6agR57fSo7pVY4ZIk5F5u3ttbwWZp5ySDOFnLtt+9ASM6Kt4+3r9g7xKRWIOC/1ek3/2L0OPw4vA==
X-Received: by 2002:a2e:9cc2:0:b0:25e:4ec0:19cc with SMTP id g2-20020a2e9cc2000000b0025e4ec019ccmr6283914ljj.401.1660653826933;
        Tue, 16 Aug 2022 05:43:46 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:46 -0700 (PDT)
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
Subject: [PATCH v3 05/10] dt-bindings: iio: frequency: adf4371: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:16 +0300
Message-Id: <20220816124321.67817-6-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 6b3a611e1cf1..0144f74a4768 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -40,15 +40,16 @@ properties:
       output stage will shut down until the ADF4371/ADF4372 achieves lock as
       measured by the digital lock detect circuitry.
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - clocks
   - clock-names
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

