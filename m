Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E7564A22
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiGCV5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGCV45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:56:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528726F3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:56:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n185so4363019wmn.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnLNcWKNYblu0OnxQiln0hOQP2zX/SMuxR4VzazEJx0=;
        b=dTLKDKOKkr6ygHuffm6Ni+B4zrkBUnExmqkzN+tNrhmr8RjMl+nsKMZt46ZwNNH7aS
         OFshMKR6X5w7ERNzztgJLYNiwEBLDQy9elLLyxBzKkG1fCxRUgEBCYC4JXMwJM1b2tTE
         Kn6rKWQUhEtSu+Fk4cSFQOaSxCfTclAsnD0PuAsUXMvBp0Qvum8zLTiiJNoskS4UdX3K
         NUWyDCAwCf01xD4LVMLe8FS73UNmm0zlzkjWS3yeH3uTZHi3JSQh4AU6IwNsHIxfCugg
         oM1RjvOmpflwZP+CZvYMyvAwgUlSgHmgc6ARBlKs6IoHa3/DW4g7T/rgXNT76q0/fvwF
         hIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnLNcWKNYblu0OnxQiln0hOQP2zX/SMuxR4VzazEJx0=;
        b=EkHQghkwRIi5guCsx5xuPlP+InWOd0sUWVwf9BcmlPKWLNYlE1VQNugpHh/OvsaImI
         VapDl7mI9scNmeLA2hwpy0fe0mUbKNRGbAvDJSK4Q6WfcCJxHTw1jWF2mEFgAgAWpaxs
         XsGwddY6tOZksaWXqQEvc05YEXWZTBM7RUA7WTjpJma5NvQFjU99faXe1z9/hqBaoGvP
         M5NreUuameU9BAzK6kAadwCYWCTLOkyiwMXBkhC4TQa1wjJa59GcyX9p7StTrvAQjyU8
         72XVLj0yIHfxuq+kPRk5cKLutuWz5zOYIAf5GMU8sfNI3qvq/xHvSHLqNV0qdNGXMOAd
         jO0A==
X-Gm-Message-State: AJIora+ak+CInttWITemu9wyZmjvxnG9SG2HMx5evXj1eEqRg7BrcRQi
        5H5aKVsdPVWt8wezeOkDOyaIhqA7B/oZawnWAGDrpg==
X-Google-Smtp-Source: AGRyM1sPTmuBec6ys1CNE7pzCd9eS2h05V7JWbkQNKYOkGbhWlIRi92o4/Kfvwy6FdMgpvpULh5vYfV7v5p4lsVu0cI=
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id
 h5-20020a05600c350500b003a19fbb4d59mr4240397wmq.165.1656885414782; Sun, 03
 Jul 2022 14:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-15-brad@pensando.io>
 <CAHp75VeRN+mChDibXqrQjOQqiSz_-inebRqcPQMmAvN_zBTFBg@mail.gmail.com>
In-Reply-To: <CAHp75VeRN+mChDibXqrQjOQqiSz_-inebRqcPQMmAvN_zBTFBg@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 14:56:43 -0700
Message-ID: <CAK9rFnyQnNFfpsCWz3u=vYgmJ+Yi4EWp0z2Q43c_2509JNTgzQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] mfd: pensando-elbasr: Add AMD Pensando Elba
 System Resource chip
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jun 14, 2022 at 4:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
> ...
>
> > +#include <linux/mfd/pensando-elbasr.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/ioctl.h>
> > +#include <linux/fs.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/list.h>
> > +#include <linux/errno.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> > +#include <linux/compat.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/spi/spidev.h>
> > +#include <linux/delay.h>
>
> Keep it sorted?
> It would easily tell that types.h is missed, but maybe other headers
> are superfluous.

Sorted and added types.h

> ...
>
> > +/* The main reason to have this class is to make mdev/udev create the
> > + * /dev/pensrB.C character device nodes exposing our userspace API.
> > + * It also simplifies memory management.  The device nodes
> > + * /dev/pensrB.C are common across Pensando boards.
> > + */
>
> /*
>  * The above style of multi-line
>  * comments is for networking,
>  * the rest uses a slightly different one.
>  */

Changed to non-networking multi-line comments, code reuse from
driver/spi/spidev.c there since ~2007.

> ...
>
> > +static DECLARE_BITMAP(minors, ELBASR_MAX_DEVS);
> > +static unsigned int bufsiz = 4096;
> > +
> > +static LIST_HEAD(device_list);
> > +static DEFINE_MUTEX(device_list_lock);
>
> Is it all to reinvent IDA?

I don't know what IDA is, searching linux IDA yields debugger and some
image viewer.
The whole purpose of adding this driver was to not use spidev.c to
provide Elba specific
access to 4 functions in the fpga and also an emmc reset driver.  The
reuse of code from
spidev.c was to avoid breaking production deployments while adding emmc hardware
reset support as a priority.  I'll strip out any code not used for
Elba deployments for next
version.

> ...
>
> > +static ssize_t
> > +elbasr_spi_sync(struct elbasr_data *elbasr_spi, struct spi_message *message)
> > +{
> > +       int status;
> > +       struct spi_device *spi;
> > +
> > +       spin_lock_irq(&elbasr_spi->spi_lock);
> > +       spi = elbasr_spi->spi;
> > +       spin_unlock_irq(&elbasr_spi->spi_lock);
>
> > +
>
> Drop this blank line and see below.

Removed

> > +       if (spi == NULL)
> > +               status = -ESHUTDOWN;
>
> if (!spi)
>   return ...
>
> > +       else
>
> > +               status = spi_sync(spi, message);
> > +
> > +       if (status == 0)
> > +               status = message->actual_length;
> > +
> > +       return status;
>
> status = spi_sync(...);
> if (status)
>   return status;
>
> return message->actual_length;

Refactored to:
        if (!spi)
                return -ESHUTDOWN;

        status = spi_sync(spi, message);
        if (status)
                return status;

        return message->actual_length;

> ...
> > +       if (status) {
>
> > +               pr_debug("elbasr_spi: nothing for minor %d\n", iminor(inode));

> We have a device pointer, don't we?

Removed

> ...
>
> > +static const struct file_operations elbasr_spi_fops = {
> > +       .owner =        THIS_MODULE,
> > +       .write =        elbasr_spi_write,
> > +       .read =         elbasr_spi_read,
> > +       .unlocked_ioctl = elbasr_spi_ioctl,
> > +       .compat_ioctl = elbasr_spi_compat_ioctl,
> > +       .open =         elbasr_spi_open,
> > +       .release =      elbasr_spi_release,
> > +       .llseek =       no_llseek,
> > +};
>
>
> As far as I can see the code looks like a proxy for SPI via SPI. Is
> that the correct interpretation? If so, why this code repeating _a
> lot_ from SPI framework, including character device IOCTL? This is a
> big question here and since there is missed documentation for ABI and
> no points to userspace tools which are going to use this ABI (red
> flag!) the code is no go.

The patch v5-0006-dt-bindings-mfd-amd-pensando-elbasr-Add-AMD-Pensa.patch
has the documentation where below is the commit message.  This is a required
companion device to the Elba SoC (on spi0) which is a FPGA with four
functions.
One function that isn't filled out (driver not included in base SoC
support) is accessed
at /dev/pensr0.2 which is a Lattice dual I2C master for the
transceiver management.
There are customer utilities and programs that open /dev/pensr0.x in operation.

  dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System
Resource chip

  Add support for the AMD Pensando Elba SoC System Resource chip
  using the SPI interface.  The Elba SR is a Multi-function Device
  supporting device register access using CS0, smbus interface for
  FRU and board peripherals using CS1, dual Lattice I2C masters for
  transceiver management using CS2, and CS3 for flash access.


> ...
>
> > +static bool
> > +elbasr_reg_readable(struct device *dev, unsigned int reg)
>
> It's pretty much one line, can you reduce the number of LoCs by
> reindenting your code a bit?

Moved to one line, here and others

> ...
>
> > +static bool
> > +elbasr_reg_writeable(struct device *dev, unsigned int reg)
>
> Ditto and so on.
>
> ...
>
> > +       struct spi_transfer t[2] = { { 0 } };
>
> Isn't  `{ }` enough?

Yes, changed

> ...
>
> > +       spi_message_add_tail(&t[0], &m);
> > +       spi_message_add_tail(&t[1], &m);
>
> spi_message_init_with_transfers() ?
> Here and elsewhere.

Changed to use of spi_message_init_with_transfers()

> ...
>
> > +       struct spi_transfer t[1] = { { 0 } };
>
> Why does `struct spi_transfer t = { };` not work?!

It does, changed

> ...
>
> > +static const struct regmap_config pensando_elbasr_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .cache_type = REGCACHE_NONE,
> > +       .readable_reg = elbasr_reg_readable,
> > +       .writeable_reg = elbasr_reg_writeable,
> > +       .reg_read = elbasr_regs_read,
> > +       .reg_write = elbasr_regs_write,
> > +       .max_register = ELBASR_MAX_REG
>
> Leave a comma here.

Added a comma after ELBASR_MAX_REG

> > +};
>
> ...
>
> > +       elbasr->elbasr_regs = devm_regmap_init(&spi->dev, NULL, spi,
> > +                                              &pensando_elbasr_regmap_config);
> > +       if (IS_ERR(elbasr->elbasr_regs)) {
> > +               ret = PTR_ERR(elbasr->elbasr_regs);
> > +               dev_err(&spi->dev, "Failed to allocate register map: %d\n", ret);
> > +               return ret;
>
> return dev_err_probe(...);

Changed to dev_err_probe(...)

> > +       }
> > +
> > +       ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
> > +                                  pensando_elbasr_subdev_info,
> > +                                  ARRAY_SIZE(pensando_elbasr_subdev_info),
> > +                                  NULL, 0, NULL);
> > +       if (ret)
> > +               dev_err(&spi->dev, "Failed to register sub-devices: %d\n", ret);
> > +
> > +       return ret;
>
> Ditto.

Changed to dev_err_probe(...)

> ...
>
> > +       /* Add Elba reset driver sub-device */
> > +       if (spi->chip_select == 0)
> > +               elbasr_regs_setup(spi, elbasr);
>
> You have an awful mixture of devm_ vs. non-devm_ calls. Either move
> from devm_ completely, or switch to devm_ in the rest of the ->probe()
> code.

Moved away from devm_

> ...
>
> > +static const struct of_device_id elbasr_spi_of_match[] = {
> > +       { .compatible = "amd,pensando-elbasr" },
> > +       { /* sentinel */ },
>
> Comma is not needed in terminator entry.

Removed comma

> ...
>
> > +static struct spi_driver elbasr_spi_driver = {
> > +       .probe = elbasr_spi_probe,
> > +       .driver = {
> > +               .name = "elbasr",
>
> > +               .of_match_table = of_match_ptr(elbasr_spi_of_match),
>
> of_match_ptr() is useless here (look at your Kconfig) and in some
> cases is harmful. No need to use this.

Removed use of of_match_ptr()

> > +       },
> > +};
>
> ...
>
> > +#include <linux/cdev.h>
> > +#include <linux/regmap.h>
>
> mutex.h and types.h are missed, for example.
> You need to use headers for direct use of. And in some cases forward
> declarations can be used instead of including a header.

Added missed mutex.h and types.h

Regards,
Brad
