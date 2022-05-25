Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F05340AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbiEYPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiEYPtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:49:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A669BADD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:49:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k30so30688734wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UydJpbLrcWgMt1c84uBS/iZ7u4bglmQySLbHThAhvv8=;
        b=QTIaIlC6V+Y2TEijOedrdXkH8QV+VA1NdYAe/JUsY/KqEV4KGfYALljT8Ye0foBG5B
         dTA0i9pp7RX3unhE/gwPaK8q/pGfNpq6+LR1lyueCO//cqlXM0cUPJmzh1xXDxPC/LFl
         M3SNs+wrvCsyVMvQKrpBq4lNQB/8AM1UX1Y5ejUxfM4CFfI9Fccnmm9M8s1bCJDzsgMk
         7BZnK1FCAahe6Lajc3N5cR92/GbKUi8l8L02gryb7sQLkitwTt2LF/WxGkxN6BGjq6aV
         HRF+JdZ6z14+N89qBM3euzQrkLxEOMRT02YFCOXK9yGxd11lFPzNj1pyO0nzO3hKlOOq
         rEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UydJpbLrcWgMt1c84uBS/iZ7u4bglmQySLbHThAhvv8=;
        b=eYZ2qWKgmaGcMmMu0e+t9hhFKm64vkquM/Y6I9cSLnq19Opm/9BshUz+iuHGW3N5M1
         4uq/ems0q/B456mPrCHsExPZDgLg2nMfBKa5ydehPMbVVCZtJldYR5Bn7XYDm846lVWJ
         GS4H8ez2rM4T8a4Z2AimRAp30hnKdW1APWLHogjOrnap0Q6Dgk9w0edqZOdqVDEuIh3N
         uIgMmmgHOJR9jNLq6Pnwa2wYluQs9ZWN+3Io0Dmj9f98xZBPfAAEdQR670Nd0nWAOPNc
         J30fHv07D5FDv03hdJFgqc+5QX3wX0IJoq6j5NTWa/Ap8Xv9xKZwkXMQUOC7q7VpTc0S
         PHeA==
X-Gm-Message-State: AOAM5324Byhn4n14vUpo3kzCBLtzF8YYWfHpWPIy1lfoJvS7Bkp9UxKS
        iIN4bV63pY8PWgVphOXyq3klFPUSq7bGDKb2YgRtTw==
X-Google-Smtp-Source: ABdhPJxW3P7y/3hZmf3oJarDJb+f5mlGntOYXlpyGBbZxJl9sr6o1mQ35VINtAjKqesywtLHaI2VaL5MCQvFW0dkMfE=
X-Received: by 2002:a05:6000:1f89:b0:20e:5db3:febf with SMTP id
 bw9-20020a0560001f8900b0020e5db3febfmr27632896wrb.685.1653493776647; Wed, 25
 May 2022 08:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-4-brad@pensando.io>
 <888c0f62-7845-715e-12a1-7b16f84d2ae9@linaro.org>
In-Reply-To: <888c0f62-7845-715e-12a1-7b16f84d2ae9@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 08:49:25 -0700
Message-ID: <CAK9rFnyUwdqcpn0y7h-S1DbXDG3QOw+kaBBKPq=4wVHDvznzBg@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 11:57 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> >
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -19,10 +19,12 @@ properties:
> >        - enum:
> >            - microchip,mpfs-sd4hc
> >            - socionext,uniphier-sd4hc
> > +          - pensando,elba-sd4hc
>
> Put your entry in alphabetical order.

Yes, will order alphabetical.

> >        - const: cdns,sd4hc
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
>
> This needs allOf:if:then: which sets constraint on number of items per
> different compatible.
>
> >
> >    interrupts:
> >      maxItems: 1

Thanks for the recommendation.  Changing to this approach as the
second item is only for Elba SoC.

Regards,
Brad
