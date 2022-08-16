Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF9595C14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiHPMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiHPMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:43:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA7E0EA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x9so10377285ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mXw/gx1TvWDFNgjG1qr/pqI36Mmqb6KSC/b/lR/QsLU=;
        b=UOD+BcMyRjVsH4kpBqlLIK2b2A6X22Fk98td5h08SfU3rLaN3A4713G7vwvrur5HLK
         Pk1LBL+7sG5dA3fya9ULzrcPxulo+m2THIeX96jFXHP+bQky+LTbs8+o6WJZUU6hFa4h
         /nv1gUMjMUmx0/WIEREx3Jt7HQgu+1DyCicNyxchyWXgA8FKLYgvIQ/6YYazUFcJTnIK
         yFdIWP0n7eZg2wjebtdTCK0ihtpD+tO2WMW2kkzp7u3xiUamZyR1qGdbHyh2k/fsJxys
         NQiJrB4bWdcQcsLupdk1WRRHJI+dHKvxkoTRoYd59V5S41pnk7DAZwySiCTO8Ax5fsjP
         MeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mXw/gx1TvWDFNgjG1qr/pqI36Mmqb6KSC/b/lR/QsLU=;
        b=ULSH/O6ai9EY0HqdAn7q7OjBOC/p8kKuaqCQHs1zXKzKlmV/HXjAa6zAuK6wz/ZUPq
         moFHB1yYWSImajTK0JL3nv91fQaarQOvJEeV5rqyqmq67Il6N+RLLBPhaxZcLm0JvsQ6
         4yB1dWACfKEcd94GWuD8/liVGOxYpYU/rfixBdZB0uIkvbWzX74U87E18hXd12PNOkdL
         c0KZzY8qfty+Y52Abp+jCJeIFPsWebhCfjVCjSVOnyWCI3GMxz3zys3mKvHeMbazyNRp
         UfwXhSyILqPtvwlP+++G7sP8pgpAMRQquL3q7HBOP1PNTw7WhjIaKDzJmXXbS/6/DwCy
         e97g==
X-Gm-Message-State: ACgBeo1Ain0JDdWyHaTBz7fW8CGHl1Ojp7lVZo7mG2XtLUSOPACRTCmN
        +U8PXpVpKskSsQCo121XZSmonA==
X-Google-Smtp-Source: AA6agR4ai7LCLiPmkNEtn/nJ8aEGD9ABZLCARPKKtmwJv+lllCUd9YTnpnjNqeElGn0ysM8MZbJFBw==
X-Received: by 2002:a05:651c:2227:b0:25e:cc38:a1e6 with SMTP id y39-20020a05651c222700b0025ecc38a1e6mr6862261ljq.84.1660653820906;
        Tue, 16 Aug 2022 05:43:40 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k14-20020ac257ce000000b0048ae4cf8a2csm1374331lfo.258.2022.08.16.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:43:40 -0700 (PDT)
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
Subject: [PATCH v3 03/10] dt-bindings: iio: amplifiers: adi,ada4250: use spi-peripheral-props.yaml
Date:   Tue, 16 Aug 2022 15:43:14 +0300
Message-Id: <20220816124321.67817-4-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/iio/amplifiers/adi,ada4250.yaml    | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
index 5277479be382..c15da155d300 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
@@ -27,14 +27,15 @@ properties:
       Enable internal buffer to drive the reference pin.
     type: boolean
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - reg
   - avdd-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

