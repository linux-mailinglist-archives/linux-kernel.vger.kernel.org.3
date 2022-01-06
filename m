Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F4486462
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbiAFMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiAFMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:30:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74194C061245;
        Thu,  6 Jan 2022 04:30:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so8816225edq.6;
        Thu, 06 Jan 2022 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFGJZ+qYaX9WjgpaHo1bAO566jEroMdTTAgFJDWQLnc=;
        b=YFor2MAkOEENOE+DYRzv7K50sr/yzfmQ1perqYtU9y9a6762KGmzFB26MLtk9pag82
         JquwbhgQzmRn7tHJlevgLQ60AoLNs21xr8UPzJO13cjjZffPc/9rxC3AAHFnV8xNN9kt
         XakplBvSqykUYhvXd59g7Q49CTlsM5jL8vWMCL2JaLmfpETRGgt+i09XGt5KMvc2uSbg
         Z3TncrbOLtlqDBGeakutlzhvlq5hHX312x8nIW0GRQUd2Ggqp6i+qRWH5HH4u+lMlpa5
         ICWoZ1E85Q94kMnkBHn4h9aLszqf/uga6gUUskLihxzk+o2Hdachs2o0CtOEcjyUVxvt
         r7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFGJZ+qYaX9WjgpaHo1bAO566jEroMdTTAgFJDWQLnc=;
        b=CIaBixdavsto1jYz8/TMUdy3nmQi8M5jypel01k+1o+6EAZdsfNVauVU1SaMucCXwr
         eZ3PDWHV3X0xRIxiydzsSHvQzJonWchm+wu3Ewd39efXwuqv9LwRV1FIOxom/X7kqAw6
         HqI66z8b/enDs1FPQYvo9BdRkmOe5vEWKjC+EMl3ofoXI2MdOeFK/i6xrcpdAFmc3MmR
         LX7EELDL/HkLoiE7FkmZrevdGi/tMP7cTSxs42Ej7iLqkX+o5dAnKEE26czoQr1ztdMn
         zbYyHJf3TM6WHnCYgf3ApOncJ6CUflYVnvonVnXJTL96LJmSHKefPoLmssenH5M3fHr1
         OZuA==
X-Gm-Message-State: AOAM530DtknTn+056ObnPCTMmHK/XIO669teK6uyg9gn6XSY87jjTFWp
        NC+Pk42Zi6e+4lMJg8lBo2XGxwIJBDPUvE+kN10L9JRa8+4=
X-Google-Smtp-Source: ABdhPJwBbBJj7F7XUG5NXraQKqZ4jxenzMd7Wsy6mPKSpuTEWns8Lpea9/VmYMm0gwGhLZiVhCdJpHtzMld0zAHizkM=
X-Received: by 2002:a17:907:2a95:: with SMTP id fl21mr1515474ejc.639.1641472235342;
 Thu, 06 Jan 2022 04:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com> <20211217115708.882525-8-tanureal@opensource.cirrus.com>
In-Reply-To: <20211217115708.882525-8-tanureal@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 14:29:58 +0200
Message-ID: <CAHp75VdQGBixkUStPiq3VuoL+9TJo946ObfRA-L-D72DaFHnrw@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] hda: cs35l41: Add support for CS35L41 in HDA systems
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 5:45 PM Lucas Tanure
<tanureal@opensource.cirrus.com> wrote:
>
> Add support for CS35L41 using a new separated driver
> that can be used in all upcoming designs



> +config SND_HDA_SCODEC_CS35L41_I2C
> +       tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
> +       depends on ACPI
> +       select SND_HDA_GENERIC
> +       select SND_SOC_CS35L41_LIB
> +       select SND_HDA_SCODEC_CS35L41
> +       help
> +         Say Y or M here to include CS35L41 I2C HD-audio side codec support
> +         in snd-hda-intel driver, such as ALC287.
> +
> +comment "Set to Y if you want auto-loading the side codec driver"
> +       depends on SND_HDA=y && SND_HDA_SCODEC_CS35L41_I2C=m
> +
> +config SND_HDA_SCODEC_CS35L41_SPI
> +       tristate "Build CS35L41 HD-audio codec support for SPI Bus"
> +       depends on ACPI
> +       select SND_HDA_GENERIC
> +       select SND_SOC_CS35L41_LIB
> +       select SND_HDA_SCODEC_CS35L41
> +       help
> +         Say Y or M here to include CS35L41 SPI HD-audio side codec support
> +         in snd-hda-intel driver, such as ALC287.

...

> +// cs35l41.c -- CS35l41 ALSA HDA audio driver

It's an additional burden in case the file will be renamed. i..o.w.
drop the names of the files from the files.


> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <sound/hda_codec.h>
> +#include "hda_local.h"
> +#include "hda_auto_parser.h"
> +#include "hda_jack.h"
> +#include "hda_generic.h"
> +#include "hda_component.h"
> +#include "cs35l41_hda.h"

...

> +       { CS35L41_PWR_CTRL1,            0x00000001, 2000 }, //GLOBAL_EN = 1

Here and everywhere else, missed space after //

...

> +static void cs35l41_hda_playback_hook(struct device *dev, int action)
> +{
> +       struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
> +       const struct cs35l41_hda_reg_sequence *reg_seq = cs35l41->reg_seq;
> +       struct regmap *reg = cs35l41->regmap;
> +       int ret = 0;
> +
> +       switch (action) {
> +       case HDA_GEN_PCM_ACT_OPEN:
> +               if (reg_seq->open)
> +                       ret = regmap_multi_reg_write(reg, reg_seq->open, reg_seq->num_open);
> +               break;
> +       case HDA_GEN_PCM_ACT_PREPARE:
> +               if (reg_seq->prepare)
> +                       ret = regmap_multi_reg_write(reg, reg_seq->prepare, reg_seq->num_prepare);
> +               break;
> +       case HDA_GEN_PCM_ACT_CLEANUP:
> +               if (reg_seq->cleanup)
> +                       ret = regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
> +               break;
> +       case HDA_GEN_PCM_ACT_CLOSE:
> +               if (reg_seq->close)
> +                       ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
> +               break;

default case?

> +       }
> +
> +       if (ret)
> +               dev_warn(cs35l41->dev, "Failed to apply multi reg write: %d\n", ret);

> +

Redundant blank line.

> +}


...

> +       if (comps && cs35l41->index >= 0 && cs35l41->index < HDA_MAX_COMPONENTS)
> +               comps = &comps[cs35l41->index];
> +       else
> +               return -EINVAL;

Can you check first? In such a case you won't need the 'else' branch at all.

...

> +       if (!comps->dev) {

Why not a positive check and standard pattern as per above?


> +               comps->dev = dev;
> +               strscpy(comps->name, dev_name(dev), sizeof(comps->name));
> +               comps->playback_hook = cs35l41_hda_playback_hook;
> +               comps->set_channel_map = cs35l41_hda_channel_map;
> +               return 0;
> +       }
> +
> +       return -EBUSY;
> +}

...

> +       switch (hw_cfg->gpio1_func) {
> +       case CS35l41_VSPK_SWITCH:
> +               regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
> +                                  CS35L41_GPIO1_CTRL_MASK, 1 << CS35L41_GPIO1_CTRL_SHIFT);
> +               break;
> +       case CS35l41_SYNC:
> +               regmap_update_bits(cs35l41->regmap, CS35L41_GPIO_PAD_CONTROL,
> +                                  CS35L41_GPIO1_CTRL_MASK, 2 << CS35L41_GPIO1_CTRL_SHIFT);
> +               break;

default case?

Same for all switch-cases in your code.

> +       }

...

> +       ret = cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, (unsigned int *)&hw_cfg->spk_pos);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

return cs35l41_hda_...(...);

...

> +       property = "cirrus,dev-index";
> +       ret = device_property_count_u32(acpi_dev, property);

Please, name adev the pointer to ACPI device. Ah, what a mess, you
have named acpi_dev the pointer to the struct device. Please, find a
better name, like dev, or physdev or so.

> +       if (ret <= 0)

Shouldn't you override the error code for the 0 case?

> +               goto no_acpi_dsd;

...

> +       if (ret > ARRAY_SIZE(values)) {
> +               ret = -EINVAL;
> +               goto err;
> +       }

Is it really the issue? I would expect the issue when you have less
than expected, and not otherwise.

...

> +       /* No devm_ version as CLSA0100, in no_acpi_dsd case, can't use devm version */

Can you elaborate why devm can't be used?

> +       cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", cs35l41->index,

Please, do not dereference fwnode pointers.
Also, why can't you use the device instead of fwnode?

> +                                                    GPIOD_OUT_LOW, "cs35l41-reset");

...

> +       hw_cfg = kzalloc(sizeof(*hw_cfg), GFP_KERNEL);

Why not devm?

> +       if (!hw_cfg) {
> +               ret = -ENOMEM;
> +               goto err;
> +       }

...

> +       property = "cirrus,speaker-position";
> +       ret = device_property_read_u32_array(acpi_dev, property, values, nval);
> +       if (ret)
> +               goto err_free;
> +       hw_cfg->spk_pos = values[cs35l41->index];

This and further is weird. Why do you need to retrieve all values for
just one? Use indexed APIs for that. If there are none, create them.

...

> +no_acpi_dsd:
> +       /*
> +        * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.

So, you need to add mapping tables and switch to regular APIs, tell
me, why it won't work.

> +        * And devices created by i2c-multi-instantiate don't have their device struct pointing to
> +        * the correct fwnode, so acpi_dev must be used here
> +        * And devm functions expect that the device requesting the resource has the correct
> +        * fwnode

You missed grammar periods and what else? Please, update your comments
to use proper English grammar.

> +        */
> +       if (strncmp(hid, "CLSA0100", 8) != 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* check I2C address to assign the index */
> +       cs35l41->index = id == 0x40 ? 0 : 1;
> +       cs35l41->reset_gpio = gpiod_get_index(acpi_dev, NULL, 0, GPIOD_OUT_HIGH);
> +       cs35l41->vspk_always_on = true;
> +       put_device(acpi_dev);
> +
> +       return NULL;
> +}

...

> +int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
> +                     struct regmap *regmap)

> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);

Why?

...

> +       if (IS_ERR(cs35l41->reset_gpio)) {

You should use _optinal variants instead,

> +               ret = PTR_ERR(cs35l41->reset_gpio);
> +               cs35l41->reset_gpio = NULL;
> +               if (ret == -EBUSY) {
> +                       dev_info(cs35l41->dev, "Reset line busy, assuming shared reset\n");
> +               } else {
> +                       if (ret != -EPROBE_DEFER)
> +                               dev_err(cs35l41->dev, "Failed to get reset GPIO: %d\n", ret);
> +                       goto err;

We have dev_err_probe() for a few releases already.

> +               }
> +       }

...

> +       ret = regmap_read(cs35l41->regmap, CS35L41_IRQ1_STATUS3, &int_sts);
> +       if (ret || (int_sts & CS35L41_OTP_BOOT_ERR)) {
> +               dev_err(cs35l41->dev, "OTP Boot error\n");
> +               ret = -EIO;

Why shadowing error code?
Why not use dev_err_probe()?

> +               goto err;
> +       }

...

> +EXPORT_SYMBOL_GPL(cs35l41_hda_probe);

Please, use the namespace variant and avoid polluting the global
namespace with  your symbols.

...

> + * cs35l41_hda.h -- CS35L41 ALSA HDA audio driver

No file names in the files.

...

> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/device.h>
> +#include <sound/cs35l41.h>

Please revisit this. You need to add here only the headers that you
are a direct user of (or in some cases their top level ones, like
types.h for compiler_attributes.h).

...

> +#ifdef CONFIG_ACPI

Drop this ugliness.

> +static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
> +       {"CLSA0100", 0 },
> +       {"CSC3551", 0 },

I believe these IDs are officially allocated by the Cirrus Logic, right?

> +       { },

No comma for terminator line here and everywhere else where it's the case.

> +};
> +MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_hda_match);
> +#endif
> +
> +static struct i2c_driver cs35l41_i2c_driver = {
> +       .driver = {
> +               .name           = "cs35l41-hda",
> +               .acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),

ACPI_PTR() as well.

> +       },
> +       .id_table       = cs35l41_hda_i2c_id,
> +       .probe          = cs35l41_hda_i2c_probe,
> +       .remove         = cs35l41_hda_i2c_remove,
> +};

> +

No need to have a blank line here.

> +module_i2c_driver(cs35l41_i2c_driver);

I stopped here, so this code needs more work and can't be applied like this.

I believe that current Cirrus Logic drivers are written in the same
(semi-) bad style and have to be fixed in the future. Put this to your
TODO list, please.

-- 
With Best Regards,
Andy Shevchenko
