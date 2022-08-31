Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779375A87D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHaVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiHaVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:02:55 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E001EA309;
        Wed, 31 Aug 2022 14:02:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a15so11830877qko.4;
        Wed, 31 Aug 2022 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6xlRlzGJaVR2uzullj0MIDzmAYPuB68YjTQcaZFNI8g=;
        b=lbaU/geU/NRB9KRdtjqIdxJ8HmOiSVcT5hPwQvCxbstjnnaab4inNB0ZkXx8WBZtsq
         HXzoklo6Z/1ZRC3VuyXorjDZ7FHbhWS3DszT23X6t2sR6fyCW7Uk9KcIMWjWxAJYsQqV
         gT4pWaeDolhkDVsiwXRvVexP+zvf76/17vh9jFFKJC8qDy73bOFxHDLWQOJlx9YhlUSQ
         /tr8rDXdBQ1K3N6dy4uisYMhoSRJEjdzlOTADsuhIXlQi3sdQsw0KRx50FYD36JX0rTc
         Yg+69eiRxhkwS+AfwWJIrYXbrgS9YFybSk7HcWYdQ8CjA3RM/+uLi8Jkad9YCQS1ZvqV
         aNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6xlRlzGJaVR2uzullj0MIDzmAYPuB68YjTQcaZFNI8g=;
        b=dGmPHUcjYew5NDI9vWG3ZD4smw2uVoK6yyXJejaz5m+x3cIG6NKjnTA4SGmErP5kkH
         9DiFMzFmk39o9W7Cen+4o2EPl03LHdH17mTVAh80rxQKZf9nJeCaX3otkwjAit9fjrpg
         dAYMHMhnLcqnZMFjUevRiCcq+q50sgDJakdFmiJ+RBUYwHAGVBPRltMrOfkcW+4DiD0I
         tpYx8lRQH4Lu9yD/virmvqSvJ8V2V+sNMkk0mM4a6CzOnVwiQP8Q8kFGSgg84Q0EnlhU
         niuI564hTRdub1pqSm8zUSPbLHgqTHkpUrRrRwEAnCjeDNLmQVDNSi455E/XFvR0556J
         +Cmg==
X-Gm-Message-State: ACgBeo0aBeAHHypqFIwUJu/9C0u/GlspiUQ/EHbVQwFhRfhlUj9rvmXk
        kcgQ8IRlfKqzZBcvIa40Khuy1fE0gs8fww9MV2k=
X-Google-Smtp-Source: AA6agR48wNqQfz2J4gpLSBsgA5I6SjIy5C7Yw8njxQJfNsfYsmiIEotjBn6HUedNHJOt4T00J8rlLV86PaeYl2utDfU=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr17219247qkf.320.1661979774149; Wed, 31
 Aug 2022 14:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133923.1114555-1-martyn.welch@collabora.com> <20220829133923.1114555-5-martyn.welch@collabora.com>
In-Reply-To: <20220829133923.1114555-5-martyn.welch@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 00:02:18 +0300
Message-ID: <CAHp75VfZmmDGJJ5wxM8-pbqo+npOSZrPtyJnQhuGadLUYod=3A@mail.gmail.com>
Subject: Re: [PATCH 5/5] gpio: pca953x: Add support for PCAL6534 and compatible
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

On Mon, Aug 29, 2022 at 4:52 PM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> Add support for the NXP PCAL6534 and Diodes Inc. PI4IOE5V6534Q. These
> devices, which have identical register layouts and features, are broadly a
> 34-bit version of the PCAL6524.
>
> However, whilst the registers are broadly what you'd expect for a 34-bit
> version of the PCAL6524, the spacing of the registers has been
> compacted. This has the unfortunate effect of breaking the bit shift
> based mechanism that is employed to work out register locations used by
> the other chips supported by this driver, resulting in special handling
> needing to be introduced in pca953x_recalc_addr() and
> pca953x_check_register().

This still needs an alternative deep review. I'll do my best to get
into it sooner than later.

...

>  #define PCA953X_TYPE           BIT(12)
>  #define PCA957X_TYPE           BIT(13)
> +#define PCAL653X_TYPE          BIT(14)
>  #define PCA_TYPE_MASK          GENMASK(15, 12)
>
> +

Stray change.

>  #define PCA_CHIP_TYPE(x)       ((x) & PCA_TYPE_MASK)

...

>  static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
>                                    u32 checkbank)
>  {
> -       int bank_shift = pca953x_bank_shift(chip);
> -       int bank = (reg & REG_ADDR_MASK) >> bank_shift;
> -       int offset = reg & (BIT(bank_shift) - 1);
> +       int bank;
> +       int offset;
> +
> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCAL653X_TYPE) {
> +               if (reg > 0x2f) {
> +                       /*
> +                        * Reserved block between 14h and 2Fh does not align on
> +                        * expected bank boundaries like other devices.
> +                        */
> +                       int temp = reg - 0x30;
> +
> +                       bank = temp / NBANK(chip);
> +                       offset = temp - (bank * NBANK(chip));
> +                       bank += 8;
> +               } else if (reg > 0x53) {
> +                       /* Handle lack of reserved registers after output port
> +                        * configuration register to form a bank.
> +                        */
> +                       int temp = reg - 0x54;
> +
> +                       bank = temp / NBANK(chip);
> +                       offset = temp - (bank * NBANK(chip));
> +                       bank += 16;

Can we rather put this into a separate function?

> +               } else {
> +                       bank = reg / NBANK(chip);
> +                       offset = reg - (bank * NBANK(chip));
> +               }
> +       } else {
> +               int bank_shift = pca953x_bank_shift(chip);
>
> -       /* Special PCAL extended register check. */
> -       if (reg & REG_ADDR_EXT) {
> -               if (!(chip->driver_data & PCA_PCAL))
> -                       return false;
> -               bank += 8;
> +               bank = (reg & REG_ADDR_MASK) >> bank_shift;
> +               offset = reg & (BIT(bank_shift) - 1);
> +
> +               /* Special PCAL extended register check. */
> +               if (reg & REG_ADDR_EXT) {
> +                       if (!(chip->driver_data & PCA_PCAL))
> +                               return false;
> +                       bank += 8;
> +               }
>         }

All the same, split this to be like

if (current)
 do_current_things
else
 do_new_type

...

>  static u8 pca953x_recalc_addr(struct pca953x_chip *chip, int reg, int off)
>  {
> -       int bank_shift = pca953x_bank_shift(chip);
> -       int addr = (reg & PCAL_GPIO_MASK) << bank_shift;
> -       int pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
> -       u8 regaddr = pinctrl | addr | (off / BANK_SZ);
> +       int addr;
> +       int pinctrl;
> +       u8 regaddr;
> +
> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCAL653X_TYPE) {
> +               /* The PCAL6534 and compatible chips have altered bank alignment that doesn't
> +                * fit within the bit shifting scheme used for other devices.
> +                */
> +               addr = (reg & PCAL_GPIO_MASK) * NBANK(chip);
> +
> +               switch (reg) {
> +               case PCAL953X_OUT_STRENGTH:
> +               case PCAL953X_IN_LATCH:
> +               case PCAL953X_PULL_EN:
> +               case PCAL953X_PULL_SEL:
> +               case PCAL953X_INT_MASK:
> +               case PCAL953X_INT_STAT:
> +               case PCAL953X_OUT_CONF:
> +                       pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x20;
> +                       break;
> +               case PCAL6524_INT_EDGE:
> +               case PCAL6524_INT_CLR:
> +               case PCAL6524_IN_STATUS:
> +               case PCAL6524_OUT_INDCONF:
> +               case PCAL6524_DEBOUNCE:
> +                       pinctrl = ((reg & PCAL_PINCTRL_MASK) >> 1) + 0x1c;
> +                       break;
> +               }
> +               regaddr = pinctrl + addr + (off / BANK_SZ);
> +       } else {
> +               int bank_shift = pca953x_bank_shift(chip);
> +
> +               addr = (reg & PCAL_GPIO_MASK) << bank_shift;
> +               pinctrl = (reg & PCAL_PINCTRL_MASK) << 1;
> +               regaddr = pinctrl | addr | (off / BANK_SZ);
> +       }

Looking at all these, why not add the callbacks for recalc_addr and
check_reg and assign them in the ->probe()?

-- 
With Best Regards,
Andy Shevchenko
