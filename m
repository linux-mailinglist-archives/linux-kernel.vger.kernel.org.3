Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E8754AF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiFNLnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiFNLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:42:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09AE2408B;
        Tue, 14 Jun 2022 04:42:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so16567505ejj.10;
        Tue, 14 Jun 2022 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dU+JDVuYQhC4RcxMSKR+d7k1wNEwhuhpZjWo6/Bjm0=;
        b=kaPRDdiiu02eYptvmv/2KYMGBTmPlgjSmJzrOzASsStgGSELwZVIk1N7c50a1lTZvZ
         QEz4CC4IV9HeY3ZOnI+QdIUSrU8lifD1zuwSKO33aL2DleK7YGObvB7HExWUjhcZdXIm
         tBmoa4mllq0VgsF6U/ufqwuB3hiKTzOdJpOEhmCXmYmU85JO+/nEeok1YPDG4k1WjkhY
         lVcaNi0mFZfuLMID3OyJpjOu/nDv25AiUH/rEi2Jt5DnZXY4Qe4HLYLUzz60bEzFnu7L
         OX2CldUsYREEuNCdgatP+r4ATRW4Mr5mYebhvLEj67kMdQeyya3QnDbHLobuROUpQM7O
         +7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dU+JDVuYQhC4RcxMSKR+d7k1wNEwhuhpZjWo6/Bjm0=;
        b=qpNW4abgNv5QylInWUpHvqQb3WqHsK9rIJf7qYYd/9PDszhJ+aiPltplai2kHxBGdd
         ElzTtVi5fidLZ4Ha8lv2Rzozylvu60xcVq0qW6ASdjDBjXzdHbGMHGBNbbihIAxJ7f0v
         HGiEkUjIjf//6d4Jn2I9hSBDeV54fbghdwrYBWzVdBtGaA2qa7fqnQeNtbQV5BriWLmz
         zNb5GMyjdM720yRYetAee6mU9nZhM6bVjhzLAIwIhJfWenON13puTGvPGdB870mZ44Ex
         QLsnIG23CmETQTPWIlT9XymFoQwwzGM29zezwxee3R4bVXXjZK9b5Mc+7mwquLE3QMiw
         2YAQ==
X-Gm-Message-State: AOAM5316oesaZcON4gQctYZKNikkX/uw565syruwVnPMOEgBeX0jQc10
        r/2MMrU/I5tZa3w6xj6xDzx1g24kWM1nzh04lG4=
X-Google-Smtp-Source: ABdhPJzKXIEBf6sI/Sh/s4ds5CGVfp9pfOtYw05rND6fwMudx7+GizMRGz4kgYksQcy6NGmwfg1mSoJnTeq75dOV3kk=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr3955821ejh.497.1655206977367; Tue, 14 Jun
 2022 04:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-15-brad@pensando.io>
In-Reply-To: <20220613195658.5607-15-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 13:42:20 +0200
Message-ID: <CAHp75VeRN+mChDibXqrQjOQqiSz_-inebRqcPQMmAvN_zBTFBg@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] mfd: pensando-elbasr: Add AMD Pensando Elba
 System Resource chip
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, piotrs@cadence.com,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
>
> From: Brad Larson <blarson@amd.com>
>
> Add support for the AMD Pensando Elba SoC System Resource chip
> using the SPI interface.  The Elba SR is a Multi-function Device
> supporting device register access using CS0, smbus interface for
> FRU and board peripherals using CS1, dual Lattice I2C masters for
> transceiver management using CS2, and CS3 for flash access.

...

> +#include <linux/mfd/pensando-elbasr.h>
> +#include <linux/mfd/core.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/ioctl.h>
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/list.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/compat.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spidev.h>
> +#include <linux/delay.h>

Keep it sorted?
It would easily tell that types.h is missed, but maybe other headers
are superfluous.

...

> +/* The main reason to have this class is to make mdev/udev create the
> + * /dev/pensrB.C character device nodes exposing our userspace API.
> + * It also simplifies memory management.  The device nodes
> + * /dev/pensrB.C are common across Pensando boards.
> + */

/*
 * The above style of multi-line
 * comments is for networking,
 * the rest uses a slightly different one.
 */

...

> +static DECLARE_BITMAP(minors, ELBASR_MAX_DEVS);
> +static unsigned int bufsiz = 4096;
> +
> +static LIST_HEAD(device_list);
> +static DEFINE_MUTEX(device_list_lock);

Is it all to reinvent IDA?

...

> +static ssize_t
> +elbasr_spi_sync(struct elbasr_data *elbasr_spi, struct spi_message *message)
> +{
> +       int status;
> +       struct spi_device *spi;
> +
> +       spin_lock_irq(&elbasr_spi->spi_lock);
> +       spi = elbasr_spi->spi;
> +       spin_unlock_irq(&elbasr_spi->spi_lock);

> +

Drop this blank line and see below.

> +       if (spi == NULL)
> +               status = -ESHUTDOWN;

if (!spi)
  return ...

> +       else

> +               status = spi_sync(spi, message);
> +
> +       if (status == 0)
> +               status = message->actual_length;
> +
> +       return status;

status = spi_sync(...);
if (status)
  return status;

return message->actual_length;

> +}

...

> +       if (status) {

> +               pr_debug("elbasr_spi: nothing for minor %d\n", iminor(inode));

We have a device pointer, don't we?

> +               goto err_find_dev;
> +       }

...

> +static const struct file_operations elbasr_spi_fops = {
> +       .owner =        THIS_MODULE,
> +       .write =        elbasr_spi_write,
> +       .read =         elbasr_spi_read,
> +       .unlocked_ioctl = elbasr_spi_ioctl,
> +       .compat_ioctl = elbasr_spi_compat_ioctl,
> +       .open =         elbasr_spi_open,
> +       .release =      elbasr_spi_release,
> +       .llseek =       no_llseek,
> +};


As far as I can see the code looks like a proxy for SPI via SPI. Is
that the correct interpretation? If so, why this code repeating _a
lot_ from SPI framework, including character device IOCTL? This is a
big question here and since there is missed documentation for ABI and
no points to userspace tools which are going to use this ABI (red
flag!) the code is no go.

...

> +static bool
> +elbasr_reg_readable(struct device *dev, unsigned int reg)

It's pretty much one line, can you reduce the number of LoCs by
reindenting your code a bit?

...

> +static bool
> +elbasr_reg_writeable(struct device *dev, unsigned int reg)

Ditto and so on.

...

> +       struct spi_transfer t[2] = { { 0 } };

Isn't  `{ }` enough?

...

> +       spi_message_add_tail(&t[0], &m);
> +       spi_message_add_tail(&t[1], &m);

spi_message_init_with_transfers() ?
Here and elsewhere.

...

> +       struct spi_transfer t[1] = { { 0 } };

Why does `struct spi_transfer t = { };` not work?!

...

> +static const struct regmap_config pensando_elbasr_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .cache_type = REGCACHE_NONE,
> +       .readable_reg = elbasr_reg_readable,
> +       .writeable_reg = elbasr_reg_writeable,
> +       .reg_read = elbasr_regs_read,
> +       .reg_write = elbasr_regs_write,
> +       .max_register = ELBASR_MAX_REG

Leave a comma here.

> +};

...

> +       elbasr->elbasr_regs = devm_regmap_init(&spi->dev, NULL, spi,
> +                                              &pensando_elbasr_regmap_config);
> +       if (IS_ERR(elbasr->elbasr_regs)) {
> +               ret = PTR_ERR(elbasr->elbasr_regs);
> +               dev_err(&spi->dev, "Failed to allocate register map: %d\n", ret);
> +               return ret;

return dev_err_probe(...);

> +       }
> +
> +       ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
> +                                  pensando_elbasr_subdev_info,
> +                                  ARRAY_SIZE(pensando_elbasr_subdev_info),
> +                                  NULL, 0, NULL);
> +       if (ret)
> +               dev_err(&spi->dev, "Failed to register sub-devices: %d\n", ret);
> +
> +       return ret;

Ditto.

...

> +       /* Add Elba reset driver sub-device */
> +       if (spi->chip_select == 0)
> +               elbasr_regs_setup(spi, elbasr);

You have an awful mixture of devm_ vs. non-devm_ calls. Either move
from devm_ completely, or switch to devm_ in the rest of the ->probe()
code.

...

> +static const struct of_device_id elbasr_spi_of_match[] = {
> +       { .compatible = "amd,pensando-elbasr" },
> +       { /* sentinel */ },

Comma is not needed in terminator entry.

> +};

...

> +static struct spi_driver elbasr_spi_driver = {
> +       .probe = elbasr_spi_probe,
> +       .driver = {
> +               .name = "elbasr",

> +               .of_match_table = of_match_ptr(elbasr_spi_of_match),

of_match_ptr() is useless here (look at your Kconfig) and in some
cases is harmful. No need to use this.

> +       },
> +};

...

> +#include <linux/cdev.h>
> +#include <linux/regmap.h>

mutex.h and types.h are missed, for example.
You need to use headers for direct use of. And in some cases forward
declarations can be used instead of including a header.

--
With Best Regards,
Andy Shevchenko
