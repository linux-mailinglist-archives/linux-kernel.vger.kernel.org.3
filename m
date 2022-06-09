Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A7545237
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiFIQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiFIQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:43:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68188A8;
        Thu,  9 Jun 2022 09:43:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s12so41411744ejx.3;
        Thu, 09 Jun 2022 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBiZ6SznVvXATC1SUBdZ68AkCh7t6mlC0hhaQj4/WrA=;
        b=OIAtE1zuERdBCetQexFckqbqrgl8T8B+lM+/UK2in1cW48d3d841F68oZ8vjXCGWGm
         l/R8nApT1yg8gtniEWhvesAmqQJhKJqJ+ex9O+mkWozilSiCasF9+MXZVF7ZJEv7FQJp
         ZgMMHUOMz7N9tjwfeHYq5xJbpvoq2ct4pxtBKIk2O0KlqVOjVSo6xobJoThYAi8ysBou
         zeshNvfD7He6Vfam19bdu7Ho9KrQ1ifa2UHnWl+mJKHMOBgFJeKh01TIqMLtT/y5yiWS
         CKZ7S9x8GG7/DWVAEpWnHbhPDJNTYGDj+JcGKfm3cm/DU7VuJ+B2zvjZyKRqJQU0LEpL
         RU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBiZ6SznVvXATC1SUBdZ68AkCh7t6mlC0hhaQj4/WrA=;
        b=FlW5Z30s31cLV1Cr4IOeDoAfjFCbRS4Mmq2SrUzp/HGabVgYFrpXVhFz/e7HReeCMd
         xwebQJ1NTdwS086OZ/OSw6xu/2Jr1Q38kqca8EKvRfyP8SNtRHEOZv5sxQaJP3TXaWNY
         RgV4cQrpulqjGS8J+PljaLqLJADKwRKooeXweDOBDKoXQ7cUMiWzpfexLlmoNC8z8Z+0
         hEqlgwx4kyDgs+FHEM/6XINxBhlxU3hCE8cMwfVTEy5dgG6ELonkqVydPyKB26Z/sS6I
         W5686+As0SSd9YQNn8qA43g5GpFoujKRuPgHZ8NGa9rgggCTUKWwDwNdnjZPqCgDupDP
         BMJA==
X-Gm-Message-State: AOAM532JpoS33z4by2HlL6BfLO29js1tOl69bJaFKXlES+QNVuL+6g8l
        idJVbTlb8GhJNFVeh4CcLxzAaJpsCQg6MRIgvLmQTJCTEpXecQ==
X-Google-Smtp-Source: ABdhPJz2/M0DGbWsj8CASHzOZAB+znTCBKOVfhi/GLCIRO6n1OofksuugGla4O2xS5kBmoRnaG30pqW2Ub50V5gD7o0=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr11280199ejm.636.1654793021839; Thu, 09
 Jun 2022 09:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220609162734.1462625-1-jjhiblot@traphandler.com> <20220609162734.1462625-4-jjhiblot@traphandler.com>
In-Reply-To: <20220609162734.1462625-4-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jun 2022 18:43:04 +0200
Message-ID: <CAHp75VftbVOwPFra83T-k5d1qu3NnD_sDHYxiiSEDDrW3NObNQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] leds: tlc5925: Add support for non blocking operations
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 6:29 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Settings multiple LEDs in a row can be a slow operation because of the
> time required to acquire the bus and prepare the transfer.
> And, in most cases, it is not required that the operation is synchronous.
>
> Implementing the non-blocking brightness_set() for such cases.
> A work queue is used to perform the actual SPI transfer.
>
> The blocking method is still available in case someone needs to perform
> this operation synchronously (ie by calling led_set_brightness_sync()).

i.e.

> +#define BITS_PER_ATOMIC (sizeof(atomic_t) * 8)

We have BITS_PER_TYPE(). Use it directly in the code, no need for a
whole new macro.

...

> +static int xmit(struct tlc5925_leds_priv *priv)
> +{
> +       int i;
> +
> +       spin_lock(&priv->lock);

This can't be called during IRQ?

> +       for (i = 0; i < priv->max_state / (sizeof(atomic_t) * 8) ; i++)

BITS_PER_TYPE() ?

> +               priv->spi_buffer[i] = atomic_read(&priv->state[i]);
> +       spin_unlock(&priv->lock);
> +
> +       return spi_write(priv->spi, priv->spi_buffer, priv->max_num_leds / 8);
> +}

...

> +static void xmit_work(struct work_struct *ws)
> +{
> +       struct tlc5925_leds_priv *priv =
> +               container_of(ws, struct tlc5925_leds_priv, xmit_work);

One line?

Missed blank line here.

> +       xmit(priv);
> +};

...

>         if (brightness)
> -               priv->state[index / 8] |= (1 << (index % 8));
> +               atomic_or(1 << (index % BITS_PER_ATOMIC),
> +                         &priv->state[index / BITS_PER_ATOMIC]);
>         else
> -               priv->state[index / 8] &= ~(1 << (index % 8));
> -       spin_unlock(&priv->lock);
> +               atomic_and(~(1 << (index % BITS_PER_ATOMIC)),
> +                          &priv->state[index / BITS_PER_ATOMIC]);

The whole bunch looks like reinventing the bitmap / bitops.
Use unsigned long (or DECLARE_BITMAP() if it can be higher than 32)
for state and set_bit() / clear_bit() / assign_bit() that are atomic.

...

> +       if (brightness)
> +               atomic_or(1 << (index % BITS_PER_ATOMIC),
> +                         &priv->state[index / BITS_PER_ATOMIC]);
> +       else
> +               atomic_and(~(1 << (index % BITS_PER_ATOMIC)),
> +                          &priv->state[index / BITS_PER_ATOMIC]);

assign_bit()

...

> +       // Allocate the buffer used to hold the state of each LED
> +       priv->max_state = round_up(max_num_leds, BITS_PER_ATOMIC);
> +       priv->state = devm_kzalloc(dev,
> +                                  priv->max_state / 8,
> +                                  GFP_KERNEL);
>         if (!priv->state)
>                 return -ENOMEM;

devm_bitmap_zalloc() ?

...

> +       // Allocate a second buffer for the communication on the SPI bus
> +       priv->spi_buffer = devm_kzalloc(dev,
> +                                  priv->max_state / 8,
> +                                  GFP_KERNEL);

Not sure I understand the output, but perhaps here the BITS_TO_BYTES()
should be used.

-- 
With Best Regards,
Andy Shevchenko
