Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1195AA7FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiIBGTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiIBGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:19:27 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8935BA9C8;
        Thu,  1 Sep 2022 23:19:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h22so801304qtu.2;
        Thu, 01 Sep 2022 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=teNUz3kE/iVr5AXZEgSAXushnxnx4M+dpFq4VeWhlU4=;
        b=MURmxpWcPeekH0WADesQuPYvZjlRo7gkj0KrERUmpREShqoENfkSq2Nnv8sKsyMxBY
         MJIwDay9YqOdRjewSxI/LTtTEJmyxT6YrOBYLOFJLWIPBa4GW8MLoxLhRv/HhiUOXYNu
         WG7naMASL4r7qbO/i+j4OJvZnxyXJb2hGPhQZB5Xuh8+nE6AjEB2CeTdr64NMDyn4WqH
         VXF5rvH0Bln7pUaXn/A12yRYI7WkQSHNRyPdo0rtFr1Quf5bPgFTHbuWDothlzxN5JX8
         Rbyr10FNvY3U7c0Ah/rhvn/o47qTczvlKdFUyZvbnQNySIoNJBFTIH8ThfliOJQf6ysN
         Z48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=teNUz3kE/iVr5AXZEgSAXushnxnx4M+dpFq4VeWhlU4=;
        b=iPcbapGctOtz4zrufnpMtpRYmRDxvogbZqkLPLgDIwGAR+oQ5DlLWupLAtZUxhDihg
         8UnJraloLlYRm93dYHC/ZbjF1igSrbFlIJ8RUBSIoJ2pVDqcgyypvy8F50C9bkmHXLRV
         zkl5sMcqABGwuhGPu8MboLMQJhxiYohBOY+kcMJHoQE47NKqh+ZYijpe0nm0e83hkyON
         34dS8JkxVWvhuRY596eabllfG2hV1UVbcIO+Dfgkd73B/asxJ7dhwXiC28gEc63qL2XB
         L41cx7A0r9jG9Ak5qUrGA+JvVueu+eVqTEvtCIMyFR5gE6448NwJxdy2/24XW5wxQ4As
         MO6w==
X-Gm-Message-State: ACgBeo2xcqTzlo5xz2bei0FquKPXDesE8s+KcR6Orhhdosny7bFOI6lR
        mHcqeqgzkBH3O8AvgVK5SKOR7riZ9r9+Y9YzH6OlZNZFUrk=
X-Google-Smtp-Source: AA6agR6dkcDOoEWyMWVbvkRny4k1BPnLjrDjMIcvtq7fTklwPYadAnB7Zkfgr1rto1Gg69/Hnx6DWFMDcOn9coQityg=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr26737813qta.429.1662099565842; Thu, 01
 Sep 2022 23:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220902061434.46995-1-qingtao.cao@digi.com>
In-Reply-To: <20220902061434.46995-1-qingtao.cao@digi.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 09:18:49 +0300
Message-ID: <CAHp75Ve3xwRKKtszHZ4B72aMA_tq0LeHuM0XOkaYE6osSvDdJQ@mail.gmail.com>
Subject: Re: [v3 PATCH 1/1] gpio: exar: access MPIO registers on cascaded chips
To:     Qingtao Cao <qingtao.cao.au@gmail.com>
Cc:     Qingtao Cao <qingtao.cao@digi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Fri, Sep 2, 2022 at 9:15 AM Qingtao Cao <qingtao.cao.au@gmail.com> wrote:
>
> When EXAR xr17v35x chips are cascaded in order to access the MPIO registers
> (part of the Device Configuration Registers) of the secondary chips, an offset
> needs to be applied based on the number of primary chip's UART channels.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
> ---
>  drivers/gpio/gpio-exar.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index d37de78247a6..482f678c893e 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -21,6 +21,12 @@
>  #define EXAR_OFFSET_MPIOLVL_HI 0x96
>  #define EXAR_OFFSET_MPIOSEL_HI 0x99
>
> +/*
> + * The Device Configuration and UART Configuration Registers
> + * for each UART channel take 1KB of memory address space.
> + */
> +#define EXAR_UART_CHANNEL_SIZE 0x400
> +
>  #define DRIVER_NAME "gpio_exar"
>
>  static DEFINE_IDA(ida_index);
> @@ -31,26 +37,39 @@ struct exar_gpio_chip {
>         int index;
>         char name[20];
>         unsigned int first_pin;
> +       /*
> +        * The offset to the cascaded device's (if existing)
> +        * Device Configuration Registers.
> +        */
> +       unsigned int cascaded_offset;
>  };
>
>  static unsigned int
>  exar_offset_to_sel_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>  {
> -       return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOSEL_HI
> -                                                  : EXAR_OFFSET_MPIOSEL_LO;
> +       unsigned int pin = exar_gpio->first_pin + (offset % 16);
> +       unsigned int cascaded = offset / 16;
> +       unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
> +
> +       return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
>  }
>
>  static unsigned int
>  exar_offset_to_lvl_addr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>  {
> -       return (offset + exar_gpio->first_pin) / 8 ? EXAR_OFFSET_MPIOLVL_HI
> -                                                  : EXAR_OFFSET_MPIOLVL_LO;
> +       unsigned int pin = exar_gpio->first_pin + (offset % 16);
> +       unsigned int cascaded = offset / 16;
> +       unsigned int addr = pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
> +
> +       return addr + (cascaded ? exar_gpio->cascaded_offset : 0);
>  }
>
>  static unsigned int
>  exar_offset_to_bit(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>  {
> -       return (offset + exar_gpio->first_pin) % 8;
> +       unsigned int pin = exar_gpio->first_pin + (offset % 16);
> +
> +       return pin % 8;
>  }
>
>  static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
> @@ -153,6 +172,17 @@ static int gpio_exar_probe(struct platform_device *pdev)
>         if (!exar_gpio)
>                 return -ENOMEM;
>
> +       /*
> +        * If cascaded, secondary xr17v354 or xr17v358 have the same amount
> +        * of MPIOs as their primaries and the last 4 bits of the primary's
> +        * PCI Device ID is the number of its UART channels.
> +        */
> +       if (pcidev->device & GENMASK(15, 12)) {
> +               ngpios += ngpios;
> +               exar_gpio->cascaded_offset = (pcidev->device & GENMASK(3, 0)) *
> +                               EXAR_UART_CHANNEL_SIZE;
> +       }
> +
>         /*
>          * We don't need to check the return values of mmio regmap operations (unless
>          * the regmap has a clock attached which is not the case here).
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
