Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADB595C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiHPMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiHPMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:44:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194FC356EB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:44:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so14756097lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZNmQiW5AvIOtEUDHlEIUtIO/nCYrI/d8smXZXTrIU/o=;
        b=ubCScZ0q9loZZzBaDHMsnkAr+Xnf0ct7t6QohzXWnoPGw69EDyNvXcLCT/1NwPMe0J
         OZIusnmonsk6u2iHoDIoKJhDyLtB4waUwMRFxkbGTDLZgGePyZziiPQAbhSadYEJzo7H
         jkJ6cdWc+ovszBtXnGzBLXGQNNTtG9ZLR+mysI6WfuTJnfYakipdLptor/fhgABDCa1q
         scikdDNIOrf1fjuUaA+roiheulylJjNmyA9OnX1IxMCkHN15AXLCPWO98rIrxA61m6OO
         KGkREXyFm/Rr4/O4RUhzNAXTv3hc4Uz1hPmApXqr/mH7xvrmfhU8w43HCfIO40lYwhkF
         ZOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZNmQiW5AvIOtEUDHlEIUtIO/nCYrI/d8smXZXTrIU/o=;
        b=eRY90Sk/uBer7uhXY4RVuXxI1oz/34V4YXfW3pqfboeHKLaFNg5TO8NGh8wzHjVJdO
         fvVoKqAt3RKPsJHc0Spqe0Akhnx4GHIylbQ8fg8z1j8OF9ND9QQskrgfSXiJyM6fpsku
         EwVYM0RPB4RGN3Oo+EumomVZbsqjc8vcKcTBjzX5uOPrRsayHMT5fa4Q1CDqkK+CPFxB
         /VGAJFAMSg8D9ds2xxGrkNlNMXOpKmAj0+dTmXjjf6eyrFypOo0Q86l8AJ25GDb9Fw+a
         YDzuJBWu6rKPRBhLLo3reRz44NT84N5GLXdPNU/UuOgUEL60bCn521dIPi62IkBWQpeR
         NeXw==
X-Gm-Message-State: ACgBeo21dZSHZgtjiX1H5IYALohTTqMngJjkN9H1XsZw4vXwzQ7ZGah5
        kN0N2KqDkcB4yRIzAcRMV/KFCQ==
X-Google-Smtp-Source: AA6agR4AaHt43P3HtQJfbqur6lCNkGkl/bOx3K2jvgqOFTGoSVo82LRZWU9GtjbYX12tSuyhQQ9h7Q==
X-Received: by 2002:a05:6512:b9d:b0:48b:2567:4bad with SMTP id b29-20020a0565120b9d00b0048b25674badmr7266813lfv.9.1660653839576;
        Tue, 16 Aug 2022 05:43:59 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:59 -0700 (PDT)
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
Subject: [PATCH v3 09/10] dt-bindings: iio: samsung,sensorhub-rinato: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:20 +0300
Message-Id: <20220816124321.67817-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
References: <20220816124321.67817-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

