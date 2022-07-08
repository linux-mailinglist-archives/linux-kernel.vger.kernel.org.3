Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7856BDB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbiGHQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiGHQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:00:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE2B74DC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:00:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sb34so38384041ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vH2XQoTEe8OmOYM6NlCKN6TrQ8aYH1k0wjJIrOlK3o=;
        b=T+QAWynVUuJF6w5v2g8s7C/cm2YlSUdUiidVeHMs+uS1/GBqyLEuZ68VhqhjBYnYxv
         GV8qKJ25PfOZmGyStEXhKA5XUoZCn+P7ZvjihpcZEPT+Hh0cMH7t55RXEduUewi7mtpM
         e1SOYnoLXVQ7VRcFkp1icR5xWRK7z37gjaUlgm0iuKPTLV/uUBktAUrbzgVsyj83mrZu
         LJ7yQzwgyjJO7iTWSM6C9uydfiDYfOPRM4kH3JNKlQZXL28/Ci/F3ntUP/SVZP9Wx8Ly
         +5xhSiM1GAwRg09e1HDmZgaJBU7Q7iBYLzcHPbDf5PHREYPDQ6SffHJS3QUv2XxAX31O
         8w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vH2XQoTEe8OmOYM6NlCKN6TrQ8aYH1k0wjJIrOlK3o=;
        b=lknEhRWqGe3eHVU4XulB7RwWFgs622q0RlHk89agAfnhx95yVdiLpY94n9A7rd6U8N
         EH2Kc1ywal9j+hTnXdiLSeFCso6yA5SGXtsVkmQ75ga9DWUQpdjtVFfg04JVmUjWIPZT
         CueHv1OWa/6EtO6JkMx+3HGIoajESMbMiaag0kmjEWHkXQ1/rD2MWBxHvX9ZuP0SFsIE
         mjJl4K45m5SMtk805SfgIRw/ypZThSWrIwWXfk+tZuk1JPz5TnrBX/4xCslYw38t5Mo3
         PBa/5eytWnhvCKNsHQVAsJYKPisRix/UDVdnOt1o5NCay+Bc9H1rtnNEk1PBn6N++/pN
         DZAw==
X-Gm-Message-State: AJIora8xN2IU7aEUiR+kCzMd9E0MRw9WXHYtI5A90QBVvxh1D7IxhK13
        Dh/KXkyD4L8i899T8GC0xMnsdBI4ugxIk10DL6k8Lvf5R1g=
X-Google-Smtp-Source: AGRyM1udHPpjymO7rEdK8y9ZWpx8x6v4eJzdZo2zstw221FW49Z12h1tYmUIDeA9l8BtFTF2Te7ELt2lAcZCzt/eShI=
X-Received: by 2002:a17:907:60cc:b0:722:e564:eb11 with SMTP id
 hv12-20020a17090760cc00b00722e564eb11mr4188422ejc.736.1657296037674; Fri, 08
 Jul 2022 09:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220704130602.12307-1-henning.schild@siemens.com> <20220704130602.12307-2-henning.schild@siemens.com>
In-Reply-To: <20220704130602.12307-2-henning.schild@siemens.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Jul 2022 18:00:27 +0200
Message-ID: <CAMRc=MeJ4LiYkCDScGBhnaDbxQsHQ8T9R2MwGOy6Ju=tkWdzXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: nct6116d: add new driver for several Nuvoton
 super io chips
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 3:06 PM Henning Schild
<henning.schild@siemens.com> wrote:
>
> This patch adds gpio support for several Nuvoton NCTXXX chips. These
> Super-I/O chips offer multiple functions of which several already have
> drivers in the kernel, i.e. hwmon and watchdog.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/gpio/Kconfig         |   9 +
>  drivers/gpio/Makefile        |   1 +
>  drivers/gpio/gpio-nct6116d.c | 412 +++++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/gpio/gpio-nct6116d.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b01961999ced..40f1494b1adc 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -457,6 +457,15 @@ config GPIO_MXS
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP
>
> +config GPIO_NCT6116D
> +       tristate "Nuvoton Super-I/O GPIO support"
> +       help
> +         This option enables support for GPIOs found on Nuvoton Super-I/O
> +         chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called gpio-nct6116d.
> +
>  config GPIO_OCTEON
>         tristate "Cavium OCTEON GPIO"
>         depends on CAVIUM_OCTEON_SOC
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 14352f6dfe8e..87f1b0a0cda2 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_GPIO_MT7621)           += gpio-mt7621.o
>  obj-$(CONFIG_GPIO_MVEBU)               += gpio-mvebu.o
>  obj-$(CONFIG_GPIO_MXC)                 += gpio-mxc.o
>  obj-$(CONFIG_GPIO_MXS)                 += gpio-mxs.o
> +obj-$(CONFIG_GPIO_NCT6116D)            += gpio-nct6116d.o
>  obj-$(CONFIG_GPIO_OCTEON)              += gpio-octeon.o
>  obj-$(CONFIG_GPIO_OMAP)                        += gpio-omap.o
>  obj-$(CONFIG_GPIO_PALMAS)              += gpio-palmas.o
> diff --git a/drivers/gpio/gpio-nct6116d.c b/drivers/gpio/gpio-nct6116d.c
> new file mode 100644
> index 000000000000..6c277636c773
> --- /dev/null
> +++ b/drivers/gpio/gpio-nct6116d.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPIO driver for Nuvoton Super-I/O chips NCT5104D, NCT6106D, NCT6116D, NCT6122D
> + *
> + * Authors:
> + *  Tasanakorn Phaipool <tasanakorn@gmail.com>
> + *  Sheng-Yuan Huang <syhuang3@nuvoton.com>
> + *  Kuan-Wei Ho <cwho@nuvoton.com>
> + *  Henning Schild <henning.schild@siemens.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * Super-I/O registers
> + */
> +#define SIO_LDSEL              0x07    /* Logical device select */
> +#define SIO_CHIPID             0x20    /* Chaip ID (2 bytes) */
> +#define SIO_GPIO_ENABLE                0x30    /* GPIO enable */
> +
> +#define SIO_LD_GPIO            0x07    /* GPIO logical device */
> +#define SIO_UNLOCK_KEY         0x87    /* Key to enable Super-I/O */
> +#define SIO_LOCK_KEY           0xAA    /* Key to disable Super-I/O */
> +
> +#define SIO_ID_MASK            GENMASK(15, 4)
> +#define SIO_NCT5104D_ID                0x1061
> +#define SIO_NCT6106D_ID                0xC452
> +#define SIO_NCT6116D_ID                0xD282
> +#define SIO_NCT6122D_ID                0xD2A3
> +
> +enum chips {
> +       nct5104d,
> +       nct6106d,
> +       nct6116d,
> +       nct6122d,
> +};
> +
> +static const char * const nct6116d_names[] = {
> +       [nct5104d] = "nct5104d",
> +       [nct6106d] = "nct6106d",
> +       [nct6116d] = "nct6116d",
> +       [nct6122d] = "nct6122d",
> +};
> +
> +struct nct6116d_sio {
> +       int addr;
> +       enum chips type;
> +};
> +
> +struct nct6116d_gpio_bank {
> +       struct gpio_chip chip;
> +       unsigned int regbase;
> +       struct nct6116d_gpio_data *data;
> +};
> +
> +struct nct6116d_gpio_data {
> +       struct nct6116d_sio *sio;
> +       int nr_bank;
> +       struct nct6116d_gpio_bank *bank;
> +};
> +
> +/*
> + * Super-I/O functions.
> + */
> +
> +static inline int superio_inb(int base, int reg)
> +{
> +       outb(reg, base);
> +       return inb(base + 1);
> +}
> +
> +static int superio_inw(int base, int reg)
> +{
> +       int val;
> +
> +       outb(reg++, base);
> +       val = inb(base + 1) << 8;
> +       outb(reg, base);
> +       val |= inb(base + 1);
> +
> +       return val;
> +}
> +
> +static inline void superio_outb(int base, int reg, int val)
> +{
> +       outb(reg, base);
> +       outb(val, base + 1);
> +}
> +
> +static inline int superio_enter(int base)
> +{
> +       /* Don't step on other drivers' I/O space by accident. */
> +       if (!request_muxed_region(base, 2, KBUILD_MODNAME)) {
> +               pr_err("I/O address 0x%04x already in use\n", base);
> +               return -EBUSY;
> +       }
> +
> +       /* According to the datasheet the key must be send twice. */
> +       outb(SIO_UNLOCK_KEY, base);
> +       outb(SIO_UNLOCK_KEY, base);
> +
> +       return 0;
> +}
> +
> +static inline void superio_select(int base, int ld)
> +{
> +       outb(SIO_LDSEL, base);
> +       outb(ld, base + 1);
> +}
> +
> +static inline void superio_exit(int base)
> +{
> +       outb(SIO_LOCK_KEY, base);
> +       release_region(base, 2);
> +}
> +
> +/*
> + * GPIO chip.
> + */
> +
> +#define gpio_dir(base) ((base) + 0)
> +#define gpio_data(base) ((base) + 1)
> +
> +static inline void *nct6116d_to_gpio_bank(struct gpio_chip *chip)
> +{
> +       return container_of(chip, struct nct6116d_gpio_bank, chip);
> +}
> +
> +static int nct6116d_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
> +       struct nct6116d_sio *sio = bank->data->sio;
> +       int err;
> +       u8 dir;
> +
> +       err = superio_enter(sio->addr);
> +       if (err)
> +               return err;
> +       superio_select(sio->addr, SIO_LD_GPIO);
> +
> +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +
> +       superio_exit(sio->addr);
> +
> +       if (dir & 1 << offset)
> +               return GPIO_LINE_DIRECTION_OUT;
> +
> +       return GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int nct6116d_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
> +       struct nct6116d_sio *sio = bank->data->sio;
> +       int err;
> +       u8 dir;
> +
> +       err = superio_enter(sio->addr);
> +       if (err)
> +               return err;
> +       superio_select(sio->addr, SIO_LD_GPIO);
> +
> +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +       dir |= BIT(offset);
> +       superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> +
> +       superio_exit(sio->addr);
> +
> +       return 0;
> +}
> +
> +static int nct6116d_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
> +       struct nct6116d_sio *sio = bank->data->sio;
> +       int err;
> +       u8 data;
> +
> +       err = superio_enter(sio->addr);
> +       if (err)
> +               return err;
> +       superio_select(sio->addr, SIO_LD_GPIO);
> +
> +       data = superio_inb(sio->addr, gpio_data(bank->regbase));
> +
> +       superio_exit(sio->addr);
> +
> +       return !!(data & BIT(offset));
> +}
> +
> +static int nct6116d_gpio_direction_out(struct gpio_chip *chip,
> +                                    unsigned int offset, int value)
> +{
> +       struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
> +       struct nct6116d_sio *sio = bank->data->sio;
> +       u8 dir, data_out;
> +       int err;
> +
> +       err = superio_enter(sio->addr);
> +       if (err)
> +               return err;
> +       superio_select(sio->addr, SIO_LD_GPIO);
> +
> +       data_out = superio_inb(sio->addr, gpio_data(bank->regbase));
> +       if (value)
> +               data_out |= BIT(offset);
> +       else
> +               data_out &= ~BIT(offset);
> +       superio_outb(sio->addr, gpio_data(bank->regbase), data_out);
> +
> +       dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
> +       dir &= ~BIT(offset);
> +       superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
> +
> +       superio_exit(sio->addr);
> +
> +       return 0;
> +}
> +
> +static void nct6116d_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +{
> +       struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
> +       struct nct6116d_sio *sio = bank->data->sio;
> +       u8 data_out;
> +       int err;
> +
> +       err = superio_enter(sio->addr);
> +       if (err)
> +               return;
> +       superio_select(sio->addr, SIO_LD_GPIO);
> +
> +       data_out = superio_inb(sio->addr, gpio_data(bank->regbase));
> +       if (value)
> +               data_out |= BIT(offset);
> +       else
> +               data_out &= ~BIT(offset);
> +       superio_outb(sio->addr, gpio_data(bank->regbase), data_out);
> +
> +       superio_exit(sio->addr);
> +}
> +
> +#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)                    \
> +       {                                                                       \
> +               .chip = {                                                       \
> +                       .label            = _label,                             \
> +                       .owner            = THIS_MODULE,                        \
> +                       .get_direction    = nct6116d_gpio_get_direction,        \
> +                       .direction_input  = nct6116d_gpio_direction_in,         \
> +                       .get              = nct6116d_gpio_get,                  \
> +                       .direction_output = nct6116d_gpio_direction_out,        \
> +                       .set              = nct6116d_gpio_set,                  \
> +                       .base             = _base,                              \
> +                       .ngpio            = _ngpio,                             \
> +                       .can_sleep        = false,                              \
> +               },                                                              \
> +               .regbase = _regbase,                                            \
> +       }
> +
> +static struct nct6116d_gpio_bank nct6116d_gpio_bank[] = {
> +       NCT6116D_GPIO_BANK(0, 8, 0xE0, KBUILD_MODNAME "-0"),
> +       NCT6116D_GPIO_BANK(10, 8, 0xE4, KBUILD_MODNAME "-1"),
> +       NCT6116D_GPIO_BANK(20, 8, 0xE8, KBUILD_MODNAME "-2"),
> +       NCT6116D_GPIO_BANK(30, 8, 0xEC, KBUILD_MODNAME "-3"),
> +       NCT6116D_GPIO_BANK(40, 8, 0xF0, KBUILD_MODNAME "-4"),
> +};
> +
> +/*
> + * Platform device and driver.
> + */
> +
> +static int nct6116d_gpio_probe(struct platform_device *pdev)
> +{
> +       struct nct6116d_sio *sio = pdev->dev.platform_data;
> +       struct nct6116d_gpio_data *data;
> +       int err;
> +       int i;
> +
> +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
> +       data->bank = nct6116d_gpio_bank;
> +       data->sio = sio;
> +
> +       platform_set_drvdata(pdev, data);
> +
> +       /* For each GPIO bank, register a GPIO chip. */
> +       for (i = 0; i < data->nr_bank; i++) {
> +               struct nct6116d_gpio_bank *bank = &data->bank[i];
> +
> +               bank->chip.parent = &pdev->dev;
> +               bank->data = data;
> +
> +               err = devm_gpiochip_add_data(&pdev->dev, &bank->chip, bank);
> +               if (err)
> +                       return dev_err_probe(&pdev->dev, err,
> +                               "Failed to register gpiochip %d\n", i);
> +       }
> +
> +       return 0;
> +}
> +
> +static int __init nct6116d_find(int addr, struct nct6116d_sio *sio)
> +{
> +       u16 devid;
> +       int err;
> +
> +       err = superio_enter(addr);
> +       if (err)
> +               return err;
> +
> +       devid = superio_inw(addr, SIO_CHIPID);
> +       superio_exit(addr);
> +       switch (devid & SIO_ID_MASK) {
> +       case SIO_NCT5104D_ID & SIO_ID_MASK:
> +               sio->type = nct5104d;
> +               break;
> +       case SIO_NCT6106D_ID & SIO_ID_MASK:
> +               sio->type = nct6106d;
> +               break;
> +       case SIO_NCT6116D_ID & SIO_ID_MASK:
> +               sio->type = nct6116d;
> +               break;
> +       case SIO_NCT6122D_ID & SIO_ID_MASK:
> +               sio->type = nct6122d;
> +               break;
> +       default:
> +               pr_info("Unsupported device 0x%04x\n", devid);
> +               return -ENODEV;
> +       }
> +       sio->addr = addr;
> +
> +       pr_info("Found %s at 0x%x chip id 0x%04x\n",
> +               nct6116d_names[sio->type], addr, devid);
> +       return 0;
> +}
> +
> +static struct platform_device *nct6116d_gpio_pdev;
> +
> +static int __init
> +nct6116d_gpio_device_add(const struct nct6116d_sio *sio)
> +{
> +       int err;
> +
> +       nct6116d_gpio_pdev = platform_device_alloc(KBUILD_MODNAME, -1);
> +       if (!nct6116d_gpio_pdev)
> +               return -ENOMEM;
> +
> +       err = platform_device_add_data(nct6116d_gpio_pdev, sio, sizeof(*sio));
> +       if (err) {
> +               pr_err("Platform data allocation failed\n");
> +               goto err;
> +       }
> +
> +       err = platform_device_add(nct6116d_gpio_pdev);
> +       if (err) {
> +               pr_err("Device addition failed\n");
> +               goto err;
> +       }
> +
> +       return 0;
> +
> +err:
> +       platform_device_put(nct6116d_gpio_pdev);
> +
> +       return err;
> +}
> +
> +static struct platform_driver nct6116d_gpio_driver = {
> +       .driver = {
> +               .name   = KBUILD_MODNAME,
> +       },
> +       .probe          = nct6116d_gpio_probe,
> +};
> +
> +static int __init nct6116d_gpio_init(void)
> +{
> +       struct nct6116d_sio sio;
> +       int err;
> +
> +       if (nct6116d_find(0x2e, &sio) &&
> +           nct6116d_find(0x4e, &sio))
> +               return -ENODEV;
> +
> +       err = platform_driver_register(&nct6116d_gpio_driver);
> +       if (!err) {
> +               err = nct6116d_gpio_device_add(&sio);
> +               if (err)
> +                       platform_driver_unregister(&nct6116d_gpio_driver);
> +       }
> +
> +       return err;
> +}
> +subsys_initcall(nct6116d_gpio_init);
> +

I need some explanation on this part. You load the module and it
creates and registers the platform device? This is not how it's done
in the kernel. It's a platform device so it shouldn't be dynamically
probed for in the module's init function. It should be defined in
device-tree or ACPI. What platform are you using it on? Manual
creation of platform devices is limited to a small set of special
cases.

Bart

> +static void __exit nct6116d_gpio_exit(void)
> +{
> +       platform_device_unregister(nct6116d_gpio_pdev);
> +       platform_driver_unregister(&nct6116d_gpio_driver);
> +}
> +module_exit(nct6116d_gpio_exit);
> +
> +MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips  NCT5104D, NCT6106D, NCT6116D, NCT6122D");
> +MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.35.1
>
