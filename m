Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3305A87C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiHaU4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiHaU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:56:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5DD2E86;
        Wed, 31 Aug 2022 13:56:26 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id f9so8367026qvw.11;
        Wed, 31 Aug 2022 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j8UxbtDew574grRc59F86ZudDhnKYJ7sEvH/yI7OmEs=;
        b=pLlZHUsafseS+eCvZzo2JMww4kXTSN5Q009GbouFmh6rphSQFQvi1GE/RwHfiTJKMd
         9migLuUKejEVPejkRaYRfP7/BIf5BciS+SYPx0hw2ASIXdnkmETO1wOs6NEhfl9bLOuB
         CtPa7JYith5/ZdRSaQvBadQYpYozjdj30GtuP9HRhzxeOodxfE83lEYOPIZlhbySw81C
         VW3tujh7TS6fEfmWuSENg9LnaCvMgwotDGbZ2iCUXXhPWsDXE4taQvChbTf6e9jmeunl
         CODvVln7wyQeAhYIKqsBZkpYHMGw5v/LftrW3ugq9j6T8npLQqqiDIKD1GBLhdqttybf
         tHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j8UxbtDew574grRc59F86ZudDhnKYJ7sEvH/yI7OmEs=;
        b=J/s9NmfiPYexWNaRGdMB6wvegF9yIrt47YwlxTHlPsAqwCmingqq68X5L5ut1Wl7vg
         RjKknk86dMn+xtgsrjHuKrmvqoUBpR9sj8lKjPI55pdWV4WYsbjPqHvjORDAddB8ubwG
         RbgzKe2kCASW9MpshwRPfSDAuzPOowCJcQFDwufXpY73/KaFuByhDPuf8F3YR5bHWLOV
         /9ZGSmK5lCVnCxuB5+tHESXgXWKI7fgTYCJ6AB46O2tMo2R6akejFDbMKLcXTiPp0k6q
         EOOJQFkmgr8YwmmMUyk6w6ZQUU4XiAkIa7NVsCnDMoDzLDklef5RAHY3PLSVxYhEm3wz
         KeJA==
X-Gm-Message-State: ACgBeo2qZxxzyg36f0jw0TGapbxWxh7JF5E8K3pXguyUED4LSJeYv0pL
        C/W8VY9P9LZMfJGBG8qVcb/I+aWrRcN/X9E9pMW/Ffa+J7k=
X-Google-Smtp-Source: AA6agR5Rx6JL/d53spayx5rkbH9OCbX4qUggQsXoOMq2Dsh8M4BdCXMWYm+Rx90QyjJ89vPJycmpDbRH1YmFQb8xBuo=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr12263042qvb.82.1661979385373; Wed, 31
 Aug 2022 13:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133923.1114555-1-martyn.welch@collabora.com> <20220829133923.1114555-4-martyn.welch@collabora.com>
In-Reply-To: <20220829133923.1114555-4-martyn.welch@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 23:55:49 +0300
Message-ID: <CAHp75VcXR9=5WwZqe=juLBDT1CZnYfWHCGDb4Tp211sL2AA_Gw@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpio: pca953x: Swap if statements to save later complexity
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

On Mon, Aug 29, 2022 at 4:43 PM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> A later patch in the series adds support for a further chip type that
> shares some similarity with the PCA953X_TYPE. In order to keep the logic
> simple,

If you say so...
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> swap over the if and else portions where checks are made against
> PCA953X_TYPE and instead check for PCA957X_TYPE.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 41e7ff83a735..19a8eb94a629 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -293,13 +293,13 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
>         struct pca953x_chip *chip = dev_get_drvdata(dev);
>         u32 bank;
>
> -       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> -               bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
> -                      PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> -       } else {
> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
>                 bank = PCA957x_BANK_INPUT | PCA957x_BANK_OUTPUT |
>                        PCA957x_BANK_POLARITY | PCA957x_BANK_CONFIG |
>                        PCA957x_BANK_BUSHOLD;
> +       } else {
> +               bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
> +                      PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
>         }
>
>         if (chip->driver_data & PCA_PCAL) {
> @@ -316,12 +316,12 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
>         struct pca953x_chip *chip = dev_get_drvdata(dev);
>         u32 bank;
>
> -       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> -               bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
> -                       PCA953x_BANK_CONFIG;
> -       } else {
> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
>                 bank = PCA957x_BANK_OUTPUT | PCA957x_BANK_POLARITY |
>                         PCA957x_BANK_CONFIG | PCA957x_BANK_BUSHOLD;
> +       } else {
> +               bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
> +                       PCA953x_BANK_CONFIG;
>         }
>
>         if (chip->driver_data & PCA_PCAL)
> @@ -336,10 +336,10 @@ static bool pca953x_volatile_register(struct device *dev, unsigned int reg)
>         struct pca953x_chip *chip = dev_get_drvdata(dev);
>         u32 bank;
>
> -       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE)
> -               bank = PCA953x_BANK_INPUT;
> -       else
> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE)
>                 bank = PCA957x_BANK_INPUT;
> +       else
> +               bank = PCA953x_BANK_INPUT;
>
>         if (chip->driver_data & PCA_PCAL)
>                 bank |= PCAL9xxx_BANK_IRQ_STAT;
> @@ -1069,13 +1069,12 @@ static int pca953x_probe(struct i2c_client *client,
>         /* initialize cached registers from their original values.
>          * we can't share this chip with another i2c master.
>          */
> -
> -       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> -               chip->regs = &pca953x_regs;
> -               ret = device_pca95xx_init(chip, invert);
> -       } else {
> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA957X_TYPE) {
>                 chip->regs = &pca957x_regs;
>                 ret = device_pca957x_init(chip, invert);
> +       } else {
> +               chip->regs = &pca953x_regs;
> +               ret = device_pca95xx_init(chip, invert);
>         }
>         if (ret)
>                 goto err_exit;
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
