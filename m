Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16D4578CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiGRVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiGRVcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:32:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A74431DE3;
        Mon, 18 Jul 2022 14:32:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so3661718edd.9;
        Mon, 18 Jul 2022 14:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZkDfDNbFMdK5ahboEdA9lOTIKE9tZIP2dVStYZIlZk=;
        b=IReFK6sSfSt/KnqfJOvKAq9nwFRsAtyRlfh7HSB4zsSFUtv4+lGKnGhm3ahufxTGr1
         bHw73MThrzP59sXlr/MeZqT5wnE/OkeKb9CuJXKMo/U04xutLWSArz1CAIG5w+/SQocJ
         PCjs1+5T0J6seKUIkD3gxgMTmrZDIRSQG4Fg7+TFApptGpAlZTjWsBRO+1cZ/f3B7C3/
         7zpNcWNGr8ly5+8ahx9Wy6AnZVIAK0CaEBqt6TIAJ7Ttc5A3UogdziimGgjLUpP78kQs
         sbrN1DJrHiPStug+p3UCmPkoyoBwcad9vTvs5feKTMJhEgYpVMEHAeU2yInpEzm//VIQ
         VT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZkDfDNbFMdK5ahboEdA9lOTIKE9tZIP2dVStYZIlZk=;
        b=yQ6IFTMp5mOBv7MrDCmtykuXnQ+ggocvArXzqaEdvPVx1BUpVq525DvX04RG+FFPHG
         rzlhNMDp+Zw+9VCUdVmL4YSJce5B5knRKfGt3SN7nRQse8L6qXOK45nVqya+G2xFsYF4
         2Ho59JwEbtzq7ZJC0MICIMQxu3AXAMxprBB0KEKsCF1jNAC3ssD6ksDI2qfswUpIGPKI
         t5+T6o+wNEGnz0CvcJX/nB2PqaveXZb6wnWODWCTj0Nm/Pb6MY7lb4zfAU4gZXzDYNrX
         9rtOQnpZa53FTqfqq9x3Gnh9VDCZl0rnQUQHtsP9HGXnMrVc2e1ciLbdptStQSoDDnpU
         DgOA==
X-Gm-Message-State: AJIora9DHX/RPXEYB5i5EsEpCjh+uvKeYoDNasSrgQ7coST0cqO+nRIV
        vK2zKpUXvcSmrt3YJfeJXccfqxkiQ97TEolmtA6ZU9EdCD/hYA==
X-Google-Smtp-Source: AGRyM1vZb2rDb+9iuNv2MQVOYd355haW+MpGrVtge67yoRFR8/7nimITKfX+LvrOp+C/e92ONLA+XMKARktsEO6wv1w=
X-Received: by 2002:a05:6402:1658:b0:43a:91cd:2ffb with SMTP id
 s24-20020a056402165800b0043a91cd2ffbmr38458308edx.277.1658179940991; Mon, 18
 Jul 2022 14:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657907849.git.william.gray@linaro.org> <e0f9ff79a4229cf0ccce4844745453dae633a1aa.1657907849.git.william.gray@linaro.org>
In-Reply-To: <e0f9ff79a4229cf0ccce4844745453dae633a1aa.1657907849.git.william.gray@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 23:31:44 +0200
Message-ID: <CAHp75VeQkpr9Ww-C+1w13BiLSuCY=FMMtjjAdVCq0a5z1bkSVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] gpio: i8255: Introduce the Intel 8255 interface
 library module
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:56 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Exposes consumer library functions providing support for interfaces
> compatible with the venerable Intel 8255 Programmable Peripheral
> Interface (PPI).
>
> The Intel 8255 PPI first appeared in the early 1970s, initially for the
> Intel 8080 and later appearing in the original IBM-PC. The popularity of
> the original Intel 8255 chip led to many subsequent variants and clones
> of the interface in various chips and integrated circuits. Although
> still popular, interfaces compatible with the Intel 8255 PPI are
> nowdays typically found embedded in larger VLSI processing chips and
> FPGA components rather than as discrete ICs.
>
> A CONFIG_GPIO_I8255 Kconfig option is introduced by this patch. Modules
> wanting access to these i8255 library functions should select this
> Kconfig option, and import the I8255 symbol namespace.

Thanks for an update, my comments below.

...

> +config GPIO_I8255
> +       tristate
> +       help
> +         Enables support for the i8255 interface library functions. The i8255
> +         interface library provides functions to facilitate communication with
> +         interfaces compatible with the venerable Intel 8255 Programmable
> +         Peripheral Interface (PPI). The Intel 8255 PPI chip was first released
> +         in the early 1970s but compatible interfaces are nowadays typically
> +         found embedded in larger VLSI processing chips and FPGA components.

+ "If built as a module its name will be ..." or similar sentence
would be good to add.

...

> +       case I8255_PORTC:
> +               /* Port C can be configured by nibble */
> +               if (port_offset > 3)

More naturally looks >= 4 to show the beginning offset number for the UPPER.

> +                       return I8255_CONTROL_PORTC_UPPER_DIRECTION;
> +               return I8255_CONTROL_PORTC_LOWER_DIRECTION;

...

> +       out_state = ioread8(&ppi[group].port[ppi_port]);
> +       out_state &= ~io_mask;
> +       out_state |= bit_mask;

Usual pattern is

  out_state = (out_state & ~mask) | (bits & mask);

(and we call them mask and value or bits)

> +

No need for this blank line.

> +       iowrite8(out_state, &ppi[group].port[ppi_port]);

...

> +               bit_mask = bitmap_get_value8(bits, offset) & gpio_mask;
> +               io_port = offset / 8;

Exactly why I recommended reconsidering the above pattern, you won't
need to do ' & mask' in the caller(s).

> +               i8255_set_port(ppi, state, io_port, gpio_mask, bit_mask);

...

> + * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
> + * group for use in i8255 library functions.

I'm not sure about terminology. What's 'group'? We have a very well
established term 'bank' isn't it what you meant here by 'group'?

...

> +int i8255_get(const struct i8255 __iomem *ppi, unsigned long offset);

I'm not sure what const with __iomem gives us? The purpose of that is?.
And if it's about the content of the register, then const is a lie.

Ditto for the rest of the similar cases.


-- 
With Best Regards,
Andy Shevchenko
