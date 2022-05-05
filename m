Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3B51C61C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382691AbiEERdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiEERdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:33:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8116B5D5C1;
        Thu,  5 May 2022 10:30:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so10101342ejb.0;
        Thu, 05 May 2022 10:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYoAdCdkT7PiEbbErCv6i3mZvm+YUlK175LWY0Bzz/E=;
        b=ETpzOAYLa4fFqZFrmj9IvU3fXGkfXuYQQfd57DQ2qqkggZCI+0UiH7qkSKEtwI0Eai
         mw9glO0bjOnoSv5ArnbCVp7RsOtIDIqwEMj3tZTwYPSlFn/Zv7Rpbwhq7k+OV9fsXJBH
         0nLT14gjFbkXvSs31mA4MVU2bv/5XaRWL+WnuvSMFR/osx1zq1SruqXu0sE/7t4d6mnI
         613nz1Pxm7DaeB/GwZcc4A4QFHAwY5nAGXDCfTl/8/U41gEAFTa/+n/L7oAxeiM2bycP
         bykictkayyxQZa2miOM0Qove/fTbgbMbcbw66+/KJs7PU0hX492U/i+WwlGB6UUWNg7y
         nhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYoAdCdkT7PiEbbErCv6i3mZvm+YUlK175LWY0Bzz/E=;
        b=eSMEF4W/zUhYjDGBfH0svNK7c9x0nkfJERbZiM59er6X6ozHbJw2IgxGHujBbL4/fp
         dysMUorUweJGjyXjIAStydEqJ1otO2eZ3Mirjyg1cOY7KCYyqkb/PiocQw7rI8chNbIn
         IUit+TerscRci/YxCXCUT2lnkm/cQotqSKgsd1SJqWrA8T7T+MSxkewge1U/MkfBtaLh
         CBD8QvNT4GmFfvuj0spTTjIfAsNQfXcx4tp4S1WkkSjsu7R99xefYdwlH9ziTYnpsMqy
         mHC6Bgy15JzfdzE6h4DwiASK2Pb2MnVqFLqpWuBxyKSI6cN2l2JBTuu6aHpmCgRRgNXT
         F2/A==
X-Gm-Message-State: AOAM532Lyl5O2TfxuUQJ5zETzneV77M3QqMcXdnlnSFG2n5i2iD5LGi4
        JExhrwp6Ty0jGIEmm35ZdwuANU3dB5Pv2nS4vNA=
X-Google-Smtp-Source: ABdhPJwJ6yGxBuUMEhWaaOxxqNqSIRu0QKpM36bbmxkM5ZA73z9f6q7bCcRpX4x5v3gRRad/6IhNm37Ex0p6Kpk8HM4=
X-Received: by 2002:a17:906:3ce9:b0:6ef:a8aa:ab46 with SMTP id
 d9-20020a1709063ce900b006efa8aaab46mr27580535ejh.579.1651771809991; Thu, 05
 May 2022 10:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220505152521.71019-1-markuss.broks@gmail.com> <20220505152521.71019-2-markuss.broks@gmail.com>
In-Reply-To: <20220505152521.71019-2-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 May 2022 19:29:34 +0200
Message-ID: <CAHp75VfUA3qnZnkPQB3TRpPDwe+F+Q6rv9dQmq2xLfw9PmJ8LA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] leds: ktd2692: Avoid duplicate error messages on
 probe deferral
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     pavel@ucw.cz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 5:25 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Use dev_err_probe instead of dev_err to avoid duplicate error
> messages if the GPIO allocation makes the probe defer.

Thanks!

There are two improvements we can make here.
1) adding a Fixes tag, so it can be backported to stable kernels;
2) see below.

...

>         led->ctrl_gpio = devm_gpiod_get(dev, "ctrl", GPIOD_ASIS);
>         ret = PTR_ERR_OR_ZERO(led->ctrl_gpio);
> -       if (ret) {
> -               dev_err(dev, "cannot get ctrl-gpios %d\n", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(dev, ret, "cannot get ctrl-gpios\n");

You may improve this and simultaneously prepare for the next change to
be smaller

       led->ctrl_gpio = devm_gpiod_get(dev, "ctrl", GPIOD_ASIS);
       if (IS_ERR(led->ctrl_gpio))
               return dev_err_probe(dev, PTR_ERR(led->ctrl_gpio),
"cannot get ctrl-gpios\n");

All the same for the other case.

-- 
With Best Regards,
Andy Shevchenko
