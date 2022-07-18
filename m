Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD6578D30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiGRWAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbiGRWAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:00:17 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C030569;
        Mon, 18 Jul 2022 15:00:16 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id r70so9298051iod.10;
        Mon, 18 Jul 2022 15:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gIUyF/ORGQjWXNvT5wIOVjajXgGpEkbk6f/tl0gQiac=;
        b=di179KuRgOE3ptTOBICiYzoBzUoVyGF9NcDnAWKlJ34a3iqCe93L5MVLhfVGXDplcv
         jQiviGqfADQCBsd5sNR40P5VXco+51oEP7/l96m1RWCCRhvC6M4EJp60E3uNtao9B+wA
         x65ZBP19n3zU5x2ku2rO0vHRWJd//IdeBb6Odeorc3dzLOP1i8JFSl5KCEbYAa8czmMZ
         t2Pt/NHUL1093wk95oHAtugkFByX8iqJYjCfByFFdFP391ICgCqViiWt/luytfTdvwIA
         7aA7YU6oiuAs4D0vk1UJzSuBXR8wZeBDEKnoLBX8UqyS3AkBqN+W1Am8cYRLypIS5U+N
         /eEg==
X-Gm-Message-State: AJIora9SqI/5In3vPbAFmo+b4Tg8RGwirBzBn56cCvKA9YK3Qhv3XvmD
        aUO4Y10dPA3w5NioUtw+xg==
X-Google-Smtp-Source: AGRyM1sUfx9PknCBXVyopJZHm5bZnR/LgT1hX56ktRZLDXFdm584csRgriFVCGgWxWMs/6JjxIxhVA==
X-Received: by 2002:a05:6602:2b84:b0:67b:d178:38bb with SMTP id r4-20020a0566022b8400b0067bd17838bbmr11138408iov.120.1658181615882;
        Mon, 18 Jul 2022 15:00:15 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 7-20020a921307000000b002dcafb975c6sm5175816ilt.82.2022.07.18.15.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:00:15 -0700 (PDT)
Received: (nullmailer pid 3640548 invoked by uid 1000);
        Mon, 18 Jul 2022 22:00:12 -0000
Date:   Mon, 18 Jul 2022 16:00:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
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
        Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] dt-bindings: iio: adc: use spi-peripheral-props.yaml
Message-ID: <20220718220012.GA3625497-robh@kernel.org>
References: <20220715095302.214276-1-krzysztof.kozlowski@linaro.org>
 <20220716192604.21a1d835@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716192604.21a1d835@jic23-huawei>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 07:26:04PM +0100, Jonathan Cameron wrote:
> On Fri, 15 Jul 2022 11:53:02 +0200
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
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > This is an RFC with only some files changed, as I am still not sure of
> > benefits for typical case - device node has just spi-max-frequency and
> > nothing more.  I still find useful to reference the schema, but maybe I
> > am missing something?
> > 
> > Before doing wide-tree cleanup like this, I would be happy to receive
> > some feedback whether this makes sense.
> 
> Hi Krzysztof,
> 
> This has the side effect of allowing spi-cpol / spi-cpha for devices
> where they weren't previously allowed by the binding.  A typical device
> only supports a subset of combinations of those.
> 
> I'm not clear whether these should always be allowed (e.g. allow for inverters
> etc in the path) or whether we should be enforcing the "correct"
> settings for devices assuming they are directly connected.
> 
> Currently we have a bunch of bindings that are documenting the allowed
> flexibility - including cases where only particular combinations of these
> settings are allowed.
> 
> So we could either:
> 1) Note that we've been doing it wrong and the binding should not enforce
>    these constraints so remove them.

I'd lean towards this.

> 2) Add explicit spi-cpol: false statements etc the drivers where they
>    are not allowed.

3) Drop spi-cpol / spi-cpha from spi-peripheral-props.yaml. It's purpose 
is to collect all possible SPI controller properties that are per child 
node. Whereas we've said spi-cpol / spi-cpha are device specific 
properties.

Rob
