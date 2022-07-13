Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F5572F38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiGMH2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiGMH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:28:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54ECE3C1E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:28:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eq6so12980207edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwzETJKIQrlU+8+QLl9F0AGowG0zSA3uMJrcnyFEu/c=;
        b=ornLNe9OOfq6PnB/k5Z5tWvTBEd/cGXmE13J9IbhA1+7I9SLxu2WcQiRYvY8Y6fgGi
         lHvSm3XOxH4JV5MHPqHaPI6mFZ6SXXYC8e+ap9cyr0e8AtbYBt+uR8Gj9uhW9a3/99gZ
         M9YLWVml/J/d2Mnf1vyXW7SZu+YG4UTRCmCb3P9795f8BjGqC68ComatjWZRvZBXQpGq
         dsEa53pNz2Pj+bYpzUycIbAPPShd72qCRmZc6N5Gz1Y0aWnM2opW8xHbb8ahwp7pgUPZ
         h1DRxgZ5volkY3d2opjGX/Kdmj3FZL+z3SZCprwNNPXMk3OzjzEXOLCzf5kboMCysuLn
         plEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwzETJKIQrlU+8+QLl9F0AGowG0zSA3uMJrcnyFEu/c=;
        b=0Hhm9BJNNWSrEIuAtX+skJzB3mRsLen38Fw+iA89IgU0Jn7snjQjopqLtEniNz6TcU
         MX9DK1NqnprUGbe4WR1SDiJ7NMlCmQnyrZNMdrCiZU/e1PgjoXpTj7+xAN+ox03p2KFA
         ckxbN9ncIN3Q+oCdU8V01MUBCG1dNc08Zjacew4ZRUseV/wFRIW+ShlhEyxXer6SDXcl
         RwEQFxVHnyk5oGuJpMX7Hw7qsGykGDWiRs3IL+sg9+r7zqKSzIdHnW0lzkq6jTI2twfn
         eDVgi/H4MX5P8nLL5HXf2wg7DSJjIHRAHGVJKAxLubdTDG2Nx9499cq0Ys+ThoLrPygv
         9G4w==
X-Gm-Message-State: AJIora/vjs7yzaYInqta3uJeE+cdasqydRzyVwWOTBLdDGM+u2mcHWl3
        dm7WmxyZxAEgqhlWsRqx9azF/ad5y4s9nTcE0uzpyQ==
X-Google-Smtp-Source: AGRyM1sQw++6I/l2EhVW6jlBTxMvQTO3mfdwwI8tvG/HGB7ECkghVpYMQmg1p1shY2t/qsrgvuXSo7B6SPggglIdLvM=
X-Received: by 2002:a05:6402:27c8:b0:43a:f392:8fdd with SMTP id
 c8-20020a05640227c800b0043af3928fddmr2857035ede.328.1657697287109; Wed, 13
 Jul 2022 00:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220712143237.13992-1-henning.schild@siemens.com> <20220712143237.13992-2-henning.schild@siemens.com>
In-Reply-To: <20220712143237.13992-2-henning.schild@siemens.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Jul 2022 09:27:56 +0200
Message-ID: <CAMRc=Md7uVpwSweCSfrNJKqhQLYs2sVv9UasL59ZpqJ50fSC5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: nct6116d: add new driver for several Nuvoton
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

On Tue, Jul 12, 2022 at 4:32 PM Henning Schild
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
> index b01961999ced..1f1ec035f3c6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -899,6 +899,15 @@ config GPIO_IT87
>           To compile this driver as a module, choose M here: the module will
>           be called gpio_it87.
>
> +config GPIO_NCT6116D
> +       tristate "Nuvoton Super-I/O GPIO support"
> +       help
> +         This option enables support for GPIOs found on Nuvoton Super-I/O
> +         chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
> +
> +         To compile this driver as a module, choose M here: the module will
> +         be called gpio_nct6116d.
> +
>  config GPIO_SCH
>         tristate "Intel SCH/TunnelCreek/Centerton/Quark X1000 GPIO"
>         depends on (X86 || COMPILE_TEST) && ACPI
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
> index 000000000000..2ff92f3e11aa
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

I'm confused - have we not discussed removing this part?

Bart

> +
> +static void __exit nct6116d_gpio_exit(void)
> +{
> +       platform_device_unregister(nct6116d_gpio_pdev);
> +       platform_driver_unregister(&nct6116d_gpio_driver);
> +}
> +module_init(nct6116d_gpio_init);
> +module_exit(nct6116d_gpio_exit);
> +
> +MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips  NCT5104D, NCT6106D, NCT6116D, NCT6122D");
> +MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.35.1
>
