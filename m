Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C479F58940D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiHCV3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:29:32 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CF19039;
        Wed,  3 Aug 2022 14:29:31 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id t15so9117379ilm.7;
        Wed, 03 Aug 2022 14:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=f9z9dK9gA2venJcM+Ps6Eq8WAHFZdcYaDOsADmzzKJM=;
        b=fWS/DW8E32o5lPuhuJllmdnNYjJb5RXZ8afAI2Ml4Nt7iaOD4vQgbYV566ASLkOBVz
         RRTK25XvKiXPUjC8CBeKESBR0TZztVgO3Vct285D5XjqSos5FJ3kYabHuvYOyMzw4HF8
         Gjyx5oTnUw+DDijY99B2/cBqISeA/pLTJt+y/oRWxJ0FcNiq60m/5PyM9C+RklAUfPkL
         guNSGKJ9vokMyE3P5tPa3alUiFW/dSBJyUJ2eu88HrDdQNhhoDrZ4b3k81N/DBmd5sUX
         TiXkPISWMFRR1BBLWPtUUFr1Bsgv1Y1I1U7GH9zSyNI1LPf8EyEdyk6pUPRtTq/T8nnf
         0Brw==
X-Gm-Message-State: ACgBeo1zZAwdq2RQdAvyJpy4rfRNd8/ggSjeyYyN7KbObQNQ6tyCVBFw
        2QncZGFTfe1awP73gtj/sg==
X-Google-Smtp-Source: AA6agR45hy/Rqr678r9u1i7F2l8fa2PcLMenAO+cXPDrjNWdbPfsgq4JOvN7Y9ATPWx78l9RcviHMw==
X-Received: by 2002:a92:cc41:0:b0:2de:a27c:a2ba with SMTP id t1-20020a92cc41000000b002dea27ca2bamr6686570ilq.285.1659562171097;
        Wed, 03 Aug 2022 14:29:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y19-20020a02ce93000000b003428d1fbf4asm1413340jaq.36.2022.08.03.14.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:29:30 -0700 (PDT)
Received: (nullmailer pid 2654000 invoked by uid 1000);
        Wed, 03 Aug 2022 21:29:26 -0000
Date:   Wed, 3 Aug 2022 15:29:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
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
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <martenli@axis.com>,
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
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: accel: use
 spi-peripheral-props.yaml
Message-ID: <20220803212926.GA2639296-robh@kernel.org>
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
 <20220727164646.387541-3-krzysztof.kozlowski@linaro.org>
 <20220731164943.320babe4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731164943.320babe4@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 04:49:43PM +0100, Jonathan Cameron wrote:
> On Wed, 27 Jul 2022 18:46:38 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > Instead of listing directly properties typical for SPI peripherals,
> > reference the spi-peripheral-props.yaml schema.  This allows using all
> > properties typical for SPI-connected devices, even these which device
> > bindings author did not tried yet.
> > 
> > Remove the spi-* properties which now come via spi-peripheral-props.yaml
> > schema, except for the cases when device schema adds some constraints
> > like maximum frequency.
> > 
> > While changing additionalProperties->unevaluatedProperties, put it in
> > typical place, just before example DTS.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > I wonder if spi-3wire is device specific (not controller) and should be
> > rather explicitly mentioned by device schema. Just like spi-cpol/cpha.
> 
> I think it is, but Mark is expert on this.

I would say yes as it's the device with a single data line.

> In general I'm waiting on Mark's opinion on the whole idea!

The prerequisite changes (except for spi-3-wire) are already queued up 
by Mark as are changes for other subsystems.

Rob
