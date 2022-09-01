Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6723D5A9F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiIATEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiIATE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:04:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6495F991;
        Thu,  1 Sep 2022 12:04:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j6so44424qkl.10;
        Thu, 01 Sep 2022 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=W/qFFOOAdXUcatsqWYCMrmRU7POJYRljMGuVofmOMck=;
        b=hkW+zBJPReWeLUB3DZtFBgm6zHDihFOEvnFqil+PeSGlnM2//BuVoLToJapTiC7G/t
         qKErgmXdNqbsjaETG1oLE8jDMKA0kkJDFsesCFci6pxnYteU1A00bG0zV7FD6l/s6ZRn
         My67PuzXtJVCgNQBDzrFI+1l6TabVFjDiFh6MndvGe9sQc7a7UCuH1xlDwjEwrQkfHCd
         sWDpDfjMUMmQUZ9ywzhPcbVEizuhQgYHboo0UDteT7HXEYhcJCkDOenaNamvjBdz3ByE
         ObBDTk4fSzp5xkU99HMyTa3binfrAC0uB8XhAvIoQ60lek1zr9FW+PAIceyh8iPd+C9U
         ToCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=W/qFFOOAdXUcatsqWYCMrmRU7POJYRljMGuVofmOMck=;
        b=WeZ+UH57uSJapeI0jjaB9Da3JH3o5CvJFRughPxnRqwu6QhMDhbPT50ybVBgFd2xzj
         89mLikLU474A2rKY24yuBsUHpjJ+xShrcsWbfFcTtif1S2+pw5kIUv9m5iCg9ItySO3v
         +yXj8MOgxxW8335oEtXavBHgCDNWVXgCKaHovC7AmA3RwRx3mdQhFXZ9NZKDKC68S0Zd
         I1eMqTxG6h1PY0aRtsTInw0GEMu0ILwf7pseKZHv2qlVerT3Mv38jWjtgen/eW6f+YRH
         q3qctZHosOi+0bNz+3C82H6WuOtmq4nTkzPiv+juLIY7Uu0nHO19uBpmHyk1D4R1DUOQ
         lC5Q==
X-Gm-Message-State: ACgBeo2dNhoEGEcMxQ/o55KU0bFOUzK5BjuopOBq38u9FqPVMuF5110c
        2x7J4qYaqtmcKIsxzkIfxNA1ItOGjTbnqwZ5rdIGCq7Q/hwDlQ==
X-Google-Smtp-Source: AA6agR4WH37VH8nTA6WfWnnPnxk2D7IFWLwSOev+koVtMfhDbxoJpV8t9O5yUTzQCNy8XJxz2zTJ7rS8l6t76oVHZvQ=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr20760737qkf.320.1662059067344; Thu, 01
 Sep 2022 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220901092922.1024311-1-qingtao.cao.au@gmail.com>
In-Reply-To: <20220901092922.1024311-1-qingtao.cao.au@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 22:03:51 +0300
Message-ID: <CAHp75Vc9LiO=YMNHgq=M2vqvqS7sL_4C89E7wPzbF6TyLtmOVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: exar: access MPIO registers on slave chips
To:     Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     nathan@nathanrossi.com, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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

On Thu, Sep 1, 2022 at 12:41 PM Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
>
> When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
> (part of the Device Configuration Registers) of the slave chips, an offset
> needs to be applied based on the number of master chip's UART channels.

...

>  #define EXAR_OFFSET_MPIOSEL_LO 0x93
>  #define EXAR_OFFSET_MPIOLVL_HI 0x96
>  #define EXAR_OFFSET_MPIOSEL_HI 0x99

+ Blank line.

> +#define EXAR_UART_CHANNEL_SIZE 0x400

Add a comment explaining what this does include, etc.

...

> +       /*
> +        * The offset to the slave device's (if existing)
> +        * Device Configuration Registers

Always finish multi-line comments with a period. Applies to other
comments in this patch.

> +        */

...

>  {
> -       return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
> -                                                  : EXAR_OFFSET_MPIOSEL_LO;
> +       int addr;
> +
> +       addr = (offset % 16 + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
> +                                                       : EXAR_OFFSET_MPIOSEL_LO;
> +       return offset / 16 ? addr + exar_gpio->slave_offset : addr;

Can we rather have something like

  unsigned int pin = exar->first_pin + (offset % 16);
  unsigned int slave = offset / 16;

  addr = pin / 8 ? ...;
  return addr + (slave ? ... : 0);

?

>  }
>
>  static unsigned int
>  exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>  {
> -       return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
> -                                                  : EXAR_OFFSET_MPIOLVL_LO;
> +       int addr;
> +
> +       addr = (offset % 16 + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
> +                                                       : EXAR_OFFSET_MPIOLVL_LO;
> +       return offset / 16 ? addr + exar_gpio->slave_offset : addr;

In the similar way as above.

>  }

...

> +       if (pcidev->device & 0xf000) {

GENMASK()

> +               /*
> +                * xr17v354 or xr17v358 slaves have the same amount of
> +                * MPIOs as the master
> +                */
> +               ngpios += ngpios;
> +
> +               /*
> +                * The last 4 bits of the master's PCI Device ID is
> +                * the number of its UART channels
> +                */
> +               exar_gpio->slave_offset = (pcidev->device & 0xf) *

GENMASK()

> +                               EXAR_UART_CHANNEL_SIZE;
> +       }

-- 
With Best Regards,
Andy Shevchenko
