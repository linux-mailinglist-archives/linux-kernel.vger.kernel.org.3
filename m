Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74959A8A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiHSWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiHSWgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:36:09 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05276108F2C;
        Fri, 19 Aug 2022 15:36:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c5so3925440qvt.11;
        Fri, 19 Aug 2022 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CkFwGVS+iZtjjWhatTiC+PU/jH4Z9OYH0mbmFaJAdxw=;
        b=ZEDtAzSC5rjUJ4xO1kldzDeKrD8LB6kTnvz+NWUSCL0EOdIcNzC5pP58IDuGcjnusr
         LH9rBV5JrTeWKB871ZQI998kFFa+FYvZwt6LvfcEYryh77wY5bRZFRURJa/zhOhwkoX+
         1AKJ+kkcAR3fjgoCh2FjT12+HxCrzc55JY9Ikl8Hc+J48I4PL+PckEmeuTSxPJ4b/ms3
         7KqcVeexJ7av3UOHa45yAOVQ6iZH64lMWHbXbJIny0ksuYzf6CRg9VbBc6tqJfbt+jbK
         0CBQ8bRPtc6eeCSbBBr0WV3L64c2Rx+jlnRZswDd/o6fIz9kDTkW4DIs1HOVEw1V7LIl
         cGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CkFwGVS+iZtjjWhatTiC+PU/jH4Z9OYH0mbmFaJAdxw=;
        b=jUFBxjBnYEcdClkvLiyJRrXfWWhLGyG0xuvWjX333IzDkR2gn/EQIMxJQYp08cmq4V
         RxY7j7xvAOu+0d8xzORc38gIjLrye3GuGFcHnfzU3VbYXmCPtwjeKTCBYMCX6DfPKOd1
         VsgghaK9S/IDscLlVRnIlvjbflThziMVHg0uKGjjSYgCAS5KVOfh3+9Wu5gpnP6a73JP
         L3zeorUX5Q3QgfR83Mx7jaPLjv2RzmulwxgBkUuH17MrsSeS99yxpTq677W3SWnBNlvZ
         CJURO+3cEA2P1OB3rljzNiXM4wIoslxaCS4oCZGNqYf/u0ympDKJEI74fBvUqS//bfTe
         V+TQ==
X-Gm-Message-State: ACgBeo1mL9UlbBceJ2vssgWQKDhezif342bdvEF0ueUoknwdPwcmhgeq
        vBBUBi07m/ImlfXfHFxU+KEARShqQWx91a0nT0o=
X-Google-Smtp-Source: AA6agR70czD0zMoPeeBaIzPj/ZMpu6Ob/a+wDrwNE/UgM1osO+LATzllvepdWSvN4SKW0iJgctHFG1Yukq83hWP9ac8=
X-Received: by 2002:a05:6214:d07:b0:476:c32f:f4f4 with SMTP id
 7-20020a0562140d0700b00476c32ff4f4mr8157961qvh.11.1660948566951; Fri, 19 Aug
 2022 15:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220817112818.787771-1-martyn.welch@collabora.com>
In-Reply-To: <20220817112818.787771-1-martyn.welch@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 01:35:30 +0300
Message-ID: <CAHp75Vc1bnUGt66LYRAVuJP+OnhLTaU=AN1JdvfiH44O9_eO8g@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: pca953x: Support for pcal6534
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Wed, Aug 17, 2022 at 2:29 PM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> The pcal6534[1] is a 34-bit I/O expander with more than a passing
> resemblance to the pcal6524[2] currently supported by the gpio-pca953x
> driver, however whilst the registers seem to functionally match
> perfectly, the alignment of the register banks in the chips address
> space do not follow the pattern expected by the existing driver. For

does not

> instance, as the chip provides 34 I/O, which requires bannks of 5 8-bit
> registers to provide input state, output state, etc. as do the 40 I/O
> variants, however the 40 I/O variants layout the banks of registers on
> 8-byte boundaries, whilst the pcal6534 does not space out the banks at
> all. Additionally the extended functionality starts at 30h rather than
> 40h and I suspect there will be other similar differences that I've not
> yet discovered.

The below shouldn't be in the commit message, but rather in the
comments (after the cutter '---' line below). And due to these two
paragraphs I consider this as an RFC (and it is luckily marked like
this), so, Bart, please do not apply this, we need more eyes and
datasheet reading before going on this.

> I suspect that this may add some additional complexity to the driver and
> I'm not sure whether this will be welcome. I've done a few cursory
> searches to see if there are other chips which follow the pattern of the
> pcal6534 and have so far only found the pi4ioe5v6534q[3], which appears
> to be funcitonaly identical to the pcal6534.
>
> I'm currently wondering whether a submission to extend the pcal6534
> is likely to be deemed acceptable. If so whether something like the

so, whether

> attached approach would be OK, or whether anyone has better ideas on how
> to achieve this. Alternatively I'd be happy to create a new driver to
> support the pcal6534 if that's deemed more appropriate.

> [1] https://www.nxp.com/docs/en/data-sheet/PCAL6534.pdf
> [2] https://www.nxp.com/docs/en/data-sheet/PCAL6524.pdf
> [3] https://www.diodes.com/assets/Datasheets/PI4IOE5V6534Q.pdf

Convert these to Datasheet: tags.

...

>  #define PCA957X_TYPE           BIT(13)
>  #define PCA_TYPE_MASK          GENMASK(15, 12)
>
> +#define PCAL6534_ALIGN         BIT(16)

I believe it should be a chip TYPE.

...

>         { "xra1202", 8  | PCA953X_TYPE },

> +       { "pi4ioe5v6534q", 34 | PCA953X_TYPE | PCA_LATCH_INT | PCAL6534_ALIGN, },

What's this and why is it not ordered?

...

> -       int bank_shift = pca953x_bank_shift(chip);
> -       int bank = (reg & REG_ADDR_MASK) >> bank_shift;
> -       int offset = reg & (BIT(bank_shift) - 1);
> +       int bank;
> +       int offset;
> +
> +       if (chip->driver_data & PCAL6534_ALIGN) {
> +               bank = (reg & REG_ADDR_MASK) / NBANK(chip);
> +               offset = reg - (bank * NBANK(chip));
> +       } else {
> +               int bank_shift = pca953x_bank_shift(chip);
> +               bank = (reg & REG_ADDR_MASK) >> bank_shift;
> +               offset = reg & (BIT(bank_shift) - 1);
> +       }

I'm wondering if it can be moved to bank_shift()  and possibly a new
helper to get an offset.

...

> +       for (i = 0; i < NBANK(chip); i++) {
>                 value[i] = bitmap_get_value8(val, i * BANK_SZ);
> +               dev_err(&chip->client->dev, "value[%d] = %x\n", i, value[i]);
> +       }
> +       dev_err(&chip->client->dev, "regaddr: %x\n", regaddr);

dev_err() ?!

...

> +       { .compatible = "diodes,pi4ioe5v6534q", .data = OF_953X(34, PCA_LATCH_INT | PCAL6534_ALIGN), },

As per above.

-- 
With Best Regards,
Andy Shevchenko
